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
	dw RhydonEvosMoves
	dw KangaskhanEvosMoves
	dw NidoranMEvosMoves
	dw ClefairyEvosMoves
	dw SpearowEvosMoves
	dw VoltorbEvosMoves
	dw NidokingEvosMoves
	dw SlowbroEvosMoves
	dw IvysaurEvosMoves
	dw ExeggutorEvosMoves
	dw LickitungEvosMoves
	dw ExeggcuteEvosMoves
	dw GrimerEvosMoves
	dw GengarEvosMoves
	dw NidoranFEvosMoves
	dw NidoqueenEvosMoves
	dw CuboneEvosMoves
	dw RhyhornEvosMoves
	dw LaprasEvosMoves
	dw ArcanineEvosMoves
	dw MewEvosMoves
	dw GyaradosEvosMoves
	dw ShellderEvosMoves
	dw TentacoolEvosMoves
	dw GastlyEvosMoves
	dw ScytherEvosMoves
	dw StaryuEvosMoves
	dw BlastoiseEvosMoves
	dw PinsirEvosMoves
	dw TangelaEvosMoves
	dw MissingNo1FEvosMoves
	dw MissingNo20EvosMoves
	dw GrowlitheEvosMoves
	dw OnixEvosMoves
	dw FearowEvosMoves
	dw PidgeyEvosMoves
	dw SlowpokeEvosMoves
	dw KadabraEvosMoves
	dw GravelerEvosMoves
	dw ChanseyEvosMoves
	dw MachokeEvosMoves
	dw MrMimeEvosMoves
	dw HitmonleeEvosMoves
	dw HitmonchanEvosMoves
	dw ArbokEvosMoves
	dw ParasectEvosMoves
	dw PsyduckEvosMoves
	dw DrowzeeEvosMoves
	dw GolemEvosMoves
	dw MissingNo32EvosMoves
	dw MagmarEvosMoves
	dw MissingNo34EvosMoves
	dw ElectabuzzEvosMoves
	dw MagnetonEvosMoves
	dw KoffingEvosMoves
	dw MissingNo38EvosMoves
	dw MankeyEvosMoves
	dw SeelEvosMoves
	dw DiglettEvosMoves
	dw TaurosEvosMoves
	dw MissingNo3DEvosMoves
	dw MissingNo3EEvosMoves
	dw MissingNo3FEvosMoves
	dw FarfetchdEvosMoves
	dw VenonatEvosMoves
	dw DragoniteEvosMoves
	dw MissingNo43EvosMoves
	dw MissingNo44EvosMoves
	dw MissingNo45EvosMoves
	dw DoduoEvosMoves
	dw PoliwagEvosMoves
	dw JynxEvosMoves
	dw MoltresEvosMoves
	dw ArticunoEvosMoves
	dw ZapdosEvosMoves
	dw DittoEvosMoves
	dw MeowthEvosMoves
	dw KrabbyEvosMoves
	dw MissingNo4FEvosMoves
	dw MissingNo50EvosMoves
	dw MissingNo51EvosMoves
	dw VulpixEvosMoves
	dw NinetalesEvosMoves
	dw PikachuEvosMoves
	dw RaichuEvosMoves
	dw MissingNo56EvosMoves
	dw MissingNo57EvosMoves
	dw DratiniEvosMoves
	dw DragonairEvosMoves
	dw KabutoEvosMoves
	dw KabutopsEvosMoves
	dw HorseaEvosMoves
	dw SeadraEvosMoves
	dw MissingNo5EEvosMoves
	dw MissingNo5FEvosMoves
	dw SandshrewEvosMoves
	dw SandslashEvosMoves
	dw OmanyteEvosMoves
	dw OmastarEvosMoves
	dw JigglypuffEvosMoves
	dw WigglytuffEvosMoves
	dw EeveeEvosMoves
	dw FlareonEvosMoves
	dw JolteonEvosMoves
	dw VaporeonEvosMoves
	dw MachopEvosMoves
	dw ZubatEvosMoves
	dw EkansEvosMoves
	dw ParasEvosMoves
	dw PoliwhirlEvosMoves
	dw PoliwrathEvosMoves
	dw WeedleEvosMoves
	dw KakunaEvosMoves
	dw BeedrillEvosMoves
	dw MissingNo73EvosMoves
	dw DodrioEvosMoves
	dw PrimeapeEvosMoves
	dw DugtrioEvosMoves
	dw VenomothEvosMoves
	dw DewgongEvosMoves
	dw MissingNo79EvosMoves
	dw MissingNo7AEvosMoves
	dw CaterpieEvosMoves
	dw MetapodEvosMoves
	dw ButterfreeEvosMoves
	dw MachampEvosMoves
	dw MissingNo7FEvosMoves
	dw GolduckEvosMoves
	dw HypnoEvosMoves
	dw GolbatEvosMoves
	dw MewtwoEvosMoves
	dw SnorlaxEvosMoves
	dw MagikarpEvosMoves
	dw MissingNo86EvosMoves
	dw MissingNo87EvosMoves
	dw MukEvosMoves
	dw MissingNo8AEvosMoves
	dw KinglerEvosMoves
	dw CloysterEvosMoves
	dw MissingNo8CEvosMoves
	dw ElectrodeEvosMoves
	dw ClefableEvosMoves
	dw WeezingEvosMoves
	dw PersianEvosMoves
	dw MarowakEvosMoves
	dw MissingNo92EvosMoves
	dw HaunterEvosMoves
	dw AbraEvosMoves
	dw AlakazamEvosMoves
	dw PidgeottoEvosMoves
	dw PidgeotEvosMoves
	dw StarmieEvosMoves
	dw BulbasaurEvosMoves
	dw VenusaurEvosMoves
	dw TentacruelEvosMoves
	dw MissingNo9CEvosMoves
	dw GoldeenEvosMoves
	dw SeakingEvosMoves
	dw MissingNo9FEvosMoves
	dw MissingNoA0EvosMoves
	dw MissingNoA1EvosMoves
	dw MissingNoA2EvosMoves
	dw PonytaEvosMoves
	dw RapidashEvosMoves
	dw RattataEvosMoves
	dw RaticateEvosMoves
	dw NidorinoEvosMoves
	dw NidorinaEvosMoves
	dw GeodudeEvosMoves
	dw PorygonEvosMoves
	dw AerodactylEvosMoves
	dw MissingNoACEvosMoves
	dw MagnemiteEvosMoves
	dw MissingNoAEEvosMoves
	dw MissingNoAFEvosMoves
	dw CharmanderEvosMoves
	dw SquirtleEvosMoves
	dw CharmeleonEvosMoves
	dw WartortleEvosMoves
	dw CharizardEvosMoves
	dw MissingNoB5EvosMoves
	dw FossilKabutopsEvosMoves
	dw FossilAerodactylEvosMoves
	dw MonGhostEvosMoves
	dw OddishEvosMoves
	dw GloomEvosMoves
	dw VileplumeEvosMoves
	dw BellsproutEvosMoves
	dw WeepinbellEvosMoves
	dw VictreebelEvosMoves
	assert_table_length NUM_POKEMON_INDEXES

RhydonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, HORN_ATTACK
	db 10, TAIL_WHIP
	db 14, GROUND_STOMP
	db 18, FURY_ATTACK
	db 24, ROCK_THROW
	db 30, BULLDOZE
	db 36, DIG
	db 42, TAKE_DOWN
	db 48, EARTHQUAKE
	db 54, ROCK_SLIDE
	db 60, HORN_DRILL
	db 65, MEGAHORN
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TAIL_WHIP
	db 10, BITE
	db 14, DOUBLE_KICK
	db 18, RAGE
	db 22, DIZZY_PUNCH
	db 28, MACH_PUNCH
	db 34, BODY_SLAM
	db 40, STRENGTH
	db 47, TAKE_DOWN
	db 54, DIZZY_PUNCH
	db 60, DOUBLE_EDGE
	db 0

NidoranMEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINO
	db 0
