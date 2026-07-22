	object_const_def
	const_export CELADONMANSION_ROOF_HOUSE_PROGRAMMER
	const_export CELADONMANSION_ROOF_HOUSE_PROTOTYPE_BALL

CeladonMansionRoofHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, CELADON_MANSION_ROOF, 3
	warp_event  3,  7, CELADON_MANSION_ROOF, 3

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_SUPER_NERD, STAY, DOWN, TEXT_CELADONMANSION_ROOF_HOUSE_PROGRAMMER
	object_event  4,  3, SPRITE_POKE_BALL, STAY, NONE, TEXT_CELADONMANSION_ROOF_HOUSE_PROTOTYPE_BALL

	def_warps_to CELADON_MANSION_ROOF_HOUSE
