_JumpMoveEffect:
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .next1
	ld a, [wEnemyMoveEffect]
.next1
	dec a ; subtract 1, there is no special effect for 00
	add a ; x2, 16bit pointers
	ld hl, MoveEffectPointerTable
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to special effect handler

INCLUDE "data/moves/effects_pointers.asm"

SleepEffect:
	ld de, wEnemyMonStatus
	ld bc, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jp z, .sleepEffect
	ld de, wBattleMonStatus
	ld bc, wPlayerBattleStatus2

.sleepEffect
	ld a, [bc]
	bit NEEDS_TO_RECHARGE, a ; does the target need to recharge? (hyper beam)
	res NEEDS_TO_RECHARGE, a ; target no longer needs to recharge
	ld [bc], a
	jr nz, .setSleepCounter ; if the target had to recharge, all hit tests will be skipped
	                        ; including the event where the target already has another status
	ld a, [de]
	ld b, a
	and $7
	jr z, .notAlreadySleeping ; can't affect a mon that is already asleep
	ld hl, AlreadyAsleepText
	jp PrintText
.notAlreadySleeping
	ld a, b
	and a
	jr nz, .didntAffect ; can't affect a mon that is already statused
	push de
	call MoveHitTest ; apply accuracy tests
	pop de
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
.setSleepCounter
; PURPLE YELLOW v0.5: sleep lasts 2-5 turns (was 1-7 with Stadium override to 1-3).
	call BattleRandom
	and $3   ; 0-3
	add 2    ; 2-5
	ld b, a
.asm_3f1ba
	ld a, b
	ld [de], a
	call PlayCurrentMoveAnimation2
	ld hl, FellAsleepText
	jp PrintText
.didntAffect
	jp PrintDidntAffectText

FellAsleepText:
	text_far _FellAsleepText
	text_end

AlreadyAsleepText:
	text_far _AlreadyAsleepText
	text_end

PoisonEffect:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .poisonEffect
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveEffect
.poisonEffect
	call CheckTargetSubstitute
	jr nz, .noEffect ; can't poison a substitute target
	ld a, [hli]
	ld b, a
	and a
	jr nz, .noEffect ; miss if target is already statused
	ld a, [hli]
	cp POISON ; can't poison a poison-type target
	jr z, .noEffect
	cp STEEL ; v0.7: can't poison a steel-type target either
	jr z, .noEffect
	ld a, [hld]
	cp POISON ; can't poison a poison-type target
	jr z, .noEffect
	cp STEEL ; v0.7
	jr z, .noEffect
	ld a, [de]
	cp POISON_SIDE_EFFECT1
	ld b, 15 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT2
	ld b, 30 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT3
	ld b, 45 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	push hl
	push de
	call MoveHitTest ; apply accuracy tests
	pop de
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	jr .inflictPoison
.sideEffectTest
	call BattleRandom
	cp b ; was side effect successful?
	ret nc
.inflictPoison
	dec hl
	set PSN, [hl]
	push de
	dec de
	ldh a, [hWhoseTurn]
	and a
	ld b, SHAKE_SCREEN_ANIM
	ld hl, wPlayerBattleStatus3
	ld a, [de]
	ld de, wPlayerToxicCounter
	jr nz, .ok
	ld b, ENEMY_HUD_SHAKE_ANIM
	ld hl, wEnemyBattleStatus3
	ld de, wEnemyToxicCounter
.ok
	cp TOXIC
	jr nz, .normalPoison ; done if move is not Toxic
	set BADLY_POISONED, [hl] ; else set Toxic battstatus
	xor a
	ld [de], a
	ld hl, BadlyPoisonedText
	jr .continue
.normalPoison
	ld hl, PoisonedText
.continue
	pop de
	ld a, [de]
	cp POISON_EFFECT
	jr z, .regularPoisonEffect
	ld a, b ; SHAKE_SCREEN_ANIM or ENEMY_HUD_SHAKE_ANIM - both specials
	call PlaySpecialBattleAnimation2
	jp PrintText
.regularPoisonEffect
	call PlayCurrentMoveAnimation2
	jp PrintText
.noEffect
	ld a, [de]
	cp POISON_EFFECT
	ret nz
.didntAffect
	ld c, 50
	call DelayFrames
	jp PrintDidntAffectText

PoisonedText:
	text_far _PoisonedText
	text_end

BadlyPoisonedText:
	text_far _BadlyPoisonedText
	text_end

DrainHPEffect:
	jpfar DrainHPEffect_

ExplodeEffect:
	ld hl, wBattleMonHP
	ld de, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .faintUser
	ld hl, wEnemyMonHP
	ld de, wEnemyBattleStatus2
.faintUser
	xor a
	ld [hli], a ; set the mon's HP to 0
	ld [hli], a
	inc hl
	ld [hl], a ; set mon's status to 0
	ld a, [de]
	res SEEDED, a ; clear mon's leech seed status
	ld [de], a
	ret

FreezeBurnParalyzeEffect:
; v0.7 type-immunity refactor:
;   - Removed vanilla "if move type == defender type, status fails" check.
;     That check was the famous Gen 1 bug that made Body Slam (Normal)
;     unable to paralyze Normal-types, while ALSO failing to give Fire/
;     Magma/Ice the immunities they should logically have to other-type
;     burn/freeze sources.
;   - Replaced with proper per-status defender-type immunity (checked
;     inside each .burn/.freeze/.paralyze handler):
;        Burn  immune: defender is FIRE or MAGMA
;        Freeze immune: defender is ICE or MAGMA
;        Paralyze immune: defender is ELECTRIC
;   - Poison immune: defender is POISON or STEEL (POISON was vanilla-correct in PoisonEffect; STEEL added in v0.7).
	xor a
	ld [wAnimationType], a
	call CheckTargetSubstitute ; call CheckTargetSubstitute ; test the HAS_SUBSTITUTE_UP bit of the defender's BattleStatus2
	ret nz ; return if they have a substitute, can't effect them
	ldh a, [hWhoseTurn]
	and a
	jp nz, .opponentAttacker
	ld a, [wEnemyMonStatus]
	and a
	jp nz, CheckDefrost ; can't inflict status if opponent is already statused
	ld a, [wPlayerMoveEffect]
	cp FREEZE_SIDE_EFFECT2 ; cp FREEZE_SIDE_EFFECT2 ; 30% freeze chance (Frost Breath, Blizzard)
	jr nz, .asm_3f2c7
	ld b, 30 percent + 1
	ld a, FREEZE_SIDE_EFFECT1 ; map to _1 variant for the dispatch below
	jr .regular_effectiveness
.asm_3f2c7
	cp PARALYZE_SIDE_EFFECT3 ; cp PARALYZE_SIDE_EFFECT3 ; v0.7: 45% paralyze tier (Nuzzle, Mind Break)
	jr nz, .burnTier3
	ld b, 45 percent + 1
	ld a, PARALYZE_SIDE_EFFECT1 ; map to _1 variant for the dispatch below
	jr .regular_effectiveness
.burnTier3
	cp BURN_SIDE_EFFECT3 ; v0.7: 45% burn tier (Lava Plume)
	jr nz, .tierLadder
	ld b, 45 percent + 1
	ld a, BURN_SIDE_EFFECT1 ; map to _1 variant for the dispatch below
	jr .regular_effectiveness
.tierLadder
	cp PARALYZE_SIDE_EFFECT1 + 1
	ld b, 15 percent + 1 ; _SIDE_EFFECT1 tier: 15%
	jr c, .regular_effectiveness
; extra effectiveness
	ld b, 30 percent + 1
	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
.regular_effectiveness
	push af
	call BattleRandom ; get random 8bit value for probability test
	cp b
	pop bc
	ret nc ; ret nc ; no status if random value >= the tier threshold in b ($27/$4D/$73 for the 15/30/45% tiers)
	ld a, b ; what type of effect is this?
	cp BURN_SIDE_EFFECT1
	jr z, .burn1
	cp FREEZE_SIDE_EFFECT1
	jr z, .freeze1
