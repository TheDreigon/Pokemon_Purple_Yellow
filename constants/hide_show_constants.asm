DEF HIDE EQU $11
DEF SHOW EQU $15

; MissableObjects indexes (see data/maps/hide_show_data.asm)
; this is a list of the sprites that can be enabled/disabled during the game

	const_def
	const HS_PALLET_TOWN_OAK               ; 00
	const HS_PALLET_TOWN_MOM               ; 01
	const HS_LYING_OLD_MAN                 ; 02
	const HS_OLD_MAN_1                     ; 03
	const HS_OLD_MAN_2                     ; 04
	const HS_MUSEUM_GUY                    ; 05
	const HS_GYM_GUY                       ; 06
	const HS_CERULEAN_RIVAL                ; 07
	const HS_CERULEAN_ROCKET               ; 08
	const HS_CERULEAN_GUARD_1              ; 09
	const HS_CERULEAN_CAVE_GUY             ; 0A
	const HS_CERULEAN_GUARD_2              ; 0B
	const HS_SAFFRON_CITY_1                ; 0C
	const HS_SAFFRON_CITY_2                ; 0D
	const HS_SAFFRON_CITY_3                ; 0E
	const HS_SAFFRON_CITY_4                ; 0F
	const HS_SAFFRON_CITY_5                ; 10
	const HS_SAFFRON_CITY_6                ; 11
	const HS_SAFFRON_CITY_7                ; 12
	const HS_SAFFRON_CITY_8                ; 13
	const HS_SAFFRON_CITY_9                ; 14
	const HS_SAFFRON_CITY_A                ; 15
	const HS_SAFFRON_CITY_B                ; 16
	const HS_SAFFRON_CITY_C                ; 17
	const HS_SAFFRON_CITY_D                ; 18
	const HS_SAFFRON_CITY_E                ; 19
	const HS_ROUTE_1_OAK				   ; 1A
	const HS_ROUTE_2_ITEM_1                ; 1B
	const HS_ROUTE_2_ITEM_2                ; 1C
	const HS_ROUTE_4_ITEM                  ; 1D
	const HS_ROUTE_9_ITEM                  ; 1E
	const HS_ROUTE_11_CARBOS               ; 1F
	const HS_ROUTE_12_SNORLAX              ; 20
	const HS_ROUTE_12_ITEM_1               ; 21
	const HS_ROUTE_12_ITEM_2               ; 22
	const HS_ROUTE_15_ITEM                 ; 23
	const HS_ROUTE_16_SNORLAX              ; 24
	const HS_ROUTE_22_RIVAL_1              ; 25
	const HS_ROUTE_22_RIVAL_2              ; 26
	const HS_NUGGET_BRIDGE_GUY             ; 27
	const HS_ROUTE_24_ITEM                 ; 28
	const HS_ROUTE_25_ITEM                 ; 29
	const HS_REDS_HOUSE_2F_MR_MIME         ; 2A
	const HS_DAISY_SITTING                 ; 2B
	const HS_DAISY_WALKING                 ; 2C
	const HS_TOWN_MAP                      ; 2D
	const HS_OAKS_LAB_RIVAL                ; 2E
	const HS_STARTER_BALL_1                ; 2F
	const HS_OAKS_LAB_OAK_1                ; 30
	const HS_POKEDEX_1                     ; 31
	const HS_POKEDEX_2                     ; 32
	const HS_OAKS_LAB_OAK_2                ; 33
	const HS_VIRIDIAN_GYM_GIOVANNI         ; 34
	const HS_VIRIDIAN_GYM_ITEM             ; 35
	const HS_VIRIDIAN_GYM_KIYO ; v0.7: the dojo master as post-League leader; slot funded by HS_DAISY_SITTING_COPY (ids between here and there shifted, new-game basis)
	const HS_OLD_AMBER                     ; 37
	const HS_CERULEAN_BULBASAUR            ; 38
	const HS_CERULEAN_CAVE_1F_ITEM_2       ; 39
	const HS_CERULEAN_CAVE_1F_ITEM_3       ; 3A
	const HS_CERULEAN_CAVE_1F_ITEM_4       ; 3B
	const HS_POKEMON_TOWER_2F_RIVAL        ; 3C
	const HS_POKEMON_TOWER_3F_ITEM         ; 3D
	; v0.7 ground-item redesign: the old ITEM_1 (the Elixir ball) was removed —
	; it became a hidden item at the same coords, and its slot funds Rock
	; Tunnel 1F's rope. The two survivors renumber; nothing referenced them.
	const HS_POKEMON_TOWER_4F_ITEM_1       ; 3E (Awakening)
	const HS_POKEMON_TOWER_4F_ITEM_2       ; 3F (Calcium)
	const HS_POKEMON_TOWER_5F_ITEM         ; 40
	const HS_POKEMON_TOWER_6F_ITEM_1       ; 41
	const HS_POKEMON_TOWER_6F_ITEM_2       ; 42
	const HS_POKEMON_TOWER_7F_JESSIE       ; 43
	const HS_POKEMON_TOWER_7F_JAMES        ; 44
	const HS_POKEMON_TOWER_7F_MR_FUJI      ; 45
	const HS_MR_FUJIS_HOUSE_MR_FUJI        ; 46
	const HS_CELADON_MANSION_PORYGON_GIFT    ; 47
	const HS_GAME_CORNER_ROCKET            ; 48
	const HS_WARDENS_HOUSE_ITEM            ; 49
	const HS_POKEMON_MANSION_1F_ITEM_1     ; 4A
	const HS_POKEMON_MANSION_1F_ITEM_2     ; 4B
	const HS_INDIGO_PLATEAU_LOBBY_POST_GAME_CLERK
	const HS_FIGHTING_DOJO_GIFT_1          ; 4D
	const HS_FIGHTING_DOJO_GIFT_2          ; 4E
	const HS_FIGHTING_DOJO_MASTER ; v0.7: hidden post-League (he holds Viridian now); slot funded by HS_DAISY_WALKING_COPY (ids between here and there shifted, new-game basis)
	const HS_SILPH_CO_1F_RECEPTIONIST      ; 50
	const HS_VOLTORB_1                     ; 51
	const HS_VOLTORB_2                     ; 52
	const HS_VOLTORB_3                     ; 53
	const HS_ELECTRODE_1                   ; 54
	const HS_VOLTORB_4                     ; 55
	const HS_VOLTORB_5                     ; 56
	const HS_ELECTRODE_2                   ; 57
	const HS_VOLTORB_6                     ; 58
	const HS_ZAPDOS                        ; 59
	const HS_POWER_PLANT_ITEM_1            ; 5A
	const HS_POWER_PLANT_ITEM_2            ; 5B
	const HS_POWER_PLANT_ITEM_3            ; 5C
	const HS_POWER_PLANT_ITEM_4            ; 5D
	const HS_POWER_PLANT_CRAIG ; Craig self-insert at Zapdos's tile (post-Zapdos + post-League)
	const HS_MOLTRES                       ; 5F
	const HS_VICTORY_ROAD_2F_ITEM_1        ; 60
	const HS_VICTORY_ROAD_2F_ITEM_2        ; 61
	const HS_VICTORY_ROAD_2F_ITEM_3        ; 62
	const HS_VICTORY_ROAD_2F_ITEM_4        ; 63
	const HS_VICTORY_ROAD_2F_BOULDER       ; 64
	const HS_VICTORY_ROAD_2F_SMITH ; Smith self-insert at Moltres's tile (post-Moltres + post-League)
	const HS_BILL_POKEMON                  ; 66
	const HS_BILL_1                        ; 67
	const HS_BILL_2                        ; 68
	const HS_VIRIDIAN_FOREST_ITEM_1        ; 69
	const HS_VIRIDIAN_FOREST_ITEM_2        ; 6A
	const HS_VIRIDIAN_FOREST_ITEM_3        ; 6B
	const HS_MT_MOON_1F_ITEM_1             ; 6C
	const HS_MT_MOON_1F_ITEM_2             ; 6D
	const HS_MT_MOON_1F_ITEM_3             ; 6E
	const HS_MT_MOON_1F_ITEM_4             ; 6F
	const HS_MT_MOON_1F_ITEM_5             ; 70
	const HS_MT_MOON_1F_ITEM_6             ; 71
	const HS_MT_MOON_B2F_JESSIE            ; 72
	const HS_MT_MOON_B2F_JAMES             ; 73
	const HS_MT_MOON_B2F_FOSSIL_1          ; 74
	const HS_MT_MOON_B2F_FOSSIL_2          ; 75
	const HS_MT_MOON_B2F_ITEM_1            ; 76
	const HS_MT_MOON_B2F_ITEM_2            ; 77
	const HS_SS_ANNE_2F_RIVAL              ; 78
	const HS_SS_ANNE_1F_ROOMS_ITEM         ; 79
	const HS_SS_ANNE_2F_ROOMS_ITEM_1       ; 7A
	const HS_SS_ANNE_2F_ROOMS_ITEM_2       ; 7B
	const HS_SS_ANNE_B1F_ROOMS_ITEM_1      ; 7C
	const HS_SS_ANNE_B1F_ROOMS_ITEM_2      ; 7D
	const HS_SS_ANNE_B1F_ROOMS_ITEM_3      ; 7E
	const HS_VICTORY_ROAD_3F_ITEM_1        ; 7F
	const HS_VICTORY_ROAD_3F_ITEM_2        ; 80
	const HS_VICTORY_ROAD_3F_BOULDER       ; 81
	const HS_ROCKET_HIDEOUT_B1F_ITEM_1     ; 82
	const HS_ROCKET_HIDEOUT_B1F_ITEM_2     ; 83
	const HS_ROCKET_HIDEOUT_B2F_ITEM_1     ; 84
	const HS_ROCKET_HIDEOUT_B2F_ITEM_2     ; 85
	const HS_ROCKET_HIDEOUT_B2F_ITEM_3     ; 86
	const HS_ROCKET_HIDEOUT_B2F_ITEM_4     ; 87
	const HS_ROCKET_HIDEOUT_B3F_ITEM_1     ; 88
	const HS_ROCKET_HIDEOUT_B3F_ITEM_2     ; 89
	const HS_ROCKET_HIDEOUT_B4F_GIOVANNI   ; 8A
	const HS_ROCKET_HIDEOUT_B4F_JAMES      ; 8B
	const HS_ROCKET_HIDEOUT_B4F_JESSIE     ; 8C
	const HS_ROCKET_HIDEOUT_B4F_ITEM_1     ; 8D
	const HS_ROCKET_HIDEOUT_B4F_ITEM_2     ; 8E
	const HS_ROCKET_HIDEOUT_B4F_ITEM_3     ; 8F
	const HS_ROCKET_HIDEOUT_B4F_ITEM_4     ; 90
	const HS_ROCKET_HIDEOUT_B4F_ITEM_5     ; 91
	const HS_SILPH_CO_2F_2                 ; 92
	const HS_SILPH_CO_2F_3                 ; 93
	const HS_SILPH_CO_2F_4                 ; 94
	const HS_SILPH_CO_2F_5                 ; 95
	const HS_SILPH_CO_3F_1                 ; 96
	const HS_SILPH_CO_3F_2                 ; 97
	const HS_SILPH_CO_3F_ITEM              ; 98
	const HS_SILPH_CO_4F_1                 ; 99
	const HS_SILPH_CO_4F_2                 ; 9A
	const HS_SILPH_CO_4F_3                 ; 9B
	const HS_SILPH_CO_4F_ITEM_1            ; 9C
	const HS_SILPH_CO_4F_ITEM_2            ; 9D
	const HS_SILPH_CO_4F_ITEM_3            ; 9E
	const HS_SILPH_CO_5F_1                 ; 9F
	const HS_SILPH_CO_5F_2                 ; A0
	const HS_SILPH_CO_5F_3                 ; A1
	const HS_SILPH_CO_5F_4                 ; A2
	const HS_SILPH_CO_5F_ITEM_1            ; A3
	const HS_SILPH_CO_5F_ITEM_2            ; A4
	const HS_SILPH_CO_5F_ITEM_3            ; A5
	const HS_SILPH_CO_6F_1                 ; A6
	const HS_SILPH_CO_6F_2                 ; A7
	const HS_SILPH_CO_6F_3                 ; A8
	const HS_SILPH_CO_6F_ITEM_1            ; A9
	const HS_SILPH_CO_6F_ITEM_2            ; AA
	const HS_SILPH_CO_7F_1                 ; AB
	const HS_SILPH_CO_7F_2                 ; AC
	const HS_SILPH_CO_7F_3                 ; AD
	const HS_SILPH_CO_7F_4                 ; AE
	const HS_SILPH_CO_7F_RIVAL             ; AF
	const HS_SILPH_CO_7F_ITEM_1            ; B0
	const HS_SILPH_CO_7F_ITEM_2            ; B1
	; Frees one HS slot to compensate for new TM ball items added elsewhere.
	const HS_SILPH_CO_8F_1                 ; B2
	const HS_SILPH_CO_8F_2                 ; B3
	const HS_SILPH_CO_8F_3                 ; B4
	const HS_SILPH_CO_9F_1                 ; B5
	const HS_SILPH_CO_9F_2                 ; B6
	const HS_SILPH_CO_9F_3                 ; B7
	const HS_SILPH_CO_10F_1                ; B8
	const HS_SILPH_CO_10F_2                ; B9
	const HS_SILPH_CO_10F_ITEM_1           ; BA
	const HS_SILPH_CO_10F_ITEM_2           ; BB
	const HS_SILPH_CO_11F_1                ; BC
	const HS_SILPH_CO_11F_JAMES            ; BD
	const HS_SILPH_CO_11F_2                ; BE
	const HS_SILPH_CO_11F_JESSIE           ; BF
	; Frees one HS slot to compensate for new TM ball items added elsewhere.
	const HS_POKEMON_MANSION_2F_ITEM       ; C0
	const HS_POKEMON_MANSION_2F_OAK
	const HS_POKEMON_MANSION_3F_ITEM_1     ; C2
	const HS_POKEMON_MANSION_3F_ITEM_2     ; C3
	const HS_POKEMON_MANSION_B1F_MEW
	const HS_POKEMON_MANSION_B1F_ITEM_1    ; C5
	const HS_POKEMON_MANSION_B1F_ITEM_2    ; C6
	const HS_POKEMON_MANSION_B1F_ITEM_3    ; C7
	const HS_POKEMON_MANSION_B1F_ITEM_4    ; C8
	const HS_POKEMON_MANSION_B1F_ITEM_5    ; C9
	const HS_SAFARI_ZONE_EAST_ITEM_1       ; CA
	const HS_SAFARI_ZONE_EAST_ITEM_2       ; CB
	const HS_SAFARI_ZONE_EAST_ITEM_3       ; CC
	const HS_SAFARI_ZONE_EAST_ITEM_4       ; CD
	const HS_SAFARI_ZONE_NORTH_ITEM_1      ; CE
	const HS_SAFARI_ZONE_NORTH_ITEM_2      ; CF
	const HS_SAFARI_ZONE_WEST_ITEM_1       ; D0
	const HS_SAFARI_ZONE_WEST_ITEM_2       ; D1
	const HS_SAFARI_ZONE_WEST_ITEM_3       ; D2
	const HS_SAFARI_ZONE_WEST_ITEM_4       ; D3
	const HS_SAFARI_ZONE_CENTER_ITEM       ; D4
	const HS_CERULEAN_CAVE_2F_ITEM_1       ; D5
	const HS_CERULEAN_CAVE_2F_ITEM_3       ; D6
	const HS_CERULEAN_CAVE_2F_ITEM_4       ; D7
	const HS_MEWTWO                        ; D8
	; v0.7 ground-item redesign: the old ITEM_1 (the Ultra Ball at 26,1) was
	; removed — hidden item at the same coords now; its slot funds Seafoam
	; 1F's rope. The three survivors renumber; nothing referenced them.
	const HS_CERULEAN_CAVE_B1F_ITEM_1      ; (rope ball at 2,13)
	const HS_CERULEAN_CAVE_B1F_ITEM_2      ; (Max Revive)
	const HS_CERULEAN_CAVE_B1F_ITEM_3      ; (Max Elixir)
	const HS_CERULEAN_CAVE_B1F_FORTE       ; Forte/DREIGON self-insert at MEWTWO's tile (post-MEWTWO + post-League; repeatable)
	const HS_VICTORY_ROAD_1F_ITEM_1        ; DD
	const HS_VICTORY_ROAD_1F_ITEM_2        ; DE
	const HS_LANCESROOM_LANCE
	const HS_LANCESROOM_LANCE_REMATCH
	const HS_CHAMPIONS_ROOM_OAK            ; E1
	const HS_CHAMPIONS_ROOM_JOLTEON
	const HS_CHAMPIONS_ROOM_FLAREON
	const HS_CHAMPIONS_ROOM_VAPOREON
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_1  ; E5
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_2  ; E6
	const HS_SEAFOAM_ISLANDS_1F_ITEM_1 ; v0.7 rope ball (slot from the CC B1F Ultra Ball conversion)
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; E8
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; E9
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_1 ; EA
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_2 ; EB
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_1 ; EC
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_2 ; ED
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_3 ; EE
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_4 ; EF
	const HS_SEAFOAM_ISLANDS_B3F_ITEM_1 ; TM41 Light Screen ball
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_1 ; F1
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_2 ; F2
	; v0.7 fix: these two were swapped relative to the SeafoamIslandsB4FHS
	; data rows (ARTICUNO row comes BEFORE the TM ball row there). Inert
	; today -- nothing references either constant -- but the first future
	; `ld a, HS_ARTICUNO / predef HideObject` would have deleted the TM42
	; ball and left Articuno standing. ROM byte-identical.
	const HS_ARTICUNO                      ; F3
	const HS_SEAFOAM_ISLANDS_B4F_ITEM_1 ; F4, TM42 Ice Beam ball
	const HS_SEAFOAM_ISLANDS_B4F_WEEBRA ; Weebra self-insert at Articuno's tile (post-Articuno + post-League)
