	object_const_def
	const_export ROUTE5_LITTLE_GIRL
	const_export ROUTE5_YOUNGSTER
	const_export ROUTE5_COOLTRAINER_M

Route5_Object:
	db $a ; border block

	def_warp_events
	warp_event 10, 37, ROUTE_5_GATE, 3
	warp_event  9, 37, ROUTE_5_GATE, 3
	warp_event 10, 41, ROUTE_5_GATE, 1
	warp_event 17, 33, UNDERGROUND_PATH_ROUTE_5, 1
	warp_event 10, 21, DAYCARE, 1

	def_bg_events
	bg_event 17, 35, TEXT_ROUTE5_UNDERGROUND_PATH_SIGN
	bg_event  9, 25, TEXT_ROUTE5_DAYCARE_SIGN

	def_object_events
; COOLTRAINER_F rather than LITTLE_GIRL: Route 5 is a split-set map (PEWTER_
; CERULEAN north of row 41, SAFFRON south) and neither set carries
; LITTLE_GIRL -- the nine walking slots of both are full, and the two tail
; slots only take four-tile sprites. Getting the actual little girl here
; costs evicting a sprite some other map uses (Forte's call, not mine).
; LEFT_RIGHT rather than ANY_DIR on purpose: her sprite is not in the
; SAFFRON set either, so she must never wander into view of a player
; standing in the southern strip.
	object_event  8, 27, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, TEXT_ROUTE5_LITTLE_GIRL
	object_event 12, 36, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, TEXT_ROUTE5_YOUNGSTER
; Vouches for the day care: the gentleman's trainer past, the daughter's
; POKeMON CENTER past (Forte's lore, 2026-08-07).
	object_event  4, 32, SPRITE_COOLTRAINER_M, WALK, UP_DOWN, TEXT_ROUTE5_COOLTRAINER_M

	def_warps_to ROUTE_5