; .paralyze1
	; v0.7: ELECTRIC defenders are immune to paralysis (any source).
	ld a, [wEnemyMonType1]
	cp ELECTRIC
	ret z
	ld a, [wEnemyMonType2]
	cp ELECTRIC
	ret z
	; v0.7: GROUND defenders are immune to ELECTRIC moves entirely, so
	; the paralyze side-effect of Electric attacks (Thundershock, etc.)
	; doesn't apply to them. Non-Electric paralyze moves (Body Slam,
	; Lick, ...) still affect Ground-types — they're only immune to
	; Electric, not to paralysis in general.
	ld a, [wPlayerMoveType]
	cp ELECTRIC
	jr nz, .applyParalyze1
	ld a, [wEnemyMonType1]
	cp GROUND
	ret z
	ld a, [wEnemyMonType2]
	cp GROUND
	ret z
.applyParalyze1
	ld a, 1 << PAR
	ld [wEnemyMonStatus], a
	call HalveSpeedDueToParalysis ; halve speed of affected mon
	ld a, ENEMY_HUD_SHAKE_ANIM
	call PlaySpecialBattleAnimation
	jp PrintMayNotAttackText ; print paralysis text
.burn1
	; v0.7: FIRE and MAGMA defenders are immune to burn.
	ld a, [wEnemyMonType1]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, [wEnemyMonType2]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, 1 << BRN
	ld [wEnemyMonStatus], a
	call HalveAttackDueToBurn ; halve attack of affected mon
	ld a, ENEMY_HUD_SHAKE_ANIM
	call PlaySpecialBattleAnimation
	ld hl, BurnedText
	jp PrintText
.freeze1
	; v0.7: ICE and MAGMA defenders are immune to freeze.
	ld a, [wEnemyMonType1]
	cp ICE
	ret z
	cp MAGMA
	ret z
	ld a, [wEnemyMonType2]
	cp ICE
	ret z
	cp MAGMA
	ret z
	call ClearHyperBeam ; resets hyper beam (recharge) condition from target
	ld a, 1 << FRZ
	ld [wEnemyMonStatus], a
	; PURPLE YELLOW v0.5: freeze-turn counter 3-6.
	call BattleRandom
	and $3
	add 3
	ld [wEnemyFreezeCounter], a
	ld a, ENEMY_HUD_SHAKE_ANIM
	call PlaySpecialBattleAnimation
	ld hl, FrozenText
	jp PrintText
.opponentAttacker
	ld a, [wBattleMonStatus] ; mostly same as above with addresses swapped for opponent
	and a
	jp nz, CheckDefrost
	ld a, [wEnemyMoveEffect]
	cp FREEZE_SIDE_EFFECT2 ; cp FREEZE_SIDE_EFFECT2 ; 30% freeze chance (Frost Breath, Blizzard)
	jr nz, .asm_3f341
	ld b, 30 percent + 1
	ld a, FREEZE_SIDE_EFFECT1 ; map to _1 variant for the dispatch below
	jr .regular_effectiveness2
.asm_3f341
	cp PARALYZE_SIDE_EFFECT3 ; cp PARALYZE_SIDE_EFFECT3 ; v0.7: 45% paralyze tier (Nuzzle, Mind Break)
	jr nz, .burnTier3_2
	ld b, 45 percent + 1
	ld a, PARALYZE_SIDE_EFFECT1 ; map to _1 variant for the dispatch below
	jr .regular_effectiveness2
.burnTier3_2
	cp BURN_SIDE_EFFECT3 ; v0.7: 45% burn tier (Lava Plume)
	jr nz, .tierLadder2
	ld b, 45 percent + 1
	ld a, BURN_SIDE_EFFECT1 ; map to _1 variant for the dispatch below
	jr .regular_effectiveness2
.tierLadder2
	cp PARALYZE_SIDE_EFFECT1 + 1
	ld b, 15 percent + 1 ; _SIDE_EFFECT1 tier: 15%
	jr c, .regular_effectiveness2
; extra effectiveness
	ld b, 30 percent + 1
	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
.regular_effectiveness2
	push af
	call BattleRandom
	cp b
	pop bc
	ret nc
	ld a, b
	cp BURN_SIDE_EFFECT1
	jr z, .burn2
	cp FREEZE_SIDE_EFFECT1
	jr z, .freeze2
; .paralyze2
	; v0.7: ELECTRIC defenders are immune to paralysis (any source).
	ld a, [wBattleMonType1]
	cp ELECTRIC
	ret z
	ld a, [wBattleMonType2]
	cp ELECTRIC
	ret z
	; v0.7: GROUND defenders are immune to ELECTRIC moves entirely
	; (player side; mirror of .paralyze1).
	ld a, [wEnemyMoveType]
	cp ELECTRIC
	jr nz, .applyParalyze2
	ld a, [wBattleMonType1]
	cp GROUND
	ret z
	ld a, [wBattleMonType2]
	cp GROUND
	ret z
.applyParalyze2
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	call HalveSpeedDueToParalysis
	ld a, SHAKE_SCREEN_ANIM
	call PlaySpecialBattleAnimation2
	jp PrintMayNotAttackText
.burn2
	; v0.7: FIRE and MAGMA defenders are immune to burn (player side).
	ld a, [wBattleMonType1]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, [wBattleMonType2]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, 1 << BRN
	ld [wBattleMonStatus], a
	call HalveAttackDueToBurn
	ld a, SHAKE_SCREEN_ANIM
	call PlaySpecialBattleAnimation2
	ld hl, BurnedText
	jp PrintText
.freeze2
	; v0.7: ICE and MAGMA defenders are immune to freeze (player side).
	ld a, [wBattleMonType1]
	cp ICE
	ret z
	cp MAGMA
	ret z
	ld a, [wBattleMonType2]
	cp ICE
	ret z
	cp MAGMA
	ret z
	call ClearHyperBeam
	ld a, 1 << FRZ
	ld [wBattleMonStatus], a
	; PURPLE YELLOW v0.5: freeze-turn counter 3-6.
	call BattleRandom
	and $3
	add 3
	ld [wPlayerFreezeCounter], a
	ld a, SHAKE_SCREEN_ANIM
	call PlaySpecialBattleAnimation2
	ld hl, FrozenText
	jp PrintText

BurnedText:
	text_far _BurnedText
	text_end

FrozenText:
	text_far _FrozenText
	text_end


; v0.7: Tri Attack new effect.
; ~30% total chance to inflict a random status on the target —
; 10% paralyze, 10% burn, 10% freeze (30% first roll, 1/3 split second).
; v0.7 type-status immunities apply (same set as FreezeBurnParalyzeEffect):
; burn -> FIRE/MAGMA immune; freeze -> ICE/MAGMA immune;
; paralyze -> ELECTRIC immune.
; Substitute blocks all status. Already-statused targets are skipped.
TriStatusSideEffect:
	xor a
	ld [wAnimationType], a
	call CheckTargetSubstitute
	ret nz                                ; substitute blocks
	; First roll: any status at all? (~30%)
	call BattleRandom
	cp 30 percent + 1
	ret nc
	; Second roll: which status? (1/3 split → ~10% each)
	call BattleRandom
	cp 33 percent + 1
	jp c, .triParalyze
	cp 67 percent
	jp c, .triBurn
	; else: freeze
.triFreeze
	ldh a, [hWhoseTurn]
	and a
	jp z, .freezeEnemy
	jp .freezeBattle
.triBurn
	ldh a, [hWhoseTurn]
	and a
	jp z, .burnEnemy
	jp .burnBattle
.triParalyze
	ldh a, [hWhoseTurn]
	and a
	jp z, .paralyzeEnemy
	jp .paralyzeBattle

; ===== Player attacking enemy =====
.paralyzeEnemy
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	; v0.7: ELECTRIC defenders are immune to paralysis.
	ld a, [wEnemyMonType1]
	cp ELECTRIC
	ret z
	ld a, [wEnemyMonType2]
	cp ELECTRIC
	ret z
	ld a, 1 << PAR
	ld [wEnemyMonStatus], a
	call HalveSpeedDueToParalysis
	ld a, ENEMY_HUD_SHAKE_ANIM
	call PlaySpecialBattleAnimation
	jp PrintMayNotAttackText

