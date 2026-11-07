LeechSeedEffect_:
	callfar MoveHitTest
	ld a, [wMoveMissed]
	and a
	jr nz, .moveMissed
	ld hl, wEnemyBattleStatus2
	ld de, wEnemyMonType1
	ldh a, [hWhoseTurn]
	and a
	jr z, .leechSeedEffect
	ld hl, wPlayerBattleStatus2
	ld de, wBattleMonType1
.leechSeedEffect
; miss if the target is grass-type or already seeded
	ld a, [de]
	cp GRASS
	jr z, .moveMissed
	inc de
	ld a, [de]
	cp GRASS
	jr z, .moveMissed
	ldh a, [hWhoseTurn] ; v1.0 (2026-11-07): or its third type (GetThirdType keeps hl: PARASECT's GRASS)
	and a
	ld a, [wEnemyMonSpecies] ; (ld keeps the flags of the and)
	jr z, .gotSpecies
	ld a, [wBattleMonSpecies]
.gotSpecies
	call GetThirdType
	cp GRASS
	jr z, .moveMissed
	bit SEEDED, [hl]
	jr nz, .moveMissed
	set SEEDED, [hl]
	callfar PlayCurrentMoveAnimation
	ld hl, WasSeededText
	jp PrintText
.moveMissed
	ld a, [wMoveMissed]
	cp MOVE_FAILED_PROTECTED
	ret z ; v1.0 (2026-11-02): the target protected itself, and MoveHitTest has said so
	ld c, 50
	call DelayFrames
	ld hl, EvadedAttackText
	jp PrintText

WasSeededText:
	text_far _WasSeededText
	text_end

EvadedAttackText:
	text_far _EvadedAttackText
	text_end
