	map_header LavenderTown, LAVENDER_TOWN, OVERWORLD, NORTH | SOUTH | WEST
	connection north, Route10, ROUTE_10, 2 ; Lavender gained 2 columns on its WEST side, so its content sits 2 blocks further right; +2 keeps the Route 10 path over the town gate. Mirror in Route10.asm is -2.
	connection south, Route12, ROUTE_12, 2 ; mirror of Route 12's -2, same 2-column shift as the north side
	connection west, Route8, ROUTE_8, 0
	end_map_header