.burnEnemy
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	; v0.7: FIRE and MAGMA defenders are immune to burn.
	ld a, [wEnemyMonType1]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, [wEnemyMonType2]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, 1 << BRN
	ld [wEnemyMonStatus], a
	call HalveAttackDueToBurn
	ld a, ENEMY_HUD_SHAKE_ANIM
	call PlaySpecialBattleAnimation
	ld hl, BurnedText
	jp PrintText

.freezeEnemy
	ld a, [wEnemyMonStatus]
	and a
	jp nz, CheckDefrost
	; v0.7: ICE and MAGMA defenders are immune to freeze.
	ld a, [wEnemyMonType1]
	cp ICE
	ret z
	cp MAGMA
	ret z
	ld a, [wEnemyMonType2]
	cp ICE
	ret z
	cp MAGMA
	ret z
	call ClearHyperBeam
	ld a, 1 << FRZ
	ld [wEnemyMonStatus], a
	call BattleRandom
	and $3
	add 3
	ld [wEnemyFreezeCounter], a
	ld a, ENEMY_HUD_SHAKE_ANIM
	call PlaySpecialBattleAnimation
	ld hl, FrozenText
	jp PrintText

; ===== Enemy attacking player =====
.paralyzeBattle
	ld a, [wBattleMonStatus]
	and a
	ret nz
	; v0.7: ELECTRIC defenders are immune to paralysis.
	ld a, [wBattleMonType1]
	cp ELECTRIC
	ret z
	ld a, [wBattleMonType2]
	cp ELECTRIC
	ret z
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	call HalveSpeedDueToParalysis
	ld a, SHAKE_SCREEN_ANIM
	call PlaySpecialBattleAnimation2
	jp PrintMayNotAttackText

.burnBattle
	ld a, [wBattleMonStatus]
	and a
	ret nz
	; v0.7: FIRE and MAGMA defenders are immune to burn.
	ld a, [wBattleMonType1]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, [wBattleMonType2]
	cp FIRE
	ret z
	cp MAGMA
	ret z
	ld a, 1 << BRN
	ld [wBattleMonStatus], a
	call HalveAttackDueToBurn
	ld a, SHAKE_SCREEN_ANIM
	call PlaySpecialBattleAnimation2
	ld hl, BurnedText
	jp PrintText

.freezeBattle
	ld a, [wBattleMonStatus]
	and a
	jp nz, CheckDefrost
	; v0.7: ICE and MAGMA defenders are immune to freeze.
	ld a, [wBattleMonType1]
	cp ICE
	ret z
	cp MAGMA
	ret z
	ld a, [wBattleMonType2]
	cp ICE
	ret z
	cp MAGMA
	ret z
	call ClearHyperBeam
	ld a, 1 << FRZ
	ld [wBattleMonStatus], a
	call BattleRandom
	and $3
	add 3
	ld [wPlayerFreezeCounter], a
	ld a, SHAKE_SCREEN_ANIM
	call PlaySpecialBattleAnimation2
	ld hl, FrozenText
	jp PrintText

DefrostTargetIfFireOrMagma::
; v0.7: ANY damaging FIRE or MAGMA move thaws a frozen target.
;
; CheckDefrost below is only reached from the burn/freeze/paralyze side-effect
; handlers, so before this only the five Fire/Magma moves carrying such an effect
; defrosted (EMBER, FLAMETHROWER, FIRE_BLAST, MAGMA_PUNCH, LAVA_PLUME) while
; FLAME_CHARGE, FLAME_BURST and EXPLOSION left the target frozen -- a rule with
; four exceptions nobody could reasonably learn. Called from the post-hit path in
; core.asm for both sides.
;
; CheckDefrost is safe to call blind: it returns immediately unless the defender
; is frozen AND the move's type is FIRE or MAGMA. It just wants the defender's
; status in a.
	ldh a, [hWhoseTurn]
	and a
	ld a, [wEnemyMonStatus] ; ld does not touch flags, so the jr below still
	jr z, .gotStatus        ; tests hWhoseTurn: 0 = player attacking
	ld a, [wBattleMonStatus]
.gotStatus
	; fallthrough

CheckDefrost:
; a Fire- or Magma-type move with a burn/freeze/paralyze side effect defrosts a frozen target (pure-status IGNITE and other Fire/Magma effects never reach this path)
	and 1 << FRZ ; are they frozen?
	ret z ; return if so
	ldh a, [hWhoseTurn]
	and a
	jr nz, .opponent
	;player [attacker]
	ld a, [wPlayerMoveType]
	cp FIRE
	jr z, .playerDefrosts
	cp MAGMA ; PURPLE YELLOW v0.5: Magma-type moves also defrost
	ret nz
.playerDefrosts
	xor a
	ld [wEnemyMonStatus], a ; set opponent status to 00 ["defrost" a frozen monster]
	ld hl, wEnemyMon1Status
	ld a, [wEnemyMonPartyPos]
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl], a ; clear status in roster
	ld hl, FireDefrostedText
	jr .common
.opponent
	ld a, [wEnemyMoveType] ; same as above with addresses swapped
	cp FIRE
	jr z, .enemyDefrosts
	cp MAGMA ; PURPLE YELLOW v0.5: Magma-type moves also defrost
	ret nz
.enemyDefrosts
	xor a
	ld [wBattleMonStatus], a
	ld hl, wPartyMon1Status
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	xor a
	ld [hl], a
	ld hl, FireDefrostedText
.common
	jp PrintText

FireDefrostedText:
	text_far _FireDefrostedText
	text_end

StatModifierUpEffect::
	ld hl, wPlayerMonStatMods
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .statModifierUpEffect
	ld hl, wEnemyMonStatMods
	ld de, wEnemyMoveEffect
.statModifierUpEffect
	ld a, [de]
	sub ATTACK_UP1_EFFECT
	cp EVASION_UP1_EFFECT + $3 - ATTACK_UP1_EFFECT ; covers all +1 effects
	jr c, .incrementStatMod
	sub ATTACK_UP2_EFFECT - ATTACK_UP1_EFFECT ; map +2 effects to equivalent +1 effect
.incrementStatMod
	ld c, a
	ld b, $0
	add hl, bc
	ld b, [hl]
	inc b ; increment corresponding stat mod
	ld a, $d
	cp b ; can't raise stat past +6 ($d or 13)
	jp c, PrintStatWontGoHigherText ; v0.7: named text instead of "Nothing happened!"
	ld a, [de]
	cp ATTACK_UP1_EFFECT + $8 ; is it a +2 effect?
	jr c, .ok
	inc b ; if so, increment stat mod again
	ld a, $d
	cp b ; unless it's already +6
	jr nc, .ok
	ld b, a
.ok
	ld [hl], b
	ld a, c
	cp $4
	jr nc, UpdateStatDone ; jump if mod affected is evasion/accuracy
	push hl
	ld hl, wBattleMonAttack + 1
	ld de, wPlayerMonUnmodifiedAttack
	ldh a, [hWhoseTurn]
	and a
	jr z, .pointToStats
	ld hl, wEnemyMonAttack + 1
	ld de, wEnemyMonUnmodifiedAttack
.pointToStats
	push bc
	sla c
	ld b, $0
	add hl, bc ; hl = modified stat
	ld a, c
	add e
	ld e, a
	jr nc, .checkIf999
	inc d ; de = unmodified (original) stat
.checkIf999
	pop bc
	; check if stat is already 999
	ld a, [hld]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .recalculateStat
	ld a, [hl]
	sbc HIGH(MAX_STAT_VALUE)
	jp z, RestoreOriginalStatModifier
.recalculateStat ; recalculate affected stat
                 ; paralysis and burn penalties are ignored here (selectively re-applied after the text below); badge boosts are baked into the unmodified stats (v0.7) so they carry through
	push hl
	push bc
	ld hl, StatModifierRatios
	dec b
	sla b
	ld c, b
	ld b, $0
	add hl, bc
	pop bc
	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a
	ld b, $4
	call Divide
	pop hl
; cap at MAX_STAT_VALUE (999)
	ldh a, [hProduct + 3]
	sub LOW(MAX_STAT_VALUE)
	ldh a, [hProduct + 2]
	sbc HIGH(MAX_STAT_VALUE)
	jp c, UpdateStat
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hMultiplicand + 1], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hMultiplicand + 2], a

