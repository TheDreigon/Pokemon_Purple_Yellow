; wUnusedD726 = wDVCalcVar1
; wUnusedD722 = wDVCalcVar2
; hFlags_0xFFF6 = hUILayoutFlags
; hTilesetType = hTileAnimations

DrawHP:
; Draws the HP bar in the stats screen
	call GetPredefRegisters
	ld a, $1
	jr DrawHP_

DrawHP2:
; Draws the HP bar in the party screen
	call GetPredefRegisters
	ld a, $2

DrawHP_:
	ld [wHPBarType], a
	push hl
	ld a, [wLoadedMonHP]
	ld b, a
	ld a, [wLoadedMonHP + 1]
	ld c, a
	or b
	jr nz, .nonzeroHP
	xor a
	ld c, a
	ld e, a
	ld a, $6
	ld d, a
	jp .drawHPBarAndPrintFraction
.nonzeroHP
	ld a, [wLoadedMonMaxHP]
	ld d, a
	ld a, [wLoadedMonMaxHP + 1]
	ld e, a
	predef HPBarLength
	ld a, $6
	ld d, a
	ld c, a
.drawHPBarAndPrintFraction
	pop hl
	push de
	push hl
	push hl
	call DrawHPBar
	pop hl
	ld a, [hUILayoutFlags]
	bit 0, a
	jr z, .printFractionBelowBar
	ld bc, $9 ; right of bar
	jr .printFraction
.printFractionBelowBar
	ld bc, SCREEN_WIDTH + 1 ; below bar
.printFraction
	add hl, bc
	ld de, wLoadedMonHP
	lb bc, 2, 3
	call PrintNumber
	ld a, "/"
	ld [hli], a
	ld de, wLoadedMonMaxHP
	lb bc, 2, 3
	call PrintNumber
	pop hl
	pop de
	ret


; Predef 0x36
StatusScreen:
	call StatusScreen_NormalizeMode
	call LoadMonData
	ld a, [wMonDataLocation]
	cp BOX_DATA
	jr c, .DontRecalculate
; mon is in a box or daycare
	ld a, [wLoadedMonBoxLevel]
	ld [wLoadedMonLevel], a
	ld [wCurEnemyLVL], a
	ld hl, wLoadedMonHPExp - 1
	ld de, wLoadedMonStats
	ld b, $1
	call CalcStats ; Recalculate stats
.DontRecalculate
	ld hl, wd72c
	set 1, [hl]
	ld a, $33
	ld [rNR50], a ; Reduce the volume
