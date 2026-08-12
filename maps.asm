SECTION "Maps 1", ROMX

INCLUDE "data/maps/headers/CeladonCity.asm"
INCLUDE "data/maps/objects/CeladonCity.asm"
CeladonCity_Blocks: INCBIN "maps/CeladonCity.blk"
	assert @ - CeladonCity_Blocks == CELADON_CITY_WIDTH * CELADON_CITY_HEIGHT, "CeladonCity.blk size does not match CELADON_CITY in map_constants.asm"

INCLUDE "data/maps/headers/PalletTown.asm"
INCLUDE "data/maps/objects/PalletTown.asm"
PalletTown_Blocks: INCBIN "maps/PalletTown.blk"
	assert @ - PalletTown_Blocks == PALLET_TOWN_WIDTH * PALLET_TOWN_HEIGHT, "PalletTown.blk size does not match PALLET_TOWN in map_constants.asm"

INCLUDE "data/maps/headers/ViridianCity.asm"
INCLUDE "data/maps/objects/ViridianCity.asm"
ViridianCity_Blocks: INCBIN "maps/ViridianCity.blk"
	assert @ - ViridianCity_Blocks == VIRIDIAN_CITY_WIDTH * VIRIDIAN_CITY_HEIGHT, "ViridianCity.blk size does not match VIRIDIAN_CITY in map_constants.asm"

INCLUDE "data/maps/headers/PewterCity.asm"
	ds 1
INCLUDE "data/maps/objects/PewterCity.asm"
PewterCity_Blocks: INCBIN "maps/PewterCity.blk"
	assert @ - PewterCity_Blocks == PEWTER_CITY_WIDTH * PEWTER_CITY_HEIGHT, "PewterCity.blk size does not match PEWTER_CITY in map_constants.asm"

INCLUDE "data/maps/headers/CeruleanCity.asm"
INCLUDE "data/maps/objects/CeruleanCity.asm"
CeruleanCity_Blocks: INCBIN "maps/CeruleanCity.blk"
	assert @ - CeruleanCity_Blocks == CERULEAN_CITY_WIDTH * CERULEAN_CITY_HEIGHT, "CeruleanCity.blk size does not match CERULEAN_CITY in map_constants.asm"

INCLUDE "data/maps/headers/VermilionCity.asm"
INCLUDE "data/maps/objects/VermilionCity.asm"
VermilionCity_Blocks: INCBIN "maps/VermilionCity.blk"
	assert @ - VermilionCity_Blocks == VERMILION_CITY_WIDTH * VERMILION_CITY_HEIGHT, "VermilionCity.blk size does not match VERMILION_CITY in map_constants.asm"

INCLUDE "data/maps/headers/FuchsiaCity.asm"
INCLUDE "data/maps/objects/FuchsiaCity.asm"
FuchsiaCity_Blocks: INCBIN "maps/FuchsiaCity.blk"
	assert @ - FuchsiaCity_Blocks == FUCHSIA_CITY_WIDTH * FUCHSIA_CITY_HEIGHT, "FuchsiaCity.blk size does not match FUCHSIA_CITY in map_constants.asm"


SECTION "Maps 2", ROMX

INCLUDE "scripts/PalletTown.asm"
INCLUDE "scripts/ViridianCity.asm"
INCLUDE "scripts/PewterCity.asm"
INCLUDE "scripts/CeruleanCity.asm"
INCLUDE "scripts/VermilionCity.asm"
INCLUDE "scripts/CeladonCity.asm"
INCLUDE "scripts/FuchsiaCity.asm"

INCLUDE "data/maps/headers/BluesHouse.asm"
INCLUDE "scripts/BluesHouse.asm"
INCLUDE "data/maps/objects/BluesHouse.asm"
BluesHouse_Blocks: INCBIN "maps/BluesHouse.blk"
	assert @ - BluesHouse_Blocks == BLUES_HOUSE_WIDTH * BLUES_HOUSE_HEIGHT, "BluesHouse.blk size does not match BLUES_HOUSE in map_constants.asm"

INCLUDE "data/maps/headers/VermilionTradeHouse.asm"
INCLUDE "scripts/VermilionTradeHouse.asm"
INCLUDE "data/maps/objects/VermilionTradeHouse.asm"
VermilionTradeHouse_Blocks: INCBIN "maps/VermilionTradeHouse.blk"
	assert @ - VermilionTradeHouse_Blocks == VERMILION_TRADE_HOUSE_WIDTH * VERMILION_TRADE_HOUSE_HEIGHT, "VermilionTradeHouse.blk size does not match VERMILION_TRADE_HOUSE in map_constants.asm"

INCLUDE "data/maps/headers/IndigoPlateauLobby.asm"
INCLUDE "scripts/IndigoPlateauLobby.asm"
INCLUDE "data/maps/objects/IndigoPlateauLobby.asm"
IndigoPlateauLobby_Blocks: INCBIN "maps/IndigoPlateauLobby.blk"
	assert @ - IndigoPlateauLobby_Blocks == INDIGO_PLATEAU_LOBBY_WIDTH * INDIGO_PLATEAU_LOBBY_HEIGHT, "IndigoPlateauLobby.blk size does not match INDIGO_PLATEAU_LOBBY in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo4F.asm"
INCLUDE "scripts/SilphCo4F.asm"
INCLUDE "data/maps/objects/SilphCo4F.asm"
SilphCo4F_Blocks: INCBIN "maps/SilphCo4F.blk"
	assert @ - SilphCo4F_Blocks == SILPH_CO_4F_WIDTH * SILPH_CO_4F_HEIGHT, "SilphCo4F.blk size does not match SILPH_CO_4F in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo5F.asm"
INCLUDE "scripts/SilphCo5F.asm"
INCLUDE "data/maps/objects/SilphCo5F.asm"
SilphCo5F_Blocks: INCBIN "maps/SilphCo5F.blk"
	assert @ - SilphCo5F_Blocks == SILPH_CO_5F_WIDTH * SILPH_CO_5F_HEIGHT, "SilphCo5F.blk size does not match SILPH_CO_5F in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo6F.asm"
INCLUDE "scripts/SilphCo6F.asm"
INCLUDE "data/maps/objects/SilphCo6F.asm"
SilphCo6F_Blocks: INCBIN "maps/SilphCo6F.blk"
	assert @ - SilphCo6F_Blocks == SILPH_CO_6F_WIDTH * SILPH_CO_6F_HEIGHT, "SilphCo6F.blk size does not match SILPH_CO_6F in map_constants.asm"


SECTION "Maps 3", ROMX

INCLUDE "data/maps/headers/CinnabarIsland.asm"
INCLUDE "data/maps/objects/CinnabarIsland.asm"
CinnabarIsland_Blocks: INCBIN "maps/CinnabarIsland.blk"
	assert @ - CinnabarIsland_Blocks == CINNABAR_ISLAND_WIDTH * CINNABAR_ISLAND_HEIGHT, "CinnabarIsland.blk size does not match CINNABAR_ISLAND in map_constants.asm"

INCLUDE "data/maps/headers/Route1.asm"
INCLUDE "data/maps/objects/Route1.asm"
Route1_Blocks: INCBIN "maps/Route1.blk"
	assert @ - Route1_Blocks == ROUTE_1_WIDTH * ROUTE_1_HEIGHT, "Route1.blk size does not match ROUTE_1 in map_constants.asm"

UndergroundPathRoute8_Blocks: INCBIN "maps/UndergroundPathRoute8.blk"
	assert @ - UndergroundPathRoute8_Blocks == UNDERGROUND_PATH_ROUTE_8_WIDTH * UNDERGROUND_PATH_ROUTE_8_HEIGHT, "UndergroundPathRoute8.blk size does not match UNDERGROUND_PATH_ROUTE_8 in map_constants.asm"

OaksLab_Blocks: INCBIN "maps/OaksLab.blk"
	assert @ - OaksLab_Blocks == OAKS_LAB_WIDTH * OAKS_LAB_HEIGHT, "OaksLab.blk size does not match OAKS_LAB in map_constants.asm"

MrPsychicsHouse_Blocks:
NameRatersHouse_Blocks:
MrFujisHouse_Blocks:
Route16FlyHouse_Blocks:
Route2TradeHouse_Blocks:
SaffronPidgeyHouse_Blocks:
VermilionPidgeyHouse_Blocks:
LavenderCuboneHouse_Blocks:
CeruleanMelaniesHouse_Blocks:
PewterNidoranHouse_Blocks:
PewterSpeechHouse_Blocks:
ViridianNicknameHouse_Blocks: INCBIN "maps/ViridianNicknameHouse.blk"
	assert @ - ViridianNicknameHouse_Blocks == VIRIDIAN_NICKNAME_HOUSE_WIDTH * VIRIDIAN_NICKNAME_HOUSE_HEIGHT, "ViridianNicknameHouse.blk size does not match VIRIDIAN_NICKNAME_HOUSE in map_constants.asm"

; Its own copy rather than another label on the stack above, so the interior can
; be redrawn in PolishedMap without dragging every other small house with it.
ViridianOldRodHouse_Blocks: INCBIN "maps/ViridianOldRodHouse.blk"
	assert @ - ViridianOldRodHouse_Blocks == VIRIDIAN_OLD_ROD_HOUSE_WIDTH * VIRIDIAN_OLD_ROD_HOUSE_HEIGHT, "ViridianOldRodHouse.blk size does not match VIRIDIAN_OLD_ROD_HOUSE in map_constants.asm"

CeladonMansionRoofHouse_Blocks:
ViridianSchoolHouse_Blocks: INCBIN "maps/ViridianSchoolHouse.blk"
	assert @ - ViridianSchoolHouse_Blocks == VIRIDIAN_SCHOOL_HOUSE_WIDTH * VIRIDIAN_SCHOOL_HOUSE_HEIGHT, "ViridianSchoolHouse.blk size does not match VIRIDIAN_SCHOOL_HOUSE in map_constants.asm"

CeruleanTrashedHouse_Blocks: INCBIN "maps/CeruleanTrashedHouse.blk"
	assert @ - CeruleanTrashedHouse_Blocks == CERULEAN_TRASHED_HOUSE_WIDTH * CERULEAN_TRASHED_HOUSE_HEIGHT, "CeruleanTrashedHouse.blk size does not match CERULEAN_TRASHED_HOUSE in map_constants.asm"

DiglettsCaveRoute11_Blocks:
DiglettsCaveRoute2_Blocks: INCBIN "maps/DiglettsCaveRoute2.blk"
	assert @ - DiglettsCaveRoute2_Blocks == DIGLETTS_CAVE_ROUTE_2_WIDTH * DIGLETTS_CAVE_ROUTE_2_HEIGHT, "DiglettsCaveRoute2.blk size does not match DIGLETTS_CAVE_ROUTE_2 in map_constants.asm"


SECTION "Maps 4", ROMX

INCLUDE "scripts/CinnabarIsland.asm"

INCLUDE "scripts/Route1.asm"

INCLUDE "data/maps/headers/OaksLab.asm"
INCLUDE "scripts/OaksLab.asm"
INCLUDE "data/maps/objects/OaksLab.asm"

INCLUDE "data/maps/headers/ViridianMart.asm"
INCLUDE "scripts/ViridianMart.asm"
INCLUDE "data/maps/objects/ViridianMart.asm"
ViridianMart_Blocks: INCBIN "maps/ViridianMart.blk"
	assert @ - ViridianMart_Blocks == VIRIDIAN_MART_WIDTH * VIRIDIAN_MART_HEIGHT, "ViridianMart.blk size does not match VIRIDIAN_MART in map_constants.asm"

INCLUDE "data/maps/headers/ViridianSchoolHouse.asm"
INCLUDE "scripts/ViridianSchoolHouse.asm"
INCLUDE "data/maps/objects/ViridianSchoolHouse.asm"

INCLUDE "data/maps/headers/ViridianNicknameHouse.asm"
	ds 1
INCLUDE "scripts/ViridianNicknameHouse.asm"
INCLUDE "data/maps/objects/ViridianNicknameHouse.asm"

INCLUDE "data/maps/headers/ViridianOldRodHouse.asm"
INCLUDE "scripts/ViridianOldRodHouse.asm"
INCLUDE "data/maps/objects/ViridianOldRodHouse.asm"

INCLUDE "data/maps/headers/PewterNidoranHouse.asm"
INCLUDE "scripts/PewterNidoranHouse.asm"
INCLUDE "data/maps/objects/PewterNidoranHouse.asm"

INCLUDE "data/maps/headers/PewterSpeechHouse.asm"
INCLUDE "scripts/PewterSpeechHouse.asm"
INCLUDE "data/maps/objects/PewterSpeechHouse.asm"

INCLUDE "data/maps/headers/CeruleanTrashedHouse.asm"
INCLUDE "scripts/CeruleanTrashedHouse.asm"
INCLUDE "data/maps/objects/CeruleanTrashedHouse.asm"

INCLUDE "data/maps/headers/CeruleanMelaniesHouse.asm"
INCLUDE "scripts/CeruleanMelaniesHouse.asm"
INCLUDE "data/maps/objects/CeruleanMelaniesHouse.asm"

INCLUDE "data/maps/headers/BikeShop.asm"
INCLUDE "scripts/BikeShop.asm"
INCLUDE "data/maps/objects/BikeShop.asm"
BikeShop_Blocks: INCBIN "maps/BikeShop.blk"
	assert @ - BikeShop_Blocks == BIKE_SHOP_WIDTH * BIKE_SHOP_HEIGHT, "BikeShop.blk size does not match BIKE_SHOP in map_constants.asm"

