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
	db  6, VINE_WHIP
	db  8, LEECH_SEED
	db 12, GROWTH
	db 20, ABSORB
	db 25, SLEEP_POWDER
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 42, PETAL_DANCE
	db 48, RECOVER
	db 55, GIGA_DRAIN
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
	db  6, VINE_WHIP
	db  8, LEECH_SEED
	db 12, GROWTH
	db 16, POISONPOWDER
	db 20, ABSORB
	db 25, SLEEP_POWDER
	db 28, ACID
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 42, PETAL_DANCE
	db 48, RECOVER
	db 52, TOXIC
	db 55, GIGA_DRAIN
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
	db  6, VINE_WHIP
	db  8, LEECH_SEED
	db 12, GROWTH
	db 16, POISONPOWDER
	db 20, ABSORB
	db 25, SLEEP_POWDER
	db 28, ACID
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 38, SLUDGE
	db 40, BODY_SLAM
	db 42, PETAL_DANCE
	db 48, RECOVER
	db 52, TOXIC
	db 55, GIGA_DRAIN
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
	db  6, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, HEADBUTT
	db 20, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 38, FLAMETHROWER
	db 42, DRAGON_CLAW
	db 48, DRAGON_BREATH
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
	db  6, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, HEADBUTT
	db 20, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 38, FLAMETHROWER
	db 42, DRAGON_CLAW
	db 48, DRAGON_BREATH
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
	db  6, EMBER
	db  9, SMOKESCREEN
	db 13, BITE
	db 17, HEADBUTT
	db 20, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 36, WING_ATTACK
	db 38, FLAMETHROWER
	db 40, FLY
	db 42, DRAGON_CLAW
	db 44, CRUNCH
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
	db  6, WATER_GUN
	db  8, WITHDRAW
	db 10, BIDE
	db 12, BITE
	db 15, AQUA_JET
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
	db  6, WATER_GUN
	db  8, WITHDRAW
	db 10, BIDE
	db 12, BITE
	db 15, AQUA_JET
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
	db  6, WATER_GUN
	db  8, WITHDRAW
	db 10, BIDE
	db 12, BITE
	db 15, AQUA_JET
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 32, WATERFALL
	db 40, CRUNCH
	db 42, BODY_SLAM
	db 46, HEAVY_SLAM
	db 48, SURF
	db 52, ICE_BEAM
	db 56, HYDRO_PUMP
	db 60, HEAD_SMASH
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
	db 15, POISONPOWDER
	db 17, STUN_POWDER
	db 20, SLEEP_POWDER
	db 22, FAIRY_WIND
	db 26, EXTRASENSORY
	db 28, WING_ATTACK
	db 30, BUG_BUZZ ; restored (Forte r4: Butterfree + Venomoth own BUG_BUZZ)
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
; BUG_BUZZ removed (Forte r4: Butterfree + Venomoth only — buzzing wings).
	db  4, POISON_STING
	db  7, STRING_SHOT
	db  9, BUG_BITE
	db 13, BIDE
	db 15, FURY_ATTACK
	db 15, RAGE
	db 18, HORN_ATTACK
	db 20, TWINEEDLE
	db 22, HONE_CLAWS
	db 25, FOCUS_ENERGY
	db 27, QUICK_ATTACK
	db 30, AGILITY
	db 33, INTIMIDATE
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
	db 36, FLY
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
	db 36, FLY
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
	db 36, FLY
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
	db  9, ASTONISH
	db 11, FOCUS_ENERGY
	db 13, FAINT_ATTACK
	db 16, RAGE
	db 20, HYPER_FANG
	db 23, HEADBUTT
	db 25, CUT
	db 27, AGILITY
	db 29, HONE_CLAWS
	db 32, SUPER_FANG
	db 36, CRUNCH
	db 40, POISON_FANG
	db 44, BODY_SLAM
	db 52, DOUBLE_EDGE
	db 56, TOXIC_FANGS
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
	db  9, ASTONISH
	db 11, FOCUS_ENERGY
	db 13, FAINT_ATTACK
	db 16, RAGE
	db 20, HYPER_FANG
	db 23, HEADBUTT
	db 25, CUT
	db 27, AGILITY
	db 29, HONE_CLAWS
	db 32, SUPER_FANG
	db 36, CRUNCH
	db 38, SLASH
	db 40, POISON_FANG
	db 44, BODY_SLAM
	db 46, NIGHT_SLASH
	db 52, DOUBLE_EDGE
	db 54, BRUTAL_SWING
	db 56, TOXIC_FANGS
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
	db  6, SAND_ATTACK
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
	db  6, SAND_ATTACK
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
	db  1, QUICK_ATTACK
	db  3, CONSTRICT
	db  6, WRAP
	db  9, BIDE
	db 12, BITE
	db 15, LEER
	db 17, ASTONISH
	db 20, POISON_STING
	db 23, COIL
	db 29, BIND
	db 31, POISON_FANG
	db 34, AGILITY
	db 37, FAINT_ATTACK
	db 40, SHADOW_SNEAK
	db 43, SUBSTITUTE
	db 48, TOXIC_FANGS
	db 51, EXTREMESPEED
	db 54, TOXIC
	db 57, NEUROTOXIN
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
	db  1, QUICK_ATTACK
	db  3, CONSTRICT
	db  6, WRAP
	db  9, BIDE
	db 12, BITE
	db 15, LEER
	db 17, ASTONISH
	db 20, POISON_STING
	db 23, COIL
	db 26, SCARY_FACE
	db 29, BIND
	db 31, POISON_FANG
	db 34, AGILITY
	db 37, FAINT_ATTACK
	db 40, SHADOW_SNEAK
	db 43, SUBSTITUTE
	db 45, IRON_TAIL
	db 48, TOXIC_FANGS
	db 51, EXTREMESPEED
	db 54, TOXIC
	db 57, NEUROTOXIN
	db 60, INTIMIDATE
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
	db  4, TAIL_WHIP
	db  7, NUZZLE
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
	db  4, TAIL_WHIP
	db  7, NUZZLE
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
	db 24, HONE_CLAWS
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
	db 24, HONE_CLAWS
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
	db 18, FAIRY_WIND
	db 20, BIDE
	db 22, HEADBUTT
	db 26, POISON_FANG
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
	db 18, FAIRY_WIND
	db 20, BIDE
	db 22, HEADBUTT
	db 24, ACID
	db 26, POISON_FANG
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
	db 18, FAIRY_WIND
	db 20, BIDE
	db 22, HEADBUTT
	db 24, ACID
	db 26, POISON_FANG
	db 28, BODY_SLAM
	db 28, STRENGTH
	db 30, TAKE_DOWN
	db 33, MUD_SHOT
	db 35, PLAY_ROUGH
	db 37, CHARM
	db 40, TOXIC_FANGS
	db 42, BULLDOZE
	db 46, MUD_BOMB
	db 50, TOXIC
	db 55, NEUROTOXIN
	db 60, BRUTAL_SWING
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
	db 39, HORN_CHARGE
	db 47, TOXIC_FANGS
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
	db 33, GROUND_STOMP
	db 35, RAGE
	db 37, FIERCE_ROAR
	db 39, HORN_CHARGE
	db 47, TOXIC_FANGS
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
	db 28, STRENGTH
	db 30, TAKE_DOWN
	db 33, GROUND_STOMP
	db 35, RAGE
	db 37, FIERCE_ROAR
	db 39, CRUNCH
	db 41, BULLDOZE
	db 43, HORN_CHARGE
	db 47, TOXIC_FANGS
	db 49, MEGAHORN
	db 51, EARTHQUAKE
	db 53, THRASH
	db 58, BRUTAL_SWING
	db 61, GORE_ATTACK
	db 65, OUTRAGE
	db 0
	
ClefairyEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Normal/Fairy mystical. SING após L30
; (Forte sec C). MIMIC/METRONOME fun naturals (Forte sec A).
; CHARM (Forte sec F). RECOVER (Forte RECOVER list — Clefairy-line).
; LIGHT_SCREEN/REFLECT/CALM_MIND reservados Clefable.
	db  1, GROWL
	db  4, FAIRY_WIND
	db  7, DOUBLESLAP
	db 10, POWDER_SNOW
	db 13, CALM_MIND
	db 16, CHARM
	db 19, DRAINING_KISS
	db 22, TICKLE
	db 25, RECOVER
	db 28, LIGHT_SCREEN
	db 32, MIMIC
	db 35, SING
	db 38, TELEPORT
	db 41, METRONOME
	db 44, DAZZLE_GLEAM
	db 50, REFLECT
	db 60, MOONBLAST
	db 0

ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex mystical Fairy. 12 backbone
; (Clefairy) + 3 Clefable-exclusives: LIGHT_SCREEN (Forte sec F),
; REFLECT (Forte sec F), CALM_MIND (Forte sec E).
	db  1, GROWL
	db  4, FAIRY_WIND
	db  7, DOUBLESLAP
	db 10, POWDER_SNOW
	db 13, CALM_MIND
	db 16, CHARM
	db 19, DRAINING_KISS
	db 22, TICKLE
	db 25, RECOVER
	db 28, LIGHT_SCREEN
	db 32, MIMIC
	db 35, SING
	db 38, TELEPORT
	db 41, METRONOME
	db 44, DAZZLE_GLEAM
	db 47, ICY_WIND
	db 50, REFLECT
	db 53, PLAY_ROUGH
	db 56, PETAL_DANCE
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
; v0.7 Pass 3 (Forte review): Normal/Fairy balloon singer. SING L1
; (Forte sec C — starts with SING). LOVELY_KISS (Forte sec C).
; CHARM (Forte sec F). METRONOME/SUBSTITUTE fun moves natural
; (Forte sec A). MOONBLAST apex Fairy.
	db  1, GROWL
	db  3, SING
	db  6, HINDER
	db  9, TACKLE
	db  9, FAIRY_WIND
	db 12, DOUBLESLAP
	db 15, CHARM
	db 17, TAUNT
	db 20, GROWTH
	db 23, ASTONISH
	db 26, BIDE
	db 31, BUBBLEBEAM
	db 34, SCREECH
	db 37, AMNESIA
	db 40, LOVELY_KISS
	db 43, DRAINING_KISS
	db 45, BODY_SLAM
	db 48, FAKE_TEARS
	db 51, RAGE
	db 54, FLY
	db 0

WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex balloon singer. 12 backbone
; (Jigglypuff) + 1 Wigglytuff-exclusive: FLY HM02 natural (Forte
; sec B Jigglypuff/Wigglytuff YES — balloon floats).
	db  1, GROWL
	db  3, SING
	db  6, HINDER
	db  9, TACKLE
	db  9, FAIRY_WIND
	db 12, DOUBLESLAP
	db 15, CHARM
	db 17, TAUNT
	db 20, GROWTH
	db 23, ASTONISH
	db 26, BIDE
	db 31, BUBBLEBEAM
	db 34, SCREECH
	db 37, AMNESIA
	db 40, LOVELY_KISS
	db 43, DRAINING_KISS
	db 45, BODY_SLAM
	db 48, FAKE_TEARS
	db 51, RAGE
	db 54, FLY
	db 57, MIRROR_MOVE
	db 60, PLAY_ROUGH
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
	db 15, SUPERSONIC
	db 17, LEECH_LIFE
	db 20, LICK
	db 22, WING_ATTACK
	db 24, EERIE_IMPULSE
	db 26, SCREECH
	db 30, ASTONISH
	db 34, AERIAL_ACE
	db 36, FLY
	db 40, POISON_FANG
	db 44, AGILITY
	db 48, TOXIC_FANGS
	db 51, EXTREMESPEED
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
	db 15, SUPERSONIC
	db 17, LEECH_LIFE
	db 20, LICK
	db 22, WING_ATTACK
	db 24, EERIE_IMPULSE
	db 26, SCREECH
	db 30, ASTONISH
	db 34, AERIAL_ACE
	db 36, FLY
	db 40, POISON_FANG
	db 44, AGILITY
	db 48, TOXIC_FANGS
	db 51, EXTREMESPEED
	db 55, DARK_PULSE
	db 60, TOXIC
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
	db 65, SPORE
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
	db 27, PARASITE
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
	db 31, TOXIC
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
	db 19, POISONPOWDER
	db 21, GUST
	db 23, STUN_POWDER
	db 25, BUG_BUZZ
	db 27, SLEEP_POWDER
	db 29, WING_ATTACK
	db 31, TOXIC
	db 40, PSYCHIC_M
	db 42, QUIVER_DANCE
	db 48, HAZE
	db 55, NIGHT_SHADE
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
; v0.7 Pass 3 (Forte review): feline cat, claws + coin. PAY_DAY
; signature. HONE_CLAWS/SLASH/NIGHT_SLASH (claws). FAINT_ATTACK
; (cat sneak). TAUNT (cat playful).
	db  1, SCRATCH
	db  4, GROWL
	db  7, BITE
	db 11, PAY_DAY
	db 14, FURY_ATTACK
	db 18, FAINT_ATTACK
	db 20, FOCUS_ENERGY
	db 22, SLASH
	db 26, HONE_CLAWS
	db 30, CHARM
	db 34, TAIL_WHIP
	db 36, ASTONISH
	db 40, NASTY_PLOT
	db 50, AGILITY
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex feline. INTIMIDATE (Forte F apex
; predator). NASTY_PLOT (Forte E sneaky special). EXTREMESPEED
; (Forte G YES list). BRUTAL_SWING apex.
	db  1, SCRATCH
	db  4, GROWL
	db  7, BITE
	db 11, PAY_DAY
	db 14, FURY_ATTACK
	db 18, FAINT_ATTACK
	db 20, FOCUS_ENERGY
	db 22, SLASH
	db 26, HONE_CLAWS
	db 30, CHARM
	db 32, INTIMIDATE
	db 34, TAIL_WHIP
	db 36, ASTONISH
	db 40, NASTY_PLOT
	db 45, NIGHT_SLASH
	db 50, AGILITY
	db 55, EXTREMESPEED
	db 60, RAGE
	db 0

PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, GOLDUCK
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Water/Psychic confused duck. DISABLE
; (canon — confused mind blocks moves). AMNESIA (Forte E Psyduck
; list). PSYCHIC_BIND (Forte G Psyduck-line YES).
	db  1, SCRATCH
	db  5, GROWL
	db 10, WATER_GUN
	db 14, DISABLE
	db 18, CONFUSION
	db 22, BUBBLEBEAM
	db 26, HEADBUTT
	db 30, WATER_PULSE
	db 36, EXTRASENSORY
	db 38, PSYCHIC_BIND
	db 42, AMNESIA
	db 51, PSYWAVE
	db 0

GolduckEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex psychic duck. CALM_MIND clearer
; mind. SURF/CUT HMs naturais (Forte sec B). HYDRO_PUMP apex.
	db  1, SCRATCH
	db  5, GROWL
	db 10, WATER_GUN
	db 14, DISABLE
	db 18, CONFUSION
	db 22, BUBBLEBEAM
	db 26, HEADBUTT
	db 30, WATER_PULSE
	db 36, EXTRASENSORY
	db 38, PSYCHIC_BIND
	db 40, SURF
	db 42, AMNESIA
	db 47, PSYCHIC_M
	db 49, AQUA_JET
	db 51, PSYWAVE
	db 53, ICY_PULSE
	db 55, DOUBLE_TEAM
	db 57, NIGHT_SHADE
	db 59, ICE_BEAM
	db 61, HYDRO_PUMP
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
	db 18, QUICK_ATTACK
	db 20, FOCUS_ENERGY
	db 22, RAGE
	db 25, ROCK_THROW
	db 27, COMET_PUNCH
	db 29, FIERCE_ROAR
	db 31, TAKE_DOWN
	db 33, BODY_SLAM
	db 39, ROLLING_KICK
	db 41, THRASH
	db 48, OUTRAGE
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
	db 18, QUICK_ATTACK
	db 20, FOCUS_ENERGY
	db 22, RAGE
	db 25, ROCK_THROW
	db 27, COMET_PUNCH
	db 29, FIERCE_ROAR
	db 31, TAKE_DOWN
	db 33, BODY_SLAM
	db 35, GROUND_STOMP
	db 37, BULK_UP
	db 39, ROLLING_KICK
	db 41, THRASH
	db 43, BRUTAL_SWING
	db 46, INTIMIDATE
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
	db 16, FIERCE_ROAR
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
	db 16, FIERCE_ROAR
	db 18, FOCUS_ENERGY
	db 22, FLAME_CHARGE
	db 26, CRUNCH
	db 32, FLAMETHROWER
	db 36, CUT
	db 38, STRENGTH
	db 40, TAKE_DOWN
	db 42, AGILITY
	db 48, PLAY_ROUGH
	db 52, SWORDS_DANCE
	db 55, FIRE_BLAST
	db 0

PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, POLIWHIRL
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): tadpole Water. BUBBLEBEAM/HYPNOSIS/
; DOUBLESLAP basic kit.
	db  5, DOUBLESLAP
	db  9, WATER_GUN
	db 11, HINDER
	db 13, HYPNOSIS
	db 17, TACKLE
	db 22, BUBBLEBEAM  ; (Evo lvl)
	db 24, BODY_SLAM
	db 28, WATER_PULSE
	db 51, AQUA_JET
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): mid-evo. STRENGTH HM04 natural
; (Forte B). BULK_UP (Forte E muscle list).
	db  5, DOUBLESLAP
	db  9, WATER_GUN
	db 11, HINDER
	db 13, HYPNOSIS
	db 17, TACKLE
	db 20, FOCUS_ENERGY
	db 22, BUBBLEBEAM  ; (Evo lvl)
	db 24, BODY_SLAM
	db 28, WATER_PULSE
	db 36, BULK_UP
	db 40, LOW_KICK
	db 44, WATERFALL
	db 49, DIZZY_PUNCH
	db 51, AQUA_JET
	db 55, SURF
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Water/Fighting. SUBMISSION
; signature (Forte: signature de Machamp + Poliwrath). DIZZY_PUNCH
; boxer-frog. SURF HM03.
	db  5, DOUBLESLAP
	db  9, WATER_GUN
	db 11, HINDER
	db 13, HYPNOSIS
	db 17, TACKLE  ; (Evo lvl)
	db 20, FOCUS_ENERGY
	db 22, BUBBLEBEAM
	db 24, BODY_SLAM
	db 28, WATER_PULSE
	db 32, LOW_KICK
	db 36, BULK_UP
	db 40, STRENGTH
	db 44, WATERFALL
	db 47, DIZZY_PUNCH
	db 49, TAKE_DOWN
	db 51, AQUA_JET
	db 53, SEISMIC_TOSS
	db 55, SURF
	db 57, SUBMISSION
	db 59, DOUBLE_EDGE
	db 61, HYDRO_PUMP
	db 0

AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, KADABRA
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): minimalist baby psychic. Apenas
; TELEPORT pre-evo — fiel ao canon Abra-only-Teleport.
	db  1, TELEPORT
	db 11, PSYWAVE
	db 21, DISABLE
	db 31, CONFUSION
	db 41, PSYCHIC_BIND
	db 43, CALM_MIND  ; (EVO LVL)
	db 0

KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, ALAKAZAM
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Psychic mage mid-evo. PSYCHIC_BIND
; Kadabra-line ownership (Forte sec G). RECOVER (Forte RECOVER
; list). LIGHT_SCREEN/REFLECT (Forte sec F). CALM_MIND (Forte sec E).
; MIND_BREAK reservado para Alakazam apex.
	db  1, TELEPORT
	db 11, PSYWAVE
	db 21, DISABLE
	db 31, CONFUSION
	db 41, PSYCHIC_BIND
	db 43, CALM_MIND  ; (EVO LVL)
	db 45, FOCUS_ENERGY
	db 47, RECOVER
	db 49, EXTRASENSORY
	db 53, LIGHT_SCREEN
	db 55, SHOCK_WAVE
	db 57, REFLECT
	db 59, PSYBEAM
	db 61, AGILITY
	db 63, PSYCHIC_M
	db 65, TRI_ATTACK
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Psychic mage. 11 backbone
; (Kadabra) + 2 Alakazam-exclusives: FLASH HM05 natural (Forte sec
; B Kadabra/Alakazam YES), MIND_BREAK very-high last move L70
; (Forte sec G).
	db  1, TELEPORT
	db 11, PSYWAVE
	db 21, DISABLE
	db 31, CONFUSION
	db 41, PSYCHIC_BIND
	db 43, CALM_MIND  ; (EVO LVL)
	db 45, FOCUS_ENERGY
	db 47, RECOVER
	db 49, EXTRASENSORY
	db 51, EERIE_IMPULSE
	db 53, LIGHT_SCREEN
	db 55, SHOCK_WAVE
	db 57, REFLECT
	db 59, PSYBEAM
	db 61, AGILITY
	db 63, PSYCHIC_M
	db 65, TRI_ATTACK
	db 67, METRONOME
	db 69, DARK_PULSE
	db 71, MIND_BREAK
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
	db 11, BIND
	db 14, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, KARATE_CHOP
	db 20, STRENGTH
	db 22, SEISMIC_TOSS
	db 25, ROCK_THROW
	db 27, DIZZY_PUNCH
	db 30, GROUND_STOMP
	db 42, TAKE_DOWN
	db 48, SUBMISSION
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
	db 11, BIND
	db 14, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, KARATE_CHOP
	db 20, STRENGTH
	db 22, SEISMIC_TOSS
	db 25, ROCK_THROW
	db 27, DIZZY_PUNCH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 42, TAKE_DOWN
	db 48, SUBMISSION
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
	db 11, BIND
	db 14, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, KARATE_CHOP
	db 20, STRENGTH
	db 20, COMET_PUNCH
	db 22, SEISMIC_TOSS
	db 25, ROCK_THROW
	db 27, DIZZY_PUNCH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 42, TAKE_DOWN
	db 46, MACH_PUNCH
	db 48, SUBMISSION
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
	db 13, BITE
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 19, BIDE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 28, TICKLE
	db 31, RAZOR_LEAF
	db 38, MEGA_DRAIN
	db 44, GIGA_DRAIN
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
	db 13, BITE
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 19, BIDE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 28, TICKLE
	db 31, RAZOR_LEAF
	db 33, BODY_SLAM
	db 36, TAKE_DOWN
	db 38, MEGA_DRAIN
	db 40, SLUDGE
	db 44, GIGA_DRAIN
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
	db 13, BITE
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 19, BIDE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 28, TICKLE
	db 31, RAZOR_LEAF
	db 33, BODY_SLAM
	db 36, TAKE_DOWN
	db 38, MEGA_DRAIN
	db 40, SLUDGE
	db 42, SCARY_FACE
	db 44, GIGA_DRAIN
	db 46, LEECH_LIFE
	db 48, SLASH
	db 52, CORRODE
	db 58, SLUDGE_WAVE
	db 65, TOXIC
	db 0
TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): jellyfish Water/Poison. SLUDGE_WAVE
; Tentacool-line ownership (Forte sec G). NEUROTOXIN Tentacruel-
; line signature (Forte sec G). Removido POISON_FANG (sem fangs
; — jellyfish).
	db  1, POISON_STING
	db  3, WATER_GUN
	db  6, HINDER
	db  9, WRAP
	db 12, CONSTRICT
	db 15, NEUROTOXIN
	db 17, ACID
	db 20, BUBBLEBEAM
	db 23, SMOKESCREEN
	db 26, SLUDGE
	db 29, WATER_PULSE
	db 31, GROWTH  ; (EVO LVL)
	db 33, BIND
	db 35, NUZZLE
	db 39, SURF
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex jellyfish. 13 backbone (Tentacool)
; + 3 Tentacruel-exclusives: CUT HM01 natural (Forte sec B), SURF
; HM03 natural, CORRODE (Forte sec F Claude decide: yes, jellyfish
; acid corrodes).
	db  1, POISON_STING
	db  3, WATER_GUN
	db  6, HINDER
	db  9, WRAP
	db 12, CONSTRICT
	db 15, NEUROTOXIN
	db 17, ACID
	db 20, BUBBLEBEAM
	db 23, SMOKESCREEN
	db 26, SLUDGE
	db 29, WATER_PULSE
	db 31, GROWTH  ; (EVO LVL)
	db 33, BIND
	db 35, NUZZLE
	db 37, EERIE_IMPULSE
	db 39, SURF
	db 43, SLUDGE_WAVE
	db 48, SHOCK_WAVE
	db 56, TOXIC
	db 60, CORRODE
	db 65, HYDRO_PUMP
	db 0

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GRAVELER
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): basic rolling rock with arms (Rock/Ground).
; 11 shared (Forte's order) + ROLLOUT L42 (Forte new signature 2026-05-23).
; ROCK_PUNCH at evo level. HEAD_SMASH high level. NO DIG (Forte removed).
; NO EXPLOSION (Forte: Koffing/Voltorb/Magmar signature only).
	db  4, TACKLE
	db  7, DEFENSE_CURL
	db 10, ROCK_THROW
	db 13, SAND_ATTACK
	db 16, GROUND_STOMP
	db 19, BIDE
	db 22, BODY_SLAM
	db 26, ROCK_PUNCH
	db 30, BULLDOZE
	db 36, ROLLOUT
	db 42, ROCK_TOMB
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
	db 32, STRENGTH
	db 34, TAKE_DOWN
	db 36, ROLLOUT
	db 40, EARTHQUAKE
	db 42, ROCK_TOMB
	db 46, IRON_HEAD
	db 50, HEAD_SMASH
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
	db 32, STRENGTH
	db 34, TAKE_DOWN
	db 36, ROLLOUT
	db 40, EARTHQUAKE
	db 42, ROCK_TOMB
	db 46, IRON_HEAD
	db 48, IRON_DEFENSE
	db 50, HEAD_SMASH
	db 58, ROCK_SLIDE
	db 62, HEAVY_SLAM
	db 65, DOUBLE_EDGE
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
	db 15, LOW_KICK
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
	db 15, LOW_KICK
	db 17, FLAME_CHARGE
	db 20, IGNITE
	db 23, BODY_SLAM
	db 28, TAKE_DOWN
	db 30, AGILITY
	db 30, HORN_ATTACK
	db 34, FLAMETHROWER
	db 42, HORN_CHARGE
	db 46, DOUBLE_EDGE
	db 50, FIRE_BLAST
	db 55, DAZZLE_GLEAM
	db 60, HORN_DRILL
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, SLOWBRO
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): slow Water/Psychic. AMNESIA (Forte E
; Slowpoke-line YES — only AMNESIA, NÃO CALM_MIND).
	db  1, TAIL_WHIP
	db  5, WATER_GUN
	db 10, REST
	db 12, PSYWAVE
	db 14, CONFUSION
	db 16, DISABLE
	db 18, HEADBUTT
	db 22, WATER_PULSE
	db 28, AMNESIA
	db 34, EXTRASENSORY
	db 44, BIDE
	db 51, RECOVER
	db 0

SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex slow Water/Psychic. WITHDRAW
; (shellder bite as makeshift shield). SURF/STRENGTH HMs.
	db  1, TAIL_WHIP
	db  5, WATER_GUN
	db 10, REST
	db 12, PSYWAVE
	db 14, CONFUSION
	db 16, DISABLE
	db 18, HEADBUTT
	db 22, WATER_PULSE
	db 28, AMNESIA
	db 34, EXTRASENSORY
	db 36, REFLECT
	db 38, WITHDRAW
	db 40, BODY_SLAM
	db 44, BIDE
	db 46, WATERFALL
	db 49, ICY_PULSE
	db 51, RECOVER
	db 53, PSYCHIC_M
	db 55, ICE_BEAM
	db 0

MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, MAGNETON
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Electric/Steel. METAL_SOUND (Forte F
; Steel-types). SONICBOOM signature. SHOCK_WAVE/THUNDERBOLT.
; TRI_ATTACK reservado para Magneton (Forte G).
	db  1, HEADBUTT
	db  5, SONICBOOM
	db  9, THUNDERSHOCK
	db 14, SUPERSONIC
	db 18, THUNDER_WAVE
	db 22, SHOCK_WAVE
	db 26, SCREECH
	db 38, METAL_SOUND
	db 40, THUNDERBOLT
	db 52, BODY_SLAM
	db 55, IRON_HEAD
	db 58, IRON_DEFENSE
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Electric/Steel. TRI_ATTACK
; (Forte G — Magneton YES, NÃO Magnemite). SCREECH metal-on-metal.
	db  1, HEADBUTT
	db  5, SONICBOOM
	db  9, THUNDERSHOCK
	db 14, SUPERSONIC
	db 18, THUNDER_WAVE
	db 20, FOCUS_ENERGY
	db 22, SHOCK_WAVE
	db 26, SCREECH
	db 38, METAL_SOUND
	db 40, THUNDERBOLT
	db 45, LIGHT_SCREEN
	db 50, THUNDER
	db 52, BODY_SLAM
	db 55, IRON_HEAD
	db 58, IRON_DEFENSE
	db 60, TRI_ATTACK
	db 62, HEAVY_SLAM
	db 64, MAGNET_BOMB
	db 0

FarfetchdEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): duck samurai-bird with leek. TACKLE em vez de
; PECK (Forte). Karate/leek combat style: KARATE_CHOP antes de LEEK_STRIKE
; (Forte: trocar order). NIGHT_SLASH/CUT/QUICK_ATTACK/RECOVER/PETAL_DANCE
; (Forte adds — leek-magic Grass move). FAINT_ATTACK low (samurai sneak),
; SMOKESCREEN truques ninja (Forte). EXTREMESPEED imediatamente antes de
; BRUTAL_SWING (Forte: high level). Removido AERIAL_ACE/FLY do levelup
; (Forte; FLY continua via HM02). HONE_CLAWS/FURY_ATTACK/SKY_ATTACK
; removidos.
	db  1, TACKLE
	db  4, SAND_ATTACK
	db  7, LEER
	db  9, FAINT_ATTACK
	db 11, GUST
	db 13, QUICK_ATTACK
	db 15, SMOKESCREEN
	db 18, KARATE_CHOP
	db 22, LEEK_STRIKE
	db 26, SLASH
	db 30, NIGHT_SLASH
	db 34, CUT
	db 38, AGILITY
	db 42, RECOVER
	db 48, SWORDS_DANCE
	db 52, PETAL_DANCE
	db 58, EXTREMESPEED
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
	db 24, FAINT_ATTACK
	db 26, GROUND_STOMP
	db 30, AGILITY
	db 33, DRILL_PECK
	db 42, TAKE_DOWN
	db 46, EXTREMESPEED
	db 50, THRASH
	db 54, DOUBLE_EDGE
	db 60, HORN_DRILL
	db 0

SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, DEWGONG
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Water/Ice seal. HEADBUTT canon. REST
; (seal naps).
	db  1, HEADBUTT
	db  5, GROWL
	db  7, TAIL_WHIP
	db  9, DOUBLESLAP
	db 11, CHARM
	db 13, FAKE_TEARS
	db 15, AQUA_JET
	db 17, WATER_GUN
	db 19, POWDER_SNOW
	db 21, ICY_WIND
	db 23, BUBBLEBEAM
	db 28, FROST_BREATH
	db 34, WATER_PULSE
	db 40, ICY_PULSE
	db 44, AURORA_BEAM
	db 47, WATERFALL
	db 53, ICE_BEAM
	db 55, BODY_SLAM
	db 59, TAKE_DOWN
	db 61, PLAY_ROUGH
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Water/Ice. SURF HM03 natural.
; ICY_PULSE (Forte: NO Lorelei quirk in v0.7).
	db  1, HEADBUTT
	db  5, GROWL
	db  7, TAIL_WHIP
	db  9, DOUBLESLAP
	db 11, CHARM
	db 13, FAKE_TEARS
	db 15, AQUA_JET
	db 17, WATER_GUN
	db 19, POWDER_SNOW
	db 21, ICY_WIND
	db 23, BUBBLEBEAM
	db 28, FROST_BREATH
	db 34, WATER_PULSE
	db 40, ICY_PULSE
	db 44, AURORA_BEAM
	db 47, WATERFALL
	db 53, ICE_BEAM
	db 55, BODY_SLAM
	db 57, BLIZZARD
	db 59, TAKE_DOWN
	db 61, PLAY_ROUGH
	db 63, HYDRO_PUMP
	db 0

GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, MUK
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pure sludge blob Poison. HARDEN como
; 1-de-3 redundância (Forte sec F). SLUDGE_WAVE Grimer-line
; ownership (Forte sec G). GUNK_SHOT signature very-high (Forte
; sec G). RECOVER (Forte RECOVER list — Grimer-line). Removido
; POISON_FANG/TOXIC_FANGS (sem fangs — anatomia sludge).
	db  1, LICK
	db  3, ASTONISH
	db  6, HARDEN
	db  9, GROWTH
	db 12, WATER_GUN
	db 14, MUD_SHOT
	db 17, ACID
	db 20, DISABLE
	db 23, TAUNT
	db 26, BIND
	db 28, SMOG
	db 31, BODY_SLAM
	db 34, SLUDGE
	db 37, RECOVER
	db 39, TOXIC
	db 42, MUD_BOMB
	db 45, SLUDGE_WAVE
	db 0

MukEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex sludge. 12 backbone (Grimer) + 3
; Muk-exclusives: STRENGTH HM04 natural (Forte sec B), CORRODE
; Muk signature (Forte sec F), EXPLOSION sludge bomb apex.
	db  1, LICK
	db  3, ASTONISH
	db  6, HARDEN
	db  9, GROWTH
	db 12, WATER_GUN
	db 14, MUD_SHOT
	db 17, ACID
	db 20, DISABLE
	db 23, TAUNT
	db 26, BIND
	db 28, SMOG
	db 31, BODY_SLAM
	db 34, SLUDGE
	db 37, RECOVER
	db 39, TOXIC
	db 42, MUD_BOMB
	db 45, SLUDGE_WAVE
	db 48, TAKE_DOWN
	db 51, ROCK_TOMB
	db 53, CORRODE
	db 56, IRON_DEFENSE
	db 59, GUNK_SHOT
	db 62, SCARY_FACE
	db 65, HEAVY_SLAM
	db 0

ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): clam Water/Water. WITHDRAW (Forte F).
; CLAMP signature (Forte G — Shellder/Cloyster ONLY). SUPERSONIC.
	db  1, TACKLE
	db  5, WITHDRAW
	db 10, SUPERSONIC
	db 14, ICY_WIND
	db 18, CLAMP
	db 20, WATER_GUN
	db 22, BUBBLEBEAM
	db 24, FROST_BREATH
	db 28, ICY_PULSE
	db 34, AURORA_BEAM
	db 40, RECOVER
	db 42, GROWTH
	db 44, BODY_SLAM
	db 46, ICE_BEAM
	db 50, WATER_PULSE
	db 55, NEUROTOXIN
	db 57, BIND
	db 61, AQUA_JET
	db 67, IRON_DEFENSE
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Water/Ice fortress. NEUROTOXIN
; (Forte G Shellder-line high). SPIKE_CANNON via SONICBOOM.
; EXPLOSION (clam shells crack).
	db  1, TACKLE
	db  5, WITHDRAW
	db 10, SUPERSONIC
	db 14, ICY_WIND
	db 18, CLAMP
	db 20, WATER_GUN
	db 22, BUBBLEBEAM
	db 24, FROST_BREATH
	db 28, ICY_PULSE
	db 34, AURORA_BEAM
	db 40, RECOVER
	db 42, GROWTH
	db 44, BODY_SLAM
	db 46, ICE_BEAM
	db 48, ROCK_TOMB
	db 50, WATER_PULSE
	db 53, HYDRO_PUMP
	db 55, NEUROTOXIN
	db 57, BIND
	db 59, BLIZZARD
	db 61, AQUA_JET
	db 63, HEAVY_SLAM
	db 65, ROCK_SLIDE
	db 67, IRON_DEFENSE
	db 69, EXPLOSION
	db 0

GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HAUNTER
	db 0
; Learnset
; v0.7 13-rules sweep: Onix strategy (pairs of 2 per level, wide
; gaps) rebuilt from Forte's own pair annotations: NIGHT_SHADE+
; Gastly carries the shared backbone (14 moves, pre-evo).
	db  1, LICK
	db  5, SMOG
	db  9, ASTONISH
	db 13, CONFUSE_RAY
	db 17, NIGHT_SHADE
	db 17, WILL_O_WISP
	db 22, POISON_GAS
	db 26, FAINT_ATTACK
	db 26, SHADOW_SNEAK
	db 30, PSYWAVE
	db 34, DISABLE
	db 34, NASTY_PLOT
	db 38, LEER
	db 38, SCARY_FACE
	db 44, SPIRIT_DRAIN
	db 0

HaunterEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, GENGAR
	db 0
; Learnset
; v0.7 13-rules sweep: Onix strategy (pairs of 2 per level, wide
; gaps) rebuilt from Forte's own pair annotations: NIGHT_SHADE+
; + SHADOW_BALL at its own evo L42.
	db  1, LICK
	db  5, SMOG
	db  9, ASTONISH
	db 13, CONFUSE_RAY
	db 17, NIGHT_SHADE
	db 17, WILL_O_WISP
	db 22, POISON_GAS
	db 26, FAINT_ATTACK
	db 26, SHADOW_SNEAK
	db 30, PSYWAVE
	db 34, DISABLE
	db 34, NASTY_PLOT
	db 38, LEER
	db 38, SCARY_FACE
	db 42, SHADOW_PUNCH
	db 44, SHADOW_BALL
	db 46, SPIRIT_DRAIN
	db 46, EXTRASENSORY
	db 50, ICY_WIND
	db 50, SLUDGE
	db 54, DARK_PULSE
	db 54, INTIMIDATE
	db 58, GROWTH
	db 58, TOXIC
	db 0

GengarEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 13-rules sweep: Onix strategy (pairs of 2 per level, wide
; gaps) rebuilt from Forte's own pair annotations: NIGHT_SHADE+
; WILL_O_WISP, sneak-pair AT the Gastly evo L26, NASTY_PLOT+DISABLE,
; SHADOW_BALL at the Haunter evo L42, SHADOW_PUNCH+EXTRASENSORY,
; DARK_PULSE+INTIMIDATE, DEEP_SLEEP+DREAM_EATER (eats what it puts
; to sleep), RECOVER+EXPLOSION, PSYCHIC_M at L70 (Forte note).
; Gengar = 30 moves (R2 cap; ICY_PULSE cut — ICY_WIND covers ice).
	db  1, LICK
	db  5, SMOG
	db  9, ASTONISH
	db 13, CONFUSE_RAY
	db 17, NIGHT_SHADE
	db 17, WILL_O_WISP
	db 22, POISON_GAS
	db 26, FAINT_ATTACK
	db 26, SHADOW_SNEAK
	db 30, PSYWAVE
	db 34, DISABLE
	db 34, NASTY_PLOT
	db 38, LEER
	db 38, SCARY_FACE
	db 42, SHADOW_PUNCH
	db 44, SHADOW_BALL
	db 46, SPIRIT_DRAIN
	db 46, EXTRASENSORY
	db 50, ICY_WIND
	db 50, SLUDGE
	db 54, DARK_PULSE
	db 54, INTIMIDATE
	db 58, GROWTH
	db 58, TOXIC
	db 62, DEEP_SLEEP
	db 62, DREAM_EATER
	db 66, EXPLOSION
	db 66, RECOVER
	db 68, HAZE
	db 70, PSYCHIC_M
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
	db  8, BIND
	db  8, COIL
	db 12, BIDE
	db 12, LEER
	db 15, HEADBUTT
	db 18, ROCK_THROW
	db 22, BULLDOZE
	db 25, BODY_SLAM
	db 25, STRENGTH
	db 28, TAKE_DOWN
	db 31, ROCK_TOMB
	db 34, FIERCE_ROAR
	db 37, CRUNCH
	db 37, DIG
	db 43, HEAD_SMASH
	db 46, BRUTAL_SWING
	db 46, IRON_TAIL
	db 49, EARTHQUAKE
	db 51, ROCK_SLIDE
	db 53, IRON_DEFENSE
	db 55, IRON_HEAD
	db 57, INTIMIDATE
	db 60, DRAGON_BREATH
	db 63, HEAVY_SLAM
	db 65, DRAGON_SLAM
	db 67, FISSURE
	db 70, HYPER_BEAM
	db 0

DrowzeeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, HYPNO
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Psychic hypnotist. HYPNOSIS L1 (Forte
; sec C low). DEEP_SLEEP signature (Forte sec C Drowzee-line).
; DREAM_EATER signature (Forte sec G). EERIE_IMPULSE (Forte sec F).
; AMNESIA (Forte sec E). DARK_PULSE (Forte sec G).
	db  1, HYPNOSIS
	db  4, PSYWAVE
	db  7, DISABLE
	db 10, HEADBUTT
	db 13, LICK
	db 16, POISON_GAS
	db 19, CONFUSION
	db 22, NASTY_PLOT
	db 25, EERIE_IMPULSE
	db 28, NIGHT_SHADE
	db 31, EXTRASENSORY
	db 34, SMOG
	db 37, PSYCHIC_BIND
	db 40, DEEP_SLEEP
	db 43, DREAM_EATER
	db 49, DARK_PULSE
	db 52, PSYBEAM
	db 61, PSYCHIC_M
	db 0

HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex hypnotist. 12 backbone (Drowzee)
; + 2 Hypno-exclusives: SCARY_FACE (Forte sec F via levelup list),
; CALM_MIND (Forte sec E).
	db  1, HYPNOSIS
	db  4, PSYWAVE
	db  7, DISABLE
	db 10, HEADBUTT
	db 13, LICK
	db 16, POISON_GAS
	db 19, CONFUSION
	db 22, NASTY_PLOT
	db 25, EERIE_IMPULSE
	db 28, NIGHT_SHADE
	db 31, EXTRASENSORY
	db 34, SMOG
	db 37, PSYCHIC_BIND
	db 40, DEEP_SLEEP
	db 43, DREAM_EATER
	db 46, SCARY_FACE
	db 49, DARK_PULSE
	db 52, PSYBEAM
	db 55, SHADOW_PUNCH
	db 58, REFLECT
	db 61, PSYCHIC_M
	db 65, SHADOW_BALL
	db 0

KrabbyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, KINGLER
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte corrections): scrappy pincer crab. VICEGRIP is
; a SHARED signature (Krabby-line + Pinsir, per Forte). CRABHAMMER
; signature at evo L28. WATER_GUN early (Forte). HARDEN carapace;
; MUD_SHOT beach burrower; FURY_ATTACK pincer jabs; GUILLOTINE apex
; pincer (vanilla canon, shared with Kingler).
	db 11, WATER_GUN
	db 13, HARDEN
	db 15, MUD_SHOT
	db 17, VICEGRIP
	db 21, BUBBLEBEAM
	db 24, FURY_ATTACK
	db 26, BIND
	db 28, CRABHAMMER
	db 34, WATER_PULSE
	db 44, GUILLOTINE
	db 0

KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte corrections): apex crusher crab (110 Atk /
; 110 Def). Shared Krabby backbone at the same levels (BIND medium-level
; before CRABHAMMER, per Forte); adds the heavy-claw kit: STRENGTH/CUT
; (shear claw), WATERFALL, BRUTAL_SWING (massive claw sweep).
; No IRON_DEFENSE (organic chitin hardens via HARDEN; steel flavor is
; for mineral/metal bodies — no reviewed mon has both). SURF is HM-only
; (Forte); SWORDS_DANCE stays TM-only.
	db 11, WATER_GUN
	db 13, HARDEN
	db 15, MUD_SHOT
	db 17, VICEGRIP
	db 21, BUBBLEBEAM
	db 24, FURY_ATTACK
	db 26, BIND
	db 28, CRABHAMMER
	db 30, STRENGTH
	db 32, CUT
	db 34, WATER_PULSE
	db 37, MUD_BOMB
	db 41, WATERFALL
	db 44, GUILLOTINE
	db 52, BRUTAL_SWING
	db 0

VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte r1): living pokeball — sphere, no limbs.
; HARDEN (a rigid metal sphere tightens its shell — it can't curl),
; METAL_SOUND (Steel typing, Forte F), ROLLOUT L29 (it IS a rolling
; ball — Forte r1 grants it beyond the Geodude line).
; EXPLOSION owner (Forte N), shared L44.
	db  9, SONICBOOM
	db 12, THUNDERSHOCK
	db 14, FLASH
	db 16, HARDEN
	db 19, THUNDER_WAVE
	db 23, METAL_SOUND
	db 26, SHOCK_WAVE
	db 29, ROLLOUT
	db 33, LIGHT_SCREEN
	db 38, THUNDERBOLT
	db 44, EXPLOSION
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte r1): apex sphere (130 Spd). AGILITY at evo
; L30 (full-speed roll). ROLLOUT shared (Forte r1). Screens pair,
; THUNDER apex top. EXPLOSION shared with Voltorb.
	db  9, SONICBOOM
	db 12, THUNDERSHOCK
	db 14, FLASH
	db 16, HARDEN
	db 19, THUNDER_WAVE
	db 23, METAL_SOUND
	db 26, SHOCK_WAVE
	db 29, ROLLOUT
	db 31, AGILITY
	db 33, LIGHT_SCREEN
	db 36, DOUBLE_TEAM
	db 38, THUNDERBOLT
	db 41, REFLECT
	db 44, EXPLOSION
	db 50, THUNDER
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): egg cluster Grass/Psychic. Powder
; table: NÃO powders (Forte: usa Hypnosis psíquica em vez).
; GROWTH (Forte plant list). EXPLOSION (eggs explodem literal).
; Removido STUN_POWDER/POISONPOWDER/SLEEP_POWDER (Forte powder
; table NÃO), REFLECT (Exeggcute não em Forte F LIGHT_SCREEN list).
	db  1, SOFTBOILED
	db  4, AMNESIA
	db  7, BIDE
	db 10, LEECH_SEED
	db 14, MEGA_DRAIN
	db 17, CONFUSION
	db 20, GROWTH
	db 27, EERIE_IMPULSE
	db 30, DISABLE
	db 33, HYPNOSIS
	db 43, PETAL_DANCE
	db 46, PSYBEAM
	db 56, PSYCHIC_M
	db 60, DARK_PULSE
	db 0

ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex egg-tree. 13 backbone (Exeggcute)
; + 2 Exeggutor-exclusives: DEEP_SLEEP (Forte sec C signature deep
; hypnosis após HYPNOSIS), HEAVY_SLAM (giant tree slam).
	db  1, SOFTBOILED
	db  4, AMNESIA
	db  7, BIDE
	db 10, LEECH_SEED
	db 14, MEGA_DRAIN
	db 17, CONFUSION
	db 20, GROWTH
	db 23, HEADBUTT
	db 27, EERIE_IMPULSE
	db 30, DISABLE
	db 33, HYPNOSIS
	db 37, GROUND_STOMP
	db 40, BODY_SLAM
	db 43, PETAL_DANCE
	db 46, PSYBEAM
	db 50, DOUBLE_EDGE
	db 53, SOLARBEAM
	db 56, PSYCHIC_M
	db 60, DARK_PULSE
	db 0

CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, MAROWAK
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): bone-wielder small reptile-mammal, sad lonely
; lore. FAIRY_WIND Cubone-only (Forte: baby Fairy presence pre-evo). TACKLE
; L10/BONE_CLUB L13 (Forte explicit). FIERCE_ROAR L13 junto a BONE_CLUB
; (Forte). HEADBUTT L18, FAINT_ATTACK L20 (Forte). BULK_UP L28 junto a RAGE
; (Forte). HEAD_SMASH/DOUBLE_EDGE muito mais cedo (Forte: era L54/L60, agora
; L36/L44). GROWTH Cubone-only (Forte add). FOCUS_ENERGY removido (Forte).
; TAIL_WHIP removido (Forte).
	db  1, GROWL
	db  4, FAIRY_WIND
	db 10, TACKLE
	db 13, BONE_CLUB
	db 13, FIERCE_ROAR
	db 18, HEADBUTT
	db 20, FAINT_ATTACK
	db 22, RECOVER
	db 26, BONEMERANG
	db 28, BULK_UP
	db 28, RAGE
	db 34, BULLDOZE
	db 40, GROWTH
	db 44, DOUBLE_EDGE
	db 44, HEAD_SMASH
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex bone-wielder, ghost-mother lore unlocked.
; 12 backbone (Cubone sem FAIRY_WIND/RECOVER/GROWTH per Forte) + 14
; Marowak-exclusives: DARK_PULSE (gains on evolving, L28), BIDE+EERIE_IMPULSE
; pouco depois evo (Forte add), DISABLE (Forte add), SPIRIT_DRAIN muito mais
; cedo (Forte: L36 not late), INTIMIDATE/SCARY_FACE/NIGHT_SHADE/THRASH/
; OUTRAGE/GORE_ATTACK/FISSURE/STRENGTH (HM)/EXPLOSION apex L65 (Forte:
; "estender até L65"). Removido GLARE/RECOVER/GROWTH (Forte explicit).
	db  1, GROWL
	db 10, TACKLE
	db 13, BONE_CLUB
	db 13, FIERCE_ROAR
	db 18, HEADBUTT
	db 20, FAINT_ATTACK
	db 26, BONEMERANG
	db 28, BULK_UP
	db 28, RAGE
	db 30, BIDE
	db 30, EERIE_IMPULSE
	db 32, DARK_PULSE
	db 34, BULLDOZE
	db 36, NIGHT_SHADE
	db 36, SPIRIT_DRAIN
	db 38, INTIMIDATE
	db 40, SCARY_FACE
	db 44, HEAD_SMASH
	db 44, THRASH
	db 46, DISABLE
	db 50, DOUBLE_EDGE
	db 54, GORE_ATTACK
	db 58, OUTRAGE
	db 60, FISSURE
	db 65, EXPLOSION
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
	db  1, LEER
	db  1, LOW_KICK
	db  8, GROUND_STOMP
	db 14, FOCUS_ENERGY
	db 18, CALM_MIND
	db 22, QUICK_ATTACK
	db 26, TAKE_DOWN
	db 30, BULK_UP
	db 34, SEISMIC_TOSS
	db 36, BULLDOZE
	db 40, AGILITY
	db 42, FAINT_ATTACK
	db 46, ROLLING_KICK
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
	db  1, DEFENSE_CURL
	db  1, QUICK_ATTACK
	db  8, MACH_PUNCH
	db 14, FOCUS_ENERGY
	db 18, CALM_MIND
	db 22, COMET_PUNCH
	db 26, DIZZY_PUNCH
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
; v0.7 Pass 3 (Forte review): Normal/Poison reptile-camaleao tongue. LICK
; signature. SCREECH antes do SUPERSONIC, HEADBUTT depois (Forte). HINDER
; low (Forte add). ASTONISH/DEFENSE_CURL/BIDE/EERIE_IMPULSE/TAUNT/DISABLE/
; SEISMIC_TOSS adicionados (Forte). CONSTRICT em vez de BIND, BIND mais
; tarde (Forte). Removido: SLAM (Forte: já não existe; só DRAGON_SLAM que
; não queremos), THRASH (Forte), GUNK_SHOT (Grimer-only signature),
; HYPER_FANG (Raticate-coded), NEUROTOXIN (kit Poison reduzido), SLUDGE
; (Tentacool/Grimer-only).
	db  1, LICK
	db  4, DEFENSE_CURL
	db  7, SCREECH
	db 10, HINDER
	db 12, HEADBUTT
	db 15, CONSTRICT
	db 20, SUPERSONIC
	db 23, ASTONISH
	db 26, BIDE
	db 29, TAUNT
	db 32, ACID
	db 35, BIND
	db 38, EERIE_IMPULSE
	db 41, DISABLE
	db 44, GROUND_STOMP
	db 48, BODY_SLAM
	db 52, SEISMIC_TOSS
	db 56, TOXIC
	db 60, DOUBLE_EDGE
	db 65, BRUTAL_SWING
	db 0

KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, WEEZING
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): gas balloon Poison/Gas. Forte sec J
; Weezing kit: acid/sludge/toxic + Gas type only. EXPLOSION apex.
; Removido SLUDGE_WAVE (só Grimer/Tentacool lines), GUNK_SHOT
; (Grimer-only signature).
	db  1, POISON_GAS
	db  4, SMOG
	db  7, SMOKESCREEN
	db 10, TAUNT
	db 13, DISABLE
	db 16, ACID
	db 19, EMBER
	db 22, BIDE
	db 25, GROWTH
	db 28, EERIE_IMPULSE
	db 31, NIGHT_SHADE
	db 34, SLUDGE
	db 37, HAZE
	db 40, LIGHT_SCREEN
	db 43, TOXIC
	db 46, SLUDGE_WAVE
	db 49, FLAMETHROWER
	db 55, EXPLOSION
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex gas balloon. 9 backbone (Koffing)
; + 1 Weezing-exclusive: CORRODE (Forte sec F Claude decide: yes,
; gas+sludge melts things). EXPLOSION apex shared no L60.
	db  1, POISON_GAS
	db  4, SMOG
	db  7, SMOKESCREEN
	db 10, TAUNT
	db 13, DISABLE
	db 16, ACID
	db 19, EMBER
	db 22, BIDE
	db 25, GROWTH
	db 28, EERIE_IMPULSE
	db 31, NIGHT_SHADE
	db 34, SLUDGE
	db 37, HAZE
	db 40, LIGHT_SCREEN
	db 43, TOXIC
	db 46, SLUDGE_WAVE
	db 49, FLAMETHROWER
	db 52, SCARY_FACE
	db 55, EXPLOSION
	db 58, CORRODE
	db 61, GUNK_SHOT
	db 65, DARK_PULSE
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
	db 13, GROUND_STOMP
	db 13, SAND_ATTACK
	db 16, ROCK_TOMB
	db 19, BODY_SLAM
	db 22, FOCUS_ENERGY
	db 22, RAGE
	db 28, BULLDOZE
	db 40, HEAD_SMASH
	db 44, TAKE_DOWN
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
	db 13, GROUND_STOMP
	db 13, SAND_ATTACK
	db 16, ROCK_TOMB
	db 19, BODY_SLAM
	db 22, FOCUS_ENERGY
	db 22, RAGE
	db 28, BULLDOZE
	db 40, HEAD_SMASH
	db 42, HORN_CHARGE
	db 42, STRENGTH
	db 44, TAKE_DOWN
	db 46, IRON_HEAD
	db 48, EARTHQUAKE
	db 52, FIERCE_ROAR
	db 58, BRUTAL_SWING
	db 61, THRASH
	db 64, HORN_DRILL
	db 67, FISSURE
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Normal/Fairy heal-tank. Forte sec J:
; SOFTBOILED signature (Chansey ONLY), SING após L30, CHARM/
; FAIRY_WIND/GROWL. NÃO TAIL_WHIP (cauda pequena), NÃO DEFENSE_CURL
; (não ball-shape). Heal-tank kit + LIGHT_SCREEN/REFLECT support.
	db  1, SOFTBOILED
	db  3, GROWL
	db  6, FAIRY_WIND
	db  9, DOUBLESLAP
	db 12, CALM_MIND
	db 15, CHARM
	db 17, SING
	db 20, TICKLE
	db 23, DRAINING_KISS
	db 26, DISABLE
	db 29, EXTRASENSORY
	db 31, LIGHT_SCREEN
	db 34, HEADBUTT
	db 37, BIDE
	db 40, PAY_DAY
	db 43, SEISMIC_TOSS
	db 45, REFLECT
	db 48, DAZZLE_GLEAM
	db 51, FAKE_TEARS
	db 54, PETAL_DANCE
	db 57, MOONBLAST
	db 60, METRONOME
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Grass vines single-stage. Powder
; table: APENAS STUN_POWDER (Forte sec C). Forte sec J kit:
; VINE_WHIP/MEGA_DRAIN/GIGA_DRAIN/WRAP/CONSTRICT/GROWTH/SOLARBEAM.
; CUT HM01 natural (Forte sec B). Removido STRING_SHOT (não
; existe), RECOVER (Tangela não em RECOVER list).
	db  1, ABSORB
	db  3, GROWTH
	db  6, WRAP
	db  9, TICKLE
	db 12, DEFENSE_CURL
	db 15, CONSTRICT
	db 17, LICK
	db 20, VINE_WHIP
	db 23, WATER_GUN
	db 26, TACKLE
	db 29, LEECH_SEED
	db 31, STUN_POWDER
	db 34, BIND
	db 37, BUBBLEBEAM
	db 40, ASTONISH
	db 43, MEGA_DRAIN
	db 45, RECOVER
	db 48, BODY_SLAM
	db 51, WATER_PULSE
	db 54, PETAL_DANCE
	db 57, LEECH_LIFE
	db 60, GIGA_DRAIN
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4): protective savanna mother. SAND_ATTACK
; early (kicks sand to cover the cub's retreat), COMET_PUNCH early
; (L1 relearn pattern), DIZZY_PUNCH HIGH (her canon signature punch,
; per Forte — placed before TAKE_DOWN to keep the FIGHTING ladder
; 19<45<75<80). THRASH not OUTRAGE; no DOUBLE_EDGE (mother with a
; baby is never reckless). BIND = restraining grab; BIDE = endures.
	db 10, TAIL_WHIP
	db 12, SAND_ATTACK
	db 14, BIND
	db 16, BITE
	db 18, COMET_PUNCH
	db 20, GROUND_STOMP
	db 23, SEISMIC_TOSS
	db 27, FIERCE_ROAR
	db 29, BIDE
	db 31, BULK_UP
	db 36, BODY_SLAM
	db 40, STRENGTH
	db 48, DIZZY_PUNCH
	db 52, TAKE_DOWN
	db 56, THRASH
	db 0

HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, SEADRA
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4 density): ink-spitting seahorse. WATER_GUN
; early (Forte). ICY_WIND added (cold-current rider, pre-ICY_PULSE).
; DRAGON_RAGE at evo L26 = dragon blood awakening (key level).
	db 10, SMOKESCREEN
	db 12, WATER_GUN
	db 14, LEER
	db 16, ICY_WIND
	db 18, BUBBLEBEAM
	db 20, AQUA_JET
	db 22, AGILITY
	db 26, DRAGON_RAGE
	db 31, WATER_PULSE
	db 36, ICY_PULSE
	db 47, HYDRO_PUMP
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4): Water/DRAGON. Horsea backbone + dragon
; kit: DRAGON_BREATH post-evo, ICE_BEAM, DRAGON_SLAM apex.
; No DRAGON_CLAW (no claws).
	db 10, SMOKESCREEN
	db 12, WATER_GUN
	db 14, LEER
	db 16, ICY_WIND
	db 18, BUBBLEBEAM
	db 20, AQUA_JET
	db 22, AGILITY
	db 26, DRAGON_RAGE
	db 28, DRAGON_BREATH
	db 31, WATER_PULSE
	db 33, WATERFALL
	db 36, ICY_PULSE
	db 42, ICE_BEAM
	db 47, HYDRO_PUMP
	db 52, DRAGON_SLAM
	db 0

GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, SEAKING
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4 density): horned river fish. WATERFALL at
; evo L24 = the salmon climb (key level). TAIL_WHIP early (L1 relearn
; pattern), BIDE (stubborn river fish), ICY_PULSE (cold streams).
	db 10, TAIL_WHIP
	db 13, HORN_ATTACK
	db 15, SUPERSONIC
	db 18, BUBBLEBEAM
	db 21, FURY_ATTACK
	db 24, WATER_PULSE
	db 28, BIDE
	db 30, AGILITY
	db 33, ICY_PULSE
	db 36, WATERFALL
	db 44, HORN_CHARGE
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r7): apex river guardian. Goldeen backbone +
; RAGE (territorial males duel), SURF, MEGAHORN top. No HORN_DRILL
; (Forte r7): the horn identity is HORN_ATTACK -> HORN_CHARGE ->
; MEGAHORN.
	db 10, TAIL_WHIP
	db 13, HORN_ATTACK
	db 15, SUPERSONIC
	db 18, BUBBLEBEAM
	db 21, FURY_ATTACK
	db 24, WATER_PULSE
	db 26, RAGE
	db 28, BIDE
	db 30, AGILITY
	db 33, ICY_PULSE
	db 36, WATERFALL
	db 40, ICE_BEAM
	db 44, HORN_CHARGE
	db 48, SURF
	db 54, MEGAHORN
	db 0

StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, STARMIE
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte r1): star with a regenerating gem core.
; MOON_STONE evolution (Forte spec fix). r1 adds: EERIE_IMPULSE
; (alien gem pulses) + DAZZLE_GLEAM (gem light burst). RECOVER L25
; (core regen), FLASH L29 (gem light), HARDEN (crystal body).
; Stone-evo line: pre-evo carries the full kit (Clefairy pattern).
	db 10, HARDEN
	db 13, WATER_GUN
	db 17, PSYWAVE
	db 21, BUBBLEBEAM
	db 25, RECOVER
	db 29, FLASH
	db 31, EERIE_IMPULSE
	db 33, WATER_PULSE
	db 35, DAZZLE_GLEAM
	db 37, PSYBEAM
	db 42, LIGHT_SCREEN
	db 48, HYDRO_PUMP
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte r1): Water/Psychic mystic star. Staryu
; backbone + screens pair, CALM_MIND, SURF before the shared
; HYDRO_PUMP, PSYCHIC_M apex, MOONBLAST high-level (Forte r1 —
; the core IS a moon-gem).
	db 10, HARDEN
	db 13, WATER_GUN
	db 17, PSYWAVE
	db 21, BUBBLEBEAM
	db 25, RECOVER
	db 29, FLASH
	db 31, EERIE_IMPULSE
	db 33, WATER_PULSE
	db 35, DAZZLE_GLEAM
	db 37, PSYBEAM
	db 39, REFLECT
	db 42, LIGHT_SCREEN
	db 44, CALM_MIND
	db 46, SURF
	db 48, HYDRO_PUMP
	db 56, PSYCHIC_M
	db 60, MOONBLAST
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Psychic/Fairy mime, single-stage. All
; 4 fun moves via NATURAL levelup (Forte sec A — MrMime explicit).
; Forte sec J kit: LIGHT_SCREEN/REFLECT canonical, DAZZLE_GLEAM,
; FAIRY_WIND, CHARM, PSYCHIC_BIND. NÃO MOONBLAST (Forte sec J).
	db  1, CHARM
	db  4, FAIRY_WIND
	db  7, HINDER
	db 10, CONFUSION
	db 13, FAKE_TEARS
	db 16, MIRROR_MOVE
	db 19, MIMIC
	db 22, PSYCHIC_BIND
	db 25, LIGHT_SCREEN
	db 28, REFLECT
	db 32, AMNESIA
	db 35, DISABLE
	db 38, EXTRASENSORY
	db 41, HYPNOSIS
	db 44, DAZZLE_GLEAM
	db 47, DOUBLE_TEAM
	db 50, SUBSTITUTE
	db 53, PETAL_DANCE
	db 56, PSYCHIC_M
	db 60, METRONOME
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4): mantis blade-NINJA. Forte adds the speed/
; stealth kit: QUICK_ATTACK, FAINT_ATTACK, SHADOW_SNEAK (ambush
; phantom), ASTONISH (startle strike — deliberated KEPT per Forte's
; delegation: the mantis threat-display IS a startle, opening the
; stealth trio ASTONISH -> SHADOW_SNEAK -> FAINT_ATTACK),
; EXTREMESPEED L56 (agile + superhuman reflexes — G
; filter fits perfectly). L1 = SCRATCH (basic swipe) + LEER.
; Blade ladder SLASH -> CUT -> NIGHT_SLASH; HONE_CLAWS = sharpening
; the scythes; GUILLOTINE last (mantis decapitation). SD L52.
; No BUG_BUZZ (Forte r4: Butterfree + Venomoth only).
	db 10, QUICK_ATTACK
	db 12, FOCUS_ENERGY
	db 14, ASTONISH
	db 16, BUG_BITE
	db 18, WING_ATTACK
	db 20, SLASH
	db 23, FAINT_ATTACK
	db 26, HONE_CLAWS
	db 29, AGILITY
	db 32, SHADOW_SNEAK
	db 35, CUT
	db 38, AERIAL_ACE
	db 42, NIGHT_SLASH
	db 47, FLY
	db 52, SWORDS_DANCE
	db 56, EXTREMESPEED
	db 60, GUILLOTINE
	db 0

JynxEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Ice/Psychic Fairy-coded singer. 26 moves big
; movepool. POWDER_SNOW antes de ICY_WIND (Forte). DOUBLESLAP cedo (Forte).
; TICKLE low (Forte add). NASTY_PLOT replaces CALM_MIND mais cedo (Forte).
; SING após L30 (Forte sec C). DRAINING_KISS/CHARM/FAIRY_WIND/PSYCHIC_BIND/
; NIGHT_SHADE/DOUBLE_TEAM/SPIRIT_DRAIN/SHADOW_BALL/DISABLE/EERIE_IMPULSE/
; CONFUSE_RAY/FROST_BREATH/LIGHT_SCREEN adicionados (Forte). DREAM_EATER
; high (Forte sec G Jynx YES, apex). POUND removido (já não existe). PSYBEAM
; removido (Forte). DARK_PULSE só TM (Forte). ICY_PULSE/SCARY_FACE só TM
; (Forte). SMOKESCREEN/FAKE_TEARS/SCREECH/CONFUSE_RAY removidos (Forte
; slim; CONFUSE_RAY redundante com LOVELY_KISS que já dá confusion). Total
; 26 moves. PLAY_ROUGH NÃO (Claude: singer elegante, não rough biter).
	db  1, LICK
	db  4, TICKLE
	db  7, LOVELY_KISS
	db  9, FAIRY_WIND
	db 11, POWDER_SNOW
	db 14, ICY_WIND
	db 16, DOUBLESLAP
	db 18, NASTY_PLOT
	db 20, PSYWAVE
	db 22, EERIE_IMPULSE
	db 28, FROST_BREATH
	db 30, SING
	db 32, DRAINING_KISS
	db 34, CHARM
	db 38, DISABLE
	db 44, ICY_PULSE
	db 47, LIGHT_SCREEN
	db 49, EXTRASENSORY
	db 51, NIGHT_SHADE
	db 53, DOUBLE_TEAM
	db 55, SHADOW_BALL
	db 57, AURORA_BEAM
	db 59, SPIRIT_DRAIN
	db 61, ICE_BEAM
	db 63, BLIZZARD
	db 65, DARK_PULSE
	db 0

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): boxer Electric counterpart de Magmar. NUZZLE
; L1 (Forte). SCREECH/THUNDER_WAVE muito mais cedo (Forte). MACH_PUNCH um
; pouco mais tarde (Forte). DIZZY_PUNCH em vez de KARATE_CHOP (Forte).
; FAINT_ATTACK adicionado. STRENGTH apenas via HM (Forte). FLASH por
; levelup (Forte: era HM only). FLAME_CHARGE/MAGNET_BOMB high (Forte add).
; BULK_UP talvez yes (Forte). EXTREMESPEED/AGILITY very high (Forte). SEM
; SOLARBEAM (Forte question — não, boxer Electric não é solar-coded).
	db  1, LEER
	db  1, NUZZLE
	db  4, QUICK_ATTACK
	db  4, THUNDERSHOCK
	db  7, LOW_KICK
	db  9, SCREECH
	db 11, DIZZY_PUNCH
	db 13, THUNDER_WAVE
	db 15, SHOCK_WAVE
	db 18, LIGHT_SCREEN
	db 22, FAINT_ATTACK
	db 26, MACH_PUNCH
	db 30, BULK_UP
	db 34, FLASH
	db 40, METAL_SOUND
	db 42, FLAME_CHARGE
	db 48, THUNDERBOLT
	db 55, AGILITY
	db 58, THUNDER
	db 60, EXTREMESPEED
	db 65, MAGNET_BOMB
	db 0

MagmarEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Fire/MAGMA boxer counterpart de Electabuzz.
; IGNITE L1 egg-move (Forte). POISON_GAS L4 (Forte add — vent toxic gas).
; ROCK_PUNCH depois de MAGMA_PUNCH (Forte). SEISMIC_TOSS/FLAME_BURST/
; CORRODE/SOLARBEAM/EXPLOSION adicionados (Forte). ROCK_TOMB + GROWTH
; via levelup (Forte: questions answered yes). HM CUT (Forte add).
; FLAME_CHARGE removido (Forte). SEM DRAGON_RAGE/DRAGON_BREATH
; (Forte question — não, Magmar é Fire/MAGMA não Dragon).
	db  4, POISON_GAS
	db  7, SMOKESCREEN
	db  9, IGNITE
	db 11, CONFUSE_RAY
	db 14, MAGMA_PUNCH
	db 16, ROCK_PUNCH
	db 18, SEISMIC_TOSS
	db 22, FOCUS_ENERGY
	db 25, ROCK_TOMB
	db 27, LAVA_PLUME
	db 30, FLAME_BURST
	db 32, BODY_SLAM
	db 34, FLAMETHROWER
	db 38, CORRODE
	db 40, LIGHT_SCREEN
	db 44, GROWTH
	db 48, SOLARBEAM
	db 52, FIRE_BLAST
	db 56, ROCK_SLIDE
	db 60, HAZE
	db 65, EXPLOSION
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4): stag-beetle grappler. Egg moves = TACKLE,
; CONSTRICT (Forte r4), VICEGRIP (shared almost-signature with the
; Krabby line). LOW_KICK removed (Forte r4). DIG L36 (dex canon:
; buries itself on cold nights; horns excavate) and DOUBLE_EDGE L54
; (stag beetles ram full-body in duels) — both Forte-approved r4.
; No SLASH (no claws), no SUBMISSION (Machamp/Poliwrath), no
; BUG_BUZZ (silent — no buzzing wings).
	db  8, HARDEN
	db 10, FOCUS_ENERGY
	db 13, BIDE
	db 17, SEISMIC_TOSS
	db 21, BUG_BITE
	db 25, BIND
	db 29, STRENGTH
	db 33, BULK_UP
	db 36, DIG
	db 40, BODY_SLAM
	db 42, TAKE_DOWN
	db 46, GORE_ATTACK
	db 50, MEGAHORN
	db 52, THRASH
	db 54, DOUBLE_EDGE
	db 56, CUT
	db 60, GUILLOTINE
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte r1): potente touro selvagem — Forte's
; identity kit (Charge/Horn Charge/Thrash/Outrage/Take Down/Gore/
; Intimidate/Scary Face/Bide/Strength) + r1 adds: BULLDOZE,
; SWORDS_DANCE, DOUBLE_EDGE; SCARY_FACE later; OUTRAGE is the LAST
; move, after HORN_DRILL (Forte r1). No EXTREMESPEED (fast, not
; agile).
	db 10, LEER
	db 13, HORN_ATTACK
	db 17, RAGE
	db 20, GROUND_STOMP
	db 24, FOCUS_ENERGY
	db 28, BIDE
	db 30, BULLDOZE
	db 32, BODY_SLAM
	db 36, INTIMIDATE
	db 40, STRENGTH
	db 44, TAKE_DOWN
	db 46, SWORDS_DANCE
	db 48, HORN_CHARGE
	db 50, THRASH
	db 54, SCARY_FACE
	db 56, GORE_ATTACK
	db 58, DOUBLE_EDGE
	db 60, HORN_DRILL
	db 65, OUTRAGE
	db 0

MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GYARADOS
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): minimalist Water (canon weakest).
; GROWL L1 (SPLASH removido em v0.7). 5 moves total — fiel ao canon.
; RAGE L26 = at evo (signature anger explosion ao evoluir).
	db  1, GROWL
	db  3, TACKLE
	db  5, WATER_GUN
	db  8, BIDE
	db 10, RAGE
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Water/Dragon-coded sea-serpent apex.
; Forte sec I: forte/bruto, mainly PHYSICAL, NÃO dócil. HYPER_BEAM
; L65 last move (Forte sec G). 5 backbone (Magikarp) + 13 Gyarados-
; exclusives: BITE evo, INTIMIDATE/SCARY_FACE, COIL (Forte sec E
; snake-coil), DRAGON_BREATH/THRASH/OUTRAGE Dragon-coded, SURF/
; STRENGTH HMs.
	db  1, GROWL
	db  3, TACKLE
	db  5, WATER_GUN
	db  8, BIDE
	db 10, RAGE
	db 13, BITE
	db 15, WATER_PULSE
	db 18, COIL
	db 20, BODY_SLAM
	db 23, WATERFALL
	db 25, FIERCE_ROAR
	db 28, CRUNCH
	db 30, SURF
	db 32, DRAGON_RAGE
	db 35, TAKE_DOWN
	db 37, INTIMIDATE
	db 40, DRAGON_BREATH
	db 42, HYDRO_PUMP
	db 45, THRASH
	db 47, DRAGON_SLAM
	db 50, BRUTAL_SWING
	db 52, HEAVY_SLAM
	db 55, OUTRAGE
	db 57, EARTHQUAKE
	db 60, HYPER_BEAM
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 v2 (+ Forte r1): gentle singing ferry. r1 adds: GROWL
; (also L1), FAIRY_WIND, FROST_BREATH, CHARM, BIDE, RECOVER high.
; PSYCHIC_M removed — Psychic damage (and the rest of the Fairy
; arsenal: Draining Kiss/Dazzle Gleam/Moonblast) is TM-only here.
; ICE ladder strictly scaled: ICY_WIND 45 < FROST_BREATH 50 <
; ICY_PULSE 65 < AURORA_BEAM 80 < ICE_BEAM 95 < BLIZZARD 115.
; SING after L30 (Forte C). STRENGTH = hauls passengers; SURF = THE
; ferry move. No THRASH/OUTRAGE (docile).
	db 10, GROWL
	db 12, ICY_WIND
	db 14, BUBBLEBEAM
	db 16, FAIRY_WIND
	db 18, BODY_SLAM
	db 20, FROST_BREATH
	db 22, ICY_PULSE
	db 26, CONFUSE_RAY
	db 28, CHARM
	db 30, SING
	db 32, BIDE
	db 34, WATER_PULSE
	db 38, AURORA_BEAM
	db 42, ICE_BEAM
	db 46, STRENGTH
	db 50, SURF
	db 54, BLIZZARD
	db 58, RECOVER
	db 62, HYDRO_PUMP
	db 0

DittoEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte-approved): TRANSFORM only, by design — no TMs,
; no other moves. Transform IS Ditto.
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
; v0.7 Pass 3 v2 (+ Forte r1): digital construct. Fun moves are
; NATURAL levelup here (Forte A: copy.exe/mirror.exe/decoy.exe/
; random.exe). r1 adds: DISABLE, THUNDER_WAVE, FLASH, REFLECT.
; TRI_ATTACK L46 signature, RECOVER (file restore), MAGNET_BOMB L58
; (shared signature with Magneton), HYPER_BEAM L65 last (Forte G).
; No NASTY_PLOT, no TRANSFORM (Ditto), no CONVERSION (gone).
	db 10, CONFUSION
	db 12, DISABLE
	db 14, AGILITY
	db 18, RECOVER
	db 20, THUNDER_WAVE
	db 22, SHOCK_WAVE
	db 26, MIMIC
	db 28, FLASH
	db 30, PSYBEAM
	db 34, MIRROR_MOVE
	db 38, LIGHT_SCREEN
	db 40, REFLECT
	db 42, METRONOME
	db 46, TRI_ATTACK
	db 50, SUBSTITUTE
	db 54, THUNDERBOLT
	db 58, MAGNET_BOMB
	db 65, HYPER_BEAM
	db 0

OmanyteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, OMASTAR
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): ammonite spiral shell Water/Rock.
; WITHDRAW shell (Forte sec F). Water+Rock physical kit. SURF
; HM03 natural (water type).
	db  1, WATER_GUN
	db  5, WITHDRAW
	db  9, HEADBUTT
	db 13, TICKLE
	db 18, CONSTRICT
	db 22, BIND
	db 26, AQUA_JET
	db 30, ROCK_THROW
	db 35, ICY_PULSE
	db 39, WATER_PULSE
	db 43, ROCK_TOMB
	db 56, HEAD_SMASH
	db 0

OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex ammonite. 11 backbone (Omanyte)
; + 2 Omastar-exclusives: STRENGTH HM04 natural (Forte sec B),
; ICE_BEAM apex (cold-water ammonite).
	db  1, WATER_GUN
	db  5, WITHDRAW
	db  9, HEADBUTT
	db 13, TICKLE
	db 18, CONSTRICT
	db 22, BIND
	db 26, AQUA_JET
	db 30, ROCK_THROW
	db 35, ICY_PULSE
	db 39, WATER_PULSE
	db 43, ROCK_TOMB
	db 47, IRON_DEFENSE
	db 52, HYDRO_PUMP
	db 56, HEAD_SMASH
	db 60, IRON_HEAD
	db 65, ICE_BEAM
	db 0

KabutoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, KABUTOPS
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): trilobite-crab Water/Rock. WITHDRAW
; (Forte sec F). ABSORB parasitic feed. Water+Rock physical kit.
	db  1, WATER_GUN
	db  5, WITHDRAW
	db  9, SCRATCH
	db 13, LEER
	db 18, ROCK_THROW
	db 22, BUBBLEBEAM
	db 26, ICY_PULSE
	db 30, SLASH
	db 35, MEGA_DRAIN
	db 39, CUT
	db 43, LEECH_LIFE
	db 47, ROCK_TOMB
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex trilobite-crab. 10 backbone
; (Kabuto) + 5 Kabutops-exclusives: CUT HM01 natural (Forte sec B),
; SURF HM03 natural, STRENGTH HM04 natural, SWORDS_DANCE (Forte
; sec E TM list — apex predator), NIGHT_SLASH (Dark slash claws).
	db  1, WATER_GUN
	db  5, WITHDRAW
	db  9, SCRATCH
	db 13, LEER
	db 18, ROCK_THROW
	db 22, BUBBLEBEAM
	db 26, ICY_PULSE
	db 30, SLASH
	db 35, MEGA_DRAIN
	db 39, CUT
	db 43, LEECH_LIFE
	db 47, ROCK_TOMB
	db 52, NIGHT_SLASH
	db 56, SWORDS_DANCE
	db 60, HEAD_SMASH
	db 65, GUILLOTINE
	db 0

AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): pterodactyl Rock/Flying apex predator,
; single-stage. Forte sec J: NÃO HYPER_BEAM, FLY/SKY_ATTACK/AGILITY/
; INTIMIDATE. CUT/FLY/STRENGTH HMs naturais (Forte sec B). NÃO
; EXTREMESPEED (Forte sec G explicit).
	db  1, BITE
	db  4, LEER
	db  7, TAILWIND
	db 11, WING_ATTACK
	db 14, FIERCE_ROAR
	db 18, ROCK_THROW
	db 21, AERIAL_ACE
	db 25, SCREECH
	db 28, FAINT_ATTACK
	db 32, FLY
	db 35, ROCK_TOMB
	db 39, CRUNCH
	db 42, AGILITY
	db 46, DRAGON_BREATH
	db 49, INTIMIDATE
	db 53, ROCK_SLIDE
	db 56, SWORDS_DANCE
	db 60, SKY_ATTACK
	db 0

SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4): gentle lazy giant. Egg moves = TACKLE +
; AMNESIA + REST. SMOG L13 early (post-banquet toxic belch — eats
; anything, Forte-approved). PLAY_ROUGH L34 (giant roughhousing,
; replaces ROCK_TOMB per Forte). TAKE_DOWN L54 replaces SUBMISSION
; (Machamp/Poliwrath signature). GROWTH (it grows!), ROLLOUT (rolls
; its bulk), BIND (bear hug), THRASH (woken fury). STRENGTH HM-only.
	db 10, LICK
	db 12, GROWTH
	db 14, SMOG
	db 16, DEFENSE_CURL
	db 18, BITE
	db 20, BIDE
	db 22, GROUND_STOMP
	db 24, BODY_SLAM
	db 26, BIND
	db 28, ROLLOUT
	db 31, BULK_UP
	db 34, PLAY_ROUGH
	db 38, CRUNCH
	db 44, BRUTAL_SWING
	db 48, THRASH
	db 52, HEAVY_SLAM
	db 54, TAKE_DOWN
	db 56, BULLDOZE
	db 58, DOUBLE_EDGE
	db 60, EARTHQUAKE
	db 0

ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4 density): parallel legendary-bird kit
; (PECK/GUST/LEER/WING_ATTACK/TAILWIND/AGILITY/AERIAL_ACE/FLY/
; FOCUS_ENERGY/HURRICANE/SKY_ATTACK at identical levels across the
; trio) + full ICE ladder. FOCUS_ENERGY early L16 (raptor fixing its
; prey — Forte r6: too weak for a high slot). Catch set @L50:
; AURORA_BEAM/FLY/ICE_BEAM/HURRICANE.
	db 10, PECK
	db 12, GUST
	db 14, LEER
	db 16, FOCUS_ENERGY
	db 18, ICY_WIND
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 28, FROST_BREATH
	db 30, AGILITY
	db 34, AERIAL_ACE
	db 36, AURORA_BEAM
	db 38, FLY
	db 42, ICE_BEAM
	db 50, HURRICANE
	db 55, BLIZZARD
	db 60, SKY_ATTACK
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r5): parallel trio kit + ELECTRIC ladder.
; DRILL_PECK L44 (Forte: "Zapdos tambem merece" — the electric dive-
; drill; ownership now Dodrio line + Fearow + Zapdos). Placed after
; FLY per the FLYING ladder (45<60<70<80<90). Trio symmetric 16/16/16.
; FOCUS_ENERGY early L16 (Forte r6). Catch set @L50: FLY/THUNDERBOLT/
; DRILL_PECK/HURRICANE.
	db 10, PECK
	db 12, GUST
	db 14, LEER
	db 16, FOCUS_ENERGY
	db 18, THUNDER_WAVE
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 28, SHOCK_WAVE
	db 30, AGILITY
	db 34, AERIAL_ACE
	db 38, FLY
	db 42, THUNDERBOLT
	db 44, DRILL_PECK
	db 50, HURRICANE
	db 55, THUNDER
	db 60, SKY_ATTACK
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r4 density): parallel trio kit + FIRE ladder
; (FLAME_CHARGE early — a flying flame; IGNITE = sets the sky on
; fire). FOCUS_ENERGY early L16 (Forte r6). Catch set @L50:
; FLAME_BURST/FLY/FLAMETHROWER/HURRICANE.
	db 10, PECK
	db 12, GUST
	db 14, LEER
	db 16, FOCUS_ENERGY
	db 18, FLAME_CHARGE
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 28, IGNITE
	db 30, AGILITY
	db 34, AERIAL_ACE
	db 36, FLAME_BURST
	db 38, FLY
	db 42, FLAMETHROWER
	db 50, HURRICANE
	db 55, FIRE_BLAST
	db 60, SKY_ATTACK
	db 0

DratiniEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DRAGONAIR
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Dragon sea-snake baby. WRAP canon
; start. COIL (Forte sec E snake-coil). DRAGON_BREATH first Dragon
; move pre-evo.
	db  1, TACKLE
	db  5, LEER
	db  9, COIL
	db 13, CONSTRICT
	db 17, BIND
	db 21, BODY_SLAM
	db 25, DRAGON_BREATH
	db 29, WATER_PULSE
	db 33, SHOCK_WAVE
	db 37, ICY_PULSE
	db 41, SURF
	db 53, DRAGON_SLAM
	db 0

DragonairEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 46, DRAGONITE
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): Dragon sea-serpent mid-evo. 7 backbone
; (Dratini) + 4 Dragonair-exclusives: DRAGON_SLAM (mid-tier Dragon),
; SURF (HM03 sea-snake natural), SHOCK_WAVE (Electric coverage),
; DRAGON_RAGE L46 = at evo (Forte sec I signature).
	db  1, TACKLE
	db  5, LEER
	db  9, COIL
	db 13, CONSTRICT
	db 17, BIND
	db 21, BODY_SLAM
	db 25, DRAGON_BREATH
	db 29, WATER_PULSE
	db 33, SHOCK_WAVE
	db 37, ICY_PULSE
	db 41, SURF
	db 43, DRAGON_RAGE
	db 46, FLY  ; (Evo lvl)
	db 53, DRAGON_SLAM
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (Forte review): apex Dragon. 11 backbone (Dragonair)
; + 7 Dragonite-exclusives: WING_ATTACK/AGILITY (wings appear evo),
; CUT/STRENGTH/FLY HMs naturais (Forte sec B), OUTRAGE L60 (Forte
; sec I), HYPER_BEAM L65 last move (Forte sec G).
	db  1, TACKLE
	db  5, LEER
	db  9, COIL
	db 13, CONSTRICT
	db 17, BIND
	db 21, BODY_SLAM
	db 25, DRAGON_BREATH
	db 29, WATER_PULSE
	db 33, SHOCK_WAVE
	db 37, ICY_PULSE
	db 41, SURF
	db 43, DRAGON_RAGE
	db 46, FLY  ; (Evo lvl)
	db 49, STRENGTH
	db 51, EXTRASENSORY
	db 53, DRAGON_SLAM
	db 55, BULLDOZE
	db 57, ROCK_TOMB
	db 59, TAKE_DOWN
	db 61, BRUTAL_SWING
	db 63, OUTRAGE
	db 65, HYPER_BEAM
	db 0

MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r7): psychic apex + honorary Dark. Egg moves =
; TACKLE/TELEPORT/CONFUSION/DISABLE (shared with Mew). Learns up to L75
; (Forte r7). r7 adds: QUICK_ATTACK, DISABLE relearn, FOCUS_ENERGY
; early (r6 rule), EERIE_IMPULSE, SHADOW_BALL back, OUTRAGE (the
; bitterness unleashed), EXTREMESPEED. NO CALM_MIND (Forte r7 — its
; mind is anything but calm). MIND_BREAK L60 signature; HYPER_BEAM L75
; LAST. No CHARM/FAKE_TEARS (not a manipulator).
	db 10, QUICK_ATTACK
	db 12, RECOVER
	db 14, DISABLE
	db 16, EXTRASENSORY
	db 18, FOCUS_ENERGY
	db 20, PSYCHIC_BIND
	db 24, AGILITY
	db 26, EERIE_IMPULSE
	db 28, LIGHT_SCREEN
	db 30, FAINT_ATTACK
	db 32, PSYBEAM
	db 36, REFLECT
	db 40, AMNESIA
	db 44, PSYCHIC_M
	db 48, INTIMIDATE
	db 52, DARK_PULSE
	db 55, SCARY_FACE
	db 58, SHADOW_BALL
	db 60, MIND_BREAK
	db 65, OUTRAGE
	db 70, EXTREMESPEED
	db 75, HYPER_BEAM
	db 0

MewEvosMoves:
; Evolutions
	db 0
; Learnset
; v0.7 Pass 3 (+ Forte r7): curious gentle ancestor (Psychic/FAIRY).
; Egg moves = TACKLE/TELEPORT/CONFUSION/DISABLE (shared with Mewtwo).
; Learns up to L75 (Forte r7). r7 adds: QUICK_ATTACK, AGILITY,
; LIGHT_SCREEN, REFLECT, and TRANSFORM back at L70 (Forte r7: canon
; wins — the ancestor unlocks its ultimate mimicry late; shared with
; Ditto). Claude deliberation per Forte: PLAY_ROUGH stays, MOONBLAST
; OUT — lunar blasts are Clefairy-line/Starmie identity; rough play IS
; Mew; and HYPER_BEAM already covers the nuke slot. All 4 fun moves
; natural (Forte A). HYPER_BEAM L75 last.
	db 10, CHARM
	db 13, QUICK_ATTACK
	db 16, FAIRY_WIND
	db 19, RECOVER
	db 22, MIMIC
	db 24, AGILITY
	db 26, DRAINING_KISS
	db 28, LIGHT_SCREEN
	db 30, EXTRASENSORY
	db 32, REFLECT
	db 34, MIRROR_MOVE
	db 36, TRI_ATTACK
	db 38, PSYBEAM
	db 42, DAZZLE_GLEAM
	db 45, CALM_MIND
	db 48, METRONOME
	db 52, PSYCHIC_M
	db 56, SUBSTITUTE
	db 60, PLAY_ROUGH
	db 70, TRANSFORM
	db 75, HYPER_BEAM
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