; v0.7: the tile animations go off HERE, before anything below waits a frame.
;
; They used to be switched off eleven lines further down, after ClearScreen
; (which ends in Delay3) and after five more frame-waiting VRAM copies. Around
; eleven VBlanks ran in that window, and VBlank's UpdateMovingBgTiles writes
; the overworld's animated tiles straight into VRAM: the water tile is
; vTileset tile $14 and the flower tile is vTileset tile $03. vTileset and
; vFrontPic are the SAME $9000 - they are two members of the VRAM union - so
; those two writes land on tiles $03 and $14 of the Pokemon picture.
;
; Vanilla never sees it, twice over: it whites the screen out first, and it
; always reloads the picture afterwards, which paints over the damage. Our
; STATUS_QUIET removed the white-out and STATUS_KEEPPIC removed the reload, so
; on the way back from the move page the two scribbled tiles simply stayed -
; a flower in the blank column beside PIKACHU and a one-pixel roll of the tile
; under its foot. Measured on the CPU, not deduced: tile $14 went dirty
; between the first and second CopyVideoDataDouble, tile $03 between the
; second and third.
;
; StatusScreen2 has always done it in this order (see the top of it); page 1
; now matches. Costs nothing - the same four instructions, moved.
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
; v0.7: STATUS_QUIET composes this page behind the one already on screen rather
; than blanking the screen first. Every route back to the stats page is a full
; redraw (page 2 draws over page 1 and reads what page 1 loads, so it can never
; be shown on its own), and white-out / redraw / fade-in reads as "the screen
; reopened" - wrong, when the player only changed page or stepped a mon.
; v0.7: the tile pattern loads moved ONTO the white-out branch, and a quiet
; redraw now skips them. Reordered, not added: this block is the same 60 bytes
; it was, which matters because all three sections of bank $4 are pinned in
; layout.link and it had six bytes left.
;
; Why they cannot run on a quiet redraw: they write the SAME VRAM TWICE.
; HpBarAndStatusGraphics is 30 tiles at vChars2 tile $62 = $9620-$97ff, and all
; three CopyVideoDataDouble destinations below - $96d0, $9760, $9780 - land
; inside it. Vanilla does exactly the same and gets away with it because the
; screen is white while it happens.
;
; Ours is not white. STATUS_QUIET leaves the previous page up, and the move
; page draws its box out of those very tiles. Each CopyVideoData waits for a
; VBlank, so for about six frames the move page sat on screen with pieces of
; the HP bar where its border should be - the flicker Forte caught coming back
; from the moves. Measured, not reasoned: tiles $96d0, $9760, $9770 and $9780
; differed from the settled page for frames +4 to +10 of the flip, while the
; tile map did not change at all in that window.
;
; Skipping is safe for the same reason STATUS_KEEPPIC is: QUIET is only ever
; set when a status page is ALREADY on screen (start_sub_menus.asm is the only
; writer of the byte), and a status page can only be up because a non-quiet
; entry loaded these. Page 2 loads no tile patterns of its own at all. The flip
; also comes out four VBlank waits shorter.
	ld a, [wStatusScreenPageChange]
	and STATUS_QUIET
	jr nz, .quietRedraw
	call GBPalWhiteOutWithDelay3
	call LoadHpBarAndStatusTilePatterns
	ld de, BattleHudTiles1  ; source
	ld hl, vChars2 + $6d0 ; dest
	lb bc, BANK(BattleHudTiles1), $03
	call CopyVideoDataDouble ; ·│ :L and halfarrow line end
	ld de, BattleHudTiles2
	ld hl, vChars2 + $780
	lb bc, BANK(BattleHudTiles2), $01
	call CopyVideoDataDouble ; │
	ld de, BattleHudTiles3
	ld hl, vChars2 + $760
	lb bc, BANK(BattleHudTiles3), $02
	call CopyVideoDataDouble ; ─┘
	jr .screenBlanked
.quietRedraw
; STATUS_QUIET composes this page behind the one already on screen rather than
; blanking first. Every route back to the stats page is a full redraw (page 2
; draws over page 1 and reads what page 1 loads, so it can never be shown on
; its own), and white-out / redraw / fade-in reads as "the screen reopened" -
; wrong, when the player only changed page or stepped a mon.
	xor a
	ldh [hAutoBGTransferEnabled], a ; nothing drawn below reaches VRAM yet
.screenBlanked
	call ClearScreen
	call UpdateSprites
	coord hl, 19, 1
	lb bc, 6, 10
	call DrawLineBox ; Draws the box around name, HP and status
	ld de, -6
	add hl, de
	ld [hl], "<DOT>"
	dec hl
	ld [hl], "№"
	coord hl, 19, 9
	lb bc, 8, 6
	call DrawLineBox ; Draws the box around types, ID No. and OT
	coord hl, 10, 9
	ld de, Type1Text
	call PlaceString ; "TYPE1/"
	coord hl, 11, 3
	predef DrawHP

	;joenote - print stat exp if select is held
	;parse dv stats here so they can be grabbed later
	push de
	ld bc, SCREEN_WIDTH + 1
	add hl, bc
	call DVParse
	call Joypad
	
	ld a, [hJoyHeld]
	and SELECT | START
	jr z, .noblank
	push hl
	ld a, " "
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	pop hl
.noblank
	
	ld a, [hJoyHeld]
	bit BIT_SELECT, a
	jr z, .checkstart
	ld de, wLoadedMonHPExp
	lb bc, 2, 5
	jr .printnum
