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
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

NidoranMEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINO
	db 0
; Learnset
	db 0

ClefairyEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
	db 0

SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
	db 0

VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db 0

NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
	
SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

IvysaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, VENUSAUR
	db 0
; Learnset
	db 0

ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

LickitungEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
	db 0

GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, MUK
	db 0
; Learnset
	db 0

GengarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINA
	db 0
; Learnset
	db 0

NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, MAROWAK
	db 0
; Learnset
	db 0

RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, RHYDON
	db 0
; Learnset
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MewEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
	db 0

TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
	db 0

GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HAUNTER
	db 0
; Learnset
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, STARMIE
	db 0
; Learnset
	db 0

BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

OnixEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, PIDGEOTTO
	db 0
; Learnset
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, SLOWBRO
	db 0
; Learnset
	db 0

KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, ALAKAZAM
	db 0
; Learnset
	db 0

GravelerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, GOLEM
	db 0
; Learnset
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, MACHAMP
	db 0
; Learnset
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, GOLDUCK
	db 0
; Learnset
	db 0

DrowzeeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HYPNO
	db 0
; Learnset
	db 0

GolemEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, WEEZING
	db 0
; Learnset
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
	db 0

SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, DEWGONG
	db 0
; Learnset
	db 0

DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DUGTRIO
	db 0
; Learnset
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

VenonatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, VENOMOTH
	db 0
; Learnset
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, POLIWHIRL
	db 0
; Learnset
	db 0

JynxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

KrabbyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, KINGLER
	db 0
; Learnset
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
	db 0

NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

DragonairEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 48, DRAGONITE
	db 0
; Learnset
	db 0

KabutoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, KABUTOPS
	db 0
; Learnset
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, SEADRA
	db 0
; Learnset
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

OmanyteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, OMASTAR
	db 0
; Learnset
	db 0

OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

JigglypuffEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, WIGGLYTUFF
	db 0
; Learnset
	db 0

WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

EeveeEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, FLAREON
	db EVOLVE_ITEM, THUNDER_STONE, 1, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, 1, VAPOREON
	db 0
; Learnset
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, MACHOKE
	db 0
; Learnset
	db 0

ZubatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, GOLBAT
	db 0
; Learnset
	db 0

EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, ARBOK
	db 0
; Learnset
	db 0

ParasEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, PARASECT
	db 0
; Learnset
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, KAKUNA
	db 0
; Learnset
	db 0

KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BEEDRILL
	db 0
; Learnset
	db 0

BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BUTTERFREE
	db 0
; Learnset
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GYARADOS
	db 0
; Learnset
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
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, KADABRA
	db 0
; Learnset
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, PIDGEOT
	db 0
; Learnset
	db 0

PidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

BulbasaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, IVYSAUR
	db 0
; Learnset
	db 0

VenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

RattataEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, RATICATE
	db 0
; Learnset
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

NidorinoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOKING
	db 0
; Learnset
	db 0

NidorinaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOQUEEN
	db 0
; Learnset
	db 0

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GRAVELER
	db 0
	; Learnset
	db 0

PorygonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, WARTORTLE
	db 0
; Learnset
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
	db 0

WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
	db 0

CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
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
	db 0

GloomEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
	db 0

VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, WEEPINBELL
	db 0
; Learnset
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
	db 0

VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