INCLUDE "data/maps/headers/MrFujisHouse.asm"
INCLUDE "scripts/MrFujisHouse.asm"
INCLUDE "data/maps/objects/MrFujisHouse.asm"

INCLUDE "data/maps/headers/LavenderCuboneHouse.asm"
INCLUDE "scripts/LavenderCuboneHouse.asm"
INCLUDE "data/maps/objects/LavenderCuboneHouse.asm"

INCLUDE "data/maps/headers/NameRatersHouse.asm"
INCLUDE "scripts/NameRatersHouse.asm"
INCLUDE "data/maps/objects/NameRatersHouse.asm"

INCLUDE "data/maps/headers/VermilionPidgeyHouse.asm"
INCLUDE "scripts/VermilionPidgeyHouse.asm"
INCLUDE "data/maps/objects/VermilionPidgeyHouse.asm"

INCLUDE "data/maps/headers/VermilionDock.asm"
INCLUDE "scripts/VermilionDock.asm"
INCLUDE "data/maps/objects/VermilionDock.asm"
VermilionDock_Blocks: INCBIN "maps/VermilionDock.blk"
	assert @ - VermilionDock_Blocks == VERMILION_DOCK_WIDTH * VERMILION_DOCK_HEIGHT, "VermilionDock.blk size does not match VERMILION_DOCK in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMansionRoofHouse.asm"
INCLUDE "scripts/CeladonMansionRoofHouse.asm"
INCLUDE "data/maps/objects/CeladonMansionRoofHouse.asm"

INCLUDE "data/maps/headers/FuchsiaMart.asm"
INCLUDE "scripts/FuchsiaMart.asm"
INCLUDE "data/maps/objects/FuchsiaMart.asm"
FuchsiaMart_Blocks: INCBIN "maps/FuchsiaMart.blk"
	assert @ - FuchsiaMart_Blocks == FUCHSIA_MART_WIDTH * FUCHSIA_MART_HEIGHT, "FuchsiaMart.blk size does not match FUCHSIA_MART in map_constants.asm"

INCLUDE "data/maps/headers/SaffronPidgeyHouse.asm"
INCLUDE "scripts/SaffronPidgeyHouse.asm"
INCLUDE "data/maps/objects/SaffronPidgeyHouse.asm"

INCLUDE "data/maps/headers/MrPsychicsHouse.asm"
INCLUDE "scripts/MrPsychicsHouse.asm"
INCLUDE "data/maps/objects/MrPsychicsHouse.asm"

INCLUDE "data/maps/headers/DiglettsCaveRoute2.asm"
INCLUDE "scripts/DiglettsCaveRoute2.asm"
INCLUDE "data/maps/objects/DiglettsCaveRoute2.asm"

INCLUDE "data/maps/headers/Route2TradeHouse.asm"
INCLUDE "scripts/Route2TradeHouse.asm"
INCLUDE "data/maps/objects/Route2TradeHouse.asm"

INCLUDE "data/maps/headers/Route5Gate.asm"
INCLUDE "scripts/Route5Gate.asm"
INCLUDE "data/maps/objects/Route5Gate.asm"
Route5Gate_Blocks: INCBIN "maps/Route5Gate.blk"
	assert @ - Route5Gate_Blocks == ROUTE_5_GATE_WIDTH * ROUTE_5_GATE_HEIGHT, "Route5Gate.blk size does not match ROUTE_5_GATE in map_constants.asm"

INCLUDE "data/maps/headers/Route6Gate.asm"
INCLUDE "scripts/Route6Gate.asm"
INCLUDE "data/maps/objects/Route6Gate.asm"
Route6Gate_Blocks: INCBIN "maps/Route6Gate.blk"
	assert @ - Route6Gate_Blocks == ROUTE_6_GATE_WIDTH * ROUTE_6_GATE_HEIGHT, "Route6Gate.blk size does not match ROUTE_6_GATE in map_constants.asm"

INCLUDE "data/maps/headers/Route7Gate.asm"
INCLUDE "scripts/Route7Gate.asm"
INCLUDE "data/maps/objects/Route7Gate.asm"
Route7Gate_Blocks: INCBIN "maps/Route7Gate.blk"
	assert @ - Route7Gate_Blocks == ROUTE_7_GATE_WIDTH * ROUTE_7_GATE_HEIGHT, "Route7Gate.blk size does not match ROUTE_7_GATE in map_constants.asm"

INCLUDE "data/maps/headers/Route8Gate.asm"
INCLUDE "scripts/Route8Gate.asm"
INCLUDE "data/maps/objects/Route8Gate.asm"
Route8Gate_Blocks: INCBIN "maps/Route8Gate.blk"
	assert @ - Route8Gate_Blocks == ROUTE_8_GATE_WIDTH * ROUTE_8_GATE_HEIGHT, "Route8Gate.blk size does not match ROUTE_8_GATE in map_constants.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute8.asm"
INCLUDE "scripts/UndergroundPathRoute8.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute8.asm"

INCLUDE "data/maps/headers/PowerPlant.asm"
INCLUDE "scripts/PowerPlant.asm"
INCLUDE "data/maps/objects/PowerPlant.asm"
PowerPlant_Blocks: INCBIN "maps/PowerPlant.blk"
	assert @ - PowerPlant_Blocks == POWER_PLANT_WIDTH * POWER_PLANT_HEIGHT, "PowerPlant.blk size does not match POWER_PLANT in map_constants.asm"

INCLUDE "data/maps/headers/DiglettsCaveRoute11.asm"
INCLUDE "scripts/DiglettsCaveRoute11.asm"
INCLUDE "data/maps/objects/DiglettsCaveRoute11.asm"

INCLUDE "data/maps/headers/Route16FlyHouse.asm"
INCLUDE "scripts/Route16FlyHouse.asm"
INCLUDE "data/maps/objects/Route16FlyHouse.asm"

INCLUDE "data/maps/headers/Route22Gate.asm"
INCLUDE "scripts/Route22Gate.asm"
INCLUDE "data/maps/objects/Route22Gate.asm"
Route22Gate_Blocks: INCBIN "maps/Route22Gate.blk"
	assert @ - Route22Gate_Blocks == ROUTE_22_GATE_WIDTH * ROUTE_22_GATE_HEIGHT, "Route22Gate.blk size does not match ROUTE_22_GATE in map_constants.asm"

INCLUDE "data/maps/headers/BillsHouse.asm"
INCLUDE "scripts/BillsHouse.asm"
INCLUDE "data/maps/objects/BillsHouse.asm"
BillsHouse_Blocks: INCBIN "maps/BillsHouse.blk"
	assert @ - BillsHouse_Blocks == BILLS_HOUSE_WIDTH * BILLS_HOUSE_HEIGHT, "BillsHouse.blk size does not match BILLS_HOUSE in map_constants.asm"


SECTION "Maps 5", ROMX

INCLUDE "data/maps/headers/LavenderTown.asm"
INCLUDE "data/maps/objects/LavenderTown.asm"
LavenderTown_Blocks: INCBIN "maps/LavenderTown.blk"
	assert @ - LavenderTown_Blocks == LAVENDER_TOWN_WIDTH * LAVENDER_TOWN_HEIGHT, "LavenderTown.blk size does not match LAVENDER_TOWN in map_constants.asm"

ViridianPokecenter_Blocks: INCBIN "maps/ViridianPokecenter.blk"
	assert @ - ViridianPokecenter_Blocks == VIRIDIAN_POKECENTER_WIDTH * VIRIDIAN_POKECENTER_HEIGHT, "ViridianPokecenter.blk size does not match VIRIDIAN_POKECENTER in map_constants.asm"

SafariZoneCenterRestHouse_Blocks:
SafariZoneWestRestHouse_Blocks:
SafariZoneEastRestHouse_Blocks:
SafariZoneNorthRestHouse_Blocks: INCBIN "maps/SafariZoneCenterRestHouse.blk"
	assert @ - SafariZoneNorthRestHouse_Blocks == SAFARI_ZONE_NORTH_REST_HOUSE_WIDTH * SAFARI_ZONE_NORTH_REST_HOUSE_HEIGHT, "SafariZoneNorthRestHouse.blk size does not match SAFARI_ZONE_NORTH_REST_HOUSE in map_constants.asm"

INCLUDE "scripts/LavenderTown.asm"


SECTION "Maps 6", ROMX

INCLUDE "data/maps/headers/ViridianPokecenter.asm"
INCLUDE "scripts/ViridianPokecenter.asm"
INCLUDE "data/maps/objects/ViridianPokecenter.asm"

INCLUDE "data/maps/headers/CeladonMart1F.asm"
INCLUDE "scripts/CeladonMart1F.asm"
INCLUDE "data/maps/objects/CeladonMart1F.asm"
CeladonMart1F_Blocks: INCBIN "maps/CeladonMart1F.blk"
	assert @ - CeladonMart1F_Blocks == CELADON_MART_1F_WIDTH * CELADON_MART_1F_HEIGHT, "CeladonMart1F.blk size does not match CELADON_MART_1F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonMansion1F.asm"
INCLUDE "scripts/PokemonMansion1F.asm"
INCLUDE "data/maps/objects/PokemonMansion1F.asm"
PokemonMansion1F_Blocks: INCBIN "maps/PokemonMansion1F.blk"
	assert @ - PokemonMansion1F_Blocks == POKEMON_MANSION_1F_WIDTH * POKEMON_MANSION_1F_HEIGHT, "PokemonMansion1F.blk size does not match POKEMON_MANSION_1F in map_constants.asm"

INCLUDE "data/maps/headers/RockTunnel1F.asm"
INCLUDE "scripts/RockTunnel1F.asm"
INCLUDE "data/maps/objects/RockTunnel1F.asm"
RockTunnel1F_Blocks: INCBIN "maps/RockTunnel1F.blk"
	assert @ - RockTunnel1F_Blocks == ROCK_TUNNEL_1F_WIDTH * ROCK_TUNNEL_1F_HEIGHT, "RockTunnel1F.blk size does not match ROCK_TUNNEL_1F in map_constants.asm"

INCLUDE "data/maps/headers/SeafoamIslands1F.asm"
INCLUDE "scripts/SeafoamIslands1F.asm"
INCLUDE "data/maps/objects/SeafoamIslands1F.asm"
SeafoamIslands1F_Blocks: INCBIN "maps/SeafoamIslands1F.blk"
	assert @ - SeafoamIslands1F_Blocks == SEAFOAM_ISLANDS_1F_WIDTH * SEAFOAM_ISLANDS_1F_HEIGHT, "SeafoamIslands1F.blk size does not match SEAFOAM_ISLANDS_1F in map_constants.asm"

INCLUDE "data/maps/headers/SSAnne3F.asm"
INCLUDE "scripts/SSAnne3F.asm"
INCLUDE "data/maps/objects/SSAnne3F.asm"
SSAnne3F_Blocks: INCBIN "maps/SSAnne3F.blk"
	assert @ - SSAnne3F_Blocks == SS_ANNE_3F_WIDTH * SS_ANNE_3F_HEIGHT, "SSAnne3F.blk size does not match SS_ANNE_3F in map_constants.asm"

INCLUDE "data/maps/headers/VictoryRoad3F.asm"
INCLUDE "scripts/VictoryRoad3F.asm"
INCLUDE "data/maps/objects/VictoryRoad3F.asm"
VictoryRoad3F_Blocks: INCBIN "maps/VictoryRoad3F.blk"
	assert @ - VictoryRoad3F_Blocks == VICTORY_ROAD_3F_WIDTH * VICTORY_ROAD_3F_HEIGHT, "VictoryRoad3F.blk size does not match VICTORY_ROAD_3F in map_constants.asm"

INCLUDE "data/maps/headers/RocketHideoutB1F.asm"
INCLUDE "scripts/RocketHideoutB1F.asm"
INCLUDE "data/maps/objects/RocketHideoutB1F.asm"
RocketHideoutB1F_Blocks: INCBIN "maps/RocketHideoutB1F.blk"
	assert @ - RocketHideoutB1F_Blocks == ROCKET_HIDEOUT_B1F_WIDTH * ROCKET_HIDEOUT_B1F_HEIGHT, "RocketHideoutB1F.blk size does not match ROCKET_HIDEOUT_B1F in map_constants.asm"

INCLUDE "data/maps/headers/RocketHideoutB2F.asm"
INCLUDE "scripts/RocketHideoutB2F.asm"
INCLUDE "data/maps/objects/RocketHideoutB2F.asm"
RocketHideoutB2F_Blocks: INCBIN "maps/RocketHideoutB2F.blk"
	assert @ - RocketHideoutB2F_Blocks == ROCKET_HIDEOUT_B2F_WIDTH * ROCKET_HIDEOUT_B2F_HEIGHT, "RocketHideoutB2F.blk size does not match ROCKET_HIDEOUT_B2F in map_constants.asm"

INCLUDE "data/maps/headers/RocketHideoutB3F.asm"
INCLUDE "scripts/RocketHideoutB3F.asm"
INCLUDE "data/maps/objects/RocketHideoutB3F.asm"
RocketHideoutB3F_Blocks: INCBIN "maps/RocketHideoutB3F.blk"
	assert @ - RocketHideoutB3F_Blocks == ROCKET_HIDEOUT_B3F_WIDTH * ROCKET_HIDEOUT_B3F_HEIGHT, "RocketHideoutB3F.blk size does not match ROCKET_HIDEOUT_B3F in map_constants.asm"

