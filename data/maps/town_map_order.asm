; v1.0 (2026-09-24, Forte): the cursor walks the story - PALLET to the CERULEAN
; CAVE - and stops at the places drawn on the map plus the four services a
; player asks "where was that again?" about: the DAY CARE, the NAME RATER, the
; MOVE DELETER and the MOVE RELEARNER (the last two share one room, so each
; borrows an unused map id - constants/map_constants.asm). S.S. ANNE is gone
; (the ship leaves). Three stops are secrets until the player has been inside -
; BILL's LAB, the POWER PLANT and the CERULEAN CAVE (TownMapSecretStops,
; engine/items/town_map.asm): the cursor skips them until then.
TownMapOrder:
	db PALLET_TOWN
	db ROUTE_1
	db VIRIDIAN_CITY
	db ROUTE_22
	db ROUTE_2
	db VIRIDIAN_FOREST
	db PEWTER_CITY
	db ROUTE_3
	db MT_MOON_1F
	db ROUTE_4
	db CERULEAN_CITY
	db ROUTE_24
	db ROUTE_25
	db BILLS_HOUSE ; secret
	db ROUTE_5
	db DAYCARE
	db ROUTE_6
	db VERMILION_CITY
	db DIGLETTS_CAVE
	db ROUTE_11
	db ROUTE_9
	db ROUTE_10
	db ROCK_TUNNEL_1F
	db POWER_PLANT ; secret
	db LAVENDER_TOWN
	db NAME_RATERS_HOUSE
	db POKEMON_TOWER_2F
	db ROUTE_8
	db ROUTE_7
	db CELADON_CITY
	db SAFFRON_CITY
	db ROUTE_16
	db ROUTE_17
	db ROUTE_18
	db ROUTE_12
	db ROUTE_13
	db ROUTE_14
	db ROUTE_15
	db FUCHSIA_CITY
	db SAFARI_ZONE_EAST
	db ROUTE_19
	db SEAFOAM_ISLANDS_B1F
	db ROUTE_20
	db CINNABAR_ISLAND
	db TOWN_MAP_MOVE_DELETER
	db TOWN_MAP_MOVE_RELEARNER
	db ROUTE_21
	db ROUTE_23
	db VICTORY_ROAD_3F
	db INDIGO_PLATEAU
	db CERULEAN_CAVE_1F ; secret
TownMapOrderEnd:
