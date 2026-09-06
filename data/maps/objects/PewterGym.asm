	object_const_def
	const_export PEWTERGYM_BROCK
	const_export PEWTERGYM_FORREST ; Brock's brother (the gym rework, 2026-09-06)
	const_export PEWTERGYM_GYM_GUIDE

PewterGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 13, LAST_MAP, 3
	warp_event  5, 13, LAST_MAP, 3

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_BROCK, STAY, DOWN, TEXT_PEWTERGYM_BROCK, OPP_BROCK, 1
; v1.0 (the gym rework, 2026-09-06): FORREST, Brock's younger brother (anime),
; the gym's one regular - a kid guarding the door with his brother's POKeMON.
	object_event  2,  6, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_PEWTERGYM_FORREST, OPP_JR_TRAINER_M, 1, 5
	object_event  7, 10, SPRITE_GYM_GUIDE, STAY, DOWN, TEXT_PEWTERGYM_GYM_GUIDE

	def_warps_to PEWTER_GYM
