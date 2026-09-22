; v1.0 (2026-09-22, T32): coordinates are two bytes, x then y, in HALF tiles.
; The packed nibble byte (dn y, x) could only address tile rows 1-16 and
; columns 2-17; the map has 17 drawn rows and 20 columns, and a two-block
; route has no whole-tile centre. The macros take tile units plus an optional
; half-tile pair (0/1 each): `external_map 10, 7, Route6Name, 0, 1` sits half
; a tile below row 8. The engine reads these with LoadTownMapEntry (c = x,
; b = y, hl = name) and draws at pixel 4*x + 24 / 4*y + 24, i.e. tile column
; x + 2, row y + 1 for a whole-tile entry (TownMapCoordsToOAMCoords).
MACRO external_map
	IF _NARG == 5
		db (\1) * 2 + (\4), (\2) * 2 + (\5)
	ELSE
		db (\1) * 2, (\2) * 2
	ENDC
	dw \3
ENDM

; the appearance of towns and routes in the town map
ExternalMapEntries:
	table_width 4, ExternalMapEntries
	; x, y, name
	external_map  2, 11, PalletTownName
	external_map  2,  8, ViridianCityName
	external_map  2,  3, PewterCityName
	external_map 10,  2, CeruleanCityName
	external_map 14,  6, LavenderTownName
	external_map 10,  9, VermilionCityName
	external_map  7,  6, CeladonCityName
	external_map  8, 13, FuchsiaCityName
	external_map  2, 16, CinnabarIslandName
	external_map  0,  2, IndigoPlateauName
	external_map 10,  6, SaffronCityName
	external_map  0,  0, PalletTownName ; unused
	external_map  2, 10, Route1Name
	external_map  2,  6, Route2Name
	external_map  4,  3, Route3Name
	external_map  8,  2, Route4Name
	external_map 10,  4, Route5Name
	external_map 10,  7, Route6Name, 0, 1 ; centred on the route's two blocks (rows 8-9)
	external_map  8,  6, Route7Name, 1, 0 ; centred on the route's two blocks (columns 10-11)
	external_map 12,  6, Route8Name
	external_map 12,  2, Route9Name
	external_map 14,  4, Route10Name
	external_map 12,  9, Route11Name
	external_map 14,  9, Route12Name
	external_map 13, 11, Route13Name
	external_map 11, 12, Route14Name
	external_map 10, 13, Route15Name
	external_map  5,  6, Route16Name
	external_map  5,  10, Route17Name
	external_map  6, 13, Route18Name
	external_map  8, 15, Route19Name ; the dotted pier block, the middle of the route's drawn path
	external_map  4, 16, Route20Name
	external_map  2, 14, Route21Name
	external_map  0,  8, Route22Name
	external_map  0,  6, Route23Name
	external_map 10,  1, Route24Name
	external_map 11,  0, Route25Name
	assert_table_length FIRST_INDOOR_MAP


MACRO internal_map
	db \1 + 1
	IF _NARG == 6
		db (\2) * 2 + (\5), (\3) * 2 + (\6)
	ELSE
		db (\2) * 2, (\3) * 2
	ENDC
	dw \4
ENDM

; the appearance of buildings and dungeons in the town map
InternalMapEntries:
	; maximum map id subject to this rule, x, y, name
	internal_map OAKS_LAB,                       2, 11, PalletTownName
	internal_map VIRIDIAN_GYM,                   2,  8, ViridianCityName
	internal_map VIRIDIAN_FOREST_SOUTH_GATE,     2,  6, Route2Name
	internal_map VIRIDIAN_FOREST,                2,  5, ViridianForestName
	internal_map PEWTER_POKECENTER,              2,  3, PewterCityName
	internal_map MT_MOON_B2F,                    6,  2, MountMoonName
	internal_map CERULEAN_MART,                 10,  2, CeruleanCityName
	internal_map MT_MOON_POKECENTER,             5,  2, Route4Name
	internal_map CERULEAN_TRASHED_HOUSE_COPY,   10,  2, CeruleanCityName
	internal_map DAYCARE,                       10,  4, Route5Name
	internal_map UNDERGROUND_PATH_ROUTE_6_COPY, 10,  7, Route6Name, 0, 1
	internal_map UNDERGROUND_PATH_ROUTE_7_COPY,  9,  6, Route7Name
	internal_map UNDERGROUND_PATH_ROUTE_8,      11,  6, Route8Name
	internal_map ROCK_TUNNEL_1F,                14,  3, RockTunnelName
	internal_map POWER_PLANT,                   15,  4, PowerPlantName
	internal_map ROUTE_11_GATE_1F,              13,  9, Route11Name