UpdateStat:
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
UpdateStatDone:
	ld b, c
	inc b
	; v0.7 burn/para reapplication fix: stash the recalc'd stat index so
	; the post-PrintText block knows which stat (and therefore which
	; status penalty, if any) to re-apply. wd11e is short-lived scratch.
	ld a, c
	ld [wd11e], a
	call PrintStatText
	; MINIMIZE was removed from the movelist; vanilla's substitute-hiding
	; special case for it is gone.
	ld a, [wMoveDidntMiss]
	and a
	jr nz, .skipUpAnim ; damage already played the animation, or dual-stat second leg
	call PlayCurrentMoveAnimation
.skipUpAnim
.applyBadgeBoostsAndStatusPenalties
	; v0.7 Badge Boost Glitch fix: vanilla called ApplyBadgeStatBoosts here
	; on every player stat-up, compounding badges by 1.125x each time.
	; Badges are now baked into wPlayerMonUnmodifiedStats at LoadBattleMonFromParty
	; (see core.asm), so stat recalcs naturally preserve them — no need
	; to re-apply on top.
	ld hl, MonsStatsRoseText
	call PrintText
	; v0.7 burn/para reapplication fix: vanilla called HalveSpeed +
	; HalveAttack on the OPPOSITE side here, on stats that hadn't been
	; recalc'd, causing penalty compounding (similar to badge glitch).
	; Replaced with a selective reapply: only the stat just recalc'd, and
	; only on the USER (whose stat changed during stat-up). Flip
	; hWhoseTurn temporarily because Halve* dispatch targets opposite of
	; hWhoseTurn (vanilla convention).
	ld a, [wd11e]                       ; retrieve recalc'd stat index
	ld c, a
	ldh a, [hWhoseTurn]
	push af
	xor 1
	ldh [hWhoseTurn], a
	ld a, c
	cp 0                                ; was attack the changed stat?
	call z, HalveAttackDueToBurn        ; if so & user is burnt, halve it
	ld a, c
	cp 2                                ; was speed the changed stat?
	call z, HalveSpeedDueToParalysis    ; if so & user is paralyzed, halve it
	pop af
	ldh [hWhoseTurn], a
	ret

RestoreOriginalStatModifier:
	pop hl
	dec [hl]

PrintNothingHappenedText:
	ld hl, NothingHappenedText
	jp PrintText

; v0.7: stat capped at +6 — print "<USER>'s <STAT> won't go any higher!".
; Expects c = 0-based stat index (live at the StatModifierUpEffect call site);
; PrintStatText consumes b = c+1 and copies the stat name to wStringBuffer.
PrintStatWontGoHigherText:
	ld b, c
	inc b
	call PrintStatText
	ld hl, StatWontGoHigherText
	jp PrintText

MonsStatsRoseText:
	text_far _MonsStatsRoseText
	text_asm
	ld hl, GreatlyRoseText
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
	cp ATTACK_DOWN1_EFFECT
	ret nc
	ld hl, RoseText
	ret

GreatlyRoseText:
	text_pause
	text_far _GreatlyRoseText
; fallthrough
RoseText:
	text_far _RoseText
	text_end

StatModifierDownEffect:
	ld hl, wEnemyMonStatMods
	ld de, wPlayerMoveEffect
	ld bc, wEnemyBattleStatus1
	ldh a, [hWhoseTurn]
	and a
	jr z, .statModifierDownEffect
	ld hl, wPlayerMonStatMods
	ld de, wEnemyMoveEffect
	ld bc, wPlayerBattleStatus1
.statModifierDownEffect
	call CheckTargetSubstitute ; can't hit through substitute
	jp nz, MoveMissed
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT
	jr c, .nonSideEffect
; v0.7 T17 (Forte, 2026-08-31): MIST / GUARD SPEC. also shield against the
; stat drops that ride on damaging moves (SURF, CRUNCH, ~31 moves). The
; damage has already landed; a protected target just keeps its stage,
; silently - CantLowerAnymore returns without text for side effects,
; exactly like a failed 33% roll. Power-0 stat moves were already blocked
; upstream in MoveHitTest (all 19, spoofed ids included - see the T17
; note); this is the other half.
	inc bc
	ld a, [bc] ; the DEFENDER's w*BattleStatus2
	dec bc
	bit PROTECTED_BY_MIST, a
	jp nz, CantLowerAnymore
	call BattleRandom
	cp 33 percent + 1 ; chance for side effects
	jp nc, CantLowerAnymore
	ld a, [de]
	sub ATTACK_DOWN_SIDE_EFFECT ; map each stat to 0-3
	jr .decrementStatMod
.nonSideEffect ; non-side effects only
	push hl
	push de
	push bc
	call MoveHitTest ; apply accuracy tests
	pop bc
	pop de
	pop hl
	ld a, [wMoveMissed]
	and a
	jp nz, MoveMissed
	ld a, [bc]
	bit INVULNERABLE, a ; fly/dig
	jp nz, MoveMissed
	ld a, [de]
	sub ATTACK_DOWN1_EFFECT
	cp EVASION_DOWN1_EFFECT + $3 - ATTACK_DOWN1_EFFECT ; covers all -1 effects
	jr c, .decrementStatMod
	sub ATTACK_DOWN2_EFFECT - ATTACK_DOWN1_EFFECT ; map -2 effects to corresponding -1 effect
.decrementStatMod
	ld c, a
	ld b, $0
	add hl, bc
	ld b, [hl]
	dec b ; dec corresponding stat mod
	jp z, CantLowerAnymore ; if stat mod is 1 (-6), can't lower anymore
	ld a, [de]
	cp ATTACK_DOWN2_EFFECT - $16 ; $24
	jr c, .ok
	cp EVASION_DOWN2_EFFECT + $5 ; $44
	jr nc, .ok
	dec b ; stat down 2 effects only (dec mod again)
	jr nz, .ok
	inc b ; increment mod to 1 (-6) if it would become 0 (-7)
.ok
	ld [hl], b ; save modified mod
	ld a, c
	cp $4
	jr nc, UpdateLoweredStatDone ; jump for evasion/accuracy
	push hl
	push de
	ld hl, wEnemyMonAttack + 1
	ld de, wEnemyMonUnmodifiedAttack
	ldh a, [hWhoseTurn]
	and a
	jr z, .pointToStat
	ld hl, wBattleMonAttack + 1
	ld de, wPlayerMonUnmodifiedAttack
.pointToStat
	push bc
	sla c
	ld b, $0
	add hl, bc ; hl = modified stat
	ld a, c
	add e
	ld e, a
	jr nc, .noCarry
	inc d ; de = unmodified stat
.noCarry
	pop bc
	ld a, [hld]
	sub $1 ; can't lower stat below 1 (-6)
	jr nz, .recalculateStat
	ld a, [hl]
	and a
	jp z, CantLowerAnymore_Pop
.recalculateStat
; recalculate affected stat
; paralysis and burn penalties are ignored here (selectively re-applied after the text below); badge boosts are baked into the player's unmodified stats (v0.7) so they carry through
	push hl
	push bc
	ld hl, StatModifierRatios
	dec b
	sla b
	ld c, b
	ld b, $0
	add hl, bc
	pop bc
	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a
	ld b, $4
	call Divide
	pop hl
	ldh a, [hProduct + 3]
	ld b, a
	ldh a, [hProduct + 2]
	or b
	jp nz, UpdateLoweredStat
	ldh [hMultiplicand + 1], a
	ld a, $1
	ldh [hMultiplicand + 2], a

UpdateLoweredStat:
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop de
	pop hl
UpdateLoweredStatDone:
	ld b, c
	inc b
	; v0.7 burn/para reapplication fix: stash the recalc'd stat index
	; for the selective penalty re-apply below.
	ld a, c
	ld [wd11e], a
	push de
	call PrintStatText
	pop de
	ld a, [wMoveDidntMiss]
	and a
	jr nz, .ApplyBadgeBoostsAndStatusPenalties ; v0.5: damage already played anim, or dual-stat second leg
	ld a, [de]
	cp $44
	jr nc, .ApplyBadgeBoostsAndStatusPenalties
	call PlayCurrentMoveAnimation2
