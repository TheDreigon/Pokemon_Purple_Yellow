; v1.0 (2026-11-17): the one failure line of the status moves.
;
; SleepEffect, PoisonEffect (POISON, TOXIC), BurnEffect (WILL-O-WISP, IGNITE), ConfusionEffect (bank $1D,
; through StatusMoveFailed) and ParalyzeEffect_ (bank $3D) jump here (farjp) when they refuse, with c = the
; cause (STATUS_FAIL_*, constants/battle_constants.asm). Each handler tests, in this order: the target's
; SUBSTITUTE (poison, burn and confusion only - sleep and paralysis land through a doll), its status (or, for
; confusion, its confusion), its type, then the accuracy. The target's state is on screen, so a refusal that
; is certain names its reason before any roll. A side effect of a damaging move that is refused says nothing
; and never comes here.
;
; The line, after the same 50-frame pause for every cause:
;   STATUS_FAIL_SUBSTITUTE "But, it failed!"
;   STATUS_FAIL_STATUSED   "<TARGET>'s / already asleep! | poisoned! | burned! | frozen! | paralyzed", the
;                          status the target HAS (TOX shares its byte with PSN: "poisoned")
;   STATUS_FAIL_CONFUSED   "<TARGET>'s / already confused!"
;   STATUS_FAIL_IMMUNE     "It doesn't affect <TARGET>!" (PrintDoesntAffectText, home)
;   STATUS_FAIL_MISS       what PrintMoveFailureText says from wMoveMissed: nothing for MOVE_FAILED_PROTECTED
;                          (TargetIsProtected has spoken), "slipped aside!" for MOVE_FAILED_EVADED, else
;                          "<USER>'s / attack missed!"
; The text stubs sit here, beside their reader: PrintText reads a stub by address with this bank mapped.
; In: c = the cause, hWhoseTurn = the attacker. Ends in PrintText, or returns silently: nothing is kept.
PrintStatusMoveFailure::
	push bc
	ld c, 50
	call DelayFrames
	pop bc
	ld a, c
	ld hl, StatusFailButItFailedText
	cp STATUS_FAIL_SUBSTITUTE
	jr z, .print
	cp STATUS_FAIL_STATUSED
	jr z, .statused
	ld hl, StatusFailConfusedText
	cp STATUS_FAIL_CONFUSED
	jr z, .print
	cp STATUS_FAIL_IMMUNE
	jp z, PrintDoesntAffectText
; STATUS_FAIL_MISS
	ld a, [wMoveMissed]
	cp MOVE_FAILED_PROTECTED
	ret z
	ld hl, MoveEvadedText
	cp MOVE_FAILED_EVADED
	jr z, .print
	ld hl, StatusFailMissedText
	jr .print
.statused
	ldh a, [hWhoseTurn]
	and a
	ld a, [wEnemyMonStatus] ; (ld keeps the flags of the and)
	jr z, .gotStatus
	ld a, [wBattleMonStatus]
.gotStatus
	ld b, a
	ld hl, StatusFailAsleepText
	and SLP_MASK
	jr nz, .print
	ld hl, StatusFailFrozenText
	bit FRZ, b
	jr nz, .print
	ld hl, StatusFailBurnedText
	bit BRN, b
	jr nz, .print
	ld hl, StatusFailParalyzedText
	bit PAR, b
	jr nz, .print
	ld hl, StatusFailPoisonedText ; PSN, with or without TOX
.print
	jp PrintText

StatusFailButItFailedText:
	text_far _ButItFailedText
	text_end

StatusFailAsleepText:
	text_far _AlreadyAsleepText
	text_end

StatusFailPoisonedText:
	text_far _AlreadyPoisonedText
	text_end

StatusFailBurnedText:
	text_far _AlreadyBurnedText
	text_end

StatusFailFrozenText:
	text_far _AlreadyFrozenText
	text_end

StatusFailParalyzedText:
	text_far _AlreadyParalyzedText
	text_end

StatusFailConfusedText:
	text_far _AlreadyConfusedText
	text_end

StatusFailMissedText:
	text_far _AttackMissedText
	text_end

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
