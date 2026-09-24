MoveDeleterText1:
	text_asm
	ld hl, MoveDeleterGreetingText
	call PrintText
.jumpback
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .exit
	ld hl, MoveDeleterSaidYesText
	call PrintText
	; Select pokemon from party.
	call SaveScreenTilesToBuffer2
	xor a
	ld [wListScrollOffset], a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	jp c, .exit
	ld a, [wWhichPokemon]
	ld b, a
	push bc
	call PrepareDeletableMoveList
	pop bc
	ld a, [wMoveBuffer]
	cp 2
	jr nc, .chooseMove
	ld hl, MoveDeleterOneMoveText
	call PrintText
	jr .jumpback
.chooseMove
	push bc
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	ld hl, MoveDeleterWhichMoveText
	call PrintText
	ld a, MOVESLISTMENU
	ld [wListMenuID], a
	ld de, wMoveBuffer
	ld hl, wListPointer
	ld [hl], e
	inc hl
	ld [hl], d
	xor a
	ld [wPrintItemPrices], a ; don't print prices
	call DisplayListMenuID
	pop bc
	jr c, .exit  ; exit if player chose cancel
	; Save the selected move id.
	ld a, [wcf91]
	ld d, a
	push de
	push bc
	ld [wMoveNum], a
	ld [wd11e],a
	call GetMoveName
	call CopyToStringBuffer ; copy name to wStringBuffer
; v1.0 (2026-09-24, Forte): CUT and SURF may be forgotten only while another
; party member still knows them - the deleter must not strand the player
; behind a tree or on an island. FLY, STRENGTH, FLASH and every other move
; stay deletable. d died in GetMoveName (it returns de = wcd6d): re-read
; wMoveNum. The refusal unwinds the stack the way the "No" answer does.
	ld a, [wMoveNum]
	ld d, a
	call DeleterCheckLastFieldMove ; carry = CUT/SURF that nobody else knows
	jr nc, .confirm
	ld hl, MoveDeleterLastFieldMoveText
	call PrintText
	pop bc ; b = mon index, needed live by .chooseMove (it pushes bc again); PrintText clobbers bc, so pop AFTER it
	pop de
	jr .chooseMove
.confirm
	ld hl, MoveDeleterConfirmText
	call PrintText
	call YesNoChoice
	pop bc
	pop de
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .chooseMove
	push de
	ld a, b ; a = mon index
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	; hl = pointer to mon's moves
	; Find the move and remove it: shift later moves (and their PP) up one slot, zero the freed last slot.
	pop de ; d = move id
	call DeleteMove
	ld hl, MoveDeleterForgotText
	call PrintText
.exit
	ld hl, MoveDeleterByeText
	call PrintText
	jp TextScriptEnd

DeleteMove:
; d = move id
	ld b, 0
.searchLoop
	ld a, [hli]
	cp d
	jr z, .foundMoveLoop
	inc b
	jr .searchLoop
.foundMoveLoop
	ld a, b
	cp 3
	jr z, .zeroLastMove
	ld a, [hl]
	dec hl
	ld [hli], a
	push hl
	ld de, wPartyMon1PP - wPartyMon1Moves
	add hl, de
	ld a, [hld]
	ld [hl], a ; copy move's PP
	pop hl
	inc hl
	inc b
	jr .foundMoveLoop
.zeroLastMove
	dec hl
	xor a
	ld [hl], a
	ld de, wPartyMon1PP - wPartyMon1Moves
	add hl, de
	ld [hl], a ; clear last move's PP
	ret

DeleterCheckLastFieldMove::
; Input: d = move id. Output: carry set if d is CUT or SURF and fewer than two
; party members know it (the selected one counts as one). PC boxes do not
; count. Preserves d; clobbers a, bc, e, hl. Exported: LearnMove (bank 1,
; level-ups and TMs) farcalls it for the same rule (2026-09-24).
	ld a, d
	cp CUT
	jr z, .fieldMove
	cp SURF
	jr nz, .allowed
.fieldMove
	ld a, [wPartyCount]
	and a
	jr z, .allowed
	ld c, a ; c = party members left to scan
	ld b, 0 ; b = members that know the move
	ld hl, wPartyMon1Moves
.monLoop
	ld e, NUM_MOVES
.moveLoop
	ld a, [hli]
	cp d
	jr nz, .notThisSlot
	inc b
.notThisSlot
	dec e
	jr nz, .moveLoop
	ld a, wPartyMon2 - wPartyMon1 - NUM_MOVES ; hl is past the 4 moves: step to the next mon's
	add l
	ld l, a
	ld a, 0 ; NOT xor a: the carry from `add l` feeds adc
	adc h
	ld h, a
	dec c
	jr nz, .monLoop
	ld a, b
	cp 2
	ret ; carry <=> fewer than 2 know it <=> refuse
.allowed
	and a
	ret

PrepareDeletableMoveList:
; Places a list of the selected pokemon's moves at wMoveBuffer.
; First byte is count, and last byte is $ff.
; Input: party mon index = [wWhichPokemon]
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	; hl = pointer to mon's 4 moves
	ld b, 0 ; count of moves
	ld c, 4 + 1 ; 4 moves
	ld de, wMoveBuffer + 1
.loop
	dec c
	jr z, .done
	ld a, [hli]
	and a
	jr z, .loop
	ld [de], a
	inc de
	inc b
	jr .loop
.done
	ld a, $ff  ; terminate the list
	ld [de], a
	ld a, b  ; store number of moves
	ld [wMoveBuffer], a
	ret

MoveDeleterGreetingText:
	text_far _MoveDeleterGreetingText
	text_end

MoveDeleterSaidYesText:
	text_far _MoveDeleterSaidYesText
	text_end

MoveDeleterWhichMoveText:
	text_far _MoveDeleterWhichMoveText
	text_end

MoveDeleterConfirmText:
	text_far _MoveDeleterConfirmText
	text_end

MoveDeleterForgotText:
	text_far _MoveDeleterForgotText
	text_end

MoveDeleterByeText:
	text_far _MoveDeleterByeText
	text_end

MoveDeleterOneMoveText:
	text_far _MoveDeleterOneMoveText
	text_end

MoveDeleterLastFieldMoveText:
	text_far _MoveDeleterLastFieldMoveText
	text_end