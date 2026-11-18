ParalyzeEffect_:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveType
	ldh a, [hWhoseTurn]
	and a
	jp z, .next
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveType
.next
; v1.0 (2026-11-17): does the target already have a status ailment? A burn whose fire is out leaves the
; slot open (TargetStatusSlot, engine/battle/soft_status.asm: hl -> the target's status as before, de kept).
	ld c, TARGET_SLOT_ANY
	farcall TargetStatusSlot
	ld c, STATUS_FAIL_STATUSED ; v1.0 (2026-11-17): the cause of each refusal, for PrintStatusMoveFailure
	jr nz, .failed
; v0.7: ELECTRIC defenders are immune to paralysis (any source).
	ld b, h
	ld c, l
	inc bc
	ld a, [bc]
	cp ELECTRIC
	jr z, .doesntAffect
	inc bc
	ld a, [bc]
	cp ELECTRIC
	jr z, .doesntAffect
; check if the target is immune due to type-vs-move-type (e.g. Ground-types
; are immune to ELECTRIC moves, including Thunder Wave)
	ld a, [de]
	cp ELECTRIC
	jr nz, .hitTest
	ld b, h
	ld c, l
	inc bc
	ld a, [bc]
	cp GROUND
	jr z, .doesntAffect
	inc bc
	ld a, [bc]
	cp GROUND
	jr z, .doesntAffect
.hitTest
	push hl
	callfar MoveHitTest
	pop hl
	ld c, STATUS_FAIL_MISS
	ld a, [wMoveMissed]
	and a
	jr nz, .failed
	ld c, 1 << PAR ; v1.0 (2026-11-17): the whole byte lands; a burn whose fire was out goes, and its ATTACK
	farcall TargetStatusSlot ; cut with it, before the SPEED cut below
	callfar HalveSpeedDueToParalysis
	ld c, 30
	call DelayFrames
	callfar PlayCurrentMoveAnimation
	jpfar PrintMayNotAttackText
; v1.0 (2026-11-17): the 50-frame pause and the line are PrintStatusMoveFailure's (bank $12).
.doesntAffect
	ld c, STATUS_FAIL_IMMUNE
.failed
	jpfar PrintStatusMoveFailure
