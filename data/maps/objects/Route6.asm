	object_const_def
	const_export ROUTE6_COOLTRAINER_M1
	const_export ROUTE6_COOLTRAINER_F1
	const_export ROUTE6_YOUNGSTER1
	const_export ROUTE6_COOLTRAINER_M2
	const_export ROUTE6_COOLTRAINER_F2
	const_export ROUTE6_YOUNGSTER2

Route6_Object:
	db $f ; border block

	def_warp_events
; v0.7 (2026-09-05, Forte): warps 1 and 2 are DEAD slots. This map's gate has
; its roof on row 0, flush with SAFFRON's seam, so the square a player stands on
; when bumping the back wall is SAFFRON (20,35)/(21,35) - the warps live there
; (SAFFRON warps 9-10) and the gate's north door lands on them by name. These
; two sit on roof tiles nobody can reach; they stay because warp ids 3 and 4
; below are referenced by the gate and the UNDERGROUND PATH (never renumber).
	warp_event  9,  0, ROUTE_6_GATE, 3
	warp_event 10,  0, ROUTE_6_GATE, 3
	warp_event 10,  3, ROUTE_6_GATE, 1
	warp_event 17,  9, UNDERGROUND_PATH_ROUTE_6, 1

	def_bg_events
	bg_event 17, 11, TEXT_ROUTE6_UNDERGROUND_PATH_SIGN

	def_object_events
	object_event 10, 21, SPRITE_COOLTRAINER_M, STAY, RIGHT, TEXT_ROUTE6_COOLTRAINER_M1, OPP_JR_TRAINER_M, 10, 0
	object_event 11, 21, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_ROUTE6_COOLTRAINER_F1, OPP_JR_TRAINER_F, 25, 0
	object_event  2, 16, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_ROUTE6_YOUNGSTER1, OPP_BUG_CATCHER, 10, 4
	object_event 11, 31, SPRITE_COOLTRAINER_M, STAY, LEFT, TEXT_ROUTE6_COOLTRAINER_M2, OPP_JR_TRAINER_M, 5, 3
	object_event 11, 30, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_ROUTE6_COOLTRAINER_F2, OPP_JR_TRAINER_F, 3, 3
	object_event 17, 25, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_ROUTE6_YOUNGSTER2, OPP_BUG_CATCHER, 11, 3

	def_warps_to ROUTE_6