.checkstart	;print DVs if start is held
	bit BIT_START, a
	jr z, .doregular
	ld de, wDVCalcVar2 + 4
	lb bc, 1, 2
.printnum
	call PrintNumber
.doregular
	pop de
	ld hl, wStatusScreenHPBarColor
	call GetHealthBarColor ; only computes a byte; the palette itself is set
	                       ; down at .pictureDone, see the note there
	coord hl, 16, 6
	ld de, wLoadedMonStatus
	call PrintStatusCondition
	jr nz, .StatusWritten
	coord hl, 16, 6
	ld de, OKText
	call PlaceString ; "OK"
.StatusWritten
	coord hl, 9, 6
	ld de, StatusText
	call PlaceString ; "STATUS/"
	coord hl, 14, 2
	call PrintLevel ; Pokémon level
	ld a, [wMonHIndex]
	ld [wd11e], a
	ld [wd0b5], a
	predef IndexToPokedex
	coord hl, 3, 7
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; Pokémon no.
	coord hl, 11, 10
	predef PrintMonType
	ld hl, NamePointers2
	call .GetStringPointer
	ld d, h
	ld e, l
	coord hl, 9, 1
	call PlaceString ; Pokémon name
	ld hl, OTPointers
	call .GetStringPointer
	ld d, h
	ld e, l
	coord hl, 12, 16
	call PlaceString ; OT
	coord hl, 12, 14
	ld de, wLoadedMonOTID
	lb bc, LEADING_ZEROES | 2, 5
	call PrintNumber ; ID Number
	ld d, $0
	call PrintStatsBox
	call Delay3
	coord hl, 1, 0
	ld a, [wStatusScreenPageChange]
	and STATUS_KEEPPIC
	jr nz, .pictureAlreadyInVRAM
	call LoadFlippedFrontSpriteByMonIndex ; draw Pokémon picture
	jr .pictureDone
.pictureAlreadyInVRAM
	call StatusScreen_PlacePicture
.pictureDone
; v0.7: the palette is set HERE, with the picture, and not thirty lines up
; where it used to be.
;
; Stepping to another mon with Up or Down is a quiet redraw, so the mon the
; player is still looking at stays on screen for the whole of it - and the
; palette is not part of the tile map, so setting it early repainted THAT mon
; in the NEXT one's colours and left it like that until the picture caught up.
; Measured on the step: something visible changed at frame +4, then twenty-six
; frames of nothing at all, then the picture arrived at +32. A green PIKACHU
; for half a second, which is what Forte reported.
;
; Moved, not added - the two instructions come from further up, so this costs
; nothing in a bank that has seven bytes left. GetHealthBarColor stays where it
; was: it only computes wStatusScreenHPBarColor and paints nothing.
	ld b, SET_PAL_STATUS_SCREEN
	call RunPaletteCommand
	ld a, [wStatusScreenPageChange]
	and STATUS_QUIET
	call z, GBPalNormal ; a quiet redraw never dimmed the palette to begin with
	call StatusScreen_RevealQuietPage ; put the finished page up BEFORE the cry
	ld a, [wStatusScreenPageChange]
	and STATUS_NOCRY
	jr nz, .continue
	call StatusScreen_PlayMonCry
.continue
	ld a, [wStatusScreenPageChange]
	ld b, a ; the mode: WaitForButton is about to overwrite it with the answer
	and STATUS_NOWAIT
	jr nz, .dontWait
	push bc ; WaitForButton uses b for the joypad
	call StatusScreen_WaitForButton ; A/Left/Right change page, Up/Down the mon
	pop bc
