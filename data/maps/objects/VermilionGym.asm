	object_const_def
	const_export VERMILIONGYM_LT_SURGE
	const_export VERMILIONGYM_VISQUEZ ; the gym rework (2026-09-06): Surge's second-in-command
	const_export VERMILIONGYM_SAILOR1 ; his two subordinates (anime EP014)
	const_export VERMILIONGYM_SAILOR2
	const_export VERMILIONGYM_GYM_GUIDE

VermilionGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 17, LAST_MAP, 4
	warp_event  5, 17, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_SURGE, STAY, DOWN, TEXT_VERMILIONGYM_LT_SURGE, OPP_LT_SURGE, 1
; v1.0 (the gym rework, 2026-09-06): Lt. Surge's people. VISQUEZ, his trained
; second (Journeys), stands at (3,6) facing RIGHT so she sees (4,6) and (5,6) -
; the two tiles under the door corridor that every player must step on - the
; last fight before Surge. The two SAILORs are the subordinates who mock the
; Pikachu in the anime; they keep the two trash-can hints in their after-lines.
	object_event  3,  6, SPRITE_COOLTRAINER_F, STAY, RIGHT, TEXT_VERMILIONGYM_VISQUEZ, OPP_COOLTRAINER_F, 9, 2
	object_event  3,  8, SPRITE_SAILOR, STAY, LEFT, TEXT_VERMILIONGYM_SAILOR1, OPP_SAILOR, 9, 2
	object_event  0, 10, SPRITE_SAILOR, STAY, RIGHT, TEXT_VERMILIONGYM_SAILOR2, OPP_SAILOR, 8, 3
	object_event  7, 14, SPRITE_GYM_GUIDE, STAY, DOWN, TEXT_VERMILIONGYM_GYM_GUIDE

	def_warps_to VERMILION_GYM
