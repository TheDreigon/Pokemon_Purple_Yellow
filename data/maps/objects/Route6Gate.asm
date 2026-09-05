	object_const_def
	const_export ROUTE6GATE_GUARD

Route6Gate_Object:
	db $a ; border block

	def_warp_events
; v0.7 (2026-09-05, Forte): named, not LAST_MAP. The north door is entered
; from SAFFRON CITY (the gate's back wall sits on the seam - see Route6.asm), so
; LAST_MAP would have sent a player who came in from the city out through the
; city's 3rd warp, the GYM. home/overworld.asm treats a named town like LAST_MAP.
	warp_event  3,  5, ROUTE_6, 3
	warp_event  4,  5, ROUTE_6, 3
	warp_event  3,  0, SAFFRON_CITY, 9
	warp_event  4,  0, SAFFRON_CITY, 10

	def_bg_events

	def_object_events
	object_event  6,  2, SPRITE_GUARD, STAY, LEFT, TEXT_ROUTE6GATE_GUARD

	def_warps_to ROUTE_6_GATE
