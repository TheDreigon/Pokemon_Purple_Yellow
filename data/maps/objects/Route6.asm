	object_const_def
	const_export ROUTE6_COOLTRAINER_M1
	const_export ROUTE6_COOLTRAINER_F1
	const_export ROUTE6_YOUNGSTER1
	const_export ROUTE6_COOLTRAINER_M2
	const_export ROUTE6_COOLTRAINER_F2
	const_export ROUTE6_YOUNGSTER2
	const_export ROUTE6_GARDENER ; v1.0 (2026-09-07, Forte): the old man who keeps the garden

Route6_Object:
	db $f ; border block

	def_warp_events
; The gate's roof is on row 0, flush with SAFFRON's seam: the square a player
; stands on when bumping its back wall is SAFFRON (20,35)/(21,35), so the
; north-door warps live there (SAFFRON warps 9-10) and the gate names them.
; v1.0 (2026-09-22): the two dead warps that used to sit on the roof tiles
; (9,0)/(10,0) are gone; the gate's south door and the UNDERGROUND PATH's exit
; were renumbered with these (ROUTE_6 1 and LAST_MAP 2).
	warp_event 10,  3, ROUTE_6_GATE, 1
	warp_event 17,  9, UNDERGROUND_PATH_ROUTE_6, 1

	def_bg_events
	bg_event 17, 11, TEXT_ROUTE6_UNDERGROUND_PATH_SIGN

	def_object_events
; v1.0 (2026-09-07): the two JR.TRAINER♂ wear the YOUNGSTER (their class pic is the camper boy);
; that freed the set's COOLTRAINER_M slot for the gardener's GRAMPS (sprite_sets.asm).
	object_event 10, 21, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_ROUTE6_COOLTRAINER_M1, OPP_JR_TRAINER_M, 10, 0
	object_event 11, 21, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_ROUTE6_COOLTRAINER_F1, OPP_JR_TRAINER_F, 25, 0
	object_event  2, 18, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_ROUTE6_YOUNGSTER1, OPP_BUG_CATCHER, 10, 4
	object_event 11, 31, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_ROUTE6_COOLTRAINER_M2, OPP_JR_TRAINER_M, 5, 3
	object_event 11, 30, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_ROUTE6_COOLTRAINER_F2, OPP_JR_TRAINER_F, 3, 3
	object_event 17, 26, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_ROUTE6_YOUNGSTER2, OPP_BUG_CATCHER, 11, 3
; v1.0 (2026-09-07, Forte): the gardener, wandering the flower strip right below the SAFFRON
; gate (row 5, between the gate and the hedge). A plain object: his text id sits within the
; first 7 entries of the table.
	object_event  7,  5, SPRITE_GRAMPS, WALK, LEFT_RIGHT, TEXT_ROUTE6_GARDENER

	def_warps_to ROUTE_6
