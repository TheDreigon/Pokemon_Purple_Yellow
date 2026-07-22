ItemPrices::
; v0.5 mart rework: prices retuned to fit the badge-tiered global mart
; system. See `Poke Marts - before-after.txt` notepad for the spec.
	table_width 3, ItemPrices
	bcd3 0     ; MASTER_BALL
	bcd3 600 ; bcd3 600   ; ULTRA_BALL
	bcd3 300 ; bcd3 300   ; GREAT_BALL
	bcd3 100 ; bcd3 100   ; POKE_BALL
	bcd3 0     ; TOWN_MAP
	bcd3 0     ; BICYCLE
	bcd3 0     ; SURFBOARD
	bcd3 1000  ; SAFARI_BALL (unchanged; Safari Zone-only)
	bcd3 0     ; POKEDEX
	bcd3 3000  ; MOON_STONE  (was 0; now sold in Celadon 4F shopping)
	bcd3 250   ; ANTIDOTE    (was 100; uniform status-healer floor)
	bcd3 250   ; BURN_HEAL
	bcd3 250   ; ICE_HEAL
	bcd3 250 ; bcd3 250   ; AWAKENING
	bcd3 250 ; bcd3 250   ; PARLYZ_HEAL
	bcd3 3000  ; FULL_RESTORE
	bcd3 2000 ; bcd3 2000  ; MAX_POTION
	bcd3 1500  ; HYPER_POTION (was 1200; slight bump to widen tier gap)
	bcd3 500   ; SUPER_POTION
	bcd3 200   ; POTION
	bcd3 0     ; BOULDERBADGE
	bcd3 0     ; CASCADEBADGE
	bcd3 0     ; THUNDERBADGE
	bcd3 0     ; RAINBOWBADGE
	bcd3 0     ; SOULBADGE
	bcd3 0     ; MARSHBADGE
	bcd3 0     ; VOLCANOBADGE
	bcd3 0     ; EARTHBADGE
	bcd3 1000  ; ESCAPE_ROPE (was 550; intentional bump - "get out of jail" tax)
	bcd3 200 ; bcd3 200   ; REPEL
	bcd3 0     ; OLD_AMBER
	bcd3 3000  ; FIRE_STONE  (was 2100; uniform 3000 across all stones)
	bcd3 3000  ; THUNDER_STONE
	bcd3 3000  ; WATER_STONE
	bcd3 4900  ; HP_UP       (was 9800; vitamins halved to make them mid-game viable)
	bcd3 4900  ; PROTEIN
	bcd3 4900  ; IRON
	bcd3 4900  ; CARBOS
	bcd3 4900  ; CALCIUM
	bcd3 4900  ; RARE_CANDY  (was 4800; rounded to match vitamin tier)
	bcd3 0     ; DOME_FOSSIL
	bcd3 0     ; HELIX_FOSSIL
	bcd3 0     ; SECRET_KEY
	bcd3 0     ; ITEM_2C
	bcd3 0     ; BIKE_VOUCHER
	bcd3 3000 ; bcd3 3000  ; X_ACCURACY
	bcd3 3000  ; LEAF_STONE  (was 2100; matches other stones)
	bcd3 0     ; CARD_KEY
	bcd3 10000 ; NUGGET      (player sells; sale value = 1/2 price)
	bcd3 19600 ; bcd3 19600 ; PP_MAX
	bcd3 1000  ; POKE_DOLL
	bcd3 500 ; bcd3 500   ; FULL_HEAL
	bcd3 1500  ; REVIVE
	bcd3 4000  ; MAX_REVIVE
	bcd3 2500 ; bcd3 2500  ; GUARD_SPEC
	bcd3 400 ; bcd3 400   ; SUPER_REPEL
	bcd3 600 ; bcd3 600   ; MAX_REPEL
	bcd3 2000 ; bcd3 2000  ; DIRE_HIT
	bcd3 10    ; COIN
	bcd3 250   ; FRESH_WATER (was 200; tweaked so $/HP no longer trivially beats SUPER_POTION)
	bcd3 300   ; SODA_POP
	bcd3 350   ; LEMONADE
	bcd3 0     ; S_S_TICKET
	bcd3 0     ; GOLD_TEETH
	bcd3 1000  ; X_ATTACK    (was 4000; X-items made cheap so they're actually used)
	bcd3 1000  ; X_DEFEND
	bcd3 1500  ; X_SPEED
	bcd3 1500  ; X_SPECIAL
	bcd3 0     ; COIN_CASE
	bcd3 0     ; OAKS_PARCEL
	bcd3 0     ; ITEMFINDER
	bcd3 0     ; SILPH_SCOPE
	bcd3 0     ; POKE_FLUTE
	bcd3 0     ; LIFT_KEY
	bcd3 0     ; EXP_ALL
	bcd3 0     ; OLD_ROD
	bcd3 0     ; GOOD_ROD
	bcd3 0     ; SUPER_ROD
	bcd3 9800  ; PP_UP
	bcd3 1200  ; ETHER       (was 0; now sold post-E4 at Indigo + Celadon 2F)
	bcd3 2000  ; MAX_ETHER   (was 0; now sold post-E4-rematch at Indigo + Celadon 2F)
	bcd3 3200  ; ELIXIR      (was 0; now sold post-E4 at Indigo + Celadon 2F)
	bcd3 4500  ; MAX_ELIXIR  (was 0; now sold post-E4-rematch at Indigo + Celadon 2F)
	assert_table_length NUM_ITEMS
	bcd3 0     ; FLOOR_B2F
	bcd3 0     ; FLOOR_B1F
	bcd3 0     ; FLOOR_1F
	bcd3 0     ; FLOOR_2F
	bcd3 0     ; FLOOR_3F
	bcd3 0     ; FLOOR_4F
	bcd3 0     ; FLOOR_5F
	bcd3 0     ; FLOOR_6F
	bcd3 0     ; FLOOR_7F
	bcd3 0     ; FLOOR_8F
	bcd3 0     ; FLOOR_9F
	bcd3 0     ; FLOOR_10F
	bcd3 0     ; FLOOR_11F
	bcd3 0     ; FLOOR_B4F
	assert_table_length NUM_ITEMS + NUM_FLOORS
