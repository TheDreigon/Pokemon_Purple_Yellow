	map_header CinnabarIsland, CINNABAR_ISLAND, OVERWORLD, NORTH | EAST
	connection north, Route21, ROUTE_21, 1 ; world-design: was +4 when Route 21 was 10 wide; the route gained 3 columns on its WEST side, which already shifts its content 3 blocks right, so the offset drops by one to keep the same on-screen alignment. Mirror in Route21.asm must stay -1.
	connection east, Route20, ROUTE_20, 8 ; drops Route 20 by 8 so its top shore corner (its row 0) lands on the island's own shore corner at row 8, and its water rows 1-8 face the island's channel rows 9-16. Mirror in Route20.asm must stay -8.
	end_map_header
