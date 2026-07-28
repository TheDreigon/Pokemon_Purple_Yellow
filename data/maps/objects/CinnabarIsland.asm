	object_const_def
	const_export CINNABARISLAND_GIRL
	const_export CINNABARISLAND_GAMBLER

CinnabarIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event   8, 23, POKEMON_MANSION_1F, 2
	warp_event 22, 29, CINNABAR_GYM, 1
	warp_event  22, 39, CINNABAR_LAB, 1
	warp_event 13, 37, CINNABAR_POKECENTER, 1
	warp_event  9, 33, CINNABAR_MART, 1

	def_bg_events
	bg_event  15, 27, TEXT_CINNABARISLAND_SIGN
	bg_event 10, 33, TEXT_CINNABARISLAND_MART_SIGN
	bg_event 14, 37, TEXT_CINNABARISLAND_POKECENTER_SIGN
	bg_event  19, 39, TEXT_CINNABARISLAND_POKEMONLAB_SIGN
	bg_event 23, 31, TEXT_CINNABARISLAND_GYM_SIGN

	def_object_events
	object_event 31, 30, SPRITE_GIRL, WALK, UP_DOWN, TEXT_CINNABARISLAND_GIRL
	object_event 13,  9, SPRITE_GAMBLER, WALK, LEFT_RIGHT, TEXT_CINNABARISLAND_GAMBLER

	def_warps_to CINNABAR_ISLAND
