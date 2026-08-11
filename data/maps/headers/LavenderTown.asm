	map_header LavenderTown, LAVENDER_TOWN, OVERWORLD, NORTH | SOUTH | WEST
	; Offsets are in BLOCKS, and each one lines the neighbour's gate up with
	; ours. Measure, never guess: a map's walkable edge cells are what decide
	; these, and .claude/seam_align.py prints both edges.
	;   north gate: Lavender cells 12-15, Route 10 cells 6-9  -> 6 + 2*3 = 12
	;   south gate: Lavender cells 14-17, Route 12 cells 8-11 -> 8 + 2*3 = 14
	;   west  gate: Lavender cells 10-11, Route 8  cells 8-9  -> 8 + 2*1 = 10
	connection north, Route10, ROUTE_10, 3 ; mirror in Route10.asm is -3
	connection south, Route12, ROUTE_12, 3 ; mirror in Route12.asm is -3
	connection west, Route8, ROUTE_8, 1 ; mirror in Route8.asm is -1
	end_map_header
