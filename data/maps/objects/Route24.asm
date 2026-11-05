	object_const_def
	const_export ROUTE24_COOLTRAINER_M1
	const_export ROUTE24_COOLTRAINER_M2
	const_export ROUTE24_COOLTRAINER_M3
	const_export ROUTE24_COOLTRAINER_F1
	const_export ROUTE24_YOUNGSTER1
	const_export ROUTE24_COOLTRAINER_F2
	const_export ROUTE24_YOUNGSTER2
	const_export ROUTE24_TM_ICY_PULSE

Route24_Object:
	db $2c ; border block

	def_warp_events

	def_bg_events

; v1.0 (2026-11-05): ROUTE_24 was cut at its old row 18 (its top went to ROUTE_25) and grew three blocks at the top;
; Forte then polished the map and placed its trainers anew (the ROCKET at (13,3): his trigger in scripts/Route24.asm is
; the cell west of him). DAMIAN, the CHARMANDER guy, was above the cut: he lives in ROUTE_25 now
; (ROUTE25_COOLTRAINER_M2).
	def_object_events
	object_event 13,  3, SPRITE_COOLTRAINER_M, STAY, LEFT, TEXT_ROUTE24_COOLTRAINER_M1, OPP_ROCKET, 6
	object_event  4,  7, SPRITE_COOLTRAINER_M, STAY, UP, TEXT_ROUTE24_COOLTRAINER_M2, OPP_JR_TRAINER_M, 2, 4
	object_event 13,  7, SPRITE_COOLTRAINER_M, STAY, LEFT, TEXT_ROUTE24_COOLTRAINER_M3, OPP_JR_TRAINER_M, 3, 1
	object_event 12, 11, SPRITE_COOLTRAINER_F, STAY, RIGHT, TEXT_ROUTE24_COOLTRAINER_F1, OPP_LASS, 7, 1
	object_event 13, 15, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_ROUTE24_YOUNGSTER1, OPP_YOUNGSTER, 4, 1
	object_event 12, 19, SPRITE_COOLTRAINER_F, STAY, RIGHT, TEXT_ROUTE24_COOLTRAINER_F2, OPP_LASS, 8, 1
	object_event 13, 23, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_ROUTE24_YOUNGSTER2, OPP_BUG_CATCHER, 9, 1
	object_event  6, 24, SPRITE_POKE_BALL, STAY, NONE, TEXT_ROUTE24_TM_ICY_PULSE, TM_ICY_PULSE ; world-design reposition (was TM_THUNDER_WAVE in April; TM renamed since, position kept)

	def_warps_to ROUTE_24