INCLUDE "data/maps/headers/RocketHideoutB4F.asm"
INCLUDE "scripts/RocketHideoutB4F.asm"
INCLUDE "data/maps/objects/RocketHideoutB4F.asm"
RocketHideoutB4F_Blocks: INCBIN "maps/RocketHideoutB4F.blk"
	assert @ - RocketHideoutB4F_Blocks == ROCKET_HIDEOUT_B4F_WIDTH * ROCKET_HIDEOUT_B4F_HEIGHT, "RocketHideoutB4F.blk size does not match ROCKET_HIDEOUT_B4F in map_constants.asm"

INCLUDE "data/maps/headers/RocketHideoutElevator.asm"
INCLUDE "scripts/RocketHideoutElevator.asm"
INCLUDE "data/maps/objects/RocketHideoutElevator.asm"
RocketHideoutElevator_Blocks: INCBIN "maps/RocketHideoutElevator.blk"
	assert @ - RocketHideoutElevator_Blocks == ROCKET_HIDEOUT_ELEVATOR_WIDTH * ROCKET_HIDEOUT_ELEVATOR_HEIGHT, "RocketHideoutElevator.blk size does not match ROCKET_HIDEOUT_ELEVATOR in map_constants.asm"

INCLUDE "data/maps/headers/SilphCoElevator.asm"
INCLUDE "scripts/SilphCoElevator.asm"
INCLUDE "data/maps/objects/SilphCoElevator.asm"
SilphCoElevator_Blocks: INCBIN "maps/SilphCoElevator.blk"
	assert @ - SilphCoElevator_Blocks == SILPH_CO_ELEVATOR_WIDTH * SILPH_CO_ELEVATOR_HEIGHT, "SilphCoElevator.blk size does not match SILPH_CO_ELEVATOR in map_constants.asm"

INCLUDE "data/maps/headers/SafariZoneEast.asm"
INCLUDE "scripts/SafariZoneEast.asm"
INCLUDE "data/maps/objects/SafariZoneEast.asm"
SafariZoneEast_Blocks: INCBIN "maps/SafariZoneEast.blk"
	assert @ - SafariZoneEast_Blocks == SAFARI_ZONE_EAST_WIDTH * SAFARI_ZONE_EAST_HEIGHT, "SafariZoneEast.blk size does not match SAFARI_ZONE_EAST in map_constants.asm"

INCLUDE "data/maps/headers/SafariZoneNorth.asm"
INCLUDE "scripts/SafariZoneNorth.asm"
INCLUDE "data/maps/objects/SafariZoneNorth.asm"
SafariZoneNorth_Blocks: INCBIN "maps/SafariZoneNorth.blk"
	assert @ - SafariZoneNorth_Blocks == SAFARI_ZONE_NORTH_WIDTH * SAFARI_ZONE_NORTH_HEIGHT, "SafariZoneNorth.blk size does not match SAFARI_ZONE_NORTH in map_constants.asm"

INCLUDE "data/maps/headers/SafariZoneCenter.asm"
INCLUDE "scripts/SafariZoneCenter.asm"
INCLUDE "data/maps/objects/SafariZoneCenter.asm"
SafariZoneCenter_Blocks: INCBIN "maps/SafariZoneCenter.blk"
	assert @ - SafariZoneCenter_Blocks == SAFARI_ZONE_CENTER_WIDTH * SAFARI_ZONE_CENTER_HEIGHT, "SafariZoneCenter.blk size does not match SAFARI_ZONE_CENTER in map_constants.asm"

INCLUDE "data/maps/headers/SafariZoneCenterRestHouse.asm"
INCLUDE "scripts/SafariZoneCenterRestHouse.asm"
INCLUDE "data/maps/objects/SafariZoneCenterRestHouse.asm"

INCLUDE "data/maps/headers/SafariZoneWestRestHouse.asm"
INCLUDE "scripts/SafariZoneWestRestHouse.asm"
INCLUDE "data/maps/objects/SafariZoneWestRestHouse.asm"

INCLUDE "data/maps/headers/SafariZoneEastRestHouse.asm"
INCLUDE "scripts/SafariZoneEastRestHouse.asm"
INCLUDE "data/maps/objects/SafariZoneEastRestHouse.asm"

INCLUDE "data/maps/headers/SafariZoneNorthRestHouse.asm"
INCLUDE "scripts/SafariZoneNorthRestHouse.asm"
INCLUDE "data/maps/objects/SafariZoneNorthRestHouse.asm"

INCLUDE "data/maps/headers/CeruleanCave2F.asm"
INCLUDE "scripts/CeruleanCave2F.asm"
INCLUDE "data/maps/objects/CeruleanCave2F.asm"
CeruleanCave2F_Blocks: INCBIN "maps/CeruleanCave2F.blk"
	assert @ - CeruleanCave2F_Blocks == CERULEAN_CAVE_2F_WIDTH * CERULEAN_CAVE_2F_HEIGHT, "CeruleanCave2F.blk size does not match CERULEAN_CAVE_2F in map_constants.asm"

INCLUDE "data/maps/headers/CeruleanCaveB1F.asm"
INCLUDE "scripts/CeruleanCaveB1F.asm"
INCLUDE "data/maps/objects/CeruleanCaveB1F.asm"
CeruleanCaveB1F_Blocks: INCBIN "maps/CeruleanCaveB1F.blk"
	assert @ - CeruleanCaveB1F_Blocks == CERULEAN_CAVE_B1F_WIDTH * CERULEAN_CAVE_B1F_HEIGHT, "CeruleanCaveB1F.blk size does not match CERULEAN_CAVE_B1F in map_constants.asm"

INCLUDE "data/maps/headers/RockTunnelB1F.asm"
INCLUDE "scripts/RockTunnelB1F.asm"
INCLUDE "data/maps/objects/RockTunnelB1F.asm"
RockTunnelB1F_Blocks: INCBIN "maps/RockTunnelB1F.blk"
	assert @ - RockTunnelB1F_Blocks == ROCK_TUNNEL_B1F_WIDTH * ROCK_TUNNEL_B1F_HEIGHT, "RockTunnelB1F.blk size does not match ROCK_TUNNEL_B1F in map_constants.asm"

INCLUDE "data/maps/headers/SeafoamIslandsB1F.asm"
INCLUDE "scripts/SeafoamIslandsB1F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB1F.asm"
SeafoamIslandsB1F_Blocks: INCBIN "maps/SeafoamIslandsB1F.blk"
	assert @ - SeafoamIslandsB1F_Blocks == SEAFOAM_ISLANDS_B1F_WIDTH * SEAFOAM_ISLANDS_B1F_HEIGHT, "SeafoamIslandsB1F.blk size does not match SEAFOAM_ISLANDS_B1F in map_constants.asm"

INCLUDE "data/maps/headers/SeafoamIslandsB2F.asm"
INCLUDE "scripts/SeafoamIslandsB2F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB2F.asm"
SeafoamIslandsB2F_Blocks: INCBIN "maps/SeafoamIslandsB2F.blk"
	assert @ - SeafoamIslandsB2F_Blocks == SEAFOAM_ISLANDS_B2F_WIDTH * SEAFOAM_ISLANDS_B2F_HEIGHT, "SeafoamIslandsB2F.blk size does not match SEAFOAM_ISLANDS_B2F in map_constants.asm"

INCLUDE "data/maps/headers/SeafoamIslandsB3F.asm"
INCLUDE "scripts/SeafoamIslandsB3F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB3F.asm"
SeafoamIslandsB3F_Blocks: INCBIN "maps/SeafoamIslandsB3F.blk"
	assert @ - SeafoamIslandsB3F_Blocks == SEAFOAM_ISLANDS_B3F_WIDTH * SEAFOAM_ISLANDS_B3F_HEIGHT, "SeafoamIslandsB3F.blk size does not match SEAFOAM_ISLANDS_B3F in map_constants.asm"

INCLUDE "data/maps/headers/SeafoamIslandsB4F.asm"
INCLUDE "scripts/SeafoamIslandsB4F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB4F.asm"
SeafoamIslandsB4F_Blocks: INCBIN "maps/SeafoamIslandsB4F.blk"
	assert @ - SeafoamIslandsB4F_Blocks == SEAFOAM_ISLANDS_B4F_WIDTH * SEAFOAM_ISLANDS_B4F_HEIGHT, "SeafoamIslandsB4F.blk size does not match SEAFOAM_ISLANDS_B4F in map_constants.asm"


SECTION "Maps 7", ROMX

INCLUDE "data/maps/headers/Route7.asm"
INCLUDE "data/maps/objects/Route7.asm"
Route7_Blocks: INCBIN "maps/Route7.blk"
	assert @ - Route7_Blocks == ROUTE_7_WIDTH * ROUTE_7_HEIGHT, "Route7.blk size does not match ROUTE_7 in map_constants.asm"

CeladonPokecenter_Blocks:
RockTunnelPokecenter_Blocks:
MtMoonPokecenter_Blocks: INCBIN "maps/MtMoonPokecenter.blk"
	assert @ - MtMoonPokecenter_Blocks == MT_MOON_POKECENTER_WIDTH * MT_MOON_POKECENTER_HEIGHT, "MtMoonPokecenter.blk size does not match MT_MOON_POKECENTER in map_constants.asm"

Route18Gate1F_Blocks:
Route15Gate1F_Blocks:
Route11Gate1F_Blocks: INCBIN "maps/Route11Gate1F.blk"
	assert @ - Route11Gate1F_Blocks == ROUTE_11_GATE_1F_WIDTH * ROUTE_11_GATE_1F_HEIGHT, "Route11Gate1F.blk size does not match ROUTE_11_GATE_1F in map_constants.asm"

Route18Gate2F_Blocks:
Route16Gate2F_Blocks:
Route15Gate2F_Blocks:
Route12Gate2F_Blocks:
Route11Gate2F_Blocks: INCBIN "maps/Route11Gate2F.blk"
	assert @ - Route11Gate2F_Blocks == ROUTE_11_GATE_2F_WIDTH * ROUTE_11_GATE_2F_HEIGHT, "Route11Gate2F.blk size does not match ROUTE_11_GATE_2F in map_constants.asm"


SECTION "Maps 8", ROMX

INCLUDE "scripts/Route7.asm"

INCLUDE "data/maps/headers/RedsHouse1F.asm"
INCLUDE "scripts/RedsHouse1F.asm"
INCLUDE "data/maps/objects/RedsHouse1F.asm"
RedsHouse1F_Blocks: INCBIN "maps/RedsHouse1F.blk"
	assert @ - RedsHouse1F_Blocks == REDS_HOUSE_1F_WIDTH * REDS_HOUSE_1F_HEIGHT, "RedsHouse1F.blk size does not match REDS_HOUSE_1F in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMart3F.asm"
INCLUDE "scripts/CeladonMart3F.asm"
INCLUDE "data/maps/objects/CeladonMart3F.asm"
CeladonMart3F_Blocks: INCBIN "maps/CeladonMart3F.blk"
	assert @ - CeladonMart3F_Blocks == CELADON_MART_3F_WIDTH * CELADON_MART_3F_HEIGHT, "CeladonMart3F.blk size does not match CELADON_MART_3F in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMart4F.asm"
INCLUDE "scripts/CeladonMart4F.asm"
INCLUDE "data/maps/objects/CeladonMart4F.asm"
CeladonMart4F_Blocks: INCBIN "maps/CeladonMart4F.blk"
	assert @ - CeladonMart4F_Blocks == CELADON_MART_4F_WIDTH * CELADON_MART_4F_HEIGHT, "CeladonMart4F.blk size does not match CELADON_MART_4F in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMartRoof.asm"
INCLUDE "scripts/CeladonMartRoof.asm"
INCLUDE "data/maps/objects/CeladonMartRoof.asm"
CeladonMartRoof_Blocks: INCBIN "maps/CeladonMartRoof.blk"
	assert @ - CeladonMartRoof_Blocks == CELADON_MART_ROOF_WIDTH * CELADON_MART_ROOF_HEIGHT, "CeladonMartRoof.blk size does not match CELADON_MART_ROOF in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMartElevator.asm"
INCLUDE "scripts/CeladonMartElevator.asm"
INCLUDE "data/maps/objects/CeladonMartElevator.asm"
CeladonMartElevator_Blocks: INCBIN "maps/CeladonMartElevator.blk"
	assert @ - CeladonMartElevator_Blocks == CELADON_MART_ELEVATOR_WIDTH * CELADON_MART_ELEVATOR_HEIGHT, "CeladonMartElevator.blk size does not match CELADON_MART_ELEVATOR in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMansion1F.asm"
INCLUDE "scripts/CeladonMansion1F.asm"
INCLUDE "data/maps/objects/CeladonMansion1F.asm"
CeladonMansion1F_Blocks: INCBIN "maps/CeladonMansion1F.blk"
	assert @ - CeladonMansion1F_Blocks == CELADON_MANSION_1F_WIDTH * CELADON_MANSION_1F_HEIGHT, "CeladonMansion1F.blk size does not match CELADON_MANSION_1F in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMansion2F.asm"
INCLUDE "scripts/CeladonMansion2F.asm"
INCLUDE "data/maps/objects/CeladonMansion2F.asm"
CeladonMansion2F_Blocks: INCBIN "maps/CeladonMansion2F.blk"
	assert @ - CeladonMansion2F_Blocks == CELADON_MANSION_2F_WIDTH * CELADON_MANSION_2F_HEIGHT, "CeladonMansion2F.blk size does not match CELADON_MANSION_2F in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMansion3F.asm"
