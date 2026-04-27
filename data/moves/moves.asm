MACRO move
	db \1 ; animation (interchangeable with move id)
	db \2 ; effect
	db \3 ; power
	db \4 ; type
	db \5 percent ; accuracy
	db \6 ; pp
	assert \6 <= 40, "PP must be 40 or less"
ENDM

Moves: ; Current total = 220
; Alphabetical by TYPE → Ascending POWER → Status moves last within type → Signatures at bottom for power moves
	table_width MOVE_LENGTH, Moves

	; === BUG TYPE (8 moves) ===
	move CONSTRICT,      SPEED_DOWN1_EFFECT,               20, BUG,          100, 30
	move BUG_BITE,       FLINCH_SIDE_EFFECT2,              40, BUG,          100, 30 ; new move.
	move LEECH_LIFE,     DRAIN_HP_EFFECT,                  70, BUG,          100, 20
	move BUG_BUZZ,       SPECIAL_DOWN_SIDE_EFFECT,         80, BUG,          100, 20 ; new move.
	move MEGAHORN,       FLINCH_SIDE_EFFECT2,              90, BUG,          100, 15 ; new move.
	move GUILLOTINE,     DEFENSE_DOWN1_EFFECT,            115, BUG,           80, 10
	move VICEGRIP,       ATTACK_TWICE_EFFECT,              35, BUG,          100, 25 ; signature.
	move TWINEEDLE,      TWINEEDLE_EFFECT,                 40, BUG,          100, 20 ; signature.


	; === DARK TYPE (10 moves) === ; new type
	move FAINT_ATTACK,   SWIFT_EFFECT,                     45, DARK,         100, 30 ; new move.
	move RAGE,           RAGE_EFFECT,                      60, DARK,          95, 25
	move NIGHT_SLASH,    NO_ADDITIONAL_EFFECT,             70, DARK,         100, 20 ; new move. high-crit.
	move BRUTAL_SWING,   DEFENSE_DOWN1_EFFECT,             85, DARK,          90, 20 ; new move.
	move DARK_PULSE,     FLINCH_SIDE_EFFECT2,              90, DARK,         100, 15 ; new move.
	move GORE_ATTACK,    PARALYZE_SIDE_EFFECT2,            95, DARK,          95, 15 ; new move. high-crit.
	move PAY_DAY,        PAY_DAY_EFFECT,                   60, DARK,         100, 25 ; signature. high-crit.
	move DREAM_EATER,    DREAM_EATER_EFFECT,              110, DARK,         100, 20 ; signature.
	move GLARE,          PARALYZE_EFFECT,                   0, DARK,          90, 20 ; signature.
	move DEEP_SLEEP,     SLEEP_EFFECT,                      0, DARK,          85, 20 ; signature.


	; === DRAGON TYPE (6 moves) ===
	move DRAGON_RAGE,    SPECIAL_DAMAGE_EFFECT,             1, DRAGON,       100, 20 ; set damage from 40 to 50.
	move DRAGON_CLAW,    NO_ADDITIONAL_EFFECT,             60, DRAGON,       100, 25 ; new move. high-crit.
	move DRAGON_BREATH,  PARALYZE_SIDE_EFFECT2,            75, DRAGON,       100, 20 ; new move.
	move DRAGON_SLAM,    RECOIL_EFFECT,                    95, DRAGON,        95, 15 ; new move.
	move OUTRAGE,        THRASH_PETAL_DANCE_EFFECT,       100, DRAGON,       100, 10 ; new move.
	move HYPER_BEAM,     HYPER_BEAM_EFFECT,               125, DRAGON,        75,  5


	; === ELECTRIC TYPE (7 moves) ===
	move NUZZLE,         PARALYZE_SIDE_EFFECT2,            35, ELECTRIC,     100, 30 ; new move.
	move THUNDERSHOCK,   PARALYZE_SIDE_EFFECT1,            55, ELECTRIC,     100, 25
	move DISCHARGE,      SWIFT_EFFECT,                     75, ELECTRIC,     100, 20 ; new move.
	move THUNDERBOLT,    PARALYZE_SIDE_EFFECT1,            95, ELECTRIC,     100, 15
	move THUNDER,        PARALYZE_SIDE_EFFECT2,           115, ELECTRIC,      85, 10
	move THUNDER_WAVE,   PARALYZE_EFFECT,                   0, ELECTRIC,      95, 20
	move VOLT_TACKLE,    NO_ADDITIONAL_EFFECT,             55, ELECTRIC,     100, 20 ; new move. signature. priority move. high-crit.


	; === FAIRY TYPE (8 moves) === ; new type
	move DOUBLESLAP,     TWO_TO_FIVE_ATTACKS_EFFECT,       16, FAIRY,         90, 20
	move FAIRY_WIND,     ATTACK_DOWN_SIDE_EFFECT,          35, FAIRY,        100, 30 ; new move.
	move DRAINING_KISS,  DRAIN_HP_EFFECT,                  50, FAIRY,        100, 20 ; new move.
	move DAZZLE_GLEAM,   FLINCH_SIDE_EFFECT2,              65, FAIRY,        100, 20 ; new move.
	move PLAY_ROUGH,     ATTACK_DOWN1_EFFECT,              80, FAIRY,        100, 20 ; new move.
	move MOONBLAST,      CHARGE_EFFECT,                   180, FAIRY,        100, 10 ; new move. signature. (use solarbeam's animation)
	move LOVELY_KISS,    SLEEP_EFFECT,                      0, FAIRY,         80, 15 ; signature.
	move SING,           SLEEP_EFFECT,                      0, FAIRY,         80, 15 ; signature.


	; === FIGHTING TYPE (15 moves) ===
	move SEISMIC_TOSS,   SPECIAL_DAMAGE_EFFECT,             1, FIGHTING,     100, 20
	move COMET_PUNCH,    TWO_TO_FIVE_ATTACKS_EFFECT,       18, FIGHTING,      90, 20
	move LOW_KICK,       FLINCH_SIDE_EFFECT2,              35, FIGHTING,      90, 35
	move BIND,           PARALYZE_SIDE_EFFECT2,            45, FIGHTING,      90, 30
	move MACH_PUNCH,     NO_ADDITIONAL_EFFECT,             45, FIGHTING,     100, 20 ; priority move.
	move KARATE_CHOP,    NO_ADDITIONAL_EFFECT,             50, FIGHTING,     100, 30 ; high-crit.
	move DOUBLE_KICK,    ATTACK_TWICE_EFFECT,              30, FIGHTING,     100, 25
	move STRENGTH,       ATTACK_UP1_EFFECT,                65, FIGHTING,     100, 20
	move TAKE_DOWN,      DEFENSE_DOWN1_EFFECT,             80, FIGHTING,      90, 20
	move LEEK_STRIKE,    FLINCH_SIDE_EFFECT2,              65, FIGHTING,     100, 25 ; new move. signature. high-crit.
	move DIZZY_PUNCH,    CONFUSION_SIDE_EFFECT2,           80, FIGHTING,     100, 20 ; signature. new effect.
	move ROLLING_KICK,   FLINCH_SIDE_EFFECT2,              80, FIGHTING,     100, 20 ; signature.
	move SUBMISSION,     ATTACK_DOWN1_EFFECT,              95, FIGHTING,     100, 15 ; signature.
	move SKY_UPPERCUT,   NO_ADDITIONAL_EFFECT,            100, FIGHTING,      95, 10 ; new move. signature. high-crit.
	move HI_JUMP_KICK,   JUMP_KICK_EFFECT,                110, FIGHTING,      90, 10 ; signature. high-crit.


	; === FIRE TYPE (7 moves) ===
	move EMBER,          BURN_SIDE_EFFECT1,                35, FIRE,         100, 30
	move FLAME_CHARGE,   SPEED_UP1_EFFECT,                 55, FIRE,         100, 20 ; new move. almost-signature.
	move FLAME_BURST,    SWIFT_EFFECT,                     75, FIRE,         100, 20 ; new move.
	move FLAMETHROWER,   BURN_SIDE_EFFECT1,                95, FIRE,         100, 15
	move FIRE_BLAST,     BURN_SIDE_EFFECT2,               115, FIRE,          85, 10
	move IGNITE,         BURN_EFFECT,                       0, FIRE,          90, 20
	move EXPLOSION,      EXPLODE_EFFECT,                  200, FIRE,         100,  5 ; signature. high-crit.


	; === FLYING TYPE (8 moves) ===
	move PECK,           NO_ADDITIONAL_EFFECT,             35, FLYING,       100, 35
	move GUST,           SPEED_DOWN_SIDE_EFFECT,           45, FLYING,       100, 30
	move WING_ATTACK,    NO_ADDITIONAL_EFFECT,             60, FLYING,       100, 25
	move AERIAL_ACE,     SWIFT_EFFECT,                     70, FLYING,       100, 20 ; new move.
	move FLY,            FLY_EFFECT,                       80, FLYING,       100, 20
	move HURRICANE,      CONFUSION_SIDE_EFFECT2,           90, FLYING,       100, 15 ; new move. new effect.
	move SKY_ATTACK,     CHARGE_EFFECT,                   180, FLYING,       100, 10
	move DRILL_PECK,     FLINCH_SIDE_EFFECT2,              90, FLYING,       100, 15 ; signature.


	; === FUNGUS TYPE (3 moves) === ; new type
	move SPORE_DAZE,     CONFUSION_SIDE_EFFECT2,           60, FUNGUS,       100, 20 ; new move. new effect.
	move PARASITE,       SUPER_FANG_EFFECT,                 1, FUNGUS,        90, 15 ; new move. signature.
	move SPORE,          SLEEP_EFFECT,                      0, FUNGUS,        90, 25 ; signature.


	; === GAS TYPE (3 moves) === ; new type
	move SMOG,           ACCURACY_DOWN1_EFFECT,            40, GAS,           90, 30
	move POISON_GAS,     POISON_EFFECT,                     0, GAS,           85, 25
	move HAZE,           ACCURACY_DOWN1_EFFECT,            80, GAS,           90, 20 ; signature.


	; === GHOST TYPE (9 moves) ===
	move NIGHT_SHADE,    SPECIAL_DAMAGE_EFFECT,             0, GHOST,        100, 20
	move LICK,           PARALYZE_SIDE_EFFECT2,            20, GHOST,        100, 30
	move ASTONISH,       FLINCH_SIDE_EFFECT2,              40, GHOST,        100, 30 ; new move.
	move SHADOW_SNEAK,   NO_ADDITIONAL_EFFECT,             45, GHOST,        100, 20 ; new move. priority move.
	move SHADOW_PUNCH,   SWIFT_EFFECT,                     55, GHOST,        100, 25 ; new move.
	move SPIRIT_DRAIN,   DRAIN_HP_EFFECT,                  70, GHOST,        100, 20 ; new move.
	move SHADOW_BALL,    PARALYZE_SIDE_EFFECT2,            90, GHOST,        100, 15 ; new move.
	move CONFUSE_RAY,    CONFUSION_EFFECT,                  0, GHOST,         90, 20
	move WILL_O_WISP,    BURN_EFFECT,                       0, GHOST,         85, 20 ; almost-signature.


	; === GRASS TYPE (11 moves) ===
	move ABSORB,         DRAIN_HP_EFFECT,                  25, GRASS,        100, 25
	move VINE_WHIP,      NO_ADDITIONAL_EFFECT,             35, GRASS,        100, 35
	move MEGA_DRAIN,     DRAIN_HP_EFFECT,                  50, GRASS,        100, 20
	move RAZOR_LEAF,     NO_ADDITIONAL_EFFECT,             60, GRASS,        100, 20 ; high-crit.
	move GIGA_DRAIN,     DRAIN_HP_EFFECT,                  75, GRASS,        100, 15 ; new move.
	move PETAL_DANCE,    THRASH_PETAL_DANCE_EFFECT,        90, GRASS,        100, 10
	move SOLARBEAM,      CHARGE_EFFECT,                   180, GRASS,        100, 10
	move LEECH_SEED,     LEECH_SEED_EFFECT,                 0, GRASS,         90, 20
	move POISONPOWDER,   POISON_EFFECT,                     0, POISON,        85, 25
	move STUN_SPORE,     PARALYZE_EFFECT,                   0, GRASS,         80, 20
	move SLEEP_POWDER,   SLEEP_EFFECT,                      0, GRASS,         75, 15


	; === GROUND TYPE (8 moves) ===
	move GROUND_STOMP,   SPEED_DOWN_SIDE_EFFECT,           35, GROUND,       100, 35 ; new move.
	move MUD_SHOT,       FLINCH_SIDE_EFFECT1,              50, GROUND,       100, 30 ; new move.
	move BULLDOZE,       SPEED_DOWN1_EFFECT,               65, GROUND,       100, 25 ; new move.
	move MUD_BOMB,       ACCURACY_DOWN1_EFFECT,            80, GROUND,       100, 20 ; new move.
	move EARTHQUAKE,     SPEED_DOWN_SIDE_EFFECT,           95, GROUND,       100, 15
	move FISSURE,        SPEED_DOWN1_EFFECT,              115, GROUND,        85, 10
	move BONE_CLUB,      FLINCH_SIDE_EFFECT1,              75, GROUND,       100, 20 ; signature.
	move DIG,            CHARGE_EFFECT,                    80, GROUND,       100, 20 ; signature.


	; === ICE TYPE (6 moves) ===
	move POWDER_SNOW,    NO_ADDITIONAL_EFFECT,             35, ICE,          100, 35 ; new move.
	move ICY_WIND,       SPEED_DOWN_SIDE_EFFECT,           50, ICE,          100, 30 ; new move.
	move AURORA_BEAM,    ATTACK_DOWN_SIDE_EFFECT,          65, ICE,          100, 25
	move FROST_BREATH,   SPEED_DOWN1_EFFECT,               80, ICE,          100, 20 ; new move.
	move ICE_BEAM,       FREEZE_SIDE_EFFECT1,              95, ICE,          100, 15 ; new effect.
	move BLIZZARD,       FREEZE_SIDE_EFFECT2,             115, ICE,           85, 10 ; new effect.


	; === MAGMA TYPE (2 moves) === ; new type
	move MAGMA_PUNCH,    BURN_SIDE_EFFECT1,                60, MAGMA,        100, 25 ; new move. signature.
	move LAVA_PLUME,     BURN_SIDE_EFFECT2,                90, MAGMA,        100, 15 ; new move. signature.


	; === NORMAL TYPE (19 moves) ===
	move WRAP,           TRAPPING_EFFECT,                  16, NORMAL,        80, 25
	move FURY_ATTACK,    TWO_TO_FIVE_ATTACKS_EFFECT,       18, NORMAL,        90, 20
	move SCRATCH,        NO_ADDITIONAL_EFFECT,             35, NORMAL,       100, 30
	move TACKLE,         NO_ADDITIONAL_EFFECT,             40, NORMAL,       100, 30
	move BITE,           FLINCH_SIDE_EFFECT1,              45, NORMAL,       100, 30
	move QUICK_ATTACK,   NO_ADDITIONAL_EFFECT,             50, NORMAL,       100, 20 ; priority move.
	move HEADBUTT,       CONFUSION_SIDE_EFFECT1,           55, NORMAL,       100, 25 ; new effect.
	move HORN_ATTACK,    FLINCH_SIDE_EFFECT1,              60, NORMAL,       100, 25
	move SLASH,          NO_ADDITIONAL_EFFECT,             65, NORMAL,       100, 20 ; high-crit.
	move BODY_SLAM,      PARALYZE_SIDE_EFFECT1,            70, NORMAL,        95, 20
	move CRUNCH,         DEFENSE_DOWN_SIDE_EFFECT,         75, NORMAL,       100, 20 ; new move.
	move HORN_CHARGE,    FLINCH_SIDE_EFFECT1,              90, NORMAL,        95, 15 ; new move. high-crit.
	move THRASH,         THRASH_PETAL_DANCE_EFFECT,        95, NORMAL,       100, 10
	move HEAVY_SLAM,     PARALYZE_SIDE_EFFECT2,           100, NORMAL,        90, 10
	move DOUBLE_EDGE,    RECOIL_EFFECT,                   120, NORMAL,        80, 10 ; high-crit.
	move EXTREMESPEED,   NO_ADDITIONAL_EFFECT,             75, NORMAL,       100, 15 ; new move. almost-signature. priority move.
	move SUPERSONIC,     CONFUSION_EFFECT,                  0, NORMAL,        80, 25
	move SUPER_FANG,     SUPER_FANG_EFFECT,                 1, NORMAL,        90, 15 ; signature.
	move HYPER_FANG,     DEFENSE_DOWN1_EFFECT,             75, NORMAL,       100, 20 ; signature. high-crit.


	; === POISON TYPE (9 moves) === (exception to the regular moves order)
	move POISON_STING,   POISON_SIDE_EFFECT1,              35, POISON,       100, 30
	move POISON_FANG,    POISON_SIDE_EFFECT2,              60, POISON,        95, 25 ; new move.
	move TOXIC_FANGS,    POISON_SIDE_EFFECT3,              85, POISON,        90, 20 ; new move. POISON_SIDE_EFFECT3 = new 50% chance.
	move ACID,           DEFENSE_DOWN1_EFFECT,             40, POISON,       100, 25
	move SLUDGE,         POISON_SIDE_EFFECT2,              65, POISON,       100, 20
	move SLUDGE_WAVE,    SPEED_DOWN1_EFFECT,               90, POISON,       100, 15 ; new move.
	move GUNK_SHOT,      POISON_EFFECT,                   115, POISON,        80, 10 ; new move.
	move NEUROTOXIN,     PARALYZE_EFFECT,                   0, POISON,        90, 20 ; new move.
	move TOXIC,          POISON_EFFECT,                     0, POISON,        90, 20


	; === PSYCHIC_TYPE (8 moves) ===
	move PSYWAVE,        FLINCH_SIDE_EFFECT2,              30, PSYCHIC_TYPE, 100, 30
	move CONFUSION,      CONFUSION_SIDE_EFFECT1,           45, PSYCHIC_TYPE, 100, 30
	move EXTRASENSORY,   SWIFT_EFFECT,                     60, PSYCHIC_TYPE, 100, 25 ; new move.
	move PSYBEAM,        SPECIAL_DOWN_SIDE_EFFECT,         75, PSYCHIC_TYPE, 100, 20
	move PSYCHIC_M,      CONFUSION_SIDE_EFFECT3,           95, PSYCHIC_TYPE, 100, 15 ; new effect.
	move MIND_BREAK,     PARALYZE_EFFECT,                 125, PSYCHIC_TYPE,  90, 10 ; signature.
	move DISABLE,        DISABLE_EFFECT,                    0, PSYCHIC_TYPE,  75, 25
	move HYPNOSIS,       SLEEP_EFFECT,                      0, PSYCHIC_TYPE,  75, 15


	; === ROCK TYPE (9 moves) ===
	move ROCK_THROW,     FLINCH_SIDE_EFFECT2,              45, ROCK,          90, 30
	move ROCK_PUNCH,     NO_ADDITIONAL_EFFECT,             60, ROCK,         100, 25 ; new move.
	move ROCK_TOMB,      SPEED_DOWN1_EFFECT,               75, ROCK,          95, 20 ; new move.
	move HEAD_SMASH,     RECOIL_EFFECT,                    85, ROCK,          95, 20 ; new move.
	move ROCK_SLIDE,     PARALYZE_SIDE_EFFECT2,            95, ROCK,         100, 15
	move CLAMP,          TRAPPING_EFFECT,                  20, ROCK,          80, 25 ; signature.
	move BONEMERANG,     ATTACK_TWICE_EFFECT,              45, ROCK,          90, 20 ; signature.
	move CRABHAMMER,     FLINCH_SIDE_EFFECT2,              90, ROCK,          90, 15 ; signature.
	move HORN_DRILL,     DEFENSE_DOWN_SIDE_EFFECT,        100, ROCK,          90, 15 ; signature. high-crit.


	; === STEEL TYPE (6 moves) === ; new type
	move CUT,            NO_ADDITIONAL_EFFECT,             55, STEEL,        100, 25 ; high-crit.
	move IRON_TAIL,      DEFENSE_DOWN_SIDE_EFFECT,         65, STEEL,         90, 25 ; new move.
	move IRON_HEAD,      FLINCH_SIDE_EFFECT2,              75, STEEL,        100, 20 ; new move.
	move SONICBOOM,      SPECIAL_DAMAGE_EFFECT,             1, STEEL,        100, 20 ; signature. set damage from 20 to 25.
	move BULLET_PUNCH,   NO_ADDITIONAL_EFFECT,             45, STEEL,        100, 20 ; new move. signature. priority move.
	move MAGNET_BOMB,    SWIFT_EFFECT,                    100, STEEL,        100, 10 ; new move. signature.


	; === WATER TYPE (7 moves) ===
	move WATER_GUN,      NO_ADDITIONAL_EFFECT,             35, WATER,        100, 35
	move AQUA_JET,       NO_ADDITIONAL_EFFECT,             45, WATER,        100, 20 ; new move. almost-signature. priority move.
	move BUBBLEBEAM,     SPEED_DOWN_SIDE_EFFECT,           50, WATER,        100, 30
	move WATER_PULSE,    CONFUSION_SIDE_EFFECT1,           65, WATER,        100, 25 ; new move. new effect.
	move WATERFALL,      FLINCH_SIDE_EFFECT1,              80, WATER,        100, 20
	move SURF,           SPEED_DOWN_SIDE_EFFECT,           95, WATER,        100, 15
	move HYDRO_PUMP,     SPEED_DOWN1_EFFECT,              115, WATER,         85, 10


	; === BIRD TYPE (51 moves) === ; "BIRD" is not related to the Flying type, nor birds. It's just a placeholder name for "Typeless" type.
	move TRI_ATTACK,     TRI_STATUS_SIDE_EFFECT,           90, BIRD,         100, 15 ; signature. new effect - ~33% chance random {paralyze/burn/freeze}.

	move SWORDS_DANCE,   ATTACK_UP2_EFFECT,                 0, BIRD,         100, 20
	move BULK_UP,        ATTACK_DEFENSE_UP1_EFFECT,         0, BIRD,         100, 25 ; new move. new effect.
	move COIL,           ATTACK_DEFENSE_UP1_EFFECT,         0, BIRD,         100, 25 ; new move. new effect.
	move FIERCE_ROAR,    ATTACK_UP1_DOWN1_EFFECT,           0, BIRD,         100, 25 ; new move. new effect.
	move HONE_CLAWS,     ATTACK_ACCURACY_UP1_EFFECT,        0, BIRD,         100, 25 ; new move. new effect.

	move DEFENSE_CURL,   DEFENSE_UP1_EFFECT,                0, BIRD,         100, 35
	move HARDEN,         DEFENSE_UP1_EFFECT,                0, BIRD,         100, 35
	move WITHDRAW,       DEFENSE_UP1_EFFECT,                0, BIRD,         100, 35

	move GROWTH,         SPECIAL_UP1_HEAL_EFFECT,           0, BIRD,         100, 20 ; new effect.
	move CALM_MIND,      SPECIAL_UP1_EFFECT,                0, BIRD,         100, 30 ; new move.
	move NASTY_PLOT,     SPECIAL_UP1_EFFECT,                0, BIRD,         100, 30 ; new move.
	move AMNESIA,        SPECIAL_UP1_EFFECT,                0, BIRD,         100, 30

	move QUIVER_DANCE,   SPECIAL_SPEED_UP1_EFFECT,          0, BIRD,         100, 20 ; new move. new effect.

	move TAILWIND,       SPEED_UP1_EFFECT,                  0, BIRD,         100, 35 ; new move.

	move AGILITY,        SPEED_EVASION_UP1_EFFECT,          0, BIRD,         100, 15 ; new effect.

	move DOUBLE_TEAM,    EVASION_UP1_EFFECT,                0, BIRD,         100, 20
	move TELEPORT,       EVASION_UP1_EFFECT,                0, BIRD,         100, 20

	move CHARM,          ATTACK_DOWN2_EFFECT,               0, BIRD,          90, 20 ; new move.
	move INTIMIDATE,     ATTACK_DOWN2_EFFECT,               0, BIRD,          90, 20 ; new move.
	move GROWL,          ATTACK_DOWN1_EFFECT,               0, BIRD,         100, 35
	move LEER,           ATTACK_DOWN1_EFFECT,               0, BIRD,         100, 35

	move CORRODE,        DEFENSE_DOWN2_EFFECT,              0, BIRD,          90, 20 ; new move. signature.
	move TAUNT,          DEFENSE_DOWN1_EFFECT,              0, BIRD,         100, 35 ; new move.
	move TICKLE,         DEFENSE_DOWN1_EFFECT,              0, BIRD,         100, 35 ; new move.
	move TAIL_WHIP,      DEFENSE_DOWN1_EFFECT,              0, BIRD,         100, 35

	move FAKE_TEARS,     SPECIAL_DOWN2_EFFECT,              0, BIRD,          90, 15 ; new move.
	move METAL_SOUND,    SPECIAL_DOWN2_EFFECT,              0, BIRD,          90, 15 ; new move. signature.
	move SCREECH,        SPECIAL_DOWN1_EFFECT,              0, BIRD,         100, 30

	move EERIE_IMPULSE,  SPECIAL_SPEED_DOWN1_EFFECT,        0, BIRD,          90, 20 ; new move. new effect.

	move SCARY_FACE,     SPEED_DOWN2_EFFECT,                0, BIRD,          90, 20 ; new move.
	move HINDER,         SPEED_DOWN1_EFFECT,                0, BIRD,         100, 30 ; new move.
	move STRING_SHOT,    SPEED_DOWN1_EFFECT,                0, BIRD,         100, 30

	move PSYCHIC_BIND,   SPEED_EVASION_DOWN1_EFFECT,        0, BIRD,          90, 20 ; new move. new effect.

	move FLASH,          ACCURACY_EVASION_DOWN1_EFFECT,     0, BIRD,         100, 15
	move SAND_ATTACK,    ACCURACY_DOWN1_EFFECT,             0, BIRD,         100, 20
	move SMOKESCREEN,    ACCURACY_DOWN1_EFFECT,             0, BIRD,         100, 20

	move RECOVER,        HEAL_EFFECT,                       0, BIRD,         100, 20
	move REST,           HEAL_EFFECT,                       0, BIRD,         100, 20
	move SOFTBOILED,     HEAL_EFFECT,                       0, BIRD,         100, 20 ; signature.

	move LIGHT_SCREEN,   LIGHT_SCREEN_EFFECT,               0, BIRD,         100, 30
	move REFLECT,        REFLECT_EFFECT,                    0, BIRD,         100, 30

	move BIDE,           BIDE_EFFECT,                       0, BIRD,         100, 20
	move FOCUS_ENERGY,   FOCUS_ENERGY_EFFECT,               0, BIRD,         100, 30
	move MIMIC,          MIMIC_EFFECT,                      0, BIRD,         100, 15
	move MIRROR_MOVE,    MIRROR_MOVE_EFFECT,                0, BIRD,         100, 20
	move SUBSTITUTE,     SUBSTITUTE_EFFECT,                 0, BIRD,         100, 15
	move TRANSFORM,      TRANSFORM_EFFECT,                  0, BIRD,         100, 40 ; signature. priority move.
	move SPLASH,         SPLASH_EFFECT,                     0, BIRD,         100, 40 ; signature.
	move METRONOME,      METRONOME_EFFECT,                  0, BIRD,         100, 20

	move STRUGGLE,       RECOIL_EFFECT,                    50, BIRD,         100, 10 ; has to be last in list.


	assert_table_length NUM_ATTACKS
