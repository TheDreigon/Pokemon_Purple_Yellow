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
TradeCenterPlayerWarp:
	special_warp_spec TRADE_CENTER,  3, 4, CLUB
TradeCenterFriendWarp:
	special_warp_spec TRADE_CENTER,  6, 4, CLUB
ColosseumPlayerWarp:
	special_warp_spec COLOSSEUM,     3, 4, CLUB
ColosseumFriendWarp:
	special_warp_spec COLOSSEUM,     6, 4, CLUB


MACRO fly_warp_spec
	db \1, 0
	dw \2
ENDM

FlyWarpDataPtr:
	fly_warp_spec PALLET_TOWN,     .PalletTown
	fly_warp_spec VIRIDIAN_CITY,   .ViridianCity
	fly_warp_spec PEWTER_CITY,     .PewterCity
	fly_warp_spec CERULEAN_CITY,   .CeruleanCity
	fly_warp_spec LAVENDER_TOWN,   .LavenderTown
	fly_warp_spec VERMILION_CITY,  .VermilionCity
	fly_warp_spec CELADON_CITY,    .CeladonCity
	fly_warp_spec FUCHSIA_CITY,    .FuchsiaCity
	fly_warp_spec CINNABAR_ISLAND, .CinnabarIsland
	fly_warp_spec INDIGO_PLATEAU,  .IndigoPlateau
	fly_warp_spec SAFFRON_CITY,    .SaffronCity
	fly_warp_spec ROUTE_4,         .Route4
	fly_warp_spec ROUTE_10,        .Route10
	fly_warp_spec ROUTE_25,        .Route25

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
