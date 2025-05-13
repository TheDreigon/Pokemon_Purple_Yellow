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
; Characteristics of each move.
	table_width MOVE_LENGTH, Moves
	move POUND,        NO_ADDITIONAL_EFFECT,        35, NORMAL,       100, 35
	move KARATE_CHOP,  NO_ADDITIONAL_EFFECT,        50, FIGHTING,     100, 30
	move DOUBLESLAP,   TWO_TO_FIVE_ATTACKS_EFFECT,  16, NORMAL,        95, 25
	move COMET_PUNCH,  TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,        95, 25
	move MEGA_PUNCH,   NO_ADDITIONAL_EFFECT,        80, NORMAL,        90, 20
	move PAY_DAY,      PAY_DAY_EFFECT,              50, NORMAL,       100, 30
	move FIRE_PUNCH,   BURN_SIDE_EFFECT1,           60, FIRE,         100, 20
	move ICE_PUNCH,    FREEZE_SIDE_EFFECT,          60, ICE,          100, 20
	move THUNDERPUNCH, PARALYZE_SIDE_EFFECT1,       60, ELECTRIC,     100, 20
	move SCRATCH,      NO_ADDITIONAL_EFFECT,        45, NORMAL,       100, 35
	move VICEGRIP,     FLINCH_SIDE_EFFECT2,         60, BUG,          100, 25
	move GUILLOTINE,   OHKO_EFFECT,                  1, BUG,           30,  5
	move RAZOR_WIND,   FLINCH_SIDE_EFFECT2,         55, FLYING,       100, 25
	move SWORDS_DANCE, ATTACK_UP2_EFFECT,            0, BIRD,         100, 20
	move CUT,          DEFENSE_DOWN_SIDE_EFFECT,    55, BUG,          100, 25
	move GUST,         NO_ADDITIONAL_EFFECT,        40, FLYING,       100, 30
	move WING_ATTACK,  NO_ADDITIONAL_EFFECT,        65, FLYING,       100, 20
	move WHIRLWIND,    SPEED_DOWN1_EFFECT,           0, BIRD,         100, 40
	move FLY,          FLY_EFFECT,                  70, FLYING,       100, 20
	move BIND,         PARALYZE_SIDE_EFFECT2,       40, ROCK,         100, 30
	move DRAGON_SLAM,  PARALYZE_SIDE_EFFECT2,       90, DRAGON,        90, 20
	move VINE_WHIP,    NO_ADDITIONAL_EFFECT,        40, GRASS,        100, 30
	move GROUND_STOMP, SPEED_DOWN_SIDE_EFFECT,      50, GROUND,       100, 30
	move DOUBLE_KICK,  ATTACK_TWICE_EFFECT,         30, FIGHTING,     100, 30
	move MEGA_KICK,    NO_ADDITIONAL_EFFECT,       110, NORMAL,        80, 20
	move JUMP_KICK,    JUMP_KICK_EFFECT,            90, FIGHTING,      95, 25
	move ROLLING_KICK, FLINCH_SIDE_EFFECT2,         70, FIGHTING,     100, 20
	move SAND_ATTACK,  ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 20
	move HEADBUTT,     CONFUSION_SIDE_EFFECT,       65, NORMAL,       100, 20
	move HORN_ATTACK,  NO_ADDITIONAL_EFFECT,        60, NORMAL,        95, 20
	move FURY_ATTACK,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, DRAGON,        95, 25
	move HORN_DRILL,   OHKO_EFFECT,                  1, ROCK,          30,  5
	move TACKLE,       NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 35
	move BODY_SLAM,    PARALYZE_SIDE_EFFECT2,       80, NORMAL,       100, 20
	move WRAP,         TRAPPING_EFFECT,             16, NORMAL,        85, 20
	move TAKE_DOWN,    DEFENSE_DOWN1_EFFECT,        75, FIGHTING,      95, 20
	move THRASH,       THRASH_PETAL_DANCE_EFFECT,   90, DRAGON,       100, 15
	move DOUBLE_EDGE,  RECOIL_EFFECT,              120, NORMAL,       100, 10
	move TAIL_WHIP,    DEFENSE_DOWN1_EFFECT,         0, BIRD,         100, 40
	move POISON_STING, POISON_SIDE_EFFECT1,         30, POISON,       100, 35
	move TWINEEDLE,    TWINEEDLE_EFFECT,            40, BUG,          100, 20
	move PIN_MISSILE,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, BUG,           95, 25
	move LEER,         SPEED_DOWN1_EFFECT,           0, BIRD,         100, 40
	move BITE,         FLINCH_SIDE_EFFECT1,         60, NORMAL,       100, 25
	move GROWL,        ATTACK_DOWN1_EFFECT,          0, BIRD,         100, 40
	move ROAR,         ATTACK_DOWN2_EFFECT,          0, BIRD,          90, 20
	move SING,         SLEEP_EFFECT,                 0, BIRD,          70, 20
	move SUPERSONIC,   CONFUSION_EFFECT,             0, BIRD,          75, 15
	move SONICBOOM,    SPECIAL_DAMAGE_EFFECT,        1, NORMAL,       100, 20
	move DISABLE,      DISABLE_EFFECT,               0, BIRD,          75, 20
	move ACID,         DEFENSE_DOWN1_EFFECT,        65, POISON,       100, 25
	move EMBER,        BURN_SIDE_EFFECT1,           40, FIRE,         100, 30
	move FLAMETHROWER, BURN_SIDE_EFFECT1,           90, FIRE,         100, 15
	move ICY_MIST,     SPEED_DOWN_SIDE_EFFECT,      40, ICE,          100, 30 ; NEW MOVE - replaced Mist.
	move WATER_GUN,    NO_ADDITIONAL_EFFECT,        40, WATER,        100, 30
	move HYDRO_PUMP,   SPEED_DOWN_SIDE_EFFECT,     110, WATER,         90, 10
	move SURF,         SPEED_DOWN_SIDE_EFFECT,      90, WATER,        100, 15
	move ICE_BEAM,     FREEZE_SIDE_EFFECT,          90, ICE,          100, 15
	move BLIZZARD,     FREEZE_SIDE_EFFECT,         110, ICE,           90, 10
	move PSYBEAM,      SPECIAL_DOWN_SIDE_EFFECT,    65, PSYCHIC_TYPE, 100, 20
	move BUBBLEBEAM,   SPEED_DOWN_SIDE_EFFECT,      60, WATER,        100, 20
	move AURORA_BEAM,  SPECIAL_DOWN_SIDE_EFFECT,    65, ICE,          100, 20
	move HYPER_BEAM,   HYPER_BEAM_EFFECT,          140, DRAGON,        90,  5
	move PECK,         NO_ADDITIONAL_EFFECT,        35, FLYING,       100, 35
	move DRILL_PECK,   NO_ADDITIONAL_EFFECT,        90, FLYING,       100, 20
	move SUBMISSION,   ATTACK_DOWN1_EFFECT,         85, FIGHTING,      95, 20
	move LOW_KICK,     FLINCH_SIDE_EFFECT2,         50, FIGHTING,      95, 25
	move COUNTER,      NO_ADDITIONAL_EFFECT,         1, FIGHTING,     100, 20
	move SEISMIC_TOSS, SPECIAL_DAMAGE_EFFECT,        1, FIGHTING,     100, 20
	move STRENGTH,     ATTACK_UP1_EFFECT,           70, FIGHTING,     100, 20
	move ABSORB,       DRAIN_HP_EFFECT,             25, GRASS,        100, 30
	move MEGA_DRAIN,   DRAIN_HP_EFFECT,             65, GRASS,        100, 20  ; TODO: create Giga Drain (absorb, mega, giga: 25, 50, 75)
	move LEECH_SEED,   LEECH_SEED_EFFECT,            0, GRASS,         90, 10
	move GROWTH,       SPECIAL_UP1_EFFECT,           0, BIRD,         100, 35
	move RAZOR_LEAF,   NO_ADDITIONAL_EFFECT,        55, GRASS,        100, 25
	move SOLARBEAM,    CHARGE_EFFECT,              180, GRASS,        100, 10
	move POISONPOWDER, POISON_EFFECT,                0, POISON,        90, 20
	move STUN_SPORE,   PARALYZE_EFFECT,              0, GRASS,         80, 20
	move SLEEP_POWDER, SLEEP_EFFECT,                 0, GRASS,         70, 20
	move PETAL_DANCE,  THRASH_PETAL_DANCE_EFFECT,   90, GRASS,        100, 15
	move STRING_SHOT,  SPEED_DOWN1_EFFECT,           0, BUG,           95, 35
	move DRAGON_RAGE,  SPECIAL_DAMAGE_EFFECT,        1, DRAGON,       100, 20
	move FIRE_SPIN,    TRAPPING_EFFECT,             18, FIRE,          85, 20
	move THUNDERSHOCK, PARALYZE_SIDE_EFFECT1,       40, ELECTRIC,     100, 30
	move THUNDERBOLT,  PARALYZE_SIDE_EFFECT1,       90, ELECTRIC,     100, 15
	move THUNDER_WAVE, PARALYZE_EFFECT,              0, ELECTRIC,      90, 25
	move THUNDER,      PARALYZE_SIDE_EFFECT1,      110, ELECTRIC,      90, 10
	move ROCK_THROW,   FLINCH_SIDE_EFFECT2,         60, ROCK,          90, 25
	move EARTHQUAKE,   SPEED_DOWN_SIDE_EFFECT,     100, GROUND,       100, 10
	move FISSURE,      OHKO_EFFECT,                  1, GROUND,        30,  5
	move DIG,          CHARGE_EFFECT,               70, GROUND,       100, 20
	move TOXIC,        POISON_EFFECT,                0, POISON,       100, 10
	move CONFUSION,    CONFUSION_SIDE_EFFECT,       40, PSYCHIC_TYPE, 100, 30
	move PSYCHIC_M,    SPECIAL_DOWN1_EFFECT,        90, PSYCHIC_TYPE, 100, 15
	move HYPNOSIS,     SLEEP_EFFECT,                 0, PSYCHIC_TYPE,  70, 20
	move MEDITATE,     SPECIAL_UP1_EFFECT,           0, BIRD,   	  100, 35
	move AGILITY,      SPEED_UP2_EFFECT,             0, BIRD,         100, 20
	move QUICK_ATTACK, NO_ADDITIONAL_EFFECT,        60, NORMAL,       100, 20
	move RAGE,         RAGE_EFFECT,                 60, DRAGON,        90, 20
	move TELEPORT,     EVASION_UP1_EFFECT,           0, PSYCHIC_TYPE, 100, 15
	move NIGHT_SHADE,  SPECIAL_DAMAGE_EFFECT,        1, GHOST,        100, 20
	move MIMIC,        MIMIC_EFFECT,                 0, BIRD,         100, 10
	move SCREECH,      DEFENSE_DOWN2_EFFECT,         0, BIRD,          90, 20
	move DOUBLE_TEAM,  EVASION_UP1_EFFECT,           0, BIRD,         100, 15
	move RECOVER,      HEAL_EFFECT,                  0, BIRD,         100, 15
	move HARDEN,       DEFENSE_UP1_EFFECT,           0, BIRD,         100, 40
	move MINIMIZE,     EVASION_UP1_EFFECT,           0, BIRD,         100, 15
	move SMOKESCREEN,  ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 20
	move CONFUSE_RAY,  CONFUSION_EFFECT,             0, GHOST,         85, 15
	move WITHDRAW,     DEFENSE_UP1_EFFECT,           0, BIRD,         100, 40
	move DEFENSE_CURL, DEFENSE_UP1_EFFECT,           0, BIRD,         100, 40
	move BARRIER,      DEFENSE_UP2_EFFECT,           0, BIRD,	      100, 20
	move LIGHT_SCREEN, LIGHT_SCREEN_EFFECT,          0, BIRD,         100, 30
	move HAZE,         ACCURACY_DOWN1_EFFECT,       40, POISON,       100, 20
	move REFLECT,      REFLECT_EFFECT,               0, BIRD,         100, 30
	move FOCUS_ENERGY, FOCUS_ENERGY_EFFECT,          0, BIRD,         100, 30
	move BIDE,         BIDE_EFFECT,                  0, BIRD,         100, 15
	move METRONOME,    METRONOME_EFFECT,             0, BIRD,         100, 20
	move MIRROR_MOVE,  MIRROR_MOVE_EFFECT,           0, BIRD,         100, 20
	move SELFDESTRUCT, EXPLODE_EFFECT,             200, NORMAL,       100,  5
	move EGG_BOMB,     BURN_SIDE_EFFECT2,           90, FIRE,         100, 10
	move LICK,         PARALYZE_SIDE_EFFECT2,       30, GHOST,        100, 35
	move SMOG,         POISON_SIDE_EFFECT2,         40, POISON,        80, 30
	move SLUDGE,       POISON_SIDE_EFFECT2,         90, POISON,       100, 15
	move BONE_CLUB,    FLINCH_SIDE_EFFECT1,         75, GROUND,       100, 20
	move FIRE_BLAST,   BURN_SIDE_EFFECT2,          110, FIRE,          90, 10
	move WATERFALL,    FLINCH_SIDE_EFFECT1,         75, WATER,        100, 15
	move CLAMP,        TRAPPING_EFFECT,             27, WATER,         85, 20  ; (27 * 5 = 135 = 90 * 1.5)
	move SWIFT,        SWIFT_EFFECT,                60, NORMAL,       100, 20
	move SKULL_BASH,   RECOIL_EFFECT,               80, ROCK,         100, 10
	move SPIKE_CANNON, TWO_TO_FIVE_ATTACKS_EFFECT,  20, ROCK,          95, 25
	move CONSTRICT,    SPEED_DOWN_SIDE_EFFECT,      35, BUG,          100, 35
	move AMNESIA,      SPECIAL_UP1_EFFECT,           0, BIRD,         100, 20
	move KINESIS,      ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 20
	move SOFTBOILED,   HEAL_EFFECT,                  0, BIRD,         100, 15
	move HI_JUMP_KICK, JUMP_KICK_EFFECT,           110, FIGHTING,      90, 20
	move GLARE,        PARALYZE_EFFECT,              0, BIRD,          90, 25
	move DREAM_EATER,  DREAM_EATER_EFFECT,         100, PSYCHIC_TYPE, 100, 15
	move POISON_GAS,   POISON_EFFECT,                0, POISON,        90, 30
	move BARRAGE,      TWO_TO_FIVE_ATTACKS_EFFECT,  16, GRASS,         95, 25
	move LEECH_LIFE,   DRAIN_HP_EFFECT,             65, BUG,          100, 20
	move LOVELY_KISS,  SLEEP_EFFECT,                 0, BIRD,          70, 20
	move SKY_ATTACK,   FLY_EFFECT,                 100, FLYING,       100, 10
	move TRANSFORM,    TRANSFORM_EFFECT,             0, BIRD,         100, 10
	move BUBBLE,       NO_ADDITIONAL_EFFECT,        20, WATER,        100, 35
	move DIZZY_PUNCH,  CONFUSION_SIDE_EFFECT,       70, FIGHTING,     100, 20
	move SPORE,        SLEEP_EFFECT,                 0, GRASS,        100, 20
	move FLASH,        EVASION_DOWN2_EFFECT,         0, BIRD,          80, 20
	move PSYWAVE,      CONFUSION_EFFECT,            25, PSYCHIC_TYPE, 100, 30 ; replaced 'SPECIAL_DAMAGE_EFFECT' with 'CONFUSION_SIDE_EFFECT'.
	move SPLASH,       SPLASH_EFFECT,                0, BIRD,         100, 40
	move ACID_ARMOR,   DEFENSE_UP2_EFFECT,           0, BIRD,         100, 20
	move CRABHAMMER,   FLINCH_SIDE_EFFECT2,        110, WATER,         90, 20 ; replaced 'NO_ADDITIONAL_EFFECT' with 'FLINCH_SIDE_EFFECT2'. deixou de ser high-crit. kingler.
	move EXPLOSION,    EXPLODE_EFFECT,             250, NORMAL,       100,  5
	move FURY_SWIPES,  TWO_TO_FIVE_ATTACKS_EFFECT,  17, NORMAL,        95, 25
	move BONEMERANG,   ATTACK_TWICE_EFFECT,         50, GROUND,        90, 20
	move REST,         HEAL_EFFECT,                  0, BIRD,         100, 15
	move ROCK_SLIDE,   PARALYZE_SIDE_EFFECT2,       90, ROCK,         100, 15
	move HYPER_FANG,   DEFENSE_DOWN_SIDE_EFFECT,    80, NORMAL,       100, 20
	move SHARPEN,      ATTACK_UP1_EFFECT,            0, BIRD,         100, 30
	move CONVERSION,   CONVERSION_EFFECT,            0, BIRD,         100, 30
	move TRI_ATTACK,   PARALYZE_SIDE_EFFECT2,       90, NORMAL,       100, 15
	move SUPER_FANG,   SUPER_FANG_EFFECT,            1, NORMAL,        90, 10
	move SLASH,        NO_ADDITIONAL_EFFECT,        65, NORMAL,       100, 25
	move SUBSTITUTE,   SUBSTITUTE_EFFECT,            0, BIRD,         100, 10
	move SHADOW_BALL,  CONFUSION_SIDE_EFFECT,       80, GHOST,        100, 20 ; NEW MOVE
	move STRUGGLE,     RECOIL_EFFECT,               50, BIRD,         100, 10
	assert_table_length NUM_ATTACKS

; New moves so far: Icy Mist (from Mist), Shadow Ball, Ground Stomp (from Stomp), Haze (now does dmg and -1Acc),