.ApplyBadgeBoostsAndStatusPenalties
	; v0.7 Badge Boost Glitch fix: removed ApplyBadgeStatBoosts call here
	; (the enemy-stat-down counterpart of the bug above). Same reasoning:
	; badges are baked into unmodified stats at LoadBattleMonFromParty.
	ld hl, MonsStatsFellText
	call PrintText
	; v0.7 burn/para reapplication fix: vanilla called HalveSpeed +
	; HalveAttack here regardless of which stat was just modified, often
	; on stats that hadn't been recalc'd, causing penalty compounding.
	; Remove just this sentence; keep the rest of the block.
	; selective reapply: only the stat just recalc'd, on the TARGET (which
	; is already opposite-of-hWhoseTurn — the existing dispatch direction).
	ld a, [wd11e]                       ; retrieve recalc'd stat index
	ld c, a
	cp 0                                ; was attack the changed stat?
	call z, HalveAttackDueToBurn        ; if so & target is burnt, halve it
	ld a, c
	cp 2                                ; was speed the changed stat?
	call z, HalveSpeedDueToParalysis    ; if so & target is paralyzed, halve it
	ret

CantLowerAnymore_Pop:
	pop de
	pop hl
	inc [hl]

CantLowerAnymore:
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT
	ret nc
	; v0.7: named text instead of "Nothing happened!". c = 0-based stat
	; index — live on both printing paths here (set at .decrementStatMod;
	; restored by `pop bc` before the CantLowerAnymore_Pop path).
	ld b, c
	inc b
	call PrintStatText
	ld hl, StatWontGoLowerText
	jp PrintText

MoveMissed:
	ld a, [de]
	cp $44
	ret nc
	jp ConditionalPrintButItFailed

MonsStatsFellText:
	text_far _MonsStatsFellText
	text_asm
	ld hl, FellText
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
; check if the move's effect decreases a stat by 2
	cp BIDE_EFFECT
	ret c
	cp ATTACK_DOWN_SIDE_EFFECT
	ret nc
	ld hl, GreatlyFellText
	ret

GreatlyFellText:
	text_pause
	text_far _GreatlyFellText
; fallthrough
FellText:
	text_far _FellText
	text_end

PrintStatText:
	ld hl, StatModTextStrings
	ld c, "@"
.findStatName_outer
	dec b
	jr z, .foundStatName
.findStatName_inner
	ld a, [hli]
	cp c
	jr z, .findStatName_outer
	jr .findStatName_inner
.foundStatName
	ld de, wStringBuffer
	ld bc, $a
	jp CopyData

INCLUDE "data/battle/stat_mod_names.asm"

INCLUDE "data/battle/stat_modifiers.asm"

BideEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerBideAccumulatedDamage
	ld bc, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .bideEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyBideAccumulatedDamage
	ld bc, wEnemyNumAttacksLeft
.bideEffect
	set STORING_ENERGY, [hl] ; mon is now using bide
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld [wPlayerMoveEffect], a
	ld [wEnemyMoveEffect], a
	call BattleRandom
	and $1
	inc a
	inc a
	ld [bc], a ; set Bide counter to 2 or 3 at random
	ldh a, [hWhoseTurn]
	add XSTATITEM_ANIM ; +turn picks the player/enemy twin
	jp PlaySpecialBattleAnimation2

ThrashPetalDanceEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .thrashPetalDanceEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
.thrashPetalDanceEffect
	set THRASHING_ABOUT, [hl] ; mon is now using thrash/petal dance
	call BattleRandom
	and $1
	inc a
	inc a
	ld [de], a ; set thrash/petal dance counter to 2 or 3 at random
	ldh a, [hWhoseTurn]
	add SHRINKING_SQUARE_ANIM ; +turn picks the player/enemy twin
	jp PlaySpecialBattleAnimation2

; v0.7 cleanup: shared no-op target for effect-pointer-table slots whose
; moves were removed in the v0.5 overhaul (Conversion; Roar/Whirlwind +
; old Teleport via SWITCH_AND_TELEPORT; the OHKO trio; Splash). The table
; is positional, so each slot must keep a valid bank-$0F target — but the
; effects are unreachable (no move row uses them, and Metronome / Mirror
; Move can only invoke effects of existing moves). Restore the original
; handlers from git history if one of these moves ever returns.
RemovedMoveEffect:
	ret

TwoToFiveAttacksEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ld bc, wPlayerNumHits
	ldh a, [hWhoseTurn]
	and a
	jr z, .twoToFiveAttacksEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
	ld bc, wEnemyNumHits
.twoToFiveAttacksEffect
	bit ATTACKING_MULTIPLE_TIMES, [hl] ; is mon attacking multiple times?
	ret nz
	set ATTACKING_MULTIPLE_TIMES, [hl] ; mon is now attacking multiple times
	ld hl, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .setNumberOfHits
	ld hl, wEnemyMoveEffect
.setNumberOfHits
	ld a, [hl]
	cp TWINEEDLE_EFFECT
	jr z, .twineedle
	cp ATTACK_TWICE_EFFECT
	ld a, $2 ; number of hits it's always 2 for ATTACK_TWICE_EFFECT
	jr z, .saveNumberOfHits
; for TWO_TO_FIVE_ATTACKS_EFFECT 3/8 chance for 2 and 3 hits, and 1/8 chance for 4 and 5 hits
	call BattleRandom
	and $3
	cp $2
	jr c, .gotNumHits
; if the number of hits was greater than 2, re-roll again for a lower chance
	call BattleRandom
	and $3
.gotNumHits
	inc a
	inc a
.saveNumberOfHits
	ld [de], a
	ld [bc], a
	ret
.twineedle
	ld a, POISON_SIDE_EFFECT2
	ld [hl], a ; v0.7: Twineedle's poison side-effect is now 30% (tier 2; was
	           ; POISON_SIDE_EFFECT1 = 15%). Rolled once, after both hits.
	ld a, $2   ; always 2 hits (explicit now; previously this relied on
	           ; POISON_SIDE_EFFECT1 happening to equal $02)
	jr .saveNumberOfHits

FlinchSideEffect:
	call CheckTargetSubstitute
	ret nz
	ld hl, wEnemyBattleStatus1
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .flinchSideEffect
	ld hl, wPlayerBattleStatus1
	ld de, wEnemyMoveEffect
.flinchSideEffect
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	call z, ClearHyperBeam
	ld a, [de]
	cp FLINCH_SIDE_EFFECT1
	ld b, 15 percent + 1 ; chance of flinch (FLINCH_SIDE_EFFECT1)
	jr z, .gotEffectChance
	ld b, 30 percent + 1 ; chance of flinch otherwise
.gotEffectChance
	call BattleRandom
	cp b
	ret nc
	set FLINCHED, [hl] ; set mon's status to flinching
	call ClearHyperBeam
	ret

ChargeEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
; v0.7 anim split: b now carries EITHER a real move id (TELEPORT below) or
; SPECIAL_ANIM_MARKER with the index parked in hSpecialAnimIndex - the play
; site at the end stays a single PlayBattleAnimation call either way.
	ld b, XSTATITEM_ANIM
	jr z, .chargeEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyMoveEffect
	ld b, XSTATITEM_DUPLICATE_ANIM
.chargeEffect
	ld a, b
	ldh [hSpecialAnimIndex], a
	ld b, SPECIAL_ANIM_MARKER
	set CHARGING_UP, [hl]
	ld a, [de]
	dec de ; de contains enemy or player MOVENUM
	cp FLY_EFFECT
	jr nz, .notFly
	set INVULNERABLE, [hl] ; mon is now invulnerable to typical attacks (fly/dig)
	ld b, TELEPORT ; load Teleport's animation
.notFly
	ld a, [de]
	cp DIG
	jr nz, .notDigOrFly
	set INVULNERABLE, [hl] ; mon is now invulnerable to typical attacks (fly/dig)
	ld a, SLIDE_DOWN_ANIM
	ldh [hSpecialAnimIndex], a
	ld b, SPECIAL_ANIM_MARKER