.dontWait
	pop af
	ld [hTileAnimations], a
	bit 7, b ; STATUS_OPTIN
	ret z ; vanilla caller: page 2 always follows and tears the screen down
	ld a, [wStatusScreenPageChange]
	and a
	ret nz ; another page or another mon is coming; leave the screen standing
	jp StatusScreen_TearDown ; B closed the screen from page 1

.GetStringPointer
; Stays inside StatusScreen's label scope - the routines below are global, and
; a global label between here and the calls above would put this out of reach.
	ld a, [wMonDataLocation]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonDataLocation]
	cp DAYCARE_DATA
	ret z
	ld a, [wWhichPokemon]
	jp SkipFixedLengthTextEntries

StatusScreen_PlayMonCry:
; Lifted out of StatusScreen so page 2 can play the cry as well. It has to be
; page 2 that plays it when the player steps to another Pokémon from the move
; list: PlayCry waits for the sound to finish inside itself, so a cry started
; while page 1 is being composed pins page 1 on screen for the cry's whole
; length. Draw first, cry second - the same shape the day care handlers use.
	ld a, [wMonDataLocation]
	cp ENEMY_PARTY_DATA
	jr z, .playRegularCry
	cp BOX_DATA
	jr z, .checkBoxData
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .playRegularCry
	jr .playPikachuSoundClip
.checkBoxData
	callfar IsThisPartymonStarterPikachu_Box
	jr nc, .playRegularCry
.playPikachuSoundClip
	ld e, 16
	callfar PlayPikachuSoundClip
	ret
.playRegularCry
	ld a, [wcf91] ; LoadMonData left the species here and page 2 never touches it
	jp PlayCry

StatusScreen_NormalizeMode:
; The answers this screen writes back (1, 2, 3) reuse the same low bits as the
; mode flags - STATUS_OTHER_PAGE is bit-for-bit STATUS_QUIET | STATUS_NOCRY. A
; caller that does not speak the protocol never writes the byte at all, so it
; would be reading whichever answer the party menu happened to leave there and
; could silently pick up a mode it knows nothing about.
;
; The party menu always leaves 0 today, so this is a trap rather than a bug -
; but it is the exact shape of trap that keeps costing this project days, so it
; is closed here instead of documented. One test at the top: no opt-in, no
; modes, and every `and STATUS_*` below can then be taken at face value.
	ld a, [wStatusScreenPageChange]
	bit 7, a ; STATUS_OPTIN
	ret nz
	xor a
	ld [wStatusScreenPageChange], a
	ret

StatusScreen_PlacePicture:
; in: hl = top left corner of the picture, the same as the full loader wants.
;
; The move page leaves the picture untouched in VRAM, so coming back to the
; stats page for the SAME mon only needs the tile map entries that ClearScreen
; wiped - not another decompression. This is the tail of
; LoadFrontSpriteByMonIndex with the LoadMonFrontSprite call left out, and it
; is worth having: the decompression measured 35 of the 60 frames a page swap
; costs, so skipping it is most of the wait.
; Goes through the predef rather than switching banks by hand: the loader this
; was lifted from lives in the home bank and can switch freely, but this routine
; does not - swapping the bank out from under itself would run the next
; instruction from whatever landed at that address.
	ld a, 1
	ld [wSpriteFlipped], a ; the status screen shows the mirrored picture, and
	                       ; the tile map has to be laid out to match
	xor a
	ldh [hStartTileID], a
	predef CopyUncompressedPicToTilemap
	xor a
	ld [wSpriteFlipped], a
	ret

StatusScreen_RevealQuietPage:
; A quiet page was composed with the BG transfer off, so VRAM still shows the
; page the player was reading. Turning the transfer back on swaps the whole
; page in at once, with no blank frame in between.
	ld a, [wStatusScreenPageChange]
	and STATUS_QUIET
	ret z
	ld a, [wStatusScreenPageChange]
	and STATUS_NOWAIT
	ret nz ; page 2 is about to draw over this one - stay hidden until it does
