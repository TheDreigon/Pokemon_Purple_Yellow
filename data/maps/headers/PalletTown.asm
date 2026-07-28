	map_header PalletTown, PALLET_TOWN, OVERWORLD, NORTH | SOUTH
	connection north, Route1, ROUTE_1, 0
	connection south, Route21, ROUTE_21, -3 ; Route 21 gained 3 columns on its WEST side, so its old content sits 3 blocks further right; -3 keeps Pallet over the same water it always was. Mirror in Route21.asm is +3.
	end_map_header