; v1.0 (2026-09-22, Forte): DIGLETT's CAVE has two mouths, so it gets two markers - the
; cave itself keeps the Route 2 side (row DIGLETTS_CAVE below) and the Route 11 mouth's
; own map sits north-east of VERMILION. The Town Map draws BOTH cursors whenever it is
; on either (DrawTwinCursor in engine/items/town_map.asm); the list has one stop.
	internal_map DIGLETTS_CAVE_ROUTE_11,        11,  8, DiglettsCaveName
	internal_map ROUTE_11_GATE_2F,              13,  9, Route11Name
	internal_map ROUTE_12_GATE_1F,              14,  7, Route12Name
	internal_map BILLS_HOUSE,                   13,  0, BillsLabName
	internal_map VERMILION_DOCK,                10,  9, VermilionCityName
	internal_map SS_ANNE_B1F_ROOMS,             10, 10, SSAnneName
	internal_map VICTORY_ROAD_1F,                0,  4, VictoryRoadName
	internal_map HALL_OF_FAME,                   0,  2, PokemonLeagueName
	internal_map UNDERGROUND_PATH_NORTH_SOUTH,  10,  6, UndergroundPathName
	internal_map CHAMPIONS_ROOM,                 0,  2, PokemonLeagueName
	internal_map UNDERGROUND_PATH_WEST_EAST,    10,  6, UndergroundPathName
	internal_map CELADON_HOTEL,                  7,  6, CeladonCityName
	internal_map LAVENDER_POKECENTER,           14,  6, LavenderTownName
	internal_map POKEMON_TOWER_7F,              15,  5, PokemonTowerName
	internal_map LAVENDER_CUBONE_HOUSE,         14,  6, LavenderTownName
	internal_map WARDENS_HOUSE,                  8, 13, FuchsiaCityName
	internal_map SAFARI_ZONE_GATE,               8, 12, SafariZoneName
	internal_map FUCHSIA_MEETING_ROOM,           8, 13, FuchsiaCityName
	internal_map SEAFOAM_ISLANDS_B4F,            6, 16, SeafoamIslandsName
	internal_map VERMILION_GOOD_ROD_HOUSE,       10,  9, VermilionCityName
	internal_map FUCHSIA_FOSSIL_HOUSE,           8, 13, FuchsiaCityName
	internal_map POKEMON_MANSION_1F,             2, 16, PokemonMansionName
	internal_map CINNABAR_MART_COPY,             2, 16, CinnabarIslandName
	internal_map INDIGO_PLATEAU_LOBBY,           0,  2, IndigoPlateauName
	internal_map MR_PSYCHICS_HOUSE,             10,  6, SaffronCityName
	internal_map ROUTE_15_GATE_2F,               9, 13, Route15Name
	internal_map ROUTE_16_FLY_HOUSE,             5,  6, Route16Name
	internal_map ROUTE_12_SUPER_ROD_HOUSE,      14, 10, Route12Name
	internal_map ROUTE_18_GATE_2F,               7, 13, Route18Name
	internal_map SEAFOAM_ISLANDS_1F,             6, 16, SeafoamIslandsName
	internal_map ROUTE_22_GATE,                  0,  7, Route22Name
	internal_map VICTORY_ROAD_2F,                0,  4, VictoryRoadName
	internal_map ROUTE_12_GATE_2F,              14,  7, Route12Name
	internal_map VERMILION_TRADE_HOUSE,         10,  9, VermilionCityName
	internal_map DIGLETTS_CAVE,                  3,  4, DiglettsCaveName
	internal_map VICTORY_ROAD_3F,                0,  4, VictoryRoadName
	internal_map UNUSED_MAP_CE,                  7,  6, RocketHQName
	internal_map SILPH_CO_8F,                   10,  6, SilphCoName
	internal_map POKEMON_MANSION_B1F,            2, 16, PokemonMansionName
	internal_map SAFARI_ZONE_NORTH_REST_HOUSE,   8, 12, SafariZoneName
	internal_map CERULEAN_CAVE_1F,               9,  1, CeruleanCaveName
	internal_map NAME_RATERS_HOUSE,             14,  6, LavenderTownName
	internal_map CERULEAN_BADGE_HOUSE,          10,  2, CeruleanCityName
	internal_map ROCK_TUNNEL_B1F,               14,  3, RockTunnelName
	internal_map SILPH_CO_ELEVATOR,             10,  6, SilphCoName
	internal_map AGATHAS_ROOM,                   0,  2, PokemonLeagueName
	internal_map SUMMER_BEACH_HOUSE,             8, 15, Route19Name
	internal_map VIRIDIAN_OLD_ROD_HOUSE,         2,  8, ViridianCityName
	internal_map DAYCARE_2F,                    10,  4, Route5Name
	internal_map BILLS_GARDEN,                  13,  0, BillsLabName
; Must stay last, and must exist at all: InternalMapEntries is an ordered RANGE
; lookup with no end check, so the HIGHEST map id needs a line or LoadTownMapEntry
; reads straight past the -1 and treats whatever follows as coordinates.
; (v0.7 note: this invariant is carried by whichever row is last -- it sat on
; the BILLS_GARDEN line above until BLUES_HOUSE_2F, the higher id, was appended
; after it. The garden row itself is also load-bearing for the range walk, but
; its habitats no longer reach the AREA page: FindWildLocationsOfMon skips the
; garden at the source -- the map is secret.)
	internal_map BLUES_HOUSE_2F,                 2, 11, PalletTownName
	db -1 ; end