.notDigOrFly
	push de
	push bc
	inc hl ; battle status 2
	push hl
	ld a, [hl]
	bit HAS_SUBSTITUTE_UP, a
	ld hl, HideSubstituteShowMonAnim
	ld b, BANK(HideSubstituteShowMonAnim)
	call nz, Bankswitch
	pop hl
	pop bc
	xor a
	ld [wAnimationType], a
	ld a, b
	call PlayBattleAnimation
	ld a, [hl]
	bit HAS_SUBSTITUTE_UP, a
	ld hl, ReshowSubstituteAnim
	ld b, BANK(ReshowSubstituteAnim)
	call nz, Bankswitch
	pop de
	ld a, [de]
	ld [wChargeMoveNum], a
	ld hl, ChargeMoveEffectText
	jp PrintText

ChargeMoveEffectText:
	text_far _ChargeMoveEffectText
	text_asm
	ld a, [wChargeMoveNum]
	; PURPLE YELLOW v0.5: RAZOR_WIND and SKULL_BASH were removed. SKY_ATTACK was
	; reintroduced in the later revision; its charge line is "soared sky-high!"
	; (Forte, 2026-08-25: Sky Attack is a stronger Fly, not a glow).
	cp SOLARBEAM
	ld hl, TookInSunlightText
	jr z, .gotText
	cp SKY_ATTACK
	ld hl, SkyAttackGlowingText
	jr z, .gotText
	cp FLY
	ld hl, FlewUpHighText
	jr z, .gotText
	; v0.7 FIX: MOONBLAST is a 5th charge move this hack added, and DIG is the
	; unguarded fall-through default below — so Clefable charging Moonblast
	; announced "dug a hole!". (Also reachable through Metronome.)
	cp MOONBLAST
	ld hl, GatheredMoonlightText
	jr z, .gotText
	cp DIG
	ld hl, DugAHoleText
.gotText
	ret

GatheredMoonlightText:
	text_far _GatheredMoonlightText
	text_end

MadeWhirlwindText:
	text_far _MadeWhirlwindText
	text_end

TookInSunlightText:
	text_far _TookInSunlightText
	text_end

LoweredItsHeadText:
	text_far _LoweredItsHeadText
	text_end

SkyAttackGlowingText:
	text_far _SkyAttackGlowingText
	text_end

FlewUpHighText:
	text_far _FlewUpHighText
	text_end

DugAHoleText:
	text_far _DugAHoleText
	text_end

TrappingEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .trappingEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
.trappingEffect
	bit USING_TRAPPING_MOVE, [hl]
	ret nz
	call ClearHyperBeam ; since this effect is called before testing whether the move will hit,
                        ; the target won't need to recharge even if the trapping move missed
	set USING_TRAPPING_MOVE, [hl] ; mon is now using a trapping move
	call BattleRandom ; 3/8 chance for 2 and 3 attacks, and 1/8 chance for 4 and 5 attacks
	and $3
	cp $2
	jr c, .setTrappingCounter
	call BattleRandom
	and $3
.setTrappingCounter
	inc a
	ld [de], a
	ret

MistEffect:
	jpfar MistEffect_

FocusEnergyEffect:
	jpfar FocusEnergyEffect_

RecoilEffect:
	jpfar RecoilEffect_

ConfusionSideEffect:
; PURPLE YELLOW v0.5: tiered confusion side effect.
; CONFUSION_SIDE_EFFECT1 = 15% (default tier).
; CONFUSION_SIDE_EFFECT2 = 30% (Confusion, Dizzy Punch, Hurricane, Spore Daze).
; CONFUSION_SIDE_EFFECT3 = 45% (v0.7 — new Psychic, heaviest tier).
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .gotEffect
	ld a, [wEnemyMoveEffect]
.gotEffect
	cp CONFUSION_SIDE_EFFECT1
	ld b, 15 percent + 1
	jr z, .rollChance
	cp CONFUSION_SIDE_EFFECT2
	ld b, 30 percent + 1
	jr z, .rollChance
	ld b, 45 percent + 1   ; CONFUSION_SIDE_EFFECT3
.rollChance
	call BattleRandom
	cp b
	ret nc
	jr ConfusionSideEffectSuccess

ConfusionEffect:
	call CheckTargetSubstitute
	jr nz, ConfusionEffectFailed
	call MoveHitTest
	ld a, [wMoveMissed]
	and a
	jr nz, ConfusionEffectFailed

ConfusionSideEffectSuccess:
	ldh a, [hWhoseTurn]
	and a
	ld hl, wEnemyBattleStatus1
	ld bc, wEnemyConfusedCounter
	ld a, [wPlayerMoveEffect]
	jr z, .confuseTarget
	ld hl, wPlayerBattleStatus1
	ld bc, wPlayerConfusedCounter
	ld a, [wEnemyMoveEffect]
.confuseTarget
	bit CONFUSED, [hl] ; is mon confused?
	jr nz, ConfusionEffectFailed
	set CONFUSED, [hl] ; mon is now confused
	push af
	call BattleRandom
	and $3
	inc a
	inc a
	ld [bc], a ; confusion status will last 2-5 turns
	pop af
	cp CONFUSION_SIDE_EFFECT1
	jr z, .skipAnim
	cp CONFUSION_SIDE_EFFECT2
	jr z, .skipAnim
	cp CONFUSION_SIDE_EFFECT3
	call nz, PlayCurrentMoveAnimation2
.skipAnim
	ld hl, BecameConfusedText
	jp PrintText

BecameConfusedText:
	text_far _BecameConfusedText
	text_end

ConfusionEffectFailed:
	; Side-effect tiers (1/2/3) are silent on miss — only ConfusionEffect
	; (the dedicated, never-side-effect move like Confuse Ray) prints
	; "but it failed".
	cp CONFUSION_SIDE_EFFECT1
	ret z
	cp CONFUSION_SIDE_EFFECT2
	ret z
	cp CONFUSION_SIDE_EFFECT3
	ret z
	ld c, 50
	call DelayFrames
	jp ConditionalPrintButItFailed

ParalyzeEffect:
	jpfar ParalyzeEffect_

SubstituteEffect:
	jpfar SubstituteEffect_

HyperBeamEffect:
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .hyperBeamEffect
	ld hl, wEnemyBattleStatus2
.hyperBeamEffect
	set NEEDS_TO_RECHARGE, [hl] ; mon now needs to recharge
	ret

ClearHyperBeam:
	push hl
	ld hl, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn
	ld hl, wPlayerBattleStatus2
.playerTurn
	res NEEDS_TO_RECHARGE, [hl] ; mon no longer needs to recharge
	pop hl
	ret

RageEffect:
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .player
	ld hl, wEnemyBattleStatus2
.player
	set USING_RAGE, [hl] ; mon is now in "rage" mode
	ret

MimicEffect:
	ld c, 50
	call DelayFrames
	call MoveHitTest
	ld a, [wMoveMissed]
	and a
	jr nz, .mimicMissed
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonMoves
	ld a, [wPlayerBattleStatus1]
	jr nz, .enemyTurn
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .letPlayerChooseMove
	ld hl, wEnemyMonMoves
	ld a, [wEnemyBattleStatus1]
.enemyTurn
	bit INVULNERABLE, a
	jr nz, .mimicMissed
.getRandomMove
	push hl
	call BattleRandom
	and $3
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .getRandomMove
	ld d, a
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonMoves
	ld a, [wPlayerMoveListIndex]
	jr z, .playerTurn
	ld hl, wEnemyMonMoves
	ld a, [wEnemyMoveListIndex]
	jr .playerTurn
.letPlayerChooseMove
	ld a, [wEnemyBattleStatus1]
	bit INVULNERABLE, a
	jr nz, .mimicMissed
	ld a, [wCurrentMenuItem]
	push af
	ld a, $1
	ld [wMoveMenuType], a
	farcall MoveSelectionMenu
	call LoadScreenTilesFromBuffer1
	ld hl, wEnemyMonMoves
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0
	add hl, bc
	ld d, [hl]
	pop af
	ld hl, wBattleMonMoves
.playerTurn
	ld c, a
	ld b, $0
	add hl, bc
	ld a, d
	ld [hl], a
	ld [wd11e], a
	call GetMoveName
	call PlayCurrentMoveAnimation
	ld hl, MimicLearnedMoveText
	jp PrintText
