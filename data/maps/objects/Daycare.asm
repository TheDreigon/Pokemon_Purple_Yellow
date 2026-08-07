	object_const_def
	const_export DAYCARE_GENTLEMAN
	const_export DAYCARE_ODDISH
	const_export DAYCARE_JIGGLYPUFF
	const_export DAYCARE_PIDGEY
	const_export DAYCARE_PSYDUCK
	const_export DAYCARE_SLOWPOKE
	const_export DAYCARE_MEOWTH

Daycare_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 5
	warp_event  3,  7, LAST_MAP, 5
	warp_event  7,  1, DAYCARE_2F, 1

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GENTLEMAN, STAY, RIGHT, TEXT_DAYCARE_GENTLEMAN
; The current boarders. Only PIDGEY has a 24-tile sheet with walk frames;
; the others are 12-tile stills -- a still sprite set to WALK animates with
; whatever sprite sits NEXT in the ROM, which is the flicker Forte saw.
; STAY sprites still turn to face the player when spoken to.
	object_event  5,  3, SPRITE_ODDISH, STAY, NONE, TEXT_DAYCARE_ODDISH
	object_event  0,  4, SPRITE_JIGGLYPUFF, STAY, NONE, TEXT_DAYCARE_JIGGLYPUFF
	object_event  7,  5, SPRITE_PIDGEY, WALK, ANY_DIR, TEXT_DAYCARE_PIDGEY
	object_event  4,  5, SPRITE_PSYDUCK, STAY, NONE, TEXT_DAYCARE_PSYDUCK
	object_event  6,  2, SPRITE_SLOWPOKE, WALK, ANY_DIR, TEXT_DAYCARE_SLOWPOKE
	object_event  1,  6, SPRITE_MEOWTH, STAY, NONE, TEXT_DAYCARE_MEOWTH

	def_warps_to DAYCARE
