; v1.0 (2026-11-24): the types FEAR never lands on (DEATH GLARE's IMMUNE refusal, SHADOW BALL's silent one, and the
; trainer AI's verdict on DEATH GLARE), by the target's type 1, type 2 or third type. Read by one routine,
; FearImmuneTarget (engine/battle/soft_status.asm). A #MON that is already dead has nothing left to fear.

FearImmuneTypes:
	db GHOST
	db -1 ; end