; NOT FIXED HERE, and it is the last thing left of the flicker Forte reported:
; the transfer moves SIX ROWS per VBlank, so putting the page up takes three
; frames whatever we do, and hAutoBGTransferPortion is wherever the last screen
; left it - so the page arrives in a scrambled order rather than top to bottom.
; Two frames of it are visible. `xor a / ldh [hAutoBGTransferPortion], a` here
; and the same before page 2's reveal would make it a plain downward wipe, and
; costs 6 bytes; bank $4 has exactly 6 left and all three of its sections are
; pinned in layout.link. That is Forte's to spend, not mine.
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

StatusScreen_TearDown:
; Undo what the way in did: the volume cut, the wd72c flag and the screen
; itself. Page 2 has always done this on the way out; page 1 needs it too now
; that B closes the screen from either page.
	ld hl, wd72c
	res 1, [hl]
	ld a, $77
	ldh [rNR50], a
	call GBPalWhiteOut
	jp ClearScreen

OTPointers:
	dw wPartyMonOT
	dw wEnemyMonOT
	dw wBoxMonOT
	dw wDayCareMonOT

NamePointers2:
	dw wPartyMonNicks
	dw wEnemyMonNicks
	dw wBoxMonNicks
	dw wDayCareMonName

Type1Text:
	db   "TYPE1/"
	next ""
	; fallthrough
Type2Text:
	db   "TYPE2/"
	next ""
	; fallthrough
IDNoText:
	db   "<ID>№/"
	next ""
	; fallthrough
OTText:
	db   "OT/"
	next "@"

StatusText:
	db "STATUS/@"

OKText:
	db "OK@"

; Draws a line starting from hl high b and wide c
DrawLineBox:
	ld de, SCREEN_WIDTH ; New line
.PrintVerticalLine
	ld [hl], $78 ; │
	add hl, de
	dec b
	jr nz, .PrintVerticalLine
	ld [hl], $77 ; ┘
	dec hl
.PrintHorizLine
	ld [hl], $76 ; ─
	dec hl
	dec c
	jr nz, .PrintHorizLine
	ld [hl], $6f ; ← (halfarrow ending)
	ret

PrintStatsBox:
	ld a, d
	and a ; a is 0 from the status screen
	jr nz, .DifferentBox
	hlcoord 0, 8
	lb bc, 8, 8
	call TextBoxBorder ; Draws the box
	hlcoord 1, 9 ; Start printing stats from here
	ld bc, $19 ; Number offset
	jr .PrintStats
.DifferentBox
	hlcoord 9, 2
	lb bc, 8, 9
	call TextBoxBorder
	hlcoord 11, 3
	ld bc, $18
.PrintStats
	push bc
	push hl
	ld de, StatsText
	call PlaceString
	pop hl
	pop bc
	add hl, bc
	; New Stat Exp / DVs display functionality, from shin pokered.
	;joenote - print stat exp if select is held
	call Joypad
	ld a, [hJoyHeld]
	bit 2, a
	jr z, .checkstart
	dec l	;shift alignment 2 tiles to the left
	dec l
	ld de, wLoadedMonAttackExp
	lb bc, 2, 5
	call PrintStat
	ld de, wLoadedMonDefenseExp
	call PrintStat
	ld de, wLoadedMonSpecialExp
	call PrintStat
	ld de, wLoadedMonSpeedExp
	jp PrintNumber
.checkstart	;joenote - print DVs if start is held
	bit 3, a
	jr z, .doregular
	ld de, wDVCalcVar2
	lb bc, 1, 2
	call PrintStat
	ld de, wDVCalcVar2 + 1
	call PrintStat
	ld de, wDVCalcVar2 + 3
	call PrintStat
	ld de, wDVCalcVar2 + 2
	jp PrintNumber
.doregular
	ld de, wLoadedMonAttack
	lb bc, 2, 3
	call PrintStat
	ld de, wLoadedMonDefense
	call PrintStat
	ld de, wLoadedMonSpecial
	call PrintStat
	ld de, wLoadedMonSpeed
	jp PrintNumber
