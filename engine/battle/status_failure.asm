; v1.0 (2026-11-17): ice over sleep - the status gate of FreezeBurnParalyzeEffect (bank $1D, callfar),
; both sides, before its roll. z: the side effect goes on to its roll - the target has no status, or
; only sleep bits and the effect is a freeze (FREEZE_SIDE_EFFECT1 / 2: the whole-byte 1 << FRZ ends
; the sleep). nz: refused - a sleeper under a burn or a paralysis, or any other status (the caller
; hands that status to CheckDefrost, which thaws a frozen target under a FIRE or MAGMA move).
; TriStatusSideEffect keeps its own gates: its freeze branch lets a sleeper through (and ~SLP_MASK), its
; burn and paralysis branches refuse any status (and a), a sleeper too.
; In: hWhoseTurn = the attacker. Out: hl -> the target's status byte, the flags; de kept.
FreezeBurnParalyzeStatusGate::
	ld hl, wEnemyMonStatus
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect] ; (ld keeps the flags of the and)
	jr z, .gotSides
	ld hl, wBattleMonStatus
	ld a, [wEnemyMoveEffect]
.gotSides
	ld b, a
	ld a, [hl]
	and a
	ret z ; no status
	and ~SLP_MASK
	ret nz ; a status other than sleep
	ld a, b
	cp FREEZE_SIDE_EFFECT1
	ret z
	cp FREEZE_SIDE_EFFECT2
	ret ; z: a freeze on a sleeper; nz: a burn or a paralysis on one
