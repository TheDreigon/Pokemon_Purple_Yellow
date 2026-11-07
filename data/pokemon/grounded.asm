; v1.0 (2026-11-07): the GROUNDED #MON, Forte's list: FLYING #MON that live on the ground. They keep all of
; FLYING (its weaknesses and resistances, STAB on its moves) but GROUND's rows never match their FLYING, so a
; GROUND move hits them as their other types take it - the inverse of AIRBORNE. The chart walks read it through
; wDefenderAirborne (GROUNDED_TRAIT, set by SetDefenderTraits from GetAirborne); nothing else in battle reads it.
; The status screen shows it under the types, where AIRBORNE goes.

GroundedMons:
	db DODUO     ; NORMAL/FLYING: its short wings make flying difficult; it runs
	db DODRIO    ; NORMAL/FLYING
	db FARFETCHD ; FIGHTING/FLYING/NORMAL: the duck that duels in the marshes
	db -1 ; end