; v0.7: HS_TOWN_MAP_COPY, HS_DAISY_SITTING_COPY and HS_DAISY_WALKING_COPY were
; here. All three named a vanilla DUPLICATE of the Blue's House block that
; nothing points at (MapHSPointers sends BLUES_HOUSE to the real one). The
; first spare paid for HS_PALLET_TOWN_MOM at index 01; the last two paid for
; HS_VIRIDIAN_GYM_KIYO and HS_FIGHTING_DOJO_MASTER (the dojo-master takeover).
; The array is still exactly 256, and there are NO spare slots left.
	const HS_LORELEISROOM_LORELEI
	const HS_LORELEISROOM_LORELEI_REMATCH
	const HS_BRUNOSROOM_BRUNO
	const HS_BRUNOSROOM_BRUNO_REMATCH
	const HS_AGATHASROOM_AGATHA
	const HS_AGATHASROOM_AGATHA_REMATCH
	const HS_ROCK_TUNNEL_1F_ITEM_1 ; v0.7 rope ball (slot from the Tower 4F Elixir conversion)
	const HS_ROCK_TUNNEL_B1F_ITEM_1 ; TM13 Iron Tail ball
; v0.7 (2026-08-30): the SAFFRON aides' exit, funded by deleting the two
; CERULEAN CAVE ULTRA BALL rows (the balls became hidden items). They sit
; at the END as their own contiguous SaffronPokecenterHS block - an
; in-place rename at the old positions emptied both caves' missable lists
; (the loader stops at the first foreign-map row; see PalletTownHS in the
; data file). Everything after the two deleted rows renumbered by -1/-2;
; all references are symbolic, and the save format already changed this
; session, so nothing persisted the old indices.
	const HS_SAFFRON_POKECENTER_AIDE_1
	const HS_SAFFRON_POKECENTER_AIDE_2
DEF NUM_HS_OBJECTS EQU const_value