INCLUDE "scripts/CeladonMansion3F.asm"
INCLUDE "data/maps/objects/CeladonMansion3F.asm"
CeladonMansion3F_Blocks: INCBIN "maps/CeladonMansion3F.blk"
	assert @ - CeladonMansion3F_Blocks == CELADON_MANSION_3F_WIDTH * CELADON_MANSION_3F_HEIGHT, "CeladonMansion3F.blk size does not match CELADON_MANSION_3F in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMansionRoof.asm"
INCLUDE "scripts/CeladonMansionRoof.asm"
INCLUDE "data/maps/objects/CeladonMansionRoof.asm"
CeladonMansionRoof_Blocks: INCBIN "maps/CeladonMansionRoof.blk"
	assert @ - CeladonMansionRoof_Blocks == CELADON_MANSION_ROOF_WIDTH * CELADON_MANSION_ROOF_HEIGHT, "CeladonMansionRoof.blk size does not match CELADON_MANSION_ROOF in map_constants.asm"

INCLUDE "data/maps/headers/CeladonPokecenter.asm"
INCLUDE "scripts/CeladonPokecenter.asm"
INCLUDE "data/maps/objects/CeladonPokecenter.asm"

INCLUDE "data/maps/headers/CeladonGym.asm"
INCLUDE "scripts/CeladonGym.asm"
INCLUDE "data/maps/objects/CeladonGym.asm"
CeladonGym_Blocks: INCBIN "maps/CeladonGym.blk"
	assert @ - CeladonGym_Blocks == CELADON_GYM_WIDTH * CELADON_GYM_HEIGHT, "CeladonGym.blk size does not match CELADON_GYM in map_constants.asm"

INCLUDE "data/maps/headers/GameCorner.asm"
INCLUDE "scripts/GameCorner.asm"
INCLUDE "data/maps/objects/GameCorner.asm"
GameCorner_Blocks: INCBIN "maps/GameCorner.blk"
	assert @ - GameCorner_Blocks == GAME_CORNER_WIDTH * GAME_CORNER_HEIGHT, "GameCorner.blk size does not match GAME_CORNER in map_constants.asm"

INCLUDE "data/maps/headers/CeladonMart5F.asm"
INCLUDE "scripts/CeladonMart5F.asm"
INCLUDE "data/maps/objects/CeladonMart5F.asm"
CeladonMart5F_Blocks: INCBIN "maps/CeladonMart5F.blk"
	assert @ - CeladonMart5F_Blocks == CELADON_MART_5F_WIDTH * CELADON_MART_5F_HEIGHT, "CeladonMart5F.blk size does not match CELADON_MART_5F in map_constants.asm"

INCLUDE "data/maps/headers/GameCornerPrizeRoom.asm"
INCLUDE "scripts/GameCornerPrizeRoom.asm"
INCLUDE "data/maps/objects/GameCornerPrizeRoom.asm"
GameCornerPrizeRoom_Blocks: INCBIN "maps/GameCornerPrizeRoom.blk"
	assert @ - GameCornerPrizeRoom_Blocks == GAME_CORNER_PRIZE_ROOM_WIDTH * GAME_CORNER_PRIZE_ROOM_HEIGHT, "GameCornerPrizeRoom.blk size does not match GAME_CORNER_PRIZE_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/CeladonDiner.asm"
INCLUDE "scripts/CeladonDiner.asm"
INCLUDE "data/maps/objects/CeladonDiner.asm"
CeladonDiner_Blocks: INCBIN "maps/CeladonDiner.blk"
	assert @ - CeladonDiner_Blocks == CELADON_DINER_WIDTH * CELADON_DINER_HEIGHT, "CeladonDiner.blk size does not match CELADON_DINER in map_constants.asm"

INCLUDE "data/maps/headers/CeladonChiefHouse.asm"
INCLUDE "scripts/CeladonChiefHouse.asm"
INCLUDE "data/maps/objects/CeladonChiefHouse.asm"
CeladonChiefHouse_Blocks: INCBIN "maps/CeladonChiefHouse.blk"
	assert @ - CeladonChiefHouse_Blocks == CELADON_CHIEF_HOUSE_WIDTH * CELADON_CHIEF_HOUSE_HEIGHT, "CeladonChiefHouse.blk size does not match CELADON_CHIEF_HOUSE in map_constants.asm"

INCLUDE "data/maps/headers/CeladonHotel.asm"
INCLUDE "scripts/CeladonHotel.asm"
INCLUDE "data/maps/objects/CeladonHotel.asm"
CeladonHotel_Blocks: INCBIN "maps/CeladonHotel.blk"
	assert @ - CeladonHotel_Blocks == CELADON_HOTEL_WIDTH * CELADON_HOTEL_HEIGHT, "CeladonHotel.blk size does not match CELADON_HOTEL in map_constants.asm"

INCLUDE "data/maps/headers/MtMoonPokecenter.asm"
INCLUDE "scripts/MtMoonPokecenter.asm"
INCLUDE "data/maps/objects/MtMoonPokecenter.asm"

INCLUDE "data/maps/headers/RockTunnelPokecenter.asm"
INCLUDE "scripts/RockTunnelPokecenter.asm"
INCLUDE "data/maps/objects/RockTunnelPokecenter.asm"

INCLUDE "data/maps/headers/Route11Gate1F.asm"
INCLUDE "scripts/Route11Gate1F.asm"
INCLUDE "data/maps/objects/Route11Gate1F.asm"

INCLUDE "data/maps/headers/Route11Gate2F.asm"
INCLUDE "scripts/Route11Gate2F.asm"
INCLUDE "data/maps/objects/Route11Gate2F.asm"

INCLUDE "data/maps/headers/Route12Gate1F.asm"
INCLUDE "scripts/Route12Gate1F.asm"
INCLUDE "data/maps/objects/Route12Gate1F.asm"
Route12Gate1F_Blocks: INCBIN "maps/Route12Gate1F.blk"
	assert @ - Route12Gate1F_Blocks == ROUTE_12_GATE_1F_WIDTH * ROUTE_12_GATE_1F_HEIGHT, "Route12Gate1F.blk size does not match ROUTE_12_GATE_1F in map_constants.asm"

INCLUDE "data/maps/headers/Route12Gate2F.asm"
INCLUDE "scripts/Route12Gate2F.asm"
INCLUDE "data/maps/objects/Route12Gate2F.asm"

INCLUDE "data/maps/headers/Route15Gate1F.asm"
INCLUDE "scripts/Route15Gate1F.asm"
INCLUDE "data/maps/objects/Route15Gate1F.asm"

INCLUDE "data/maps/headers/Route15Gate2F.asm"
INCLUDE "scripts/Route15Gate2F.asm"
INCLUDE "data/maps/objects/Route15Gate2F.asm"

INCLUDE "data/maps/headers/Route16Gate1F.asm"
INCLUDE "scripts/Route16Gate1F.asm"
INCLUDE "data/maps/objects/Route16Gate1F.asm"
Route16Gate1F_Blocks: INCBIN "maps/Route16Gate1F.blk"
	assert @ - Route16Gate1F_Blocks == ROUTE_16_GATE_1F_WIDTH * ROUTE_16_GATE_1F_HEIGHT, "Route16Gate1F.blk size does not match ROUTE_16_GATE_1F in map_constants.asm"

INCLUDE "data/maps/headers/Route16Gate2F.asm"
INCLUDE "scripts/Route16Gate2F.asm"
INCLUDE "data/maps/objects/Route16Gate2F.asm"

INCLUDE "data/maps/headers/Route18Gate1F.asm"
INCLUDE "scripts/Route18Gate1F.asm"
INCLUDE "data/maps/objects/Route18Gate1F.asm"

INCLUDE "data/maps/headers/Route18Gate2F.asm"
INCLUDE "scripts/Route18Gate2F.asm"
INCLUDE "data/maps/objects/Route18Gate2F.asm"

INCLUDE "data/maps/headers/MtMoon1F.asm"
INCLUDE "scripts/MtMoon1F.asm"
INCLUDE "data/maps/objects/MtMoon1F.asm"
MtMoon1F_Blocks: INCBIN "maps/MtMoon1F.blk"
	assert @ - MtMoon1F_Blocks == MT_MOON_1F_WIDTH * MT_MOON_1F_HEIGHT, "MtMoon1F.blk size does not match MT_MOON_1F in map_constants.asm"

INCLUDE "data/maps/headers/MtMoonB2F.asm"
INCLUDE "scripts/MtMoonB2F.asm"
INCLUDE "data/maps/objects/MtMoonB2F.asm"
MtMoonB2F_Blocks: INCBIN "maps/MtMoonB2F.blk"
	assert @ - MtMoonB2F_Blocks == MT_MOON_B2F_WIDTH * MT_MOON_B2F_HEIGHT, "MtMoonB2F.blk size does not match MT_MOON_B2F in map_constants.asm"
INCLUDE "scripts/MtMoonB2F_2.asm"

INCLUDE "data/maps/headers/SafariZoneWest.asm"
INCLUDE "scripts/SafariZoneWest.asm"
INCLUDE "data/maps/objects/SafariZoneWest.asm"
SafariZoneWest_Blocks: INCBIN "maps/SafariZoneWest.blk"
	assert @ - SafariZoneWest_Blocks == SAFARI_ZONE_WEST_WIDTH * SAFARI_ZONE_WEST_HEIGHT, "SafariZoneWest.blk size does not match SAFARI_ZONE_WEST in map_constants.asm"

INCLUDE "data/maps/headers/SafariZoneSecretHouse.asm"
INCLUDE "scripts/SafariZoneSecretHouse.asm"
INCLUDE "data/maps/objects/SafariZoneSecretHouse.asm"
SafariZoneSecretHouse_Blocks: INCBIN "maps/SafariZoneSecretHouse.blk"
	assert @ - SafariZoneSecretHouse_Blocks == SAFARI_ZONE_SECRET_HOUSE_WIDTH * SAFARI_ZONE_SECRET_HOUSE_HEIGHT, "SafariZoneSecretHouse.blk size does not match SAFARI_ZONE_SECRET_HOUSE in map_constants.asm"


SECTION "Maps 9", ROMX

INCLUDE "data/maps/headers/TradeCenter.asm"
INCLUDE "scripts/TradeCenter.asm"
INCLUDE "data/maps/objects/TradeCenter.asm"
TradeCenter_Blocks: INCBIN "maps/TradeCenter.blk"
	assert @ - TradeCenter_Blocks == TRADE_CENTER_WIDTH * TRADE_CENTER_HEIGHT, "TradeCenter.blk size does not match TRADE_CENTER in map_constants.asm"

INCLUDE "data/maps/headers/Colosseum.asm"
INCLUDE "scripts/Colosseum.asm"
INCLUDE "data/maps/objects/Colosseum.asm"
Colosseum_Blocks: INCBIN "maps/Colosseum.blk"
	assert @ - Colosseum_Blocks == COLOSSEUM_WIDTH * COLOSSEUM_HEIGHT, "Colosseum.blk size does not match COLOSSEUM in map_constants.asm"


SECTION "Maps 10", ROMX

INCLUDE "data/maps/headers/Route22.asm"
INCLUDE "data/maps/objects/Route22.asm"
Route22_Blocks: INCBIN "maps/Route22.blk"
	assert @ - Route22_Blocks == ROUTE_22_WIDTH * ROUTE_22_HEIGHT, "Route22.blk size does not match ROUTE_22 in map_constants.asm"

INCLUDE "data/maps/headers/Route20.asm"
INCLUDE "data/maps/objects/Route20.asm"
Route20_Blocks: INCBIN "maps/Route20.blk"
	assert @ - Route20_Blocks == ROUTE_20_WIDTH * ROUTE_20_HEIGHT, "Route20.blk size does not match ROUTE_20 in map_constants.asm"

INCLUDE "data/maps/headers/Route23.asm"
INCLUDE "data/maps/objects/Route23.asm"
Route23_Blocks: INCBIN "maps/Route23.blk"
	assert @ - Route23_Blocks == ROUTE_23_WIDTH * ROUTE_23_HEIGHT, "Route23.blk size does not match ROUTE_23 in map_constants.asm"

INCLUDE "data/maps/headers/Route24.asm"
INCLUDE "data/maps/objects/Route24.asm"
Route24_Blocks: INCBIN "maps/Route24.blk"
	assert @ - Route24_Blocks == ROUTE_24_WIDTH * ROUTE_24_HEIGHT, "Route24.blk size does not match ROUTE_24 in map_constants.asm"

INCLUDE "data/maps/headers/Route25.asm"
INCLUDE "data/maps/objects/Route25.asm"
Route25_Blocks: INCBIN "maps/Route25.blk"
	assert @ - Route25_Blocks == ROUTE_25_WIDTH * ROUTE_25_HEIGHT, "Route25.blk size does not match ROUTE_25 in map_constants.asm"

INCLUDE "data/maps/headers/IndigoPlateau.asm"
INCLUDE "scripts/IndigoPlateau.asm"
INCLUDE "data/maps/objects/IndigoPlateau.asm"
IndigoPlateau_Blocks: INCBIN "maps/IndigoPlateau.blk"
	assert @ - IndigoPlateau_Blocks == INDIGO_PLATEAU_WIDTH * INDIGO_PLATEAU_HEIGHT, "IndigoPlateau.blk size does not match INDIGO_PLATEAU in map_constants.asm"

