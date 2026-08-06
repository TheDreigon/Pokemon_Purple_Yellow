; The accuracy roll and the burn/paralysis stat penalties.
;
; These came out of Battle Core, which was at its 16 KB ceiling, and they came
; here rather than anywhere else because this is where their callers are:
; MoveHitTest is called 8 times from effects.asm against 2 from core.asm, and
; the two Halve routines 13 times against 2. Moving them WITH the effects turns
; 21 would-be cross-bank calls back into local ones.
;
; CalcHitChance travels with MoveHitTest because MoveHitTest is its only caller.
; Neither of them ends up calling anything left behind in Battle Core:
; BattleRandom is in the home bank and Multiply/Divide always were, so nothing
; here pays a farcall at all.

MoveHitTest:
; player's turn
	ld hl, wEnemyBattleStatus1
	ld de, wPlayerMoveEffect
	ld bc, wEnemyMonStatus
	ldh a, [hWhoseTurn]
	and a
	jr z, .dreamEaterCheck
; enemy's turn
	ld hl, wPlayerBattleStatus1
	ld de, wEnemyMoveEffect
	ld bc, wBattleMonStatus
.dreamEaterCheck
	ld a, [de]
	cp DREAM_EATER_EFFECT
	jr nz, .swiftCheck
	ld a, [bc]
	and SLP_MASK
	jp z, .moveMissed
.swiftCheck
	ld a, [de]
	cp SWIFT_EFFECT
	ret z ; Swift never misses (this was fixed from the Japanese versions)
	call CheckTargetSubstitute ; substitute check (note that this overwrites a)
	jr z, .checkForDigOrFlyStatus
	ld a, [de]
	cp DRAIN_HP_EFFECT
	jp z, .moveMissed
	cp DREAM_EATER_EFFECT
	jp z, .moveMissed
.checkForDigOrFlyStatus
	bit INVULNERABLE, [hl]
	jp nz, .moveMissed
	ldh a, [hWhoseTurn]
	and a
	jr nz, .enemyTurn
.playerTurn
; v0.7 fix: Mist (Guard Spec.) may only block moves that do NOTHING but lower a
; stat. This test keys on the effect id alone, and in vanilla every effect in
; the blocked ranges belonged to a 0-BP status move — but the v0.5 "damage AND
; lower a stat" redesign attached those same effect ids to 17 DAMAGING moves
; (Hydro Pump, Fissure, Guillotine, Submission, Bulldoze, Sludge Wave, Acid,
; Take Down, ...). Without this power gate, a mon behind Mist was flatly immune
; to all of them: Prof. Oak carries Guard Spec. in his hard-mode bag, so once
; he used it the player's Hydro Pump could never land again — and the player
; could buy Guard Spec. in Celadon for the same free immunity.
	ld a, [wPlayerMovePower]
	and a
	jr nz, .skipEnemyMistCheck ; a damaging move is never Mist-blocked
; v0.7 FIX: the chart says PSYCHIC_TYPE has NO_EFFECT against DARK, but a 0-BP
; status move never reaches the damage path that applies the chart — so HYPNOSIS
; and DISABLE were landing on Dark-types regardless. Enforced here, on the
; 0-power path only, so damaging Psychic moves keep their own "doesn't affect".
	ld a, [wPlayerMoveType]
	cp PSYCHIC_TYPE
	jr nz, .playerPsychicOk
	ld a, [wEnemyMonType1]
	cp DARK
	jp z, .moveMissed ; jp, not jr: .moveMissed is ~160 bytes ahead from here
	ld a, [wEnemyMonType2]
	cp DARK
	jp z, .moveMissed
.playerPsychicOk
; this checks if the move effect is disallowed by mist
	ld a, [wPlayerMoveEffect]
	cp ATTACK_DOWN1_EFFECT
	jr c, .skipEnemyMistCheck
	cp HAZE_EFFECT + 1
	jr c, .enemyMistCheck
	cp ATTACK_DOWN2_EFFECT
	jr c, .skipEnemyMistCheck
	cp REFLECT_EFFECT + 1
	jr c, .enemyMistCheck
	jr .skipEnemyMistCheck
.enemyMistCheck
; if move effect is from $12 to $19 inclusive or $3a to $41 inclusive
; i.e. the following moves
; i.e. stat-lowering / status effects that Mist protection (Guard Spec.) blocks; effects handled via their own exclusive functions (Haze, Light Screen, Reflect, ...) never reach this check
	ld a, [wEnemyBattleStatus2]
	bit PROTECTED_BY_MIST, a ; is mon protected by mist?
	jp nz, .moveMissed