.mimicMissed
	jp PrintButItFailedText_

MimicLearnedMoveText:
	text_far _MimicLearnedMoveText
	text_end

LeechSeedEffect:
	jpfar LeechSeedEffect_

DisableEffect:
	call MoveHitTest
	ld a, [wMoveMissed]
	and a
	jr nz, .moveMissed
	ld de, wEnemyDisabledMove
	ld hl, wEnemyMonMoves
	ldh a, [hWhoseTurn]
	and a
	jr z, .disableEffect
	ld de, wPlayerDisabledMove
	ld hl, wBattleMonMoves
.disableEffect
; no effect if target already has a move disabled
	ld a, [de]
	and a
	jr nz, .moveMissed
.pickMoveToDisable
	push hl
	call BattleRandom
	and $3
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .pickMoveToDisable ; loop until a non-00 move slot is found
	ld [wd11e], a ; store move number
	push hl
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonPP
	jr nz, .enemyTurn
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	pop hl ; wEnemyMonMoves
	jr nz, .playerTurnNotLinkBattle
; .playerTurnLinkBattle
	push hl
	ld hl, wEnemyMonPP
.enemyTurn
	push hl
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	and $3f
	pop hl ; wBattleMonPP or wEnemyMonPP
	jr z, .moveMissedPopHL ; nothing to do if all moves have no PP left
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .pickMoveToDisable ; pick another move if this one had 0 PP
.playerTurnNotLinkBattle
; non-link battle enemies have unlimited PP so the previous checks aren't needed
	call BattleRandom
	and $7
	inc a ; 1-8 turns disabled
	inc c ; move 1-4 will be disabled
	swap c
	add c ; map disabled move to high nibble of wEnemyDisabledMove / wPlayerDisabledMove
	ld [de], a
	call PlayCurrentMoveAnimation2
	ld hl, wPlayerDisabledMoveNumber
	ldh a, [hWhoseTurn]
	and a
	jr nz, .printDisableText
	inc hl ; wEnemyDisabledMoveNumber
.printDisableText
	ld a, [wd11e] ; move number
	ld [hl], a
	call GetMoveName
	ld hl, MoveWasDisabledText
	jp PrintText
.moveMissedPopHL
	pop hl
.moveMissed
	jp PrintButItFailedText_

MoveWasDisabledText:
	text_far _MoveWasDisabledText
	text_end

PayDayEffect:
	jpfar PayDayEffect_

HazeEffect:
	jpfar HazeEffect_

HealEffect:
	jpfar HealEffect_

TransformEffect:
	jpfar TransformEffect_

ReflectLightScreenEffect:
	jpfar ReflectLightScreenEffect_

NothingHappenedText:
	text_far _NothingHappenedText
	text_end

StatWontGoHigherText:
	text_far _StatWontGoHigherText
	text_end

StatWontGoLowerText:
	text_far _StatWontGoLowerText
	text_end

PrintNoEffectText:
	ld hl, NoEffectText
	jp PrintText

NoEffectText:
	text_far _NoEffectText
	text_end

ConditionalPrintButItFailed:
	ld a, [wMoveDidntMiss]
	and a
	ret nz ; return if the side effect failed, yet the attack was successful

PrintButItFailedText_:
	ld hl, ButItFailedText
	jp PrintText

ButItFailedText:
	text_far _ButItFailedText
	text_end

PrintDidntAffectText:
	ld hl, DidntAffectText
	jp PrintText

DidntAffectText:
	text_far _DidntAffectText
	text_end

; IsUnaffectedText moved to core.asm: its only reader is PrintMoveFailureText,
; which hands the address to PrintText with Battle Core's bank mapped. A text
; stub is read by address, not through a farcall, so it must live beside its
; reader. Found by cross_bank_call_audit after the effects left this bank.

PrintMayNotAttackText:
	ld hl, ParalyzedMayNotAttackText
	jp PrintText

ParalyzedMayNotAttackText:
	text_far _ParalyzedMayNotAttackText
	text_end

CheckTargetSubstitute:
	push hl
	ld hl, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .next1
	ld hl, wPlayerBattleStatus2
.next1
	bit HAS_SUBSTITUTE_UP, [hl]
	pop hl
	ret

; v0.7 anim split (2026-08-31): the special-index twins of the wrappers
; below - park the index, raise the marker, and reuse the same machinery.
PlaySpecialBattleAnimation2:
; play SPECIAL animation index a, wAnimationType 3 or 6
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	jr PlayBattleAnimation2

PlaySpecialBattleAnimation:
; play SPECIAL animation index a, predefined animation type
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	jr PlayBattleAnimation

PlayCurrentMoveAnimation2:
; animation at MOVENUM will be played unless MOVENUM is 0
; plays wAnimationType 3 or 6
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z

PlayBattleAnimation2:
; play animation ID at a and animation type 6 or 3
	ld [wAnimationID], a
	ldh a, [hWhoseTurn]
	and a
	ld a, ANIMATIONTYPE_SHAKE_SCREEN_HORIZONTALLY_SLOW_2
	jr z, .storeAnimationType
	ld a, ANIMATIONTYPE_SHAKE_SCREEN_HORIZONTALLY_SLOW
.storeAnimationType
	ld [wAnimationType], a
	jp PlayBattleAnimationGotID

PlayCurrentMoveAnimation:
; animation at MOVENUM will be played unless MOVENUM is 0
; resets wAnimationType
	xor a
	ld [wAnimationType], a
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z

PlayBattleAnimation:
; play animation ID at a and predefined animation type
	ld [wAnimationID], a

PlayBattleAnimationGotID:
; play animation at wAnimationID
	push hl
	push de
	push bc
	predef MoveAnimation
	callfar Func_78e98
	pop bc
	pop de
	pop hl
	ret


; ============================================================
; === PURPLE YELLOW: dual-stat and burn effect handlers ===
; ============================================================

AttackDefenseUp1Effect:
; Dual-stat +1 for the user (Attack + Defense). Used by BULK_UP.
; Spoofs wPlayer/EnemyMoveEffect and calls StatModifierUpEffect twice.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr
	ld de, wEnemyMoveEffect
.gotEffectPtr
	push de
	ld a, ATTACK_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	; Suppress animation on the second leg (we only want one "used BULK_UP"
	; hit) by spoofing wMoveDidntMiss; the guard in StatModifierUpEffect
	; reads this flag and skips PlayCurrentMoveAnimation.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, DEFENSE_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	ld a, ATTACK_DEFENSE_UP1_EFFECT
	ld [de], a
	ret

AttackAccuracyUp1Effect:
; Dual-stat +1 for the user (Attack + Accuracy). Used by HONE_CLAWS.
; Same pattern as AttackDefenseUp1Effect.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr3
	ld de, wEnemyMoveEffect
.gotEffectPtr3
	push de
	ld a, ATTACK_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	; Suppress animation on the second leg.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, ACCURACY_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	ld a, ATTACK_ACCURACY_UP1_EFFECT
	ld [de], a
	ret

SpeedEvasionUp1Effect:
; Dual-stat +1 for the user (Speed + Evasion). Used by AGILITY (revised).
; Same pattern as AttackAccuracyUp1Effect.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr4
	ld de, wEnemyMoveEffect
.gotEffectPtr4
	push de
	ld a, SPEED_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	; Suppress animation on the second leg.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, EVASION_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	ld a, SPEED_EVASION_UP1_EFFECT
	ld [de], a
	ret

SpecialAccuracyUp1Effect:
; Dual-stat +1 for the user (Special + Accuracy). Used by CALM_MIND (revised).
; Same pattern as AttackAccuracyUp1Effect.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtrCM
	ld de, wEnemyMoveEffect
.gotEffectPtrCM
	push de
	ld a, SPECIAL_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	; Suppress animation on the second leg.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, ACCURACY_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	ld a, SPECIAL_ACCURACY_UP1_EFFECT
	ld [de], a
	ret

