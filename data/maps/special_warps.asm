; Format: (size 2 bytes)
; 00: target map ID
; 01: which dungeon warp in the source map was used
DungeonWarpList:
	db SEAFOAM_ISLANDS_B1F, 1
	db SEAFOAM_ISLANDS_B1F, 2
	db SEAFOAM_ISLANDS_B2F, 1
	db SEAFOAM_ISLANDS_B2F, 2
	db SEAFOAM_ISLANDS_B3F, 1
	db SEAFOAM_ISLANDS_B3F, 2
	db SEAFOAM_ISLANDS_B4F, 1
	db SEAFOAM_ISLANDS_B4F, 2
	db VICTORY_ROAD_2F,     2
	db POKEMON_MANSION_1F,  1
	db POKEMON_MANSION_1F,  2
	db POKEMON_MANSION_2F,  3
	db -1 ; end


MACRO fly_warp
	event_displacement \1_WIDTH, \2, \3
	db ((\3) & $01) ;sub-block Y
	db ((\2) & $01) ;sub-block X
ENDM

DungeonWarpData:
	fly_warp SEAFOAM_ISLANDS_B1F, 18,  7
	fly_warp SEAFOAM_ISLANDS_B1F, 23,  7
	fly_warp SEAFOAM_ISLANDS_B2F, 19,  7
	fly_warp SEAFOAM_ISLANDS_B2F, 22,  7
	fly_warp SEAFOAM_ISLANDS_B3F, 18,  7
	fly_warp SEAFOAM_ISLANDS_B3F, 19,  7
	fly_warp SEAFOAM_ISLANDS_B4F,  4, 14
	fly_warp SEAFOAM_ISLANDS_B4F,  5, 14
	fly_warp VICTORY_ROAD_2F,     22, 16
	fly_warp POKEMON_MANSION_1F,  16, 14
	fly_warp POKEMON_MANSION_1F,  16, 14
	fly_warp POKEMON_MANSION_2F,  18, 14


MACRO special_warp_spec
	db \1
	fly_warp \1, \2, \3
	db \4
ENDM

NewGameWarp:
	special_warp_spec REDS_HOUSE_2F, 3, 6, REDS_HOUSE_2


; \1 = the key: what the FLY list (an interior's own map id, since 2026-09-24) or
;      wLastBlackoutMap (the town / route of the last CENTER) holds
; \2 = the map the player lands on: the key itself for a town or a route, the
;      map outside the door for an interior. Always written out (PALLET TOWN is
;      map id 0, so "0 = the key" would have made it unrepresentable).
; \3 = the landing row below
; LoadSpecialWarpData matches the key and writes \2 to wCurMap.
; No terminator: a key that is not here runs into the rows (vanilla).
MACRO fly_warp_spec
	db \1, \2
	dw \3
ENDM

FlyWarpDataPtr:
	fly_warp_spec PALLET_TOWN,     PALLET_TOWN,     .PalletTown
	fly_warp_spec VIRIDIAN_CITY,   VIRIDIAN_CITY,   .ViridianCity
	fly_warp_spec PEWTER_CITY,     PEWTER_CITY,     .PewterCity
	fly_warp_spec CERULEAN_CITY,   CERULEAN_CITY,   .CeruleanCity
	fly_warp_spec LAVENDER_TOWN,   LAVENDER_TOWN,   .LavenderTown
	fly_warp_spec VERMILION_CITY,  VERMILION_CITY,  .VermilionCity
	fly_warp_spec CELADON_CITY,    CELADON_CITY,    .CeladonCity
	fly_warp_spec FUCHSIA_CITY,    FUCHSIA_CITY,    .FuchsiaCity
	fly_warp_spec CINNABAR_ISLAND, CINNABAR_ISLAND, .CinnabarIsland
	fly_warp_spec INDIGO_PLATEAU,  INDIGO_PLATEAU,  .IndigoPlateau
	fly_warp_spec SAFFRON_CITY,    SAFFRON_CITY,    .SaffronCity
	fly_warp_spec ROUTE_4,         ROUTE_4,         .Route4  ; blackouts from MT.MOON's CENTER
	fly_warp_spec ROUTE_10,        ROUTE_10,        .Route10 ; blackouts from ROCK TUNNEL's CENTER
; v1.0 (2026-09-24, Forte): the FLY list names interiors; each lands one cell
; below its door, the rule every other fly point follows (fly_point_rule.py).
	fly_warp_spec MT_MOON_POKECENTER,     ROUTE_4,       .Route4
	fly_warp_spec ROCK_TUNNEL_POKECENTER, ROUTE_10,      .Route10
	fly_warp_spec BILLS_HOUSE,            ROUTE_25,      .Route25
	fly_warp_spec DAYCARE,                ROUTE_5,       .DayCare
	fly_warp_spec POWER_PLANT,            ROUTE_10,      .PowerPlant
	fly_warp_spec SEAFOAM_ISLANDS_1F,     ROUTE_20,      .Seafoam
	fly_warp_spec VICTORY_ROAD_1F,        ROUTE_23,      .VictoryRoad
	fly_warp_spec CERULEAN_CAVE_1F,       CERULEAN_CITY, .CeruleanCave

.PalletTown:     fly_warp PALLET_TOWN,      5,  6
.ViridianCity:   fly_warp VIRIDIAN_CITY,   23, 26
.PewterCity:     fly_warp PEWTER_CITY,     13, 26
; v0.7 (2026-08-07): was (19, 18). The city rework left that cell inside the
; mart's fence line -- flying in stranded the player on a tile with no
; walkable neighbour, a hard soft-lock. Now the plaza cell in front of the
; POKeMON CENTER door at (21, 25), the same convention as the other cities.
.CeruleanCity:   fly_warp CERULEAN_CITY,   21, 26
.LavenderTown:   fly_warp LAVENDER_TOWN,    7,  8
.VermilionCity:  fly_warp VERMILION_CITY,  11,  4
.CeladonCity:    fly_warp CELADON_CITY,    35,  8
.FuchsiaCity:    fly_warp FUCHSIA_CITY,    25, 28
.CinnabarIsland: fly_warp CINNABAR_ISLAND, 13, 38
.IndigoPlateau:  fly_warp INDIGO_PLATEAU,   9,  6
.SaffronCity:    fly_warp SAFFRON_CITY,     9, 30
.Route4:         fly_warp ROUTE_4,         11,  6
.Route10:        fly_warp ROUTE_10,        11, 22
; BILL's LAB. ROUTE 25 has no POKeMON CENTER, so by the same rule as PALLET
; and INDIGO it lands one cell below the map's first warp -- which here is BILL's
; own front door at (53, 5).
.Route25:        fly_warp ROUTE_25,        53,  6
; v1.0 (2026-09-24, Forte): the interiors' landing cells, one below each door.
; The POWER PLANT's and the CERULEAN CAVE's are strips of land reached only by SURF:
; whoever flies there has been inside, so has SURF. All five are land tiles.
.DayCare:        fly_warp ROUTE_5,        10, 22 ; the DAY CARE's door is (10, 21)
.PowerPlant:     fly_warp ROUTE_10,        4, 42 ; the POWER PLANT's door is (4, 41)
.Seafoam:        fly_warp ROUTE_20,       46,  8 ; SEAFOAM's west door is (46, 7)
.VictoryRoad:    fly_warp ROUTE_23,        4, 32 ; VICTORY ROAD's 1F door is (4, 31)
.CeruleanCave:   fly_warp CERULEAN_CITY,   6, 12 ; the cave's door is (6, 11)