; Learnset
	db  5, LEER
	db  8, POISON_STING
	db 12, DOUBLE_KICK
	db 17, HORN_ATTACK
	db 23, POISON_FANG
	db 28, FOCUS_ENERGY
	db 34, TOXIC_FANGS
	db 40, BULLDOZE
	db 47, EARTHQUAKE
	db 54, GUNK_SHOT
	db 60, MEGAHORN
	db 0

ClefairyEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
	db  5, DOUBLESLAP
	db 10, GROWL
	db 15, DRAINING_KISS
	db 20, SING
	db 25, METRONOME
	db 30, FAIRY_WIND
	db 35, DAZZLE_GLEAM
	db 42, CHARM
	db 50, MOONBLAST
	db 58, SOFTBOILED
	db 0

SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
	db  5, PECK
	db  9, GROWL
	db 13, LEER
	db 17, FURY_ATTACK
	db 22, AERIAL_ACE
	db 28, FAINT_ATTACK
	db 34, DRILL_PECK
	db 40, AGILITY
	db 47, HONE_CLAWS
	db 53, SKY_ATTACK
	db 60, BRUTAL_SWING
	db 0

VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db  5, SONICBOOM
	db 10, THUNDERSHOCK
	db 14, SCREECH
	db 18, DISCHARGE
	db 22, MAGNET_BOMB
	db 28, THUNDER_WAVE
	db 34, EXPLOSION
	db 40, THUNDERBOLT
	db 47, MIRROR_MOVE
	db 54, THUNDER
	db 0

NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, LEER
	db  8, POISON_STING
	db 12, DOUBLE_KICK
	db 17, HORN_ATTACK
	db 23, POISON_FANG
	db 28, FOCUS_ENERGY
	db 34, TOXIC_FANGS
	db 40, BULLDOZE
	db 47, EARTHQUAKE
	db 54, GUNK_SHOT
	db 54, MEGAHORN
	db 60, MEGAHORN
	db 60, OUTRAGE
	db 0
	
SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, TAIL_WHIP
	db 10, WATER_GUN
	db 14, CONFUSION
	db 18, DISABLE
	db 22, HEADBUTT
	db 28, WATER_PULSE
	db 34, PSYBEAM
	db 40, AMNESIA
	db 47, SURF
	db 54, PSYCHIC_M
	db 54, BODY_SLAM
	db 60, HYDRO_PUMP
	db 0

IvysaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, VENUSAUR
	db 0
; Learnset
	db  4, VINE_WHIP
	db  8, LEECH_SEED
	db 12, POISONPOWDER
	db 16, GROWTH
	db 20, ABSORB
	db 24, SLEEP_POWDER
	db 28, RAZOR_LEAF
	db 32, MEGA_DRAIN
	db 38, SLUDGE
	db 42, GIGA_DRAIN
	db 48, PETAL_DANCE
	db 50, RECOVER
	db 0

ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, FURY_ATTACK
	db  9, HYPNOSIS
	db 13, REFLECT
	db 17, LEECH_SEED
	db 22, CONFUSION
	db 28, STUN_SPORE
	db 34, POISONPOWDER
	db 40, SLEEP_POWDER
	db 47, PSYCHIC_M
	db 54, EXPLOSION
	db 60, GIGA_DRAIN
	db 0

LickitungEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, DEFENSE_CURL
	db 10, WRAP
	db 14, DISABLE
	db 18, NEUROTOXIN
	db 22, BODY_SLAM
	db 28, ACID
	db 34, SLUDGE
	db 40, TOXIC
	db 47, TAKE_DOWN
	db 54, GUNK_SHOT
	db 60, HYPER_FANG
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
	db  5, FURY_ATTACK
	db  9, HYPNOSIS
	db 13, REFLECT
	db 17, LEECH_SEED
	db 22, CONFUSION
	db 28, STUN_SPORE
	db 34, POISONPOWDER
	db 40, SLEEP_POWDER
	db 47, PSYCHIC_M
	db 54, EXPLOSION
	db 60, GIGA_DRAIN
	db 0

GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, MUK
	db 0
; Learnset
	db  5, POISON_STING
	db  9, DISABLE
	db 13, ACID
	db 17, BIND
	db 22, POISON_FANG
	db 28, SLUDGE
	db 34, TOXIC_FANGS
	db 40, HARDEN
	db 47, SLUDGE_WAVE
	db 54, GUNK_SHOT
	db 60, RECOVER
	db 0

GengarEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, LICK
	db  9, SMOG
	db 13, ASTONISH
	db 17, CONFUSE_RAY
	db 22, NIGHT_SHADE
	db 28, SHADOW_SNEAK
	db 34, WILL_O_WISP
	db 40, SHADOW_BALL
	db 47, DARK_PULSE
	db 54, SHADOW_PUNCH
	db 60, DREAM_EATER
	db 0

NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINA
	db 0
; Learnset
	db  5, GROWL
	db  8, POISON_STING
	db 12, TAIL_WHIP
	db 17, BITE
	db 23, POISON_FANG
	db 28, FURY_ATTACK
	db 34, TOXIC_FANGS
	db 40, BODY_SLAM
	db 47, EARTHQUAKE
	db 54, CRUNCH
	db 60, SLUDGE_WAVE
	db 0

NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, GROWL
	db  8, POISON_STING
	db 12, TAIL_WHIP
	db 17, BITE
	db 23, POISON_FANG
	db 28, FURY_ATTACK
	db 34, TOXIC_FANGS
	db 40, BODY_SLAM
	db 47, EARTHQUAKE
	db 54, CRUNCH
	db 54, BODY_SLAM
	db 60, SLUDGE_WAVE
	db 60, EARTHQUAKE
	db 0

CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, MAROWAK
	db 0
; Learnset
	db  5, GROWL
	db  9, TAIL_WHIP
	db 13, BONE_CLUB
	db 17, HEADBUTT
	db 22, FOCUS_ENERGY
	db 28, BONEMERANG
	db 34, RAGE
	db 40, BULK_UP
	db 46, EARTHQUAKE
	db 54, DOUBLE_EDGE
	db 0

RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, RHYDON
	db 0
; Learnset
	db  5, HORN_ATTACK
	db 10, TAIL_WHIP
	db 14, GROUND_STOMP
	db 18, FURY_ATTACK
	db 24, ROCK_THROW
	db 30, BULLDOZE
	db 36, DIG
	db 42, TAKE_DOWN
	db 48, EARTHQUAKE
	db 54, ROCK_SLIDE
	db 60, HORN_DRILL
	db 65, MEGAHORN
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, SING
	db 12, WATER_PULSE
	db 16, ICY_WIND
	db 22, CONFUSE_RAY
	db 25, CHARM
	db 28, BODY_SLAM
	db 32, BIDE
	db 36, ICE_BEAM
	db 42, SURF
	db 48, BLIZZARD
	db 55, HYDRO_PUMP
	db 60, RECOVER
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, BITE
	db 10, EMBER
	db 15, INTIMIDATE
	db 20, FLAME_CHARGE
	db 26, FAINT_ATTACK
	db 32, FLAMETHROWER
	db 38, TAKE_DOWN
	db 45, AGILITY
	db 52, CRUNCH
	db 54, EXTREMESPEED
	db 60, FIRE_BLAST
	db 60, OUTRAGE
	db 0

MewEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, PSYCHIC_BIND
	db 15, TRANSFORM
	db 20, RECOVER
	db 25, PSYBEAM
	db 30, CALM_MIND
	db 35, DRAINING_KISS
	db 40, SHADOW_BALL
	db 45, MIRROR_MOVE
	db 50, PSYCHIC_M
	db 55, MIND_BREAK
	db 60, MOONBLAST
	db 65, METRONOME
	db 70, HYPER_BEAM
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, TACKLE
	db 20, BITE
	db 24, DRAGON_RAGE
	db 28, INTIMIDATE
	db 32, LEER
	db 36, AQUA_JET
	db 40, ICE_BEAM
	db 44, BODY_SLAM
	db 48, DRAGON_BREATH
	db 52, CRUNCH
	db 56, HYDRO_PUMP
	db 60, OUTRAGE
	db 65, HYPER_BEAM
	db 0

ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
	db  5, WITHDRAW
	db 10, AURORA_BEAM
	db 14, ICY_WIND
	db 18, CLAMP
	db 22, BUBBLEBEAM
	db 28, ICE_BEAM
	db 34, HARDEN
	db 40, BLIZZARD
	db 47, HYDRO_PUMP
	db 54, EXPLOSION
	db 0

TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
	db  6, POISON_STING
	db 10, SUPERSONIC
	db 14, WATER_GUN
	db 18, ACID
	db 22, BUBBLEBEAM
	db 28, BIND
	db 34, WATER_PULSE
	db 40, POISON_FANG
	db 47, SLUDGE_WAVE
	db 54, SURF
	db 60, HYDRO_PUMP
	db 0

GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HAUNTER
	db 0
; Learnset
	db  5, LICK
	db  9, SMOG
	db 13, ASTONISH
	db 17, CONFUSE_RAY
	db 22, NIGHT_SHADE
	db 28, SHADOW_SNEAK
	db 34, WILL_O_WISP
	db 40, SHADOW_BALL
	db 47, DARK_PULSE
	db 54, SHADOW_PUNCH
	db 60, DREAM_EATER
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, QUICK_ATTACK
	db  9, LEER
	db 13, FURY_ATTACK
	db 17, FOCUS_ENERGY
	db 22, WING_ATTACK
	db 28, SLASH
	db 34, AERIAL_ACE
	db 40, AGILITY
	db 47, NIGHT_SLASH
	db 54, BRUTAL_SWING
	db 60, GUILLOTINE
	db 0

StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, STARMIE
	db 0
; Learnset
	db  5, WATER_GUN
	db 10, HARDEN
	db 14, BUBBLEBEAM
	db 18, FAINT_ATTACK
	db 22, RECOVER
	db 28, WATER_PULSE
	db 34, PSYBEAM
	db 40, ICY_WIND
	db 47, SURF
	db 54, PSYCHIC_M
	db 60, HYDRO_PUMP
	db 0

BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
	db  4, WATER_GUN
	db  8, WITHDRAW
	db 12, BITE
	db 16, BUBBLEBEAM
	db 20, ICY_WIND
	db 25, WATERFALL
	db 30, HARDEN
	db 35, SURF
	db 45, HYDRO_PUMP
	db 50, HEAD_SMASH
	db 55, BIDE
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, VICEGRIP
	db 10, FOCUS_ENERGY
	db 14, BIND
	db 18, BUG_BITE
	db 22, SEISMIC_TOSS
	db 28, GORE_ATTACK
	db 34, BULK_UP
	db 40, BRUTAL_SWING
	db 47, MEGAHORN
	db 54, GUILLOTINE
	db 60, SUBMISSION
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, CONSTRICT
	db 10, ABSORB
	db 14, VINE_WHIP
	db 18, STUN_SPORE
	db 22, GROWTH
	db 28, MEGA_DRAIN
	db 34, BIND
	db 40, STRING_SHOT
	db 47, GIGA_DRAIN
	db 60, RECOVER
	db 0

MissingNo1FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo20EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GrowlitheEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
	db  5, BITE
	db 10, EMBER
	db 15, INTIMIDATE
	db 20, FLAME_CHARGE
	db 26, FAINT_ATTACK
	db 32, FLAMETHROWER
	db 38, TAKE_DOWN
	db 45, AGILITY
	db 52, CRUNCH
	db 60, FIRE_BLAST
	db 0

OnixEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, BIND
	db 10, HARDEN
	db 14, ROCK_THROW
	db 18, MUD_SHOT
	db 22, BULLDOZE
	db 28, ROCK_TOMB
	db 34, DIG
	db 40, IRON_TAIL
	db 47, EARTHQUAKE
	db 54, ROCK_SLIDE
	db 60, HEAD_SMASH
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, PECK
	db  9, GROWL
	db 13, LEER
	db 17, FURY_ATTACK
	db 22, AERIAL_ACE
	db 28, FAINT_ATTACK
	db 34, DRILL_PECK
	db 40, AGILITY
	db 47, HONE_CLAWS
	db 53, SKY_ATTACK
	db 60, BRUTAL_SWING
	db 60, HURRICANE
	db 0

PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, PIDGEOTTO
	db 0
; Learnset
	db  5, SAND_ATTACK
	db  9, QUICK_ATTACK
	db 13, TAILWIND
	db 17, WING_ATTACK
	db 20, AERIAL_ACE
	db 25, FAINT_ATTACK
	db 30, HONE_CLAWS
	db 35, FLY
	db 42, BRUTAL_SWING
	db 48, AGILITY
	db 55, SKY_ATTACK
	db 60, HURRICANE
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, SLOWBRO
	db 0
; Learnset
	db  6, TAIL_WHIP
	db 10, WATER_GUN
	db 14, CONFUSION
	db 18, DISABLE
	db 22, HEADBUTT
	db 28, WATER_PULSE
	db 34, PSYBEAM
	db 40, AMNESIA
	db 47, SURF
	db 54, PSYCHIC_M
	db 60, HYDRO_PUMP
	db 0

KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, ALAKAZAM
	db 0
; Learnset
	db  8, DISABLE
	db 12, PSYBEAM
	db 16, PSYCHIC_BIND
	db 20, DISABLE
	db 24, RECOVER
	db 28, REFLECT
	db 32, PSYBEAM
	db 38, CALM_MIND
	db 44, PSYCHIC_M
	db 50, MIND_BREAK
	db 0

GravelerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, GOLEM
	db 0
; Learnset
	db  5, DEFENSE_CURL
	db 10, ROCK_THROW
	db 14, MUD_SHOT
	db 18, ROCK_PUNCH
	db 22, BULLDOZE
	db 28, ROCK_TOMB
	db 34, DIG
	db 40, EARTHQUAKE
	db 47, ROCK_SLIDE
	db 54, HEAD_SMASH
	db 60, EXPLOSION
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, GROWL
	db  8, DEFENSE_CURL
	db 12, DOUBLESLAP
	db 16, SING
	db 22, REFLECT
	db 28, LIGHT_SCREEN
	db 34, DRAINING_KISS
	db 40, SOFTBOILED
	db 47, DAZZLE_GLEAM
	db 54, DOUBLE_EDGE
	db 60, BODY_SLAM
	db 0

MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, MACHAMP
	db 0
; Learnset
	db  5, LOW_KICK
	db  9, LEER
	db 13, FOCUS_ENERGY
	db 17, KARATE_CHOP
	db 22, ROLLING_KICK
	db 28, STRENGTH
	db 34, BULK_UP
	db 40, TAKE_DOWN
	db 47, SUBMISSION
	db 54, DIZZY_PUNCH
	db 60, SKY_UPPERCUT
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  8, CONFUSION
	db 12, DOUBLESLAP
	db 17, LIGHT_SCREEN
	db 22, DAZZLE_GLEAM
	db 28, PSYBEAM
	db 34, MIMIC
	db 40, PSYCHIC_M
	db 47, SUBSTITUTE
	db 54, DREAM_EATER
	db 60, MOONBLAST
	db 0

HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, DOUBLE_KICK
	db 10, FOCUS_ENERGY
	db 14, ROLLING_KICK
	db 18, LOW_KICK
	db 22, DIZZY_PUNCH
	db 28, BULK_UP
	db 34, MIND_BREAK
	db 40, STRENGTH
	db 47, SUBMISSION
	db 54, HI_JUMP_KICK
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, COMET_PUNCH
	db 10, AGILITY
	db 14, MACH_PUNCH
	db 18, FLAME_BURST
	db 22, ICY_WIND
	db 28, DISCHARGE
	db 34, BULK_UP
	db 40, DIZZY_PUNCH
	db 47, SKY_UPPERCUT
	db 54, FOCUS_ENERGY
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WRAP
	db 10, BITE
	db 14, POISON_STING
	db 18, ACID
	db 22, GLARE
	db 28, POISON_FANG
	db 34, SCREECH
	db 40, TOXIC_FANGS
	db 47, SLUDGE_WAVE
	db 50, WRAP
	db 54, GUNK_SHOT
	db 60, CRUNCH
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SCRATCH
	db  9, POISONPOWDER
	db 13, ABSORB
	db 17, STUN_SPORE
	db 22, LEECH_LIFE
	db 28, SLASH
	db 28, SPORE
	db 35, GROWTH
	db 35, PARASITE
	db 42, MEGA_DRAIN
	db 50, GIGA_DRAIN
	db 0

PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, GOLDUCK
	db 0
; Learnset
	db  5, WATER_GUN
	db 10, TAIL_WHIP
	db 14, DISABLE
	db 18, CONFUSION
	db 22, BUBBLEBEAM
	db 28, WATER_PULSE
	db 34, PSYBEAM
	db 40, SURF
	db 46, PSYCHIC_M
	db 54, HYDRO_PUMP
	db 0

DrowzeeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HYPNO
	db 0
; Learnset
	db  5, HYPNOSIS
	db  9, DISABLE
	db 13, CONFUSION
	db 17, FAINT_ATTACK
	db 22, PSYBEAM
	db 28, PSYCHIC_BIND
	db 34, BRUTAL_SWING
	db 40, PSYCHIC_M
	db 47, NIGHT_SLASH
	db 54, DREAM_EATER
	db 0

GolemEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, DEFENSE_CURL
	db 10, ROCK_THROW
	db 14, MUD_SHOT
	db 18, ROCK_PUNCH
	db 22, BULLDOZE
	db 28, ROCK_TOMB
	db 34, DIG
	db 40, EARTHQUAKE
	db 47, ROCK_SLIDE
	db 54, HEAD_SMASH
	db 60, EXPLOSION
	db 0

MissingNo32EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MagmarEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, EMBER
	db 10, LEER
	db 14, SMOKESCREEN
	db 18, FAINT_ATTACK
	db 22, FLAME_BURST
	db 28, CONFUSE_RAY
	db 34, MAGMA_PUNCH
	db 40, FLAMETHROWER
	db 47, LAVA_PLUME
	db 54, DIZZY_PUNCH
	db 60, FIRE_BLAST
	db 0

MissingNo34EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, QUICK_ATTACK
	db 10, LEER
	db 14, THUNDERSHOCK
	db 18, LIGHT_SCREEN
	db 22, DISCHARGE
	db 28, THUNDER_WAVE
	db 34, AGILITY
	db 40, SCREECH
	db 47, THUNDERBOLT
	db 54, DIZZY_PUNCH
	db 60, THUNDER
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, THUNDERSHOCK
	db 10, SUPERSONIC
	db 14, SONICBOOM
	db 18, THUNDER_WAVE
	db 22, DISCHARGE
	db 28, SCREECH
	db 34, BULLET_PUNCH
	db 40, MAGNET_BOMB
	db 46, THUNDERBOLT
	db 54, THUNDER
	db 54, TRI_ATTACK
	db 0

KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, WEEZING
	db 0
; Learnset
	db  5, SMOG
	db  9, POISON_GAS
	db 13, SLUDGE
	db 17, SMOKESCREEN
	db 22, ACID
	db 28, HAZE
	db 34, SLUDGE_WAVE
	db 40, GUNK_SHOT
	db 47, TOXIC
	db 54, EXPLOSION
	db 0

MissingNo38EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MankeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 29, PRIMEAPE
	db 0
; Learnset
	db  5, SCRATCH
	db  9, LEER
	db 13, LOW_KICK
	db 17, KARATE_CHOP
	db 22, RAGE
	db 28, FOCUS_ENERGY
	db 34, DIZZY_PUNCH
	db 40, FAINT_ATTACK
	db 47, SUBMISSION
	db 54, CRUNCH
	db 60, SKY_UPPERCUT
	db 0

SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, DEWGONG
	db 0
; Learnset
	db  5, HEADBUTT
	db 10, GROWL
	db 14, ICY_WIND
	db 18, AURORA_BEAM
	db 22, REST
	db 28, BUBBLEBEAM
	db 34, WATER_PULSE
	db 40, ICE_BEAM
	db 47, TAKE_DOWN
	db 54, SURF
	db 60, BLIZZARD
	db 0

DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DUGTRIO
	db 0
; Learnset
	db  5, GROUND_STOMP
	db 10, GROWL
	db 14, MUD_SHOT
	db 18, DIG
	db 24, BULLDOZE
	db 30, SAND_ATTACK
	db 36, MUD_BOMB
	db 42, EARTHQUAKE
	db 50, FISSURE
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, TAIL_WHIP
	db 10, HORN_ATTACK
	db 14, FOCUS_ENERGY
	db 18, GROUND_STOMP
	db 22, INTIMIDATE
	db 28, RAGE
	db 32, HORN_CHARGE
	db 36, SCARY_FACE
	db 40, TAKE_DOWN
	db 45, STRENGTH
	db 50, BODY_SLAM
	db 54, GORE_ATTACK
	db 58, MEGAHORN
	db 62, OUTRAGE
	db 66, HEAD_SMASH
	db 0

MissingNo3DEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo3EEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo3FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FarfetchdEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, PECK
	db  8, SAND_ATTACK
	db 12, FURY_ATTACK
	db 17, LEEK_STRIKE
	db 22, FOCUS_ENERGY
	db 28, AERIAL_ACE
	db 34, SLASH
	db 40, AGILITY
	db 47, HONE_CLAWS
	db 54, SKY_ATTACK
	db 60, BRUTAL_SWING
	db 0

VenonatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, VENOMOTH
	db 0
; Learnset
	db  5, TACKLE
	db  9, POISONPOWDER
	db 13, DISABLE
	db 17, CONFUSION
	db 22, STUN_SPORE
	db 28, PSYBEAM
	db 34, SLEEP_POWDER
	db 40, PSYCHIC_M
	db 47, BUG_BUZZ
	db 54, SLUDGE
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, BIND
	db  8, THUNDER_WAVE
	db 11, DRAGON_RAGE
	db 15, AGILITY
	db 20, BITE
	db 25, AQUA_JET
	db 30, DRAGON_BREATH
	db 35, ICY_WIND
	db 40, EXTREMESPEED
	db 45, OUTRAGE
	db 48, WING_ATTACK
	db 50, BULK_UP
	db 52, FLY
	db 55, DRAGON_CLAW
	db 58, AERIAL_ACE
	db 62, HURRICANE
	db 65, HYPER_BEAM
	db 0

MissingNo43EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo44EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo45EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DoduoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DODRIO
	db 0
; Learnset
	db  5, PECK
	db  9, GROWL
	db 13, QUICK_ATTACK
	db 17, FURY_ATTACK
	db 22, RAGE
	db 28, TRI_ATTACK
	db 34, DRILL_PECK
	db 40, AGILITY
	db 48, HORN_CHARGE
	db 55, DOUBLE_EDGE
	db 0

PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, POLIWHIRL
	db 0
; Learnset
	db  5, BUBBLEBEAM
	db  9, DOUBLESLAP
	db 13, HYPNOSIS
	db 17, WATER_GUN
	db 22, BODY_SLAM
	db 28, WATER_PULSE
	db 34, MIND_BREAK
	db 40, SURF
	db 47, BIDE
	db 54, HYDRO_PUMP
	db 0

JynxEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, LICK
	db 10, LOVELY_KISS
	db 14, POWDER_SNOW
	db 18, DRAINING_KISS
	db 22, SING
	db 28, ICY_WIND
	db 34, BODY_SLAM
	db 40, ICE_BEAM
	db 47, PSYCHIC_M
	db 54, BLIZZARD
	db 60, DREAM_EATER
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, PECK
	db 10, EMBER
	db 15, FLAME_CHARGE
	db 22, AGILITY
	db 28, FLAMETHROWER
	db 34, WING_ATTACK
	db 40, WILL_O_WISP
	db 47, DRILL_PECK
	db 54, FLAME_BURST
	db 60, SKY_ATTACK
	db 66, FIRE_BLAST
	db 72, HURRICANE
	db 0

ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, POWDER_SNOW
	db 10, GUST
	db 15, ICY_WIND
	db 22, AGILITY
	db 28, AURORA_BEAM
	db 34, WING_ATTACK
	db 40, ICE_BEAM
	db 47, REFLECT
	db 54, FAINT_ATTACK
	db 60, BLIZZARD
	db 66, HURRICANE
	db 72, SKY_ATTACK
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, PECK
	db 10, THUNDERSHOCK
	db 15, AGILITY
	db 22, DISCHARGE
	db 28, WING_ATTACK
	db 34, DOUBLE_TEAM
	db 40, THUNDER_WAVE
	db 47, DRILL_PECK
	db 54, THUNDERBOLT
	db 60, SKY_ATTACK
	db 66, THUNDER
	db 72, HURRICANE
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
	db  5, GROWL
	db  9, BITE
	db 13, PAY_DAY
	db 17, FURY_ATTACK
	db 22, FAINT_ATTACK
	db 28, HONE_CLAWS
	db 34, SLASH
	db 40, TAUNT
	db 47, NIGHT_SLASH
	db 54, BRUTAL_SWING
	db 0

KrabbyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, KINGLER
	db 0
; Learnset
	db  5, VICEGRIP
	db  9, LEER
	db 13, BUBBLEBEAM
	db 17, MUD_SHOT
	db 22, BIND
	db 28, WATER_PULSE
	db 34, BULK_UP
	db 40, CRABHAMMER
	db 47, SURF
	db 54, GUILLOTINE
	db 60, HYDRO_PUMP
	db 0

MissingNo4FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo50EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo51EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

VulpixEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NINETALES
	db 0
; Learnset
	db  5, TAIL_WHIP
	db 10, EMBER
	db 15, QUICK_ATTACK
	db 20, CONFUSE_RAY
	db 25, FAIRY_WIND
	db 30, FLAME_CHARGE
	db 35, WILL_O_WISP
	db 42, FLAMETHROWER
	db 48, DAZZLE_GLEAM
	db 55, FIRE_BLAST
	db 62, MOONBLAST
	db 0

NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TAIL_WHIP
	db 10, EMBER
	db 15, QUICK_ATTACK
	db 20, CONFUSE_RAY
	db 25, FAIRY_WIND
	db 30, FLAME_CHARGE
	db 35, WILL_O_WISP
	db 42, FLAMETHROWER
	db 48, DAZZLE_GLEAM
	db 55, FIRE_BLAST
	db 62, MOONBLAST
	db 62, FIRE_BLAST
	db 0

PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
	db  6, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 11, NUZZLE
	db 15, DOUBLE_TEAM
	db 20, THUNDER_WAVE
	db 25, THUNDERBOLT
	db 30, AGILITY
	db 35, THUNDER
	db 40, VOLT_TACKLE
	db 45, IRON_TAIL
	db 50, EXTREMESPEED
	db 55, BODY_SLAM
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 11, NUZZLE
	db 15, DOUBLE_TEAM
	db 20, THUNDER_WAVE
	db 25, THUNDERBOLT
	db 30, AGILITY
	db 35, THUNDER
	db 40, VOLT_TACKLE
	db 45, IRON_TAIL
	db 50, EXTREMESPEED
	db 55, BODY_SLAM
	db 0

MissingNo56EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo57EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DratiniEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DRAGONAIR
	db 0
; Learnset
	db  5, BIND
	db  8, THUNDER_WAVE
	db 11, DRAGON_RAGE
	db 15, AGILITY
	db 20, BITE
	db 25, AQUA_JET
	db 30, DRAGON_BREATH
	db 35, ICY_WIND
	db 40, EXTREMESPEED
	db 45, OUTRAGE
	db 50, BULK_UP
	db 0

DragonairEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 48, DRAGONITE
	db 0
; Learnset
	db  5, BIND
	db  8, THUNDER_WAVE
	db 11, DRAGON_RAGE
	db 15, AGILITY
	db 20, BITE
	db 25, AQUA_JET
	db 30, DRAGON_BREATH
	db 35, ICY_WIND
	db 40, EXTREMESPEED
	db 45, OUTRAGE
	db 50, BULK_UP
	db 0

KabutoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, KABUTOPS
	db 0
; Learnset
	db  5, SCRATCH
	db 10, HARDEN
	db 14, ABSORB
	db 18, LEECH_LIFE
	db 22, MUD_SHOT
	db 28, BUG_BITE
	db 34, ROCK_THROW
	db 40, SLASH
	db 47, ROCK_SLIDE
	db 54, BRUTAL_SWING
	db 60, MEGAHORN
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SCRATCH
	db 10, HARDEN
	db 14, ABSORB
	db 18, LEECH_LIFE
	db 22, MUD_SHOT
	db 28, BUG_BITE
	db 34, ROCK_THROW
	db 40, SLASH
	db 47, ROCK_SLIDE
	db 47, NIGHT_SLASH
	db 54, BRUTAL_SWING
	db 54, AQUA_JET
	db 60, MEGAHORN
	db 60, BRUTAL_SWING
	db 0

HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, SEADRA
	db 0
; Learnset
	db  5, WATER_GUN
	db  9, SMOKESCREEN
	db 13, BUBBLEBEAM
	db 17, LEER
	db 22, WATER_PULSE
	db 28, AGILITY
	db 34, DRAGON_BREATH
	db 40, DRAGON_RAGE
	db 47, SURF
	db 54, DRAGON_CLAW
	db 60, HYDRO_PUMP
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WATER_GUN
	db  9, SMOKESCREEN
	db 13, BUBBLEBEAM
	db 17, LEER
	db 22, WATER_PULSE
	db 28, AGILITY
	db 34, DRAGON_BREATH
	db 40, DRAGON_RAGE
	db 47, SURF
	db 54, DRAGON_CLAW
	db 60, HYDRO_PUMP
	db 0

MissingNo5EEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo5FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

SandshrewEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, SANDSLASH
	db 0
; Learnset
	db  5, DEFENSE_CURL
	db 10, SAND_ATTACK
	db 14, GROUND_STOMP
	db 18, BULLDOZE
	db 24, SLASH
	db 30, DIG
	db 36, MUD_BOMB
	db 42, EARTHQUAKE
	db 50, FISSURE
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, DEFENSE_CURL
	db 10, SAND_ATTACK
	db 14, GROUND_STOMP
	db 18, BULLDOZE
	db 24, SLASH
	db 30, DIG
	db 36, MUD_BOMB
	db 42, EARTHQUAKE
	db 50, FISSURE
	db 54, BRUTAL_SWING
	db 0

OmanyteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, OMASTAR
	db 0
; Learnset
	db  5, WATER_GUN
	db 10, WITHDRAW
	db 14, BITE
	db 18, BUBBLEBEAM
	db 22, MUD_SHOT
	db 28, WATER_PULSE
	db 34, ROCK_THROW
	db 40, ROCK_TOMB
	db 47, BIDE
	db 54, ROCK_SLIDE
	db 60, HYDRO_PUMP
	db 0

OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WATER_GUN
	db 10, WITHDRAW
	db 14, BITE
	db 18, BUBBLEBEAM
	db 22, MUD_SHOT
	db 28, WATER_PULSE
	db 34, ROCK_THROW
	db 40, ROCK_TOMB
	db 47, BIDE
	db 54, ROCK_SLIDE
	db 54, HYDRO_PUMP
	db 60, HYDRO_PUMP
	db 0

JigglypuffEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, WIGGLYTUFF
	db 0
; Learnset
	db  5, DOUBLESLAP
	db 10, GROWL
	db 15, DRAINING_KISS
	db 20, SING
	db 25, REST
	db 30, FAIRY_WIND
	db 35, DAZZLE_GLEAM
	db 42, BODY_SLAM
	db 50, MOONBLAST
	db 58, HYPER_FANG
	db 0

WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, DOUBLESLAP
	db 10, GROWL
	db 15, DRAINING_KISS
	db 20, SING
	db 25, REST
	db 30, FAIRY_WIND
	db 35, DAZZLE_GLEAM
	db 42, BODY_SLAM
	db 50, MOONBLAST
	db 58, HYPER_FANG
	db 62, DOUBLE_EDGE
	db 0

EeveeEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, FLAREON
	db EVOLVE_ITEM, THUNDER_STONE, 1, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, 1, VAPOREON
	db 0
