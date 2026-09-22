	object_const_def
	const_export CELADONMANSION_ROOF_HOUSE_PROGRAMMER

CeladonMansionRoofHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, CELADON_MANSION_ROOF, 3
	warp_event  3,  7, CELADON_MANSION_ROOF, 3

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_SUPER_NERD, STAY, DOWN, TEXT_CELADONMANSION_ROOF_HOUSE_PROGRAMMER

	def_warps_to CELADON_MANSION_ROOF_HOUSE
