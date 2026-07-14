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
; Pure Grass — no Poison moves (no glands yet, bulb closed). No STUN_POWDER
; (powder table: line = Sleep only, uniform). SOLARBEAM signature is reserved
; for Venusaur (full bloom concentrates light).
	db  6, VINE_WHIP
	db  8, LEECH_SEED
	db 13, ABSORB
	db 18, GROWTH
	db 24, SLEEP_POWDER
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
; Grass/Poison — bulb open, poison glands active. Adds 3 Poison moves over
; Bulbasaur (POISONPOWDER, ACID, TOXIC). No SLUDGE — plant biology doesn't fit
; the "sludge/blob" framing (Muk/Weezing-coded). Same powder rule: no STUN_POWDER.
	db  6, VINE_WHIP
	db  8, LEECH_SEED
	db 13, ABSORB
	db 18, GROWTH
	db 20, POISONPOWDER
	db 24, SLEEP_POWDER
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
; Same backbone as Ivysaur (uniformity rule), adds SOLARBEAM as the line's
; single signature — full bloom of the flower concentrates sunlight enough to
; fire a beam. No GUNK_SHOT (Muk/Weezing signature). No DAZZLE_GLEAM
; (Fairy-coded shimmer; Venusaur is plant, not magical creature).
	db  6, VINE_WHIP
	db  8, LEECH_SEED
	db 13, ABSORB
	db 18, GROWTH
	db 20, POISONPOWDER
	db 24, SLEEP_POWDER
	db 28, ACID
	db 30, RAZOR_LEAF
	db 36, MEGA_DRAIN
	db 38, BODY_SLAM
	db 40, BULLDOZE
	db 42, PETAL_DANCE
	db 46, SLUDGE
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
; Pure Fire baby. Shared backbone with the whole line (uniformity rule).
; Anatomical exclusions: small teeth (no CRUNCH — Charizard exclusive), no
; wings (no WING_ATTACK/FLY/AERIAL_ACE/HURRICANE). DRAGON_CLAW@36 (evo
; signature) + DRAGON_BREATH@48 shared. FLAME_CHARGE reserved for fast-fire
; quadrupeds (Growlithe/Ponyta lines). OUTRAGE is TM-only.
	db  6, EMBER
	db 10, BITE
	db 14, SMOKESCREEN
	db 18, HEADBUTT
	db 20, CUT
	db 22, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 36, DRAGON_CLAW
	db 38, FLAMETHROWER
	db 48, DRAGON_BREATH
	db 52, FIRE_BLAST
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
; Same backbone as Charmander (uniformity rule). Still no wings, no big jaw —
; Charizard gets both via anatomical exception (FLAMETHROWER/DRAGON_BREATH/
; FIRE_BLAST are shared across the line).
	db  6, EMBER
	db 10, BITE
	db 14, SMOKESCREEN
	db 18, HEADBUTT
	db 20, CUT
	db 22, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 36, DRAGON_CLAW
	db 38, FLAMETHROWER
	db 48, DRAGON_BREATH
	db 52, FIRE_BLAST
	db 0

CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
; Full dragon-form. Adds 5 anatomical exclusives over Char/Charme: WING_ATTACK
; / FLY / AERIAL_ACE / SKY_ATTACK (wings now developed; natural-FLY learner)
; and CRUNCH (big jaw). SKY_ATTACK@60 capstone dive-bomb (180 BP charge; joins
; the flying-apex club — birds/Aerodactyl/Fearow/Pidgeot). HURRICANE is TM-only.
; DRAGON_CLAW@36 / DRAGON_BREATH@48 shared across the line. Entry levels unique.
	db  6, EMBER
	db 10, BITE
	db 14, SMOKESCREEN
	db 18, HEADBUTT
	db 20, CUT
	db 22, SLASH
	db 24, FLAME_BURST
	db 28, FOCUS_ENERGY
	db 32, IGNITE
	db 36, DRAGON_CLAW
	db 38, FLAMETHROWER
	db 40, WING_ATTACK
	db 42, FLY
	db 44, CRUNCH
	db 46, AERIAL_ACE
	db 48, DRAGON_BREATH
	db 52, FIRE_BLAST
	db 55, DRAGON_RAGE
	db 60, SKY_ATTACK
	db 0

SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, WARTORTLE
	db 0
; Learnset
; Pure Water baby turtle. Shared backbone with the whole line. No AQUA_JET
; (turtle slow), no HARDEN (weak + redundant with WITHDRAW), no HYDRO_PUMP
; (anatomical: no shell-cannons until Blastoise). No ICY_WIND (turtles don't
; make wind) — WATER_PULSE covers the slot. BODY_SLAM is the prerequisite for
; HEAVY_SLAM that Blastoise gets exclusively.
	db  6, WATER_GUN
	db  8, WITHDRAW
	db 10, BITE
	db 14, BIDE
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 30, BODY_SLAM
	db 36, WATERFALL
	db 44, SURF
	db 0

WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
; Same backbone as Squirtle (uniformity rule). Cannons developing → HYDRO_PUMP
; at L56 (line evo signature, shared with Blastoise). Blastoise gets cannons
; fully formed + massive size via anatomical exception. No CRUNCH — jaw stays
; BITE baby-tier.
	db  6, WATER_GUN
	db  8, WITHDRAW
	db 10, BITE
	db 14, BIDE
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 30, BODY_SLAM
	db 36, WATERFALL  ; (EVO LVL Blastoise)
	db 44, SURF
	db 56, HYDRO_PUMP
	db 0

BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
; Full tank apex. Adds 5 anatomical exclusives over Squirtle/Wartortle:
; BULLDOZE L39, HEAVY_SLAM L41 (massive frame — needs BODY_SLAM prerequisite,
; shared at L30), HEAD_SMASH L52 (signature shell-head bash; vanilla Skull Bash
; equivalent), ICE_BEAM L48 / BLIZZARD L60 (ice coverage). WATERFALL L36 and
; HYDRO_PUMP L56 are shared with Wartortle (evo signature, cannons developed).
; Entry levels unique.
	db  6, WATER_GUN
	db  8, WITHDRAW
	db 10, BITE
	db 14, BIDE
	db 18, BUBBLEBEAM
	db 22, HEADBUTT
	db 26, WATER_PULSE
	db 30, BODY_SLAM
	db 36, WATERFALL
	db 39, BULLDOZE
	db 41, HEAVY_SLAM
	db 44, SURF
	db 48, ICE_BEAM
	db 52, HEAD_SMASH
	db 56, HYDRO_PUMP
	db 60, BLIZZARD
	db 0

CaterpieEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, METAPOD
	db 0
; Learnset
; Joke-tier baby caterpillar. STRING_SHOT at L1 (base stats). TACKLE@4 is the
; only learned move; real growth happens after evolving. Line owns TACKLE
; (Metapod/Butterfree L1).
	db  4, TACKLE
	db 0

MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BUTTERFREE
	db 0
; Learnset
; Cocoon. HARDEN/IRON_DEFENSE/BIDE only (defensive shell). All real growth
; happens after evolving to Butterfree.
	db 16, IRON_DEFENSE
	db 21, BIDE
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
; Butterfly with Bug/Psychic typing (antennae). Wings, powders, and psychic
; awakening. All 3 powders per the powder table. QUIVER_DANCE late game
; (signature moth/butterfly dance). HURRICANE as the final move.
	db  1, BUG_BITE
	db 11, GUST
	db 14, CONFUSION
	db 15, POISONPOWDER
	db 18, STUN_POWDER
	db 20, SLEEP_POWDER
	db 22, FAIRY_WIND
	db 24, TAILWIND
	db 26, EXTRASENSORY
	db 28, WING_ATTACK
	db 30, BUG_BUZZ ; Butterfree + Venomoth own BUG_BUZZ
	db 33, PSYCHIC_BIND
	db 36, PSYBEAM
	db 42, QUIVER_DANCE
	db 48, PETAL_DANCE
	db 54, PSYCHIC_M
	db 58, HURRICANE
	db 0

WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 8, KAKUNA
	db 0
; Learnset
; Joke-tier baby spike-bug. STRING_SHOT at L1 (base stats). POISON_STING@4 is
; the only learned move; real growth happens after evolving.
	db  4, POISON_STING
	db 0

KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 11, BEEDRILL
	db 0
; Learnset
; Cocoon. HARDEN/IRON_DEFENSE/BIDE only (defensive shell). All growth happens
; after evolving to Beedrill.
	db 16, IRON_DEFENSE
	db 21, BIDE
	db 0

BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
; Stinger bee. TWINEEDLE signature (L20). No powders. Its stingers are its
; huge, aggressive primary weapon, so they double as "horns"/"fangs" in a few
; exceptional cases (Horn Attack, Toxic Fangs L50) for a deeper movepool.
; Neurotoxin at L50 = real-world bee venom.
	db  1, BUG_BITE
	db 11, TACKLE
	db 14, FURY_ATTACK
	db 15, RAGE
	db 18, HORN_ATTACK
	db 20, TWINEEDLE
	db 22, FOCUS_ENERGY
	db 24, HONE_CLAWS
	db 26, QUICK_ATTACK
	db 28, AERIAL_ACE
	db 30, AGILITY
	db 35, SWORDS_DANCE
	db 40, THRASH
	db 42, INTIMIDATE
	db 44, DOUBLE_EDGE
	db 47, DRILL_PECK
	db 50, NEUROTOXIN
	db 50, TOXIC_FANGS
	db 55, EXTREMESPEED
	db 60, GORE_ATTACK
	db 65, OUTRAGE
	db 0

PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, PIDGEOTTO
	db 0
; Learnset
; Peaceful raptor line. PECK before GUST (35 BP < 45 BP, power progression).
; No Dark moves (those belong to the Spearow line). No HONE_CLAWS / SLASH /
; TAKE_DOWN / INTIMIDATE on the baby (small talons, light body, not menacing).
	db  4, PECK
	db  8, SAND_ATTACK
	db 12, GUST
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 30, AERIAL_ACE
	db 36, FLY
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, PIDGEOT
	db 0
; Learnset
; Medium hawk. Pidgey's backbone + HONE_CLAWS and SLASH (medium-grown talons).
	db  4, PECK
	db  8, SAND_ATTACK
	db 12, GUST
	db 17, LEER
	db 18, QUICK_ATTACK
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
; Apex eagle/falcon (mach-2 raptor per Pokedex). Pidgeotto's learnset +
; TAKE_DOWN and INTIMIDATE (full-grown menacing presence).
	db  4, PECK
	db  8, SAND_ATTACK
	db 12, GUST
	db 17, LEER
	db 18, QUICK_ATTACK
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
; Normal-type rodent, sharp-fanged. HYPER_FANG signature at L20 (evo level).
; RAGE (rodent rage), HONE_CLAWS (claws sharpen), POISON_BITE (rats carry
; disease — STAB-less but plausible), CUT (sharp teeth/claws), FAINT_ATTACK
; (sneaky rat strike — Dark, no STAB here but Raticate gets STAB).
	db  4, QUICK_ATTACK
	db  7, BITE
	db  7, POISON_STING
	db 11, FOCUS_ENERGY
	db 13, FAINT_ATTACK
	db 16, RAGE
	db 18, HEADBUTT
	db 20, HYPER_FANG
	db 23, SCREECH
	db 25, CUT
	db 27, AGILITY
	db 29, HONE_CLAWS
	db 32, SUPER_FANG
	db 36, POISON_BITE
	db 40, BODY_SLAM
	db 48, TOXIC_FANGS
	db 52, EXTREMESPEED
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
; Normal/Dark — matured rodent. Rattata's learnset + Dark unlock and matured
; claws: NIGHT_SLASH (Dark high-crit physical strike for a physical attacker).
	db  4, QUICK_ATTACK
	db  7, BITE
	db  7, POISON_STING
	db  9, ASTONISH
	db 11, FOCUS_ENERGY
	db 13, FAINT_ATTACK
	db 16, RAGE
	db 18, HEADBUTT
	db 20, HYPER_FANG
	db 23, SCREECH
	db 25, CUT
	db 27, AGILITY
	db 29, HONE_CLAWS
	db 32, SUPER_FANG
	db 36, POISON_BITE
	db 40, BODY_SLAM
	db 44, NIGHT_SLASH
	db 48, TOXIC_FANGS
	db 52, EXTREMESPEED
	db 56, GORE_ATTACK
	db 60, TOXIC
	db 0

SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
; Honorary Dark/Flying — aggressive bird-of-prey with 2 Dark moves
; (FAINT_ATTACK, NIGHT_SLASH). No HURRICANE / GUST progression, which keeps
; the line distinct from Pidgey. WING_ATTACK at L20 (evo level).
	db  4, PECK
	db  6, SAND_ATTACK
	db  8, LEER
	db 12, FURY_ATTACK
	db 14, QUICK_ATTACK
	db 16, TAILWIND
	db 18, WING_ATTACK
	db 23, FAINT_ATTACK
	db 27, AERIAL_ACE
	db 31, NIGHT_SLASH
	db 36, HONE_CLAWS
	db 42, TAKE_DOWN
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex predator. Spearow's learnset + anatomical exclusives: DRILL_PECK
; signature (long beak as drill), GORE_ATTACK (Dark — beak gore), INTIMIDATE
; (massive raptor presence), SKY_ATTACK (L52 peak).
	db  4, PECK
	db  6, SAND_ATTACK
	db  8, LEER
	db 12, FURY_ATTACK
	db 14, QUICK_ATTACK
	db 16, TAILWIND
	db 18, WING_ATTACK
	db 23, FAINT_ATTACK
	db 27, AERIAL_ACE
	db 31, NIGHT_SLASH
	db 36, HONE_CLAWS
	db 40, DRILL_PECK
	db 42, TAKE_DOWN
	db 46, GORE_ATTACK
	db 50, INTIMIDATE
	db 55, SKY_ATTACK
	db 0

EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, ARBOK
	db 0
; Learnset
; Poison snake with a deep movepool. CONSTRICT (basic squeeze), BIND (heavy
; strangle), BIDE (coil-and-counter), SUBSTITUTE (snake shed-skin), AGILITY
; (fast strike), FAINT_ATTACK (Dark sneaky), SHADOW_SNEAK (Ghost — snake
; hides in shadow), NEUROTOXIN (snake venom), EXTREMESPEED (peak strike).
; No GUNK_SHOT / SLUDGE_WAVE (Muk/Weezing only). No SCREECH (snakes hiss).
	db  3, WRAP
	db  6, BITE
	db  9, BIDE
	db 12, QUICK_ATTACK
	db 15, POISON_STING
	db 18, ASTONISH
	db 24, COIL
	db 26, BIND
	db 30, POISON_BITE
	db 33, AGILITY
	db 36, FAINT_ATTACK
	db 40, SHADOW_SNEAK
	db 42, SUBSTITUTE
	db 48, TOXIC_FANGS
	db 54, EXTREMESPEED
	db 57, TOXIC
	db 60, NEUROTOXIN
	db 65, RECOVER
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
; Poison/Dark — matured cobra. Ekans's learnset + cobra hood, Dark unlock,
; and heavy whip-tail: SCARY_FACE (L21, EVO LVL), IRON_TAIL (high-level
; whip), INTIMIDATE (full hood display, L52).
	db  3, WRAP
	db  6, BITE
	db  9, BIDE
	db 12, QUICK_ATTACK
	db 15, POISON_STING
	db 18, ASTONISH
	db 21, SCARY_FACE  ; (EVO LVL)
	db 24, COIL
	db 26, BIND
	db 30, POISON_BITE
	db 33, AGILITY
	db 36, FAINT_ATTACK
	db 40, SHADOW_SNEAK
	db 42, SUBSTITUTE
	db 45, IRON_TAIL
	db 48, TOXIC_FANGS
	db 52, INTIMIDATE
	db 54, EXTREMESPEED
	db 57, TOXIC
	db 60, NEUROTOXIN
	db 65, RECOVER
	db 0

PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
; Electric mouse. Power-progression: NUZZLE (35 BP) before THUNDERSHOCK
; (55 BP). CHARM mid (cute mouse). VOLT_TACKLE signature at L23.
	db  3, TAIL_WHIP
	db  5, NUZZLE
	db 10, QUICK_ATTACK
	db 13, THUNDERSHOCK
	db 15, CHARM
	db 17, THUNDER_WAVE
	db 21, SHOCK_WAVE
	db 23, VOLT_TACKLE
	db 25, AGILITY
	db 28, FLASH
	db 30, IRON_TAIL
	db 36, THUNDERBOLT
	db 42, BODY_SLAM
	db 48, EXTREMESPEED
	db 55, THUNDER
	db 60, PLAY_ROUGH
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
; Bigger orange mouse. Shares Pikachu's backbone (VOLT_TACKLE at the same
; level). Adds DOUBLE_EDGE (bigger reckless body — anatomical exclusive).
	db  3, TAIL_WHIP
	db  5, NUZZLE
	db 10, QUICK_ATTACK
	db 13, THUNDERSHOCK
	db 15, CHARM
	db 17, THUNDER_WAVE
	db 21, SHOCK_WAVE
	db 23, VOLT_TACKLE
	db 25, AGILITY
	db 28, FLASH
	db 30, IRON_TAIL
	db 36, THUNDERBOLT
	db 42, BODY_SLAM
	db 48, EXTREMESPEED
	db 52, DOUBLE_EDGE
	db 55, THUNDER
	db 60, PLAY_ROUGH
	db 0

SandshrewEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, SANDSLASH
	db 0
; Learnset
; Armoured armadillo Ground digger. DEFENSE_CURL (ball-shape). MUD_SHOT
; over GROUND_STOMP. SLASH at L22 = evo level (apex claws appear), then
; HONE_CLAWS. No FISSURE (reserved for the Sandslash apex). Learns
; STRENGTH (on the HM04 list).
	db  7, DEFENSE_CURL
	db 10, MUD_SHOT
	db 13, SAND_ATTACK
	db 16, ROLLOUT
	db 18, BULLDOZE
	db 20, CUT
	db 22, SLASH
	db 24, HONE_CLAWS
	db 30, DIG
	db 36, MUD_BOMB
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex armoured digger. Shared backbone + Sandslash-exclusives:
; IRON_DEFENSE (defensive armour, not a setup attacker), ROCK_TOMB
; (armoured-digger Rock affinity), EARTHQUAKE (apex Ground), NIGHT_SLASH
; (high-level claws apex), FISSURE (deep-dig OHKO L56), GORE_ATTACK,
; ROCK_SLIDE (last move L65).
	db  7, DEFENSE_CURL
	db 10, MUD_SHOT
	db 13, SAND_ATTACK
	db 16, ROLLOUT
	db 18, BULLDOZE
	db 20, CUT
	db 22, SLASH
	db 24, HONE_CLAWS
	db 30, DIG
	db 36, MUD_BOMB
	db 42, IRON_DEFENSE
	db 44, ROCK_TOMB
	db 48, EARTHQUAKE
	db 52, NIGHT_SLASH
	db 56, FISSURE
	db 60, GORE_ATTACK
	db 65, ROCK_SLIDE
	db 0

NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, NIDORINA
	db 0
; Learnset
; Defensive female juvenile, fairy-tinged. Shared backbone that Nidorina
; and Nidoqueen inherit. SAND_ATTACK basic; FAIRY_WIND at L17 = evo level
; (fairy gift on evolution); TOXIC_FANGS late capstone. No SCRATCH. No
; BULLDOZE/GROUND_STOMP/CRUNCH in shared (Queen exclusivity).
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, TAIL_WHIP
	db 15, BITE
	db 15, QUICK_ATTACK
	db 17, FAIRY_WIND
	db 20, BIDE
	db 22, HEADBUTT
	db 26, POISON_BITE
	db 28, BODY_SLAM
	db 40, TOXIC_FANGS
	db 50, TOXIC
	db 0

NidorinaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOQUEEN
	db 0
; Learnset
; Mid-stage female, chemical ground attacker. Nidoran♀ base + Nidorina/
; Nidoqueen exclusives: ACID (glandular chemistry), TAKE_DOWN, MUD_SHOT
; (F-line mud-thrower, not stomp), PLAY_ROUGH at L35 = evo level (fairy
; gift on evolution), TOXIC_FANGS, MUD_BOMB, TOXIC, NEUROTOXIN. No
; BULLDOZE/EARTHQUAKE/CRUNCH/STRENGTH (Nidoqueen-only).
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, TAIL_WHIP
	db 15, BITE
	db 15, QUICK_ATTACK
	db 17, FAIRY_WIND
	db 20, BIDE
	db 22, HEADBUTT
	db 24, ACID
	db 26, POISON_BITE
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
; Matriarch, fairy + ground apex. Inherits all Nidoran♀/Nidorina entries;
; adds Nidoqueen-only: CHARM, BULLDOZE (her ground move), TOXIC, STRENGTH.
; EARTHQUAKE is TM50-only, not levelup. No MEGAHORN/OUTRAGE/THRASH/
; GORE_ATTACK (M-only apex moves).
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, TAIL_WHIP
	db 15, BITE
	db 17, FAIRY_WIND
	db 20, BIDE
	db 22, HEADBUTT
	db 24, ACID
	db 26, POISON_BITE
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
; Aggressive male juvenile, single-horn. Shared backbone that Nidorino and
; Nidoking inherit. POISON_STING + SAND_ATTACK basic toolkit; FURY_ATTACK
; early; POISON_BITE/BODY_SLAM mid-tier; HORN_CHARGE late as adult-horn
; move; TOXIC_FANGS late capstone. No DOUBLE_KICK.
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, BITE
	db 15, QUICK_ATTACK
	db 17, HORN_ATTACK
	db 19, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 25, POISON_BITE
	db 28, BODY_SLAM
	db 39, HORN_CHARGE
	db 47, TOXIC_FANGS
	db 0

NidorinoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, NIDOKING
	db 0
