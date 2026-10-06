MACRO force_bike_surf
	db \1, \3, \2
ENDM

ForcedBikeOrSurfMaps:
	; map id, x, y
	; ROUTE_16 / ROUTE_18: the two cells of each gate's west door (the Cycling Road side), where the
	; gate's LAST_MAP exits 1 and 2 land and the bike is forced; they move with that door's warp_event
	; lines (data/maps/objects/Route16.asm, Route18.asm).
	force_bike_surf ROUTE_16,            17, 10
	force_bike_surf ROUTE_16,            17, 11
	force_bike_surf ROUTE_18,            29,  8
	force_bike_surf ROUTE_18,            29,  9
	force_bike_surf SEAFOAM_ISLANDS_B3F, 18,  7
	force_bike_surf SEAFOAM_ISLANDS_B3F, 19,  7
	force_bike_surf SEAFOAM_ISLANDS_B4F,  4, 14
	force_bike_surf SEAFOAM_ISLANDS_B4F,  5, 14
	db -1 ; end
