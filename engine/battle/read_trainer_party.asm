ReadTrainer:

; don't change any moves in a link battle
	ld a, [wLinkState]
	and a
	ret nz

; set [wEnemyPartyCount] to 0, [wEnemyPartySpecies] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl, wEnemyPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

; get the pointer to trainer data for this class
	ld a, [wTrainerClass] ; get trainer class
	dec a
	add a
	ld hl, TrainerDataPointers
	ld c, a
	ld b, 0
	add hl, bc ; hl points to trainer class
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTrainerNo]
	ld b, a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z, .IterateTrainer
.inner
	ld a, [hli]
	and a
	jr nz, .inner
	jr .outer

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [wLoneAttackNo] != 0, one pokemon on the team has a special move
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	ld a, [hli]
	cp $FF ; is the trainer special?
	jr z, .SpecialTrainer ; if so, check for special moves
	call HardModeBossLevelBump ; v0.7 hard mode: bosses get +2 (cap MAX_LEVEL)
	ld [wCurEnemyLVL], a
.LoopTrainerData
	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jp z, .AddAdditionalMoveData
	ld [wcf91], a ; write species somewhere (XXX why?)
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData
.SpecialTrainer
; if this code is being run:
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [wLoneAttackNo] != 0, one pokemon on the team has a special move
	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jr z, .AddAdditionalMoveData
	call HardModeBossLevelBump ; v0.7 hard mode: bosses get +2 (cap MAX_LEVEL)
	ld [wCurEnemyLVL], a
	ld a, [hli]
	ld [wcf91], a
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .SpecialTrainer
.AddAdditionalMoveData
; does the trainer have additional move data?
	ld a, [wTrainerClass]
	ld b, a
	ld a, [wTrainerNo]
	ld c, a
	ld hl, SpecialTrainerMoves
.loopAdditionalMoveData
	ld a, [hli]
	cp $ff
	jr z, .FinishUp
	cp b
	jr nz, .asm_39c46
	ld a, [hli]
	cp c
	jr nz, .asm_39c46
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop
	ld a, [de]
	inc de
	and a
	jp z, .FinishUp
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [de]
	inc de
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	jr .writeAdditionalMoveDataLoop
.asm_39c46
	ld a, [hli]
	and a
	jr nz, .asm_39c46
	jr .loopAdditionalMoveData
.FinishUp
; clear wAmountMoneyWon addresses
	xor a
	ld de, wAmountMoneyWon
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ld a, [wCurEnemyLVL]
	ld b, a
.LastLoop
; update wAmountMoneyWon addresses (money to win) based on enemy's level
	ld hl, wTrainerBaseMoney + 1
	ld c, 2 ; wAmountMoneyWon is a 3-byte number
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz, .LastLoop ; repeat wCurEnemyLVL times
	ret

; v0.7 hard mode helper. Called from both .IterateTrainer (uniform-level
; trainer) and .SpecialTrainer (per-mon level) just BEFORE writing to
; wCurEnemyLVL. Adds 2 to A if Hard mode + boss class, capped at
; MAX_LEVEL. No-op otherwise.
;
; Note: this also subtly bumps the prize money (wAmountMoneyWon is
; computed from the bumped wCurEnemyLVL down at .FinishUp). That's
; intentional — boss reward scales with the harder fight.
;
; Lives in bank $0E (Battle Engine 6) alongside ReadTrainer; uses
; farcall to reach IsBossTrainerClass in bank $0F (Battle Core).
;
; Input:  a = unbumped level
; Output: a = bumped level (or unchanged if not hard-mode boss)
; Trashes: b  (hl is preserved — see push/pop hl below)
HardModeBossLevelBump:
	; v0.7 FIX: the farcall to IsBossTrainerClass clobbers hl (the farcall
	; macro does `ld hl, target`), but ReadTrainer's callers keep the live
	; trainer-party data pointer in hl across this call. Preserve it, or
	; every Hard-mode trainer battle would load a garbage enemy party.
	push hl
	push af
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .noBump
	ld a, [wTrainerClass]
	farcall IsBossTrainerClass
	jr z, .noBump
	pop af
	add 2
	cp MAX_LEVEL + 1
	jr c, .done
	ld a, MAX_LEVEL
.done
	pop hl
	ret
.noBump
	pop af
	pop hl
	ret
