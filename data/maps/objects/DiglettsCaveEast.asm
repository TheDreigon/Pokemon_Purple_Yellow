; DIGLETT's CAVE from block column 25 of maps/DiglettsCave.blk on (maps.asm): a cell (x, y) of that master
; is (x - 50, y) here. Nothing stands within 5 cells of the seam: x 0-4 here, x 45-49 in DiglettsCave.asm.
DiglettsCaveEast_Object:
	db $19 ; border block

	def_warp_events
	warp_event 45, 55, DIGLETTS_CAVE_ROUTE_11, 3

	def_bg_events

	def_object_events

	def_warps_to DIGLETTS_CAVE_EAST