AccuracyEvasionDown1Effect:
; Dual-stat -1 on the target (Accuracy + Evasion). Used by FLASH.
; Spoofs the effect and calls StatModifierDownEffect twice. Each call does
; its own accuracy check; for 100% accurate moves (FLASH) both always land.
; For sub-100% users the two effects roll independently, which is a known
; minor quirk.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr2
	ld de, wEnemyMoveEffect
.gotEffectPtr2
	push de
	ld a, ACCURACY_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect
	pop de
	xor a
	ld [wMoveMissed], a ; reset miss flag between legs (hit independently each leg)
	; Suppress animation on the second leg: the guard in StatModifierDownEffect
	; reads wMoveDidntMiss and skips PlayCurrentMoveAnimation2 when set.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, EVASION_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect
	pop de
	ld a, ACCURACY_EVASION_DOWN1_EFFECT
	ld [de], a
	ret

SpecialSpeedDown1Effect:
; Dual-stat -1 on the target (Special + Speed). Used by EERIE_IMPULSE.
; Spoofs the effect and calls StatModifierDownEffect twice. Each call does
; its own accuracy check; for 100% accurate moves both always land.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr5
	ld de, wEnemyMoveEffect
.gotEffectPtr5
	push de
	ld a, SPECIAL_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect
	pop de
	xor a
	ld [wMoveMissed], a ; reset miss flag between legs (hit independently each leg)
	; Suppress animation on the second leg.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, SPEED_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect
	pop de
	ld a, SPECIAL_SPEED_DOWN1_EFFECT
	ld [de], a
	ret

SpeedEvasionDown1Effect:
; Dual-stat -1 on the target (Speed + Evasion). Used by PSYCHIC_BIND (v0.7).
; Mirrors SpeedEvasionUp1Effect (Agility) but in the down direction —
; same "spoof effect, call StatModifierDownEffect twice, restore" pattern
; as SpecialSpeedDown1Effect / AccuracyEvasionDown1Effect above.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr7
	ld de, wEnemyMoveEffect
.gotEffectPtr7
	push de
	ld a, SPEED_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect
	pop de
	xor a
	ld [wMoveMissed], a ; reset miss flag between legs (each leg rolls independently)
	; Suppress animation on the second leg.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, EVASION_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect
	pop de
	ld a, SPEED_EVASION_DOWN1_EFFECT
	ld [de], a
	ret

SpecialSpeedUp1Effect:
; Dual-stat +1 for the user (Special + Speed). Used by QUIVER_DANCE (v0.7).
; Mirrors SpecialSpeedDown1Effect in the up direction — same pattern as
; AttackDefenseUp1Effect / SpeedEvasionUp1Effect above.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr8
	ld de, wEnemyMoveEffect
.gotEffectPtr8
	push de
	ld a, SPECIAL_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	; Suppress animation on the second leg (we only want one "used QUIVER
	; DANCE" hit) by spoofing wMoveDidntMiss; the guard in StatModifierUp
	; Effect reads this flag and skips PlayCurrentMoveAnimation.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, SPEED_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect
	pop de
	ld a, SPECIAL_SPEED_UP1_EFFECT
	ld [de], a
	ret

AttackUp1Down1Effect:
; Mixed-direction dual-stat: ATK+1 to user, ATK-1 to target. Used by FIERCE_ROAR.
; Up leg always succeeds; down leg has its own hit roll, so reset wMoveMissed
; before invoking it (otherwise a miss carries over from somewhere upstream).
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr6
	ld de, wEnemyMoveEffect
.gotEffectPtr6
	push de
	ld a, ATTACK_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect       ; targets user
	pop de
	; Reset miss flag for the down leg's independent hit test.
	xor a
	ld [wMoveMissed], a
	; Suppress animation on the second leg.
	ld a, 1
	ld [wMoveDidntMiss], a
	push de
	ld a, ATTACK_DOWN1_EFFECT
	ld [de], a
	call StatModifierDownEffect     ; targets opponent
	pop de
	ld a, ATTACK_UP1_DOWN1_EFFECT
	ld [de], a
	ret

SpecialUp1HealEffect:
; Dual: SPC+1 to user + heal 1/4 max HP. Used by GROWTH (revised).
; Phase 1 uses StatModifierUpEffect for animated SPC+1 + "rose!" text.
; Phase 2 farcalls HealEffect_ which takes a GROWTH-specific branch that
; divides max HP by 4 and honours wMoveDidntMiss to skip re-animating.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr7
	ld de, wEnemyMoveEffect
.gotEffectPtr7
	push de
	ld a, SPECIAL_UP1_EFFECT
	ld [de], a
	call StatModifierUpEffect       ; +1 SPC to user (anim + text)
	pop de
	; Suppress the move-anim replay inside HealEffect_'s .playAnim.
	ld a, 1
	ld [wMoveDidntMiss], a
; v0.7 FIX: HealEffect_'s full-HP guard runs before its per-move dispatch and
; lands on .failed, which prints "But, it failed!" UNCONDITIONALLY (it calls
; PrintButItFailedText_, not the conditional variant, so the wMoveDidntMiss set
; just above is ignored). At full HP that produced "<MON>'s SPECIAL rose!"
; immediately followed by "But, it failed!" for the same move — even though the
; stat really did go up. Skip the heal leg when the user is already at max HP.
; Battle Core is at its size limit, so this stays deliberately compact: the
; effect pointer rides the stack rather than being re-derived.
	push de
	ldh a, [hWhoseTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	jr z, .growthGotHP
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
.growthGotHP
	ld a, [de]                      ; the same 16-bit compare HealEffect_ uses
	cp [hl]
	inc de
	inc hl
	jr nz, .growthDoHeal
	ld a, [de]
	sbc [hl]
	jr z, .growthSkipHeal           ; already at max HP
.growthDoHeal
	callfar HealEffect_             ; /4 heal via Growth branch
.growthSkipHeal
	pop de
	ld a, SPECIAL_UP1_HEAL_EFFECT
	ld [de], a
	ret

BurnEffect:
; Always-burn status move (WILL_O_WISP). Mirrors PoisonEffect structure.
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .burnEffect
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveEffect
.burnEffect
	call CheckTargetSubstitute
	jr nz, .didntAffect
	ld a, [hli]
	ld b, a
	and a
	jr nz, .alreadyStatused
	ld a, [hli]
	cp FIRE ; can not burn a fire-type target
	jr z, .didntAffect
	cp MAGMA ; v0.7: nor a magma-type target (matches the side-effect paths)
	jr z, .didntAffect
	ld a, [hld]
	cp FIRE
	jr z, .didntAffect
	cp MAGMA ; v0.7
	jr z, .didntAffect
	push hl
	push de
	call MoveHitTest
	pop de
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	; apply burn
	dec hl
	set BRN, [hl]
	call HalveAttackDueToBurn
	call PlayCurrentMoveAnimation2
	ld hl, BurnedText
	jp PrintText
.alreadyStatused
; v0.7: an always-burn move cannot burn a target that already has a status, but a
; FIRE or MAGMA one must still THAW a frozen one -- "any fire move melts the ice",
; with no exception for the one that happens to deal no damage (IGNITE). Any
; status other than freeze fails exactly as before.
;
; MoveHitTest first: IGNITE is 95% accurate and a move that misses must not
; defrost. The type gate below decides whether this thaws at all.
	bit FRZ, a
	jr z, .didntAffect
	push bc
	call MoveHitTest
	pop bc
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
; v0.7 fix: only a FIRE or MAGMA always-burn move (IGNITE) thaws. For any
; other type (WILL_O_WISP is GHOST) CheckDefrost would `ret` without printing,
; leaving the whole turn silent after "used WILL O WISP!" -- fail loudly
; instead. (Read the type via hWhoseTurn, not via de: MoveHitTest clobbers de
; -- see the push de around it in the fresh-status path above.)
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveType] ; ld does not touch flags, the jr still tests hWhoseTurn
	jr z, .gotBurnMoveType
	ld a, [wEnemyMoveType]
.gotBurnMoveType
	cp FIRE
	jr z, .thawFrozenTarget
	cp MAGMA
	jr nz, .didntAffect
.thawFrozenTarget
	ld a, b ; the defender's status, read above
	jp CheckDefrost
.didntAffect
	jp PrintDidntAffectText
