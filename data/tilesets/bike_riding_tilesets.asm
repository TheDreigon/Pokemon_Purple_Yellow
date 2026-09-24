BikeRidingTilesets::
	db OVERWORLD
	db FOREST
	db UNDERGROUND
	db SHIP_PORT
	db CAVERN
; v1.0 (2026-09-24): ride through the gates. Every gate (ROUTE 2/5/6/7/8/22,
; both floors of the ROUTE 11/12/15/16/18 gates), the SAFARI ZONE gate and its
; rest houses and the four UNDERGROUND PATH entrances share this tileset, and
; each sits between two places you can already ride in. Warping into one no
; longer dismounts (LoadPlayerSpriteGraphics.startWalking) and USE BICYCLE
; inside works. The ROUTE 16/18 gates still clear the forced-bike bit in their
; map scripts, so "can't get off here" ends at their door.
	db GATE
	db -1 ; end