; Learnset
	db  5, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 12, GROWL
	db 17, BITE
	db 22, HEADBUTT
	db 28, TAKE_DOWN
	db 34, BODY_SLAM
	db 40, DOUBLE_EDGE
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 12, GROWL
	db 17, BITE
	db 22, EMBER
	db 28, FLAME_CHARGE
	db 34, FAINT_ATTACK
	db 40, FLAME_BURST
	db 47, FLAMETHROWER
	db 54, TAKE_DOWN
	db 60, FIRE_BLAST
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 12, GROWL
	db 17, BITE
	db 22, THUNDERSHOCK
	db 28, DOUBLE_TEAM
	db 34, DISCHARGE
	db 40, AGILITY
	db 47, THUNDER_WAVE
	db 54, THUNDERBOLT
	db 60, EXTREMESPEED
	db 65, THUNDER
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 12, GROWL
	db 17, BITE
	db 22, WATER_GUN
	db 28, BUBBLEBEAM
	db 34, WATER_PULSE
	db 40, AURORA_BEAM
	db 47, ICY_WIND
	db 54, SURF
	db 60, RECOVER
	db 65, HYDRO_PUMP
	db 0

MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, MACHOKE
	db 0
; Learnset
	db  5, LOW_KICK
	db  9, LEER
	db 13, FOCUS_ENERGY
	db 17, KARATE_CHOP
	db 22, ROLLING_KICK
	db 28, STRENGTH
	db 34, BULK_UP
	db 40, TAKE_DOWN
	db 47, SUBMISSION
	db 54, DIZZY_PUNCH
	db 60, SKY_UPPERCUT
	db 0

ZubatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, GOLBAT
	db 0
; Learnset
	db  5, LEECH_LIFE
	db  9, SUPERSONIC
	db 13, BITE
	db 17, CONFUSE_RAY
	db 22, WING_ATTACK
	db 28, POISON_FANG
	db 34, AERIAL_ACE
	db 40, SLUDGE
	db 47, DARK_PULSE
	db 54, TOXIC
	db 60, HURRICANE
	db 0

EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, ARBOK
	db 0
; Learnset
	db  5, WRAP
	db 10, BITE
	db 14, POISON_STING
	db 18, ACID
	db 22, GLARE
	db 28, POISON_FANG
	db 34, SCREECH
	db 40, TOXIC_FANGS
	db 47, SLUDGE_WAVE
	db 54, GUNK_SHOT
	db 60, CRUNCH
	db 0

ParasEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, PARASECT
	db 0
; Learnset
	db  5, SCRATCH
	db  9, POISONPOWDER
	db 13, ABSORB
	db 17, STUN_SPORE
	db 22, LEECH_LIFE
	db 28, SLASH
	db 35, GROWTH
	db 42, MEGA_DRAIN
	db 50, GIGA_DRAIN
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
	db  5, BUBBLEBEAM
	db  9, DOUBLESLAP
	db 13, HYPNOSIS
	db 17, WATER_GUN
	db 22, BODY_SLAM
	db 28, WATER_PULSE
	db 34, MIND_BREAK
	db 40, SURF
	db 47, BIDE
	db 54, HYDRO_PUMP
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, BUBBLEBEAM
	db  9, DOUBLESLAP
	db 13, HYPNOSIS
	db 17, WATER_GUN
	db 22, BODY_SLAM
	db 28, WATER_PULSE
	db 34, MIND_BREAK
	db 40, SURF
	db 40, SUBMISSION
	db 47, BIDE
	db 47, DIZZY_PUNCH
	db 54, HYDRO_PUMP
	db 54, MIND_BREAK
	db 60, SKY_UPPERCUT
	db 0

WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, KAKUNA
	db 0
; Learnset
	db  5, POISON_STING
	db  9, FURY_ATTACK
	db 13, BUG_BITE
	db 0

KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BEEDRILL
	db 0
; Learnset
	db  5, POISON_STING
	db  9, FURY_ATTACK
	db 13, BUG_BITE
	db 0

BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, POISON_STING
	db  9, FURY_ATTACK
	db 11, TWINEEDLE
	db 13, BUG_BITE
	db 15, RAGE
	db 20, LEECH_LIFE
	db 25, BUG_BUZZ
	db 30, SLUDGE
	db 36, TOXIC_FANGS
	db 42, GUNK_SHOT
	db 48, MEGAHORN
	db 0

MissingNo73EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, PECK
	db  9, GROWL
	db 13, QUICK_ATTACK
	db 17, FURY_ATTACK
	db 22, RAGE
	db 28, TRI_ATTACK
	db 34, DRILL_PECK
	db 40, AGILITY
	db 48, HORN_CHARGE
	db 55, DOUBLE_EDGE
	db 60, TRI_ATTACK
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SCRATCH
	db  9, LEER
	db 13, LOW_KICK
	db 17, KARATE_CHOP
	db 22, RAGE
	db 28, FOCUS_ENERGY
	db 34, DIZZY_PUNCH
	db 40, FAINT_ATTACK
	db 47, SUBMISSION
	db 54, CRUNCH
	db 60, SKY_UPPERCUT
	db 60, OUTRAGE
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, GROUND_STOMP
	db 10, GROWL
	db 14, MUD_SHOT
	db 18, DIG
	db 24, BULLDOZE
	db 30, SAND_ATTACK
	db 36, MUD_BOMB
	db 42, EARTHQUAKE
	db 50, FISSURE
	db 54, TRI_ATTACK
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TACKLE
	db  9, POISONPOWDER
	db 13, DISABLE
	db 17, CONFUSION
	db 22, STUN_SPORE
	db 22, GUST
	db 28, PSYBEAM
	db 28, AERIAL_ACE
	db 34, SLEEP_POWDER
	db 40, PSYCHIC_M
	db 47, BUG_BUZZ
	db 54, SLUDGE
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, HEADBUTT
	db 10, GROWL
	db 14, ICY_WIND
	db 18, AURORA_BEAM
	db 22, REST
	db 28, BUBBLEBEAM
	db 34, WATER_PULSE
	db 40, ICE_BEAM
	db 47, TAKE_DOWN
	db 54, SURF
	db 60, BLIZZARD
	db 60, BODY_SLAM
	db 0

MissingNo79EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo7AEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

CaterpieEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, METAPOD
	db 0
; Learnset
	db  5, BUG_BITE
	db  9, LEECH_LIFE
	db 0

MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BUTTERFREE
	db 0
; Learnset
	db  5, BUG_BITE
	db  9, LEECH_LIFE
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, BUG_BITE
	db  9, LEECH_LIFE
	db 11, GUST
	db 14, POISONPOWDER
	db 18, STUN_SPORE
	db 22, SLEEP_POWDER
	db 28, SUPERSONIC
	db 34, CONFUSION
	db 40, PSYBEAM
	db 48, PSYCHIC_M
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, LOW_KICK
	db  9, LEER
	db 13, FOCUS_ENERGY
	db 17, KARATE_CHOP
	db 22, ROLLING_KICK
	db 28, STRENGTH
	db 34, BULK_UP
	db 40, TAKE_DOWN
	db 47, SUBMISSION
	db 54, DIZZY_PUNCH
	db 60, SKY_UPPERCUT
	db 60, SUBMISSION
	db 0

MissingNo7FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GolduckEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WATER_GUN
	db 10, TAIL_WHIP
	db 14, DISABLE
	db 18, CONFUSION
	db 22, BUBBLEBEAM
	db 28, WATER_PULSE
	db 34, PSYBEAM
	db 40, SURF
	db 46, PSYCHIC_M
	db 54, HYDRO_PUMP
	db 60, PSYCHIC_M
	db 0

HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, HYPNOSIS
	db  9, DISABLE
	db 13, CONFUSION
	db 17, FAINT_ATTACK
	db 22, PSYBEAM
	db 28, PSYCHIC_BIND
	db 34, BRUTAL_SWING
	db 40, PSYCHIC_M
	db 47, NIGHT_SLASH
	db 54, DREAM_EATER
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, LEECH_LIFE
	db  9, SUPERSONIC
	db 13, BITE
	db 17, CONFUSE_RAY
	db 22, WING_ATTACK
	db 28, POISON_FANG
	db 34, AERIAL_ACE
	db 40, SLUDGE
	db 47, DARK_PULSE
	db 54, TOXIC
	db 60, HURRICANE
	db 60, DARK_PULSE
	db 0

MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, RECOVER
	db 18, CALM_MIND
	db 25, PSYBEAM
	db 32, SHADOW_BALL
	db 38, PSYCHIC_M
	db 40, DARK_PULSE
	db 48, AGILITY
	db 55, BULK_UP
	db 62, MIND_BREAK
	db 70, HYPER_BEAM
	db 0

SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, HEADBUTT
	db 12, BITE
	db 18, BODY_SLAM
	db 22, HARDEN
	db 28, REST
	db 33, TAKE_DOWN
	db 38, BIDE
	db 50, HEAVY_SLAM
	db 58, CRUNCH
	db 0

MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GYARADOS
	db 0
; Learnset
	db 15, TACKLE
	db 0

MissingNo86EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo87EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MukEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, POISON_STING
	db  9, DISABLE
	db 13, ACID
	db 17, BIND
	db 22, POISON_FANG
	db 28, SLUDGE
	db 34, TOXIC_FANGS
	db 40, HARDEN
	db 47, SLUDGE_WAVE
	db 54, GUNK_SHOT
	db 54, SLUDGE_WAVE
	db 60, RECOVER
	db 0

MissingNo8AEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, VICEGRIP
	db  9, LEER
	db 13, BUBBLEBEAM
	db 17, MUD_SHOT
	db 22, BIND
	db 28, WATER_PULSE
	db 34, BULK_UP
	db 40, CRABHAMMER
	db 47, SURF
	db 54, GUILLOTINE
	db 60, HYDRO_PUMP
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WITHDRAW
	db 10, AURORA_BEAM
	db 14, ICY_WIND
	db 18, CLAMP
	db 22, BUBBLEBEAM
	db 28, ICE_BEAM
	db 34, HARDEN
	db 40, BLIZZARD
	db 47, HYDRO_PUMP
	db 54, EXPLOSION
	db 0

MissingNo8CEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SONICBOOM
	db 10, THUNDERSHOCK
	db 14, SCREECH
	db 18, DISCHARGE
	db 22, MAGNET_BOMB
	db 28, THUNDER_WAVE
	db 34, EXPLOSION
	db 40, THUNDERBOLT
	db 47, MIRROR_MOVE
	db 54, THUNDER
	db 54, EXPLOSION
	db 0

ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, DOUBLESLAP
	db 10, GROWL
	db 15, DRAINING_KISS
	db 20, SING
	db 25, METRONOME
	db 30, FAIRY_WIND
	db 35, DAZZLE_GLEAM
	db 42, CHARM
	db 50, MOONBLAST
	db 58, SOFTBOILED
	db 60, MOONBLAST
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SMOG
	db  9, POISON_GAS
	db 13, SLUDGE
	db 17, SMOKESCREEN
	db 22, ACID
	db 28, HAZE
	db 34, SLUDGE_WAVE
	db 40, GUNK_SHOT
	db 47, TOXIC
	db 54, EXPLOSION
	db 60, EXPLOSION
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, GROWL
	db  9, BITE
	db 13, PAY_DAY
	db 17, FURY_ATTACK
	db 22, FAINT_ATTACK
	db 28, HONE_CLAWS
	db 34, SLASH
	db 40, TAUNT
	db 47, NIGHT_SLASH
	db 54, BRUTAL_SWING
	db 60, BRUTAL_SWING
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, GROWL
	db  9, TAIL_WHIP
	db 13, BONE_CLUB
	db 17, HEADBUTT
	db 22, FOCUS_ENERGY
	db 28, BONEMERANG
	db 34, RAGE
	db 40, BULK_UP
	db 46, EARTHQUAKE
	db 47, FAINT_ATTACK
	db 54, DOUBLE_EDGE
	db 54, NIGHT_SLASH
	db 0

MissingNo92EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

HaunterEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, GENGAR
	db 0
; Learnset
	db  5, LICK
	db  9, SMOG
	db 13, ASTONISH
	db 17, CONFUSE_RAY
	db 22, NIGHT_SHADE
	db 28, SHADOW_SNEAK
	db 34, WILL_O_WISP
	db 40, SHADOW_BALL
	db 47, DARK_PULSE
	db 54, SHADOW_PUNCH
	db 60, DREAM_EATER
	db 0

AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, KADABRA
	db 0
; Learnset
	db  8, DISABLE
	db 12, PSYBEAM
	db 16, PSYCHIC_BIND
	db 20, DISABLE
	db 24, RECOVER
	db 28, REFLECT
	db 32, PSYBEAM
	db 38, CALM_MIND
	db 44, PSYCHIC_M
	db 50, MIND_BREAK
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
	db  8, DISABLE
	db 12, PSYBEAM
	db 16, PSYCHIC_BIND
	db 20, DISABLE
	db 24, RECOVER
	db 28, REFLECT
	db 32, PSYBEAM
	db 38, CALM_MIND
	db 44, PSYCHIC_M
	db 50, MIND_BREAK
	db 54, RECOVER
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, PIDGEOT
	db 0
; Learnset
	db  5, SAND_ATTACK
	db  9, QUICK_ATTACK
	db 13, TAILWIND
	db 17, WING_ATTACK
	db 20, AERIAL_ACE
	db 25, FAINT_ATTACK
	db 30, HONE_CLAWS
	db 35, FLY
	db 42, BRUTAL_SWING
	db 48, AGILITY
	db 55, SKY_ATTACK
	db 60, HURRICANE
	db 0

PidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SAND_ATTACK
	db  9, QUICK_ATTACK
	db 13, TAILWIND
	db 17, WING_ATTACK
	db 20, AERIAL_ACE
	db 25, FAINT_ATTACK
	db 30, HONE_CLAWS
	db 35, FLY
	db 42, BRUTAL_SWING
	db 48, AGILITY
	db 55, SKY_ATTACK
	db 60, HURRICANE
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WATER_GUN
	db 10, HARDEN
	db 14, BUBBLEBEAM
	db 18, FAINT_ATTACK
	db 22, RECOVER
	db 28, WATER_PULSE
	db 34, PSYBEAM
	db 40, ICY_WIND
	db 47, SURF
	db 54, PSYCHIC_M
	db 60, HYDRO_PUMP
	db 0

BulbasaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, IVYSAUR
	db 0
; Learnset
	db  4, VINE_WHIP
	db  8, LEECH_SEED
	db 12, POISONPOWDER
	db 16, GROWTH
	db 20, ABSORB
	db 24, SLEEP_POWDER
	db 28, RAZOR_LEAF
	db 32, MEGA_DRAIN
	db 38, SLUDGE
	db 42, GIGA_DRAIN
	db 48, PETAL_DANCE
	db 50, RECOVER
	db 0

VenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
	db  4, VINE_WHIP
	db  8, LEECH_SEED
	db 12, POISONPOWDER
	db 16, GROWTH
	db 20, ABSORB
	db 24, SLEEP_POWDER
	db 28, RAZOR_LEAF
	db 32, MEGA_DRAIN
	db 38, SLUDGE
	db 42, GIGA_DRAIN
	db 48, PETAL_DANCE
	db 50, RECOVER
	db 55, SOLARBEAM
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, POISON_STING
	db 10, SUPERSONIC
	db 14, WATER_GUN
	db 18, ACID
	db 22, BUBBLEBEAM
	db 28, BIND
	db 34, WATER_PULSE
	db 40, POISON_FANG
	db 47, SLUDGE_WAVE
	db 50, WRAP
	db 54, SURF
	db 60, HYDRO_PUMP
	db 0

MissingNo9CEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, SEAKING
	db 0
; Learnset
	db  5, WATER_GUN
	db  9, SUPERSONIC
	db 13, HORN_ATTACK
	db 17, BUBBLEBEAM
	db 22, FURY_ATTACK
	db 28, WATER_PULSE
	db 34, WATERFALL
	db 40, AGILITY
	db 47, SURF
	db 54, HORN_DRILL
	db 60, MEGAHORN
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, WATER_GUN
	db  9, SUPERSONIC
	db 13, HORN_ATTACK
	db 17, BUBBLEBEAM
	db 22, FURY_ATTACK
	db 28, WATER_PULSE
	db 34, WATERFALL
	db 40, AGILITY
	db 47, SURF
	db 54, HORN_DRILL
	db 60, MEGAHORN
	db 0