.skipEnemyMistCheck
	ld a, [wPlayerBattleStatus2]
	bit USING_X_ACCURACY, a ; is the player using X Accuracy?
	ret nz ; if so, always hit regardless of accuracy/evasion
	jr .calcHitChance
.enemyTurn
	ld a, [wEnemyMovePower] ; same power gate as the player turn — see above
	and a
	jr nz, .skipPlayerMistCheck
	ld a, [wEnemyMoveType] ; same PSYCHIC->DARK guard as the player turn
	cp PSYCHIC_TYPE
	jr nz, .enemyPsychicOk
	ld a, [wBattleMonType1]
	cp DARK
	jr z, .moveMissed
	ld a, [wBattleMonType2]
	cp DARK
	jr z, .moveMissed
.enemyPsychicOk
	ld a, [wEnemyMoveEffect]
	cp ATTACK_DOWN1_EFFECT
	jr c, .skipPlayerMistCheck
	cp HAZE_EFFECT + 1
	jr c, .playerMistCheck
	cp ATTACK_DOWN2_EFFECT
	jr c, .skipPlayerMistCheck
	cp REFLECT_EFFECT + 1
	jr c, .playerMistCheck
	jr .skipPlayerMistCheck
.playerMistCheck
; similar to enemy mist check
	ld a, [wPlayerBattleStatus2]
	bit PROTECTED_BY_MIST, a ; is mon protected by mist?
	jp nz, .moveMissed
.skipPlayerMistCheck
	ld a, [wEnemyBattleStatus2]
	bit USING_X_ACCURACY, a ; is the enemy using X Accuracy?
	ret nz ; if so, always hit regardless of accuracy/evasion
.calcHitChance
	call CalcHitChance ; scale the move accuracy according to attacker's accuracy and target's evasion
	ld a, [wPlayerMoveAccuracy]
	ld b, a
	ldh a, [hWhoseTurn]
	and a
	jr z, .doAccuracyCheck
	ld a, [wEnemyMoveAccuracy]
	ld b, a
.doAccuracyCheck
	; v0.7 hard mode boss accuracy edge (~±5pp = ±13/256). Applied
	; BEFORE the wDifficulty/.DontRemoveMiss check below, so the
	; existing 1/256 fix (which only runs in normal mode) sees the
	; ORIGINAL b in normal mode (we no-op there) and the boss-edged b
	; in hard mode (where the 1/256 fix is skipped anyway).
	; Player turn = player attacking boss → -5pp (harder to hit).
	; Enemy turn  = boss attacking player → +5pp (boss hits more).
	push bc                      ; preserve b (the accuracy value)
	farcall IsHardModeBossBattle
	pop bc
	jr z, .skipBossAccEdge
	ldh a, [hWhoseTurn]
	and a
	jr z, .bossAccPlayerTurn
	; enemy turn: b += 13, cap at $ff
	ld a, b
	add 13
	jr nc, .saveBossAcc
	ld a, $ff
	jr .saveBossAcc
.bossAccPlayerTurn
	; player turn: b -= 13, floor at 0
	ld a, b
	sub 13
	jr nc, .saveBossAcc
	xor a
.saveBossAcc
	ld b, a
.skipBossAccEdge
	ld a, [wDifficulty] ; Check if player is on hard mode
	and a
	jr nz, .DontRemoveMiss ; Keep 1/256 chance to miss on hard mode
	; The following snippet fixes 1/256 chance to miss on 100% accurate moves bug on normal mode
	ld a, b
	cp $FF ; Is the value $FF?
	ret z ; If so, we need not calculate, just so we can fix this bug.
.DontRemoveMiss
	call BattleRandom
	cp b
	jr nc, .moveMissed
	ret
.moveMissed
	xor a
	ld hl, wDamage ; zero the damage
	ld [hli], a
	ld [hl], a
; v0.7: say WHICH miss this was. b still holds the accuracy the roll was
; compared against, so b = $FF means the move could only have failed on the
; 1-in-256 -- the one Gen 1 quirk this game keeps on purpose, and only in hard
; mode (normal mode returns before the roll when b is $FF). Reporting that as
; "attack missed" told the player their 100%-accurate move was not.
; Written tightly because Battle Core is within a handful of bytes of its bank:
; a is already 0 here, b is dead after this point, and MOVE_FAILED/_EVADED are
; 1 and 2, so two incs do it.
	inc a ; a = MOVE_FAILED
	inc b ; $FF + 1 = 0, so Z means the accuracy was $FF
	jr nz, .gotFailureReason
	inc a ; a = MOVE_FAILED_EVADED
.gotFailureReason
	ld [wMoveMissed], a
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn2
.enemyTurn2
	ld hl, wEnemyBattleStatus1
	res USING_TRAPPING_MOVE, [hl] ; end multi-turn attack e.g. wrap
	ret
