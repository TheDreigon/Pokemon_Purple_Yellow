; Evos+moves data structure:
; - Evolution methods:
;    * db EVOLVE_LEVEL, level, species
;    * db EVOLVE_ITEM, used item, min level (1), species
;    * db EVOLVE_TRADE, min level (1), species
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * db level, move
; - db 0 ; no more level-up moves

EvosMovesPointerTable:
	table_width 2, EvosMovesPointerTable
	dw BulbasaurEvosMoves      ; 1
	dw IvysaurEvosMoves        ; 2
	dw VenusaurEvosMoves       ; 3
	dw CharmanderEvosMoves     ; 4
	dw CharmeleonEvosMoves     ; 5
	dw CharizardEvosMoves      ; 6
	dw SquirtleEvosMoves       ; 7
	dw WartortleEvosMoves      ; 8
	dw BlastoiseEvosMoves      ; 9
	dw CaterpieEvosMoves       ; 10
	dw MetapodEvosMoves        ; 11
	dw ButterfreeEvosMoves     ; 12
	dw WeedleEvosMoves         ; 13
	dw KakunaEvosMoves         ; 14
	dw BeedrillEvosMoves       ; 15
	dw PidgeyEvosMoves         ; 16
	dw PidgeottoEvosMoves      ; 17
	dw PidgeotEvosMoves        ; 18
	dw RattataEvosMoves        ; 19
	dw RaticateEvosMoves       ; 20
	dw SpearowEvosMoves        ; 21
	dw FearowEvosMoves         ; 22
	dw EkansEvosMoves          ; 23
	dw ArbokEvosMoves          ; 24
	dw PikachuEvosMoves        ; 25
	dw RaichuEvosMoves         ; 26
	dw SandshrewEvosMoves      ; 27
	dw SandslashEvosMoves      ; 28
	dw NidoranFEvosMoves       ; 29
	dw NidorinaEvosMoves       ; 30
	dw NidoqueenEvosMoves      ; 31
	dw NidoranMEvosMoves       ; 32
	dw NidorinoEvosMoves       ; 33
	dw NidokingEvosMoves       ; 34
	dw ClefairyEvosMoves       ; 35
	dw ClefableEvosMoves       ; 36
	dw VulpixEvosMoves         ; 37
	dw NinetalesEvosMoves      ; 38
	dw JigglypuffEvosMoves     ; 39
	dw WigglytuffEvosMoves     ; 40
	dw ZubatEvosMoves          ; 41
	dw GolbatEvosMoves         ; 42
	dw OddishEvosMoves         ; 43
	dw GloomEvosMoves          ; 44
	dw VileplumeEvosMoves      ; 45
	dw ParasEvosMoves          ; 46
	dw ParasectEvosMoves       ; 47
	dw VenonatEvosMoves        ; 48
	dw VenomothEvosMoves       ; 49
	dw DiglettEvosMoves        ; 50
	dw DugtrioEvosMoves        ; 51
	dw MeowthEvosMoves         ; 52
	dw PersianEvosMoves        ; 53
	dw PsyduckEvosMoves        ; 54
	dw GolduckEvosMoves        ; 55
	dw MankeyEvosMoves         ; 56
	dw PrimeapeEvosMoves       ; 57
	dw GrowlitheEvosMoves      ; 58
	dw ArcanineEvosMoves       ; 59
	dw PoliwagEvosMoves        ; 60
	dw PoliwhirlEvosMoves      ; 61
	dw PoliwrathEvosMoves      ; 62
	dw AbraEvosMoves           ; 63
	dw KadabraEvosMoves        ; 64
	dw AlakazamEvosMoves       ; 65
	dw MachopEvosMoves         ; 66
	dw MachokeEvosMoves        ; 67
	dw MachampEvosMoves        ; 68
	dw BellsproutEvosMoves     ; 69
	dw WeepinbellEvosMoves     ; 70
	dw VictreebelEvosMoves     ; 71
	dw TentacoolEvosMoves      ; 72
	dw TentacruelEvosMoves     ; 73
	dw GeodudeEvosMoves        ; 74
	dw GravelerEvosMoves       ; 75
	dw GolemEvosMoves          ; 76
	dw PonytaEvosMoves         ; 77
	dw RapidashEvosMoves       ; 78
	dw SlowpokeEvosMoves       ; 79
	dw SlowbroEvosMoves        ; 80
	dw MagnemiteEvosMoves      ; 81
	dw MagnetonEvosMoves       ; 82
	dw FarfetchdEvosMoves      ; 83
	dw DoduoEvosMoves          ; 84
	dw DodrioEvosMoves         ; 85
	dw SeelEvosMoves           ; 86
	dw DewgongEvosMoves        ; 87
	dw GrimerEvosMoves         ; 88
	dw MukEvosMoves            ; 89
	dw ShellderEvosMoves       ; 90
	dw CloysterEvosMoves       ; 91
	dw GastlyEvosMoves         ; 92
	dw HaunterEvosMoves        ; 93
	dw GengarEvosMoves         ; 94
	dw OnixEvosMoves           ; 95
	dw DrowzeeEvosMoves        ; 96
	dw HypnoEvosMoves          ; 97
	dw KrabbyEvosMoves         ; 98
	dw KinglerEvosMoves        ; 99
	dw VoltorbEvosMoves        ; 100
	dw ElectrodeEvosMoves      ; 101
	dw ExeggcuteEvosMoves      ; 102
	dw ExeggutorEvosMoves      ; 103
	dw CuboneEvosMoves         ; 104
	dw MarowakEvosMoves        ; 105
	dw HitmonleeEvosMoves      ; 106
	dw HitmonchanEvosMoves     ; 107
	dw LickitungEvosMoves      ; 108
	dw KoffingEvosMoves        ; 109
	dw WeezingEvosMoves        ; 110
	dw RhyhornEvosMoves        ; 111
	dw RhydonEvosMoves         ; 112
	dw ChanseyEvosMoves        ; 113
	dw TangelaEvosMoves        ; 114
	dw KangaskhanEvosMoves     ; 115
	dw HorseaEvosMoves         ; 116
	dw SeadraEvosMoves         ; 117
	dw GoldeenEvosMoves        ; 118
	dw SeakingEvosMoves        ; 119
	dw StaryuEvosMoves         ; 120
	dw StarmieEvosMoves        ; 121
	dw MrMimeEvosMoves         ; 122
	dw ScytherEvosMoves        ; 123
	dw JynxEvosMoves           ; 124
	dw ElectabuzzEvosMoves     ; 125
	dw MagmarEvosMoves         ; 126
	dw PinsirEvosMoves         ; 127
	dw TaurosEvosMoves         ; 128
	dw MagikarpEvosMoves       ; 129
	dw GyaradosEvosMoves       ; 130
	dw LaprasEvosMoves         ; 131
	dw DittoEvosMoves          ; 132
	dw EeveeEvosMoves          ; 133
	dw VaporeonEvosMoves       ; 134
	dw JolteonEvosMoves        ; 135
	dw FlareonEvosMoves        ; 136
	dw PorygonEvosMoves        ; 137
	dw OmanyteEvosMoves        ; 138
	dw OmastarEvosMoves        ; 139
	dw KabutoEvosMoves         ; 140
	dw KabutopsEvosMoves       ; 141
	dw AerodactylEvosMoves     ; 142
	dw SnorlaxEvosMoves        ; 143
	dw ArticunoEvosMoves       ; 144
	dw ZapdosEvosMoves         ; 145
	dw MoltresEvosMoves        ; 146
	dw DratiniEvosMoves        ; 147
	dw DragonairEvosMoves      ; 148
	dw DragoniteEvosMoves      ; 149
	dw MewtwoEvosMoves         ; 150
	dw MewEvosMoves            ; 151
	dw FossilKabutopsEvosMoves
	dw FossilAerodactylEvosMoves
	dw MonGhostEvosMoves
	assert_table_length NUM_POKEMON_INDEXES

RhydonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, TAIL_WHIP
	db 10, FURY_ATTACK
	db 14, GROUND_STOMP
	db 19, ROCK_THROW
	db 24, BODY_SLAM
	db 30, ROCK_SLIDE
	db 36, TAKE_DOWN
	db 42, EARTHQUAKE
	db 50, HORN_DRILL
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 13, BITE
	db 18, ROAR
	db 24, MEGA_PUNCH
	db 28, DIZZY_PUNCH
	db 34, DIZZY_PUNCH
	db 40, BODY_SLAM
	db 46, DOUBLE_EDGE
	db 0

NidoranMEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, NIDORINO
	db 0
; Learnset
	db 6, POISON_STING
	db 8, HORN_ATTACK
	db 12, DOUBLE_KICK
	db 23, FOCUS_ENERGY
	db 30, FURY_ATTACK
	db 38, HORN_DRILL
	db 0

ClefairyEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
	db 13, DOUBLESLAP
	db 19, MINIMIZE
	db 26, DEFENSE_CURL
	db 30, METRONOME
	db 32, SING
	db 35, BODY_SLAM
	db 43, LIGHT_SCREEN
	db 0

SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
	db 7, LEER
	db 10, FURY_ATTACK
	db 14, FOCUS_ENERGY
	db 18, SWIFT
	db 21, MIRROR_MOVE
	db 24, DRILL_PECK
	db 28, WHIRLWIND
	db 30, SHARPEN
	db 40, AGILITY
	db 0

VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db 10, QUICK_ATTACK
	db 14, SONICBOOM
	db 18, THUNDERSHOCK
	db 22, SELFDESTRUCT
	db 26, BIDE
	db 30, LIGHT_SCREEN
	db 35, THUNDERBOLT
	db 42, EXPLOSION
	db 50, THUNDER
	db 0

NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, POISON_STING
	db 8, HORN_ATTACK
	db 12, DOUBLE_KICK
	db 25, THRASH
	db 27, FOCUS_ENERGY
	db 32, SLUDGE
	db 36, FURY_ATTACK
	db 40, EARTHQUAKE
	db 46, HORN_DRILL
	db 0
	
SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, BUBBLE
	db 10, DISABLE
	db 15, CONFUSION
	db 20, BUBBLEBEAM
	db 25, HEADBUTT
	db 30, AMNESIA
	db 31, BARRIER
	db 35, RECOVER
	db 40, PSYCHIC_M
	db 45, TOXIC
	db 0

IvysaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, VENUSAUR
	db 0
; Learnset
	db 7, LEECH_SEED
	db 9, VINE_WHIP
	db 16, ACID
	db 22, POISONPOWDER
	db 25, SLEEP_POWDER
	db 29, RAZOR_LEAF
	db 38, GROWTH
	db 42, BODY_SLAM
	db 50, SOLARBEAM
	db 0

ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, POISONPOWDER
	db 13, LEECH_SEED
	db 19, CONFUSION
	db 20, MEGA_DRAIN
	db 25, REFLECT
	db 28, GROUND_STOMP
	db 32, STUN_SPORE
	db 40, EGG_BOMB
	db 45, PSYCHIC_M
	db 48, SLEEP_POWDER
	db 0

LickitungEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, GROUND_STOMP
	db 15, DISABLE
	db 19, HEADBUTT
	db 23, DEFENSE_CURL
	db 32, BODY_SLAM
	db 39, SCREECH
	db 44, WRAP
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
	db 10, POISONPOWDER
	db 13, LEECH_SEED
	db 19, CONFUSION
	db 20, MEGA_DRAIN
	db 25, REFLECT
	db 32, STUN_SPORE
	db 40, EGG_BOMB
	db 45, PSYCHIC_M
	db 48, SLEEP_POWDER
	db 0

GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, MUK
	db 0
; Learnset
	db 10, HARDEN
	db 16, ACID
	db 19, POISON_GAS
	db 24, ACID_ARMOR
	db 27, MINIMIZE
	db 33, SLUDGE
	db 37, BODY_SLAM
	db 42, TOXIC
	db 45, SCREECH
	db 0

GengarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, SMOG
	db 15, PSYWAVE
	db 36, NIGHT_SHADE
	db 55, HYPNOSIS
	db 55, DREAM_EATER
	db 0

NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, NIDORINA
	db 0
; Learnset
 	db 6, POISON_STING
	db 8, BITE
	db 12, DOUBLE_KICK
	db 23, TAIL_WHIP
	db 30, HEADBUTT
	db 38, FURY_SWIPES
	db 0

NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
	db 2, TAIL_WHIP
	db 6, POISON_STING
	db 8, HEADBUTT
	db 12, DOUBLE_KICK
	db 25, BODY_SLAM
	db 32, SLUDGE
	db 40, EARTHQUAKE
	db 0

CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, MAROWAK
	db 0
