; v1.0 (2026-11-01): the moves that reach a #MON hidden by a two-turn move. An aimed attack
; misses, as the target is out of range: only what fills the sky or shakes the ground gets
; there, and a #MON hiding the same way meets the other one on its way. In the home bank
; because the hit test (Battle Effects) and the AI's layer 5 (Battle Engine 6) both ask.

; In: a = the attacking move, c = the hidden #MON's move effect.
; Out: carry if the move reaches it. Kills a, b, c, d, e, h and l.
MoveReachesHiddenMon::
	ld hl, MovesReachingUnderground
	ld b, a
	ld a, c
	cp FLY_EFFECT ; FLY and SKY ATTACK; the only other way to hide is DIG (ChargeEffect)
	ld a, b
	jr nz, .gotList
	ld hl, MovesReachingTheSky
.gotList
	ld de, 1
	jp IsInArray

MovesReachingTheSky:
	db AERIAL_ACE, HURRICANE, SKY_ATTACK, FLY, BLIZZARD, THUNDER, HAZE, -1

MovesReachingUnderground:
	db EARTHQUAKE, FISSURE, DIG, -1
