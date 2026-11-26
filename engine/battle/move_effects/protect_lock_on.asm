; v1.0 (2026-11-02): PROTECT and LOCK-ON, the two moves of the Gen 2 pair, with the rules of this game.
; Both are ResidualEffects1 moves: no damage calculation, and each runs its own test.

; PROTECT (priority 11, above EXTREMESPEED: data/battle/priority_moves.asm). The user is out of reach
; of every move aimed at it for the rest of this turn (TRANSFORM and a WRAP's later turns aside, by
; design: they skip the hit test): PROTECTING, which MoveHitTest reads first (TargetIsProtected) and
; the turn's commit clears (CommitTurnBattleBits, core.asm). It fails
; - when the user moves last (the target's MOVED_THIS_TURN): with nothing left to block, it would
;   only cost the next turn's PROTECT. Only another PROTECT goes first at that priority, or a
;   PROTECT that MIRROR MOVE or METRONOME calls in its own speed slot. No roll is drawn then;
; - v1.0 (2026-11-25) by the chain: after n PROTECTs of its own that worked in a row
;   (PROTECT_CHAIN, counted by the commit), it works 1 time in 2^n - 50 %, 25 %, then 12.5 % on
;   (ProtectChainRoll, soft_status.asm, which sets PROTECTING when it works). A PROTECT that fails
;   breaks the chain: the next one is sure again. (2026-11-02 to 11-25: it always failed the turn
;   after one that worked.)
ProtectEffect:
	ld de, wEnemyBattleStatus3
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotTarget
	ld de, wPlayerBattleStatus3
.gotTarget
	ld a, [de]
	bit MOVED_THIS_TURN, a
	jr nz, ProtectLockOnFailed
	farcall ProtectChainRoll ; carry: the chain's roll failed; else the user's PROTECTING is set (bank $12)
	jr c, ProtectLockOnFailed
	call PlayCurrentMoveAnimation
	ld hl, ProtectedItselfText
	jp PrintText

; LOCK-ON. Until either side leaves the field, the user's moves skip the accuracy roll against the
; target (LOCKED_ON: MoveHitTest; SendOutMon and EnemySendOutFirstMon clear the other side's). It
; never misses a target in sight (LOCK_ON_EFFECT exits MoveHitTest as SWIFT does); a target up in
; the air or underground dodges it, and one that protected itself blocks it. Already locked on, it
; fails.
LockOnEffect:
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotUser
	ld hl, wEnemyBattleStatus2
.gotUser
	bit LOCKED_ON, [hl]
	jr nz, ProtectLockOnFailed
	push hl
	call MoveHitTest
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, ProtectLockOnFailed ; a hidden target, or a protected one (TargetIsProtected said it: silent below)
	set LOCKED_ON, [hl]
	call PlayCurrentMoveAnimation
	ld hl, TookAimText
	jp PrintText

ProtectLockOnFailed:
	ld c, 50
	call DelayFrames
	jp PrintButItFailedText_

ProtectedItselfText:
	text_far _ProtectedItselfText
	text_end

TookAimText:
	text_far _TookAimText
	text_end
