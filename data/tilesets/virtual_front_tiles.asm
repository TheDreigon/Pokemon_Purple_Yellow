; v1.0 (2026-11-27): cells drawn as one tile that act as another, for everything that asks for the tile in front of
; the player (VirtualFrontTile, engine/overworld/player_state.asm): collision on land and on water, the warp carpets,
; ledges, surfing, fishing. Map, y, x (the cell in front, in map coordinates), the tile it acts as.
VirtualFrontTiles:
; VERMILION CITY's dock: the two cells right below the S.S. ANNE warp are drawn as the pier plank $3C and act as $04,
; as they did when block $05 drew $04 itself. As $04 they are not walkable (no one walks or surfs in from the south,
; which also keeps the sea south of the bollards, and the map's south edge, out of reach) and they are a facing-down
; warp carpet, so the step down onto the warp takes the player to the dock. Tile slot $04 now holds a new
; mountain-tip diagonal (block $80), so the plank's twin had no slot of its own left.
	db VERMILION_CITY, 32, 18, $04
	db VERMILION_CITY, 32, 19, $04
	db -1 ; end
