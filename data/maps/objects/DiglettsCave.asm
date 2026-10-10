; DIGLETT's CAVE up to block column 24 of maps/DiglettsCave.blk (maps.asm): a cell (x, y) of that master is
; (x, y) here, and from x 50 on it is DiglettsCaveEast.asm's. Nothing stands within 5 cells of the seam:
; x 45-49 here, x 0-4 there.
DiglettsCave_Object:
	db $19 ; border block

	def_warp_events
	warp_event  5,  5, DIGLETTS_CAVE_ROUTE_2, 3

	def_bg_events

	def_object_events

	def_warps_to DIGLETTS_CAVE
