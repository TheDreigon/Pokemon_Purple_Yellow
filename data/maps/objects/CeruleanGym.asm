	object_const_def
	const_export CERULEANGYM_MISTY
	const_export CERULEANGYM_DAISY  ; the SENSATIONAL SISTERS (the gym rework, 2026-09-06)
	const_export CERULEANGYM_VIOLET
	const_export CERULEANGYM_LILY
	const_export CERULEANGYM_GYM_GUIDE

CeruleanGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 13, LAST_MAP, 4
	warp_event  5, 13, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  4,  2, SPRITE_MISTY, STAY, DOWN, TEXT_CERULEANGYM_MISTY, OPP_MISTY, 1
; v1.0 (the gym rework, 2026-09-06): Misty's three sisters, the SENSATIONAL
; SISTERS (anime EP007 / EP061; Let's Go), youngest to eldest along the way in.
; DAISY (BEAUTY, the eldest) watches the row-3 corridor every player crosses to
; reach Misty; VIOLET (JR.TRAINER♀) the right-hand column; LILY (LASS) stands
; beside the corridor mouth at (3,8) facing RIGHT, so she sees (4,8)/(5,8) - the
; tiles every player steps onto from the entrance corridor - without blocking.
	object_event  2,  3, SPRITE_BEAUTY, STAY, RIGHT, TEXT_CERULEANGYM_DAISY, OPP_BEAUTY, 17, 3
	object_event  8,  7, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_CERULEANGYM_VIOLET, OPP_JR_TRAINER_F, 2, 3
	object_event  3,  8, SPRITE_GIRL, STAY, RIGHT, TEXT_CERULEANGYM_LILY, OPP_LASS, 21, 2 ; the LASS pic's girl (was LITTLE_GIRL, a child - she is the youngest sister, not a kid; 2026-09-07) ; the little-girl sprite: the youngest
	object_event  7, 11, SPRITE_GYM_GUIDE, STAY, DOWN, TEXT_CERULEANGYM_GYM_GUIDE

	def_warps_to CERULEAN_GYM