.playerTurn2
	ld hl, wPlayerBattleStatus1
	res USING_TRAPPING_MOVE, [hl] ; end multi-turn attack e.g. wrap
	ret

; values for player turn

CalcHitChance:
	ld hl, wPlayerMoveAccuracy
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMonAccuracyMod]
	ld b, a
	ld a, [wEnemyMonEvasionMod]
	ld c, a
	jr z, .next
; values for enemy turn
	ld hl, wEnemyMoveAccuracy
	ld a, [wEnemyMonAccuracyMod]
	ld b, a
	ld a, [wPlayerMonEvasionMod]
	ld c, a
.next
	ld a, $0e
	sub c
	ld c, a ; c = 14 - EVASIONMOD (this "reflects" the value over 7, so that an increase in the target's evasion
	       ; decreases the hit chance instead of increasing the hit chance)
; zero the high bytes of the multiplicand
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a ; set multiplicand to move accuracy
	push hl
	ld d, $02 ; loop has two iterations
; loop to do the calculations, the first iteration multiplies by the accuracy ratio and
; the second iteration multiplies by the evasion ratio
.loop
	push bc
	ld hl, AccuracyModifierRatios ; v0.7: acc/eva stages use their own modern (Gen 5+) 3/(3+n) curve
	dec b
	sla b
	ld c, b
	ld b, $00
	add hl, bc ; hl = address of stat modifier ratio
	pop bc
	ld a, [hli]
	ldh [hMultiplier], a ; set multiplier to the numerator of the ratio
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a ; set divisor to the the denominator of the ratio
	                 ; (the dividend is the product of the previous multiplication)
	ld b, $04 ; number of bytes in the dividend
	call Divide
	ldh a, [hQuotient + 3]
	ld b, a
	ldh a, [hQuotient + 2]
	or b
	jp nz, .nextCalculation
; make sure the result is always at least one
	ldh [hQuotient + 2], a
	ld a, $01
	ldh [hQuotient + 3], a
.nextCalculation
	ld b, c
	dec d
	jr nz, .loop
	ldh a, [hQuotient + 2]
	and a ; is the calculated hit chance over 0xFF?
	ldh a, [hQuotient + 3]
	jr z, .storeAccuracy
; if calculated hit chance over 0xFF
	ld a, $ff ; set the hit chance to 0xFF
.storeAccuracy
	pop hl
	ld [hl], a ; store the hit chance in the move accuracy variable
	ret

; multiplies damage by a random percentage from ~85% to 100%

HalveAttackDueToBurn:
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn
.enemyTurn ; halve the player's attack
	ld a, [wBattleMonStatus]
	and 1 << BRN
	ret z ; return if player not burnt
	ld hl, wBattleMonAttack + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storePlayerAttack
	ld b, 1 ; give the player a minimum of at least one attack point
.storePlayerAttack
	ld [hl], b
	ret
.playerTurn ; halve the enemy's attack
	ld a, [wEnemyMonStatus]
	and 1 << BRN
	ret z ; return if enemy not burnt
	ld hl, wEnemyMonAttack + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storeEnemyAttack
	ld b, 1 ; give the enemy a minimum of at least one attack point
.storeEnemyAttack
	ld [hl], b
	ret

HalveSpeedDueToParalysis:
; v0.7: was QuarterSpeedDueToParalysis (/ 4) — now halves (/ 2) per modern
; Pokemon (Gen 7+ behavior) and project owner's call. Rename + one less
; srl/rr pair per side. Behaviour: halve current speed if statused.
; (Idempotency caveat: still halves whatever's there — must only be called
; right after a recalc-from-unmodified, never on a stat that already had
; the penalty applied. See UpdateStatDone / UpdateLoweredStatDone in
; effects.asm and LoadBattleMonFromParty for the v0.7-correct call sites.)
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn
.enemyTurn ; halve the player's speed
	ld a, [wBattleMonStatus]
	and 1 << PAR
	ret z ; return if player not paralysed
	ld hl, wBattleMonSpeed + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storePlayerSpeed
	ld b, 1 ; give the player a minimum of at least one speed point
.storePlayerSpeed
	ld [hl], b
	ret
.playerTurn ; halve the enemy's speed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	ret z ; return if enemy not paralysed
	ld hl, wEnemyMonSpeed + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storeEnemySpeed
	ld b, 1 ; give the enemy a minimum of at least one speed point
.storeEnemySpeed
	ld [hl], b
	ret

; HalveAttackDueToBurn moved to engine/battle/hit_and_penalties.asm ("Battle Effects" section).