MissingNo9FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoA0EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoA1EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoA2EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PonytaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, RAPIDASH
	db 0
; Learnset
	db  5, EMBER
	db 10, TAIL_WHIP
	db 14, GROUND_STOMP
	db 18, FLAME_CHARGE
	db 22, AGILITY
	db 28, DOUBLE_KICK
	db 34, FIRE_BLAST
	db 34, TAKE_DOWN
	db 40, FLAMETHROWER
	db 47, DOUBLE_EDGE
	db 54, FIRE_BLAST
	db 0

RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, EMBER
	db 10, TAIL_WHIP
	db 14, GROUND_STOMP
	db 18, FLAME_CHARGE
	db 22, AGILITY
	db 28, DOUBLE_KICK
	db 34, FIRE_BLAST
	db 34, TAKE_DOWN
	db 40, FLAMETHROWER
	db 47, DOUBLE_EDGE
	db 54, FIRE_BLAST
	db 54, EXTREMESPEED
	db 60, FIRE_BLAST
	db 0

RattataEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, RATICATE
	db 0
; Learnset
	db  5, QUICK_ATTACK
	db  9, BITE
	db 13, FOCUS_ENERGY
	db 18, HYPER_FANG
	db 23, HEADBUTT
	db 28, SUPER_FANG
	db 34, CRUNCH
	db 40, BODY_SLAM
	db 47, DOUBLE_EDGE
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, QUICK_ATTACK
	db  9, BITE
	db 13, FOCUS_ENERGY
	db 18, HYPER_FANG
	db 23, HEADBUTT
	db 28, SUPER_FANG
	db 34, CRUNCH
	db 40, BODY_SLAM
	db 47, DOUBLE_EDGE
	db 54, NIGHT_SLASH
	db 0

NidorinoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOKING
	db 0
; Learnset
	db  5, LEER
	db  8, POISON_STING
	db 12, DOUBLE_KICK
	db 17, HORN_ATTACK
	db 23, POISON_FANG
	db 28, FOCUS_ENERGY
	db 34, TOXIC_FANGS
	db 40, BULLDOZE
	db 47, EARTHQUAKE
	db 54, GUNK_SHOT
	db 60, MEGAHORN
	db 0

NidorinaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOQUEEN
	db 0
; Learnset
	db  5, GROWL
	db  8, POISON_STING
	db 12, TAIL_WHIP
	db 17, BITE
	db 23, POISON_FANG
	db 28, FURY_ATTACK
	db 34, TOXIC_FANGS
	db 40, BODY_SLAM
	db 47, EARTHQUAKE
	db 54, CRUNCH
	db 60, SLUDGE_WAVE
	db 0

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GRAVELER
	db 0
	; Learnset
	db  5, DEFENSE_CURL
	db 10, ROCK_THROW
	db 14, MUD_SHOT
	db 18, ROCK_PUNCH
	db 22, BULLDOZE
	db 28, ROCK_TOMB
	db 34, DIG
	db 40, EARTHQUAKE
	db 47, ROCK_SLIDE
	db 54, HEAD_SMASH
	db 60, EXPLOSION
	db 0

PorygonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, AGILITY
	db 10, PSYBEAM
	db 14, RECOVER
	db 18, PSYCHIC_BIND
	db 22, SONICBOOM
	db 28, TRI_ATTACK
	db 34, DISCHARGE
	db 40, MAGNET_BOMB
	db 47, THUNDERBOLT
	db 54, MIRROR_MOVE
	db 60, HYPER_BEAM
	db 0

AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db  8, BITE
	db 12, ROCK_THROW
	db 17, FAINT_ATTACK
	db 22, AERIAL_ACE
	db 28, ROCK_TOMB
	db 34, TAKE_DOWN
	db 40, ROCK_SLIDE
	db 47, CRUNCH
	db 54, HEAD_SMASH
	db 60, HURRICANE
	db 66, SKY_ATTACK
	db 0

MissingNoACEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, MAGNETON
	db 0
; Learnset
	db  6, THUNDERSHOCK
	db 10, SUPERSONIC
	db 14, SONICBOOM
	db 18, THUNDER_WAVE
	db 22, DISCHARGE
	db 28, SCREECH
	db 34, BULLET_PUNCH
	db 40, MAGNET_BOMB
	db 46, THUNDERBOLT
	db 54, THUNDER
	db 0

MissingNoAEEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoAFEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

CharmanderEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, CHARMELEON
	db 0
; Learnset
	db  5, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, FLAME_BURST
	db 22, SLASH
	db 27, FLAMETHROWER
	db 32, CRUNCH
	db 37, DRAGON_BREATH
	db 45, FIRE_BLAST
	db 50, OUTRAGE
	db 0

SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, WARTORTLE
	db 0
; Learnset
	db  4, WATER_GUN
	db  8, WITHDRAW
	db 12, BITE
	db 16, BUBBLEBEAM
	db 20, ICY_WIND
	db 25, WATERFALL
	db 30, HARDEN
	db 35, SURF
	db 45, HYDRO_PUMP
	db 55, BIDE
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
	db  5, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, FLAME_BURST
	db 22, SLASH
	db 27, FLAMETHROWER
	db 32, CRUNCH
	db 37, DRAGON_BREATH
	db 45, FIRE_BLAST
	db 50, OUTRAGE
	db 0

WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
	db  4, WATER_GUN
	db  8, WITHDRAW
	db 12, BITE
	db 16, BUBBLEBEAM
	db 20, ICY_WIND
	db 25, WATERFALL
	db 30, HARDEN
	db 35, SURF
	db 45, HYDRO_PUMP
	db 55, BIDE
	db 0

CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, FLAME_BURST
	db 22, SLASH
	db 27, FLAMETHROWER
	db 32, CRUNCH
	db 36, WING_ATTACK
	db 37, DRAGON_BREATH
	db 41, AERIAL_ACE
	db 45, FIRE_BLAST
	db 50, OUTRAGE
	db 55, HURRICANE
	db 0

MissingNoB5EvosMoves:
; Evolutions
	db 0
; Learnset
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
	db EVOLVE_LEVEL, 22, GLOOM
	db 0
; Learnset
	db  5, ABSORB
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 18, MEGA_DRAIN
	db 22, ACID
	db 28, GROWTH
	db 34, GIGA_DRAIN
	db 40, SLUDGE
	db 48, PETAL_DANCE
	db 55, MOONBLAST
	db 0

GloomEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
	db  5, ABSORB
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 18, MEGA_DRAIN
	db 22, ACID
	db 28, GROWTH
	db 34, GIGA_DRAIN
	db 40, SLUDGE
	db 48, PETAL_DANCE
	db 55, MOONBLAST
	db 0

VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, ABSORB
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 18, MEGA_DRAIN
	db 22, ACID
	db 28, GROWTH
	db 34, GIGA_DRAIN
	db 40, SLUDGE
	db 40, POISONPOWDER
	db 47, SPORE
	db 48, PETAL_DANCE
	db 55, MOONBLAST
	db 0

BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, WEEPINBELL
	db 0
; Learnset
	db  5, VINE_WHIP
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 18, ACID
	db 22, WRAP
	db 28, GROWTH
	db 34, MEGA_DRAIN
	db 40, RAZOR_LEAF
	db 46, SLUDGE
	db 52, GIGA_DRAIN
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
	db  5, VINE_WHIP
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 18, ACID
	db 22, WRAP
	db 28, GROWTH
	db 34, MEGA_DRAIN
	db 40, RAZOR_LEAF
	db 46, SLUDGE
	db 52, GIGA_DRAIN
	db 0

VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, VINE_WHIP
	db 10, POISONPOWDER
	db 14, STUN_SPORE
	db 18, ACID
	db 22, WRAP
	db 28, GROWTH
	db 34, MEGA_DRAIN
	db 40, RAZOR_LEAF
	db 46, SLUDGE
	db 47, SLEEP_POWDER
	db 52, GIGA_DRAIN
	db 0