INCLUDE "data/maps/headers/SaffronCity.asm"
INCLUDE "data/maps/objects/SaffronCity.asm"
SaffronCity_Blocks: INCBIN "maps/SaffronCity.blk"
	assert @ - SaffronCity_Blocks == SAFFRON_CITY_WIDTH * SAFFRON_CITY_HEIGHT, "SaffronCity.blk size does not match SAFFRON_CITY in map_constants.asm"
INCLUDE "scripts/SaffronCity.asm"

INCLUDE "scripts/Route20.asm"
INCLUDE "scripts/Route22.asm"
INCLUDE "scripts/Route23.asm"
INCLUDE "scripts/Route24.asm"
INCLUDE "scripts/Route25.asm"

INCLUDE "data/maps/headers/VictoryRoad2F.asm"
INCLUDE "scripts/VictoryRoad2F.asm"
INCLUDE "data/maps/objects/VictoryRoad2F.asm"
VictoryRoad2F_Blocks: INCBIN "maps/VictoryRoad2F.blk"
	assert @ - VictoryRoad2F_Blocks == VICTORY_ROAD_2F_WIDTH * VICTORY_ROAD_2F_HEIGHT, "VictoryRoad2F.blk size does not match VICTORY_ROAD_2F in map_constants.asm"

INCLUDE "data/maps/headers/MtMoonB1F.asm"
INCLUDE "scripts/MtMoonB1F.asm"
INCLUDE "data/maps/objects/MtMoonB1F.asm"
MtMoonB1F_Blocks: INCBIN "maps/MtMoonB1F.blk"
	assert @ - MtMoonB1F_Blocks == MT_MOON_B1F_WIDTH * MT_MOON_B1F_HEIGHT, "MtMoonB1F.blk size does not match MT_MOON_B1F in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo7F.asm"
INCLUDE "scripts/SilphCo7F.asm"
INCLUDE "data/maps/objects/SilphCo7F.asm"
SilphCo7F_Blocks: INCBIN "maps/SilphCo7F.blk"
	assert @ - SilphCo7F_Blocks == SILPH_CO_7F_WIDTH * SILPH_CO_7F_HEIGHT, "SilphCo7F.blk size does not match SILPH_CO_7F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonMansion2F.asm"
INCLUDE "scripts/PokemonMansion2F.asm"
INCLUDE "data/maps/objects/PokemonMansion2F.asm"
PokemonMansion2F_Blocks: INCBIN "maps/PokemonMansion2F.blk"
	assert @ - PokemonMansion2F_Blocks == POKEMON_MANSION_2F_WIDTH * POKEMON_MANSION_2F_HEIGHT, "PokemonMansion2F.blk size does not match POKEMON_MANSION_2F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonMansion3F.asm"
INCLUDE "scripts/PokemonMansion3F.asm"
INCLUDE "data/maps/objects/PokemonMansion3F.asm"
PokemonMansion3F_Blocks: INCBIN "maps/PokemonMansion3F.blk"
	assert @ - PokemonMansion3F_Blocks == POKEMON_MANSION_3F_WIDTH * POKEMON_MANSION_3F_HEIGHT, "PokemonMansion3F.blk size does not match POKEMON_MANSION_3F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonMansionB1F.asm"
INCLUDE "scripts/PokemonMansionB1F.asm"
INCLUDE "data/maps/objects/PokemonMansionB1F.asm"
PokemonMansionB1F_Blocks: INCBIN "maps/PokemonMansionB1F.blk"
	assert @ - PokemonMansionB1F_Blocks == POKEMON_MANSION_B1F_WIDTH * POKEMON_MANSION_B1F_HEIGHT, "PokemonMansionB1F.blk size does not match POKEMON_MANSION_B1F in map_constants.asm"


SECTION "Maps 11", ROMX

INCLUDE "data/maps/headers/Route2.asm"
INCLUDE "data/maps/objects/Route2.asm"
Route2_Blocks: INCBIN "maps/Route2.blk"
	assert @ - Route2_Blocks == ROUTE_2_WIDTH * ROUTE_2_HEIGHT, "Route2.blk size does not match ROUTE_2 in map_constants.asm"

INCLUDE "data/maps/headers/Route3.asm"
INCLUDE "data/maps/objects/Route3.asm"
Route3_Blocks: INCBIN "maps/Route3.blk"
	assert @ - Route3_Blocks == ROUTE_3_WIDTH * ROUTE_3_HEIGHT, "Route3.blk size does not match ROUTE_3 in map_constants.asm"

INCLUDE "data/maps/headers/Route4.asm"
INCLUDE "data/maps/objects/Route4.asm"
Route4_Blocks: INCBIN "maps/Route4.blk"
	assert @ - Route4_Blocks == ROUTE_4_WIDTH * ROUTE_4_HEIGHT, "Route4.blk size does not match ROUTE_4 in map_constants.asm"

INCLUDE "data/maps/headers/Route5.asm"
INCLUDE "data/maps/objects/Route5.asm"
Route5_Blocks: INCBIN "maps/Route5.blk"
	assert @ - Route5_Blocks == ROUTE_5_WIDTH * ROUTE_5_HEIGHT, "Route5.blk size does not match ROUTE_5 in map_constants.asm"

INCLUDE "data/maps/headers/Route9.asm"
INCLUDE "data/maps/objects/Route9.asm"
Route9_Blocks: INCBIN "maps/Route9.blk"
	assert @ - Route9_Blocks == ROUTE_9_WIDTH * ROUTE_9_HEIGHT, "Route9.blk size does not match ROUTE_9 in map_constants.asm"

INCLUDE "data/maps/headers/Route13.asm"
INCLUDE "data/maps/objects/Route13.asm"
Route13_Blocks: INCBIN "maps/Route13.blk"
	assert @ - Route13_Blocks == ROUTE_13_WIDTH * ROUTE_13_HEIGHT, "Route13.blk size does not match ROUTE_13 in map_constants.asm"

INCLUDE "data/maps/headers/Route14.asm"
INCLUDE "data/maps/objects/Route14.asm"
Route14_Blocks: INCBIN "maps/Route14.blk"
	assert @ - Route14_Blocks == ROUTE_14_WIDTH * ROUTE_14_HEIGHT, "Route14.blk size does not match ROUTE_14 in map_constants.asm"

INCLUDE "data/maps/headers/Route17.asm"
INCLUDE "data/maps/objects/Route17.asm"
Route17_Blocks: INCBIN "maps/Route17.blk"
	assert @ - Route17_Blocks == ROUTE_17_WIDTH * ROUTE_17_HEIGHT, "Route17.blk size does not match ROUTE_17 in map_constants.asm"

INCLUDE "data/maps/headers/Route19.asm"
INCLUDE "data/maps/objects/Route19.asm"
Route19_Blocks: INCBIN "maps/Route19.blk"
	assert @ - Route19_Blocks == ROUTE_19_WIDTH * ROUTE_19_HEIGHT, "Route19.blk size does not match ROUTE_19 in map_constants.asm"

INCLUDE "data/maps/headers/Route21.asm"
INCLUDE "data/maps/objects/Route21.asm"
Route21_Blocks: INCBIN "maps/Route21.blk"
	assert @ - Route21_Blocks == ROUTE_21_WIDTH * ROUTE_21_HEIGHT, "Route21.blk size does not match ROUTE_21 in map_constants.asm"

; The two rod houses still share one layout. The Daycare used to stack here
; too, until it grew a staircase (2026-08-07) -- a stacked label means one
; file IS the other maps, and the stairs would have appeared in all three.
VermilionGoodRodHouse_Blocks:
Route12SuperRodHouse_Blocks: INCBIN "maps/VermilionGoodRodHouse.blk"
	assert @ - VermilionGoodRodHouse_Blocks == VERMILION_GOOD_ROD_HOUSE_WIDTH * VERMILION_GOOD_ROD_HOUSE_HEIGHT, "VermilionGoodRodHouse.blk size does not match VERMILION_GOOD_ROD_HOUSE in map_constants.asm"

Daycare_Blocks: INCBIN "maps/Daycare.blk"
	assert @ - Daycare_Blocks == DAYCARE_WIDTH * DAYCARE_HEIGHT, "Daycare.blk size does not match DAYCARE in map_constants.asm"

FuchsiaFossilHouse_Blocks: INCBIN "maps/FuchsiaFossilHouse.blk"
	assert @ - FuchsiaFossilHouse_Blocks == FUCHSIA_FOSSIL_HOUSE_WIDTH * FUCHSIA_FOSSIL_HOUSE_HEIGHT, "FuchsiaFossilHouse.blk size does not match FUCHSIA_FOSSIL_HOUSE in map_constants.asm"


SECTION "Maps 12", ROMX

INCLUDE "scripts/Route2.asm"
INCLUDE "scripts/Route3.asm"
INCLUDE "scripts/Route4.asm"
INCLUDE "scripts/Route5.asm"
INCLUDE "scripts/Route9.asm"
INCLUDE "scripts/Route13.asm"
INCLUDE "scripts/Route14.asm"
INCLUDE "scripts/Route17.asm"
INCLUDE "scripts/Route19.asm"
INCLUDE "scripts/Route21.asm"

INCLUDE "data/maps/headers/VermilionGoodRodHouse.asm"
INCLUDE "scripts/VermilionGoodRodHouse.asm"
INCLUDE "data/maps/objects/VermilionGoodRodHouse.asm"

INCLUDE "data/maps/headers/CeladonMart2F.asm"
INCLUDE "scripts/CeladonMart2F.asm"
INCLUDE "data/maps/objects/CeladonMart2F.asm"
CeladonMart2F_Blocks: INCBIN "maps/CeladonMart2F.blk"
	assert @ - CeladonMart2F_Blocks == CELADON_MART_2F_WIDTH * CELADON_MART_2F_HEIGHT, "CeladonMart2F.blk size does not match CELADON_MART_2F in map_constants.asm"

INCLUDE "data/maps/headers/FuchsiaFossilHouse.asm"
INCLUDE "scripts/FuchsiaFossilHouse.asm"
INCLUDE "data/maps/objects/FuchsiaFossilHouse.asm"

INCLUDE "data/maps/headers/Daycare.asm"
INCLUDE "scripts/Daycare.asm"
INCLUDE "data/maps/objects/Daycare.asm"

INCLUDE "data/maps/headers/Daycare2F.asm"
INCLUDE "scripts/Daycare2F.asm"
INCLUDE "data/maps/objects/Daycare2F.asm"
Daycare2F_Blocks: INCBIN "maps/Daycare2F.blk"
	assert @ - Daycare2F_Blocks == DAYCARE_2F_WIDTH * DAYCARE_2F_HEIGHT, "Daycare2F.blk size does not match DAYCARE_2F in map_constants.asm"

INCLUDE "data/maps/headers/Route12SuperRodHouse.asm"
INCLUDE "scripts/Route12SuperRodHouse.asm"
INCLUDE "data/maps/objects/Route12SuperRodHouse.asm"

INCLUDE "data/maps/headers/SilphCo8F.asm"
INCLUDE "scripts/SilphCo8F.asm"
INCLUDE "data/maps/objects/SilphCo8F.asm"
SilphCo8F_Blocks: INCBIN "maps/SilphCo8F.blk"
	assert @ - SilphCo8F_Blocks == SILPH_CO_8F_WIDTH * SILPH_CO_8F_HEIGHT, "SilphCo8F.blk size does not match SILPH_CO_8F in map_constants.asm"


SECTION "Maps 13", ROMX

INCLUDE "data/maps/headers/Route6.asm"
INCLUDE "data/maps/objects/Route6.asm"
Route6_Blocks: INCBIN "maps/Route6.blk"
	assert @ - Route6_Blocks == ROUTE_6_WIDTH * ROUTE_6_HEIGHT, "Route6.blk size does not match ROUTE_6 in map_constants.asm"

INCLUDE "data/maps/headers/Route8.asm"
INCLUDE "data/maps/objects/Route8.asm"
Route8_Blocks: INCBIN "maps/Route8.blk"
	assert @ - Route8_Blocks == ROUTE_8_WIDTH * ROUTE_8_HEIGHT, "Route8.blk size does not match ROUTE_8 in map_constants.asm"

INCLUDE "data/maps/headers/Route10.asm"
INCLUDE "data/maps/objects/Route10.asm"
Route10_Blocks: INCBIN "maps/Route10.blk"
	assert @ - Route10_Blocks == ROUTE_10_WIDTH * ROUTE_10_HEIGHT, "Route10.blk size does not match ROUTE_10 in map_constants.asm"

INCLUDE "data/maps/headers/Route11.asm"
INCLUDE "data/maps/objects/Route11.asm"
Route11_Blocks: INCBIN "maps/Route11.blk"
	assert @ - Route11_Blocks == ROUTE_11_WIDTH * ROUTE_11_HEIGHT, "Route11.blk size does not match ROUTE_11 in map_constants.asm"

INCLUDE "data/maps/headers/Route12.asm"
INCLUDE "data/maps/objects/Route12.asm"
Route12_Blocks: INCBIN "maps/Route12.blk"
	assert @ - Route12_Blocks == ROUTE_12_WIDTH * ROUTE_12_HEIGHT, "Route12.blk size does not match ROUTE_12 in map_constants.asm"

INCLUDE "data/maps/headers/Route15.asm"
INCLUDE "data/maps/objects/Route15.asm"
Route15_Blocks: INCBIN "maps/Route15.blk"
	assert @ - Route15_Blocks == ROUTE_15_WIDTH * ROUTE_15_HEIGHT, "Route15.blk size does not match ROUTE_15 in map_constants.asm"

