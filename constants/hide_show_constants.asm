DEF HIDE EQU $11
DEF SHOW EQU $15

; MissableObjects indexes (see data/maps/hide_show_data.asm)
; this is a list of the sprites that can be enabled/disabled during the game

	const_def
	const HS_PALLET_TOWN_OAK               ; 00
	const HS_PALLET_TOWN_MOM               ; 01
	const HS_LYING_OLD_MAN                 ; 01
	const HS_OLD_MAN_1                     ; 02
	const HS_OLD_MAN_2                     ; 03
	const HS_MUSEUM_GUY                    ; 04
	const HS_GYM_GUY                       ; 05
	const HS_CERULEAN_RIVAL                ; 06
	const HS_CERULEAN_ROCKET               ; 07
	const HS_CERULEAN_GUARD_1              ; 08
	const HS_CERULEAN_CAVE_GUY             ; 09
	const HS_CERULEAN_GUARD_2              ; 0A
	const HS_SAFFRON_CITY_1                ; 0B
	const HS_SAFFRON_CITY_2                ; 0C
	const HS_SAFFRON_CITY_3                ; 0D
	const HS_SAFFRON_CITY_4                ; 0E
	const HS_SAFFRON_CITY_5                ; 0F
	const HS_SAFFRON_CITY_6                ; 10
	const HS_SAFFRON_CITY_7                ; 11
	const HS_SAFFRON_CITY_8                ; 12
	const HS_SAFFRON_CITY_9                ; 13
	const HS_SAFFRON_CITY_A                ; 14
	const HS_SAFFRON_CITY_B                ; 15
	const HS_SAFFRON_CITY_C                ; 16
	const HS_SAFFRON_CITY_D                ; 17
	const HS_SAFFRON_CITY_E                ; 18
	const HS_ROUTE_1_OAK				   ; 19
	const HS_ROUTE_2_ITEM_1                ; 1A
	const HS_ROUTE_2_ITEM_2                ; 1B
	const HS_ROUTE_4_ITEM                  ; 1C
	const HS_ROUTE_9_ITEM                  ; 1D
	const HS_ROUTE_11_CARBOS               ; 1E
	const HS_ROUTE_12_SNORLAX              ; 1F
	const HS_ROUTE_12_ITEM_1               ; 20
	const HS_ROUTE_12_ITEM_2               ; 21
	const HS_ROUTE_15_ITEM                 ; 22
	const HS_ROUTE_16_SNORLAX              ; 23
	const HS_ROUTE_22_RIVAL_1              ; 24
	const HS_ROUTE_22_RIVAL_2              ; 25
	const HS_NUGGET_BRIDGE_GUY             ; 26
	const HS_ROUTE_24_ITEM                 ; 27
	const HS_ROUTE_25_ITEM                 ; 28
	const HS_REDS_HOUSE_2F_MR_MIME         ; 29
	const HS_DAISY_SITTING                 ; 2A
	const HS_DAISY_WALKING                 ; 2B
	const HS_TOWN_MAP                      ; 2C
	const HS_OAKS_LAB_RIVAL                ; 2D
	const HS_STARTER_BALL_1                ; 2E
	const HS_OAKS_LAB_OAK_1                ; 2F
	const HS_POKEDEX_1                     ; 30
	const HS_POKEDEX_2                     ; 31
	const HS_OAKS_LAB_OAK_2                ; 32
	const HS_VIRIDIAN_GYM_GIOVANNI         ; 33
	const HS_VIRIDIAN_GYM_ITEM             ; 34
	const HS_OLD_AMBER                     ; 35
	const HS_CERULEAN_BULBASAUR            ; 36
	const HS_CERULEAN_CAVE_1F_ITEM_1       ; 37
	const HS_CERULEAN_CAVE_1F_ITEM_2       ; 38
	const HS_CERULEAN_CAVE_1F_ITEM_3       ; 39
	const HS_CERULEAN_CAVE_1F_ITEM_4       ; 3A
	const HS_POKEMON_TOWER_2F_RIVAL        ; 3B
	const HS_POKEMON_TOWER_3F_ITEM         ; 3C
	; v0.7 ground-item redesign: the old ITEM_1 (the Elixir ball) was removed —
	; it became a hidden item at the same coords, and its slot funds Rock
	; Tunnel 1F's rope. The two survivors renumber; nothing referenced them.
	const HS_POKEMON_TOWER_4F_ITEM_1       ; 3D (Awakening)
	const HS_POKEMON_TOWER_4F_ITEM_2       ; 3E (Calcium)
	const HS_POKEMON_TOWER_5F_ITEM         ; 3F
	const HS_POKEMON_TOWER_6F_ITEM_1       ; 40
	const HS_POKEMON_TOWER_6F_ITEM_2       ; 41
	const HS_POKEMON_TOWER_7F_JESSIE       ; 42
	const HS_POKEMON_TOWER_7F_JAMES        ; 43
	const HS_POKEMON_TOWER_7F_MR_FUJI      ; 44
	const HS_MR_FUJIS_HOUSE_MR_FUJI        ; 45
	const HS_CELADON_MANSION_PORYGON_GIFT    ; 46
	const HS_GAME_CORNER_ROCKET            ; 47
	const HS_WARDENS_HOUSE_ITEM            ; 48
	const HS_POKEMON_MANSION_1F_ITEM_1     ; 49
	const HS_POKEMON_MANSION_1F_ITEM_2     ; 4A
	const HS_INDIGO_PLATEAU_LOBBY_POST_GAME_CLERK
	const HS_FIGHTING_DOJO_GIFT_1          ; 4C
	const HS_FIGHTING_DOJO_GIFT_2          ; 4D
	const HS_SILPH_CO_1F_RECEPTIONIST      ; 4E
	const HS_VOLTORB_1                     ; 4F
	const HS_VOLTORB_2                     ; 50
	const HS_VOLTORB_3                     ; 51
	const HS_ELECTRODE_1                   ; 52
	const HS_VOLTORB_4                     ; 53
	const HS_VOLTORB_5                     ; 54
	const HS_ELECTRODE_2                   ; 55
	const HS_VOLTORB_6                     ; 56
	const HS_ZAPDOS                        ; 57
	const HS_POWER_PLANT_ITEM_1            ; 58
	const HS_POWER_PLANT_ITEM_2            ; 59
	const HS_POWER_PLANT_ITEM_3            ; 5A
	const HS_POWER_PLANT_ITEM_4            ; 5B
	const HS_POWER_PLANT_CRAIG ; Craig self-insert at Zapdos's tile (post-Zapdos + post-League)
	const HS_MOLTRES                       ; 5D
	const HS_VICTORY_ROAD_2F_ITEM_1        ; 5E
	const HS_VICTORY_ROAD_2F_ITEM_2        ; 5F
	const HS_VICTORY_ROAD_2F_ITEM_3        ; 60
	const HS_VICTORY_ROAD_2F_ITEM_4        ; 61
	const HS_VICTORY_ROAD_2F_BOULDER       ; 62
	const HS_VICTORY_ROAD_2F_SMITH ; Smith self-insert at Moltres's tile (post-Moltres + post-League)
	const HS_BILL_POKEMON                  ; 64
	const HS_BILL_1                        ; 65
	const HS_BILL_2                        ; 66
	const HS_VIRIDIAN_FOREST_ITEM_1        ; 67
	const HS_VIRIDIAN_FOREST_ITEM_2        ; 68
	const HS_VIRIDIAN_FOREST_ITEM_3        ; 69
	const HS_MT_MOON_1F_ITEM_1             ; 6A
	const HS_MT_MOON_1F_ITEM_2             ; 6B
	const HS_MT_MOON_1F_ITEM_3             ; 6C
	const HS_MT_MOON_1F_ITEM_4             ; 6D
	const HS_MT_MOON_1F_ITEM_5             ; 6E
	const HS_MT_MOON_1F_ITEM_6             ; 6F
	const HS_MT_MOON_B2F_JESSIE            ; 70
	const HS_MT_MOON_B2F_JAMES             ; 71
	const HS_MT_MOON_B2F_FOSSIL_1          ; 72
	const HS_MT_MOON_B2F_FOSSIL_2          ; 73
	const HS_MT_MOON_B2F_ITEM_1            ; 74
	const HS_MT_MOON_B2F_ITEM_2            ; 75
	const HS_SS_ANNE_2F_RIVAL              ; 76
	const HS_SS_ANNE_1F_ROOMS_ITEM         ; 77
	const HS_SS_ANNE_2F_ROOMS_ITEM_1       ; 78
	const HS_SS_ANNE_2F_ROOMS_ITEM_2       ; 79
	const HS_SS_ANNE_B1F_ROOMS_ITEM_1      ; 7A
	const HS_SS_ANNE_B1F_ROOMS_ITEM_2      ; 7B
	const HS_SS_ANNE_B1F_ROOMS_ITEM_3      ; 7C
	const HS_VICTORY_ROAD_3F_ITEM_1        ; 7D
	const HS_VICTORY_ROAD_3F_ITEM_2        ; 7E
	const HS_VICTORY_ROAD_3F_BOULDER       ; 7F
	const HS_ROCKET_HIDEOUT_B1F_ITEM_1     ; 80
	const HS_ROCKET_HIDEOUT_B1F_ITEM_2     ; 81
	const HS_ROCKET_HIDEOUT_B2F_ITEM_1     ; 82
	const HS_ROCKET_HIDEOUT_B2F_ITEM_2     ; 83
	const HS_ROCKET_HIDEOUT_B2F_ITEM_3     ; 84
	const HS_ROCKET_HIDEOUT_B2F_ITEM_4     ; 85
	const HS_ROCKET_HIDEOUT_B3F_ITEM_1     ; 86
	const HS_ROCKET_HIDEOUT_B3F_ITEM_2     ; 87
	const HS_ROCKET_HIDEOUT_B4F_GIOVANNI   ; 88
	const HS_ROCKET_HIDEOUT_B4F_JAMES      ; 89
	const HS_ROCKET_HIDEOUT_B4F_JESSIE     ; 8A
	const HS_ROCKET_HIDEOUT_B4F_ITEM_1     ; 8B
	const HS_ROCKET_HIDEOUT_B4F_ITEM_2     ; 8C
	const HS_ROCKET_HIDEOUT_B4F_ITEM_3     ; 8D
	const HS_ROCKET_HIDEOUT_B4F_ITEM_4     ; 8E
	const HS_ROCKET_HIDEOUT_B4F_ITEM_5     ; 8F
	const HS_SILPH_CO_2F_2                 ; 90
	const HS_SILPH_CO_2F_3                 ; 91
	const HS_SILPH_CO_2F_4                 ; 92
	const HS_SILPH_CO_2F_5                 ; 93
	const HS_SILPH_CO_3F_1                 ; 94
	const HS_SILPH_CO_3F_2                 ; 95
	const HS_SILPH_CO_3F_ITEM              ; 96
	const HS_SILPH_CO_4F_1                 ; 97
	const HS_SILPH_CO_4F_2                 ; 98
	const HS_SILPH_CO_4F_3                 ; 99
	const HS_SILPH_CO_4F_ITEM_1            ; 9A
	const HS_SILPH_CO_4F_ITEM_2            ; 9B
	const HS_SILPH_CO_4F_ITEM_3            ; 9C
	const HS_SILPH_CO_5F_1                 ; 9D
	const HS_SILPH_CO_5F_2                 ; 9E
	const HS_SILPH_CO_5F_3                 ; 9F
	const HS_SILPH_CO_5F_4                 ; A0
	const HS_SILPH_CO_5F_ITEM_1            ; A1
	const HS_SILPH_CO_5F_ITEM_2            ; A2
	const HS_SILPH_CO_5F_ITEM_3            ; A3
	const HS_SILPH_CO_6F_1                 ; A4
	const HS_SILPH_CO_6F_2                 ; A5
	const HS_SILPH_CO_6F_3                 ; A6
	const HS_SILPH_CO_6F_ITEM_1            ; A7
	const HS_SILPH_CO_6F_ITEM_2            ; A8
	const HS_SILPH_CO_7F_1                 ; A9
	const HS_SILPH_CO_7F_2                 ; AA
	const HS_SILPH_CO_7F_3                 ; AB
	const HS_SILPH_CO_7F_4                 ; AC
	const HS_SILPH_CO_7F_RIVAL             ; AD
	const HS_SILPH_CO_7F_ITEM_1            ; AE
	const HS_SILPH_CO_7F_ITEM_2            ; AF
	; Frees one HS slot to compensate for new TM ball items added elsewhere.
	const HS_SILPH_CO_8F_1                 ; B0
	const HS_SILPH_CO_8F_2                 ; B1
	const HS_SILPH_CO_8F_3                 ; B2
	const HS_SILPH_CO_9F_1                 ; B3
	const HS_SILPH_CO_9F_2                 ; B4
	const HS_SILPH_CO_9F_3                 ; B5
	const HS_SILPH_CO_10F_1                ; B6
	const HS_SILPH_CO_10F_2                ; B7
	const HS_SILPH_CO_10F_ITEM_1           ; B8
	const HS_SILPH_CO_10F_ITEM_2           ; B9
	const HS_SILPH_CO_11F_1                ; BA
	const HS_SILPH_CO_11F_JAMES            ; BB
	const HS_SILPH_CO_11F_2                ; BC
	const HS_SILPH_CO_11F_JESSIE           ; BD
	; Frees one HS slot to compensate for new TM ball items added elsewhere.
	const HS_POKEMON_MANSION_2F_ITEM       ; BE
	const HS_POKEMON_MANSION_2F_OAK
	const HS_POKEMON_MANSION_3F_ITEM_1     ; C0
	const HS_POKEMON_MANSION_3F_ITEM_2     ; C1
	const HS_POKEMON_MANSION_B1F_MEW
	const HS_POKEMON_MANSION_B1F_ITEM_1    ; C3
	const HS_POKEMON_MANSION_B1F_ITEM_2    ; C4
	const HS_POKEMON_MANSION_B1F_ITEM_3    ; C5
	const HS_POKEMON_MANSION_B1F_ITEM_4    ; C6
	const HS_POKEMON_MANSION_B1F_ITEM_5    ; C7
	const HS_SAFARI_ZONE_EAST_ITEM_1       ; C8
	const HS_SAFARI_ZONE_EAST_ITEM_2       ; C9
	const HS_SAFARI_ZONE_EAST_ITEM_3       ; CA
	const HS_SAFARI_ZONE_EAST_ITEM_4       ; CB
	const HS_SAFARI_ZONE_NORTH_ITEM_1      ; CC
	const HS_SAFARI_ZONE_NORTH_ITEM_2      ; CD
	const HS_SAFARI_ZONE_WEST_ITEM_1       ; CE
	const HS_SAFARI_ZONE_WEST_ITEM_2       ; CF
	const HS_SAFARI_ZONE_WEST_ITEM_3       ; D0
	const HS_SAFARI_ZONE_WEST_ITEM_4       ; D1
	const HS_SAFARI_ZONE_CENTER_ITEM       ; D2
	const HS_CERULEAN_CAVE_2F_ITEM_1       ; D3
	const HS_CERULEAN_CAVE_2F_ITEM_2       ; D4
	const HS_CERULEAN_CAVE_2F_ITEM_3       ; D5
	const HS_CERULEAN_CAVE_2F_ITEM_4       ; D6
	const HS_MEWTWO                        ; D7
	; v0.7 ground-item redesign: the old ITEM_1 (the Ultra Ball at 26,1) was
	; removed — hidden item at the same coords now; its slot funds Seafoam
	; 1F's rope. The three survivors renumber; nothing referenced them.
	const HS_CERULEAN_CAVE_B1F_ITEM_1      ; (rope ball at 2,13)
	const HS_CERULEAN_CAVE_B1F_ITEM_2      ; (Max Revive)
	const HS_CERULEAN_CAVE_B1F_ITEM_3      ; (Max Elixir)
	const HS_CERULEAN_CAVE_B1F_FORTE       ; Forte/DREIGON self-insert at MEWTWO's tile (post-MEWTWO + post-League; repeatable)
	const HS_VICTORY_ROAD_1F_ITEM_1        ; DC
	const HS_VICTORY_ROAD_1F_ITEM_2        ; DD
	const HS_LANCESROOM_LANCE
	const HS_LANCESROOM_LANCE_REMATCH
	const HS_CHAMPIONS_ROOM_OAK            ; E0
	const HS_CHAMPIONS_ROOM_JOLTEON
	const HS_CHAMPIONS_ROOM_FLAREON
	const HS_CHAMPIONS_ROOM_VAPOREON
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_1  ; E4
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_2  ; E5
	const HS_SEAFOAM_ISLANDS_1F_ITEM_1 ; v0.7 rope ball (slot from the CC B1F Ultra Ball conversion)
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; E7
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; E8
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_1 ; E9
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_2 ; EA
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_1 ; EB
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_2 ; EC
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_3 ; ED
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_4 ; EE
	const HS_SEAFOAM_ISLANDS_B3F_ITEM_1 ; TM41 Light Screen ball
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_1 ; F0
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_2 ; F1
	const HS_SEAFOAM_ISLANDS_B4F_ITEM_1 ; TM42 Ice Beam ball
	const HS_ARTICUNO                      ; F3
	const HS_SEAFOAM_ISLANDS_B4F_WEEBRA ; Weebra self-insert at Articuno's tile (post-Articuno + post-League)
	const HS_DAISY_SITTING_COPY            ; F5
	const HS_DAISY_WALKING_COPY            ; F6
; v0.7: HS_TOWN_MAP_COPY was here. These three name a vanilla DUPLICATE of the
; Blue's House block that nothing points at (MapHSPointers sends BLUES_HOUSE to
; the real one), so the third row was the array's only spare -- and it paid for
; HS_PALLET_TOWN_MOM at index 01. The array is still exactly 256.
	const HS_LORELEISROOM_LORELEI
	const HS_LORELEISROOM_LORELEI_REMATCH
	const HS_BRUNOSROOM_BRUNO
	const HS_BRUNOSROOM_BRUNO_REMATCH
	const HS_AGATHASROOM_AGATHA
	const HS_AGATHASROOM_AGATHA_REMATCH
	const HS_ROCK_TUNNEL_1F_ITEM_1 ; v0.7 rope ball (slot from the Tower 4F Elixir conversion)
	const HS_ROCK_TUNNEL_B1F_ITEM_1 ; TM13 Iron Tail ball (appended at list end to avoid renumbering earlier HS ids)
DEF NUM_HS_OBJECTS EQU const_value
