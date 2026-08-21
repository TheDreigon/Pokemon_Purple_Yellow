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
	const HS_CERULEAN_CAVE_1F_ITEM_1       ; 39
	const HS_CERULEAN_CAVE_1F_ITEM_2       ; 3A
	const HS_CERULEAN_CAVE_1F_ITEM_3       ; 3B
	const HS_CERULEAN_CAVE_1F_ITEM_4       ; 3C
	const HS_POKEMON_TOWER_2F_RIVAL        ; 3D
	const HS_POKEMON_TOWER_3F_ITEM         ; 3E
	; v0.7 ground-item redesign: the old ITEM_1 (the Elixir ball) was removed —
	; it became a hidden item at the same coords, and its slot funds Rock
	; Tunnel 1F's rope. The two survivors renumber; nothing referenced them.
	const HS_POKEMON_TOWER_4F_ITEM_1       ; 3F (Awakening)
	const HS_POKEMON_TOWER_4F_ITEM_2       ; 40 (Calcium)
	const HS_POKEMON_TOWER_5F_ITEM         ; 41
	const HS_POKEMON_TOWER_6F_ITEM_1       ; 42
	const HS_POKEMON_TOWER_6F_ITEM_2       ; 43
	const HS_POKEMON_TOWER_7F_JESSIE       ; 44
	const HS_POKEMON_TOWER_7F_JAMES        ; 45
	const HS_POKEMON_TOWER_7F_MR_FUJI      ; 46
	const HS_MR_FUJIS_HOUSE_MR_FUJI        ; 47
	const HS_CELADON_MANSION_PORYGON_GIFT    ; 48
	const HS_GAME_CORNER_ROCKET            ; 49
	const HS_WARDENS_HOUSE_ITEM            ; 4A
	const HS_POKEMON_MANSION_1F_ITEM_1     ; 4B
	const HS_POKEMON_MANSION_1F_ITEM_2     ; 4C
	const HS_INDIGO_PLATEAU_LOBBY_POST_GAME_CLERK
	const HS_FIGHTING_DOJO_GIFT_1          ; 4E
	const HS_FIGHTING_DOJO_GIFT_2          ; 4F
	const HS_FIGHTING_DOJO_MASTER ; v0.7: hidden post-League (he holds Viridian now); slot funded by HS_DAISY_WALKING_COPY (ids between here and there shifted, new-game basis)
	const HS_SILPH_CO_1F_RECEPTIONIST      ; 51
	const HS_VOLTORB_1                     ; 52
	const HS_VOLTORB_2                     ; 53
	const HS_VOLTORB_3                     ; 54
	const HS_ELECTRODE_1                   ; 55
	const HS_VOLTORB_4                     ; 56
	const HS_VOLTORB_5                     ; 57
	const HS_ELECTRODE_2                   ; 58
	const HS_VOLTORB_6                     ; 59
	const HS_ZAPDOS                        ; 5A
	const HS_POWER_PLANT_ITEM_1            ; 5B
	const HS_POWER_PLANT_ITEM_2            ; 5C
	const HS_POWER_PLANT_ITEM_3            ; 5D
	const HS_POWER_PLANT_ITEM_4            ; 5E
	const HS_POWER_PLANT_CRAIG ; Craig self-insert at Zapdos's tile (post-Zapdos + post-League)
	const HS_MOLTRES                       ; 60
	const HS_VICTORY_ROAD_2F_ITEM_1        ; 61
	const HS_VICTORY_ROAD_2F_ITEM_2        ; 62
	const HS_VICTORY_ROAD_2F_ITEM_3        ; 63
	const HS_VICTORY_ROAD_2F_ITEM_4        ; 64
	const HS_VICTORY_ROAD_2F_BOULDER       ; 65
	const HS_VICTORY_ROAD_2F_SMITH ; Smith self-insert at Moltres's tile (post-Moltres + post-League)
	const HS_BILL_POKEMON                  ; 67
	const HS_BILL_1                        ; 68
	const HS_BILL_2                        ; 69
	const HS_VIRIDIAN_FOREST_ITEM_1        ; 6A
	const HS_VIRIDIAN_FOREST_ITEM_2        ; 6B
	const HS_VIRIDIAN_FOREST_ITEM_3        ; 6C
	const HS_MT_MOON_1F_ITEM_1             ; 6D
	const HS_MT_MOON_1F_ITEM_2             ; 6E
	const HS_MT_MOON_1F_ITEM_3             ; 6F
	const HS_MT_MOON_1F_ITEM_4             ; 70
	const HS_MT_MOON_1F_ITEM_5             ; 71
	const HS_MT_MOON_1F_ITEM_6             ; 72
	const HS_MT_MOON_B2F_JESSIE            ; 73
	const HS_MT_MOON_B2F_JAMES             ; 74
	const HS_MT_MOON_B2F_FOSSIL_1          ; 75
	const HS_MT_MOON_B2F_FOSSIL_2          ; 76
	const HS_MT_MOON_B2F_ITEM_1            ; 77
	const HS_MT_MOON_B2F_ITEM_2            ; 78
	const HS_SS_ANNE_2F_RIVAL              ; 79
	const HS_SS_ANNE_1F_ROOMS_ITEM         ; 7A
	const HS_SS_ANNE_2F_ROOMS_ITEM_1       ; 7B
	const HS_SS_ANNE_2F_ROOMS_ITEM_2       ; 7C
	const HS_SS_ANNE_B1F_ROOMS_ITEM_1      ; 7D
	const HS_SS_ANNE_B1F_ROOMS_ITEM_2      ; 7E
	const HS_SS_ANNE_B1F_ROOMS_ITEM_3      ; 7F
	const HS_VICTORY_ROAD_3F_ITEM_1        ; 80
	const HS_VICTORY_ROAD_3F_ITEM_2        ; 81
	const HS_VICTORY_ROAD_3F_BOULDER       ; 82
	const HS_ROCKET_HIDEOUT_B1F_ITEM_1     ; 83
	const HS_ROCKET_HIDEOUT_B1F_ITEM_2     ; 84
	const HS_ROCKET_HIDEOUT_B2F_ITEM_1     ; 85
	const HS_ROCKET_HIDEOUT_B2F_ITEM_2     ; 86
	const HS_ROCKET_HIDEOUT_B2F_ITEM_3     ; 87
	const HS_ROCKET_HIDEOUT_B2F_ITEM_4     ; 88
	const HS_ROCKET_HIDEOUT_B3F_ITEM_1     ; 89
	const HS_ROCKET_HIDEOUT_B3F_ITEM_2     ; 8A
	const HS_ROCKET_HIDEOUT_B4F_GIOVANNI   ; 8B
	const HS_ROCKET_HIDEOUT_B4F_JAMES      ; 8C
	const HS_ROCKET_HIDEOUT_B4F_JESSIE     ; 8D
	const HS_ROCKET_HIDEOUT_B4F_ITEM_1     ; 8E
	const HS_ROCKET_HIDEOUT_B4F_ITEM_2     ; 8F
	const HS_ROCKET_HIDEOUT_B4F_ITEM_3     ; 90
	const HS_ROCKET_HIDEOUT_B4F_ITEM_4     ; 91
	const HS_ROCKET_HIDEOUT_B4F_ITEM_5     ; 92
	const HS_SILPH_CO_2F_2                 ; 93
	const HS_SILPH_CO_2F_3                 ; 94
	const HS_SILPH_CO_2F_4                 ; 95
	const HS_SILPH_CO_2F_5                 ; 96
	const HS_SILPH_CO_3F_1                 ; 97
	const HS_SILPH_CO_3F_2                 ; 98
	const HS_SILPH_CO_3F_ITEM              ; 99
	const HS_SILPH_CO_4F_1                 ; 9A
	const HS_SILPH_CO_4F_2                 ; 9B
	const HS_SILPH_CO_4F_3                 ; 9C
	const HS_SILPH_CO_4F_ITEM_1            ; 9D
	const HS_SILPH_CO_4F_ITEM_2            ; 9E
	const HS_SILPH_CO_4F_ITEM_3            ; 9F
	const HS_SILPH_CO_5F_1                 ; A0
	const HS_SILPH_CO_5F_2                 ; A1
	const HS_SILPH_CO_5F_3                 ; A2
	const HS_SILPH_CO_5F_4                 ; A3
	const HS_SILPH_CO_5F_ITEM_1            ; A4
	const HS_SILPH_CO_5F_ITEM_2            ; A5
	const HS_SILPH_CO_5F_ITEM_3            ; A6
	const HS_SILPH_CO_6F_1                 ; A7
	const HS_SILPH_CO_6F_2                 ; A8
	const HS_SILPH_CO_6F_3                 ; A9
	const HS_SILPH_CO_6F_ITEM_1            ; AA
	const HS_SILPH_CO_6F_ITEM_2            ; AB
	const HS_SILPH_CO_7F_1                 ; AC
	const HS_SILPH_CO_7F_2                 ; AD
	const HS_SILPH_CO_7F_3                 ; AE
	const HS_SILPH_CO_7F_4                 ; AF
	const HS_SILPH_CO_7F_RIVAL             ; B0
	const HS_SILPH_CO_7F_ITEM_1            ; B1
	const HS_SILPH_CO_7F_ITEM_2            ; B2
	; Frees one HS slot to compensate for new TM ball items added elsewhere.
	const HS_SILPH_CO_8F_1                 ; B3
	const HS_SILPH_CO_8F_2                 ; B4
	const HS_SILPH_CO_8F_3                 ; B5
	const HS_SILPH_CO_9F_1                 ; B6
	const HS_SILPH_CO_9F_2                 ; B7
	const HS_SILPH_CO_9F_3                 ; B8
	const HS_SILPH_CO_10F_1                ; B9
	const HS_SILPH_CO_10F_2                ; BA
	const HS_SILPH_CO_10F_ITEM_1           ; BB
	const HS_SILPH_CO_10F_ITEM_2           ; BC
	const HS_SILPH_CO_11F_1                ; BD
	const HS_SILPH_CO_11F_JAMES            ; BE
	const HS_SILPH_CO_11F_2                ; BF
	const HS_SILPH_CO_11F_JESSIE           ; C0
	; Frees one HS slot to compensate for new TM ball items added elsewhere.
	const HS_POKEMON_MANSION_2F_ITEM       ; C1
	const HS_POKEMON_MANSION_2F_OAK
	const HS_POKEMON_MANSION_3F_ITEM_1     ; C3
	const HS_POKEMON_MANSION_3F_ITEM_2     ; C4
	const HS_POKEMON_MANSION_B1F_MEW
	const HS_POKEMON_MANSION_B1F_ITEM_1    ; C6
	const HS_POKEMON_MANSION_B1F_ITEM_2    ; C7
	const HS_POKEMON_MANSION_B1F_ITEM_3    ; C8
	const HS_POKEMON_MANSION_B1F_ITEM_4    ; C9
	const HS_POKEMON_MANSION_B1F_ITEM_5    ; CA
	const HS_SAFARI_ZONE_EAST_ITEM_1       ; CB
	const HS_SAFARI_ZONE_EAST_ITEM_2       ; CC
	const HS_SAFARI_ZONE_EAST_ITEM_3       ; CD
	const HS_SAFARI_ZONE_EAST_ITEM_4       ; CE
	const HS_SAFARI_ZONE_NORTH_ITEM_1      ; CF
	const HS_SAFARI_ZONE_NORTH_ITEM_2      ; D0
	const HS_SAFARI_ZONE_WEST_ITEM_1       ; D1
	const HS_SAFARI_ZONE_WEST_ITEM_2       ; D2
	const HS_SAFARI_ZONE_WEST_ITEM_3       ; D3
	const HS_SAFARI_ZONE_WEST_ITEM_4       ; D4
	const HS_SAFARI_ZONE_CENTER_ITEM       ; D5
	const HS_CERULEAN_CAVE_2F_ITEM_1       ; D6
	const HS_CERULEAN_CAVE_2F_ITEM_2       ; D7
	const HS_CERULEAN_CAVE_2F_ITEM_3       ; D8
	const HS_CERULEAN_CAVE_2F_ITEM_4       ; D9
	const HS_MEWTWO                        ; DA
	; v0.7 ground-item redesign: the old ITEM_1 (the Ultra Ball at 26,1) was
	; removed — hidden item at the same coords now; its slot funds Seafoam
	; 1F's rope. The three survivors renumber; nothing referenced them.
	const HS_CERULEAN_CAVE_B1F_ITEM_1      ; (rope ball at 2,13)
	const HS_CERULEAN_CAVE_B1F_ITEM_2      ; (Max Revive)
	const HS_CERULEAN_CAVE_B1F_ITEM_3      ; (Max Elixir)
	const HS_CERULEAN_CAVE_B1F_FORTE       ; Forte/DREIGON self-insert at MEWTWO's tile (post-MEWTWO + post-League; repeatable)
	const HS_VICTORY_ROAD_1F_ITEM_1        ; DF
	const HS_VICTORY_ROAD_1F_ITEM_2        ; E0
	const HS_LANCESROOM_LANCE
	const HS_LANCESROOM_LANCE_REMATCH
	const HS_CHAMPIONS_ROOM_OAK            ; E3
	const HS_CHAMPIONS_ROOM_JOLTEON
	const HS_CHAMPIONS_ROOM_FLAREON
	const HS_CHAMPIONS_ROOM_VAPOREON
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_1  ; E7
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_2  ; E8
	const HS_SEAFOAM_ISLANDS_1F_ITEM_1 ; v0.7 rope ball (slot from the CC B1F Ultra Ball conversion)
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; EA
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; EB
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_1 ; EC
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_2 ; ED
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_1 ; EE
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_2 ; EF
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_3 ; F0
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_4 ; F1
	const HS_SEAFOAM_ISLANDS_B3F_ITEM_1 ; TM41 Light Screen ball
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_1 ; F3
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_2 ; F4
	const HS_SEAFOAM_ISLANDS_B4F_ITEM_1 ; TM42 Ice Beam ball
	const HS_ARTICUNO                      ; F6
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
	const HS_ROCK_TUNNEL_B1F_ITEM_1 ; TM13 Iron Tail ball (appended at list end to avoid renumbering earlier HS ids)
DEF NUM_HS_OBJECTS EQU const_value
