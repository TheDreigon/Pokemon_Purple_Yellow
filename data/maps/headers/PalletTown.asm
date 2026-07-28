	map_header PalletTown, PALLET_TOWN, OVERWORLD, NORTH | SOUTH
	connection north, Route1, ROUTE_1, 0
	connection south, Route21, ROUTE_21, -1 ; Route 21 gained a column on its WEST side, so its old content sits one block further right; -1 keeps Pallet over the same water it always was. Mirror in Route21.asm is +1.
	end_map_header