INCLUDE "data/maps/headers/Route16.asm"
INCLUDE "data/maps/objects/Route16.asm"
Route16_Blocks: INCBIN "maps/Route16.blk"
	assert @ - Route16_Blocks == ROUTE_16_WIDTH * ROUTE_16_HEIGHT, "Route16.blk size does not match ROUTE_16 in map_constants.asm"

INCLUDE "data/maps/headers/Route18.asm"
INCLUDE "data/maps/objects/Route18.asm"
Route18_Blocks: INCBIN "maps/Route18.blk"
	assert @ - Route18_Blocks == ROUTE_18_WIDTH * ROUTE_18_HEIGHT, "Route18.blk size does not match ROUTE_18 in map_constants.asm"



SECTION "Maps 14", ROMX

INCLUDE "scripts/Route6.asm"
INCLUDE "scripts/Route8.asm"
INCLUDE "scripts/Route10.asm"
INCLUDE "scripts/Route11.asm"
INCLUDE "scripts/Route12.asm"
INCLUDE "scripts/Route15.asm"
INCLUDE "scripts/Route16.asm"
INCLUDE "scripts/Route18.asm"

INCLUDE "data/maps/headers/PokemonFanClub.asm"
INCLUDE "scripts/PokemonFanClub.asm"
INCLUDE "data/maps/objects/PokemonFanClub.asm"
PokemonFanClub_Blocks: INCBIN "maps/PokemonFanClub.blk"
	assert @ - PokemonFanClub_Blocks == POKEMON_FAN_CLUB_WIDTH * POKEMON_FAN_CLUB_HEIGHT, "PokemonFanClub.blk size does not match POKEMON_FAN_CLUB in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo2F.asm"
INCLUDE "scripts/SilphCo2F.asm"
INCLUDE "data/maps/objects/SilphCo2F.asm"
SilphCo2F_Blocks: INCBIN "maps/SilphCo2F.blk"
	assert @ - SilphCo2F_Blocks == SILPH_CO_2F_WIDTH * SILPH_CO_2F_HEIGHT, "SilphCo2F.blk size does not match SILPH_CO_2F in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo3F.asm"
INCLUDE "scripts/SilphCo3F.asm"
INCLUDE "data/maps/objects/SilphCo3F.asm"
SilphCo3F_Blocks: INCBIN "maps/SilphCo3F.blk"
	assert @ - SilphCo3F_Blocks == SILPH_CO_3F_WIDTH * SILPH_CO_3F_HEIGHT, "SilphCo3F.blk size does not match SILPH_CO_3F in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo10F.asm"
INCLUDE "scripts/SilphCo10F.asm"
INCLUDE "data/maps/objects/SilphCo10F.asm"
SilphCo10F_Blocks: INCBIN "maps/SilphCo10F.blk"
	assert @ - SilphCo10F_Blocks == SILPH_CO_10F_WIDTH * SILPH_CO_10F_HEIGHT, "SilphCo10F.blk size does not match SILPH_CO_10F in map_constants.asm"

INCLUDE "data/maps/headers/LancesRoom.asm"
INCLUDE "scripts/LancesRoom.asm"
INCLUDE "data/maps/objects/LancesRoom.asm"
LancesRoom_Blocks: INCBIN "maps/LancesRoom.blk"
	assert @ - LancesRoom_Blocks == LANCES_ROOM_WIDTH * LANCES_ROOM_HEIGHT, "LancesRoom.blk size does not match LANCES_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/HallOfFame.asm"
INCLUDE "scripts/HallOfFame.asm"
INCLUDE "data/maps/objects/HallOfFame.asm"
HallOfFame_Blocks: INCBIN "maps/HallOfFame.blk"
	assert @ - HallOfFame_Blocks == HALL_OF_FAME_WIDTH * HALL_OF_FAME_HEIGHT, "HallOfFame.blk size does not match HALL_OF_FAME in map_constants.asm"


SECTION "Maps 15", ROMX

SaffronMart_Blocks:
LavenderMart_Blocks:
CeruleanMart_Blocks:
VermilionMart_Blocks: INCBIN "maps/VermilionMart.blk"
	assert @ - VermilionMart_Blocks == VERMILION_MART_WIDTH * VERMILION_MART_HEIGHT, "VermilionMart.blk size does not match VERMILION_MART in map_constants.asm"

CopycatsHouse2F_Blocks:
RedsHouse2F_Blocks: INCBIN "maps/RedsHouse2F.blk"
	assert @ - RedsHouse2F_Blocks == REDS_HOUSE_2F_WIDTH * REDS_HOUSE_2F_HEIGHT, "RedsHouse2F.blk size does not match REDS_HOUSE_2F in map_constants.asm"

Museum1F_Blocks: INCBIN "maps/Museum1F.blk"
	assert @ - Museum1F_Blocks == MUSEUM_1F_WIDTH * MUSEUM_1F_HEIGHT, "Museum1F.blk size does not match MUSEUM_1F in map_constants.asm"

Museum2F_Blocks: INCBIN "maps/Museum2F.blk"
	assert @ - Museum2F_Blocks == MUSEUM_2F_WIDTH * MUSEUM_2F_HEIGHT, "Museum2F.blk size does not match MUSEUM_2F in map_constants.asm"

SaffronPokecenter_Blocks:
VermilionPokecenter_Blocks:
LavenderPokecenter_Blocks:
PewterPokecenter_Blocks: INCBIN "maps/PewterPokecenter.blk"
	assert @ - PewterPokecenter_Blocks == PEWTER_POKECENTER_WIDTH * PEWTER_POKECENTER_HEIGHT, "PewterPokecenter.blk size does not match PEWTER_POKECENTER in map_constants.asm"

UndergroundPathRoute7_Blocks:
UndergroundPathRoute7Copy_Blocks:
UndergroundPathRoute6_Blocks:
UndergroundPathRoute5_Blocks: INCBIN "maps/UndergroundPathRoute5.blk"
	assert @ - UndergroundPathRoute5_Blocks == UNDERGROUND_PATH_ROUTE_5_WIDTH * UNDERGROUND_PATH_ROUTE_5_HEIGHT, "UndergroundPathRoute5.blk size does not match UNDERGROUND_PATH_ROUTE_5 in map_constants.asm"

Route2Gate_Blocks:
ViridianForestSouthGate_Blocks:
ViridianForestNorthGate_Blocks: INCBIN "maps/ViridianForestNorthGate.blk"
	assert @ - ViridianForestNorthGate_Blocks == VIRIDIAN_FOREST_NORTH_GATE_WIDTH * VIRIDIAN_FOREST_NORTH_GATE_HEIGHT, "ViridianForestNorthGate.blk size does not match VIRIDIAN_FOREST_NORTH_GATE in map_constants.asm"

INCLUDE "data/maps/headers/RedsHouse2F.asm"
INCLUDE "scripts/RedsHouse2F.asm"
INCLUDE "data/maps/objects/RedsHouse2F.asm"


SECTION "Maps 16", ROMX

INCLUDE "data/maps/headers/Museum1F.asm"
INCLUDE "scripts/Museum1F.asm"
INCLUDE "data/maps/objects/Museum1F.asm"

INCLUDE "data/maps/headers/Museum2F.asm"
INCLUDE "scripts/Museum2F.asm"
INCLUDE "data/maps/objects/Museum2F.asm"

INCLUDE "data/maps/headers/PewterGym.asm"
INCLUDE "scripts/PewterGym.asm"
INCLUDE "data/maps/objects/PewterGym.asm"
PewterGym_Blocks: INCBIN "maps/PewterGym.blk"
	assert @ - PewterGym_Blocks == PEWTER_GYM_WIDTH * PEWTER_GYM_HEIGHT, "PewterGym.blk size does not match PEWTER_GYM in map_constants.asm"

INCLUDE "data/maps/headers/PewterPokecenter.asm"
INCLUDE "scripts/PewterPokecenter.asm"
INCLUDE "data/maps/objects/PewterPokecenter.asm"

INCLUDE "data/maps/headers/CeruleanPokecenter.asm"
INCLUDE "scripts/CeruleanPokecenter.asm"
INCLUDE "data/maps/objects/CeruleanPokecenter.asm"
CeruleanPokecenter_Blocks: INCBIN "maps/CeruleanPokecenter.blk"
	assert @ - CeruleanPokecenter_Blocks == CERULEAN_POKECENTER_WIDTH * CERULEAN_POKECENTER_HEIGHT, "CeruleanPokecenter.blk size does not match CERULEAN_POKECENTER in map_constants.asm"

INCLUDE "data/maps/headers/CeruleanGym.asm"
INCLUDE "scripts/CeruleanGym.asm"
INCLUDE "data/maps/objects/CeruleanGym.asm"
CeruleanGym_Blocks: INCBIN "maps/CeruleanGym.blk"
	assert @ - CeruleanGym_Blocks == CERULEAN_GYM_WIDTH * CERULEAN_GYM_HEIGHT, "CeruleanGym.blk size does not match CERULEAN_GYM in map_constants.asm"

INCLUDE "data/maps/headers/CeruleanMart.asm"
INCLUDE "scripts/CeruleanMart.asm"
INCLUDE "data/maps/objects/CeruleanMart.asm"

INCLUDE "data/maps/headers/LavenderPokecenter.asm"
INCLUDE "scripts/LavenderPokecenter.asm"
INCLUDE "data/maps/objects/LavenderPokecenter.asm"

INCLUDE "data/maps/headers/LavenderMart.asm"
INCLUDE "scripts/LavenderMart.asm"
INCLUDE "data/maps/objects/LavenderMart.asm"

INCLUDE "data/maps/headers/VermilionPokecenter.asm"
INCLUDE "scripts/VermilionPokecenter.asm"
INCLUDE "data/maps/objects/VermilionPokecenter.asm"

INCLUDE "data/maps/headers/VermilionMart.asm"
INCLUDE "scripts/VermilionMart.asm"
INCLUDE "data/maps/objects/VermilionMart.asm"

INCLUDE "data/maps/headers/VermilionGym.asm"
INCLUDE "scripts/VermilionGym.asm"
INCLUDE "data/maps/objects/VermilionGym.asm"
VermilionGym_Blocks: INCBIN "maps/VermilionGym.blk"
	assert @ - VermilionGym_Blocks == VERMILION_GYM_WIDTH * VERMILION_GYM_HEIGHT, "VermilionGym.blk size does not match VERMILION_GYM in map_constants.asm"

INCLUDE "data/maps/headers/CopycatsHouse2F.asm"
INCLUDE "scripts/CopycatsHouse2F.asm"
INCLUDE "data/maps/objects/CopycatsHouse2F.asm"

INCLUDE "data/maps/headers/FightingDojo.asm"
INCLUDE "scripts/FightingDojo.asm"
INCLUDE "data/maps/objects/FightingDojo.asm"
FightingDojo_Blocks: INCBIN "maps/FightingDojo.blk"
	assert @ - FightingDojo_Blocks == FIGHTING_DOJO_WIDTH * FIGHTING_DOJO_HEIGHT, "FightingDojo.blk size does not match FIGHTING_DOJO in map_constants.asm"

INCLUDE "data/maps/headers/SaffronGym.asm"
INCLUDE "scripts/SaffronGym.asm"
INCLUDE "data/maps/objects/SaffronGym.asm"
SaffronGym_Blocks: INCBIN "maps/SaffronGym.blk"
	assert @ - SaffronGym_Blocks == SAFFRON_GYM_WIDTH * SAFFRON_GYM_HEIGHT, "SaffronGym.blk size does not match SAFFRON_GYM in map_constants.asm"

INCLUDE "data/maps/headers/SaffronMart.asm"
INCLUDE "scripts/SaffronMart.asm"
INCLUDE "data/maps/objects/SaffronMart.asm"

INCLUDE "data/maps/headers/SilphCo1F.asm"
INCLUDE "scripts/SilphCo1F.asm"
INCLUDE "data/maps/objects/SilphCo1F.asm"
SilphCo1F_Blocks: INCBIN "maps/SilphCo1F.blk"
	assert @ - SilphCo1F_Blocks == SILPH_CO_1F_WIDTH * SILPH_CO_1F_HEIGHT, "SilphCo1F.blk size does not match SILPH_CO_1F in map_constants.asm"

INCLUDE "data/maps/headers/SaffronPokecenter.asm"
INCLUDE "scripts/SaffronPokecenter.asm"
INCLUDE "data/maps/objects/SaffronPokecenter.asm"

INCLUDE "data/maps/headers/ViridianForestNorthGate.asm"
INCLUDE "scripts/ViridianForestNorthGate.asm"
INCLUDE "data/maps/objects/ViridianForestNorthGate.asm"

INCLUDE "data/maps/headers/Route2Gate.asm"
INCLUDE "scripts/Route2Gate.asm"
INCLUDE "data/maps/objects/Route2Gate.asm"

INCLUDE "data/maps/headers/ViridianForestSouthGate.asm"
INCLUDE "scripts/ViridianForestSouthGate.asm"
INCLUDE "data/maps/objects/ViridianForestSouthGate.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute5.asm"
INCLUDE "scripts/UndergroundPathRoute5.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute5.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute6.asm"
INCLUDE "scripts/UndergroundPathRoute6.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute6.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute7.asm"
INCLUDE "scripts/UndergroundPathRoute7.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute7.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute7Copy.asm"
INCLUDE "scripts/UndergroundPathRoute7Copy.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute7Copy.asm"

