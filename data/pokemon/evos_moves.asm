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
	dw NoEvosMoves
	dw NoEvosMoves
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
	dw NoEvosMoves
	dw MagmarEvosMoves
	dw NoEvosMoves
	dw ElectabuzzEvosMoves
	dw MagnetonEvosMoves
	dw KoffingEvosMoves
	dw NoEvosMoves
	dw MankeyEvosMoves
	dw SeelEvosMoves
	dw DiglettEvosMoves
	dw TaurosEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw FarfetchdEvosMoves
	dw VenonatEvosMoves
	dw DragoniteEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw DoduoEvosMoves
	dw PoliwagEvosMoves
	dw JynxEvosMoves
	dw MoltresEvosMoves
	dw ArticunoEvosMoves
	dw ZapdosEvosMoves
	dw DittoEvosMoves
	dw MeowthEvosMoves
	dw KrabbyEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw VulpixEvosMoves
	dw NinetalesEvosMoves
	dw PikachuEvosMoves
	dw RaichuEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw DratiniEvosMoves
	dw DragonairEvosMoves
	dw KabutoEvosMoves
	dw KabutopsEvosMoves
	dw HorseaEvosMoves
	dw SeadraEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
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
	dw NoEvosMoves
	dw DodrioEvosMoves
	dw PrimeapeEvosMoves
	dw DugtrioEvosMoves
	dw VenomothEvosMoves
	dw DewgongEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw CaterpieEvosMoves
	dw MetapodEvosMoves
	dw ButterfreeEvosMoves
	dw MachampEvosMoves
	dw NoEvosMoves
	dw GolduckEvosMoves
	dw HypnoEvosMoves
	dw GolbatEvosMoves
	dw MewtwoEvosMoves
	dw SnorlaxEvosMoves
	dw MagikarpEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw MukEvosMoves
	dw NoEvosMoves
	dw KinglerEvosMoves
	dw CloysterEvosMoves
	dw NoEvosMoves
	dw ElectrodeEvosMoves
	dw ClefableEvosMoves
	dw WeezingEvosMoves
	dw PersianEvosMoves
	dw MarowakEvosMoves
	dw NoEvosMoves
	dw HaunterEvosMoves
	dw AbraEvosMoves
	dw AlakazamEvosMoves
	dw PidgeottoEvosMoves
	dw PidgeotEvosMoves
	dw StarmieEvosMoves
	dw BulbasaurEvosMoves
	dw VenusaurEvosMoves
	dw TentacruelEvosMoves
	dw NoEvosMoves
	dw GoldeenEvosMoves
	dw SeakingEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw PonytaEvosMoves
	dw RapidashEvosMoves
	dw RattataEvosMoves
	dw RaticateEvosMoves
	dw NidorinoEvosMoves
	dw NidorinaEvosMoves
	dw GeodudeEvosMoves
	dw PorygonEvosMoves
	dw AerodactylEvosMoves
	dw NoEvosMoves
	dw MagnemiteEvosMoves
	dw NoEvosMoves
	dw NoEvosMoves
	dw CharmanderEvosMoves
	dw SquirtleEvosMoves
	dw CharmeleonEvosMoves
	dw WartortleEvosMoves
	dw CharizardEvosMoves
	dw NoEvosMoves
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

BulbasaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, IVYSAUR
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pure Grass — no Poison moves (no glands yet,
; bulb closed). No Stun Spore per Forte's powder table (Venusaur = Poison +
; Sleep, NO Stun; uniform within line). Single signature SOLARBEAM kept on
; Venusaur only (full bloom concentrates light).
	db  4, VINE_WHIP
	db  8, LEECH_SEED
	db 12, GROWTH
	db 20, ABSORB
	db 25, SLEEP_POWDER
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 42, GIGA_DRAIN
	db 48, RECOVER
	db 55, PETAL_DANCE
	db 0

IvysaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, VENUSAUR
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Grass/Poison — bulb open, poison glands active.
; Adds 3 Poison moves over Bulbasaur (POISONPOWDER, ACID, TOXIC). Sludge
; dropped — plant biology doesn't fit "sludge/blob" framing (those are
; Muk/Weezing-coded). Same powder rule: no STUN_POWDER.
	db  4, VINE_WHIP
	db  8, LEECH_SEED
	db 12, GROWTH
	db 19, POISONPOWDER
	db 20, ABSORB
	db 25, SLEEP_POWDER
	db 28, ACID
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 42, GIGA_DRAIN
	db 48, RECOVER
	db 52, TOXIC
	db 55, PETAL_DANCE
	db 0

VenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): same backbone as Ivysaur (uniformity rule),
; adds SOLARBEAM as the line's single signature — full bloom of the flower
; concentrates sunlight enough to fire a beam. GUNK_SHOT removed (signature
; of Muk/Weezing). DAZZLE_GLEAM not added (Fairy-coded shimmer; Venusaur is
; plant, not magical creature).
	db  4, VINE_WHIP
	db  8, LEECH_SEED
	db 12, GROWTH
	db 19, POISONPOWDER
	db 20, ABSORB
	db 25, SLEEP_POWDER
	db 28, ACID
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 42, GIGA_DRAIN
	db 48, RECOVER
	db 52, TOXIC
	db 55, PETAL_DANCE
	db 60, SOLARBEAM
	db 0

CharmanderEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, CHARMELEON
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pure FIRE baby. Shared backbone with the
; whole line by uniformity rule. Anatomical exclusions: small teeth (no
; CRUNCH — Charizard exclusive), no wings (no WING_ATTACK/FLY/AERIAL_ACE/
; HURRICANE), throat too small for breath weapon (DRAGON_RAGE here, not
; DRAGON_BREATH which is Charizard exclusive). FLAME_CHARGE reserved for
; fast-fire quadrupeds (Growlithe/Ponyta lines per Forte). Outrage moved
; to TM55 only.
	db  5, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, HEADBUTT
	db 20, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 37, FLAMETHROWER
	db 42, DRAGON_CLAW
	db 48, DRAGON_RAGE
	db 52, FIRE_BLAST
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): same backbone as Charmander (uniformity rule).
; Still no wings, no big jaw, no breath weapon — Charizard gets all those
; via anatomical exception.
	db  5, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, HEADBUTT
	db 20, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 37, FLAMETHROWER
	db 42, DRAGON_CLAW
	db 48, DRAGON_RAGE
	db 52, FIRE_BLAST
	db 0

CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): full dragon-form. Adds 5 anatomical
; exclusives over Char/Charme: WING_ATTACK / FLY / AERIAL_ACE / HURRICANE
; (wings now developed; Forte's natural-FLY learner) and CRUNCH (big jaw).
; L48 substitutes the line's DRAGON_RAGE with DRAGON_BREATH — Charizard's
; throat capacity supports a full breath weapon, smaller Char/Charme don't.
; All entry levels unique (rule #7).
	db  5, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, HEADBUTT
	db 20, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 36, WING_ATTACK
	db 37, FLAMETHROWER
	db 38, FLY
	db 40, CRUNCH
	db 42, DRAGON_CLAW
	db 46, AERIAL_ACE
	db 48, DRAGON_BREATH
	db 52, FIRE_BLAST
	db 60, HURRICANE
	db 0

SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, WARTORTLE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pure WATER baby turtle. Shared backbone with
; the whole line. No AQUA_JET (turtle slow), no HARDEN (Forte: weak +
; redundant with WITHDRAW), no HYDRO_PUMP (anatomical: no shell-cannons
; until Blastoise). BIDE moved early (Forte: bad move, get out of late
; slot). HEADBUTT moved earlier per Forte. ICY_WIND replaced with WATER_
; PULSE (turtles don't make wind). BODY_SLAM added — prerequisite for
; HEAVY_SLAM that Blastoise gets exclusively.
	db  4, WATER_GUN
	db  8, WITHDRAW
	db 10, BIDE
	db 12, BITE
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 32, WATERFALL
	db 42, BODY_SLAM
	db 48, SURF
	db 0

WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): same backbone as Squirtle (uniformity rule).
; Still no shell-cannons → no HYDRO_PUMP. Blastoise gets cannons + jaw
; growth + massive size via anatomical exception.
	db  4, WATER_GUN
	db  8, WITHDRAW
	db 10, BIDE
	db 12, BITE
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 32, WATERFALL
	db 42, BODY_SLAM
	db 48, SURF
	db 0

BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): full tank apex. Adds 5 anatomical exclusives
; over Squirtle/Wartortle: HYDRO_PUMP at L36 (signature on evolution —
; cannons developed), CRUNCH (big jaw), HEAVY_SLAM (massive frame — needs
; BODY_SLAM as prerequisite, which is shared at L42), HEAD_SMASH (signature
; shell-head bash — vanilla Skull Bash equivalent), EARTHQUAKE (massive
; footsteps shake earth). All entry levels unique (rule #7).
	db  4, WATER_GUN
	db  8, WITHDRAW
	db 10, BIDE
	db 12, BITE
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 32, WATERFALL
	db 36, HYDRO_PUMP
	db 40, CRUNCH
	db 42, BODY_SLAM
	db 46, HEAVY_SLAM
	db 48, SURF
	db 52, HEAD_SMASH
	db 60, EARTHQUAKE
	db 0

CaterpieEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, METAPOD
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): joke-tier baby caterpillar. Shared with the
; whole line. STRING_SHOT moved L1 → L7 (1 level before evo at L8 — earned
; just before graduating to cocoon).
	db  4, BUG_BITE
	db  7, STRING_SHOT
	db  9, LEECH_LIFE
	db 13, BIDE
	db 0

MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BUTTERFREE
	db 0
; Learnset
; v0.7 Pass 3: cocoon. Same 4 shared entries as Caterpie (uniformity rule).
; All real growth happens after evolving to Butterfree.
	db  4, BUG_BITE
	db  7, STRING_SHOT
	db  9, LEECH_LIFE
	db 13, BIDE
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: butterfly with Bug/Psychic typing (antennae). Shared 4 +
; 10 exclusives (wings, powders, psychic awakens). All 3 powders per
; Forte's powder table. Hurricane reserved as final move (Forte: "as
; last move"). Quiver Dance late game (signature moth/butterfly dance,
; new SPECIAL_SPEED_UP1_EFFECT after engine update). Added FAIRY_WIND and HURRICANE.
	db  4, BUG_BITE
	db  7, STRING_SHOT
	db  9, LEECH_LIFE
	db 11, GUST
	db 13, CONFUSION
	db 14, POISONPOWDER
	db 17, STUN_POWDER
	db 20, SLEEP_POWDER
	db 22, FAIRY_WIND
	db 26, EXTRASENSORY
	db 28, WING_ATTACK
	db 30, BUG_BUZZ
	db 33, PSYCHIC_BIND
	db 36, PSYCHIC_M
	db 42, QUIVER_DANCE
	db 48, HURRICANE
	db 0

WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, KAKUNA
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): joke-tier baby spike-bug. Shared with the
; whole line. STRING_SHOT moved L1 → L7 (1 level before evo at L8). L4
; replaced with POISON_STING per Forte (FURY_ATTACK dropped from shared,
; reserved for Beedrill's twin-needle frenzy at L15).
	db  4, POISON_STING
	db  7, STRING_SHOT
	db  9, BUG_BITE
	db 13, BIDE
	db 0

KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BEEDRILL
	db 0
; Learnset
; v0.7 Pass 3: cocoon. Same 4 shared entries as Weedle (uniformity rule).
; All growth happens after evolving to Beedrill.
	db  4, POISON_STING
	db  7, STRING_SHOT
	db  9, BUG_BITE
	db 13, BIDE
	db 0

BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (one of Forte's favorite mon — gets the deepest movepool of the
; line). Shared 4 + 16 exclusives. NO powders (Forte's powder table).
; NO Sludge / Gunk Shot / Toxic Fangs / Megahorn (anatomical: stinger
; bee, not blob/fanged/horned mon). Twin Needle = signature on evo.
; Fury Attack at L15 with RAGE (Forte explicit same-level exception —
; one of the line's "small number of exceptions"). Neurotoxin
; at L48 is real-world bee venom biology.
	db  4, POISON_STING
	db  7, STRING_SHOT
	db  9, BUG_BITE
	db 11, TWINEEDLE
	db 13, BIDE
	db 15, RAGE
	db 15, FURY_ATTACK
	db 18, HORN_ATTACK
	db 20, LEECH_LIFE
	db 22, HONE_CLAWS
	db 25, FOCUS_ENERGY
	db 27, QUICK_ATTACK
	db 30, AGILITY
	db 33, INTIMIDATE
	db 36, BUG_BUZZ
	db 40, AERIAL_ACE
	db 42, DOUBLE_EDGE
	db 48, NEUROTOXIN
	db 52, DRILL_PECK
	db 60, EXTREMESPEED
	db 0

PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, PIDGEOTTO
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): peaceful raptor line. PECK before GUST per
; power-progression rule (35 BP < 45 BP). No FAINT_ATTACK / BRUTAL_SWING
; / NIGHT_SLASH (those are Spearow line — honorary Dark). No AGILITY (not
; on Forte's natural list — Pidgeot only via TM). No HONE_CLAWS / SLASH /
; TAKE_DOWN / INTIMIDATE on Pidgey baby (anatomical: small talons, light
; body, not menacing).
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, QUICK_ATTACK
	db 14, GUST
	db 18, LEER
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 30, AERIAL_ACE
	db 35, FLY
	db 42, HURRICANE
	db 50, SKY_ATTACK
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, PIDGEOT
	db 0
; Learnset
; v0.7 Pass 3: medium hawk. Same shared backbone as Pidgey + 2 anatomical
; exclusives (HONE_CLAWS, SLASH) — medium-grown talons.
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, QUICK_ATTACK
	db 14, GUST
	db 18, LEER
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 30, AERIAL_ACE
	db 34, HONE_CLAWS
	db 35, FLY
	db 38, SLASH
	db 42, HURRICANE
	db 50, SKY_ATTACK
	db 0

PidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: apex eagle/falcon (mach-2 raptor per Pokédex). Pidgeotto's
; learnset + 2 apex-only exclusives (TAKE_DOWN per Forte, INTIMIDATE — full-
; grown menacing presence).
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, QUICK_ATTACK
	db 14, GUST
	db 18, LEER
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 30, AERIAL_ACE
	db 34, HONE_CLAWS
	db 35, FLY
	db 38, SLASH
	db 42, HURRICANE
	db 44, TAKE_DOWN
	db 46, INTIMIDATE
	db 50, SKY_ATTACK
	db 0

RattataEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, RATICATE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Normal-type rodent, sharp-fanged. HYPER_FANG
; at L20 (evo level — signature on graduation to Raticate per Forte). Adds
; per Forte: RAGE (rodent rage), HONE_CLAWS (rodent claws sharpen),
; POISON_FANG (rats carry disease — STAB-less but anatomically plausible),
; CUT (sharp teeth/claws), FAINT_ATTACK (sneaky rat strike — Dark, no STAB
; for Rattata but Raticate gets STAB).
	db  4, QUICK_ATTACK
	db  7, BITE
	db  8, ASTONISH
	db 10, FOCUS_ENERGY
	db 13, FAINT_ATTACK
	db 16, RAGE
	db 20, HYPER_FANG
	db 23, HEADBUTT
	db 25, CUT
	db 26, AGILITY
	db 29, HONE_CLAWS
	db 32, SUPER_FANG
	db 36, CRUNCH
	db 40, POISON_FANG
	db 44, BODY_SLAM
	db 52, DOUBLE_EDGE
	db 55, TOXIC_FANGS
	db 60, EXTREMESPEED
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: Normal/Dark — matured rodent. Rattata's 15 + 3 anatomical
; exclusives (Dark unlock + matured claws): SLASH (per Forte — any mon with
; NIGHT_SLASH also has SLASH), NIGHT_SLASH (Dark high-crit), BRUTAL_SWING
; (Dark physical — replaces DARK_PULSE per Forte since Raticate is physical
; attacker, not special).
	db  4, QUICK_ATTACK
	db  7, BITE
	db  8, ASTONISH
	db 10, FOCUS_ENERGY
	db 13, FAINT_ATTACK
	db 16, RAGE
	db 20, HYPER_FANG
	db 23, HEADBUTT
	db 25, CUT
	db 26, AGILITY
	db 29, HONE_CLAWS
	db 32, SUPER_FANG
	db 36, CRUNCH
	db 37, SLASH
	db 40, POISON_FANG
	db 44, BODY_SLAM
	db 45, NIGHT_SLASH
	db 52, DOUBLE_EDGE
	db 54, BRUTAL_SWING
	db 55, TOXIC_FANGS
	db 60, EXTREMESPEED
	db 0

SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): honorary Dark/Flying — aggressive bird-of-
; prey. Includes 3 Dark moves (FAINT_ATTACK, NIGHT_SLASH, BRUTAL_SWING).
; NO HURRICANE per Forte (no GUST progression — keeps line distinct from
; Pidgey). WING_ATTACK at L20 (evo level). BRUTAL_SWING moved much higher.
	db  4, PECK
	db  8, LEER
	db 11, QUICK_ATTACK
	db 15, FURY_ATTACK
	db 20, WING_ATTACK
	db 23, FAINT_ATTACK
	db 27, AERIAL_ACE
	db 31, NIGHT_SLASH
	db 36, HONE_CLAWS
	db 42, BRUTAL_SWING
	db 52, SKY_ATTACK
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: apex predator. Spearow's 11 + 3 anatomical exclusives:
; DRILL_PECK signature (long beak as drill), GORE_ATTACK (Dark — beak gore,
; Fearow scarier), INTIMIDATE (massive raptor presence).
	db  4, PECK
	db  8, LEER
	db 11, QUICK_ATTACK
	db 15, FURY_ATTACK
	db 20, WING_ATTACK
	db 23, FAINT_ATTACK
	db 27, AERIAL_ACE
	db 31, NIGHT_SLASH
	db 36, HONE_CLAWS
	db 40, DRILL_PECK
	db 42, BRUTAL_SWING
	db 46, GORE_ATTACK
	db 50, INTIMIDATE
	db 52, SKY_ATTACK
	db 0

EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, ARBOK
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Poison snake. Forte loves snakes — gets the
; deepest movepool of the trio. Adds: QUICK_ATTACK (very early), CONSTRICT
; (basic squeeze), BIND (heavy strangle), BIDE (coil-and-counter),
; SUBSTITUTE (snake shed-skin per Forte's natural list), AGILITY (Forte's
; natural — fast strike), FAINT_ATTACK (Dark sneaky), HINDER (snake threat),
; SHADOW_SNEAK (Ghost — snake hides in shadow), NEUROTOXIN (Forte added
; Ekans to the prior Muk/Weezing/Tentacruel/Arbok list), EXTREMESPEED
; (high-level peak strike). NO GUNK_SHOT (Muk/Weezing only). NO SLUDGE_WAVE
; (also Muk-only). NO SCREECH (snakes hiss, not screech).
	db  4, QUICK_ATTACK
	db  7, CONSTRICT
	db 10, WRAP
	db 11, BIDE
	db 13, BITE
	db 16, LEER
	db 17, ASTONISH
	db 19, POISON_STING
	db 20, COIL
	db 22, BIND
	db 28, GLARE
	db 31, SUBSTITUTE
	db 34, POISON_FANG
	db 37, AGILITY
	db 40, FAINT_ATTACK
	db 46, SHADOW_SNEAK
	db 50, TOXIC_FANGS
	db 54, TOXIC
	db 57, NEUROTOXIN
	db 60, EXTREMESPEED
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: Poison/Dark — matured cobra. Ekans's 20 + 4 anatomical
; exclusives (cobra hood + Dark unlock + bigger jaw + heavy whip-tail):
; SCARY_FACE (per Forte at L21 — evo level, hood reveal), CRUNCH (per
; Forte — bigger jaw), IRON_TAIL (per Forte — high-level whip), INTIMIDATE
; (full hood display). Removed prior duplicate WRAP (was vanilla bug),
; GUNK_SHOT (Muk-only), SLUDGE_WAVE (Muk-only).
	db  4, QUICK_ATTACK
	db  7, CONSTRICT
	db 10, WRAP
	db 11, BIDE
	db 13, BITE
	db 16, LEER
	db 17, ASTONISH
	db 19, POISON_STING
	db 20, COIL
	db 21, SCARY_FACE
	db 22, BIND
	db 28, GLARE
	db 31, SUBSTITUTE
	db 34, POISON_FANG
	db 37, AGILITY
	db 40, FAINT_ATTACK
	db 46, SHADOW_SNEAK
	db 48, CRUNCH
	db 50, TOXIC_FANGS
	db 54, TOXIC
	db 55, INTIMIDATE
	db 57, NEUROTOXIN
	db 60, EXTREMESPEED
	db 0

PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Electric mouse. Power-progression: NUZZLE
; (35 BP) before THUNDERSHOCK (55 BP). CHARM mid (cute mouse). VOLT_TACKLE
; signature at L23 (Pichu egg-move lore — both Pikachu/Raichu learn at
; same level per Forte's simplification).
	db  4, NUZZLE
	db  7, TAIL_WHIP
	db 10, QUICK_ATTACK
	db 13, THUNDERSHOCK
	db 15, CHARM
	db 17, THUNDER_WAVE
	db 21, SHOCK_WAVE
	db 23, VOLT_TACKLE
	db 25, AGILITY
	db 30, IRON_TAIL
	db 36, THUNDERBOLT
	db 42, BODY_SLAM
	db 48, EXTREMESPEED
	db 55, THUNDER
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: bigger orange mouse. Same shared backbone as Pikachu (per
; Forte: "raichu aprende-o ao mesmo lvl que o pikachu" for VOLT_TACKLE
; — simpler than the L1-Move-Reminder trick). Adds DOUBLE_EDGE (bigger
; reckless body — anatomical exclusive).
	db  4, NUZZLE
	db  7, TAIL_WHIP
	db 10, QUICK_ATTACK
	db 13, THUNDERSHOCK
	db 15, CHARM
	db 17, THUNDER_WAVE
	db 21, SHOCK_WAVE
	db 23, VOLT_TACKLE
	db 25, AGILITY
	db 30, IRON_TAIL
	db 36, THUNDERBOLT
	db 42, BODY_SLAM
	db 48, EXTREMESPEED
	db 52, DOUBLE_EDGE
	db 55, THUNDER
	db 0

SandshrewEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, SANDSLASH
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): armadillo armoured Ground digger. DEFENSE_CURL
; (Forte sec F list — ball-shape). MUD_SHOT em vez de GROUND_STOMP (Forte:
; "GROUND_STOMP demasiado pequeno"). SLASH a L22 = ao evo (claws apex
; aparecem); HONE_CLAWS imediatamente depois (Forte). Removido FISSURE
; (Forte sec G — só Diglett-line + Onix; reservado para Sandslash apex).
; STRENGTH NÃO (Sandshrew/Sandslash não estão na HM04 list).
	db  4, SCRATCH
	db  7, DEFENSE_CURL
	db 10, MUD_SHOT
	db 13, SAND_ATTACK
	db 18, BULLDOZE
	db 22, SLASH
	db 23, HONE_CLAWS
	db 30, DIG
	db 36, MUD_BOMB
	db 44, EARTHQUAKE
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex armoured digger. 10 backbone + 6 Sandslash-
; exclusives: CUT (HM01 natural), IRON_DEFENSE (Forte: substitui SWORDS_DANCE
; — Sandslash defensive armoured não setup attacker), ROCK_TOMB (Forte add
; — armoured digger Rock affinity), NIGHT_SLASH (Forte: high-level claws
; apex), GORE_ATTACK (Forte explicit L55-56), FISSURE (Forte: substitui
; BRUTAL_SWING como last move; reavaliação — apex deep-dig finisher).
	db  4, SCRATCH
	db  7, DEFENSE_CURL
	db 10, MUD_SHOT
	db 13, SAND_ATTACK
	db 18, BULLDOZE
	db 22, SLASH
	db 23, HONE_CLAWS
	db 30, DIG
	db 36, CUT
	db 36, MUD_BOMB
	db 42, IRON_DEFENSE
	db 44, EARTHQUAKE
	db 48, ROCK_TOMB
	db 52, NIGHT_SLASH
	db 56, GORE_ATTACK
	db 60, FISSURE
	db 0

NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINA
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): defensive female juvenile, fairy-tinged. 11
; shared moves Nidorina+Nidoqueen inherit. SAND_ATTACK basic; BIDE (swap
; from FURY_ATTACK per Forte F#5); HEADBUTT (Forte F-old); FAIRY_WIND at
; L17 (= evo level per Forte F#1, fairy gift on evolution); TOXIC_FANGS
; capstone late per Forte (F#4). NO SCRATCH (Forte F-old). NO BULLDOZE/
; GROUND_STOMP/CRUNCH in shared (Forte F#3 — mid-evo + Queen exclusivity).
	db  4, GROWL
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, TAIL_WHIP
	db 16, BITE
	db 17, FAIRY_WIND
	db 19, BIDE
	db 22, HEADBUTT
	db 25, POISON_FANG
	db 28, BODY_SLAM
	db 40, TOXIC_FANGS
	db 50, TOXIC
	db 0

NidorinaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOQUEEN
	db 0
; Learnset
; v0.7 Pass 3 (Forte review + ba9e751 polish): mid-stage female, chemical
; ground attacker. Shared Nidoran♀ base + Nidorina+Nidoqueen exclusives:
; ACID at L24 (Forte F#7 — F-only balance, glandular chemistry), TAKE_
; DOWN, MUD_SHOT at L33 (Forte ba9e751: replaced GROUND_STOMP — F-line
; mud-thrower instead of stomp), PLAY_ROUGH at L35 (= evo level, fairy
; gift on evolution), TOXIC_FANGS, MUD_BOMB (Forte ba9e751 add), TOXIC,
; NEUROTOXIN (per Forte's neurotoxin list — F-line gets it). NO BULLDOZE/
; EARTHQUAKE/CRUNCH/STRENGTH (Nidoqueen-only per Forte).
	db  4, GROWL
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, TAIL_WHIP
	db 16, BITE
	db 17, FAIRY_WIND
	db 19, BIDE
	db 22, HEADBUTT
	db 24, ACID
	db 25, POISON_FANG
	db 28, BODY_SLAM
	db 30, TAKE_DOWN
	db 33, MUD_SHOT
	db 35, PLAY_ROUGH
	db 40, TOXIC_FANGS
	db 46, MUD_BOMB
	db 50, TOXIC
	db 55, NEUROTOXIN
	db 0

NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review + ba9e751 polish): matriarch, fairy + ground
; apex. Inherits all Nidoran♀+Nidorina entries; adds Nidoqueen-only:
; CHARM at L36 (Forte F#3 — após L36 evo line ref), BULLDOZE at L42
; (Forte ba9e751 — Nidoqueen-only ground move), TOXIC, STRENGTH (Forte
; F#8). EARTHQUAKE removed from levelup (Forte ba9e751 — accessible via
; TM50 only). CRUNCH removed from levelup (Forte ba9e751 cleanup). NO
; MEGAHORN/OUTRAGE/THRASH/GORE_ATTACK/BRUTAL_SWING (M-only apex moves).
	db  4, GROWL
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, TAIL_WHIP
	db 16, BITE
	db 17, FAIRY_WIND
	db 19, BIDE
	db 22, HEADBUTT
	db 24, ACID
	db 25, POISON_FANG
	db 28, BODY_SLAM
	db 30, TAKE_DOWN
	db 33, MUD_SHOT
	db 35, PLAY_ROUGH
	db 36, CHARM
	db 40, TOXIC_FANGS
	db 42, BULLDOZE
	db 46, MUD_BOMB
	db 50, TOXIC
	db 52, STRENGTH
	db 55, NEUROTOXIN
	db 0

NidoranMEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINO
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): aggressive male juvenile, single-horn. 11
; shared moves Nidorino+Nidoking inherit. POISON_STING+SAND_ATTACK basic
; toolkit; FURY_ATTACK early per Forte (#3) to match F line; POISON_FANG/
; BODY_SLAM mid-tier; HORN_CHARGE late as adult-horn move; TOXIC_FANGS
; capstone late per Forte (#12). NO DOUBLE_KICK.
	db  4, LEER
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, BITE
	db 17, HORN_ATTACK
	db 19, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 25, POISON_FANG
	db 28, BODY_SLAM
	db 37, HORN_CHARGE
	db 44, TOXIC_FANGS
	db 0

NidorinoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOKING
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mid-stage male, mature horn, learns
; aggression primitives. Shared Nidoran♂ base + 4 exclusives shared with
; Nidoking: TAKE_DOWN, GROUND_STOMP earlier per Forte (#1 — Nidorino+
; Nidoking exclusive), RAGE at L35 (Forte #4 — = evo level), FIERCE_ROAR
; at L36 (Forte #2 + Forte #6 — now Nidorino too, was Nidoking-only).
	db  4, LEER
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, BITE
	db 17, HORN_ATTACK
	db 19, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 25, POISON_FANG
	db 28, BODY_SLAM
	db 30, TAKE_DOWN
	db 34, GROUND_STOMP
	db 35, RAGE
	db 36, FIERCE_ROAR
	db 37, HORN_CHARGE
	db 44, TOXIC_FANGS
	db 0

NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex predator male, full kit. Inherits all
; Nidoran♂+Nidorino entries; adds 8 Nidoking-only: BULLDOZE (Forte #2 —
; Nidoking-only not shared, depois de GROUND_STOMP for power progression
; 35→65 BP), CRUNCH antes de STRENGTH (Forte #1), EARTHQUAKE, THRASH
; (swap from MEGAHORN per Forte #9 — MEGAHORN só TM agora), BRUTAL_SWING
; + GORE_ATTACK (Forte #5 high-level apex), OUTRAGE final L65 per Forte
; (#2 spacing 3-em-3 com gap final). NO HORN_DRILL (Forte #7).
	db  4, LEER
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, BITE
	db 17, HORN_ATTACK
	db 19, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 25, POISON_FANG
	db 28, BODY_SLAM
	db 30, TAKE_DOWN
	db 34, GROUND_STOMP
	db 35, RAGE
	db 36, FIERCE_ROAR
	db 37, HORN_CHARGE
	db 38, BULLDOZE
	db 41, CRUNCH
	db 43, STRENGTH
	db 44, TOXIC_FANGS
	db 46, EARTHQUAKE
	db 49, THRASH
	db 52, TOXIC
	db 55, BRUTAL_SWING
	db 58, GORE_ATTACK
	db 65, OUTRAGE
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

VulpixEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NINETALES
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): kitsune raposa Fire-Fairy-coded. WILL_O_WISP
; (Ghost) preferido sobre IGNITE (Fire) por anatomia — Vulpix não tem chama
; "aberta" como Charmander/Magmar; sua Fire é spectral kitsune. NIGHT_SHADE/
; FAINT_ATTACK/AGILITY adicionados (Forte). FLAME_CHARGE removido (muito
; físico para ser sensível/elegante de ataque à distância). DAZZLE_GLEAM
; reservado para Ninetales-only.
	db  4, TAIL_WHIP
	db  7, EMBER
	db 11, QUICK_ATTACK
	db 14, CONFUSE_RAY
	db 17, FAIRY_WIND
	db 20, NIGHT_SHADE
	db 24, FAINT_ATTACK
	db 28, AGILITY
	db 32, WILL_O_WISP
	db 40, FLAMETHROWER
	db 48, FIRE_BLAST
	db 0

NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex kitsune. 11 shared backbone + 4 exclusives:
; EERIE_IMPULSE (uncanny mature kitsune), DAZZLE_GLEAM (Fairy mid-apex),
; SHADOW_BALL (Ghost-coded — many tails channel spectral), MOONBLAST (lunar
; signature). Sem FLASH (Forte: removido — não necessário com EERIE_IMPULSE
; já a cobrir o slot de mid-game utility).
	db  4, TAIL_WHIP
	db  7, EMBER
	db 11, QUICK_ATTACK
	db 14, CONFUSE_RAY
	db 17, FAIRY_WIND
	db 20, NIGHT_SHADE
	db 24, FAINT_ATTACK
	db 28, AGILITY
	db 32, WILL_O_WISP
	db 36, EERIE_IMPULSE
	db 40, FLAMETHROWER
	db 44, DAZZLE_GLEAM
	db 48, FIRE_BLAST
	db 52, SHADOW_BALL
	db 60, MOONBLAST
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

ZubatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, GOLBAT
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): vampire bat. Drain progression per Forte:
; BITE → ABSORB → LEECH_LIFE. WING_ATTACK at L21 (evo level per Forte).
; TOXIC after TOXIC_FANGS (progression per Forte). NO SLUDGE (Muk-only).
; NO HURRICANE in levelup (Forte: Golbat TM only). Adds: ABSORB,
; QUICK_ATTACK, POISON_STING, ASTONISH, AGILITY (Forte's natural list).
	db  4, BITE
	db  7, QUICK_ATTACK
	db 11, ABSORB
	db 13, POISON_STING
	db 14, SUPERSONIC
	db 17, LEECH_LIFE
	db 20, ASTONISH
	db 21, WING_ATTACK
	db 24, EERIE_IMPULSE
	db 30, AGILITY
	db 34, AERIAL_ACE
	db 40, POISON_FANG
	db 46, TOXIC_FANGS
	db 52, TOXIC
	db 60, EXTREMESPEED
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: matured vampire bat. Zubat's 14 + 4 anatomical exclusives
; (bigger wings + can carry rider + sinister vibe + eerie bat): SCREECH
; (vanilla L1, moved to levelup L26), FLY (Forte's natural list — Golbat
; only, Zubat too small), DARK_PULSE (vampire-bat sinister), EERIE_IMPULSE
; (per Forte #19 — eerie bat). NO HURRICANE in levelup (Forte: TM only).
	db  4, BITE
	db  7, QUICK_ATTACK
	db 11, ABSORB
	db 13, POISON_STING
	db 14, SUPERSONIC
	db 17, LEECH_LIFE
	db 20, ASTONISH
	db 21, WING_ATTACK
	db 24, EERIE_IMPULSE
	db 26, SCREECH
	db 30, AGILITY
	db 34, AERIAL_ACE
	db 36, FLY
	db 40, POISON_FANG
	db 42, DARK_PULSE
	db 46, TOXIC_FANGS
	db 52, TOXIC
	db 60, EXTREMESPEED
	db 0

OddishEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, GLOOM
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): basic radish/turnip plant (Grass/Poison). 11
; shared (Forte's order). STUN_POWDER+SLEEP_POWDER+POISONPOWDER triad
; emerges before/at evo (POISONPOWDER at L22 = evo level, signature na evo
; — full powder kit complete by Gloom). LEECH_SEED + drain + apex PETAL_
; DANCE. NO MOONBLAST (per Forte: Clefairy/Mew only). NO TOXIC (Gloom-
; tier per Forte). NO BODY_SLAM/HEAVY_SLAM/SOLARBEAM in levelup.
	db  4, ABSORB
	db  7, GROWL
	db 10, GROWTH
	db 13, TACKLE
	db 16, STUN_POWDER
	db 19, SLEEP_POWDER
	db 22, POISONPOWDER
	db 25, ACID
	db 28, LEECH_SEED
	db 34, MEGA_DRAIN
	db 46, PETAL_DANCE
	db 0

GloomEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mid-stage flower bud (Grass/Fungus per typing
; revision). Oddish's 11 + 2 Gloom-tier exclusives (per Forte): SCREECH
; (drooly mouth resonance), TOXIC (mature poison glands).
	db  4, ABSORB
	db  7, GROWL
	db 10, GROWTH
	db 13, TACKLE
	db 16, STUN_POWDER
	db 19, SLEEP_POWDER
	db 22, POISONPOWDER
	db 25, ACID
	db 28, LEECH_SEED
	db 31, SCREECH
	db 34, MEGA_DRAIN
	db 37, TOXIC
	db 46, PETAL_DANCE
	db 0

VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Rafflesia bloom (Grass/Fungus). Powder
; warfare specialist — full powder triad in shared. Gloom's 13 + 5
; Vileplume-only exclusives (per Forte's reshuffle): SPORE_DAZE (fungal
; confusion — moved from Gloom to Vileplume per Forte), EERIE_IMPULSE
; (mature spore mind-effect), LEECH_LIFE (insect drain — high level),
; HAZE (gas/spore cloud apex), DARK_PULSE (dark fungal apex peak per
; Forte). NO BODY_SLAM/HEAVY_SLAM/SOLARBEAM in levelup (per Forte).
	db  4, ABSORB
	db  7, GROWL
	db 10, GROWTH
	db 13, TACKLE
	db 16, STUN_POWDER
	db 19, SLEEP_POWDER
	db 22, POISONPOWDER
	db 25, ACID
	db 28, LEECH_SEED
	db 31, SCREECH
	db 34, MEGA_DRAIN
	db 37, TOXIC
	db 40, SPORE_DAZE
	db 43, EERIE_IMPULSE
	db 46, PETAL_DANCE
	db 48, LEECH_LIFE
	db 52, HAZE
	db 58, DARK_PULSE
	db 0

ParasEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, PARASECT
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): cordyceps-controlled bug (Bug/Grass; Parasect
; → Bug/Fungus per typing revision). 10 shared (Forte's order). Powder
; profile: POISONPOWDER + STUN_POWDER + (SPORE = Parasect signature, only
; in Parasect learnset). LEECH_LIFE early bug-drain; SLASH mid-stage claws;
; drain progression (ABSORB→MEGA→GIGA).
	db  4, BUG_BITE
	db  7, SCRATCH
	db 10, ABSORB
	db 13, GROWTH
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 25, MEGA_DRAIN
	db 31, LEECH_LIFE
	db 37, SLASH
	db 46, GIGA_DRAIN
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mushroom-dominated apex (Bug/Fungus). Paras'
; 10 + 9 Parasect-only exclusives (per Forte feedback). SPORE at L22 (=
; evo level — mushroom takes over signature). PARASITE (Parasect-only
; super-fang). SPORE_DAZE (fungal confusion). SCARY_FACE (creepy fungal-
; zombie). EERIE_IMPULSE (mind-affecting spores per Forte). NIGHT_SLASH
; (dark sharp claws). DOUBLE_EDGE (apex recoil — swap from BODY_SLAM per
; Forte). TOXIC_FANGS (fungal mandibular toxin — Forte agreed). TOXIC at
; L60 last move (per Forte). NO BUG_BUZZ (per Forte — removed). Spaced
; out post-evo per Forte's feedback.
	db  4, BUG_BITE
	db  7, SCRATCH
	db 10, ABSORB
	db 13, GROWTH
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 22, SPORE
	db 25, MEGA_DRAIN
	db 26, PARASITE
	db 29, SPORE_DAZE
	db 31, LEECH_LIFE
	db 34, SCARY_FACE
	db 37, SLASH
	db 40, EERIE_IMPULSE
	db 44, NIGHT_SLASH
	db 46, GIGA_DRAIN
	db 50, DOUBLE_EDGE
	db 55, TOXIC_FANGS
	db 60, TOXIC
	db 0

VenonatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, VENOMOTH
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pre-moth, Bug/Poison. NO powders here —
; Forte made powders Venomoth-exclusive (anatomical: wings as powder
; source, baby Venonat lacks them). Spore Daze is Venonat-only (Forte:
; fuzzy baby body releases dazing spores; Venomoth replaces it with
; proper powder kit). PSYWAVE early before CONFUSION per Forte. Removed
; PSYBEAM. Added TOXIC and HAZE per Forte. STRING_SHOT skipped (no
; spinneret anatomy on the fuzzy bug body).
	db  4, POISON_STING
	db  8, PSYWAVE
	db 11, LEECH_LIFE
	db 14, SUPERSONIC
	db 17, CONFUSION
	db 20, SPORE_DAZE
	db 24, BUG_BUZZ
	db 30, TOXIC
	db 40, PSYCHIC_M
	db 48, HAZE
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: full moth. 9 shared with Venonat + 6 exclusives (wings +
; powders + signature dance). Powders Venomoth-only per Forte (wings as
; powder source). NO Spore Daze (Venonat baby exclusive — Venomoth
; graduated to proper powders). NO PSYBEAM per Forte. Quiver Dance late
; (new SPECIAL_SPEED_UP1_EFFECT). All entry levels unique (rule #7).
	db  4, POISON_STING
	db  8, PSYWAVE
	db 11, LEECH_LIFE
	db 14, SUPERSONIC
	db 17, CONFUSION
	db 18, POISONPOWDER
	db 21, GUST
	db 22, WING_ATTACK
	db 23, STUN_POWDER
	db 24, BUG_BUZZ
	db 25, SLEEP_POWDER
	db 30, TOXIC
	db 40, PSYCHIC_M
	db 42, QUIVER_DANCE
	db 48, HAZE
	db 0

DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DUGTRIO
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mole subterrâneo. DIG L1 (Forte: physically
; essential — toda a anatomia Diglett é "live in dig"). GROWL como hinder
; vocal mole (mole quase-cego, vocal makes sense). Quick attack/agility
; speed. EARTHQUAKE a L33 = ao evo. EXTREMESPEED Forte explicit override
; (apex mole speed). FISSURE signature Forte sec G last move L60.
	db  1, DIG
	db  1, SCRATCH
	db  4, SAND_ATTACK
	db  8, GROWL
	db 12, QUICK_ATTACK
	db 17, BULLDOZE
	db 22, AGILITY
	db 26, MUD_BOMB
	db 33, EARTHQUAKE
	db 36, HONE_CLAWS
	db 40, SLASH
	db 46, ROCK_TOMB
	db 52, EXTREMESPEED
	db 60, FISSURE
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex 3-headed mole. 14 backbone (Diglett) +
; 4 Dugtrio-exclusives (Forte): SCREECH (after HONE_CLAWS, não tarde),
; NIGHT_SLASH, TAKE_DOWN, RECOVER (esconde-se debaixo de terra a
; descansar). Removido: TRI_ATTACK (Forte sec G — só Porygon/Mew/
; Magneton; Forte explicit "nada de tri attack aqui"). STRENGTH via HM
; only (não levelup — Forte explicit).
	db  1, DIG
	db  1, SCRATCH
	db  4, SAND_ATTACK
	db  8, GROWL
	db 12, QUICK_ATTACK
	db 17, BULLDOZE
	db 22, AGILITY
	db 26, MUD_BOMB
	db 33, EARTHQUAKE
	db 36, HONE_CLAWS
	db 38, SCREECH
	db 40, SLASH
	db 46, ROCK_TOMB
	db 48, NIGHT_SLASH
	db 52, EXTREMESPEED
	db 54, TAKE_DOWN
	db 58, RECOVER
	db 60, FISSURE
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

MankeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 29, PRIMEAPE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): macaco selvagem rage-fueled. BITE/SAND_ATTACK/
; QUICK_ATTACK adicionados ao base (Forte). FIERCE_ROAR como battle roar
; ape (Forte: optional yes). ROCK_THROW + TAKE_DOWN (Forte add). THRASH a
; L28 simbólico — 1 lvl pre-evo (Forte). Removido: DIZZY_PUNCH/SUBMISSION
; (técnica reservada para Machamp/Poliwrath, não força bruta)/SKY_UPPERCUT
; (Hitmons exclusive)/FAINT_ATTACK (ape não sneak)/CRUNCH (não biter).
; STRENGTH via HM only (não levelup — Forte note 1).
	db  4, SCRATCH
	db  7, LEER
	db  9, BITE
	db 11, LOW_KICK
	db 13, SAND_ATTACK
	db 15, KARATE_CHOP
	db 18, QUICK_ATTACK
	db 20, FOCUS_ENERGY
	db 22, RAGE
	db 25, ROCK_THROW
	db 27, FIERCE_ROAR
	db 28, THRASH
	db 36, TAKE_DOWN
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex rage-monkey. 13 backbone + 9 Primeape-
; exclusives: INTIMIDATE (Forte: EARLIER, era L48), BODY_SLAM, GROUND_STOMP,
; BULK_UP (muscle-based per Forte), COMET_PUNCH, BRUTAL_SWING (rage swing),
; OUTRAGE (Forte: LATER), SWORDS_DANCE high lvl (Forte), GORE_ATTACK high
; lvl (Forte). Skip ROCK_PUNCH (sem rock affinity; ROCK_THROW backbone já
; cobre rock). STRENGTH via HM only.
	db  4, SCRATCH
	db  7, LEER
	db  9, BITE
	db 11, LOW_KICK
	db 13, SAND_ATTACK
	db 15, KARATE_CHOP
	db 18, QUICK_ATTACK
	db 20, FOCUS_ENERGY
	db 22, RAGE
	db 25, ROCK_THROW
	db 26, INTIMIDATE
	db 27, FIERCE_ROAR
	db 28, THRASH
	db 30, BODY_SLAM
	db 32, GROUND_STOMP
	db 34, BULK_UP
	db 36, TAKE_DOWN
	db 38, COMET_PUNCH
	db 42, BRUTAL_SWING
	db 48, OUTRAGE
	db 52, SWORDS_DANCE
	db 60, GORE_ATTACK
	db 0

GrowlitheEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): alpha canine puppy. HONE_CLAWS+FOCUS_ENERGY
; foundation predator (Forte add). FIERCE_ROAR substitui INTIMIDATE
; (Forte). CRUNCH movido para lower level (era L52; CRUNCH=Normal type
; neste hack, não cobre Dark). PLAY_ROUGH como Fairy bite/claw rough
; (Forte question: yes — anatomia canina perfeita; SUBMISSION rejeitado
; porque canine não wrestla). Sem rock move (Forte question: not — sem
; affinity earth). AGILITY movido para Arcanine-only. FAINT_ATTACK
; removido (Forte: redundante).
	db  4, BITE
	db  7, LEER
	db 11, HONE_CLAWS
	db 14, EMBER
	db 15, FIERCE_ROAR
	db 18, FOCUS_ENERGY
	db 22, FLAME_CHARGE
	db 26, CRUNCH
	db 32, FLAMETHROWER
	db 40, TAKE_DOWN
	db 48, PLAY_ROUGH
	db 55, FIRE_BLAST
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex alpha canine. 12 shared backbone + 4
; Arcanine-exclusives: CUT (HM01 natural — claws sharp), AGILITY (Forte:
; higher level que Growlithe original), STRENGTH (HM04 natural),
; SWORDS_DANCE (Forte explicit "essenciais que tem MESMO"). Removido:
; EXTREMESPEED (Forte: canine não está na lista YES — só Pikachu/Raichu/
; Raticate/Arbok/Persian/Hitmonchan), OUTRAGE (Arcanine não é Dragon-coded).
	db  4, BITE
	db  7, LEER
	db 11, HONE_CLAWS
	db 14, EMBER
	db 15, FIERCE_ROAR
	db 18, FOCUS_ENERGY
	db 22, FLAME_CHARGE
	db 26, CRUNCH
	db 32, FLAMETHROWER
	db 36, CUT
	db 40, TAKE_DOWN
	db 42, AGILITY
	db 44, STRENGTH
	db 48, PLAY_ROUGH
	db 52, SWORDS_DANCE
	db 55, FIRE_BLAST
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

MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, MACHOKE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): humanoid disciplined fighter. TACKLE starter
; (Forte). BULK_UP early L16 (Forte). DIZZY_PUNCH em vez de ROLLING_KICK
; (Forte: ROLLING_KICK Hitmonlee-only). BIND/SEISMIC_TOSS/ROCK_THROW
; adicionados (Forte). STRENGTH a L26 = evo level "em cima" (Forte).
; GROUND_STOMP fits humanoid stomping. SUBMISSION higher level (Forte:
; "um pouco mais alto"). Removido SKY_UPPERCUT (Hitmons exclusive).
	db  1, TACKLE
	db  4, LOW_KICK
	db  7, LEER
	db 11, KARATE_CHOP
	db 14, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, DIZZY_PUNCH
	db 20, BIND
	db 22, SEISMIC_TOSS
	db 25, ROCK_THROW
	db 26, STRENGTH
	db 30, GROUND_STOMP
	db 42, SUBMISSION
	db 48, TAKE_DOWN
	db 0

MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, MACHAMP
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mid-evo. 14 backbone (Machop) + BODY_SLAM
; Machoke-and-up exclusive (Forte: "dar body slam ao machoke").
	db  1, TACKLE
	db  4, LOW_KICK
	db  7, LEER
	db 11, KARATE_CHOP
	db 14, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, DIZZY_PUNCH
	db 20, BIND
	db 22, SEISMIC_TOSS
	db 25, ROCK_THROW
	db 26, STRENGTH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 42, SUBMISSION
	db 48, TAKE_DOWN
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex 4-arm humanoid fighter. 15 Machoke
; backbone + 5 Machamp-exclusives high-level (all Forte): COMET_PUNCH L42
; (4 arms = rapid combo punches), MACH_PUNCH (priority hand), BULLET_PUNCH
; (steel fast punch), IRON_DEFENSE (disciplined defense), SWORDS_DANCE
; (apex setup). SUBMISSION shared (Forte: signature de Machamp + Poliwrath
; — fica em backbone). Removido SUBMISSION duplicado L60.
	db  1, TACKLE
	db  4, LOW_KICK
	db  7, LEER
	db 11, KARATE_CHOP
	db 14, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, DIZZY_PUNCH
	db 20, BIND
	db 22, SEISMIC_TOSS
	db 25, ROCK_THROW
	db 26, STRENGTH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 42, SUBMISSION
	db 42, COMET_PUNCH
	db 46, MACH_PUNCH
	db 48, TAKE_DOWN
	db 50, BULLET_PUNCH
	db 55, SWORDS_DANCE
	db 60, IRON_DEFENSE
	db 0

BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, WEEPINBELL
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): carnivorous pitcher predator (Grass/Poison).
; 12 shared. Powder rule: ONLY SLEEP_POWDER (per powder table — predator,
; só adormece presa; NO Poison Powder, NO Stun Powder). CONSTRICT/WRAP +
; vine kit; BIDE; SLEEP_POWDER at evo level (signature na evo); ACID +
; RAZOR_LEAF + drain progression (ABSORB→MEGA→GIGA); TICKLE for debuff
; (per Forte). NO SLUDGE/CORRODE in shared (Forte: Weep+Vict-tier).
	db  4, ABSORB
	db  7, WRAP
	db 10, GROWTH
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 19, BIDE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 28, TICKLE
	db 31, RAZOR_LEAF
	db 37, MEGA_DRAIN
	db 43, GIGA_DRAIN
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mid-stage carnivore (Grass/Poison). Bellsprout's
; 12 shared + 6 Weepinbell+Victreebel exclusives (per Forte): BODY_SLAM
; (pitcher slam), TAKE_DOWN (vine grapple), SLUDGE (digestive), LEECH_LIFE
; (insect drain), CORRODE (predator -2 def signature), SLUDGE_WAVE high-
; level apex poison.
	db  4, ABSORB
	db  7, WRAP
	db 10, GROWTH
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 19, BIDE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 28, TICKLE
	db 31, RAZOR_LEAF
	db 33, BODY_SLAM
	db 36, TAKE_DOWN
	db 37, MEGA_DRAIN
	db 40, SLUDGE
	db 43, GIGA_DRAIN
	db 46, LEECH_LIFE
	db 52, CORRODE
	db 58, SLUDGE_WAVE
	db 0

VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex carnivore (Grass/Poison). Weepinbell's
; 18 + 3 Victreebel-only exclusives (per Forte): SLASH (sharp leaves
; matured), SCARY_FACE (giant trap mouth — eerie/sinister), DOUBLE_EDGE
; (apex predator overcommit recoil).
	db  4, ABSORB
	db  7, WRAP
	db 10, GROWTH
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 19, BIDE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 28, TICKLE
	db 31, RAZOR_LEAF
	db 33, BODY_SLAM
	db 36, TAKE_DOWN
	db 37, MEGA_DRAIN
	db 40, SLUDGE
	db 41, SCARY_FACE
	db 43, GIGA_DRAIN
	db 46, LEECH_LIFE
	db 48, SLASH
	db 52, CORRODE
	db 58, SLUDGE_WAVE
	db 60, DOUBLE_EDGE
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

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GRAVELER
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): basic rolling rock with arms (Rock/Ground).
; 11 shared (Forte's order). ROCK_PUNCH at evo level (signature na evo).
; HEAD_SMASH high level. NO DIG (Forte removed). NO EXPLOSION (Forte:
; signature of Koffing/Voltorb/Magmar only).
	db  4, TACKLE
	db  7, DEFENSE_CURL
	db 10, ROCK_THROW
	db 13, SAND_ATTACK
	db 16, GROUND_STOMP
	db 19, BIDE
	db 22, BODY_SLAM
	db 26, ROCK_PUNCH
	db 30, BULLDOZE
	db 36, ROCK_TOMB
	db 50, HEAD_SMASH
	db 0

GravelerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, GOLEM
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mid-stage rolling rock (Rock/Ground).
; Geodude's 11 + 6 Graveler+Golem exclusives (per Forte): TAKE_DOWN
; (charge), EARTHQUAKE, IRON_HEAD (rock-iron), STRENGTH (HM), ROCK_SLIDE
; (apex rock — after HEAD_SMASH per Forte's progression), DOUBLE_EDGE
; (apex recoil). NO BULK_UP per Forte (rock not muscle). NO DIG/
; EXPLOSION (Forte removed). Evo level 38 → 42 per Forte's biblia.
	db  4, TACKLE
	db  7, DEFENSE_CURL
	db 10, ROCK_THROW
	db 13, SAND_ATTACK
	db 16, GROUND_STOMP
	db 19, BIDE
	db 22, BODY_SLAM
	db 26, ROCK_PUNCH
	db 30, BULLDOZE
	db 34, TAKE_DOWN
	db 36, ROCK_TOMB
	db 40, EARTHQUAKE
	db 46, IRON_HEAD
	db 50, HEAD_SMASH
	db 54, STRENGTH
	db 58, ROCK_SLIDE
	db 62, DOUBLE_EDGE
	db 0

GolemEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex turtle-shell rock (Rock/Ground).
; Graveler's 17 + 2 Golem-only exclusives (per Forte): IRON_DEFENSE (DEF
; +2 — new BIRD move v0.7), HEAVY_SLAM (apex Normal heavy frame). NO
; EXPLOSION (Forte: Koffing/Voltorb/Magmar signature only). NO HORN
; moves (no horn anatomy). NO OUTRAGE (gentle giant under heft).
	db  4, TACKLE
	db  7, DEFENSE_CURL
	db 10, ROCK_THROW
	db 13, SAND_ATTACK
	db 16, GROUND_STOMP
	db 19, BIDE
	db 22, BODY_SLAM
	db 26, ROCK_PUNCH
	db 30, BULLDOZE
	db 34, TAKE_DOWN
	db 36, ROCK_TOMB
	db 40, EARTHQUAKE
	db 46, IRON_HEAD
	db 48, IRON_DEFENSE
	db 50, HEAD_SMASH
	db 54, STRENGTH
	db 58, ROCK_SLIDE
	db 62, DOUBLE_EDGE
	db 65, HEAVY_SLAM
	db 0

PonytaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, RAPIDASH
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): equino jovem com mane Fire aberta. IGNITE
; (Fire — não Ghost) anatomy-correct: chama da mane é literal/aberta.
; BODY_SLAM (Forte: sim — equino rear-up + body-down). FAIRY_WIND
; adicionado à base (Forte: shared com Vulpix-line, basal Fairy
; presence). AGILITY a L30 coincidente com a evolução (Forte: ironia
; "Rapid"-ash unlock no momento certo). GROUND_STOMP via hooves (anatomia).
	db  4, EMBER
	db  7, TAIL_WHIP
	db 11, GROUND_STOMP
	db 13, FAIRY_WIND
	db 17, FLAME_CHARGE
	db 20, IGNITE
	db 23, BODY_SLAM
	db 28, TAKE_DOWN
	db 30, AGILITY
	db 34, FLAMETHROWER
	db 42, DOUBLE_EDGE
	db 50, FIRE_BLAST
	db 0

RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex equino unicórnio. 12 shared backbone +
; 5 Rapidash-exclusives: HORN_ATTACK (horn aparece com a evo, mesmo level
; que AGILITY — same-level apex pair), FLASH (HM05 natural — mane
; brilhante), HORN_CHARGE (Forte add — mid-tier horn), DAZZLE_GLEAM
; (Forte: sim — unicorn glow Fairy apex), HORN_DRILL (Forte explicit
; signature, last move L60). Removido: EXTREMESPEED (Forte explicit
; "Rapidash NÃO — rápido mas não ágil").
	db  4, EMBER
	db  7, TAIL_WHIP
	db 11, GROUND_STOMP
	db 13, FAIRY_WIND
	db 17, FLAME_CHARGE
	db 20, IGNITE
	db 23, BODY_SLAM
	db 28, TAKE_DOWN
	db 30, AGILITY
	db 30, HORN_ATTACK
	db 34, FLAMETHROWER
	db 38, FLASH
	db 42, DOUBLE_EDGE
	db 46, HORN_CHARGE
	db 50, FIRE_BLAST
	db 55, DAZZLE_GLEAM
	db 60, HORN_DRILL
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, SLOWBRO
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

MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, MAGNETON
	db 0
; Learnset
	db  6, THUNDERSHOCK
	db 10, SUPERSONIC
	db 14, SONICBOOM
	db 18, THUNDER_WAVE
	db 22, SHOCK_WAVE
	db 28, SCREECH
	db 34, BULLET_PUNCH
	db 40, MAGNET_BOMB
	db 46, THUNDERBOLT
	db 54, THUNDER
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, THUNDERSHOCK
	db 10, SUPERSONIC
	db 14, SONICBOOM
	db 18, THUNDER_WAVE
	db 22, SHOCK_WAVE
	db 28, SCREECH
	db 34, BULLET_PUNCH
	db 40, MAGNET_BOMB
	db 46, THUNDERBOLT
	db 54, THUNDER
	db 54, TRI_ATTACK
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

DoduoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DODRIO
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): flightless ratite. NO flying moves at all
; (no GUST/WING_ATTACK/FLY/AERIAL_ACE/HURRICANE/SKY_ATTACK) — anatomical
; exception per Forte despite Normal/Flying typing. NO TRI_ATTACK
; (signature now Porygon/Magneton/Mew only, per Forte). DRILL_PECK at L33
; (evo level — long beak fully developed). AGILITY natural per Forte's
; list. GROUND_STOMP added (heavy ratite legs). SAND_ATTACK per Forte.
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, LEER
	db 14, QUICK_ATTACK
	db 18, FURY_ATTACK
	db 22, RAGE
	db 26, GROUND_STOMP
	db 30, AGILITY
	db 33, DRILL_PECK
	db 42, TAKE_DOWN
	db 50, DOUBLE_EDGE
	db 0

DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: 3-headed ratite. Doduo's 11 + 2 exclusives: EXTREMESPEED
; (Forte — high level, peak running speed) and HORN_DRILL (Forte — last
; move, long beak as horn-drill). NO TRI_ATTACK (Porygon-only signature).
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, LEER
	db 14, QUICK_ATTACK
	db 18, FURY_ATTACK
	db 22, RAGE
	db 26, GROUND_STOMP
	db 30, AGILITY
	db 33, DRILL_PECK
	db 42, TAKE_DOWN
	db 46, EXTREMESPEED
	db 50, DOUBLE_EDGE
	db 60, HORN_DRILL
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

OnixEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): colossal rock-snake tunneler. Single mon —
; deepest movepool in this batch (29 moves). Per Forte: HAS JAW (eats
; earth to tunnel) → CRUNCH; metallic core → IRON_TAIL/IRON_HEAD/IRON_
; DEFENSE; snake form → COIL/BIND; extreme deep-earth pressure → DRAGON_
; BREATH/DRAGON_SLAM (+HYPER_BEAM L70 last move). NO GORE_ATTACK/OUTRAGE
; (sem fogo selvagem, gentle giant under all that defense). Pairs at same
; level (per Forte): COIL+BIND, BIDE+LEER, CRUNCH+DIG, IRON_TAIL+BRUTAL_
; SWING, IRON_DEFENSE+IRON_HEAD. FISSURE signature (Forte's list).
	db  4, TACKLE
	db  6, GROUND_STOMP
	db 8, COIL
	db 8, BIND
	db 12, BIDE
	db 12, LEER
	db 15, HEADBUTT
	db 18, ROCK_THROW
	db 22, BULLDOZE
	db 25, BODY_SLAM
	db 28, TAKE_DOWN
	db 31, ROCK_TOMB
	db 34, FIERCE_ROAR
	db 37, CRUNCH
	db 37, DIG
	db 40, STRENGTH
	db 43, HEAD_SMASH
	db 46, IRON_TAIL
	db 46, BRUTAL_SWING
	db 49, EARTHQUAKE
	db 50, ROCK_SLIDE
	db 52, IRON_DEFENSE
	db 53, IRON_HEAD
	db 55, INTIMIDATE
	db 60, DRAGON_BREATH
	db 63, HEAVY_SLAM
	db 65, DRAGON_SLAM
	db 67, FISSURE
	db 70, HYPER_BEAM
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

VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db  5, SONICBOOM
	db 10, THUNDERSHOCK
	db 14, SCREECH
	db 18, SHOCK_WAVE
	db 22, MAGNET_BOMB
	db 28, THUNDER_WAVE
	db 34, EXPLOSION
	db 40, THUNDERBOLT
	db 47, MIRROR_MOVE
	db 54, THUNDER
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SONICBOOM
	db 10, THUNDERSHOCK
	db 14, SCREECH
	db 18, SHOCK_WAVE
	db 22, MAGNET_BOMB
	db 28, THUNDER_WAVE
	db 34, EXPLOSION
	db 40, THUNDERBOLT
	db 47, MIRROR_MOVE
	db 54, THUNDER
	db 54, EXPLOSION
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
	db 28, STUN_POWDER
	db 34, POISONPOWDER
	db 40, SLEEP_POWDER
	db 47, PSYCHIC_M
	db 54, EXPLOSION
	db 60, GIGA_DRAIN
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
	db 28, STUN_POWDER
	db 34, POISONPOWDER
	db 40, SLEEP_POWDER
	db 47, PSYCHIC_M
	db 54, EXPLOSION
	db 60, GIGA_DRAIN
	db 0

CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, MAROWAK
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

HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pure leg-only kicker, single-stage. Order
; per Forte: starters LOW_KICK+LEER -> GROUND_STOMP -> FOCUS_ENERGY+
; CALM_MIND -> ROLLING_KICK -> mid-late. BRUTAL_SWING como leg swing
; (Forte interpretation). SEISMIC_TOSS (Forte add). FAINT_ATTACK no
; high-level (Forte: maybe — included). HI_JUMP_KICK signature apex.
; Removido: SUBMISSION (Forte: técnica de Machamp/Poliwrath, não
; Hitmonlee), MIND_BREAK BUG (era Mewtwo signature). STRENGTH via HM
; only (não levelup — Forte note 1).
	db  1, LOW_KICK
	db  1, LEER
	db  8, GROUND_STOMP
	db 14, FOCUS_ENERGY
	db 18, CALM_MIND
	db 22, QUICK_ATTACK
	db 26, ROLLING_KICK
	db 30, BULK_UP
	db 34, SEISMIC_TOSS
	db 36, BULLDOZE
	db 40, AGILITY
	db 42, FAINT_ATTACK
	db 46, TAKE_DOWN
	db 50, SWORDS_DANCE
	db 52, HI_JUMP_KICK
	db 55, BRUTAL_SWING
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pure fist-only puncher, single-stage. Order
; per Forte: starters QUICK_ATTACK+DEFENSE_CURL (DEFENSE_CURL agora L1
; em vez de L30 — boxer-guard inicial faz mais sentido) -> MACH_PUNCH ->
; FOCUS_ENERGY+CALM_MIND -> DIZZY_PUNCH+COMET_PUNCH -> mid-late punches.
; Elemental coverage agora 100% punches: ROCK_PUNCH/SHADOW_PUNCH/
; MAGMA_PUNCH (Forte: removido FLAME_BURST/SHOCK_WAVE/ICY_WIND porque já
; nao são punches, apenas special attacks). FAINT_ATTACK + RECOVER
; (Forte: stamina de boxer — exception). EXTREMESPEED Forte explicit
; "Hitmonchan in YES list". MAGMA_PUNCH signature exception (Forte).
; STRENGTH via HM only.
	db  1, QUICK_ATTACK
	db  1, DEFENSE_CURL
	db  8, MACH_PUNCH
	db 14, FOCUS_ENERGY
	db 18, CALM_MIND
	db 22, DIZZY_PUNCH
	db 26, COMET_PUNCH
	db 30, AGILITY
	db 34, ROCK_PUNCH
	db 36, BULLET_PUNCH
	db 40, BULK_UP
	db 44, FAINT_ATTACK
	db 46, SHADOW_PUNCH
	db 50, RECOVER
	db 52, SKY_UPPERCUT
	db 55, MAGMA_PUNCH
	db 60, EXTREMESPEED
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

RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, RHYDON
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): rhinoceros charger (Ground/Rock). 11 shared
; per Forte's order. HEAD_SMASH at L40 (= evo level, signature na evo).
; Pairs at same level (per Forte): SAND_ATTACK+GROUND_STOMP (L13), FOCUS_
; ENERGY+RAGE (L22). NO HORN_DRILL/FISSURE/EARTHQUAKE in shared (Rhydon-
; only per Forte).
	db  4, TACKLE
	db  7, LEER
	db 10, HORN_ATTACK
	db 13, SAND_ATTACK
	db 13, GROUND_STOMP
	db 16, ROCK_TOMB
	db 19, BODY_SLAM
	db 22, FOCUS_ENERGY
	db 22, RAGE
	db 28, BULLDOZE
	db 40, HEAD_SMASH
	db 43, TAKE_DOWN
	db 46, IRON_HEAD
	db 65, MEGAHORN
	db 0

RhydonEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex rhinoceros (Ground/Rock). Rhyhorn's
; 13 + 8 Rhydon-only exclusives (per Forte): HORN_CHARGE (matured horn
; just after evo), EARTHQUAKE (Rhydon-only per Forte), FIERCE_ROAR,
; STRENGTH (HM), BRUTAL_SWING, THRASH (primal force), HORN_DRILL
; (signature per Forte's Dodrio+Rhydon list), FISSURE (Forte's optional
; high level — included). NO DRAGON_SLAM (Rhydon is rhino, not dragon
; — Forte questioned, my call: skip; no extreme-pressure justification
; like Onix). NO MEGAHORN (Bug type, Rhydon not bug).
	db  4, TACKLE
	db  7, LEER
	db 10, HORN_ATTACK
	db 13, SAND_ATTACK
	db 13, GROUND_STOMP
	db 16, ROCK_TOMB
	db 19, BODY_SLAM
	db 22, FOCUS_ENERGY
	db 22, RAGE
	db 28, BULLDOZE
	db 40, HEAD_SMASH
	db 42, HORN_CHARGE
	db 43, TAKE_DOWN
	db 46, IRON_HEAD
	db 48, EARTHQUAKE
	db 52, FIERCE_ROAR
	db 55, STRENGTH
	db 58, BRUTAL_SWING
	db 61, THRASH
	db 64, HORN_DRILL
	db 67, FISSURE
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

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
	db  6, CONSTRICT
	db 10, ABSORB
	db 14, VINE_WHIP
	db 18, STUN_POWDER
	db 22, GROWTH
	db 28, MEGA_DRAIN
	db 34, BIND
	db 40, STRING_SHOT
	db 47, GIGA_DRAIN
	db 60, RECOVER
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, TAIL_WHIP
	db 10, BITE
	db 18, RAGE
	db 22, DIZZY_PUNCH
	db 28, MACH_PUNCH
	db 34, BODY_SLAM
	db 40, STRENGTH
	db 47, TAKE_DOWN
	db 54, DIZZY_PUNCH
	db 60, DOUBLE_EDGE
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

GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, SEAKING
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

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, QUICK_ATTACK
	db 10, LEER
	db 14, THUNDERSHOCK
	db 18, LIGHT_SCREEN
	db 22, SHOCK_WAVE
	db 28, THUNDER_WAVE
	db 34, AGILITY
	db 40, SCREECH
	db 47, THUNDERBOLT
	db 54, DIZZY_PUNCH
	db 60, THUNDER
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

MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GYARADOS
	db 0
; Learnset
	db 15, TACKLE
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

DittoEvosMoves:
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
; v0.7 Pass 3 (Forte review): Eevee Normal-only base. TAKE_DOWN removed
; per Forte #10 (only Eevee loses; the 3 evolutions keep). CHARM added per
; Forte #11 (cute fox charm — shared with all 4 forms).
	db  4, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 11, GROWL
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 30, BODY_SLAM
	db 36, DOUBLE_EDGE
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: Water fox, fluid body. Eevee shared + water/ice kit +
; HARDEN (Forte #5 — fluid body solidifies to ice/scale armor) + RECOVER
; (Forte #5 — animal regen pattern, fluid body reforms). Forte #3 said
; both moves earlier and close together — placed L28/L30. ICY_WIND replaced
; with ICE_BEAM (Vaporeon water-mastery deserves real ice attack, not
; light wind). Removed ICY_WIND.
	db  4, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 11, GROWL
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 22, WATER_GUN
	db 24, TAKE_DOWN
	db 26, BUBBLEBEAM
	db 28, HARDEN
	db 30, BODY_SLAM
	db 32, WATER_PULSE
	db 34, RECOVER
	db 36, DOUBLE_EDGE
	db 38, AURORA_BEAM
	db 44, SURF
	db 48, ICE_BEAM
	db 60, HYDRO_PUMP
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: Electric fox, fastest Eeveelution. Eevee shared + electric
; kit + METAL_SOUND per Forte #7 (electric sparks = metallic-sound debuff).
; AGILITY natural per Forte's list. NO DOUBLE_TEAM (not on Forte's natural
; list).
	db  4, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 11, GROWL
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 22, THUNDERSHOCK
	db 24, TAKE_DOWN
	db 26, THUNDER_WAVE
	db 30, BODY_SLAM
	db 32, SHOCK_WAVE
	db 36, DOUBLE_EDGE
	db 38, AGILITY
	db 44, THUNDERBOLT
	db 46, METAL_SOUND
	db 52, EXTREMESPEED
	db 60, THUNDER
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3: Fire fox. Eevee shared (CHARM included, TAKE_DOWN re-added
; here per Forte — only Eevee loses TAKE_DOWN). IGNITE early per Forte
; (was L54, now L26 — basic burn utility), SWORDS_DANCE late per Forte
; (was L52, now L57 — peak claw-buff before final fire).
	db  4, TAIL_WHIP
	db  8, QUICK_ATTACK
	db 11, GROWL
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 22, EMBER
	db 24, TAKE_DOWN
	db 26, IGNITE
	db 28, FLAME_CHARGE
	db 30, BODY_SLAM
	db 34, FAINT_ATTACK
	db 36, DOUBLE_EDGE
	db 40, FLAME_BURST
	db 47, FLAMETHROWER
	db 57, SWORDS_DANCE
	db 60, FIRE_BLAST
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
	db 34, SHOCK_WAVE
	db 40, MAGNET_BOMB
	db 47, THUNDERBOLT
	db 54, MIRROR_MOVE
	db 60, HYPER_BEAM
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
	db 22, SHOCK_WAVE
	db 28, WING_ATTACK
	db 34, DOUBLE_TEAM
	db 40, THUNDER_WAVE
	db 47, DRILL_PECK
	db 54, THUNDERBOLT
	db 60, SKY_ATTACK
	db 66, THUNDER
	db 72, HURRICANE
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
	db EVOLVE_LEVEL, 46, DRAGONITE
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

NoEvosMoves:
; Shared placeholder for the 36 internal-index gaps (the slots that
; manifest as MISSINGNO. when reached via the Cinnabar coast wild-encounter
; bug). The pointer table is positional and must have NUM_POKEMON_INDEXES
; entries, so every gap-index points here. Engine reads `db 0`/`db 0` =
; no evolutions, no learnset. ROM-identical to the 36 separate-but-identical
; placeholder blocks that used to exist. Fossil Kabutops/Aerodactyl/MonGhost
; are kept as named separate blocks (real gameplay entities, may get
; learnsets in future).
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
