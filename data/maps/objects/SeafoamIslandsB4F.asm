	object_const_def
	const_export SEAFOAMISLANDSB4F_BOULDER1
	const_export SEAFOAMISLANDSB4F_BOULDER2
	const_export SEAFOAMISLANDSB4F_ARTICUNO
	const_export SEAFOAM_ISLANDS_WEEBRA
	const_export SEAFOAMISLANDSB4F_TM_ICE_BEAM

SeafoamIslandsB4F_Object:
	db $7d ; border block

	def_warp_events
	warp_event 20, 17, SEAFOAM_ISLANDS_B3F, 6
	warp_event 21, 17, SEAFOAM_ISLANDS_B3F, 7
	warp_event 11,  7, SEAFOAM_ISLANDS_B3F, 2
	warp_event 25,  4, SEAFOAM_ISLANDS_B3F, 3

	def_bg_events
	bg_event  9, 15, TEXT_SEAFOAMISLANDSB4F_BOULDERS_SIGN
	bg_event 23,  1, TEXT_SEAFOAMISLANDSB4F_DANGER_SIGN

	def_object_events
	object_event  4, 15, SPRITE_BOULDER, STAY, NONE, TEXT_SEAFOAMISLANDSB4F_BOULDER1
	object_event  5, 15, SPRITE_BOULDER, STAY, NONE, TEXT_SEAFOAMISLANDSB4F_BOULDER2
	object_event  6,  1, SPRITE_ARTICUNO, STAY, DOWN, TEXT_SEAFOAMISLANDSB4F_ARTICUNO, ARTICUNO, 50
	object_event  6, 1, SPRITE_KRIS, WALK, ANY_DIR, TEXT_SEAFOAM_ISLANDS_WEEBRA, OPP_WEEBRA, 1 ; spawns on Articuno's tile (6,1), then wanders (WALK); missable HIDE, shown by script only post-Articuno + post-League. Talk-triggered, headerless.
	object_event 15,  8, SPRITE_POKE_BALL, STAY, NONE, TEXT_SEAFOAMISLANDSB4F_TM_ICE_BEAM, TM_ICE_BEAM

	def_warps_to SEAFOAM_ISLANDS_B4F