INCLUDE "data/maps/headers/SilphCo9F.asm"
INCLUDE "scripts/SilphCo9F.asm"
INCLUDE "data/maps/objects/SilphCo9F.asm"
SilphCo9F_Blocks: INCBIN "maps/SilphCo9F.blk"
	assert @ - SilphCo9F_Blocks == SILPH_CO_9F_WIDTH * SILPH_CO_9F_HEIGHT, "SilphCo9F.blk size does not match SILPH_CO_9F in map_constants.asm"

INCLUDE "data/maps/headers/VictoryRoad1F.asm"
INCLUDE "scripts/VictoryRoad1F.asm"
INCLUDE "data/maps/objects/VictoryRoad1F.asm"
VictoryRoad1F_Blocks: INCBIN "maps/VictoryRoad1F.blk"
	assert @ - VictoryRoad1F_Blocks == VICTORY_ROAD_1F_WIDTH * VICTORY_ROAD_1F_HEIGHT, "VictoryRoad1F.blk size does not match VICTORY_ROAD_1F in map_constants.asm"


SECTION "Maps 17", ROMX

ViridianForest_Blocks: INCBIN "maps/ViridianForest.blk"
	assert @ - ViridianForest_Blocks == VIRIDIAN_FOREST_WIDTH * VIRIDIAN_FOREST_HEIGHT, "ViridianForest.blk size does not match VIRIDIAN_FOREST in map_constants.asm"
UndergroundPathNorthSouth_Blocks: INCBIN "maps/UndergroundPathNorthSouth.blk"
	; NO SIZE ASSERT HERE, and deliberately so: this is a vanilla quirk, not a
	; mistake of ours. The header declares 4x24 while the .blk holds only 4x23
	; rows (see the note in map_constants.asm), so the engine reads four bytes
	; past the file for a bottom row nobody can reach. Correcting the constant
	; would shorten a map that connections and warps are calibrated against —
	; a real behaviour change to fix something that has never been visible.
	; Every OTHER map is guarded; if this one ever gets redrawn, give it a
	; matching height and restore the assert.
UndergroundPathWestEast_Blocks: INCBIN "maps/UndergroundPathWestEast.blk"
	assert @ - UndergroundPathWestEast_Blocks == UNDERGROUND_PATH_WEST_EAST_WIDTH * UNDERGROUND_PATH_WEST_EAST_HEIGHT, "UndergroundPathWestEast.blk size does not match UNDERGROUND_PATH_WEST_EAST in map_constants.asm"


SSAnneB1FRooms_Blocks:
SSAnne2FRooms_Blocks: INCBIN "maps/SSAnne2FRooms.blk"
	assert @ - SSAnne2FRooms_Blocks == SS_ANNE_2F_ROOMS_WIDTH * SS_ANNE_2F_ROOMS_HEIGHT, "SSAnne2FRooms.blk size does not match SS_ANNE_2F_ROOMS in map_constants.asm"

INCLUDE "data/maps/headers/PokemonTower1F.asm"
INCLUDE "scripts/PokemonTower1F.asm"
INCLUDE "data/maps/objects/PokemonTower1F.asm"
PokemonTower1F_Blocks: INCBIN "maps/PokemonTower1F.blk"
	assert @ - PokemonTower1F_Blocks == POKEMON_TOWER_1F_WIDTH * POKEMON_TOWER_1F_HEIGHT, "PokemonTower1F.blk size does not match POKEMON_TOWER_1F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonTower2F.asm"
INCLUDE "scripts/PokemonTower2F.asm"
INCLUDE "data/maps/objects/PokemonTower2F.asm"
PokemonTower2F_Blocks: INCBIN "maps/PokemonTower2F.blk"
	assert @ - PokemonTower2F_Blocks == POKEMON_TOWER_2F_WIDTH * POKEMON_TOWER_2F_HEIGHT, "PokemonTower2F.blk size does not match POKEMON_TOWER_2F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonTower3F.asm"
INCLUDE "scripts/PokemonTower3F.asm"
INCLUDE "data/maps/objects/PokemonTower3F.asm"
PokemonTower3F_Blocks: INCBIN "maps/PokemonTower3F.blk"
	assert @ - PokemonTower3F_Blocks == POKEMON_TOWER_3F_WIDTH * POKEMON_TOWER_3F_HEIGHT, "PokemonTower3F.blk size does not match POKEMON_TOWER_3F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonTower4F.asm"
INCLUDE "scripts/PokemonTower4F.asm"
INCLUDE "data/maps/objects/PokemonTower4F.asm"
PokemonTower4F_Blocks: INCBIN "maps/PokemonTower4F.blk"
	assert @ - PokemonTower4F_Blocks == POKEMON_TOWER_4F_WIDTH * POKEMON_TOWER_4F_HEIGHT, "PokemonTower4F.blk size does not match POKEMON_TOWER_4F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonTower5F.asm"
INCLUDE "scripts/PokemonTower5F.asm"
INCLUDE "data/maps/objects/PokemonTower5F.asm"
PokemonTower5F_Blocks: INCBIN "maps/PokemonTower5F.blk"
	assert @ - PokemonTower5F_Blocks == POKEMON_TOWER_5F_WIDTH * POKEMON_TOWER_5F_HEIGHT, "PokemonTower5F.blk size does not match POKEMON_TOWER_5F in map_constants.asm"

INCLUDE "data/maps/headers/PokemonTower6F.asm"
INCLUDE "scripts/PokemonTower6F.asm"
INCLUDE "data/maps/objects/PokemonTower6F.asm"
PokemonTower6F_Blocks: INCBIN "maps/PokemonTower6F.blk"
	assert @ - PokemonTower6F_Blocks == POKEMON_TOWER_6F_WIDTH * POKEMON_TOWER_6F_HEIGHT, "PokemonTower6F.blk size does not match POKEMON_TOWER_6F in map_constants.asm"


INCLUDE "data/maps/headers/PokemonTower7F.asm"
INCLUDE "scripts/PokemonTower7F.asm"
INCLUDE "data/maps/objects/PokemonTower7F.asm"
PokemonTower7F_Blocks: INCBIN "maps/PokemonTower7F.blk"
	assert @ - PokemonTower7F_Blocks == POKEMON_TOWER_7F_WIDTH * POKEMON_TOWER_7F_HEIGHT, "PokemonTower7F.blk size does not match POKEMON_TOWER_7F in map_constants.asm"


SECTION "Maps 18", ROMX

INCLUDE "data/maps/headers/ViridianForest.asm"
INCLUDE "scripts/ViridianForest.asm"
INCLUDE "data/maps/objects/ViridianForest.asm"

INCLUDE "data/maps/headers/SSAnne1F.asm"
INCLUDE "scripts/SSAnne1F.asm"
INCLUDE "data/maps/objects/SSAnne1F.asm"
SSAnne1F_Blocks: INCBIN "maps/SSAnne1F.blk"
	assert @ - SSAnne1F_Blocks == SS_ANNE_1F_WIDTH * SS_ANNE_1F_HEIGHT, "SSAnne1F.blk size does not match SS_ANNE_1F in map_constants.asm"

INCLUDE "data/maps/headers/SSAnne2F.asm"
INCLUDE "scripts/SSAnne2F.asm"
INCLUDE "data/maps/objects/SSAnne2F.asm"
SSAnne2F_Blocks: INCBIN "maps/SSAnne2F.blk"
	assert @ - SSAnne2F_Blocks == SS_ANNE_2F_WIDTH * SS_ANNE_2F_HEIGHT, "SSAnne2F.blk size does not match SS_ANNE_2F in map_constants.asm"

INCLUDE "data/maps/headers/SSAnneB1F.asm"
INCLUDE "scripts/SSAnneB1F.asm"
INCLUDE "data/maps/objects/SSAnneB1F.asm"
SSAnneB1F_Blocks: INCBIN "maps/SSAnneB1F.blk"
	assert @ - SSAnneB1F_Blocks == SS_ANNE_B1F_WIDTH * SS_ANNE_B1F_HEIGHT, "SSAnneB1F.blk size does not match SS_ANNE_B1F in map_constants.asm"

INCLUDE "data/maps/headers/SSAnneBow.asm"
INCLUDE "scripts/SSAnneBow.asm"
INCLUDE "data/maps/objects/SSAnneBow.asm"
SSAnneBow_Blocks: INCBIN "maps/SSAnneBow.blk"
	assert @ - SSAnneBow_Blocks == SS_ANNE_BOW_WIDTH * SS_ANNE_BOW_HEIGHT, "SSAnneBow.blk size does not match SS_ANNE_BOW in map_constants.asm"

INCLUDE "data/maps/headers/SSAnneKitchen.asm"
INCLUDE "scripts/SSAnneKitchen.asm"
INCLUDE "data/maps/objects/SSAnneKitchen.asm"
SSAnneKitchen_Blocks: INCBIN "maps/SSAnneKitchen.blk"
	assert @ - SSAnneKitchen_Blocks == SS_ANNE_KITCHEN_WIDTH * SS_ANNE_KITCHEN_HEIGHT, "SSAnneKitchen.blk size does not match SS_ANNE_KITCHEN in map_constants.asm"

INCLUDE "data/maps/headers/SSAnneCaptainsRoom.asm"
INCLUDE "scripts/SSAnneCaptainsRoom.asm"
INCLUDE "data/maps/objects/SSAnneCaptainsRoom.asm"
SSAnneCaptainsRoom_Blocks: INCBIN "maps/SSAnneCaptainsRoom.blk"
	assert @ - SSAnneCaptainsRoom_Blocks == SS_ANNE_CAPTAINS_ROOM_WIDTH * SS_ANNE_CAPTAINS_ROOM_HEIGHT, "SSAnneCaptainsRoom.blk size does not match SS_ANNE_CAPTAINS_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/SSAnne1FRooms.asm"
INCLUDE "scripts/SSAnne1FRooms.asm"
INCLUDE "data/maps/objects/SSAnne1FRooms.asm"
SSAnne1FRooms_Blocks: INCBIN "maps/SSAnne1FRooms.blk"
	assert @ - SSAnne1FRooms_Blocks == SS_ANNE_1F_ROOMS_WIDTH * SS_ANNE_1F_ROOMS_HEIGHT, "SSAnne1FRooms.blk size does not match SS_ANNE_1F_ROOMS in map_constants.asm"

INCLUDE "data/maps/headers/SSAnne2FRooms.asm"
INCLUDE "scripts/SSAnne2FRooms.asm"
INCLUDE "data/maps/objects/SSAnne2FRooms.asm"

INCLUDE "data/maps/headers/SSAnneB1FRooms.asm"
INCLUDE "scripts/SSAnneB1FRooms.asm"
INCLUDE "data/maps/objects/SSAnneB1FRooms.asm"

INCLUDE "data/maps/headers/UndergroundPathNorthSouth.asm"
INCLUDE "scripts/UndergroundPathNorthSouth.asm"
INCLUDE "data/maps/objects/UndergroundPathNorthSouth.asm"

INCLUDE "data/maps/headers/UndergroundPathWestEast.asm"
INCLUDE "scripts/UndergroundPathWestEast.asm"
INCLUDE "data/maps/objects/UndergroundPathWestEast.asm"

INCLUDE "data/maps/headers/DiglettsCave.asm"
INCLUDE "scripts/DiglettsCave.asm"
INCLUDE "data/maps/objects/DiglettsCave.asm"
DiglettsCave_Blocks: INCBIN "maps/DiglettsCave.blk"
	assert @ - DiglettsCave_Blocks == DIGLETTS_CAVE_WIDTH * DIGLETTS_CAVE_HEIGHT, "DiglettsCave.blk size does not match DIGLETTS_CAVE in map_constants.asm"

INCLUDE "data/maps/headers/SilphCo11F.asm"
INCLUDE "scripts/SilphCo11F.asm"
INCLUDE "data/maps/objects/SilphCo11F.asm"
SilphCo11F_Blocks: INCBIN "maps/SilphCo11F.blk"
	assert @ - SilphCo11F_Blocks == SILPH_CO_11F_WIDTH * SILPH_CO_11F_HEIGHT, "SilphCo11F.blk size does not match SILPH_CO_11F in map_constants.asm"


SECTION "Maps 19", ROMX

CopycatsHouse1F_Blocks: INCBIN "maps/CopycatsHouse1F.blk"
	assert @ - CopycatsHouse1F_Blocks == COPYCATS_HOUSE_1F_WIDTH * COPYCATS_HOUSE_1F_HEIGHT, "CopycatsHouse1F.blk size does not match COPYCATS_HOUSE_1F in map_constants.asm"

CinnabarMart_Blocks:
PewterMart_Blocks: INCBIN "maps/PewterMart.blk"
	assert @ - PewterMart_Blocks == PEWTER_MART_WIDTH * PEWTER_MART_HEIGHT, "PewterMart.blk size does not match PEWTER_MART in map_constants.asm"

FuchsiaBillsGrandpasHouse_Blocks: INCBIN "maps/FuchsiaBillsGrandpasHouse.blk"
	assert @ - FuchsiaBillsGrandpasHouse_Blocks == FUCHSIA_BILLS_GRANDPAS_HOUSE_WIDTH * FUCHSIA_BILLS_GRANDPAS_HOUSE_HEIGHT, "FuchsiaBillsGrandpasHouse.blk size does not match FUCHSIA_BILLS_GRANDPAS_HOUSE in map_constants.asm"

CinnabarPokecenter_Blocks:
FuchsiaPokecenter_Blocks: INCBIN "maps/FuchsiaPokecenter.blk"
	assert @ - FuchsiaPokecenter_Blocks == FUCHSIA_POKECENTER_WIDTH * FUCHSIA_POKECENTER_HEIGHT, "FuchsiaPokecenter.blk size does not match FUCHSIA_POKECENTER in map_constants.asm"

