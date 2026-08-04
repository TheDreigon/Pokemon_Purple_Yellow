	object_const_def
	const_export PALLETTOWN_OAK
	const_export PALLETTOWN_GIRL
	const_export PALLETTOWN_FISHER
	const_export PALLETTOWN_MOM

PalletTown_Object:
	db $b ; border block

	def_warp_events
	warp_event  5,  5, REDS_HOUSE_1F, 1
	warp_event 13,  5, BLUES_HOUSE, 1
	warp_event 12, 11, OAKS_LAB, 2

	def_bg_events
	bg_event 13, 13, TEXT_PALLETTOWN_OAKSLAB_SIGN
	bg_event  7,  9, TEXT_PALLETTOWN_SIGN
	bg_event  3,  5, TEXT_PALLETTOWN_PLAYERSHOUSE_SIGN
	bg_event 11,  5, TEXT_PALLETTOWN_RIVALSHOUSE_SIGN

	def_object_events
	object_event 10,  4, SPRITE_OAK, STAY, NONE, TEXT_PALLETTOWN_OAK
	object_event 13, 16, SPRITE_GIRL, WALK, ANY_DIR, TEXT_PALLETTOWN_GIRL
	object_event  5, 14, SPRITE_FISHER, WALK, ANY_DIR, TEXT_PALLETTOWN_FISHER
; v0.7: the player's MOTHER, hidden by default (HS_PALLET_TOWN_MOM) and shown
; only for the TRAINER MANUAL scene, the way PALLETTOWN_OAK is shown only for
; his. Appended last so no earlier object const shifts. These coordinates are
; her doorstep; the script moves her before showing her.
	object_event  5,  6, SPRITE_MOM, STAY, DOWN, TEXT_PALLETTOWN_MOM

	def_warps_to PALLET_TOWN
