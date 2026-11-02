; v1.0 (2026-11-02): the cuttable tree of each tileset that has one - the tile CUT looks for in front of the player,
; the bottom-left tile of the tree's 2x2 cell (the tile the collision test reads; none of the three is walkable).
; One table for every reader: UsedCut, IsCutTile (the A in front of a tree) and the tile read in front of the player
; (IsCutTreeTile). OVERWORLD's tall grass ($52), which UsedCut cuts too, is not a tree and is not listed.
CutTreeTiles:
	db OVERWORLD, $3d
	db GYM,       $50
	db FOREST,    $58 ; v1.0 (2026-11-02): OVERWORLD's tree on forest ground, tiles $10 $11 / $58 $59
	db -1 ; end

CutTreeBlockSwaps:
	; first byte = tileset block containing the cut tree
	; second byte = corresponding tileset block after the cut animation happens
	; One table for every tileset, read by block id alone: an id must hold a cut tree in one tileset at most.
	db $32, $6D
	db $33, $6C
	db $34, $6F
	db $35, $4C
	db $60, $6E
	db $0B, $0A
	db $3C, $35
	db $3F, $35
	db $3D, $36
	; FOREST (v1.0, 2026-11-02): OVERWORLD's five tree blocks ($32 $33 $34 $35 $60) drawn with the forest's ground
	; and the SAFARI's bush; four of the blocks CUT leaves were already in the tileset
	db $76, $7F
	db $77, $7D
	db $78, $7C
	db $79, $7B
	db $7A, $7E
	db -1 ; end
