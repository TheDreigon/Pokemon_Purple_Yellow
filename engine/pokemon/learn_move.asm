LearnMove:
	call SaveScreenTilesToBuffer1
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wcd6d
	ld de, wLearnMoveMonName
	ld bc, NAME_LENGTH
	call CopyData

DontAbandonLearning:
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2Moves - wPartyMon1Moves
	ld a, [wWhichPokemon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
.findEmptyMoveSlotLoop
	ld a, [hl]
	and a
	jr z, .next
	inc hl
	dec b
	jr nz, .findEmptyMoveSlotLoop
	push de
	call TryingToLearn
	pop de
	jp c, AbandonLearning
	push hl
	push de
	ld [wd11e], a
	call GetMoveName
	ld hl, OneTwoAndText
	call PrintText
	pop de
	pop hl
.next
	ld a, [wMoveNum]
	ld [hl], a
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	push hl
	push de
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wBuffer
	ld a, BANK(Moves)
	call FarCopyData
	ld a, [wBuffer + 5] ; a = move's max PP
	pop de
	pop hl
	ld [hl], a
	ld a, [wIsInBattle]
	and a
	jp z, PrintLearnedMove
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b
	jp nz, PrintLearnedMove
	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyData
	ld bc, wPartyMon1PP - wPartyMon1OTID
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyData
	jp PrintLearnedMove

AbandonLearning:
	ld hl, AbandonLearningText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jp nz, DontAbandonLearning
	ld hl, DidNotLearnText
	call PrintText
	ld b, 0
	ret

PrintLearnedMove:
	ld hl, LearnedMove1Text
	call PrintText
	ld b, 1
	ret

TryingToLearn:
	push hl
	ld hl, TryingToLearnText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	pop hl
	ld a, [wCurrentMenuItem]
	rra
	ret c
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callfar FormatMovesString
	pop hl
; v0.7: the cursor is zeroed HERE rather than inside the loop, because the loop
; is re-entered every time the player closes a MOVE INFO card and putting it
; back on the top move each time would make comparing five of them a chore.
	xor a
	ld [wCurrentMenuItem], a
.loop
	push hl
	ld hl, WhichMoveToForgetText
	call PrintText
; v0.7: five rows, not four, and the box starts a row higher so its foot still
; lands on row 12 where the text box begins. The fifth row is the move being
; learned: the choice is between five moves, so the player is shown five.
	hlcoord 4, 6
	lb bc, 5, 14
	call TextBoxBorder
	hlcoord 6, 7
	ld de, wMovesString
	ldh a, [hUILayoutFlags]
	set 2, a
	ldh [hUILayoutFlags], a
	call PlaceString
	ldh a, [hUILayoutFlags]
	res 2, a
	ldh [hUILayoutFlags], a
; the move being learned, placed on its own rather than appended to
; wMovesString: that buffer is 56 bytes and four twelve-letter names already
; fill 52 of them.
	ld a, [wMoveNum]
	ld [wd11e], a
	call GetMoveName ; de = wcd6d
	hlcoord 6, 11
	call PlaceString
	ld hl, wTopMenuItemY
	ld a, 7
	ld [hli], a ; wTopMenuItemY
	ld a, 5
	ld [hli], a ; wTopMenuItemX
	inc hl ; leave wCurrentMenuItem where the player left it
	inc hl ; wTileBehindCursor
	ld a, [wNumMovesMinusOne]
	inc a ; ...plus the move being learned
	ld [hli], a ; wMaxMenuItem
	ld a, A_BUTTON | B_BUTTON | START
	ld [hli], a ; wMenuWatchedKeys
	ld a, [wCurrentMenuItem]
	ld [hl], a ; wLastMenuItem: the box is redrawn whole, so match the cursor
	xor a
	ld [wMenuWatchMovingOutOfBounds], a ; menu hygiene: a stale start-menu-wrap flag
	ld [wMenuJoypadPollCount], a         ; or cable-club poll count would auto-forget a move
	ld hl, hUILayoutFlags
	set 1, [hl]
	call HandleMenuInput
	ld hl, hUILayoutFlags
	res 1, [hl]
	push af
	call LoadScreenTilesFromBuffer1
	pop af
	pop hl ; hl = the mon's four move bytes
; v0.7: START opens the MOVE INFO card for whichever of the five is highlighted,
; the same card START opens on the FIGHT menu and in the MOVEDEX. Deciding
; which of five moves to drop was the one moment the game demanded the
; comparison and gave you nothing but the names.
	bit BIT_START, a
	jp nz, .showCard
	bit BIT_B_BUTTON, a
	jp nz, .cancel
; The fifth entry is the move being learned, so choosing it means "forget that
; one" -- which is giving up on it. Same exit as B: the caller asks whether to
; stop learning and prints "did not learn".
	ld a, [wCurrentMenuItem]
	cp NUM_MOVES
	jp z, .cancel ; jp, not jr: the .showCard restore block pushed .cancel out of jr reach
; v0.7: confirm before dropping it. The move went the instant the cursor was on
; it and A was pressed, with no way back from a mis-press -- and this is the one
; choice in the game that cannot be undone afterwards.
	push hl
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	pop hl
	push hl ; the mon's four move bytes
	push bc ; the row the player chose
	call GetMoveName ; names the move being FORGOTTEN, into wcd6d
	ld hl, ConfirmForgetMoveText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu -- it lands on wCurrentMenuItem
	ld a, [wCurrentMenuItem] ; 0 = yes
; 🔴 pop bc / pop hl and NOT pop af: popping af would restore F along with A and
; throw the answer away. (The MOVEDEX shipped exactly that bug once.)
	pop bc
	pop hl
	and a
	jr nz, .keptMove
	ld a, c
	ld [wCurrentMenuItem], a ; the yes/no overwrote the row; put it back
	push hl
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	push af
	push bc
	call IsMoveHM
	pop bc
	pop de
	ld a, d
	; jr c, .hm ; Don't prevent hm deletion
	pop hl
	add hl, bc
	and a
	ret

; Said no: put the cursor back on the row they were looking at and redraw.
.keptMove
	ld a, c
	ld [wCurrentMenuItem], a
	jp .loop

.showCard
	push hl
	; v0.7 fix: the card writes the inspected move into wPlayerSelectedMove
	; (ShowMoveInfo's input) and clobbers the wPlayerMove* block. Mid-battle
	; -- this menu runs on level-up after an enemy faint -- a mon locked
	; into a charge/Thrash/Bide/Rage continuation reuses BOTH across turns,
	; so it would execute the INSPECTED move as its charge release, or run
	; the continuation with the inspected move's power/type/effect. Save
	; the selection here; re-derive the block after the card.
	ld a, [wPlayerSelectedMove]
	push af
	ld a, [wCurrentMenuItem]
	cp NUM_MOVES
	jr z, .cardForNewMove
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	jr .gotCardMove
.cardForNewMove
	ld a, [wMoveNum]
.gotCardMove
	ld [wPlayerSelectedMove], a
; Buffer 1 still holds the screen LearnMove saved on the way in, and the card
; does not touch it -- the FIGHT menu wraps it in buffer 2 -- so it can be laid
; over the top and the screen pulled back afterwards.
;
; The party's mini-icons are OAM, not tilemap, so restoring the screen does
; nothing about them and they floated over the card whenever this was reached by
; teaching a TM (the FIGHT menu never showed it, because in battle the Pokemon
; are background tiles). Clear them going in and put them back coming out --
; ClearSprites only zeroes the shadow buffer, so it takes a frame to reach the
; screen.
;
; They are NOT put back: RedrawPartyMenu_ would do it, but it prints names
; through the string buffers, and wStringBuffer is holding the move being
; LEARNED for the whole of this flow -- calling it turned "Learn IRON TAIL /
; over GROWL?" into garbage. The icons stay gone until the caller rebuilds the
; party menu, which costs a little of the screen behind the window and is a much
; smaller price than sprites sitting on top of the card.
	call ClearSprites
	call DelayFrame
	farcall ShowMoveInfo
	call LoadScreenTilesFromBuffer1
	pop af
	ld [wPlayerSelectedMove], a
; Mid-battle the Thrash/Bide/Rage/charge continuations skip move selection:
; charge re-reads wPlayerSelectedMove in GetCurrentMove, the others reuse the
; wPlayerMove* block without re-deriving it -- and the card clobbered both.
; Restore the selection and re-derive the block from it (the same fetch
; GetCurrentMove and the card itself perform). 0 = nothing selected
; (out-of-battle learn); $ff = "player is trapped" -- nothing to re-derive.
	and a
	jr z, .cardDone
	inc a
	jr z, .cardDone
	dec a
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveNum
	ld a, BANK(Moves)
	call FarCopyData
.cardDone
	pop hl
	jp .loop
; .hm
; 	ld hl, HMCantDeleteText
; 	call PrintText
; 	pop hl
; 	jr .loop
.cancel
	scf
	ret

LearnedMove1Text:
	text_far _LearnedMove1Text
	sound_get_item_1 ; plays SFX_GET_ITEM_1 in the party menu (rare candy) and plays SFX_LEVEL_UP in battle
	text_promptbutton
	text_end

WhichMoveToForgetText:
	text_far _WhichMoveToForgetText
	text_end

ConfirmForgetMoveText:
	text_far _ConfirmForgetMoveText
	text_end

AbandonLearningText:
	text_far _AbandonLearningText
	text_end

DidNotLearnText:
	text_far _DidNotLearnText
	text_end

TryingToLearnText:
	text_far _TryingToLearnText
	text_end

OneTwoAndText:
; bugfix: In Red/Blue, the SFX_SWAP sound was played in the wrong bank, which played an incorrect sound
; Yellow has fixed this by swapping to the correct bank
	text_far _OneTwoAndText
	text_pause
	text_asm
	push af
	push bc
	push de
	push hl
	ld a, $1
	ld [wMuteAudioAndPauseMusic], a
	call DelayFrame
	ld a, [wAudioROMBank]
	push af
	ld a, BANK(SFX_Swap_1)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	call WaitForSoundToFinish
	ld a, SFX_SWAP
	call PlaySound
	call WaitForSoundToFinish
	pop af
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	xor a
	ld [wMuteAudioAndPauseMusic], a
	pop hl
	pop de
	pop bc
	pop af
	ld hl, PoofText
	ret

PoofText:
	text_far _PoofText
	text_pause
ForgotAndText:
	text_far _ForgotAndText
	text_end

HMCantDeleteText:
	text_far _HMCantDeleteText
	text_end