; Learnset
	db 5, LEER
	db 9, TACKLE
	db 12, TAIL_WHIP
	db 16, BONE_CLUB
	db 20, HEADBUTT
	db 25, FOCUS_ENERGY
	db 31, BONEMERANG
	db 36, RAGE
	db 42, THRASH
	db 0

RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, RHYDON
	db 0
; Learnset
	db 8, TAIL_WHIP
	db 10, FURY_ATTACK
	db 14, GROUND_STOMP
	db 19, ROCK_THROW
	db 24, BODY_SLAM
	db 30, ROCK_SLIDE
	db 36, TAKE_DOWN
	db 42, EARTHQUAKE
	db 50, HORN_DRILL
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
	db 19, ICY_MIST
	db 23, AURORA_BEAM
	db 25, BODY_SLAM
	db 30, CONFUSE_RAY
	db 34, WATERFALL
	db 38, ICE_BEAM
	db 46, SING
	db 51, HYDRO_PUMP
	db 55, BLIZZARD
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, EMBER
	db 23, ROAR
	db 30, TAKE_DOWN
	db 45, FLAMETHROWER
	db 46, AGILITY
	db 0

MewEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, TRANSFORM
	db 15, CONFUSION
	db 20, MEGA_PUNCH
	db 25, PSYBEAM
	db 30, METRONOME
	db 40, PSYCHIC_M
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, BITE
	db 22, GUST
	db 25, WATERFALL
	db 28, DRAGON_RAGE
	db 32, LEER
	db 35, THRASH
	db 41, HYDRO_PUMP
	db 48, DRAGON_SLAM
	db 52, HYPER_BEAM
	db 0

ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
	db 10, WATER_GUN
	db 14, SUPERSONIC
	db 17, LEER
	db 20, AURORA_BEAM
	db 25, BUBBLEBEAM
	db 35, ICE_BEAM
	db 43, CLAMP
	db 50, BLIZZARD
	db 55, EXPLOSION
	db 0

TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
	db 7, SUPERSONIC
	db 13, WATER_GUN
	db 18, ACID
	db 23, BUBBLEBEAM
	db 27, CONSTRICT
	db 35, BARRIER
	db 40, SCREECH
	db 43, SLUDGE
	db 47, WRAP
	db 50, HYDRO_PUMP
	db 0

GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, HAUNTER
	db 0
; Learnset
	db 10, SMOG
	db 15, PSYWAVE
	db 23, POISON_GAS
	db 36, NIGHT_SHADE
	db 55, HYPNOSIS
	db 55, DREAM_EATER
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, LEER
	db 10, FOCUS_ENERGY
	db 15, CUT
	db 20, WING_ATTACK
	db 25, SLASH
	db 30, DOUBLE_TEAM
	db 35, RAZOR_WIND
	db 40, TAKE_DOWN
	db 45, SWORDS_DANCE
	db 50, GUILLOTINE
	db 0

StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, STARMIE
	db 0
; Learnset
	db 5, HARDEN
	db 10, SWIFT
	db 15, BUBBLEBEAM
	db 20, RECOVER
	db 25, MINIMIZE
	db 30, GROWTH
	db 35, PSYBEAM
	db 40, LIGHT_SCREEN
	db 45, PSYCHIC_M
	db 50, HYDRO_PUMP
	db 0

BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, BUBBLE
	db 10, WATER_GUN
	db 15, BITE
	db 21, BUBBLEBEAM
	db 27, BODY_SLAM
	db 31, WITHDRAW
	db 33, WATERFALL
	db 42, SKULL_BASH
	db 45, ICE_BEAM
	db 52, HYDRO_PUMP
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, CONSTRICT
	db 10, PECK
	db 15, HORN_ATTACK
	db 20, DEFENSE_CURL
	db 25, SEISMIC_TOSS
	db 30, COUNTER
	db 35, DIG
	db 40, SUBMISSION
	db 45, SWORDS_DANCE
	db 50, GUILLOTINE
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, TACKLE
	db 10, CONSTRICT
	db 15, WRAP
	db 20, ABSORB
	db 25, GROWTH
	db 30, STUN_SPORE
	db 35, BODY_SLAM
	db 40, RECOVER
	db 45, MEGA_DRAIN
	db 50, DRAGON_SLAM
	db 0

GrowlitheEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
	db 18, EMBER
	db 23, ROAR
	db 30, TAKE_DOWN
	db 35, FLAMETHROWER
	db 36, AGILITY
	db 0

OnixEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, ROCK_THROW
	db 19, DIG
	db 25, RAGE
	db 29, HARDEN
	db 31, DRAGON_SLAM
	db 37, ROCK_SLIDE
	db 43, EARTHQUAKE
	db 48, BIND
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 10, FURY_ATTACK
	db 14, FOCUS_ENERGY
	db 18, SWIFT
	db 20, MIRROR_MOVE
	db 24, DRILL_PECK
	db 28, WHIRLWIND
	db 30, SHARPEN
	db 40, AGILITY
	db 0

PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, PIDGEOTTO
	db 0
; Learnset
	db 5, SAND_ATTACK
	db 12, QUICK_ATTACK
	db 19, WING_ATTACK
	db 21, WHIRLWIND
	db 29, TAKE_DOWN
	db 34, AGILITY
	db 49, MIRROR_MOVE
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, SLOWBRO
	db 0
; Learnset
	db 5, BUBBLE
	db 10, DISABLE
	db 15, CONFUSION
	db 20, BUBBLEBEAM
	db 25, HEADBUTT
	db 30, AMNESIA
	db 35, RECOVER
	db 40, PSYCHIC_M
	db 0

KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, ALAKAZAM
	db 0
; Learnset
	db 16, CONFUSION
	db 20, DISABLE
	db 27, PSYBEAM
	db 31, RECOVER
	db 38, PSYCHIC_M
	db 42, REFLECT
	db 0

GravelerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, GOLEM
	db 0
; Learnset
	db 6, DEFENSE_CURL
	db 12, ROCK_THROW
	db 21, DIG
	db 26, HARDEN
	db 31, SELFDESTRUCT
	db 40, ROCK_SLIDE
	db 45, EARTHQUAKE
	db 48, EXPLOSION
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, DOUBLESLAP
	db 24, SING
	db 30, GROWL
	db 38, MINIMIZE
	db 44, DEFENSE_CURL
	db 48, LIGHT_SCREEN
	db 50, MEGA_PUNCH
	db 54, DOUBLE_EDGE
	db 0

MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, MACHAMP
	db 0