; Learnset
; Mid-stage male, mature horn, learns aggression primitives. Nidoran♂ base
; + exclusives shared with Nidoking: TAKE_DOWN, GROUND_STOMP, RAGE at L35
; (= evo level), FIERCE_ROAR.
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, BITE
	db 15, QUICK_ATTACK
	db 17, HORN_ATTACK
	db 19, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 25, POISON_BITE
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
; Apex predator male, full kit. Inherits all Nidoran♂/Nidorino entries;
; adds Nidoking-only: BULLDOZE (after GROUND_STOMP for power progression
; 35->65 BP), STRENGTH then CRUNCH, EARTHQUAKE, THRASH, MEGAHORN at L49,
; BRUTAL_SWING, GORE_ATTACK (high-level apex), OUTRAGE (final L65). No
; HORN_DRILL.
	db  7, POISON_STING
	db 10, SAND_ATTACK
	db 13, BITE
	db 17, HORN_ATTACK
	db 19, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 25, POISON_BITE
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
; Mystical Fairy. SING after L30. MIMIC/METRONOME fun naturals. CHARM.
; RECOVER (Clefairy-line). LIGHT_SCREEN/REFLECT/CALM_MIND shared with
; Clefable.
	db  4, FAIRY_WIND
	db  7, DOUBLESLAP
	db 10, POWDER_SNOW
	db 13, CALM_MIND
	db 16, CHARM
	db 19, TICKLE
	db 22, DRAINING_KISS
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
; Apex mystical Fairy. Clefairy backbone + Clefable-exclusives: BODY_SLAM,
; ICY_WIND, PLAY_ROUGH, PETAL_DANCE.
	db  4, FAIRY_WIND
	db  7, DOUBLESLAP
	db 10, POWDER_SNOW
	db 13, CALM_MIND
	db 16, CHARM
	db 19, TICKLE
	db 22, DRAINING_KISS
	db 22, BODY_SLAM
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
; Fire-Fairy-coded kitsune fox. WILL_O_WISP (Ghost) over IGNITE (Fire) by
; anatomy — Vulpix has no open flame like Charmander/Magmar; its Fire is
; spectral kitsune. NIGHT_SHADE/FAINT_ATTACK/AGILITY for the ranged,
; graceful caster. No FLAME_CHARGE (too physical). DAZZLE_GLEAM reserved
; for Ninetales-only.
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
; Apex kitsune. Shared backbone + exclusives: EERIE_IMPULSE (uncanny mature
; kitsune), DAZZLE_GLEAM (Fairy mid-apex), SHADOW_BALL (Ghost-coded — many
; tails channel spectral), MOONBLAST (lunar signature). No FLASH —
; EERIE_IMPULSE covers the mid-game utility slot.
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
; Normal/Fairy balloon singer. Voice kit: SING early, LOVELY_KISS,
; CHARM. DRAINING_KISS/BUBBLEBEAM round out the fairy pool.
	db  6, HINDER
	db  6, DEFENSE_CURL
	db  9, TACKLE
	db  9, FAIRY_WIND
	db 12, DOUBLESLAP
	db 15, CHARM
	db 17, TICKLE
	db 20, GROWTH
	db 23, ASTONISH
	db 26, BIDE
	db 29, ROLLOUT
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
; Apex balloon singer. Jigglypuff backbone (incl. FLY HM02 natural L54
; — the balloon body floats) plus two apex exclusives: MIRROR_MOVE,
; PLAY_ROUGH.
	db  6, HINDER
	db  6, DEFENSE_CURL
	db  9, TACKLE
	db  9, FAIRY_WIND
	db 12, DOUBLESLAP
	db 15, CHARM
	db 17, TICKLE
	db 20, GROWTH
	db 23, ASTONISH
	db 26, BIDE
	db 29, ROLLOUT
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
; Vampire bat. Drain progression BITE -> ABSORB -> LEECH_LIFE.
; WING_ATTACK at L21 (evo level). No SLUDGE (Muk signature). HURRICANE
; is TM only, not levelup.
	db  7, QUICK_ATTACK
	db 11, ABSORB
	db 13, POISON_STING
	db 17, LEECH_LIFE
	db 19, LICK
	db 21, WING_ATTACK
	db 24, EERIE_IMPULSE
	db 26, SCREECH
	db 30, ASTONISH
	db 34, AERIAL_ACE
	db 36, FLY
	db 40, POISON_BITE
	db 44, AGILITY
	db 48, TOXIC_FANGS
	db 51, EXTREMESPEED
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
; Matured vampire bat. Zubat backbone plus apex exclusives DARK_PULSE
; (L55) and TOXIC (L60). HURRICANE is TM only, not levelup.
	db  7, QUICK_ATTACK
	db 11, ABSORB
	db 13, POISON_STING
	db 17, LEECH_LIFE
	db 19, LICK
	db 21, WING_ATTACK
	db 24, EERIE_IMPULSE
	db 26, SCREECH
	db 30, ASTONISH
	db 34, AERIAL_ACE
	db 36, FLY
	db 40, POISON_BITE
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
; Basic radish/turnip plant (Grass/Poison). Powder triad
; STUN_POWDER + SLEEP_POWDER + POISONPOWDER emerges by the evo level
; (POISONPOWDER at L22). LEECH_SEED + drain + apex PETAL_DANCE.
	db 10, GROWTH
	db 13, TACKLE
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 22, SLEEP_POWDER
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
; Mid-stage flower bud (Grass/Fungus). Oddish backbone plus two
; exclusives: SCREECH (drooly mouth resonance), TOXIC (mature poison
; glands).
	db 10, GROWTH
	db 13, TACKLE
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 22, SLEEP_POWDER
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
; Apex Rafflesia bloom (Grass/Fungus). Powder-warfare specialist with
; the full powder triad. Apex exclusives: SPORE_DAZE (fungal
; confusion), EERIE_IMPULSE (mature spore mind-effect), LEECH_LIFE
; (insect drain, high level), HAZE (gas/spore cloud), DARK_PULSE (dark
; fungal peak), SPORE (true apex L65).
	db 10, GROWTH
	db 13, TACKLE
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 22, SLEEP_POWDER
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
; Cordyceps-controlled bug (Bug/Grass). Powder profile:
; POISONPOWDER + STUN_POWDER + SPORE (at L22, the evo level).
; LEECH_LIFE bug-drain; SLASH claws; drain progression
; ABSORB -> MEGA_DRAIN -> GIGA_DRAIN.
	db 10, ABSORB
	db 13, GROWTH
	db 13, LEECH_SEED
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 22, SPORE
	db 25, MEGA_DRAIN
	db 27, CUT
	db 29, SLASH
	db 31, LEECH_LIFE
	db 34, DIG
	db 46, GIGA_DRAIN
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
; Mushroom-dominated apex (Bug/Fungus). Paras backbone plus apex
; exclusives: SPORE at L22 (evo level, mushroom takes over signature),
; PARASITE (signature super-fang), SPORE_DAZE (fungal confusion),
; SCARY_FACE (fungal-zombie), EERIE_IMPULSE (mind-affecting spores),
; NIGHT_SLASH (dark sharp claws), DOUBLE_EDGE (apex recoil),
; TOXIC_FANGS (fungal mandibular toxin), TOXIC (L60 last move).
	db 10, ABSORB
	db 13, GROWTH
	db 13, LEECH_SEED
	db 16, STUN_POWDER
	db 19, POISONPOWDER
	db 22, SPORE
	db 25, MEGA_DRAIN
	db 27, PARASITE
	db 27, CUT
	db 29, SPORE_DAZE
	db 29, SLASH
	db 31, LEECH_LIFE
	db 34, SCARY_FACE
	db 34, DIG
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
; Pre-moth, Bug/Poison. No powders here — powders are wing-sourced and
; the baby Venonat lacks wings. SPORE_DAZE is Venonat-only (the fuzzy
; baby body releases dazing spores; Venomoth replaces it with a proper
; powder kit). PSYWAVE early before CONFUSION. No STRING_SHOT (no
; spinneret anatomy on the fuzzy bug body).
	db  4, POISON_STING
	db  8, PSYWAVE
	db 11, BUG_BITE
	db 14, SUPERSONIC
	db 18, CONFUSION
	db 34, LEECH_LIFE
	db 37, SPORE_DAZE
	db 44, SMOG
	db 50, TOXIC
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
; Full moth. Venonat backbone plus wing exclusives: full powder kit
; (wing-sourced), GUST/WING_ATTACK, QUIVER_DANCE signature (late),
; BUG_BUZZ. SPORE_DAZE here is graduated into the proper powders.
	db  4, POISON_STING
	db  8, PSYWAVE
	db 11, BUG_BITE
	db 14, SUPERSONIC
	db 21, POISONPOWDER
	db 21, GUST
	db 23, STUN_POWDER
	db 25, BUG_BUZZ
	db 27, SLEEP_POWDER
	db 29, WING_ATTACK
	db 31, ACID
	db 34, LEECH_LIFE
	db 37, SPORE_DAZE
	db 40, QUIVER_DANCE
	db 44, SMOG
	db 47, NIGHT_SHADE
	db 50, TOXIC
	db 54, HAZE
	db 58, PSYCHIC_M
	db 0

DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DUGTRIO
	db 0
; Learnset
; Subterranean mole. DIG L1 (anatomically essential — the whole Diglett
; body is built to live in the dig). GROWL as a vocal hinder (near-blind
; mole). QUICK_ATTACK/AGILITY speed. EARTHQUAKE at L33 = evo level.
; EXTREMESPEED apex mole speed. FISSURE signature, last move L60.
	db  5, DIG
	db 10, SAND_ATTACK
	db 12, QUICK_ATTACK
	db 17, BULLDOZE
	db 22, AGILITY
	db 24, CUT
	db 26, MUD_BOMB
	db 28, SLASH
	db 30, FAINT_ATTACK
	db 33, EARTHQUAKE
	db 36, HONE_CLAWS
	db 46, ROCK_TOMB
	db 52, EXTREMESPEED
	db 60, FISSURE
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex 3-headed mole. Diglett backbone plus apex exclusives: SCREECH,
; NIGHT_SLASH, TAKE_DOWN, RECOVER (burrows underground to rest). No
; TRI_ATTACK (Porygon/Mew/Magneton signature). STRENGTH via HM only,
; not levelup.
	db  5, DIG
	db 10, SAND_ATTACK
	db 12, QUICK_ATTACK
	db 17, BULLDOZE
	db 22, AGILITY
	db 24, CUT
	db 26, MUD_BOMB
	db 28, SLASH
	db 30, FAINT_ATTACK
	db 33, EARTHQUAKE
	db 36, HONE_CLAWS
	db 38, SCREECH
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
; Feline cat, claws + coin. PAY_DAY signature. HONE_CLAWS/SLASH
; (claws). FAINT_ATTACK (cat sneak). INTIMIDATE (predator).
	db  5, TAIL_WHIP
	db  7, BITE
	db  9, ASTONISH
	db  9, QUICK_ATTACK
	db 12, PAY_DAY
	db 15, FURY_ATTACK
	db 18, FAINT_ATTACK
	db 21, HONE_CLAWS
	db 24, FOCUS_ENERGY
	db 26, TAKE_DOWN
	db 26, CUT
	db 28, SLASH  ; (EVO LVL)
	db 32, INTIMIDATE
	db 38, NASTY_PLOT
	db 44, AGILITY
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex feline. INTIMIDATE (apex predator). NASTY_PLOT (sneaky special).
; EXTREMESPEED (apex speed).
	db  5, TAIL_WHIP
	db  7, BITE
	db  9, ASTONISH
	db  9, QUICK_ATTACK
	db 12, PAY_DAY
	db 15, FURY_ATTACK
	db 18, FAINT_ATTACK
	db 21, HONE_CLAWS
	db 24, FOCUS_ENERGY
	db 26, TAKE_DOWN
	db 26, CUT
	db 28, SLASH
	db 32, INTIMIDATE
	db 35, RAGE
	db 38, NASTY_PLOT
	db 41, NIGHT_SLASH
	db 44, AGILITY
	db 50, EXTREMESPEED
	db 0

PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, GOLDUCK
	db 0
; Learnset
; Water duck with latent psychic power. DISABLE — its confused mind
; blocks the foe's moves. AMNESIA and PSYCHIC_BIND from the psychic side.
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
; Apex psychic duck. AMNESIA clears the mind. SURF/CUT natural HM
; learners. HYDRO_PUMP as the apex move.
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
; Rage-fueled wild monkey. BITE, SAND_ATTACK and QUICK_ATTACK fit an
; ape's kit. FIERCE_ROAR is its battle roar. No DIZZY_PUNCH/SUBMISSION
; (grappling technique, not brute force) and no FAINT_ATTACK (an ape
; doesn't sneak). STRENGTH via HM only.
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
	db 50, OUTRAGE
	db 60, GORE_ATTACK
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex rage-monkey. Shares Mankey's backbone, plus exclusives: GROUND_STOMP,
; BULK_UP (muscle setup), BRUTAL_SWING (rage swing), high-level SWORDS_DANCE
; and GORE_ATTACK, INTIMIDATE. STRENGTH via HM only.
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
	db 37, ROCK_PUNCH
	db 39, ROLLING_KICK
	db 41, THRASH
	db 43, BRUTAL_SWING
	db 46, INTIMIDATE
	db 48, SEISMIC_TOSS
	db 50, OUTRAGE
	db 52, SWORDS_DANCE
	db 60, GORE_ATTACK
	db 0

GrowlitheEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
; Alpha canine pup. HONE_CLAWS + FOCUS_ENERGY as a predator's foundation.
; Intimidation ladder GROWL -> FIERCE_ROAR -> INTIMIDATE. PLAY_ROUGH fits
; a canine's rough bite/claw; no SUBMISSION (a canine doesn't wrestle) and
; no rock move (no earth affinity).
	db  7, LEER
	db  9, QUICK_ATTACK
	db 11, HONE_CLAWS
	db 14, EMBER
	db 16, FIERCE_ROAR
	db 18, FOCUS_ENERGY
	db 22, FLAME_CHARGE
	db 24, CUT
	db 26, CRUNCH
	db 28, SLASH
	db 32, FLAMETHROWER
	db 40, TAKE_DOWN
	db 44, INTIMIDATE
	db 48, PLAY_ROUGH
	db 55, FIRE_BLAST
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex alpha canine. Shares Growlithe's backbone, plus exclusives: AGILITY,
; STRENGTH (natural HM04) and SWORDS_DANCE. No EXTREMESPEED (canine isn't on
; the signature list) and no OUTRAGE (not Dragon-coded).
	db  7, LEER
	db  9, QUICK_ATTACK
	db 11, HONE_CLAWS
	db 14, EMBER
	db 16, FIERCE_ROAR
	db 18, FOCUS_ENERGY
	db 22, FLAME_CHARGE
	db 24, CUT
	db 26, CRUNCH
	db 28, SLASH
	db 32, FLAMETHROWER
	db 38, STRENGTH
	db 40, TAKE_DOWN
	db 42, AGILITY
	db 44, INTIMIDATE
	db 48, PLAY_ROUGH
	db 52, SWORDS_DANCE
	db 55, FIRE_BLAST
	db 0

PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 17, POLIWHIRL
	db 0
