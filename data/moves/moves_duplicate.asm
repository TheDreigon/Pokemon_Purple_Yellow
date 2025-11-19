MACRO move
	db \1 ; animation (interchangeable with move id)
	db \2 ; effect
	db \3 ; power
	db \4 ; type
	db \5 percent ; accuracy
	db \6 ; pp
	assert \6 <= 40, "PP must be 40 or less"
ENDM

Moves:
; Reorganized: Alphabetical by TYPE → Ascending POWER → Status moves last within type
	table_width MOVE_LENGTH, Moves

	; === BUG TYPE (5 moves) ===
	move LEECH_LIFE,   DRAIN_HP_EFFECT,             50, BUG,          100, 25
	move CUT,          NO_ADDITIONAL_EFFECT,        55, BUG,          100, 30
	move VICEGRIP,     ATTACK_TWICE_EFFECT,         30, BUG,          100, 30
	move PIN_MISSILE,  TWO_TO_FIVE_ATTACKS_EFFECT,  20, BUG,          100, 30 ; signature.
	move TWINEEDLE,    TWINEEDLE_EFFECT,            45, BUG,          100, 20 ; signature.
	move STRING_SHOT,  SPEED_DOWN1_EFFECT,           0, BUG,           95, 40

	; === DARK TYPE (2 moves) === ; new type
	move RAGE,         RAGE_EFFECT,                 60, DARK,         100, 20

	; === DRAGON TYPE (2 moves) ===
	move DRAGON_RAGE,  SPECIAL_DAMAGE_EFFECT,        1, DRAGON,       100, 20
	move DRAGON_SLAM,  FLINCH_SIDE_EFFECT1,         80, DRAGON,       100, 20 ; renamed from SLAM.

	; === ELECTRIC TYPE (5 moves) ===
	move THUNDERSHOCK, PARALYZE_SIDE_EFFECT1,       40, ELECTRIC,     100, 30
	move THUNDERPUNCH, PARALYZE_SIDE_EFFECT1,       70, ELECTRIC,     100, 15
	move THUNDERBOLT,  PARALYZE_SIDE_EFFECT1,       95, ELECTRIC,     100, 15
	move THUNDER,      PARALYZE_SIDE_EFFECT1,      120, ELECTRIC,      85,  5
	move THUNDER_WAVE, PARALYZE_EFFECT,              0, ELECTRIC,     100, 20

	; === FIGHTING TYPE (9 moves) ===
	move SEISMIC_TOSS, SPECIAL_DAMAGE_EFFECT,        1, FIGHTING,     100, 20
	move KARATE_CHOP,  NO_ADDITIONAL_EFFECT,        50, FIGHTING,     100, 25
	move LOW_KICK,     FLINCH_SIDE_EFFECT2,         50, FIGHTING,     100, 20
	move DOUBLE_KICK,  ATTACK_TWICE_EFFECT,         30, FIGHTING,     100, 30
	move STRENGTH,     NO_ADDITIONAL_EFFECT,        80, NORMAL,       100, 15 ; previously a normal type.
	move SUBMISSION,   RECOIL_EFFECT,               80, FIGHTING,     100, 25
	move ROLLING_KICK, FLINCH_SIDE_EFFECT2,         70, FIGHTING,     100, 15 ; signature.
	move JUMP_KICK,    JUMP_KICK_EFFECT,            90, FIGHTING,      95, 25 ; signature.
	move HI_JUMP_KICK, JUMP_KICK_EFFECT,           120, FIGHTING,      90, 20 ; signature.
	move COUNTER,      NO_ADDITIONAL_EFFECT,         1, FIGHTING,     100, 20 ; remove.

	; === FIRE TYPE (5 moves) ===
	move FIRE_SPIN,    TRAPPING_EFFECT,             15, FIRE,          85, 15
	move EMBER,        BURN_SIDE_EFFECT1,           40, FIRE,         100, 25
	move FIRE_PUNCH,   BURN_SIDE_EFFECT2,           70, FIRE,         100, 15
	move FLAMETHROWER, BURN_SIDE_EFFECT1,           95, FIRE,         100, 15
	move FIRE_BLAST,   BURN_SIDE_EFFECT2,          120, FIRE,          85,  5

	; === FLYING TYPE (7 moves) ===
	move PECK,         NO_ADDITIONAL_EFFECT,        35, FLYING,       100, 35
	move GUST,         NO_ADDITIONAL_EFFECT,        40, FLYING,       100, 35
	move WING_ATTACK,  NO_ADDITIONAL_EFFECT,        60, FLYING,       100, 35
	move FLY,          FLY_EFFECT,                  70, FLYING,       100, 15
	move DRILL_PECK,   NO_ADDITIONAL_EFFECT,        80, FLYING,       100, 20
	move SKY_ATTACK,   NO_ADDITIONAL_EFFECT,       120, FLYING,        85, 10
	move MIRROR_MOVE,  MIRROR_MOVE_EFFECT,           0, FLYING,       100, 20

	; === GHOST TYPE (3 moves) ===
	move LICK,         PARALYZE_SIDE_EFFECT2,       40, GHOST,        100, 30
	move NIGHT_SHADE,  NO_ADDITIONAL_EFFECT,        60, GHOST,        100, 15
	move CONFUSE_RAY,  CONFUSION_EFFECT,             0, GHOST,        100, 10

	; === GRASS TYPE (12 moves) ===
	move ABSORB,       DRAIN_HP_EFFECT,             30, GRASS,        100, 25
	move VINE_WHIP,    NO_ADDITIONAL_EFFECT,        40, GRASS,        100, 25
	move RAZOR_LEAF,   NO_ADDITIONAL_EFFECT,        55, GRASS,         95, 25
	move MEGA_DRAIN,   DRAIN_HP_EFFECT,             65, GRASS,        100, 20
	move PETAL_DANCE,  THRASH_PETAL_DANCE_EFFECT,   90, GRASS,        100, 20
	move SOLARBEAM,    CHARGE_EFFECT,              180, GRASS,        100, 10
	move LEECH_SEED,   LEECH_SEED_EFFECT,            0, GRASS,         90, 10
	move POISONPOWDER, POISON_EFFECT,                0, POISON,        90, 35
	move STUN_SPORE,   PARALYZE_EFFECT,              0, GRASS,         75, 30
	move SLEEP_POWDER, SLEEP_EFFECT,                 0, GRASS,         75, 15
	move EGG_BOMB,     NO_ADDITIONAL_EFFECT,       100, GRASS,        100, 15 ; signature.
	move SPORE,        SLEEP_EFFECT,                 0, GRASS,        100, 15 ; signature.

	; === GROUND TYPE (5 moves) ===
	move FISSURE,      OHKO_EFFECT,                  1, GROUND,        30,  5
	move DIG,          CHARGE_EFFECT,               70, GROUND,       100, 20
	move EARTHQUAKE,   NO_ADDITIONAL_EFFECT,       100, GROUND,       100, 10
	move BONE_CLUB,    FLINCH_SIDE_EFFECT1,         65, GROUND,       100, 20 ; signature.
	move BONEMERANG,   ATTACK_TWICE_EFFECT,         50, GROUND,        90, 20 ; signature.

	; === ICE TYPE (5 moves) ===
	move AURORA_BEAM,  ATTACK_DOWN_SIDE_EFFECT,     65, ICE,          100, 20
	move ICE_PUNCH,    FREEZE_SIDE_EFFECT,          70, ICE,          100, 15
	move ICE_BEAM,     FREEZE_SIDE_EFFECT,          95, ICE,          100, 15
	move BLIZZARD,     FREEZE_SIDE_EFFECT,         120, ICE,           85,  5
	move MIST,         MIST_EFFECT,                  0, ICE,          100, 30

	; === NORMAL TYPE (50 moves) ===
	move GUILLOTINE,   OHKO_EFFECT,                  1, NORMAL,        30,  5
	move HORN_DRILL,   OHKO_EFFECT,                  1, NORMAL,        30,  5
	move SONICBOOM,    SPECIAL_DAMAGE_EFFECT,        1, NORMAL,       100, 20
	move SUPER_FANG,   SUPER_FANG_EFFECT,            1, NORMAL,        90, 10
	move BIND,         TRAPPING_EFFECT,             15, NORMAL,        85, 20
	move WRAP,         TRAPPING_EFFECT,             15, NORMAL,        85, 20
	move FURY_ATTACK,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, NORMAL,       100, 35
	move DOUBLESLAP,   TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,       100, 35
	move SPIKE_CANNON, TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,       100, 15
	move BARRAGE,      TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,       100, 20
	move FURY_SWIPES,  TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,       100, 20
	move COMET_PUNCH,  TWO_TO_FIVE_ATTACKS_EFFECT,  25, NORMAL,       100, 25
	move TACKLE,       NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 35
	move POUND,        NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 35
	move SCRATCH,      NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 35
	move QUICK_ATTACK, NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 30
	move CONSTRICT,    SPEED_DOWN_SIDE_EFFECT,      40, NORMAL,       100, 35
	move PAY_DAY,      PAY_DAY_EFFECT,              60, NORMAL,       100, 20
	move BITE,         FLINCH_SIDE_EFFECT1,         60, NORMAL,       100, 25
	move SWIFT,        SWIFT_EFFECT,                60, NORMAL,       100, 20
	move STOMP,        FLINCH_SIDE_EFFECT2,         65, NORMAL,       100, 20
	move HORN_ATTACK,  NO_ADDITIONAL_EFFECT,        65, NORMAL,       100, 25
	move HEADBUTT,     FLINCH_SIDE_EFFECT2,         70, NORMAL,       100, 15
	move SLASH,        NO_ADDITIONAL_EFFECT,        70, NORMAL,       100, 20
	move DIZZY_PUNCH,  CONFUSION_SIDE_EFFECT,       70, NORMAL,       100, 20
	move MEGA_PUNCH,   NO_ADDITIONAL_EFFECT,        80, NORMAL,        85, 20
	move RAZOR_WIND,   HYPER_BEAM_EFFECT,           80, NORMAL,       100, 10
	move HYPER_FANG,   FLINCH_SIDE_EFFECT1,         80, NORMAL,        90, 15
	move BODY_SLAM,    NO_ADDITIONAL_EFFECT,        80, NORMAL,       100, 20
	move TRI_ATTACK,   BURN_SIDE_EFFECT2,           85, NORMAL,       100, 15
	move THRASH,       THRASH_PETAL_DANCE_EFFECT,   90, NORMAL,       100, 20
	move TAKE_DOWN,    RECOIL_EFFECT,               95, NORMAL,       100, 20
	move SKULL_BASH,   HYPER_BEAM_EFFECT,          100, NORMAL,       100, 15
	move MEGA_KICK,    NO_ADDITIONAL_EFFECT,       120, NORMAL,        85, 10
	move DOUBLE_EDGE,  RECOIL_EFFECT,              120, NORMAL,       100, 15
	move HYPER_BEAM,   HYPER_BEAM_EFFECT,          150, NORMAL,        90,  5
	move SELFDESTRUCT, EXPLODE_EFFECT,             200, NORMAL,       100,  5 ; remove.
	move EXPLOSION,    EXPLODE_EFFECT,             250, NORMAL,       100,  5

	; === POISON TYPE (6 moves) ===
	move POISON_STING, POISON_SIDE_EFFECT1,         35, POISON,       100, 35
	move SMOG,         POISON_SIDE_EFFECT2,         40, POISON,        80, 20
	move ACID,         DEFENSE_DOWN_SIDE_EFFECT,    65, POISON,       100, 30
	move SLUDGE,       POISON_SIDE_EFFECT2,         90, POISON,       100, 20
	move TOXIC,        POISON_EFFECT,                0, POISON,        85, 10
	move POISON_GAS,   POISON_EFFECT,                0, POISON,        85, 40

	; === PSYCHIC_TYPE (7 moves) ===
	move PSYWAVE,      SPECIAL_DAMAGE_EFFECT,        1, PSYCHIC_TYPE,  95, 15
	move CONFUSION,    CONFUSION_SIDE_EFFECT,       50, PSYCHIC_TYPE, 100, 25
	move PSYBEAM,      SPECIAL_DOWN_SIDE_EFFECT     70, PSYCHIC_TYPE, 100, 20
	move PSYCHIC_M,    SPECIAL_DOWN_SIDE_EFFECT,    90, PSYCHIC_TYPE, 100, 15
	move DREAM_EATER,  DREAM_EATER_EFFECT,         100, PSYCHIC_TYPE, 100, 15
	move HYPNOSIS,     SLEEP_EFFECT,                 0, PSYCHIC_TYPE,  75, 15
	move TELEPORT,     EVASION_UP1_EFFECT,           0, PSYCHIC_TYPE, 100, 30

	; === ROCK TYPE (2 moves) ===
	move ROCK_BLAST,   TWO_TO_FIVE_ATTACKS_EFFECT,  18, ROCK,          90, 35 ; new move
	move ROCK_THROW,   NO_ADDITIONAL_EFFECT,        50, ROCK,          95, 25
	move ROCK_SLIDE,   FLINCH_SIDE_EFFECT1,         75, ROCK,          95, 15

	; === WATER TYPE (8 moves) ===
	move BUBBLE,       SPEED_DOWN_SIDE_EFFECT,      10, WATER,        100, 30 ; remove.
	move WATER_GUN,    NO_ADDITIONAL_EFFECT,        35, WATER,        100, 25
	move BUBBLEBEAM,   SPEED_DOWN_SIDE_EFFECT,      55, WATER,        100, 20
	move WATERFALL,    FLINCH_SIDE_EFFECT1,         75, WATER,        100, 15
	move SURF,         NO_ADDITIONAL_EFFECT,        95, WATER,        100, 15
	move HYDRO_PUMP,   NO_ADDITIONAL_EFFECT,       120, WATER,         85, 10
	move CRABHAMMER,   NO_ADDITIONAL_EFFECT,       110, WATER,        100, 10 ; signature.
	move CLAMP,        TRAPPING_EFFECT,             35, WATER,         85, 10 ; signature.

    ; === BIRD TYPE (43 moves) ===
	move SWORDS_DANCE, ATTACK_UP2_EFFECT,            0, BIRD,         100, 30
	move WHIRLWIND,    SPEED_UP1_EFFECT,             0, BIRD,         100, 30
	move SAND_ATTACK,  ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 15
	move TAIL_WHIP,    DEFENSE_DOWN1_EFFECT,         0, BIRD,         100, 30
	move LEER,         DEFENSE_DOWN1_EFFECT,         0, BIRD,         100, 30
	move GROWL,        ATTACK_DOWN1_EFFECT,          0, BIRD,         100, 40
	move ROAR,         SWITCH_AND_TELEPORT_EFFECT,   0, BIRD,         100, 20
	move SING,         SLEEP_EFFECT,                 0, BIRD,          75, 15
	move SUPERSONIC,   CONFUSION_EFFECT,             0, BIRD,          70, 20
	move DISABLE,      DISABLE_EFFECT,               0, BIRD,          75, 20
	move GROWTH,       SPECIAL_UP1_EFFECT,           0, BIRD,         100, 40
	move MEDITATE,     ATTACK_UP1_EFFECT,            0, BIRD,         100, 40
	move AGILITY,      SPEED_UP2_EFFECT,             0, BIRD,         100, 30
	move MIMIC,        MIMIC_EFFECT,                 0, BIRD,         100, 10
	move SCREECH,      DEFENSE_DOWN2_EFFECT,         0, BIRD,          85, 40
	move DOUBLE_TEAM,  EVASION_UP1_EFFECT,           0, BIRD,         100, 15
	move RECOVER,      HEAL_EFFECT,                  0, BIRD,         100, 20
	move HARDEN,       DEFENSE_UP1_EFFECT,           0, BIRD,         100, 30
	move MINIMIZE,     EVASION_UP1_EFFECT,           0, BIRD,         100, 20
	move SMOKESCREEN,  ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 20
	move WITHDRAW,     DEFENSE_UP1_EFFECT,           0, BIRD,         100, 40
	move DEFENSE_CURL, DEFENSE_UP1_EFFECT,           0, BIRD,         100, 40
	move BARRIER,      DEFENSE_UP2_EFFECT,           0, BIRD,         100, 30
	move LIGHT_SCREEN, LIGHT_SCREEN_EFFECT,          0, BIRD,         100, 30
	move HAZE,         HAZE_EFFECT,                  0, BIRD,         100, 30
	move REFLECT,      REFLECT_EFFECT,               0, BIRD,         100, 20
	move FOCUS_ENERGY, FOCUS_ENERGY_EFFECT,          0, BIRD,         100, 30
	move BIDE,         BIDE_EFFECT,                  0, BIRD,         100, 10
	move METRONOME,    METRONOME_EFFECT,             0, BIRD,         100, 20
	move AMNESIA,      SPECIAL_UP2_EFFECT,           0, BIRD,         100, 20
	move KINESIS,      ACCURACY_DOWN1_EFFECT,        0, BIRD,          80, 15
	move SOFTBOILED,   HEAL_EFFECT,                  0, BIRD,         100,  5
	move GLARE,        PARALYZE_EFFECT,              0, BIRD,          90, 30
	move LOVELY_KISS,  SLEEP_EFFECT,                 0, BIRD,          75, 15
	move TRANSFORM,    TRANSFORM_EFFECT,             0, BIRD,         100, 10
	move FLASH,        ACCURACY_DOWN1_EFFECT,        0, BIRD,          70, 20
	move SPLASH,       SPLASH_EFFECT,                0, BIRD,         100, 40
	move ACID_ARMOR,   DEFENSE_UP2_EFFECT,           0, BIRD,         100, 40
	move REST,         HEAL_EFFECT,                  0, BIRD,         100, 10
	move SHARPEN,      ATTACK_UP1_EFFECT,            0, BIRD,         100, 30
	move CONVERSION,   CONVERSION_EFFECT,            0, BIRD,         100, 30
	move ROCK_POLISH,  SPEED_UP1_EFFECT,             0, BIRD,         100, 30
	move SUBSTITUTE,   SUBSTITUTE_EFFECT,            0, BIRD,         100, 10
	move STRUGGLE,     RECOIL_EFFECT,               50, BIRD,         100, 10

	assert_table_length NUM_ATTACKS
