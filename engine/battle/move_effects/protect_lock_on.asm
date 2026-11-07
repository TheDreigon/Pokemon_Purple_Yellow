; v1.0 (2026-11-02): PROTECT and LOCK-ON, the two moves of the Gen 2 pair, with the rules of this game.
; Both are ResidualEffects1 moves: no damage calculation, and each runs its own test.

; PROTECT (priority 11, above EXTREMESPEED: data/battle/priority_moves.asm). The user is out of reach
; of every move aimed at it for the rest of this turn (TRANSFORM and a WRAP's later turns aside, by
; design: they skip the hit test): PROTECTING, which MoveHitTest reads first (TargetIsProtected) and
; the turn's commit clears (CommitTurnBattleBits, core.asm). It fails
; - the turn after a PROTECT of its own that worked (PROTECTED_LAST_TURN, which the commit sets
;   from PROTECTING): never twice in a row, no luck involved;
; - when the user moves last (the target's MOVED_THIS_TURN): with nothing left to block, it would
;   only cost the next turn's PROTECT. Only another PROTECT goes first at that priority, or a
;   PROTECT that MIRROR MOVE or METRONOME calls in its own speed slot.
ProtectEffect:
	ld hl, wPlayerBattleStatus2
	ld de, wEnemyBattleStatus3
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotSides
	ld hl, wEnemyBattleStatus2
	ld de, wPlayerBattleStatus3
.gotSides
	bit PROTECTED_LAST_TURN, [hl]
	jr nz, ProtectLockOnFailed
	ld a, [de]
	bit MOVED_THIS_TURN, a
	jr nz, ProtectLockOnFailed
	set PROTECTING, [hl]
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