PrintStat:
	push hl
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret

StatsText:
	db   "ATTACK"
	next "DEFENSE"
	next "SPECIAL"
	next "SPEED@"

StatusScreen2:
	call StatusScreen_NormalizeMode
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	ldh [hAutoBGTransferEnabled], a
	ld bc, NUM_MOVES + 1
	ld hl, wMoves
	call FillMemory
	ld hl, wLoadedMonMoves
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callfar FormatMovesString
	hlcoord 9, 2
	lb bc, 5, 10
	call ClearScreenArea ; Clear under name
	hlcoord 19, 3
	ld [hl], $78
	hlcoord 0, 8
	lb bc, 8, 18
	call TextBoxBorder ; Draw move container
	hlcoord 2, 9
	ld de, wMovesString
	call PlaceString ; Print moves
	ld a, [wNumMovesMinusOne]
	inc a
	ld c, a
	ld a, $4
	sub c
	ld b, a ; ld b, a ; number of empty move slots (4 - number of moves)
	hlcoord 11, 10
	ld de, SCREEN_WIDTH * 2
	ld a, "<BOLD_P>"
	call StatusScreen_PrintPP ; Print "PP"
	ld a, b
	and a
	jr z, .InitPP
	ld c, a
	ld a, "-"
	call StatusScreen_PrintPP ; Fill the rest with --
.InitPP
	ld hl, wLoadedMonMoves
	decoord 14, 10
	ld b, 0
.PrintPP
	ld a, [hli]
	and a
	jr z, .PPDone
	push bc
	push hl
	push de
	ld hl, wCurrentMenuItem
	ld a, [hl]
	push af
	ld a, b
	ld [hl], a
	push hl
	callfar GetMaxPP
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, wPartyMon1PP - wPartyMon1Moves - 1
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStatusScreenCurrentPP], a
	ld h, d
	ld l, e
	push hl
	ld de, wStatusScreenCurrentPP
	lb bc, 1, 2
	call PrintNumber
	ld a, "/"
	ld [hli], a
	ld de, wMaxPP
	lb bc, 1, 2
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp $4
	jr nz, .PrintPP
