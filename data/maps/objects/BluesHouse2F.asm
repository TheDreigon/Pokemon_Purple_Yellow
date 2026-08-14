BluesHouse2F_Object:
	db $a ; border block

	def_warp_events
; Down to BLUES_HOUSE warp 3, which is the staircase warp appended to that map's
; array - the same shape REDS_HOUSE_2F has, where warp 3 of REDS_HOUSE_1F is its
; own staircase and warps 1 and 2 are the two tiles of the front door.
	warp_event  7,  1, BLUES_HOUSE, 3

	def_bg_events

; No objects and no bg events, exactly like the player's own upstairs. The SNES
; and the PC up here are HIDDEN OBJECTS, in data/events/hidden_objects.asm, at
; the same two coordinates the player's room uses.
	def_object_events

	def_warps_to BLUES_HOUSE_2F