; Learnset
; Water tadpole. BUBBLEBEAM, HYPNOSIS and DOUBLESLAP basic kit.
	db  9, WATER_GUN
	db 11, HINDER
	db 13, HYPNOSIS
	db 17, TACKLE
	db 22, BUBBLEBEAM
	db 24, BODY_SLAM
	db 28, WATER_PULSE
	db 51, AQUA_JET
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
; Mid-evo. STRENGTH natural HM04 learner. BULK_UP muscle setup.
	db  9, WATER_GUN
	db 11, HINDER
	db 13, HYPNOSIS
	db 17, TACKLE
	db 20, FOCUS_ENERGY
	db 20, LOW_KICK
	db 22, BUBBLEBEAM
	db 24, BODY_SLAM
	db 28, WATER_PULSE
	db 32, BIDE
	db 36, BULK_UP
	db 36, WATERFALL
	db 40, SURF
	db 42, PLAY_ROUGH
	db 49, DIZZY_PUNCH
	db 51, AQUA_JET
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex Water/Fighting. SUBMISSION signature (shared with Machamp).
; DIZZY_PUNCH for the boxer-frog. SURF natural HM03 learner.
	db  9, WATER_GUN
	db 11, HINDER
	db 13, HYPNOSIS
	db 17, TACKLE  ; (Evo lvl)
	db 20, FOCUS_ENERGY
	db 20, LOW_KICK
	db 22, BUBBLEBEAM
	db 24, BODY_SLAM
	db 28, WATER_PULSE
	db 32, BIDE
	db 36, BULK_UP
	db 36, WATERFALL
	db 40, STRENGTH
	db 40, SURF
	db 42, PLAY_ROUGH
	db 45, TAKE_DOWN
	db 47, DIZZY_PUNCH
	db 51, AQUA_JET
	db 53, SEISMIC_TOSS
	db 57, SUBMISSION
	db 59, DOUBLE_EDGE
	db 0

AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, KADABRA
	db 0
; Learnset
; Minimalist baby psychic. TELEPORT signature at L1 (canon Abra-only-
; Teleport), then a basic psychic kit (PSYWAVE/DISABLE/PSYCHIC_BIND).
	db  7, PSYWAVE
	db 13, DISABLE
	db 19, PSYCHIC_BIND
	db 26, CONFUSION  ; (EVO LVL)
	db 42, CALM_MIND
	db 0

KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, ALAKAZAM
	db 0
; Learnset
; Psychic mage mid-evo. PSYCHIC_BIND owned by the Kadabra line. RECOVER,
; LIGHT_SCREEN/REFLECT and CALM_MIND round out the mage kit. MIND_BREAK is
; reserved for the Alakazam apex.
	db  7, PSYWAVE
	db 13, DISABLE
	db 19, PSYCHIC_BIND
	db 26, CONFUSION
	db 30, RECOVER
	db 34, EXTRASENSORY
	db 38, LIGHT_SCREEN
	db 42, CALM_MIND  ; (EVO LVL)
	db 42, FOCUS_ENERGY
	db 44, PSYBEAM
	db 46, SHOCK_WAVE
	db 48, REFLECT
	db 50, PSYCHIC_M
	db 52, AGILITY
	db 54, TRI_ATTACK
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex Psychic mage. Shares Kadabra's backbone, plus exclusives:
; EERIE_IMPULSE, METRONOME, DARK_PULSE, and MIND_BREAK as the very-high
; last move (L70). FLASH natural HM05 learner.
	db  7, PSYWAVE
	db 13, DISABLE
	db 19, PSYCHIC_BIND
	db 26, CONFUSION
	db 30, RECOVER
	db 34, EXTRASENSORY
	db 38, LIGHT_SCREEN
	db 42, FOCUS_ENERGY
	db 42, CALM_MIND  ; (EVO LVL)
	db 44, EERIE_IMPULSE
	db 44, PSYBEAM
	db 46, SHOCK_WAVE
	db 48, REFLECT
	db 50, PSYCHIC_M
	db 52, AGILITY
	db 54, TRI_ATTACK
	db 56, METRONOME
	db 60, DARK_PULSE
	db 70, MIND_BREAK
	db 0

MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, MACHOKE
	db 0
; Learnset
; Disciplined humanoid fighter. TACKLE starter, BULK_UP early. DIZZY_PUNCH
; instead of ROLLING_KICK (Hitmonlee-only). GROUND_STOMP fits humanoid
; stomping. SUBMISSION at higher level.
	db 10, BIND
	db 10, LOW_KICK
	db 13, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, KARATE_CHOP
	db 21, SEISMIC_TOSS
	db 23, ROCK_THROW
	db 26, STRENGTH  ; (EVO LVL)
	db 28, DIZZY_PUNCH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 38, TAKE_DOWN
	db 48, SUBMISSION
	db 0

MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, MACHAMP
	db 0
; Learnset
; Mid-evo. Shares Machop's backbone, plus BODY_SLAM as a Machoke-and-up
; exclusive.
	db 10, BIND
	db 10, LOW_KICK
	db 13, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, KARATE_CHOP
	db 21, SEISMIC_TOSS
	db 23, ROCK_THROW
	db 26, STRENGTH  ; (EVO LVL)
	db 28, DIZZY_PUNCH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 38, TAKE_DOWN
	db 46, MACH_PUNCH
	db 48, SUBMISSION
	db 50, BULLDOZE
	db 55, SWORDS_DANCE
	db 62, THRASH
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex 4-arm humanoid fighter. Shares Machoke's backbone, plus high-level
; exclusives: COMET_PUNCH (4 arms = rapid combo punches), MACH_PUNCH
; (priority hand), BULLET_PUNCH (steel fast punch), IRON_DEFENSE
; (strong muscles and 4 arms defense), SWORDS_DANCE (apex setup).
; SUBMISSION signature shared with Poliwrath.
	db 10, BIND
	db 10, LOW_KICK
	db 13, FOCUS_ENERGY
	db 16, BULK_UP
	db 18, KARATE_CHOP
	db 21, SEISMIC_TOSS
	db 23, ROCK_THROW
	db 26, STRENGTH  ; (EVO LVL)
	db 28, DIZZY_PUNCH
	db 30, GROUND_STOMP
	db 36, BODY_SLAM
	db 38, TAKE_DOWN
	db 42, COMET_PUNCH  ; (EVO LVL)
	db 46, MACH_PUNCH
	db 48, SUBMISSION
	db 50, BULLDOZE
	db 52, BULLET_PUNCH
	db 55, SWORDS_DANCE
	db 60, IRON_DEFENSE
	db 62, THRASH
	db 65, OUTRAGE
	db 0

BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, WEEPINBELL
	db 0
; Learnset
; Carnivorous pitcher predator (Grass/Poison). Powder rule: ONLY
; SLEEP_POWDER (predator just sleeps its prey; no Poison/Stun Powder).
; CONSTRICT/WRAP + vine kit; SLEEP_POWDER at evo level (signature on evo);
; ACID + RAZOR_LEAF + drain progression (ABSORB->MEGA->GIGA); TICKLE for
; debuff. No SLUDGE/CORRODE here (Weepinbell/Victreebel tier).
	db 10, GROWTH
	db 13, BITE
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 16, TICKLE
	db 19, BIDE
	db 19, DOUBLESLAP
	db 22, SLEEP_POWDER
	db 25, ACID
	db 31, RAZOR_LEAF
	db 38, MEGA_DRAIN
	db 44, GIGA_DRAIN
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
; Mid-stage carnivore (Grass/Poison). Bellsprout backbone +
; Weepinbell/Victreebel exclusives: BODY_SLAM (pitcher slam), TAKE_DOWN
; (vine grapple), SLUDGE (digestive), LEECH_LIFE (insect drain), CORRODE
; (predator -2 def signature), SLUDGE_WAVE high-level apex poison.
	db 10, GROWTH
	db 13, BITE
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 16, TICKLE
	db 19, BIDE
	db 19, DOUBLESLAP
	db 22, SLEEP_POWDER
	db 25, ACID
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
; Apex carnivore (Grass/Poison). Weepinbell backbone + Victreebel-only
; exclusives: CUT (HM, matured leaves), SLASH (sharp matured leaves),
; SCARY_FACE (giant trap mouth, eerie/sinister), TOXIC (apex predator
; finishing poison).
	db 10, GROWTH
	db 13, BITE
	db 13, CONSTRICT
	db 16, VINE_WHIP
	db 16, TICKLE
	db 19, BIDE
	db 19, DOUBLESLAP
	db 22, SLEEP_POWDER
	db 25, ACID
	db 27, CUT
	db 29, SLASH
	db 31, RAZOR_LEAF
	db 33, BODY_SLAM
	db 36, TAKE_DOWN
	db 38, MEGA_DRAIN
	db 40, SLUDGE
	db 42, SCARY_FACE
	db 44, GIGA_DRAIN
	db 46, LEECH_LIFE
	db 52, CORRODE
	db 58, SLUDGE_WAVE
	db 65, TOXIC
	db 0
TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
; Jellyfish Water/Poison. SLUDGE_WAVE is the line signature (on
; Tentacruel). NEUROTOXIN is the Tentacruel-line signature. No
; POISON_BITE (a jellyfish has no fangs).
	db  6, HINDER
	db  9, WRAP
	db 12, CONSTRICT
	db 15, NEUROTOXIN
	db 17, ACID
	db 20, BUBBLEBEAM
	db 23, SMOKESCREEN
	db 26, SLUDGE
	db 29, WATER_PULSE
	db 31, GROWTH
	db 33, BIND
	db 33, LEECH_LIFE
	db 35, NUZZLE
	db 39, SURF
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex jellyfish. Tentacool backbone (SURF L39 incl.) + Tentacruel-
; exclusive levelup moves: EERIE_IMPULSE, SLUDGE_WAVE, SHOCK_WAVE, TOXIC,
; CORRODE (jellyfish acid corrodes), HYDRO_PUMP. CUT (HM01) via TM/HM
; only, not in the levelset.
	db  6, HINDER
	db  9, WRAP
	db 12, CONSTRICT
	db 15, NEUROTOXIN
	db 17, ACID
	db 20, BUBBLEBEAM
	db 23, SMOKESCREEN
	db 26, SLUDGE
	db 29, WATER_PULSE
	db 31, GROWTH
	db 33, BIND
	db 33, LEECH_LIFE
	db 35, NUZZLE
	db 37, EERIE_IMPULSE
	db 39, SURF
	db 43, SLUDGE_WAVE
	db 48, SHOCK_WAVE
	db 53, TOXIC
	db 60, CORRODE
	db 65, HYDRO_PUMP
	db 0

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, GRAVELER
	db 0
; Learnset
; Basic rolling rock with arms (Rock/Ground). ROLLOUT L36 line signature.
; ROCK_PUNCH at evo level (it has arms). HEAD_SMASH high level. No DIG.
; No EXPLOSION (Koffing/Voltorb/Magmar signature only).
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
; Mid-stage rolling rock (Rock/Ground). Geodude backbone +
; Graveler/Golem exclusives: TAKE_DOWN (charge), EARTHQUAKE, IRON_HEAD
; (rock-iron), STRENGTH (HM), ROCK_SLIDE (apex rock, after HEAD_SMASH),
; DOUBLE_EDGE (apex recoil). No BULK_UP (rock, not muscle). No DIG/
; EXPLOSION.
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
; Apex turtle-shell rock (Rock/Ground). Graveler backbone + Golem-only
; exclusives: IRON_DEFENSE (DEF +2), HEAVY_SLAM (apex Normal heavy frame).
; No EXPLOSION (Koffing/Voltorb/Magmar signature only). No HORN moves (no
; horn anatomy). No OUTRAGE (gentle giant under the heft).
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
	db 55, ROCK_SLIDE
	db 62, HEAVY_SLAM
	db 65, DOUBLE_EDGE
	db 0

PonytaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, RAPIDASH
	db 0
; Learnset
; Young equine with an open Fire mane. IGNITE (Fire, not Ghost) is
; anatomy-correct: the mane flame is literal/open. BODY_SLAM (equine
; rear-up + body-down). FAIRY_WIND shared with the Vulpix line (basal
; Fairy presence). AGILITY at L30 coincides with the evolution. GROUND_STOMP
; via hooves.
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
; Apex equine unicorn. Ponyta backbone + Rapidash-exclusives: HORN_ATTACK
; (horn appears with the evo, same level as AGILITY), HORN_CHARGE (mid-tier
; horn), DAZZLE_GLEAM (unicorn glow, Fairy apex), HORN_DRILL (signature,
; last move L60). No EXTREMESPEED (fast but not agile).
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
	db 39, HORN_CHARGE
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
; Slow Water/Normal. AMNESIA only, no CALM_MIND.
	db  6, TAIL_WHIP
	db  9, WATER_GUN
	db 12, PSYWAVE
	db 14, CONFUSION
	db 16, DISABLE
	db 18, PSYCHIC_BIND
	db 20, HEADBUTT
	db 22, WATER_PULSE
	db 28, AMNESIA
	db 33, EXTRASENSORY
	db 51, RECOVER
	db 0

SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex slow Water/Psychic. WITHDRAW (Shellder bite as a makeshift
; shield). SURF/STRENGTH HMs.
	db  6, TAIL_WHIP
	db  9, WATER_GUN
	db 12, PSYWAVE
	db 14, CONFUSION
	db 16, DISABLE
	db 18, PSYCHIC_BIND
	db 20, HEADBUTT
	db 22, WATER_PULSE
	db 28, AMNESIA
	db 35, WITHDRAW
	db 37, EXTRASENSORY
	db 40, BODY_SLAM
	db 40, BIDE
	db 43, ICY_PULSE
	db 46, PSYCHIC_M
	db 51, RECOVER
	db 53, ICE_BEAM
	db 0

MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, MAGNETON
	db 0
; Learnset
; Electric/Steel. METAL_SOUND (Steel-type). SONICBOOM signature.
; SHOCK_WAVE/THUNDERBOLT. TRI_ATTACK reserved for Magneton.
	db  6, HEADBUTT
	db  9, THUNDERSHOCK
	db 12, SUPERSONIC
	db 16, THUNDER_WAVE
	db 20, SONICBOOM
	db 22, SHOCK_WAVE
	db 26, SCREECH
	db 33, BODY_SLAM  ; (EVO LVL)
	db 36, METAL_SOUND
	db 39, THUNDERBOLT
	db 45, IRON_HEAD
	db 57, IRON_DEFENSE
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex Electric/Steel. TRI_ATTACK (Magneton only, not Magnemite).
; SCREECH metal-on-metal.
	db  6, HEADBUTT
	db  9, THUNDERSHOCK
	db 12, SUPERSONIC
	db 16, THUNDER_WAVE
	db 20, SONICBOOM
	db 22, SHOCK_WAVE
	db 26, SCREECH
	db 33, FOCUS_ENERGY
	db 33, BODY_SLAM
	db 36, METAL_SOUND
	db 39, THUNDERBOLT
	db 42, LIGHT_SCREEN
	db 45, IRON_HEAD
	db 48, TRI_ATTACK
	db 51, HEAVY_SLAM
	db 54, THUNDER
	db 57, IRON_DEFENSE
	db 60, MAGNET_BOMB
	db 0

FarfetchdEvosMoves:
; Evolutions
	db 0
; Learnset
; Duck samurai-bird with leek. Karate/leek combat style: KARATE_CHOP
; before LEEK_STRIKE. FAINT_ATTACK low (samurai sneak). PETAL_DANCE =
; leek-magic Grass move. EXTREMESPEED just before BRUTAL_SWING (high
; level). FLY via HM02 only, not levelup.
	db  6, TACKLE
	db  8, SAND_ATTACK
	db 12, FAINT_ATTACK
	db 15, QUICK_ATTACK
	db 18, KARATE_CHOP
	db 22, LEEK_STRIKE
	db 25, CUT
	db 27, SLASH
	db 30, NIGHT_SLASH
	db 38, AGILITY
	db 42, RECOVER
	db 48, SWORDS_DANCE
	db 52, PETAL_DANCE
	db 55, BRUTAL_SWING
	db 60, EXTREMESPEED
	db 62, THRASH
	db 65, OUTRAGE
	db 0

DoduoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, DODRIO
	db 0
; Learnset
; Flightless ratite. NO wing/gust flight moves despite Normal/Flying
; typing — anatomical exception. NO TRI_ATTACK (Porygon/Magneton/Mew
; signature). DRILL_PECK at evo L33 (long beak fully developed).
; GROUND_STOMP (heavy ratite legs).
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, LEER
	db 14, QUICK_ATTACK
	db 18, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 26, GROUND_STOMP
	db 30, AGILITY
	db 33, DRILL_PECK
	db 40, TAKE_DOWN
	db 55, DOUBLE_EDGE
	db 0

DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
; 3-headed ratite. Doduo backbone + exclusives: FAINT_ATTACK,
; EXTREMESPEED (high level, peak running speed), THRASH, HORN_DRILL
; (last move, long beak as horn-drill). NO TRI_ATTACK
; (Porygon/Magneton/Mew signature).
	db  4, PECK
	db  8, SAND_ATTACK
	db 11, LEER
	db 14, QUICK_ATTACK
	db 18, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 26, GROUND_STOMP
	db 30, AGILITY
	db 33, DRILL_PECK
	db 36, FAINT_ATTACK
	db 40, TAKE_DOWN
	db 46, EXTREMESPEED
	db 50, THRASH
	db 55, DOUBLE_EDGE
	db 60, HORN_DRILL
	db 0

SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, DEWGONG
	db 0
; Learnset
; Water/Ice seal. HORN_ATTACK (horn on the head).
; (TACKLE lives in the egg field — R22, Forte 2026-07-15.)
	db  4, TAIL_WHIP
	db  8, WATER_GUN
	db 10, DOUBLESLAP
	db 12, POWDER_SNOW
	db 14, CHARM
	db 16, HORN_ATTACK
	db 18, BUBBLEBEAM
	db 21, ICY_WIND
	db 24, FAKE_TEARS
	db 28, FROST_BREATH
	db 30, WATER_PULSE
	db 33, BODY_SLAM
	db 36, ICY_PULSE
	db 40, AQUA_JET
	db 42, AURORA_BEAM
	db 46, WATERFALL
	db 50, ICE_BEAM
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex Water/Ice. SURF natural via HM03. ICY_PULSE (no Lorelei quirk).
; (TACKLE lives in the egg field — R22, Forte 2026-07-15.)
	db  4, TAIL_WHIP
	db  8, WATER_GUN
	db 10, DOUBLESLAP
	db 12, POWDER_SNOW
	db 14, CHARM
	db 16, HORN_ATTACK
	db 18, BUBBLEBEAM
	db 21, ICY_WIND
	db 24, FAKE_TEARS
	db 28, FROST_BREATH
	db 30, WATER_PULSE
	db 33, BODY_SLAM
	db 36, ICY_PULSE
	db 40, AQUA_JET
	db 42, AURORA_BEAM
	db 46, WATERFALL
	db 50, ICE_BEAM
	db 55, PLAY_ROUGH
	db 60, HYDRO_PUMP
	db 62, BLIZZARD
	db 0

GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, MUK
	db 0
; Learnset
; Pure sludge blob Poison/Water. SLUDGE_WAVE = Grimer-line signature.
; RECOVER (sludge re-forms). NO bite/fang moves — sludge anatomy has
; no fangs.
	db  6, ASTONISH
	db  9, TACKLE
	db 12, WATER_GUN
	db 14, MUD_SHOT
	db 17, ACID
	db 21, RECOVER
	db 22, GROWTH
	db 26, BIND
	db 28, SMOG
	db 30, CORRODE
	db 31, BODY_SLAM
	db 33, SLUDGE
	db 36, TOXIC
	db 38, MUD_BOMB
	db 42, DISABLE
	db 45, SLUDGE_WAVE
	db 0

MukEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex sludge. Grimer backbone + Muk-exclusives: GUNK_SHOT signature
; very-high, TAKE_DOWN/ROCK_TOMB/IRON_DEFENSE/SCARY_FACE/HEAVY_SLAM.
; STRENGTH via HM.
	db  6, ASTONISH
	db  9, TACKLE
	db 12, WATER_GUN
	db 14, MUD_SHOT
	db 17, ACID
	db 21, RECOVER
	db 22, GROWTH
	db 26, BIND
	db 28, SMOG
	db 30, CORRODE
	db 31, BODY_SLAM
	db 33, SLUDGE
	db 36, TOXIC
	db 38, MUD_BOMB
	db 42, DISABLE
	db 45, SLUDGE_WAVE
	db 48, TAKE_DOWN
	db 50, IRON_DEFENSE
	db 52, ROCK_TOMB
	db 55, SCARY_FACE
	db 57, GUNK_SHOT
	db 60, HEAVY_SLAM
	db 0

ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
; Clam Water/Water. WITHDRAW (shell). CLAMP signature
; (Shellder/Cloyster ONLY).
	db  6, WATER_GUN
	db  9, BIDE
	db 13, ICY_WIND
	db 16, BUBBLEBEAM
	db 19, FROST_BREATH
	db 23, BIND
	db 23, CLAMP
	db 25, WATER_PULSE
	db 28, ICY_PULSE
	db 31, ROCK_TOMB
	db 34, AURORA_BEAM
	db 36, RECOVER
	db 40, BODY_SLAM
	db 42, GROWTH
	db 44, ICE_BEAM
	db 48, AQUA_JET
	db 50, IRON_DEFENSE
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex Water/Ice fortress. NEUROTOXIN (Shellder-line high).
; EXPLOSION (clam shells crack).
	db  6, WATER_GUN
	db  9, BIDE
	db 13, ICY_WIND
	db 16, BUBBLEBEAM
	db 19, FROST_BREATH
	db 23, BIND
	db 23, CLAMP
	db 25, WATER_PULSE
	db 28, ICY_PULSE
	db 31, ROCK_TOMB
	db 34, AURORA_BEAM
	db 36, RECOVER
	db 40, BODY_SLAM
	db 42, GROWTH
	db 44, ICE_BEAM
	db 46, NEUROTOXIN
	db 48, AQUA_JET
	db 50, IRON_DEFENSE
	db 53, HEAD_SMASH
	db 56, EXPLOSION
	db 60, SCARY_FACE
	db 62, HYDRO_PUMP
	db 65, BLIZZARD
	db 0

GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HAUNTER
	db 0
; Learnset
; Ghost/Poison gas wisp. Pairs of 2 per level with wide gaps.
; Gastly carries the shared backbone (15 moves, pre-evo).
	db  5, SMOG
	db  7, LEER
	db  9, ASTONISH
	db 17, NIGHT_SHADE
	db 17, WILL_O_WISP
	db 22, POISON_GAS
	db 26, FAINT_ATTACK
	db 26, SHADOW_SNEAK
	db 30, PSYWAVE
	db 34, DISABLE
	db 34, NASTY_PLOT
	db 38, SCARY_FACE
	db 44, SPIRIT_DRAIN
	db 0

HaunterEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, GENGAR
	db 0
; Learnset
; Ghost/Poison. Pairs of 2 per level with wide gaps. SHADOW_PUNCH at
; evo L42, SHADOW_BALL L44.
	db  5, SMOG
	db  7, LEER
	db  9, ASTONISH
	db 17, NIGHT_SHADE
	db 17, WILL_O_WISP
	db 22, POISON_GAS
	db 26, FAINT_ATTACK
	db 26, SHADOW_SNEAK
	db 30, PSYWAVE
	db 34, DISABLE
	db 34, NASTY_PLOT
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
; Apex Ghost/Poison. Pairs of 2 per level with wide gaps. Sneak-pair
; at Gastly evo L26, SHADOW_PUNCH at Haunter evo L42, SHADOW_BALL L44.
; DEEP_SLEEP+DREAM_EATER (eats what it puts to sleep). PSYCHIC_M last
; at L70. ICY_WIND covers ice.
	db  5, SMOG
	db  7, LEER
	db  9, ASTONISH
	db 17, NIGHT_SHADE
	db 17, WILL_O_WISP
	db 22, POISON_GAS
	db 26, FAINT_ATTACK
	db 26, SHADOW_SNEAK
	db 30, PSYWAVE
	db 34, DISABLE
	db 34, NASTY_PLOT
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
; Colossal rock-snake tunneler. Single mon, deep movepool. HAS JAW
; (eats earth to tunnel) -> CRUNCH; metallic core -> IRON_TAIL/IRON_
; HEAD/IRON_DEFENSE; snake form -> COIL/BIND; extreme deep-earth
; pressure -> DRAGON_BREATH/DRAGON_SLAM; HYPER_BEAM last at L70.
; No wild-fire moves (gentle giant under all that defense). Pairs at
; same level: COIL+BIND, BIDE+LEER, CRUNCH+DIG, IRON_TAIL+BRUTAL_SWING.
; FISSURE signature. ROCK_THROW@18 = exception (pushes the rock with
; its tail; serpent has no hands).
	db  6, GROUND_STOMP
	db  8, BIND
	db  8, COIL
	db 12, BIDE
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
; Psychic hypnotist. HYPNOSIS L1 (low). DEEP_SLEEP signature
; (Drowzee-line). DREAM_EATER signature.
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
; Apex hypnotist. Drowzee backbone + Hypno-exclusives: SCARY_FACE
; (L46), SHADOW_PUNCH (L55), REFLECT (L58), SHADOW_BALL (L65).
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
; Scrappy pincer crab. VICEGRIP is a shared signature (Krabby line +
; Pinsir). CRABHAMMER signature at evo L28. HARDEN carapace; MUD_SHOT
; beach burrower; FURY_ATTACK pincer jabs; GUILLOTINE apex pincer
; (shared with Kingler).
	db 13, HARDEN
	db 15, MUD_SHOT
	db 17, VICEGRIP
	db 19, BUBBLEBEAM
	db 24, FURY_ATTACK
	db 26, BIND
	db 28, CRABHAMMER
	db 30, WATER_PULSE
	db 44, GUILLOTINE
	db 0

KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex crusher crab (110 Atk / 110 Def). Shared Krabby backbone at the
; same levels; adds the heavy-claw kit: STRENGTH/CUT (shear claw),
; WATERFALL, BRUTAL_SWING (massive claw sweep). No IRON_DEFENSE
; (organic chitin hardens via HARDEN; steel flavor is for mineral/metal
; bodies). SURF is HM-only; SWORDS_DANCE stays TM-only.
	db 13, HARDEN
	db 15, MUD_SHOT
	db 17, VICEGRIP
	db 19, BUBBLEBEAM
	db 24, FURY_ATTACK
	db 26, BIND
	db 28, CRABHAMMER
	db 28, CUT
	db 30, STRENGTH
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
; Living pokeball — sphere, no limbs. HARDEN (a rigid metal sphere
; tightens its shell — it can't curl), METAL_SOUND (Steel typing),
; ROLLOUT L29 (it IS a rolling ball). EXPLOSION owner, shared L44.
	db  6, HEADBUTT
	db 10, HARDEN
	db 12, SUPERSONIC
	db 15, QUICK_ATTACK
	db 18, THUNDERSHOCK
	db 20, SONICBOOM
	db 22, SHOCK_WAVE
	db 25, SCREECH
	db 25, EERIE_IMPULSE
	db 28, ROLLOUT
	db 30, BODY_SLAM
	db 33, AGILITY
	db 33, VOLT_TACKLE
	db 36, IRON_HEAD
	db 39, METAL_SOUND
	db 42, THUNDERBOLT
	db 46, EXPLOSION
	db 50, EXTREMESPEED
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex sphere (130 Spd). AGILITY at L31 (full-speed roll). ROLLOUT
; shared. Screens pair, THUNDER apex top. EXPLOSION shared with Voltorb.
	db  6, HEADBUTT
	db 10, HARDEN
	db 12, SUPERSONIC
	db 15, QUICK_ATTACK
	db 18, THUNDERSHOCK
	db 20, SONICBOOM
	db 22, SHOCK_WAVE
	db 25, SCREECH
	db 25, EERIE_IMPULSE
	db 28, ROLLOUT
	db 30, BODY_SLAM
	db 33, AGILITY
	db 33, VOLT_TACKLE
	db 36, IRON_HEAD
	db 39, METAL_SOUND
	db 42, THUNDERBOLT
	db 46, EXPLOSION
	db 46, HEAVY_SLAM
	db 48, DOUBLE_EDGE
	db 50, EXTREMESPEED
	db 55, THUNDER
	db 60, IRON_DEFENSE
	db 65, MAGNET_BOMB
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
; Egg cluster Grass/Psychic. No powders — uses psychic Hypnosis
; instead. GROWTH (plant).
	db  4, AMNESIA
	db  7, BIDE
	db 10, LEECH_SEED
	db 14, MEGA_DRAIN
	db 17, CONFUSION
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
; Apex egg-tree. Exeggcute backbone + Exeggutor-exclusives: HEADBUTT/
; GROUND_STOMP/BODY_SLAM/DOUBLE_EDGE/SOLARBEAM (apex tree).
	db  4, AMNESIA
	db  7, BIDE
	db 10, LEECH_SEED
	db 14, MEGA_DRAIN
	db 17, CONFUSION
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
; Bone-wielder small reptile-mammal, sad lonely lore. FAIRY_WIND
; Cubone-only (baby Fairy presence pre-evo). BONE_CLUB signature.
; FIERCE_ROAR L13 alongside BONE_CLUB. BULK_UP L28 alongside RAGE.
; No RECOVER/GROWTH: the child cannot heal or grow on its own, it only
; suffers and fights.
	db  4, FAIRY_WIND
	db 13, BONE_CLUB
	db 13, FIERCE_ROAR
	db 18, HEADBUTT
	db 20, FAINT_ATTACK
	db 26, BONEMERANG
	db 28, BULK_UP
	db 28, RAGE
	db 34, BULLDOZE
	db 44, DOUBLE_EDGE
	db 44, HEAD_SMASH
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex bone-wielder, ghost-mother lore unlocked. Cubone backbone (no
; FAIRY_WIND/RECOVER/GROWTH) + Marowak-exclusives: DARK_PULSE (gains on
; evolving, L32), BIDE+EERIE_IMPULSE just after evo, DISABLE,
; SPIRIT_DRAIN, INTIMIDATE/SCARY_FACE/NIGHT_SHADE/THRASH/OUTRAGE/
; GORE_ATTACK/FISSURE/STRENGTH (HM)/EXPLOSION apex L65.
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
; Pure leg-only kicker, single-stage. BRUTAL_SWING as a leg swing.
; HI_JUMP_KICK signature apex. No SUBMISSION (a Machamp/Poliwrath
; technique, not a kicker). STRENGTH via HM only.
	db  6, TACKLE
	db 10, GROUND_STOMP
	db 16, FOCUS_ENERGY
	db 16, CALM_MIND
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
	db 60, EXTREMESPEED
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
; Pure fist-only puncher, single-stage. DEFENSE_CURL L1 (boxer's
; initial guard). Elemental coverage is 100% punches: ROCK_PUNCH/
; SHADOW_PUNCH/MAGMA_PUNCH (no FLAME_BURST/SHOCK_WAVE/ICY_WIND — those
; are special attacks, not punches). RECOVER for boxer stamina.
; MAGMA_PUNCH signature exception. STRENGTH via HM only.
	db 6, DEFENSE_CURL
	db 10, QUICK_ATTACK
	db 12, MACH_PUNCH
	db 16, FOCUS_ENERGY
	db 16, CALM_MIND
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
	db 55, EXTREMESPEED
	db 60, MAGMA_PUNCH
	db 0

LickitungEvosMoves:
; Evolutions
	db 0
; Learnset
; Normal/Poison tongue reptile. LICK signature; egg = LICK/TAIL_WHIP.
; GROUND_STOMP early; SLUDGE_WAVE penultimate, TOXIC last (L65).
	db  4, DEFENSE_CURL
	db  7, SCREECH
	db 10, HINDER
	db 12, HEADBUTT
	db 15, CONSTRICT
	db 18, GROUND_STOMP
	db 21, ASTONISH
	db 24, WATER_GUN
	db 27, BIDE
	db 30, ROLLOUT
	db 33, ACID
	db 37, BIND
	db 41, PLAY_ROUGH
	db 45, BODY_SLAM
	db 49, SEISMIC_TOSS
	db 53, DOUBLE_EDGE
	db 57, BRUTAL_SWING
	db 61, SLUDGE_WAVE
	db 65, TOXIC
	db 0

KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, WEEZING
	db 0
; Learnset
; Gas balloon Poison/Gas. Kit: acid/sludge/toxic + Gas type only.
; EXPLOSION apex. No GUNK_SHOT (Grimer-only signature).
	db  6, TACKLE
	db 12, DISABLE
	db 16, ACID
	db 19, EMBER
	db 22, BIDE
	db 25, GROWTH
	db 28, EERIE_IMPULSE
	db 31, CORRODE
	db 31, NIGHT_SHADE
	db 34, SLUDGE
	db 36, HAZE
	db 40, TOXIC
	db 42, LIGHT_SCREEN
	db 46, SLUDGE_WAVE
	db 49, FLAMETHROWER
	db 55, EXPLOSION
	db 60, RECOVER
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex gas balloon. Koffing backbone (incl. shared CORRODE L31) +
; Weezing-exclusives: SCARY_FACE (L52), GUNK_SHOT (L61), DARK_PULSE
; (L65). EXPLOSION shared at L55.
	db  6, TACKLE
	db 12, DISABLE
	db 16, ACID
	db 19, EMBER
	db 22, BIDE
	db 25, GROWTH
	db 28, EERIE_IMPULSE
	db 31, CORRODE
	db 31, NIGHT_SHADE
	db 34, SLUDGE
	db 36, HAZE
	db 40, TOXIC
	db 42, LIGHT_SCREEN
	db 46, SLUDGE_WAVE
	db 49, FLAMETHROWER
	db 52, SCARY_FACE
	db 55, EXPLOSION
	db 60, RECOVER
	db 62, GUNK_SHOT
	db 65, DARK_PULSE
	db 0

RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, RHYDON
	db 0
; Learnset
; Rhinoceros charger (Ground/Rock). HEAD_SMASH at L40 (= evo level,
; signature on the evo). Pairs at same level: SAND_ATTACK+GROUND_STOMP
; (L13), FOCUS_ENERGY+RAGE (L22). No HORN_DRILL/FISSURE/EARTHQUAKE in
; shared (Rhydon-only).
	db  4, TACKLE
	db 10, HORN_ATTACK
	db 13, SAND_ATTACK
	db 16, ROCK_TOMB
	db 19, BODY_SLAM
	db 22, RAGE
	db 28, BULLDOZE
	db 36, IRON_HEAD
	db 40, HEAD_SMASH
	db 44, TAKE_DOWN
	db 0

RhydonEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex rhinoceros (Ground/Rock). Rhyhorn backbone + Rhydon-only
; exclusives: MEGAHORN, HORN_CHARGE (matured horn just after evo),
; EARTHQUAKE, FIERCE_ROAR, STRENGTH (HM), BRUTAL_SWING, THRASH (primal
; force), HORN_DRILL (shared signature with Dodrio), FISSURE. No
; DRAGON_SLAM (rhino, not dragon; no extreme-pressure justification like
; Onix). MEGAHORN apex horn — gesture over type: a rhino horn.
	db  4, TACKLE
	db 10, HORN_ATTACK
	db 13, SAND_ATTACK
	db 16, ROCK_TOMB
	db 19, BODY_SLAM
	db 22, RAGE
	db 28, BULLDOZE
	db 32, STRENGTH
	db 36, IRON_HEAD
	db 40, HEAD_SMASH
	db 42, HORN_CHARGE
	db 44, TAKE_DOWN
	db 48, FIERCE_ROAR
	db 51, EARTHQUAKE
	db 54, MEGAHORN
	db 56, ROCK_SLIDE
	db 58, BRUTAL_SWING
	db 61, THRASH
	db 63, HORN_DRILL
	db 65, FISSURE
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
; Normal/Fairy heal-tank. SOFTBOILED signature (Chansey only).
; No TAIL_WHIP (tail too small), no DEFENSE_CURL (not ball-shaped).
; Heal-tank kit + LIGHT_SCREEN/REFLECT support.
	db  3, FAIRY_WIND
	db  6, DOUBLESLAP
	db  9, TACKLE
	db 12, CALM_MIND
	db 15, CHARM
	db 17, SING
	db 19, TICKLE
	db 21, HEADBUTT
	db 23, DRAINING_KISS
	db 26, DISABLE
	db 28, EXTRASENSORY
	db 31, LIGHT_SCREEN
	db 34, BIDE
	db 38, PAY_DAY
	db 41, REFLECT
	db 43, DAZZLE_GLEAM
	db 45, FAKE_TEARS
	db 50, SEISMIC_TOSS
	db 53, PETAL_DANCE
	db 57, MOONBLAST
	db 60, METRONOME
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
; Grass/Water vines, single-stage. Powder table: STUN_POWDER only.
; Vine kit: VINE_WHIP/MEGA_DRAIN/GIGA_DRAIN/WRAP/CONSTRICT/GROWTH.
; CUT HM01 natural. RECOVER fits (vines regenerate; semi-defensive).
	db  4, GROWTH
	db  6, WRAP
	db  6, TICKLE
	db 12, VINE_WHIP
	db 14, DEFENSE_CURL
	db 16, LICK
	db 19, ABSORB
	db 22, WATER_GUN
	db 24, TACKLE
	db 26, LEECH_SEED
	db 30, STUN_POWDER
	db 33, BIND
	db 36, BUBBLEBEAM
	db 40, ASTONISH
	db 42, MEGA_DRAIN
	db 45, RECOVER
	db 48, BODY_SLAM
	db 50, WATER_PULSE
	db 53, PETAL_DANCE
	db 55, GIGA_DRAIN
	db 60, LEECH_LIFE
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
; Protective savanna mother. SAND_ATTACK early (kicks sand to cover
; the cub's retreat), COMET_PUNCH then DIZZY_PUNCH high (her canon
; signature punch) on the punch/contact ladder 18<45<52<56. THRASH
; not OUTRAGE; no DOUBLE_EDGE (a mother with a baby is never
; reckless). BIND = restraining grab; BIDE = endures.
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
	db 45, DIZZY_PUNCH
	db 52, TAKE_DOWN
	db 56, THRASH
	db 0

HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, SEADRA
	db 0
; Learnset
; Ink-spitting seahorse. ICY_WIND (cold-current rider, pre-ICY_PULSE).
; DRAGON_BREATH at evo L26 = dragon blood awakening (key level).
	db 10, SMOKESCREEN
	db 15, ICY_WIND
	db 18, BUBBLEBEAM
	db 20, HARDEN
	db 20, POISON_STING
	db 23, AQUA_JET
	db 26, WATER_PULSE
	db 28, FOCUS_ENERGY
	db 31, ICY_PULSE
	db 35, WATERFALL
	db 55, NEUROTOXIN
	db 60, AGILITY
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
; Water/Dragon. Horsea backbone + dragon kit: DRAGON_BREATH post-evo,
; ICE_BEAM, DRAGON_SLAM apex. No DRAGON_CLAW (no claws).
	db 10, SMOKESCREEN
	db 15, ICY_WIND
	db 18, BUBBLEBEAM
	db 20, HARDEN
	db 20, POISON_STING
	db 23, AQUA_JET
	db 26, WATER_PULSE
	db 28, FOCUS_ENERGY
	db 31, ICY_PULSE
	db 35, WATERFALL
	db 39, DRAGON_BREATH
	db 45, ICE_BEAM
	db 50, HYDRO_PUMP
	db 55, NEUROTOXIN
	db 60, AGILITY
	db 0

GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, SEAKING
	db 0
; Learnset
; Horned river fish. WATER_PULSE at evo L24 (key level); WATERFALL
; L36. BIDE (stubborn river fish), ICY_PULSE (cold streams).
	db 13, HORN_ATTACK
	db 15, SUPERSONIC
	db 18, BUBBLEBEAM
	db 21, FURY_ATTACK
	db 24, WATER_PULSE
	db 28, BIDE
	db 30, AQUA_JET
	db 33, ICY_PULSE
	db 36, WATERFALL
	db 40, HORN_CHARGE
	db 60, AGILITY
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex river guardian. Goldeen backbone + RAGE (territorial males
; duel), SURF, MEGAHORN top. No HORN_DRILL: the horn identity is
; HORN_ATTACK -> HORN_CHARGE -> MEGAHORN.
	db 13, HORN_ATTACK
	db 15, SUPERSONIC
	db 18, BUBBLEBEAM
	db 21, FURY_ATTACK
	db 24, WATER_PULSE
	db 26, RAGE
	db 28, BIDE
	db 30, AQUA_JET
	db 33, ICY_PULSE
	db 36, WATERFALL
	db 40, HORN_CHARGE
	db 44, ICE_BEAM
	db 48, SURF
	db 54, MEGAHORN
	db 60, AGILITY
	db 0

StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, STARMIE
	db 0
; Learnset
; Star with a regenerating gem core. MOON_STONE evolution.
; EERIE_IMPULSE (alien gem pulses), DAZZLE_GLEAM (gem light burst),
; RECOVER L25 (core regen), HARDEN (crystal body). Stone-evo line:
; pre-evo carries most of the kit (Starmie adds the top-end).
	db 13, WATER_GUN
	db 15, QUICK_ATTACK
	db 17, PSYWAVE
	db 19, AQUA_JET
	db 21, BUBBLEBEAM
	db 25, RECOVER
	db 30, GROWTH
	db 31, EERIE_IMPULSE
	db 33, WATER_PULSE
	db 35, DAZZLE_GLEAM
	db 37, PSYBEAM
	db 42, LIGHT_SCREEN
	db 44, AURORA_BEAM
	db 48, HYDRO_PUMP
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
; Water/Psychic mystic star. Staryu backbone + GROWTH, SURF
; before the shared HYDRO_PUMP, PSYCHIC_M apex, MOONBLAST high-level
; (the core is a moon-gem).
	db 13, WATER_GUN
	db 15, QUICK_ATTACK
	db 17, PSYWAVE
	db 19, AQUA_JET
	db 21, BUBBLEBEAM
	db 25, RECOVER
	db 30, GROWTH
	db 31, EERIE_IMPULSE
	db 33, WATER_PULSE
	db 35, DAZZLE_GLEAM
	db 37, PSYBEAM
	db 42, LIGHT_SCREEN
	db 46, SURF
	db 48, HYDRO_PUMP
	db 50, AURORA_BEAM
	db 56, PSYCHIC_M
	db 60, MOONBLAST
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
; Psychic/Fairy mime, single-stage. All 4 fun moves via natural
; levelup. LIGHT_SCREEN/REFLECT canonical, DAZZLE_GLEAM, FAIRY_WIND,
; CHARM, PSYCHIC_BIND. No MOONBLAST.
	db  5, CHARM
	db  8, FAIRY_WIND
	db 10, CONFUSION
	db 12, FAKE_TEARS
	db 16, MIRROR_MOVE
	db 18, MIMIC
	db 22, DISABLE
	db 22, PSYCHIC_BIND
	db 26, LIGHT_SCREEN
	db 26, REFLECT
	db 32, AMNESIA
	db 36, METRONOME
	db 38, EXTRASENSORY
	db 41, HYPNOSIS
	db 44, DAZZLE_GLEAM
	db 46, DOUBLE_TEAM
	db 48, SUBSTITUTE
	db 52, SHADOW_PUNCH
	db 55, PSYCHIC_M
	db 60, PETAL_DANCE
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
; Mantis blade-ninja. Speed/stealth kit: QUICK_ATTACK, FAINT_ATTACK,
; SHADOW_SNEAK (ambush phantom). ASTONISH (the mantis threat-display
; is a startle) opens the stealth trio ASTONISH -> FAINT_ATTACK ->
; SHADOW_SNEAK. EXTREMESPEED L56 (agile + superhuman reflexes).
; Blade ladder SLASH -> CUT -> NIGHT_SLASH; HONE_CLAWS = sharpening
; the scythes; GUILLOTINE last (mantis decapitation).
; No BUG_BUZZ (Butterfree + Venomoth only).
	db 10, QUICK_ATTACK
	db 12, FOCUS_ENERGY
	db 14, ASTONISH
	db 16, BUG_BITE
	db 18, WING_ATTACK
	db 20, CUT
	db 22, SLASH
	db 24, HONE_CLAWS
	db 28, FAINT_ATTACK
	db 30, AGILITY
	db 32, SHADOW_SNEAK
	db 35, TAKE_DOWN
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
; Ghost/Ice Fairy-coded singer with a big movepool. POWDER_SNOW
; before ICY_WIND. SING at L27. Fairy/ghost kit: DRAINING_KISS,
; CHARM, FAIRY_WIND, NIGHT_SHADE, SPIRIT_DRAIN, SHADOW_BALL,
; EERIE_IMPULSE, FROST_BREATH, DARK_PULSE L60. No CONFUSE_RAY
; (redundant with LOVELY_KISS, which already confuses). No PLAY_ROUGH
; (an elegant singer, not a rough biter).
	db  5, TICKLE
	db  8, FAIRY_WIND
	db 11, POWDER_SNOW
	db 13, ICY_WIND
	db 16, LICK
	db 18, LOVELY_KISS
	db 20, PSYWAVE
	db 22, EERIE_IMPULSE
	db 22, DISABLE
	db 24, FROST_BREATH
	db 27, SING
	db 30, DRAINING_KISS
	db 33, CHARM
	db 36, ICY_PULSE
	db 39, EXTRASENSORY
	db 42, DOUBLE_TEAM
	db 45, NIGHT_SHADE
	db 48, AURORA_BEAM
	db 51, SHADOW_BALL
	db 54, ICE_BEAM
	db 57, SPIRIT_DRAIN
	db 60, DARK_PULSE
	db 65, BLIZZARD
	db 0

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
; Boxer Electric, counterpart of Magmar. NUZZLE L1, DIZZY_PUNCH and
; MACH_PUNCH for the boxer kit. EXTREMESPEED/AGILITY very high.
; No SOLARBEAM (a boxer Electric isn't solar-coded).
	db  5, NUZZLE
	db  8, LOW_KICK
	db 11, SCREECH
	db 14, THUNDERSHOCK
	db 17, QUICK_ATTACK
	db 20, THUNDER_WAVE
	db 23, SHOCK_WAVE
	db 26, LIGHT_SCREEN
	db 26, FLASH
	db 28, THUNDERBOLT
	db 30, FAINT_ATTACK
	db 32, MACH_PUNCH
	db 35, BULK_UP
	db 38, DIZZY_PUNCH
	db 42, BULLET_PUNCH
	db 47, METAL_SOUND
	db 50, AGILITY
	db 50, THUNDER
	db 55, THRASH
	db 60, FLAME_CHARGE
	db 65, MAGNET_BOMB
	db 0

MagmarEvosMoves:
; Evolutions
	db 0
; Learnset
; Fire/Magma boxer, counterpart of Electabuzz. POISON_GAS L4 (vents
; toxic gas), ROCK_PUNCH after MAGMA_PUNCH. HM CUT.
; No DRAGON_RAGE/DRAGON_BREATH (Magmar is Fire/Magma, not Dragon).
	db  5, POISON_GAS
	db  8, SMOKESCREEN
	db 11, IGNITE
	db 14, SMOG
	db 17, MAGMA_PUNCH
	db 20, ROCK_PUNCH
	db 23, SEISMIC_TOSS
	db 26, FOCUS_ENERGY
	db 28, FLAME_BURST
	db 30, FLASH
	db 32, ROCK_TOMB
	db 35, FLAMETHROWER
	db 38, BODY_SLAM
	db 42, CORRODE
	db 44, LAVA_PLUME
	db 47, LIGHT_SCREEN
	db 50, GROWTH
	db 50, FIRE_BLAST
	db 55, SOLARBEAM
	db 60, HAZE
	db 65, EXPLOSION
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
; Stag-beetle grappler. VICEGRIP (shared almost-signature with the
; Krabby line). DIG L36 (dex canon: buries itself on cold nights;
; horns excavate), DOUBLE_EDGE L55 (stag beetles ram full-body in
; duels), SUBMISSION L57 (full-body grappling slam fits the brute).
; No SLASH (no claws), no BUG_BUZZ (silent; no buzzing wings).
	db  8, HARDEN
	db 10, FOCUS_ENERGY
	db 13, BIDE
	db 16, BUG_BITE
	db 19, SEISMIC_TOSS
	db 21, VICEGRIP
	db 23, CUT
	db 25, BIND
	db 29, STRENGTH
	db 33, BULK_UP
	db 36, DIG
	db 40, BODY_SLAM
	db 42, TAKE_DOWN
	db 46, GORE_ATTACK
	db 50, MEGAHORN
	db 53, THRASH
	db 55, DOUBLE_EDGE
	db 57, SUBMISSION
	db 60, GUILLOTINE
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
; Powerful wild bull. Identity kit: HORN_CHARGE/THRASH/TAKE_DOWN/
; GORE_ATTACK/INTIMIDATE/SCARY_FACE/BIDE/STRENGTH + BULLDOZE,
; SWORDS_DANCE, DOUBLE_EDGE. OUTRAGE is the last move, after
; HORN_DRILL. No EXTREMESPEED (fast, not agile).
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
; Minimalist Water (canon weakest). 5 moves total, faithful to canon.
; RAGE L25 (one before the L26 evo).
	db 10, TACKLE
	db 15, WATER_GUN
	db 20, BIDE
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
; Water/Dragon-coded sea-serpent apex. Brutal, mainly physical, not
; docile. HYPER_BEAM L65 last move. 5 backbone (Magikarp) + Gyarados-
; exclusives in a post-evo burst @27-65: BITE, INTIMIDATE, COIL (snake-
; coil), Dragon-coded DRAGON_BREATH/DRAGON_SLAM/OUTRAGE, SURF/HYDRO_PUMP/
; EARTHQUAKE/THRASH/HEAVY_SLAM. SURF/STRENGTH HMs.
	db 10, TACKLE
	db 15, WATER_GUN
	db 20, BIDE
	db 26, BITE
	db 26, RAGE
	db 28, WATER_PULSE
	db 30, COIL
	db 33, BODY_SLAM
	db 34, FIERCE_ROAR
	db 36, WATERFALL
	db 37, CRUNCH
	db 40, INTIMIDATE
	db 43, TAKE_DOWN
	db 45, DRAGON_RAGE
	db 47, BRUTAL_SWING
	db 50, DRAGON_SLAM
	db 52, THRASH
	db 55, DRAGON_BREATH
	db 55, HYDRO_PUMP
	db 58, HEAVY_SLAM
	db 60, EARTHQUAKE
	db 62, OUTRAGE
	db 65, HYPER_BEAM
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
; Gentle singing ferry. Psychic damage and the rest of the Fairy
; arsenal (Draining Kiss/Dazzle Gleam/Moonblast) are TM-only here.
; ICE ladder strictly scaled by power: ICY_WIND < FROST_BREATH <
; ICY_PULSE < AURORA_BEAM < ICE_BEAM < BLIZZARD. SING after L30.
; STRENGTH = hauls passengers; SURF = THE ferry move. No THRASH/
; OUTRAGE (docile).
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
; TRANSFORM only, by design — no TMs, no other moves. Transform IS
; Ditto.
	db 0

EeveeEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, FLAREON
	db EVOLVE_ITEM, THUNDER_STONE, 1, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, 1, VAPOREON
	db 0
; Learnset
; Normal-only base. No TAKE_DOWN (only Eevee lacks it; the 3
; evolutions keep it). CHARM = cute fox charm, shared with all 4 forms.
	db  4, TAIL_WHIP
	db  7, SAND_ATTACK
	db 10, QUICK_ATTACK
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 30, BODY_SLAM
	db 36, PLAY_ROUGH
	db 40, DOUBLE_EDGE
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
; Water fox, fluid body. Eevee shared + water/ice kit + HARDEN (fluid
; body solidifies to ice/scale armor) + RECOVER (regen pattern, fluid
; body reforms). HARDEN L30 (weak-move guideline), RECOVER L32.
; ICE_BEAM, not light wind — its water-mastery deserves a real ice
; attack.
	db  4, TAIL_WHIP
	db  7, SAND_ATTACK
	db 10, QUICK_ATTACK
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 22, WATER_GUN
	db 24, TAKE_DOWN
	db 26, BUBBLEBEAM
	db 28, WATER_PULSE
	db 30, BODY_SLAM
	db 30, HARDEN
	db 32, RECOVER
	db 36, PLAY_ROUGH
	db 40, AURORA_BEAM
	db 44, SURF
	db 48, ICE_BEAM
	db 54, DOUBLE_EDGE
	db 60, HYDRO_PUMP
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
; Electric fox, fastest Eeveelution. Eevee shared + electric kit +
; METAL_SOUND (electric sparks = metallic-sound debuff). AGILITY
; natural. No DOUBLE_TEAM.
	db  4, TAIL_WHIP
	db  7, SAND_ATTACK
	db 10, QUICK_ATTACK
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 22, THUNDERSHOCK
	db 24, TAKE_DOWN
	db 26, THUNDER_WAVE
	db 28, SHOCK_WAVE
	db 28, CUT
	db 30, SLASH
	db 32, AGILITY
	db 36, PLAY_ROUGH
	db 40, METAL_SOUND
	db 44, THUNDERBOLT
	db 48, EXTREMESPEED
	db 54, DOUBLE_EDGE
	db 60, THUNDER
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
; Fire fox. Eevee shared (CHARM included, TAKE_DOWN kept — only Eevee
; lacks it). IGNITE early L26 (basic burn utility), SWORDS_DANCE late
; (peak claw-buff before final fire).
	db  4, TAIL_WHIP
	db  7, SAND_ATTACK
	db 10, QUICK_ATTACK
	db 14, BITE
	db 18, HEADBUTT
	db 20, CHARM
	db 22, EMBER
	db 24, TAKE_DOWN
	db 26, IGNITE
	db 28, FLAME_CHARGE
	db 28, CUT
	db 30, SLASH
	db 32, FAINT_ATTACK
	db 36, PLAY_ROUGH
	db 40, FLAME_BURST
	db 44, FLAMETHROWER
	db 48, SWORDS_DANCE
	db 54, DOUBLE_EDGE
	db 60, FIRE_BLAST
	db 0

PorygonEvosMoves:
; Evolutions
	db 0
; Learnset
; Digital construct. Fun moves are natural levelup here (copy.exe/
; mirror.exe/decoy.exe/random.exe). TRI_ATTACK L46 signature, RECOVER
; (file restore), MAGNET_BOMB L58 (shared signature with Magneton),
; HYPER_BEAM L65 last. No NASTY_PLOT, no TRANSFORM (Ditto), no
; CONVERSION.
	db 10, CONFUSION
	db 12, DISABLE
	db 14, AGILITY
	db 18, RECOVER
	db 20, THUNDER_WAVE
	db 22, SHOCK_WAVE
	db 24, METAL_SOUND
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
; Ammonite spiral shell, Rock/Water. WITHDRAW into shell. Water+Rock
; physical kit. No SURF/STRENGTH HM yet — those come at Omastar.
	db  8, HEADBUTT
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
; Apex ammonite. 12 backbone (Omanyte) + Omastar-exclusives:
; IRON_DEFENSE, HYDRO_PUMP, IRON_HEAD, ICE_BEAM apex (cold-water
; ammonite). SURF/STRENGTH HMs natural.
	db  8, HEADBUTT
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
; Trilobite-crab, Rock/Bug. WITHDRAW into shell. MEGA_DRAIN/LEECH_LIFE
; parasitic feed. Water+Rock physical kit.
	db  8, WATER_GUN
	db 13, LEER
	db 18, ROCK_THROW
	db 22, BUBBLEBEAM
	db 26, ICY_PULSE
	db 28, CUT
	db 30, SLASH
	db 35, MEGA_DRAIN
	db 43, LEECH_LIFE
	db 47, ROCK_TOMB
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex trilobite-crab. 12 backbone (Kabuto) + Kabutops-exclusives:
; NIGHT_SLASH (Dark slash claws), SWORDS_DANCE (apex predator),
; HEAD_SMASH, GUILLOTINE. CUT/SURF/STRENGTH HMs natural.
	db  8, WATER_GUN
	db 13, LEER
	db 18, ROCK_THROW
	db 22, BUBBLEBEAM
	db 26, ICY_PULSE
	db 28, CUT
	db 30, SLASH
	db 35, MEGA_DRAIN
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
; Pterodactyl, Rock/Flying apex predator, single-stage. FLY/SKY_ATTACK/
; AGILITY/INTIMIDATE fit the flying apex predator. CUT/FLY/STRENGTH HMs
; natural. No HYPER_BEAM, no EXTREMESPEED.
	db  8, TAILWIND
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
; Gentle lazy giant. Egg moves = TACKLE + AMNESIA + REST. SMOG L14
; early (post-banquet toxic belch — eats anything). PLAY_ROUGH L34
; (giant roughhousing). No SUBMISSION (Machamp/Poliwrath signature).
; GROWTH (it grows!), ROLLOUT (rolls its bulk), BIND (bear hug),
; THRASH (woken fury). STRENGTH HM-only.
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
; Parallel legendary-bird kit (PECK/GUST/LEER/WING_ATTACK/TAILWIND/
; AGILITY/AERIAL_ACE/FLY/FOCUS_ENERGY/HURRICANE/SKY_ATTACK at identical
; levels across the trio) + full ICE ladder. FOCUS_ENERGY early L16
; (raptor fixing its prey — too weak for a high slot). Catch set @L50:
; AURORA_BEAM/FLY/ICE_BEAM/HURRICANE.
	db 12, GUST
	db 14, LEER
	db 16, FOCUS_ENERGY
	db 18, ICY_WIND
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 28, FROST_BREATH
	db 30, AGILITY
	db 32, AERIAL_ACE
	db 34, QUIVER_DANCE
	db 36, AURORA_BEAM
	db 38, FLY
	db 42, ICE_BEAM
	db 46, HURRICANE
	db 50, RECOVER
	db 52, BLIZZARD
	db 56, SKY_ATTACK
	db 65, HYPER_BEAM
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
; Parallel trio kit + ELECTRIC ladder. DRILL_PECK L44 (the electric
; dive-drill; shared with Dodrio line + Fearow). Placed after FLY per
; the FLYING ladder. FOCUS_ENERGY early L16. Catch set @L50: FLY/
; THUNDERBOLT/DRILL_PECK/HURRICANE.
	db 12, GUST
	db 14, LEER
	db 16, FOCUS_ENERGY
	db 18, THUNDER_WAVE
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 28, SHOCK_WAVE
	db 30, AGILITY
	db 32, AERIAL_ACE
	db 34, QUIVER_DANCE
	db 38, FLY
	db 42, THUNDERBOLT
	db 42, DRILL_PECK
	db 46, HURRICANE
	db 50, RECOVER
	db 52, THUNDER
	db 56, SKY_ATTACK
	db 65, HYPER_BEAM
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
; Parallel trio kit + FIRE ladder (FLAME_CHARGE early — a flying
; flame; IGNITE = sets the sky on fire). FOCUS_ENERGY early L16.
; Catch set @L50: FLAME_BURST/FLY/FLAMETHROWER/HURRICANE.
	db 12, GUST
	db 14, LEER
	db 16, FOCUS_ENERGY
	db 18, FLAME_CHARGE
	db 22, WING_ATTACK
	db 26, TAILWIND
	db 28, IGNITE
	db 30, AGILITY
	db 32, AERIAL_ACE
	db 34, QUIVER_DANCE
	db 36, FLAME_BURST
	db 38, FLY
	db 42, FLAMETHROWER
	db 46, HURRICANE
	db 50, RECOVER
	db 52, FIRE_BLAST
	db 56, SKY_ATTACK
	db 65, HYPER_BEAM
	db 0

DratiniEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DRAGONAIR
	db 0
; Learnset
; Dragon sea-snake baby. CONSTRICT/BIND wrap kit. COIL (snake-coil).
; DRAGON_BREATH first Dragon move pre-evo.
	db  6, TACKLE
	db  8, CONSTRICT
	db 12, COIL
	db 16, BIND
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
; Dragon sea-serpent mid-evo. 12 backbone (Dratini) + Dragonair-
; exclusives: IRON_TAIL L39, DRAGON_RAGE L43 (signature) and FLY L46 =
; evo level.
	db  6, TACKLE
	db  8, CONSTRICT
	db 12, COIL
	db 16, BIND
	db 21, BODY_SLAM
	db 25, DRAGON_BREATH
	db 29, WATER_PULSE
	db 33, SHOCK_WAVE
	db 37, ICY_PULSE
	db 39, IRON_TAIL
	db 41, SURF
	db 43, DRAGON_RAGE
	db 46, FLY  ; (Evo lvl)
	db 53, DRAGON_SLAM
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
; Apex Dragon. 15 backbone (Dragonair) + Dragonite-exclusives:
; STRENGTH L49 HM natural, EXTRASENSORY, BULLDOZE, ROCK_TOMB,
; TAKE_DOWN, BRUTAL_SWING, OUTRAGE L63, HYPER_BEAM L65 last move.
	db  6, TACKLE
	db  8, CONSTRICT
	db 12, COIL
	db 16, BIND
	db 21, BODY_SLAM
	db 25, DRAGON_BREATH
	db 29, WATER_PULSE
	db 33, SHOCK_WAVE
	db 37, ICY_PULSE
	db 39, IRON_TAIL
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
; Psychic apex + honorary Dark. Egg moves = TACKLE/TELEPORT/CONFUSION/
; DISABLE (shared with Mew). Learns up to L75. FOCUS_ENERGY early,
; OUTRAGE (the bitterness unleashed), EXTREMESPEED. No CALM_MIND — its
; mind is anything but calm. MIND_BREAK L60 signature; HYPER_BEAM L75
; last. No CHARM/FAKE_TEARS (not a manipulator).
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
; Curious gentle ancestor (Psychic/Fairy). Egg moves = TACKLE/TELEPORT/
; CONFUSION/DISABLE (shared with Mewtwo). Learns up to L75. TRANSFORM
; L66 — the ancestor unlocks its ultimate mimicry late (shared with
; Ditto). PLAY_ROUGH (rough play IS Mew), no MOONBLAST — lunar blasts
; are Clefairy-line/Starmie identity, and HYPER_BEAM already covers the
; nuke slot. All 4 fun moves natural. HYPER_BEAM L75 last.
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
	db 66, TRANSFORM
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
