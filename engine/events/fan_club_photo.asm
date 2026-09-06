; The FAN CLUB CHAIRMAN's photo of one of your #MON.
;
; v0.7: this screen used to be the drawing half of PrintFanClubPortrait, which
; then shipped the tilemap out over the link port to a Game Boy Printer. The
; printer is gone; the photo is not. The routine only ever drew — the caller
; now just waits for a button press instead of running a transmission loop.
;
; Callers must have a party index in wWhichPokemon (DisplayPartyMenu leaves it
; there) before calling this.

DisplayFanClubPhoto::
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call LoadHpBarAndStatusTilePatterns
	ld de, FanClubPhotoHPGFX
	ld hl, vChars2 + $710
	lb bc, BANK(FanClubPhotoHPGFX), (FanClubPhotoHPGFXEnd - FanClubPhotoHPGFX) / 8
	call CopyVideoDataDouble

	ld de, FanClubPhotoLevelGFX
	ld hl, vChars2 + $6e0
	lb bc, BANK(FanClubPhotoLevelGFX), (FanClubPhotoLevelGFXEnd - FanClubPhotoLevelGFX) / 8
	call CopyVideoDataDouble

	xor a
	ldh [hAutoBGTransferEnabled], a
	xor a
	ld [wWhichTradeMonSelectionMenu], a
	call LoadMonData

	ld hl, wTileMap
	lb bc, 16, 18
	call TextBoxBorder

	hlcoord 0, 12
	lb bc, 4, 18
	call TextBoxBorder

	hlcoord 3, 10
	call PrintLevelFull

	hlcoord 2, 10
	ld a, $6e
	ld [hli], a
	ld [hl], " "

	hlcoord 2, 11
	ld [hl], "’"

	hlcoord 4, 11
	ld de, wLoadedMonMaxHP
	lb bc, 2, 3
	call PrintNumber

	ld a, [wMonHeader]
	ld [wPokeBallAnimData], a
	ld [wd0b5], a
	ld hl, wPartyMonNicks
	call .GetNamePointer
	hlcoord 8, 2
	call PlaceString

	call GetMonName
	hlcoord 9, 3
	call PlaceString

	predef IndexToPokedex
	hlcoord 2, 8
	ld [hl], "№"
	inc hl
	ld [hl], $f2
	inc hl
	ld de, wPokeBallAnimData
	lb bc, $80 | 1, 3
	call PrintNumber

	hlcoord 8, 4
	ld de, .OT
	call PlaceString

	ld hl, wPartyMonOT
	call .GetNamePointer
	hlcoord 9, 5
	call PlaceString

	hlcoord 9, 6
	ld de, .IDNo
	call PlaceString

	hlcoord 13, 6
	ld de, wLoadedMonOTID
	lb bc, $80 | 2, 5
	call PrintNumber

	hlcoord 8, 7
	ld de, .Stats
	ldh a, [hUILayoutFlags]
	set 2, a ; <NEXT> advances one line instead of two
	ldh [hUILayoutFlags], a
	call PlaceString
	ldh a, [hUILayoutFlags]
	res 2, a
	ldh [hUILayoutFlags], a

; v1.0 (the SPECIAL split, 2026-09-06): five stats by name, in display order
; (ATTACK / DEFENSE / SP.ATK / SP.DEF / SPEED) - the struct stores SPEED
; before the two SP stats, and walking it raw under fixed labels is how the
; dex once disagreed with the stats page (NIDORAN). Rows 7-11, labels at
; col 8 (a gap before every number), numbers at cols 16-18, above the moves
; box border on row 12.
	hlcoord 16, 7
	ld de, wLoadedMonAttack
	call .stat
	ld de, wLoadedMonDefense
	call .stat
	ld de, wLoadedMonSpAtk
	call .stat
	ld de, wLoadedMonSpDef
	call .stat
	ld de, wLoadedMonSpeed
	lb bc, 2, 3
	call PrintNumber
	ASSERT 7 + (NUM_STATS - 1) == 12, "five stat rows 7-11 end on the moves box border"

	hlcoord 1, 13
	ld a, [wLoadedMonMoves]
	call .PlaceMoveName

	hlcoord 1, 14
	ld a, [wLoadedMonMoves + 1]
	call .PlaceMoveName

	hlcoord 1, 15
	ld a, [wLoadedMonMoves + 2]
	call .PlaceMoveName

	hlcoord 1, 16
	ld a, [wLoadedMonMoves + 3]
	call .PlaceMoveName

	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand

	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	call GBPalNormal
	hlcoord 1, 1
	call LoadFlippedFrontSpriteByMonIndex
	ret

.GetNamePointer:
	ld bc, NAME_LENGTH
	ld a, [wWhichPokemon]
	call AddNTimes
	ld e, l
	ld d, h
	ret

.PlaceMoveName:
	and a
	jr z, .no_move
	ld [wPokeBallAnimData], a
	call GetMoveName
	jr .place_string

.no_move
	ld de, .Blank
.place_string
	call PlaceString
	ret

.OT:
	db "OT/@"

.IDNo:
	db $73, "№/@"

.stat
	push hl
	lb bc, 2, 3
	call PrintNumber
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	ret

.Stats:
	db   "ATTACK"
	next "DEFENSE"
	next "SP.ATK"
	next "SP.DEF"
	next "SPEED@"

.Blank:
	db "--------------@"

FanClubPhotoHPGFX:
INCBIN "gfx/fan_club/hp.1bpp"
FanClubPhotoHPGFXEnd:

FanClubPhotoLevelGFX:
INCBIN "gfx/fan_club/lv.1bpp"
FanClubPhotoLevelGFXEnd:
