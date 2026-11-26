; v1.0 (2026-11-17): the one failure line of the status moves.
;
; SleepEffect, PoisonEffect (POISON, TOXIC), BurnEffect (WILL-O-WISP, IGNITE), ConfusionEffect (bank $1D,
; through StatusMoveFailed) and ParalyzeEffect_ (bank $3D) jump here (farjp) when they refuse, with c = the
; cause (STATUS_FAIL_*, constants/battle_constants.asm); v1.0 (2026-11-24) DEATH GLARE's FearEffect_ and
; SPIRAL's SpiralEffect_ too (soft_status.asm, near: the same bank). Each
; handler tests, in this order: the target's SUBSTITUTE (poison, burn, confusion, fear and SPIRAL only - sleep and
; paralysis land through a doll; SPIRAL stops at the doll before its sleep leg), its status (or, for confusion,
; its confusion; for fear, its fear), its type, then the accuracy. SPIRAL refuses only for the doll and the miss
; (SUBSTITUTE, MISS): its two legs' gates come after its hit and are silent. The target's state is on screen, so
; a refusal that
; is certain names its reason before any roll. A side effect of a damaging move that is refused says nothing
; and never comes here.
;
; The line, after the same 50-frame pause for every cause:
;   STATUS_FAIL_SUBSTITUTE "But, it failed!"
;   STATUS_FAIL_STATUSED   "<TARGET>'s / already asleep! | poisoned! | burned! | frozen! | paralyzed", the
;                          status the target HAS (TOX shares its byte with PSN: "poisoned"; a burn only
;                          while its fire burns - one whose fire is out leaves the slot open,
;                          TargetStatusSlot in soft_status.asm, and the move lands)
;   STATUS_FAIL_CONFUSED   "<TARGET>'s / already confused!"
;   STATUS_FAIL_SCARED     "<TARGET>'s / already scared!" (v1.0 2026-11-24: DEATH GLARE, FearEffect_ in
;                          soft_status.asm, which jumps here near: the same bank)
;   STATUS_FAIL_IMMUNE    "It doesn't affect <TARGET>!" (PrintDoesntAffectText, home)
;   STATUS_FAIL_MISS       what PrintMoveFailureText says from wMoveMissed: nothing for MOVE_FAILED_PROTECTED
;                          (TargetIsProtected has spoken) and MOVE_FAILED_HABITUATED (MoveHitTest has, v1.0
;                          2026-11-26), "slipped aside!" for MOVE_FAILED_EVADED, else
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
	ld hl, StatusFailScaredText
	cp STATUS_FAIL_SCARED
	jr z, .print
	cp STATUS_FAIL_IMMUNE
	jp z, PrintDoesntAffectText
; STATUS_FAIL_MISS
	ld a, [wMoveMissed]
	cp MOVE_FAILED_PROTECTED
	ret nc ; PROTECT's, or (v1.0 2026-11-26) the habit's: MoveHitTest has said either
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

StatusFailScaredText:
	text_far _AlreadyScaredText
	text_end

; v1.0 (2026-11-17): ice over sleep - the status gate of FreezeBurnParalyzeEffect (bank $1D, callfar),
; both sides, before its roll. z: the side effect goes on to its roll - the target's slot is open (no
; status, or a burn whose fire is out: TargetStatusSlot, soft_status.asm), or it holds only sleep bits
; and the effect is a freeze (FREEZE_SIDE_EFFECT1 / 2: the whole-byte 1 << FRZ ends the sleep). nz:
; refused - a sleeper under a burn or a paralysis, or any other status (the caller hands that status to
; CheckDefrost, which thaws a frozen target under a FIRE or MAGMA move).
; TriStatusSideEffect asks TargetStatusSlot the same two questions itself (its freeze branch, then its
; burn and paralysis branches).
; In: hWhoseTurn = the attacker. Out: hl -> the target's status byte, the flags; de kept.
FreezeBurnParalyzeStatusGate::
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .gotEffect
	ld a, [wEnemyMoveEffect]
.gotEffect
	ld c, TARGET_SLOT_FREEZE
	cp FREEZE_SIDE_EFFECT1
	jp z, TargetStatusSlot
	cp FREEZE_SIDE_EFFECT2
	jp z, TargetStatusSlot
	ASSERT TARGET_SLOT_ANY == TARGET_SLOT_FREEZE - 1
	dec c ; a burn or a paralysis
	jp TargetStatusSlot
