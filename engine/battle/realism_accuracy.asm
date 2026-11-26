; v1.0 (2026-11-26): the realism factors on the status moves. A move that gives a status condition and nothing else
; (StatusMoveRealism, by its effect) hits more or less often with the target's types: the factors of the side effects
; for that status (data/battle/realism_factors.asm; AdjustStatusChance, engine/battle/soft_status.asm, bank $12) move
; its hit chance, 10 points per row of each of the target's types, its third included (WILL-O-WISP, 85 %, into a WATER
; #MON: 75 %). They act on the chance the roll uses: after the ACCURACY and EVASION stages, before the habit's toll
; (DEATH GLARE: the factors, then the habit) and the Hard boss edge. They never take it below REALISM_FLOOR (5 %) nor
; above 100 %, and never raise a chance the stages had already taken under the floor.
;
; Everything MoveHitTest tests before the roll still comes first: PROTECT, a hidden target, MIST, and LOCK-ON's lock,
; which skips the roll and the factors with it (the move hits). The immunities are the handlers' own and are never
; crossed: an ELECTRIC #MON is never paralysed, a GHOST never scared. SPIRAL is not one of these moves: its accuracy
; stays, and each of its two legs takes the factors of its own status (SLP, CONFUSION) on its chance, as a side effect
; does (SpiralEffect_, engine/battle/soft_status.asm).
;
; The trainer AI's layer 1: one of these moves whose factors lower its chance on the player's #MON gets +1
; (AIRealismScores), the step a damaging move resisted by the player's types gets in layer 3; after layer 1's own
; rules, and only on a move they did not find useless (an immunity first, here too).
;
; The code is in Battle Core Overflow, with the habit (engine/battle/habituation.asm): MoveHitTest (bank $1D) and the
; trainer AI (Battle Engine 6) reach both with the one far call each already made.

; The status moves, by effect, and the status each gives.
StatusMoveRealism:
	db SLEEP_EFFECT,     REALISM_SLP
	db POISON_EFFECT,    REALISM_PSN
	db TOXIC_EFFECT,     REALISM_PSN
	db PARALYZE_EFFECT,  REALISM_PAR
	db BURN_EFFECT,      REALISM_BRN
	db CONFUSION_EFFECT, REALISM_CONFUSION
	db FEAR_EFFECT,      REALISM_FEAR
	db -1

; MoveHitTest's far call after CalcHitChance: the realism factors, then the habit.
; IN  d = the hit chance CalcHitChance gave (1-$FF); hWhoseTurn = the attacker.
; OUT d = that chance with the target's factors (one of the status moves) less the habit's toll (at least 1),
;     e = the habit's toll alone (HabitAccuracy): a miss the factors caused is an ordinary miss. Clobbers a, bc, hl.
HitChanceTolls::
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .gotEffect
	ld a, [wEnemyMoveEffect]
.gotEffect
	call RealismAccuracy
	jp HabitAccuracy

; IN  a = a move's effect, d = a hit chance; hWhoseTurn = the attacker.
; OUT d = that chance with the target's factors when the effect is one of StatusMoveRealism's, else as it was.
;     Clobbers a, bc, e, hl.
RealismAccuracy:
	ld b, a
	ld hl, StatusMoveRealism
.find
	ld a, [hli]
	cp -1
	ret z ; not a status move
	cp b
	ld a, [hli] ; the status (ld keeps the flags of the cp)
	jr nz, .find
	ld e, a
	ld a, d
	push af ; the chance before the factors
	farcall AdjustStatusChance ; d = the chance with the factors (keeps e)
	pop af
	cp REALISM_FLOOR
	ret nc
	ld b, a ; the stages had taken it under the floor: a positive sum raises it, a negative one leaves it there
	ld a, d
	cp REALISM_FLOOR
	ret nz ; (a positive sum: at least one step above the floor)
	ld d, b
	ret

; The trainer AI's layer 1 (AIMoveChoiceModification1) calls this after its own rules: the realism factors' scores,
; then the habit's (AIHabitScores). Both leave alone a slot those rules scored useless or that the trainer cannot use
; (AI_SCORE_USELESS or more): a move refused before its roll has no hit chance to lower, and the useless tier keeps
; its own order. Clobbers every register.
AIHitChanceScores::
	call AIRealismScores
	jp AIHabitScores

; Each of the trainer's status moves (StatusMoveRealism) whose factors lower its hit chance on the player's #MON
; (the types the screen shows, its third by the species it looks like) gets +1: still the one chosen when the others
; score worse. A sum of 0 or more, nothing; a slot at AI_SCORE_USELESS or more, nothing (AIHitChanceScores). Nothing
; with the trainer's own LOCK-ON set (its moves skip the roll). MIRROR MOVE ranks as the move it would copy, the
; player's last, as in layer 1's own rules.
; Clobbers every register; hWhoseTurn is kept.
AIRealismScores:
	ld a, [wEnemyBattleStatus2]
	bit LOCKED_ON, a
	ret nz
	ldh a, [hWhoseTurn]
	push af
	ld a, 1
	ldh [hWhoseTurn], a ; the trainer's turn: the target, whose factors count, is the player's #MON
	ld hl, wEnemyMonMoves
	ld de, wBuffer ; the scores, one per slot, as layer 1 walks them
	ld b, NUM_MOVES
.loop
	ld a, [de]
	cp AI_SCORE_USELESS
	ld a, [hli] ; (ld keeps the flags of the cp)
	jr nc, .next ; useless, or not usable: left alone
	and a
	jr z, .done ; no more moves
	cp MIRROR_MOVE
	jr nz, .judge
	ld a, [wPlayerUsedMove] ; its copy
	and a
	jr z, .next ; nothing to copy
.judge
	push hl
	push de
	push bc
	call MoveEffectOf
	ld d, 50 percent ; a chance away from both limits: the sum of the factors alone moves it
	call RealismAccuracy
	ld a, d
	cp 50 percent
	pop bc
	pop de
	pop hl
	jr nc, .next ; not lowered (pop keeps the flags of the cp)
	ld a, [de]
	inc a
	ld [de], a
.next
	inc de
	dec b
	jr nz, .loop
.done
	pop af
	ldh [hWhoseTurn], a
	ret

; IN  a = a move (not 0). OUT a = its effect (the Moves table, in Battle Engine 6). Clobbers bc, hl.
MoveEffectOf:
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	jp GetFarByte
