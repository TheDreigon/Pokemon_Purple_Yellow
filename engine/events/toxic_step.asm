; v1.0 (2026-11-11): the out-of-battle poison tick, every fourth step. These are the
; two loops of vanilla's ApplyOutOfBattlePoisonDamage (engine/events/poison.asm, bank
; 3: its gates, the day care's EXP and the black out stay there), moved behind one
; farcall because the new rules need more room than bank 3 has. In "Battle Core
; Overflow" (bank $10), next to engine/battle/toxic_carry.asm.
; The rules (Forte, 2026-11-10 and 11):
;  - ordinary POISON costs nothing on the map. Only a bad POISON bites - PSN and TOX
;    together in the status byte, $88 - for 1 HP every fourth step, as POISON did;
;  - Hard: down to a faint, as before (the text, PIKACHU's reaction, and the black out
;    back in bank 3 when it was the last one standing);
;  - Normal: it never takes the last HP. At 1 HP - reached by this bite, or already
;    there when the bite comes - the bad POISON is over: the whole status byte is
;    cleared and TEXT_TOX_SURVIVED says so (Gen 4's "survived the poisoning");
;  - the flash and SFX_POISONED only while a #MON is still badly poisoned after the
;    bites (vanilla counted after the damage too).
; Trashes a, bc, de, hl.
StepToxicTick::
	xor a
	ld [wWhichPokemon], a
	ld hl, wPartyMon1Status
	ld de, wPartySpecies
.applyDamageLoop
	ld a, [hl]
	and (1 << PSN) | (1 << TOX)
	cp (1 << PSN) | (1 << TOX)
	jp nz, .nextMon2 ; no bad POISON: nothing on the map
	dec hl
	dec hl
	ld a, [hld]
	ld b, a ; the HP's low byte
	ld a, [hli]
	ld c, a ; its high byte
	or b
	jp z, .nextMon ; already fainted
; hl = the HP's low byte
	ld a, [wDifficulty]
	and a
	jr nz, .subtract ; Hard: down to a faint
	ld a, c
	and a
	jr nz, .subtract ; Normal, 256 HP or more
	ld a, b
	cp 3
	jr nc, .subtract ; Normal, 3 to 255 HP
; Normal, 1 or 2 HP: it ends at 1 HP, and the bad POISON is over
	ld [hl], 1
	push hl
	inc hl
	inc hl
	xor a
	ld [hl], a ; the whole status byte: PSN and TOX leave together
	push de
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	xor a
	ld [wJoyIgnore], a
	call EnableAutoTextBoxDrawing
	ld a, TEXT_TOX_SURVIVED
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	pop de
	pop hl
	jr .nextMon
.subtract
; subtract 1 from HP
	ld a, [hl]
	dec a
	ld [hld], a
	inc a
	jr nz, .noBorrow
; borrow 1 from upper byte of HP
	dec [hl]
	inc hl
	jr .nextMon
.noBorrow
	ld a, [hli]
	or [hl]
	jr nz, .nextMon ; didn't faint from damage
; the mon fainted from the damage (Hard only)
	push hl
	inc hl
	inc hl
	ld [hl], a ; the whole status byte (a = 0)
	ld a, [de]
	ld [wd11e], a
	push de
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	xor a
	ld [wJoyIgnore], a
	call EnableAutoTextBoxDrawing
	ld a, TEXT_MON_FAINTED
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .curMonNotPlayerPikachu
	ld e, $3
	callfar PlayPikachuSoundClip
	calladb_ModifyPikachuHappiness PIKAHAPPY_PSNFNT
.curMonNotPlayerPikachu
	pop de
	pop hl
.nextMon
	inc hl
	inc hl
.nextMon2
	inc de
	ld a, [de]
	inc a
	jr z, .applyDamageLoopDone
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	push hl
	ld hl, wWhichPokemon
	inc [hl]
	pop hl
	jp .applyDamageLoop
.applyDamageLoopDone
	ld hl, wPartyMon1Status
	ld a, [wPartyCount]
	ld d, a
	ld e, 0
.countLoop
	ld a, [hl]
	and (1 << PSN) | (1 << TOX)
	cp (1 << PSN) | (1 << TOX)
	jr nz, .notBadlyPoisoned
	inc e
.notBadlyPoisoned
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	dec d
	jr nz, .countLoop
	ld a, e
	and a ; is any party member still badly poisoned?
	ret z
	ld b, $2
	predef ChangeBGPalColor0_4Frames ; change BG white to dark grey for 4 frames
	ld a, SFX_POISONED
	jp PlaySound