; Learnset
	db 5, LEER
	db 7, FOCUS_ENERGY
	db 19, SEISMIC_TOSS
	db 28, SUBMISSION
	db 33, BODY_SLAM
	db 37, COUNTER
	db 41, KARATE_CHOP
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, CONFUSION
	db 23, LIGHT_SCREEN
	db 23, REFLECT
	db 27, DOUBLESLAP
	db 31, PSYBEAM
	db 39, MEDITATE
	db 43, PSYCHIC_M
	db 47, SUBSTITUTE
	db 50, BARRIER
	db 0

HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, DOUBLE_KICK
	db 26, MEGA_KICK
	db 28, FOCUS_ENERGY
	db 30, MEDITATE
	db 31, ROLLING_KICK
	db 36, GROUND_STOMP
	db 40, JUMP_KICK
	db 42, COUNTER
	db 46, HI_JUMP_KICK
	db 50, AGILITY
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, COMET_PUNCH
	db 26, MEGA_PUNCH
	db 28, DEFENSE_CURL
	db 30, MEDITATE
	db 31, DIZZY_PUNCH
	db 34, THUNDERPUNCH
	db 36, FIRE_PUNCH
	db 48, ICE_PUNCH
	db 42, COUNTER
	db 46, SUBMISSION
	db 50, AGILITY
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9,  POISON_STING
	db 15, BITE
	db 18, ACID
	db 22, SUBSTITUTE
	db 25, GLARE
	db 30, SCREECH
	db 35, SLUDGE
	db 38, WRAP
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, STUN_SPORE
	db 8, ABSORB
	db 10, LEECH_LIFE
	db 13, POISONPOWDER
	db 24, SPORE
	db 27, MEGA_DRAIN
	db 30, SLASH
	db 36, GROWTH
	db 0

PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, GOLDUCK
	db 0
; Learnset
	db 10, DISABLE
	db 15, CONFUSION
	db 17, BUBBLEBEAM
	db 23, SCREECH
	db 40, FURY_SWIPES
	db 42, PSYCHIC_M
	db 45, AMNESIA
	db 50, HYDRO_PUMP
	db 0

DrowzeeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HYPNO
	db 0
; Learnset
	db 12, DISABLE
	db 17, CONFUSION
	db 24, HEADBUTT
	db 29, POISON_GAS
	db 32, PSYCHIC_M
	db 37, MEDITATE
	db 40, HYPNOSIS
	db 45, DREAM_EATER
	db 0

GolemEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, DEFENSE_CURL
	db 12, ROCK_THROW
	db 21, DIG
	db 26, HARDEN
	db 31, SELFDESTRUCT
	db 40, ROCK_SLIDE
	db 45, EARTHQUAKE
	db 48, EXPLOSION
	db 0

MagmarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, SMOG
	db 15, LEER
	db 20, CONFUSE_RAY
	db 31, FIRE_PUNCH
	db 40, SMOKESCREEN
	db 43, FLAMETHROWER
	db 54, FIRE_BLAST
	db 0

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, THUNDERSHOCK
	db 20, THUNDER_WAVE
	db 25, SCREECH
	db 31, THUNDERPUNCH
	db 40, LIGHT_SCREEN
	db 43, THUNDERBOLT
	db 54, THUNDER
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, THUNDERSHOCK
	db 11, SUPERSONIC
	db 16, SONICBOOM
	db 21, THUNDER_WAVE
	db 24, SWIFT
	db 27, REFLECT
	db 33, THUNDERBOLT
	db 37, TRI_ATTACK
	db 43, SCREECH
	db 50, THUNDER
	db 0

KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, WEEZING
	db 0
; Learnset
	db 23, ACID
	db 27, SMOKESCREEN
	db 33, SLUDGE
	db 38, AMNESIA
	db 40, SELFDESTRUCT
	db 45, HAZE
	db 48, EXPLOSION
	db 0

MankeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, PRIMEAPE
	db 0
; Learnset
	db 9, LOW_KICK
	db 15, FURY_SWIPES
	db 21, KARATE_CHOP
	db 27, FOCUS_ENERGY
	db 33, SEISMIC_TOSS
	db 39, THRASH
	db 45, SCREECH
	db 0

SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 34, DEWGONG
	db 0
; Learnset
	db 5, GROWL
	db 13, WATER_GUN
	db 16, AURORA_BEAM
	db 21, REST
	db 25, BUBBLEBEAM
	db 32, TAKE_DOWN
	db 40, ICE_BEAM
	db 50, BLIZZARD
	db 0

DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DUGTRIO
	db 0
; Learnset
	db 15, GROWL
	db 19, DIG
	db 24, SAND_ATTACK
	db 31, SLASH
	db 35, SCREECH
	db 40, EARTHQUAKE
	db 55, FISSURE
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, LEER
	db 12, HEADBUTT
	db 15, GROUND_STOMP
	db 18, HORN_ATTACK
	db 21, TAIL_WHIP
	db 28, SKULL_BASH
	db 35, RAGE
	db 40, TAKE_DOWN
	db 45, THRASH
	db 50, DOUBLE_EDGE
	db 0

FarfetchdEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 9, SHARPEN
	db 13, FURY_ATTACK
	db 18, WING_ATTACK
	db 23, SLASH
	db 28, SWORDS_DANCE
	db 31, DRILL_PECK
	db 39, AGILITY
	db 0

VenonatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, VENOMOTH
	db 0
; Learnset
	db 11, SUPERSONIC
	db 13, LEECH_LIFE
	db 17, CONFUSION
	db 20, POISONPOWDER
	db 29, STUN_SPORE
	db 33, PSYBEAM
	db 36, SLEEP_POWDER
	db 41, PSYCHIC_M
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, DRAGON_RAGE
	db 25, AGILITY
	db 30, DRAGON_SLAM
	db 55, WING_ATTACK
	db 60, HYPER_BEAM
	db 0

DoduoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, DODRIO
	db 0
; Learnset
	db 20, GROWL
	db 24, FURY_ATTACK
	db 30, DRILL_PECK
	db 36, RAGE
	db 39, TRI_ATTACK
	db 45, LOW_KICK
	db 51, AGILITY
	db 0

PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, POLIWHIRL
	db 0
; Learnset
	db 6, ICY_MIST
	db 9, BUBBLE
	db 13, WATER_GUN
	db 22, BUBBLEBEAM
	db 35, BODY_SLAM
	db 43, HYPNOSIS
	db 48, AMNESIA
	db 53, HYDRO_PUMP
	db 0

JynxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, CONFUSION
	db 23, DOUBLESLAP
	db 31, ICE_PUNCH
	db 35, LOVELY_KISS
	db 39, PSYCHIC_M
	db 43, ICE_BEAM
	db 47, BODY_SLAM
	db 54, BLIZZARD
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
	db 35, AGILITY
	db 40, DRILL_PECK
	db 45, FLAMETHROWER
	db 51, FIRE_BLAST
	db 55, SKY_ATTACK
	db 60, FIRE_SPIN
	db 0

ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 35, AGILITY
	db 40, DRILL_PECK
	db 45, ICE_BEAM
	db 51, BLIZZARD
	db 55, SKY_ATTACK
	db 60, ICY_MIST
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 35, AGILITY
	db 40, DRILL_PECK
	db 45, THUNDERBOLT
	db 51, THUNDER
	db 55, SKY_ATTACK
	db 60, LIGHT_SCREEN
	db 0

DittoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MeowthEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, PERSIAN
	db 0
; Learnset
	db 10, FURY_SWIPES
	db 15, BITE
	db 18, PAY_DAY
	db 22, SCREECH
	db 29, TAKE_DOWN
	db 34, SLASH
	db 45, HYPER_BEAM
	db 0

KrabbyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, KINGLER
	db 0
; Learnset
	db 20, VICEGRIP
	db 25, BUBBLEBEAM
	db 29, CUT
	db 30, GROUND_STOMP
	db 35, CRABHAMMER
	db 40, HARDEN
	db 50, GUILLOTINE
	db 0

VulpixEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, NINETALES
	db 0
; Learnset
	db 7, QUICK_ATTACK
	db 13, LEER
	db 16, CONFUSE_RAY
	db 25, REFLECT
	db 32, FLAMETHROWER
	db 37, NIGHT_SHADE
	db 42, FIRE_SPIN
	db 0

NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, QUICK_ATTACK
	db 13, LEER
	db 16, CONFUSE_RAY
	db 25, REFLECT
	db 32, FLAMETHROWER
	db 37, NIGHT_SHADE
	db 42, FIRE_SPIN
	db 0

PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
	db 6, QUICK_ATTACK
	db 8, THUNDER_WAVE
	db 11, TAIL_WHIP
	db 15, DOUBLE_TEAM
	db 20, THUNDERPUNCH
	db 24, HEADBUTT
	db 30, THUNDERBOLT
	db 36, AGILITY
	db 41, THUNDER
	db 50, LIGHT_SCREEN
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, QUICK_ATTACK
	db 8, THUNDER_WAVE
	db 11, TAIL_WHIP
	db 15, DOUBLE_TEAM
	db 20, THUNDERPUNCH
	db 24, HEADBUTT
	db 30, THUNDERBOLT
	db 36, AGILITY
	db 41, THUNDER
	db 50, LIGHT_SCREEN
	db 0

DratiniEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, DRAGONAIR
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, DRAGON_RAGE
	db 25, AGILITY
	db 30, DRAGON_SLAM
	db 60, HYPER_BEAM
	db 0

DragonairEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 55, DRAGONITE
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, DRAGON_RAGE
	db 25, AGILITY
	db 30, DRAGON_SLAM
	db 45, DRAGON_RAGE
	db 60, HYPER_BEAM
	db 0

KabutoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, KABUTOPS
	db 0
; Learnset
	db 11, LEER	
	db 15, WATER_GUN
	db 19, ABSORB
	db 25, ROCK_THROW
	db 35, MEGA_DRAIN
	db 39, SLASH
	db 43, SWORDS_DANCE
	db 46, ROCK_SLIDE
	db 53, HYDRO_PUMP
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 11, LEER	
	db 15, WATER_GUN
	db 19, ABSORB
	db 25, ROCK_THROW
	db 35, MEGA_DRAIN
	db 39, SLASH
	db 43, SWORDS_DANCE
	db 46, ROCK_SLIDE
	db 53, HYDRO_PUMP
	db 0

HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 32, SEADRA
	db 0
; Learnset
	db 10, WATER_GUN
	db 14, SMOKESCREEN
	db 18, LEER
	db 22, BUBBLEBEAM
	db 26, DRAGON_RAGE
	db 30, AURORA_BEAM
	db 33, WATERFALL
	db 37, AGILITY
	db 45, HYDRO_PUMP
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, WATER_GUN
	db 14, SMOKESCREEN
	db 18, LEER
	db 22, BUBBLEBEAM
	db 26, DRAGON_RAGE
	db 30, AURORA_BEAM
	db 33, WATERFALL
	db 37, AGILITY
	db 41, DRAGON_SLAM
	db 45, HYDRO_PUMP
	db 0

SandshrewEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, SANDSLASH
	db 0
; Learnset
	db 5,  POISON_STING
	db 8,  FURY_SWIPES
	db 10, SAND_ATTACK
	db 14, DIG
	db 18, SWIFT
	db 22, SLASH
	db 33, EARTHQUAKE
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5,  POISON_STING
	db 8,  FURY_SWIPES
	db 10, SAND_ATTACK
	db 14, DIG
	db 18, SWIFT
	db 22, SLASH
	db 30, EARTHQUAKE
	db 42, SWORDS_DANCE
	db 0

OmanyteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, OMASTAR
	db 0
; Learnset
	db 15, CONSTRICT
	db 18, BUBBLEBEAM
	db 22, HORN_ATTACK
	db 25, ROCK_THROW
	db 27, SPIKE_CANNON
	db 30, LEER
	db 37, ROCK_SLIDE
	db 46, HYDRO_PUMP
	db 0

OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, CONSTRICT
	db 18, BUBBLEBEAM
	db 22, HORN_ATTACK
	db 25, ROCK_THROW
	db 27, SPIKE_CANNON
	db 30, LEER
	db 37, ROCK_SLIDE
	db 42, CLAMP
	db 46, HYDRO_PUMP
	db 0

JigglypuffEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, WIGGLYTUFF
	db 0
; Learnset
	db 3, POUND
	db 5, DEFENSE_CURL
	db 14, DISABLE
	db 16, DOUBLESLAP
	db 24, REST
	db 30, BODY_SLAM
	db 38, LOVELY_KISS,
	db 43, DOUBLE_EDGE
	db 0

WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
	db 3, POUND
	db 5, DEFENSE_CURL
	db 14, DISABLE
	db 16, DOUBLESLAP
	db 24, REST
	db 30, BODY_SLAM
	db 38, LOVELY_KISS,
	db 43, DOUBLE_EDGE
	db 0

EeveeEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, FLAREON
	db EVOLVE_ITEM, THUNDER_STONE, 1, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, 1, VAPOREON
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 8, SAND_ATTACK
	db 9, BITE
	db 10, QUICK_ATTACK
	db 14, GROWL
	db 17, DOUBLE_KICK
	db 22, HEADBUTT
	db 30, FOCUS_ENERGY
	db 36, JUMP_KICK
	db 42, TAKE_DOWN
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 10, LEER
	db 23, QUICK_ATTACK
	db 26, EMBER
	db 30, DOUBLE_KICK
	db 36, FLAMETHROWER
	db 39, DOUBLE_EDGE
	db 41, GROWTH
	db 47, FIRE_SPIN
	db 52, FIRE_BLAST
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 23, QUICK_ATTACK
	db 26, THUNDERSHOCK
	db 30, DOUBLE_KICK
	db 36, THUNDERBOLT
	db 39, PIN_MISSILE
	db 41, AGILITY
	db 47, THUNDER_WAVE
	db 52, THUNDER
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 16, WATER_GUN
	db 23, QUICK_ATTACK
	db 26, BUBBLEBEAM
	db 30, BITE
	db 36, AURORA_BEAM
	db 39, ICY_MIST
	db 39, HAZE
	db 41, ACID_ARMOR
	db 47, REST
	db 52, HYDRO_PUMP
	db 0

MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, MACHOKE
	db 0
; Learnset
	db 5, LEER
	db 7, FOCUS_ENERGY
	db 19, SEISMIC_TOSS
	db 28, SUBMISSION
	db 33, TAKE_DOWN
	db 37, COUNTER
	db 45, KARATE_CHOP
	db 0

ZubatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, GOLBAT
	db 0
; Learnset
	db 5, SUPERSONIC
	db 7, GUST
	db 12, BITE
	db 19, CONFUSE_RAY
	db 23, WING_ATTACK
	db 27, ACID
	db 36, SLUDGE
	db 46, HAZE
	db 0

EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, ARBOK
	db 0
; Learnset
	db 9,  POISON_STING
	db 12, BITE
	db 15, ACID
	db 22, SUBSTITUTE
	db 25, GLARE
	db 30, SCREECH
	db 35, SLUDGE
	db 47, WRAP
	db 0

ParasEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, PARASECT
	db 0
; Learnset
	db 6, STUN_SPORE
	db 8, ABSORB
	db 10, LEECH_LIFE
	db 13, POISONPOWDER
	db 24, SPORE
	db 27, MEGA_DRAIN
	db 30, SLASH
	db 36, GROWTH
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
	db 6,  ICY_MIST
	db 10, DOUBLESLAP
	db 13, WATER_GUN
	db 22, BUBBLEBEAM
	db 25, KARATE_CHOP
	db 30, ICE_PUNCH
	db 35, BODY_SLAM
	db 43, HYPNOSIS
	db 48, AMNESIA
	db 53, HYDRO_PUMP
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6,  ICY_MIST
	db 10, DOUBLESLAP
	db 13, WATER_GUN
	db 22, BUBBLEBEAM
	db 25, KARATE_CHOP
	db 30, ICE_PUNCH
	db 35, BODY_SLAM
	db 43, HYPNOSIS
	db 48, AMNESIA
	db 53, HYDRO_PUMP
	db 0

WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 7, KAKUNA
	db 0
; Learnset
	db 0

KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 10, BEEDRILL
	db 0
; Learnset
	db 7, HARDEN
	db 0

BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, PIN_MISSILE
	db 12, POISON_STING
	db 14, QUICK_ATTACK
	db 16, FURY_ATTACK
	db 18, RAGE
	db 20, TWINEEDLE
	db 23, HORN_ATTACK
	db 27, ACID
	db 31, SLUDGE
	db 35, AGILITY
	db 40, SWORDS_DANCE
	db 0

DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, GROWL
	db 24, FURY_ATTACK
	db 30, DRILL_PECK
	db 36, RAGE
	db 39, TRI_ATTACK
	db 45, JUMP_KICK
	db 51, AGILITY
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, LOW_KICK
	db 15, FURY_SWIPES
	db 21, KARATE_CHOP
	db 27, FOCUS_ENERGY
	db 33, SEISMIC_TOSS
	db 39, THRASH
	db 45, SCREECH
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, GROWL
	db 19, DIG
	db 24, SAND_ATTACK
	db 31, SLASH
	db 35, SCREECH
	db 40, EARTHQUAKE
	db 55, FISSURE
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
	db 11, SUPERSONIC
	db 13, LEECH_LIFE
	db 17, CONFUSION
	db 20, POISONPOWDER
	db 25, ACID
	db 29, STUN_SPORE
	db 33, PSYBEAM
	db 36, SLEEP_POWDER
	db 41, PSYCHIC_M
	db 46, SLUDGE
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, GROWL
	db 13, WATER_GUN
	db 16, AURORA_BEAM
	db 21, REST
	db 25, BUBBLEBEAM
	db 32, TAKE_DOWN
	db 40, ICE_BEAM
	db 50, BLIZZARD

CaterpieEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 7, METAPOD
	db 0
; Learnset
	db 0

MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 10, BUTTERFREE
	db 7, HARDEN
	db 0
; Learnset
	db 7, HARDEN
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, CONFUSION
	db 12, LEECH_LIFE
	db 13, POISONPOWDER
	db 14, STUN_SPORE
	db 15, SLEEP_POWDER
	db 18, SUPERSONIC
	db 24, GUST
	db 24, PSYBEAM
	db 28, WHIRLWIND
	db 32, PSYCHIC_M
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, LEER
	db 7, FOCUS_ENERGY
	db 19, SEISMIC_TOSS
	db 28, SUBMISSION
	db 33, TAKE_DOWN
	db 37, COUNTER
	db 45, KARATE_CHOP
	db 0

GolduckEvosMoves:
; Evolutions
	db 0
; Learnset
	db 28, TAIL_WHIP
	db 10, DISABLE
	db 15, CONFUSION
	db 17, BUBBLEBEAM
	db 23, SCREECH
	db 40, FURY_SWIPES
	db 42, PSYCHIC_M
	db 45, AMNESIA
	db 50, HYDRO_PUMP
	db 0

HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, DISABLE
	db 17, CONFUSION
	db 24, HEADBUTT
	db 29, POISON_GAS
	db 32, PSYCHIC_M
	db 37, MEDITATE
	db 40, HYPNOSIS
	db 45, DREAM_EATER
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, SUPERSONIC
	db 7, GUST
	db 12, BITE
	db 19, CONFUSE_RAY
	db 22, WING_ATTACK
	db 27, ACID
	db 36, SLUDGE
	db 46, HAZE
	db 0

MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 63, BARRIER
	db 66, PSYCHIC_M
	db 70, RECOVER
	db 75, ICY_MIST
	db 81, AMNESIA
	db 0

SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 29, HEADBUTT
	db 33, HARDEN
	db 36, REST
	db 43, BODY_SLAM
	db 48, DOUBLE_EDGE
	db 56, HYPER_BEAM
	db 0

MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, GYARADOS
	db 0
; Learnset
	db 15, TACKLE
	db 0

MukEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, HARDEN
	db 16, ACID
	db 19, POISON_GAS
	db 24, ACID_ARMOR
	db 27, MINIMIZE
	db 33, SLUDGE
	db 37, BODY_SLAM
	db 42, TOXIC
	db 45, SCREECH
	db 0

KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, VICEGRIP
	db 25, BUBBLEBEAM
	db 28, CUT
	db 30, GROUND_STOMP
	db 35, CRABHAMMER
	db 40, HARDEN
	db 50, GUILLOTINE
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, WATER_GUN
	db 14, SUPERSONIC
	db 17, LEER
	db 20, AURORA_BEAM
	db 25, BUBBLEBEAM
	db 35, CLAMP
	db 40, ICE_BEAM
	db 46, SPIKE_CANNON
	db 50, BLIZZARD
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, QUICK_ATTACK
	db 14, SONICBOOM
	db 18, THUNDERSHOCK
	db 22, SELFDESTRUCT
	db 26, BIDE
	db 30, LIGHT_SCREEN
	db 35, THUNDERBOLT
	db 42, EXPLOSION
	db 50, THUNDER
	db 0

ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, DOUBLESLAP
	db 19, MINIMIZE
	db 26, DEFENSE_CURL
	db 30, METRONOME
	db 35, BODY_SLAM
	db 43, LIGHT_SCREEN
	db 48, SING
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 23, ACID
	db 27, SMOKESCREEN
	db 33, SLUDGE
	db 38, AMNESIA
	db 40, SELFDESTRUCT
	db 45, HAZE
	db 48, EXPLOSION
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, FURY_SWIPES
	db 15, BITE
	db 18, PAY_DAY
	db 22, SCREECH
	db 29, TAKE_DOWN
	db 34, SLASH
	db 50, HYPER_BEAM
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, LEER
	db 9, TACKLE
	db 12, TAIL_WHIP
	db 16, BONE_CLUB
	db 20, HEADBUTT
	db 25, FOCUS_ENERGY
	db 31, BONEMERANG
	db 36, RAGE
	db 42, THRASH
	db 48, EARTHQUAKE
	db 0

HaunterEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, GENGAR
	db 0
; Learnset
	db 10, SMOG
	db 15, PSYWAVE
	db 36, NIGHT_SHADE
	db 55, HYPNOSIS
	db 55, DREAM_EATER
	db 0

AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, KADABRA
	db 0
; Learnset
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, CONFUSION
	db 20, DISABLE
	db 27, PSYBEAM
	db 31, RECOVER
	db 38, PSYCHIC_M
	db 42, REFLECT
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, PIDGEOT
	db 0
; Learnset
	db 5, SAND_ATTACK
	db 12, QUICK_ATTACK
	db 18, WING_ATTACK
	db 21, WHIRLWIND
	db 29, TAKE_DOWN
	db 34, AGILITY
	db 49, MIRROR_MOVE
	db 0

PidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, SAND_ATTACK
	db 12, QUICK_ATTACK
	db 18, WING_ATTACK
	db 21, WHIRLWIND
	db 29, TAKE_DOWN
	db 34, AGILITY
	db 40, SKY_ATTACK
	db 49, MIRROR_MOVE
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, HARDEN
	db 10, SWIFT
	db 15, BUBBLEBEAM
	db 20, RECOVER
	db 25, MINIMIZE
	db 30, GROWTH
	db 35, PSYBEAM
	db 40, LIGHT_SCREEN
	db 45, PSYCHIC_M
	db 50, HYDRO_PUMP
	db 0

BulbasaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, IVYSAUR
	db 0
; Learnset
	db 7, LEECH_SEED
	db 9, VINE_WHIP
	db 22, POISONPOWDER
	db 25, SLEEP_POWDER
	db 29, RAZOR_LEAF
	db 38, GROWTH
	db 42, BODY_SLAM
	db 50, SOLARBEAM
	db 0

VenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEECH_SEED
	db 9, VINE_WHIP
	db 16, ACID
	db 22, POISONPOWDER
	db 25, SLEEP_POWDER
	db 29, RAZOR_LEAF
	db 36, SLUDGE
	db 38, GROWTH
	db 42, BODY_SLAM
	db 50, SOLARBEAM
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, SUPERSONIC
	db 13, WATER_GUN
	db 18, ACID
	db 23, BUBBLEBEAM
	db 27, CONSTRICT
	db 35, BARRIER
	db 40, SCREECH
	db 43, SLUDGE
	db 47, WRAP
	db 50, HYDRO_PUMP
	db 0

GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, SEAKING
	db 0
; Learnset
	db 7, PECK
	db 10, SUPERSONIC
	db 13, WATER_GUN
	db 15, HORN_ATTACK
	db 17, WATERFALL
	db 24, FURY_ATTACK
	db 33, DRILL_PECK
	db 43, HORN_DRILL
	db 48, AGILITY
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, PECK
	db 10, SUPERSONIC
	db 13, WATER_GUN
	db 15, HORN_ATTACK
	db 17, WATERFALL
	db 24, FURY_ATTACK
	db 33, DRILL_PECK
	db 43, HORN_DRILL
	db 48, AGILITY
	db 0

PonytaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, RAPIDASH
	db 0
; Learnset
	db 19, GROUND_STOMP
	db 25, DOUBLE_KICK
	db 30, TAIL_WHIP
	db 33, FLAMETHROWER
	db 35, AGILITY
	db 36, FIRE_SPIN
	db 40, TAKE_DOWN
	db 45, FIRE_BLAST
	db 0

RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 19, GROUND_STOMP
	db 25, DOUBLE_KICK
	db 28, GROWL
	db 30, TAIL_WHIP
	db 33, FLAMETHROWER
	db 35, AGILITY
	db 36, FIRE_SPIN
	db 40, TAKE_DOWN
	db 45, FIRE_BLAST
	db 50, HI_JUMP_KICK
	db 0

RattataEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, RATICATE
	db 0
; Learnset
	db 7, QUICK_ATTACK
	db 9, BITE
	db 14, HYPER_FANG
	db 19, FOCUS_ENERGY
	db 24, DIG
	db 28, SUPER_FANG
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, QUICK_ATTACK
	db 9, BITE
	db 14, HYPER_FANG
	db 19, FOCUS_ENERGY
	db 24, DIG
	db 28, SUPER_FANG
	db 0

NidorinoEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NIDOKING
	db 0
; Learnset
	db 8, HORN_ATTACK
	db 12, DOUBLE_KICK
	db 19, POISON_STING
	db 21, BITE
	db 24, DIG
	db 27, FOCUS_ENERGY
	db 32, SLUDGE
	db 36, FURY_ATTACK
	db 40, EARTHQUAKE
	db 46, HORN_DRILL
	db 0

NidorinaEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NIDOQUEEN
	db 0
; Learnset
	db 6, POISON_STING
	db 8, BITE
	db 12, DOUBLE_KICK
	db 21, HEADBUTT
	db 24, DIG
	db 27, TAIL_WHIP
	db 32, SLUDGE
	db 36, FURY_SWIPES
	db 40, EARTHQUAKE
	db 0

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, GRAVELER
	db 0
	; Learnset
	db 6, DEFENSE_CURL
	db 12, ROCK_THROW
	db 21, DIG
	db 26, HARDEN
	db 31, SELFDESTRUCT
	db 40, ROCK_SLIDE
	db 45, EARTHQUAKE
	db 48, EXPLOSION
	db 0

PorygonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, PSYBEAM
	db 20, RECOVER
	db 24, SHARPEN
	db 28, TRI_ATTACK
	db 32, AGILITY
	db 40, BARRIER
	db 50, HYPER_BEAM
	db 0

AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, BITE	
	db 22, SUPERSONIC
	db 27, ROCK_THROW
	db 32, WING_ATTACK
	db 40, ROCK_SLIDE
	db 43, TAKE_DOWN
	db 50, HYPER_BEAM
	db 0

MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, MAGNETON
	db 0
; Learnset
	db 6, THUNDERSHOCK
	db 11, SUPERSONIC
	db 16, SONICBOOM
	db 21, THUNDER_WAVE
	db 24, SWIFT
	db 27, REFLECT
	db 33, THUNDERBOLT
	db 43, SCREECH
	db 50, THUNDER
	db 0

CharmanderEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, CHARMELEON
	db 0
; Learnset
	db 9, EMBER
	db 13, LEER
	db 17, RAGE
	db 19, FIRE_PUNCH
	db 23, BITE
	db 33, SLASH
	db 38, FLAMETHROWER
	db 46, FIRE_SPIN
	db 50, DRAGON_SLAM
	db 0

SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, WARTORTLE
	db 0
; Learnset
	db 5, BUBBLE
	db 10, WATER_GUN
	db 15, BITE
	db 21, BUBBLEBEAM
	db 27, BODY_SLAM
	db 31, WITHDRAW
	db 33, WATERFALL
	db 42, SKULL_BASH
	db 45, ICE_BEAM
	db 52, HYDRO_PUMP
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
	db 9, EMBER
	db 13, LEER
	db 17, RAGE
	db 19, FIRE_PUNCH
	db 23, BITE
	db 33, SLASH
	db 40, FLAMETHROWER
	db 48, DRAGON_SLAM
	db 56, FIRE_SPIN
	db 0

WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
	db 5, BUBBLE
	db 10, WATER_GUN
	db 15, BITE
	db 21, BUBBLEBEAM
	db 27, BODY_SLAM
	db 31, WITHDRAW
	db 33, WATERFALL
	db 42, SKULL_BASH
	db 45, ICE_BEAM
	db 52, HYDRO_PUMP
	db 0

CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, EMBER
	db 13, LEER
	db 17, RAGE
	db 19, FIRE_PUNCH
	db 23, BITE
	db 33, SLASH
	db 36, WING_ATTACK
	db 42, FLAMETHROWER
	db 48, DRAGON_SLAM
	db 56, FIRE_SPIN
	db 0

FossilKabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FossilAerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MonGhostEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

OddishEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, GLOOM
	db 0
; Learnset
	db 5, POISONPOWDER
	db 8, LEECH_SEED
	db 13, ABSORB
	db 16, STUN_SPORE
	db 21, ACID
	db 25, MEGA_DRAIN
	db 30, SLEEP_POWDER
	db 35, PETAL_DANCE
	db 40, SLUDGE
	db 50, SOLARBEAM
	db 0

GloomEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
	db 5, POISONPOWDER
	db 8, LEECH_SEED
	db 13, ABSORB
	db 16, STUN_SPORE
	db 21, ACID
	db 25, MEGA_DRAIN
	db 30, SLEEP_POWDER
	db 35, PETAL_DANCE
	db 40, SLUDGE
	db 50, SOLARBEAM
	db 0

VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, POISONPOWDER
	db 8, LEECH_SEED
	db 13, ABSORB
	db 16, STUN_SPORE
	db 21, ACID
	db 25, MEGA_DRAIN
	db 30, SLEEP_POWDER
	db 35, PETAL_DANCE
	db 40, SLUDGE
	db 50, SOLARBEAM
	db 0

BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, WEEPINBELL
	db 0
; Learnset
	db 13, POISONPOWDER
	db 21, STUN_SPORE
	db 25, ACID
	db 27, HEADBUTT
	db 29, RAZOR_LEAF
	db 36, SLUDGE
	db 43, WRAP
	db 48, SLEEP_POWDER
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
	db 21, STUN_SPORE
	db 25, ACID
	db 27, HEADBUTT
	db 29, RAZOR_LEAF
	db 36, SLUDGE
	db 43, WRAP
	db 48, SLEEP_POWDER
	db 0

VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, POISONPOWDER
	db 14, VINE_WHIP
	db 21, STUN_SPORE
	db 25, ACID
	db 27, HEADBUTT
	db 29, RAZOR_LEAF
	db 36, SLUDGE
	db 43, WRAP
	db 48, SLEEP_POWDER
	db 0
