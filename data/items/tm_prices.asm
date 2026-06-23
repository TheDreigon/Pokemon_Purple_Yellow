TechnicalMachinePrices:
; Each entry is a 3-byte packed BCD price (0..999999).
; Reading routine: engine/items/tm_prices.asm:GetMachinePrice.
; Migrated from nybble_array (max 15000) to 3-byte BCD (max 999999)
; in the v0.5 TM rework to support prices up to 30000.
; v0.7 TM rework (Forte spec): all 55 prices updated to match new TM
; mapping + new sale-site spec (TMs_HMs_before-after.txt DEPOIS).
	db $00, $50, $00 ; TM01 ROCK_THROW    =   5000  ; Celadon 2F
	db $00, $50, $00 ; TM02 QUICK_ATTACK  =   5000  ; Celadon 2F
	db $00, $75, $00 ; TM03 BIND          =   7500  ; Celadon 2F
	db $00, $50, $00 ; TM04 FAINT_ATTACK  =   5000  ; Celadon 2F
	db $01, $50, $00 ; TM05 BULLDOZE      =  15000  ; Cinnabar
	db $01, $00, $00 ; TM06 WATER_PULSE   =  10000  ; Celadon 2F
	db $01, $25, $00 ; TM07 ICY_PULSE     =  12500  ; Celadon 2F
	db $01, $00, $00 ; TM08 SEISMIC_TOSS  =  10000  ; Celadon 2F
	db $00, $75, $00 ; TM09 RAGE          =   7500  ; Celadon 2F
	db $00, $75, $00 ; TM10 BODY_SLAM     =   7500  ; Celadon 2F
	db $01, $25, $00 ; TM11 FLAME_BURST   =  12500  ; Celadon 2F
	db $01, $25, $00 ; TM12 SHOCK_WAVE    =  12500  ; Celadon 2F (also Surge gift)
	db $00, $75, $00 ; TM13 IRON_TAIL     =   7500  ; Celadon 2F
	db $01, $00, $00 ; TM14 NIGHT_SHADE   =  10000  ; Celadon 2F
	db $01, $00, $00 ; TM15 CONFUSE_RAY   =  10000  ; Fuchsia
	db $01, $50, $00 ; TM16 IGNITE        =  15000  ; Fuchsia
	db $01, $50, $00 ; TM17 THUNDER_WAVE  =  15000  ; Fuchsia
	db $01, $50, $00 ; TM18 BULK_UP       =  15000  ; Celadon 5F
	db $00, $00, $00 ; TM19 MIMIC         =      0  ; Game Corner (1000 coins)
	db $00, $00, $00 ; TM20 MIRROR_MOVE   =      0  ; Game Corner (500 coins)
	db $00, $00, $00 ; TM21 SUBSTITUTE    =      0  ; Game Corner (1000 coins)
	db $00, $00, $00 ; TM22 METRONOME     =      0  ; Game Corner (1500 coins) + Cinnabar Lab gift
	db $02, $00, $00 ; TM23 GIGA_DRAIN    =  20000  ; Indigo Pre-E4
	db $01, $00, $00 ; TM24 DAZZLE_GLEAM  =  10000  ; Cinnabar
	db $01, $75, $00 ; TM25 AGILITY       =  17500  ; Celadon 5F
	db $01, $00, $00 ; TM26 POISON_BITE   =  10000  ; Cinnabar
	db $01, $00, $00 ; TM27 IRON_HEAD     =  10000  ; Cinnabar
	db $02, $50, $00 ; TM28 FAKE_TEARS    =  25000  ; Celadon 5F
	db $01, $25, $00 ; TM29 AERIAL_ACE    =  12500  ; Celadon 2F
	db $02, $00, $00 ; TM30 CHARM         =  20000  ; Celadon 5F
	db $02, $00, $00 ; TM31 HURRICANE     =  20000  ; Indigo Pre-E4
	db $02, $00, $00 ; TM32 MEGAHORN      =  20000  ; Indigo Pre-E4
	db $00, $75, $00 ; TM33 DRAGON_CLAW   =   7500  ; Celadon 2F
	db $02, $00, $00 ; TM34 TOXIC         =  20000  ; Fuchsia (also Koga gift)
	db $01, $25, $00 ; TM35 EXTRASENSORY  =  12500  ; Celadon 2F
	db $02, $00, $00 ; TM36 INTIMIDATE    =  20000  ; Celadon 5F
	db $01, $50, $00 ; TM37 SCARY_FACE    =  15000  ; Celadon 5F
	db $01, $50, $00 ; TM38 LEECH_LIFE    =  15000  ; Cinnabar
	db $01, $50, $00 ; TM39 TAKE_DOWN     =  15000  ; Cinnabar
	db $02, $50, $00 ; TM40 PSYCHIC_M     =  25000  ; Indigo Pre-E4
	db $01, $00, $00 ; TM41 LIGHT_SCREEN  =  10000  ; Celadon 5F
	db $02, $50, $00 ; TM42 ICE_BEAM      =  25000  ; Indigo Pre-E4
	db $02, $25, $00 ; TM43 DARK_PULSE    =  22500  ; Indigo Pre-E4
	db $02, $25, $00 ; TM44 SHADOW_BALL   =  22500  ; Indigo Pre-E4
	db $02, $50, $00 ; TM45 FLAMETHROWER  =  25000  ; Indigo Pre-E4
	db $01, $00, $00 ; TM46 REFLECT       =  10000  ; Celadon 5F
	db $02, $50, $00 ; TM47 THUNDERBOLT   =  25000  ; Indigo Pre-E4
	db $02, $00, $00 ; TM48 SWORDS_DANCE  =  20000  ; Celadon 5F
	db $01, $00, $00 ; TM49 CALM_MIND     =  10000  ; Celadon 5F
	db $02, $50, $00 ; TM50 EARTHQUAKE    =  25000  ; Indigo Pre-E4
	db $02, $50, $00 ; TM51 ROCK_SLIDE    =  25000  ; Indigo Pre-E4
	db $02, $00, $00 ; TM52 PETAL_DANCE   =  20000  ; Indigo Pre-E4
	db $02, $25, $00 ; TM53 DOUBLE_EDGE   =  22500  ; Indigo Pos-E4
	db $02, $50, $00 ; TM54 THRASH        =  25000  ; Indigo Pos-E4
	db $02, $75, $00 ; TM55 OUTRAGE       =  27500  ; Indigo Pos-E4