.PPDone
	hlcoord 9, 3
	ld de, StatusScreenExpText
	call PlaceString
	ld a, [wLoadedMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .Level100
	inc a
	ld [wLoadedMonLevel], a ; Increase temporarily if not 100
.Level100
	hlcoord 14, 6
	ld [hl], "<to>"
	inc hl
	inc hl
	call PrintLevel
	pop af
	ld [wLoadedMonLevel], a
	ld de, wLoadedMonExp
	hlcoord 12, 4
	lb bc, 3, 7
	call PrintNumber ; exp
	call CalcExpToLevelUp
	ld de, wLoadedMonExp
	hlcoord 7, 6
	lb bc, 3, 7
	call PrintNumber ; exp needed to level up
	hlcoord 9, 0
	call StatusScreen_ClearName
	hlcoord 9, 1
	call StatusScreen_ClearName
	ld a, [wMonHIndex]
	ld [wd11e], a
	call GetMonName
	hlcoord 9, 1
	call PlaceString
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ld a, [wStatusScreenPageChange]
	and STATUS_CRYAFTER
	call nz, StatusScreen_PlayMonCry ; the stepped-to mon's cry, over a page
	                                 ; that is already up
	call StatusScreen_WaitForButton ; A/Left/Right change page, Up/Down the mon
	pop af
	ldh [hTileAnimations], a
	ld a, [wStatusScreenPageChange]
	and a
	ret nz ; another page or another mon is coming; leave the screen standing
	jp StatusScreen_TearDown

StatusScreen_WaitForButton:
; Answers the caller instead of merely returning, because the party menu drives
; both pages of this screen from outside. The answer goes in
; wStatusScreenPageChange - a predef cannot return one in a register.
;
;   B               -> STATUS_CLOSED       leave the screen
;   A, Left, Right  -> STATUS_OTHER_PAGE   the same mon's other page
;   Up, Down        -> STATUS_PREV/NEXT_MON  walk the party in place
;
; A caller that did not set STATUS_OPTIN keeps vanilla behaviour exactly: A or
; B ends the page and the d-pad does nothing. Battle, Bill's PC and the cable
; club are all in that group.
	ld a, [wStatusScreenPageChange]
	bit 7, a ; STATUS_OPTIN
	jr nz, .optedIn
	xor a
	ld [wStatusScreenPageChange], a ; a defined STATUS_CLOSED, so the tear-down
	                                ; check at the end of page 2 still fires
	jp WaitForTextScrollButtonPress ; jp, not jr - it lives in the home bank
.optedIn
	ldh a, [hDownArrowBlinkCount1]
	push af
	ldh a, [hDownArrowBlinkCount2]
	push af
	xor a
	ldh [hDownArrowBlinkCount1], a
	ld a, $6
	ldh [hDownArrowBlinkCount2], a
.loop
	push hl
	hlcoord 18, 16
	call HandleDownArrowBlinkTiming
	pop hl
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	bit BIT_B_BUTTON, b
	ld c, STATUS_CLOSED
	jr nz, .done
	ld c, STATUS_OTHER_PAGE
	bit BIT_A_BUTTON, b
	jr nz, .done
	bit BIT_D_LEFT, b
	jr nz, .done
	bit BIT_D_RIGHT, b
	jr nz, .done
	bit BIT_D_UP, b
	ld c, STATUS_PREV_MON
	jr nz, .done
	bit BIT_D_DOWN, b
	ld c, STATUS_NEXT_MON
	jr z, .loop
.done
	ld a, c
	ld [wStatusScreenPageChange], a
	pop af
	ldh [hDownArrowBlinkCount2], a
	pop af
	ldh [hDownArrowBlinkCount1], a
	ret

CalcExpToLevelUp:
	ld a, [wLoadedMonLevel]
	cp MAX_LEVEL
	jr z, .atMaxLevel
	inc a
	ld d, a
	callfar CalcExperience
	ld hl, wLoadedMonExp + 2
	ldh a, [hExperience + 2]
	sub [hl]
	ld [hld], a
	ldh a, [hExperience + 1]
	sbc [hl]
	ld [hld], a
	ldh a, [hExperience]
	sbc [hl]
	ld [hld], a
	ret
.atMaxLevel
	ld hl, wLoadedMonExp
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

StatusScreenExpText:
	db   "EXP POINTS"
	next "LEVEL UP@"

StatusScreen_ClearName:
	ld bc, 10
	ld a, " "
	jp FillMemory

StatusScreen_PrintPP:
; print PP or -- c times, going down two rows each time
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, StatusScreen_PrintPP
	ret

; DV parsing from shin pokered
;joenote - parse DV scores
DVParse:
	push hl
	push bc
	ld hl, wDVCalcVar2
	ld b, $00

	ld a, [wLoadedMonDVs]	;get attack dv
	swap a
	and $0F
	ld [hl], a
	inc hl
	and $01
	sla a
	sla a
	sla a
	or b
	ld b, a
	
	
	ld a, [wLoadedMonDVs]	;get defense dv
	and $0F
	ld [hl], a
	inc hl
	and $01
	sla a
	sla a
	or b
	ld b, a
	
	ld a, [wLoadedMonDVs + 1]	;get speed dv
	swap a
	and $0F
	ld [hl], a
	inc hl
	and $01
	sla a
	or b
	ld b, a
	
	ld a, [wLoadedMonDVs + 1]	;get special dv
	and $0F
	ld [hl], a
	inc hl
	and $01
	or b
	ld b, a

	ld [hl], b	;load hp dv
	
	pop bc
	pop hl
	ret