CeruleanBadgeHouse_Blocks: INCBIN "maps/CeruleanBadgeHouse.blk"
	assert @ - CeruleanBadgeHouse_Blocks == CERULEAN_BADGE_HOUSE_WIDTH * CERULEAN_BADGE_HOUSE_HEIGHT, "CeruleanBadgeHouse.blk size does not match CERULEAN_BADGE_HOUSE in map_constants.asm"


SECTION "Maps 20", ROMX

INCLUDE "scripts/CeruleanCity_2.asm"

INCLUDE "data/maps/headers/ViridianGym.asm"
INCLUDE "scripts/ViridianGym.asm"
INCLUDE "data/maps/objects/ViridianGym.asm"
ViridianGym_Blocks: INCBIN "maps/ViridianGym.blk"
	assert @ - ViridianGym_Blocks == VIRIDIAN_GYM_WIDTH * VIRIDIAN_GYM_HEIGHT, "ViridianGym.blk size does not match VIRIDIAN_GYM in map_constants.asm"

INCLUDE "data/maps/headers/PewterMart.asm"
INCLUDE "scripts/PewterMart.asm"
INCLUDE "data/maps/objects/PewterMart.asm"

INCLUDE "data/maps/headers/CeruleanCave1F.asm"
INCLUDE "scripts/CeruleanCave1F.asm"
INCLUDE "data/maps/objects/CeruleanCave1F.asm"
CeruleanCave1F_Blocks: INCBIN "maps/CeruleanCave1F.blk"
	assert @ - CeruleanCave1F_Blocks == CERULEAN_CAVE_1F_WIDTH * CERULEAN_CAVE_1F_HEIGHT, "CeruleanCave1F.blk size does not match CERULEAN_CAVE_1F in map_constants.asm"

INCLUDE "data/maps/headers/CeruleanBadgeHouse.asm"
INCLUDE "scripts/CeruleanBadgeHouse.asm"
INCLUDE "data/maps/objects/CeruleanBadgeHouse.asm"


SECTION "Maps 21", ROMX

INCLUDE "data/maps/headers/FuchsiaBillsGrandpasHouse.asm"
INCLUDE "scripts/FuchsiaBillsGrandpasHouse.asm"
INCLUDE "data/maps/objects/FuchsiaBillsGrandpasHouse.asm"

INCLUDE "data/maps/headers/FuchsiaPokecenter.asm"
INCLUDE "scripts/FuchsiaPokecenter.asm"
INCLUDE "data/maps/objects/FuchsiaPokecenter.asm"

INCLUDE "data/maps/headers/WardensHouse.asm"
INCLUDE "scripts/WardensHouse.asm"
INCLUDE "data/maps/objects/WardensHouse.asm"
WardensHouse_Blocks: INCBIN "maps/WardensHouse.blk"
	assert @ - WardensHouse_Blocks == WARDENS_HOUSE_WIDTH * WARDENS_HOUSE_HEIGHT, "WardensHouse.blk size does not match WARDENS_HOUSE in map_constants.asm"

INCLUDE "data/maps/headers/SafariZoneGate.asm"
INCLUDE "data/maps/objects/SafariZoneGate.asm"
SafariZoneGate_Blocks: INCBIN "maps/SafariZoneGate.blk"
	assert @ - SafariZoneGate_Blocks == SAFARI_ZONE_GATE_WIDTH * SAFARI_ZONE_GATE_HEIGHT, "SafariZoneGate.blk size does not match SAFARI_ZONE_GATE in map_constants.asm"
INCLUDE "scripts/SafariZoneGate.asm"

INCLUDE "data/maps/headers/FuchsiaGym.asm"
INCLUDE "scripts/FuchsiaGym.asm"
INCLUDE "data/maps/objects/FuchsiaGym.asm"
FuchsiaGym_Blocks: INCBIN "maps/FuchsiaGym.blk"
	assert @ - FuchsiaGym_Blocks == FUCHSIA_GYM_WIDTH * FUCHSIA_GYM_HEIGHT, "FuchsiaGym.blk size does not match FUCHSIA_GYM in map_constants.asm"

INCLUDE "data/maps/headers/FuchsiaMeetingRoom.asm"
INCLUDE "scripts/FuchsiaMeetingRoom.asm"
INCLUDE "data/maps/objects/FuchsiaMeetingRoom.asm"
FuchsiaMeetingRoom_Blocks: INCBIN "maps/FuchsiaMeetingRoom.blk"
	assert @ - FuchsiaMeetingRoom_Blocks == FUCHSIA_MEETING_ROOM_WIDTH * FUCHSIA_MEETING_ROOM_HEIGHT, "FuchsiaMeetingRoom.blk size does not match FUCHSIA_MEETING_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/CinnabarGym.asm"
INCLUDE "scripts/CinnabarGym.asm"
INCLUDE "data/maps/objects/CinnabarGym.asm"
CinnabarGym_Blocks: INCBIN "maps/CinnabarGym.blk"
	assert @ - CinnabarGym_Blocks == CINNABAR_GYM_WIDTH * CINNABAR_GYM_HEIGHT, "CinnabarGym.blk size does not match CINNABAR_GYM in map_constants.asm"
INCLUDE "scripts/CinnabarGym_2.asm"

INCLUDE "data/maps/headers/CinnabarLab.asm"
INCLUDE "scripts/CinnabarLab.asm"
INCLUDE "data/maps/objects/CinnabarLab.asm"
CinnabarLab_Blocks: INCBIN "maps/CinnabarLab.blk"
	assert @ - CinnabarLab_Blocks == CINNABAR_LAB_WIDTH * CINNABAR_LAB_HEIGHT, "CinnabarLab.blk size does not match CINNABAR_LAB in map_constants.asm"

INCLUDE "data/maps/headers/CinnabarLabTradeRoom.asm"
INCLUDE "scripts/CinnabarLabTradeRoom.asm"
INCLUDE "data/maps/objects/CinnabarLabTradeRoom.asm"
CinnabarLabTradeRoom_Blocks: INCBIN "maps/CinnabarLabTradeRoom.blk"
	assert @ - CinnabarLabTradeRoom_Blocks == CINNABAR_LAB_TRADE_ROOM_WIDTH * CINNABAR_LAB_TRADE_ROOM_HEIGHT, "CinnabarLabTradeRoom.blk size does not match CINNABAR_LAB_TRADE_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/CinnabarLabMetronomeRoom.asm"
INCLUDE "scripts/CinnabarLabMetronomeRoom.asm"
INCLUDE "data/maps/objects/CinnabarLabMetronomeRoom.asm"
CinnabarLabMetronomeRoom_Blocks: INCBIN "maps/CinnabarLabMetronomeRoom.blk"
	assert @ - CinnabarLabMetronomeRoom_Blocks == CINNABAR_LAB_METRONOME_ROOM_WIDTH * CINNABAR_LAB_METRONOME_ROOM_HEIGHT, "CinnabarLabMetronomeRoom.blk size does not match CINNABAR_LAB_METRONOME_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/CinnabarLabFossilRoom.asm"
INCLUDE "scripts/CinnabarLabFossilRoom.asm"
INCLUDE "data/maps/objects/CinnabarLabFossilRoom.asm"
CinnabarLabFossilRoom_Blocks: INCBIN "maps/CinnabarLabFossilRoom.blk"
	assert @ - CinnabarLabFossilRoom_Blocks == CINNABAR_LAB_FOSSIL_ROOM_WIDTH * CINNABAR_LAB_FOSSIL_ROOM_HEIGHT, "CinnabarLabFossilRoom.blk size does not match CINNABAR_LAB_FOSSIL_ROOM in map_constants.asm"

; Mateo's move relearner/deleter files
INCLUDE "scripts/move_deleter.asm"
INCLUDE "scripts/move_relearner.asm"

INCLUDE "data/maps/headers/CinnabarPokecenter.asm"
INCLUDE "scripts/CinnabarPokecenter.asm"
INCLUDE "data/maps/objects/CinnabarPokecenter.asm"

INCLUDE "data/maps/headers/CinnabarMart.asm"
INCLUDE "scripts/CinnabarMart.asm"
INCLUDE "data/maps/objects/CinnabarMart.asm"

INCLUDE "data/maps/headers/CopycatsHouse1F.asm"
INCLUDE "scripts/CopycatsHouse1F.asm"
INCLUDE "data/maps/objects/CopycatsHouse1F.asm"

INCLUDE "data/maps/headers/ChampionsRoom.asm"
INCLUDE "scripts/ChampionsRoom.asm"
INCLUDE "data/maps/objects/ChampionsRoom.asm"
ChampionsRoom_Blocks: INCBIN "maps/ChampionsRoom.blk"
	assert @ - ChampionsRoom_Blocks == CHAMPIONS_ROOM_WIDTH * CHAMPIONS_ROOM_HEIGHT, "ChampionsRoom.blk size does not match CHAMPIONS_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/LoreleisRoom.asm"
INCLUDE "scripts/LoreleisRoom.asm"
INCLUDE "data/maps/objects/LoreleisRoom.asm"
LoreleisRoom_Blocks: INCBIN "maps/LoreleisRoom.blk"
	assert @ - LoreleisRoom_Blocks == LORELEIS_ROOM_WIDTH * LORELEIS_ROOM_HEIGHT, "LoreleisRoom.blk size does not match LORELEIS_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/BrunosRoom.asm"
INCLUDE "scripts/BrunosRoom.asm"
INCLUDE "data/maps/objects/BrunosRoom.asm"
BrunosRoom_Blocks: INCBIN "maps/BrunosRoom.blk"
	assert @ - BrunosRoom_Blocks == BRUNOS_ROOM_WIDTH * BRUNOS_ROOM_HEIGHT, "BrunosRoom.blk size does not match BRUNOS_ROOM in map_constants.asm"

INCLUDE "data/maps/headers/AgathasRoom.asm"
INCLUDE "scripts/AgathasRoom.asm"
INCLUDE "data/maps/objects/AgathasRoom.asm"
AgathasRoom_Blocks: INCBIN "maps/AgathasRoom.blk"
	assert @ - AgathasRoom_Blocks == AGATHAS_ROOM_WIDTH * AGATHAS_ROOM_HEIGHT, "AgathasRoom.blk size does not match AGATHAS_ROOM in map_constants.asm"


SECTION "Maps 22", ROMX

INCLUDE "scripts/ViridianCity_2.asm"
INCLUDE "scripts/VermilionCity_2.asm"
INCLUDE "scripts/CeladonCity_2.asm"
INCLUDE "scripts/Route1_2.asm"
INCLUDE "scripts/Route22_2.asm"
INCLUDE "scripts/RedsHouse1F_2.asm"
INCLUDE "scripts/OaksLab_2.asm"
INCLUDE "scripts/ViridianSchoolHouse_2.asm"
INCLUDE "scripts/Museum1F_2.asm"
INCLUDE "scripts/PewterPokecenter_2.asm"
INCLUDE "scripts/PokemonTower2F_2.asm"
INCLUDE "scripts/CeladonMart3F_2.asm"
INCLUDE "scripts/CeladonMansion1F_2.asm"
INCLUDE "scripts/CeladonMansion3F_2.asm"
INCLUDE "scripts/GameCorner_2.asm"
INCLUDE "scripts/CeladonDiner_2.asm"
INCLUDE "scripts/SafariZoneGate_2.asm"
INCLUDE "scripts/CinnabarGym_3.asm"
INCLUDE "scripts/MtMoonPokecenter_2.asm"

INCLUDE "data/maps/headers/SummerBeachHouse.asm"
INCLUDE "scripts/SummerBeachHouse.asm"
SummerBeachHouse_Blocks: INCBIN "maps/SummerBeachHouse.blk"
	assert @ - SummerBeachHouse_Blocks == SUMMER_BEACH_HOUSE_WIDTH * SUMMER_BEACH_HOUSE_HEIGHT, "SummerBeachHouse.blk size does not match SUMMER_BEACH_HOUSE in map_constants.asm"
INCLUDE "data/maps/objects/SummerBeachHouse.asm"

INCLUDE "scripts/BillsHouse_2.asm"
INCLUDE "scripts/CeladonMansionRoofHouse_2.asm"
INCLUDE "scripts/ViridianForest_2.asm"
INCLUDE "scripts/SSAnne2FRooms_2.asm"
INCLUDE "scripts/SilphCo11F_2.asm"

; BILL's garden, behind the Sea Cottage. A FLOATING section on purpose: every
; "Maps N" section is pinned to a bank in layout.link, so adding a map to one
; eats that bank's slack. The header, script, objects and blocks must all live
; in the SAME section, because map_header stores `dw BillsGarden_Blocks` -- a
; 16-bit pointer that is read with the header's own bank.
;
; The map was seeded from kep-hack's BillsGarden.blk (see the credit note in
; the CHANGELIST) and is meant to be redrawn.
SECTION "Bills Garden Map", ROMX

INCLUDE "data/maps/headers/BillsGarden.asm"
INCLUDE "scripts/BillsGarden.asm"
INCLUDE "data/maps/objects/BillsGarden.asm"
BillsGarden_Blocks: INCBIN "maps/BillsGarden.blk"
	assert @ - BillsGarden_Blocks == BILLS_GARDEN_WIDTH * BILLS_GARDEN_HEIGHT, "BillsGarden.blk size does not match BILLS_GARDEN in map_constants.asm"
