	object_const_def
	const_export ROUTE20_SWIMMER1
	const_export ROUTE20_SWIMMER2
	const_export ROUTE20_SWIMMER3
	const_export ROUTE20_SWIMMER4
	const_export ROUTE20_SWIMMER5
	const_export ROUTE20_SWIMMER6
	const_export ROUTE20_COOLTRAINER_M
	const_export ROUTE20_SWIMMER7
	const_export ROUTE20_SWIMMER8
	const_export ROUTE20_SWIMMER9

Route20_Object:
	db $43 ; border block

	def_warp_events
	warp_event 46,  7, SEAFOAM_ISLANDS_1F, 1
	warp_event 58, 11, SEAFOAM_ISLANDS_1F, 3

	def_bg_events
	bg_event 45,  9, TEXT_ROUTE20_SEAFOAM_ISLANDS_WEST_SIGN
	bg_event 57, 15, TEXT_ROUTE20_SEAFOAM_ISLANDS_EAST_SIGN

	def_object_events
	object_event 83,  7, SPRITE_SWIMMER, STAY, UP, TEXT_ROUTE20_SWIMMER1, OPP_SWIMMER, 9, 4
	object_event 46, 18, SPRITE_SWIMMER, STAY, UP, TEXT_ROUTE20_SWIMMER2, OPP_BEAUTY, 15, 4
	object_event  9,  6, SPRITE_SWIMMER, STAY, DOWN, TEXT_ROUTE20_SWIMMER3, OPP_BEAUTY, 6, 2
	object_event 78,  8, SPRITE_SWIMMER, STAY, RIGHT, TEXT_ROUTE20_SWIMMER4, OPP_JR_TRAINER_F, 24, 4
	object_event 40, 14, SPRITE_SWIMMER, STAY, DOWN, TEXT_ROUTE20_SWIMMER5, OPP_SWIMMER, 10, 3
	object_event 82, 14, SPRITE_SWIMMER, STAY, UP, TEXT_ROUTE20_SWIMMER6, OPP_SWIMMER, 11, 4
	object_event 34,  9, SPRITE_YOUNGSTER, STAY, UP, TEXT_ROUTE20_COOLTRAINER_M, OPP_BIRD_KEEPER, 11, 2 ; v0.7: was COOLTRAINER_M, which left the west-half set when MOM took its slot -- the miss fell back to the PLAYER's tiles (a RED clone in the sea). YOUNGSTER is in BOTH of Route 20's sets, stands on land, and fits the stranded bird-kid dialog.
	object_event  5, 13, SPRITE_SWIMMER, STAY, UP, TEXT_ROUTE20_SWIMMER7, OPP_BEAUTY, 7, 4
	object_event 54, 19, SPRITE_SWIMMER, STAY, DOWN, TEXT_ROUTE20_SWIMMER8, OPP_JR_TRAINER_F, 16, 3
	object_event 13, 17, SPRITE_SWIMMER, STAY, UP, TEXT_ROUTE20_SWIMMER9, OPP_BEAUTY, 8, 4

	def_warps_to ROUTE_20
