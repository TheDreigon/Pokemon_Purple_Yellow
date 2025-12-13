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

	; === BUG TYPE (8 moves) ===
	move CONSTRICT,    SPEED_DOWN1_EFFECT,          20, BUG,          100, 30
	move BUG_BITE,     FLINCH_SIDE_EFFECT1,         35, BUG,          100, 35 ; new move.
	move LEECH_LIFE,   DRAIN_HP_EFFECT,             60, BUG,          100, 20 ; high-crit.
	move VICEGRIP,     ATTACK_TWICE_EFFECT,         30, BUG,          100, 30
	move BUG_BUZZ,     SPECIAL_DOWN_SIDE_EFFECT,    80, BUG,          100, 20 ; new move.
	move MEGAHORN,     NO_ADDITIONAL_EFFECT,        90, BUG,           95, 15 ; new move.
	move TWINEEDLE,    TWINEEDLE_EFFECT,            40, BUG,          100, 20 ; signature.
	move GUILLOTINE,   DEFENSE_DOWN1_EFFECT,       115, BUG,           85, 10 ; signature.
	; move PIN_MISSILE,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, BUG,          100, 20 ; remove.


	; === DARK TYPE (10 moves) === ; new type
	move FAINT_ATTACK, SWIFT_EFFECT,                45, DARK,         100, 25 ; new move.
	move RAGE,         RAGE_EFFECT,                 60, DARK,          95, 20
	move NIGHT_SLASH,  NO_ADDITIONAL_EFFECT,        70, DARK,         100, 20 ; new move. high-crit.
	move BRUTAL_SWING, DEFENSE_DOWN_SIDE_EFFECT,    80, DARK,         100, 20 ; new move.
	move DARK_PULSE,   FLINCH_SIDE_EFFECT2,         85, DARK,         100, 15 ; new move.
	move GORE_ATTACK,  NO_ADDITIONAL_EFFECT,        95, DARK,          95, 15 ; new move. high-crit.
	move THRASH,       THRASH_PETAL_DANCE_EFFECT,  100, DARK,          95, 10
	move DEEP_SLEEP,   SLEEP_EFFECT,                 0, DARK,          85, 20 ; signature.
	move PAY_DAY,      PAY_DAY_EFFECT,              65, DARK,         100, 25 ; signature. high-crit.
	move DREAM_EATER,  DREAM_EATER_EFFECT,         110, DARK,         100, 20 ; signature.


	; === DRAGON TYPE (6 moves) ===
	move DRAGON_RAGE,  SPECIAL_DAMAGE_EFFECT,        1, DRAGON,       100, 20 ; set damage from 40 to 50.
	move DRAGON_CLAW,  NO_ADDITIONAL_EFFECT,        60, DRAGON,       100, 25 ; new move.
	move DRAGON_BREATH,PARALYZE_SIDE_EFFECT2,       75, DRAGON,       100, 20 ; new move.
	move DRAGON_SLAM,  RECOIL_EFFECT,               90, DRAGON,       100, 15 ; new move.
	move OUTRAGE,      THRASH_PETAL_DANCE_EFFECT,  105, DRAGON,        90, 10 ; new move.
	move HYPER_BEAM,   HYPER_BEAM_EFFECT,          125, DRAGON,        75,  5 ; high-crit.
	; move SLAM,         FLINCH_SIDE_EFFECT1,         80, DRAGON,       100, 20 ; remove.


	; === ELECTRIC TYPE (8 moves) ===
	move NUZZLE,       PARALYZE_SIDE_EFFECT2,       35, ELECTRIC,     100, 30 ; new move.
	move THUNDERSHOCK, PARALYZE_SIDE_EFFECT1,       55, ELECTRIC,     100, 25
	move DISCHARGE,    SWIFT_EFFECT,                75, ELECTRIC,     100, 20 ; new move.
	move THUNDERBOLT,  PARALYZE_SIDE_EFFECT1,       95, ELECTRIC,     100, 15
	move THUNDER,      PARALYZE_SIDE_EFFECT2,      115, ELECTRIC,      85, 10
	move THUNDER_WAVE, PARALYZE_EFFECT,              0, ELECTRIC,     100, 20
	move TRI_ATTACK,   BURN_SIDE_EFFECT2,           85, ELECTRIC,     100, 20 ; signature.
	move VOLT_ATTACK,  NO_ADDITIONAL_EFFECT,        75, ELECTRIC,     100, 20 ; new move. signature. make it go first like Quick Attack. high-crit.
	; move THUNDERPUNCH, PARALYZE_SIDE_EFFECT2,       70, ELECTRIC,     100, 25 ; remove.


    ; === FAIRY TYPE (6 moves) === ; new type
	move DOUBLESLAP,   TWO_TO_FIVE_ATTACKS_EFFECT,  16, FAIRY,         90, 20
	move FAIRY_WIND,   ATTACK_DOWN_SIDE_EFFECT,     35, FAIRY,        100, 30 ; new move.
	move DRAINING_KISS,DRAIN_HP_EFFECT,             50, FAIRY,        100, 25 ; new move.
	move DAZE_GLEAM,   FLINCH_SIDE_EFFECT2,         65, FAIRY,        100, 20 ; new move.
	move PLAY_ROUGH,   ATTACK_DOWN1_EFFECT,         75, FAIRY,        100, 20 ; new move.
	move MOONBLAST,    SPECIAL_DOWN_SIDE_EFFECT,    90, FAIRY,        100, 15 ; new move.


	; === FIGHTING TYPE (13 moves) ===
	move SEISMIC_TOSS, SPECIAL_DAMAGE_EFFECT,        1, FIGHTING,     100, 20
	move LOW_KICK,     FLINCH_SIDE_EFFECT2,         35, FIGHTING,     100, 30
	move BIND,         PARALYZE_SIDE_EFFECT2,       45, FIGHTING,      90, 30
	move KARATE_CHOP,  NO_ADDITIONAL_EFFECT,        55, FIGHTING,     100, 30
	move DOUBLE_KICK,  ATTACK_TWICE_EFFECT,         30, FIGHTING,     100, 25
	move STRENGTH,     NO_ADDITIONAL_EFFECT,        80, FIGHTING,     100, 20
	move TAKE_DOWN,    DEFENSE_DOWN1_EFFECT,        85, FIGHTING,      90, 15
	move JUMP_KICK,    JUMP_KICK_EFFECT,            90, FIGHTING,      90, 15
	move DIZZY_PUNCH,  CONFUSION_SIDE_EFFECT,       65, FIGHTING,     100, 25 ; signature.
	move ROLLING_KICK, FLINCH_SIDE_EFFECT2,         65, FIGHTING,     100, 25 ; signature.
	move LEEK_STRIKE,  FLINCH_SIDE_EFFECT2,         65, FIGHTING,     100, 25 ; new move. signature. high-crit.
	move SUBMISSION,   ATTACK_DOWN1_EFFECT,         95, FIGHTING,     100, 15 ; signature.
	move HI_JUMP_KICK, JUMP_KICK_EFFECT,           120, FIGHTING,      80, 10 ; signature.
	; move COUNTER,      NO_ADDITIONAL_EFFECT,         1, FIGHTING,     100, 20 ; remove.


	; === FIRE TYPE (7 moves) ===
	move EMBER,        BURN_SIDE_EFFECT1,           35, FIRE,         100, 30
	move FLAME_WHEEL,  BURN_SIDE_EFFECT1,           55, FIRE,         100, 25 ; new move.
	move FLAME_BURST,  SWIFT_EFFECT,                75, FIRE,         100, 20 ; new move.
	move FLAMETHROWER, BURN_SIDE_EFFECT1,           95, FIRE,         100, 15
	move FIRE_BLAST,   BURN_SIDE_EFFECT2,          115, FIRE,          85, 10
	move FLAME_CHARGE, SPEED_UP1_EFFECT,            60, FIRE,         100, 25 ; new move. signature.
	move EXPLOSION,    EXPLODE_EFFECT,             200, FIRE,         100,  5 ; signature. high-crit.
	; move FIRE_SPIN,    TRAPPING_EFFECT,             16, FIRE,          85, 15 ; remove.
	; move FIRE_PUNCH,   BURN_SIDE_EFFECT2,           70, FIRE,         100, 25 ; remove.


	; === FLYING TYPE (8 moves) ===
	move PECK,         NO_ADDITIONAL_EFFECT,        35, FLYING,       100, 35
	move GUST,         SPEED_DOWN_SIDE_EFFECT,      50, FLYING,       100, 30
	move WING_ATTACK,  NO_ADDITIONAL_EFFECT,        60, FLYING,       100, 25
	move AERIAL_ACE,   SWIFT_EFFECT,                70, FLYING,       100, 20 ; new move.
	move FLY,          FLY_EFFECT,                  80, FLYING,       100, 20
	move HURRICANE,    CONFUSION_SIDE_EFFECT,       95, FLYING,       100, 15 ; new move.
	move SKY_ATTACK,   FLY_EFFECT,                 110, FLYING,       100, 10 ; becomes like FLY_EFFECT.
	move DRILL_PECK,   NO_ADDITIONAL_EFFECT,        90, FLYING,       100, 20 ; signature.


    ; === GAS TYPE (3 moves) === ; new type
	move SMOG,         ACCURACY_DOWN1_EFFECT,       40, GAS,           90, 30
	move POISON_GAS,   POISON_EFFECT,                0, GAS,           85, 25
	move HAZE,         ACCURACY_DOWN1_EFFECT,       80, GAS,           90, 20 ; signature.


	; === GHOST TYPE (8 moves) ===
	move NIGHT_SHADE,  SPECIAL_DAMAGE_EFFECT,        0, GHOST,        100, 20
	move LICK,         PARALYZE_SIDE_EFFECT2,       25, GHOST,        100, 30
	move ASTONISH,     FLINCH_SIDE_EFFECT2,         40, GHOST,        100, 30 ; new move.
	move SHADOW_PUNCH, SWIFT_EFFECT,                55, GHOST,        100, 25 ; new move.
	move SPIRIT_DRAIN, DRAIN_HP_EFFECT,             70, GHOST,        100, 15 ; new move.
	move SHADOW_BALL,  PARALYZE_SIDE_EFFECT2,       90, GHOST,        100, 15 ; new move.
	move SHADOW_SNEAK, NO_ADDITIONAL_EFFECT,        45, GHOST,        100, 25 ; new move. signature. make it go first like Quick Attack.
	move CONFUSE_RAY,  CONFUSION_EFFECT,             0, GHOST,         85, 25


	; === GRASS TYPE (12 moves) ===
	move ABSORB,       DRAIN_HP_EFFECT,             25, GRASS,        100, 25
	move VINE_WHIP,    NO_ADDITIONAL_EFFECT,        35, GRASS,        100, 35
	move MEGA_DRAIN,   DRAIN_HP_EFFECT,             50, GRASS,        100, 20
	move RAZOR_LEAF,   NO_ADDITIONAL_EFFECT,        55, GRASS,        100, 25 ; high-crit.
	move GIGA_DRAIN,   DRAIN_HP_EFFECT,             75, GRASS,        100, 15 ; new move.
	move PETAL_DANCE,  THRASH_PETAL_DANCE_EFFECT,   90, GRASS,        100, 15
	move SOLARBEAM,    CHARGE_EFFECT,              180, GRASS,        100, 10
	move LEECH_SEED,   LEECH_SEED_EFFECT,            0, GRASS,         90, 15
	move POISONPOWDER, POISON_EFFECT,                0, POISON,        85, 25
	move STUN_SPORE,   PARALYZE_EFFECT,              0, GRASS,         80, 20
	move SLEEP_POWDER, SLEEP_EFFECT,                 0, GRASS,         75, 15
	move SPORE,        SLEEP_EFFECT,                 0, GRASS,         95, 15 ; signature.
	; move EGG_BOMB,     NO_ADDITIONAL_EFFECT,       100, GRASS,        100, 15 ; remove.


	; === GROUND TYPE (8 moves) ===
	move GROUND_STOMP, NO_ADDITIONAL_EFFECT,        35, GROUND,       100, 35 ; new move.
	move MUD_SHOT,     SPEED_DOWN_SIDE_EFFECT,      50, GROUND,       100, 30 ; new move.
	move BULLDOZE,     SPEED_DOWN1_EFFECT,          65, GROUND,       100, 25 ; new move.
	move MUD_BOMB,     ACCURACY_DOWN1_EFFECT,       80, GROUND,       100, 20 ; new move.
	move EARTHQUAKE,   SPEED_DOWN_SIDE_EFFECT,      95, GROUND,       100, 15
	move FISSURE,      SPEED_DOWN1_EFFECT,         115, GROUND,        85, 10
	move BONE_CLUB,    FLINCH_SIDE_EFFECT1,         75, GROUND,       100, 20 ; signature.
	move DIG,          CHARGE_EFFECT,               80, GROUND,       100, 20 ; becomes signature.


	; === ICE TYPE (6 moves) ===
	move POWDER_SNOW,  NO_ADDITIONAL_EFFECT,        35, ICE,          100, 35 ; new move.
	move ICY_WIND,     SPEED_DOWN_SIDE_EFFECT,      50, ICE,          100, 30 ; new move.
	move AURORA_BEAM,  ATTACK_DOWN1_EFFECT,         65, ICE,          100, 25
	move FROST_BREATH, SPEED_DOWN1_EFFECT,          80, ICE,          100, 20 ; new move.
	move ICE_BEAM,     FREEZE_SIDE_EFFECT,          95, ICE,          100, 15
	move BLIZZARD,     FREEZE_SIDE_EFFECT,         115, ICE,           85, 10
	; move ICE_PUNCH,    FREEZE_SIDE_EFFECT,          70, ICE,          100, 25 ; remove.
	; move MIST,         MIST_EFFECT,                  0, ICE,          100, 30 ; remove.


    ; === MAGMA TYPE (2 moves) === ; new type
	move MAGMA_PUNCH,  BURN_SIDE_EFFECT1,           70, MAGMA,        100, 20 ; new move. signature.
	move LAVA_PLUME,   BURN_SIDE_EFFECT2,           90, MAGMA,        100, 15 ; new move. signature.


	; === NORMAL TYPE (21 moves) ===
	move WRAP,         TRAPPING_EFFECT,             16, NORMAL,        85, 20
	move FURY_SWIPES,  TWO_TO_FIVE_ATTACKS_EFFECT,  17, NORMAL,        90, 20
	move FURY_ATTACK,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, NORMAL,        90, 20
	move COMET_PUNCH,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, NORMAL,        90, 20
	move POUND,        NO_ADDITIONAL_EFFECT,        30, NORMAL,       100, 35
	move SCRATCH,      NO_ADDITIONAL_EFFECT,        35, NORMAL,       100, 35
	move TACKLE,       NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 30
	move QUICK_ATTACK, NO_ADDITIONAL_EFFECT,        45, NORMAL,       100, 25
	move BITE,         FLINCH_SIDE_EFFECT1,         50, NORMAL,       100, 30
	move HEADBUTT,     CONFUSION_SIDE_EFFECT,       55, NORMAL,       100, 25
	move HORN_ATTACK,  NO_ADDITIONAL_EFFECT,        60, NORMAL,        95, 25
	move SLASH,        NO_ADDITIONAL_EFFECT,        65, NORMAL,        95, 20 ; high-crit.
	move MEGA_PUNCH,   FLINCH_SIDE_EFFECT1,         75, NORMAL,        90, 20
	move CRUNCH,       DEFENSE_DOWN_SIDE_EFFECT,    75, NORMAL,       100, 20 ; new move.
	move BODY_SLAM,    NO_ADDITIONAL_EFFECT,        80, NORMAL,        95, 20
	move HORN_CHARGE,  NO_ADDITIONAL_EFFECT,        85, NORMAL,        95, 15 ; new move. high-crit.
	move HEAVY_SLAM,   PARALYZE_SIDE_EFFECT2,      100, NORMAL,        90, 10
	move DOUBLE_EDGE,  RECOIL_EFFECT,              120, NORMAL,        90, 10
	move EXTREMESPEED, NO_ADDITIONAL_EFFECT,        75, NORMAL,       100, 20 ; new move. signature. make it go first like Quick Attack.
	move SUPER_FANG,   SUPER_FANG_EFFECT,            1, NORMAL,        90, 10 ; signature.
	move HYPER_FANG,   DEFENSE_DOWN1_EFFECT,        80, NORMAL,       100, 20 ; signature. high-crit.
	; move SPIKE_CANNON, TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,        90, 20 ; remove.
	; move BARRAGE,      TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,        90, 20 ; remove.
	; move SWIFT,        SWIFT_EFFECT,                60, NORMAL,       100, 20 ; remove.
	; move STOMP,        FLINCH_SIDE_EFFECT2,         65, NORMAL,       100, 20 ; remove.
	; move RAZOR_WIND,   HYPER_BEAM_EFFECT,           80, NORMAL,       100, 10 ; remove.
	; move SKULL_BASH,   HYPER_BEAM_EFFECT,          100, NORMAL,       100, 15 ; remove.
	; move MEGA_KICK,    NO_ADDITIONAL_EFFECT,       115, NORMAL,        85, 10 ; remove.
	; move SELFDESTRUCT, EXPLODE_EFFECT,             200, NORMAL,       100,  5 ; remove.


	; === POISON TYPE (8 moves) ===
	move POISON_STING, POISON_SIDE_EFFECT1,         35, POISON,       100, 35
	move ACID,         DEFENSE_DOWN_SIDE_EFFECT,    45, POISON,       100, 30
	move POISON_FANG,  POISON_SIDE_EFFECT2,         65, POISON,       100, 25 ; new move.
	move SLUDGE,       DEFENSE_DOWN_SIDE_EFFECT,    75, POISON,       100, 20
	move SLUDGE_BOMB,  POISON_SIDE_EFFECT2,         90, POISON,       100, 15 ; new move.
	move GUNK_SHOT,    POISON_SIDE_EFFECT2,        115, POISON,        85, 10 ; new move.
	move TOXIC,        POISON_EFFECT,                0, POISON,        80, 20
	move NEUROTOXIN,   PARALYZE_EFFECT,              0, POISON,        85, 25 ; new move.


	; === PSYCHIC_TYPE (7 moves) ===
	move PSYWAVE,      CONFUSION_SIDE_EFFECT,       30, PSYCHIC_TYPE, 100, 30
	move CONFUSION,    CONFUSION_SIDE_EFFECT,       45, PSYCHIC_TYPE, 100, 30
	move EXTRASENSORY, SWIFT_EFFECT,                60, PSYCHIC_TYPE, 100, 25 ; new move.
	move PSYBEAM,      SPECIAL_DOWN_SIDE_EFFECT,    75, PSYCHIC_TYPE, 100, 20
	move PSYCHIC_M,    SPECIAL_DOWN1_EFFECT,        90, PSYCHIC_TYPE, 100, 15
	move MIND_BREAK,   FLINCH_SIDE_EFFECT2,        120, PSYCHIC_TYPE,  90, 10 ; signature.
	move HYPNOSIS,     SLEEP_EFFECT,                 0, PSYCHIC_TYPE,  75, 15


	; === ROCK TYPE (10 moves) ===
	move ROCK_BLAST,   TWO_TO_FIVE_ATTACKS_EFFECT,  18, ROCK,          90, 35 ; new move.
	move ROCK_PUNCH,   NO_ADDITIONAL_EFFECT,        50, ROCK,         100, 30 ; new move.
	move ROCK_THROW,   FLINCH_SIDE_EFFECT2,         65, ROCK,          90, 25
	move ROCK_TOMB,    SPEED_DOWN1_EFFECT,          80, ROCK,          95, 20 ; new move.
	move ROCK_SLIDE,   PARALYZE_SIDE_EFFECT2,       95, ROCK,         100, 15
	move STONE_EDGE,   NO_ADDITIONAL_EFFECT,       110, ROCK,          85, 10 ; new move. high-crit.
	move CLAMP,        TRAPPING_EFFECT,             20, ROCK,          80, 20 ; signature.
	move BONEMERANG,   ATTACK_TWICE_EFFECT,         45, ROCK,          90, 20 ; signature.
	move CRABHAMMER,   FLINCH_SIDE_EFFECT2,         90, ROCK,          90, 15 ; signature.
	move HORN_DRILL,   DEFENSE_DOWN1_EFFECT,       100, ROCK,          90, 15 ; signature.


    ; === STEEL TYPE (6 moves) === ; new type
	move CUT,          NO_ADDITIONAL_EFFECT,        55, STEEL,        100, 25 ; high-crit.
	move IRON_TAIL,    DEFENSE_DOWN_SIDE_EFFECT,    65, STEEL,        100, 20 ; new move.
	move IRON_HEAD,    FLINCH_SIDE_EFFECT2,         75, STEEL,        100, 20 ; new move.
	move MAGNET_BOMB,  SWIFT_EFFECT,               100, STEEL,        100, 10 ; new move.
	move SONICBOOM,    SPECIAL_DAMAGE_EFFECT,        1, STEEL,        100, 20 ; signature. set damage from 20 to 25.
	move BULLET_PUNCH, NO_ADDITIONAL_EFFECT,        45, STEEL,        100, 25 ; new move. signature. make it go first like Quick Attack.


	; === WATER TYPE (7 moves) ===
	move WATER_GUN,    NO_ADDITIONAL_EFFECT,        35, WATER,        100, 35
	move BUBBLEBEAM,   SPEED_DOWN_SIDE_EFFECT,      50, WATER,        100, 30
	move WATER_PULSE,  CONFUSION_SIDE_EFFECT,       65, WATER,        100, 25 ; new move.
	move WATERFALL,    FLINCH_SIDE_EFFECT1,         80, WATER,        100, 20
	move SURF,         SPEED_DOWN_SIDE_EFFECT,      95, WATER,        100, 15
	move HYDRO_PUMP,   SPEED_DOWN1_EFFECT,         115, WATER,         85, 10
	move AQUA_JET,     NO_ADDITIONAL_EFFECT,        45, WATER,        100, 25 ; new move. signature. make it go first like Quick Attack.
	; move BUBBLE,       SPEED_DOWN_SIDE_EFFECT,      10, WATER,        100, 30 ; remove.


    ; === BIRD TYPE (65 moves) ===
	move SWORDS_DANCE, ATTACK_UP2_EFFECT,            0, BIRD,         100, 25
	move SHARPEN,      ATTACK_UP2_EFFECT,            0, BIRD,         100, 25 ; signature.
	move HOWL,         ATTACK_UP1_EFFECT,            0, BIRD,         100, 35 ; new move.
	move HONE_CLAWS,   ATTACK_UP1_EFFECT,            0, BIRD,         100, 35 ; new move.
	move WORK_UP,      ATTACK_UP1_EFFECT,            0, BIRD,         100, 35 ; new move.

	move ACID_ARMOR,   DEFENSE_UP2_EFFECT,           0, BIRD,         100, 25; signature.
	move HARDEN,       DEFENSE_UP1_EFFECT,           0, BIRD,         100, 35
	move WITHDRAW,     DEFENSE_UP1_EFFECT,           0, BIRD,         100, 35
	move DEFENSE_CURL, DEFENSE_UP1_EFFECT,           0, BIRD,         100, 35
	move AQUA_VEIL,    DEFENSE_UP1_EFFECT,           0, BIRD,         100, 35 ; new move.

	move CALM_MIND,    SPECIAL_UP1_EFFECT,           0, BIRD,         100, 35 ; new move.
	move NASTY_PLOT,   SPECIAL_UP1_EFFECT,           0, BIRD,         100, 35 ; new move.
	move AROMATIC_MIST,SPECIAL_UP1_EFFECT,           0, BIRD,         100, 35 ; new move.
	move GROWTH,       SPECIAL_UP1_EFFECT,           0, BIRD,         100, 35
	move AMNESIA,      SPECIAL_UP1_EFFECT,           0, BIRD,         100, 35

	move AGILITY,      SPEED_UP2_EFFECT,             0, BIRD,         100, 25
	move TAILWIND,     SPEED_UP1_EFFECT,             0, BIRD,         100, 35 ; new move.
	move ROCK_POLISH,  SPEED_UP1_EFFECT,             0, BIRD,         100, 35 ; new move.
	move QUIVER_DANCE, SPEED_UP1_EFFECT,             0, BIRD,         100, 35 ; new move.

	move MINIMIZE,     EVASION_UP1_EFFECT,           0, BIRD,         100, 15
	move DOUBLE_TEAM,  EVASION_UP1_EFFECT,           0, BIRD,         100, 15
	move TELEPORT,     EVASION_UP1_EFFECT,           0, BIRD,         100, 15

	move CHARM,        ATTACK_DOWN2_EFFECT,          0, BIRD,         100, 25 ; new move.
	move INTIMIDATE,   ATTACK_DOWN2_EFFECT,          0, BIRD,         100, 25 ; new move.
	move NOBLE_ROAR,   ATTACK_DOWN2_EFFECT,          0, BIRD,         100, 25 ; new move. signature.
	move LEER,         ATTACK_DOWN1_EFFECT,          0, BIRD,         100, 35
	move GROWL,        ATTACK_DOWN1_EFFECT,          0, BIRD,         100, 35
	move FEATHER_DANCE,ATTACK_DOWN1_EFFECT,          0, BIRD,         100, 35 ; new move.

	move TAUNT,        DEFENSE_DOWN2_EFFECT,         0, BIRD,         100, 25 ; new move.
	move CORRODE,      DEFENSE_DOWN2_EFFECT,         0, BIRD,         100, 25 ; new move. signature.
	move TAIL_WHIP,    DEFENSE_DOWN1_EFFECT,         0, BIRD,         100, 35
	move TICKLE,       DEFENSE_DOWN1_EFFECT,         0, BIRD,         100, 35 ; new move.
	move DECAY,        DEFENSE_DOWN1_EFFECT,         0, BIRD,         100, 35 ; new move.

	move FAKE_TEARS,   SPECIAL_DOWN2_EFFECT,         0, BIRD,         100, 25 ; new move.
	move METAL_SOUND,  SPECIAL_DOWN2_EFFECT,         0, BIRD,         100, 25 ; new move. signature.
	move SCREECH,      SPECIAL_DOWN1_EFFECT,         0, BIRD,         100, 35
	move EERIE_IMPULSE,SPECIAL_DOWN1_EFFECT,         0, BIRD,         100, 35 ; new move.
	move CONFIDE,      SPECIAL_DOWN1_EFFECT,         0, BIRD,         100, 35 ; new move.

	move SCARY_FACE,   SPEED_DOWN2_EFFECT,           0, BIRD,         100, 25 ; new move.
	move PSYCHIC_BIND, SPEED_DOWN2_EFFECT,           0, BIRD,         100, 25 ; new move.
	move SLUDGE_TRAP,  SPEED_DOWN2_EFFECT,           0, BIRD,         100, 25 ; new move. signature.
	move SWEET_SCENT,  SPEED_DOWN1_EFFECT,           0, BIRD,         100, 35 ; new move.
	move HINDER,       SPEED_DOWN1_EFFECT,           0, BIRD,         100, 35 ; new move.
	move STRING_SHOT,  SPEED_DOWN1_EFFECT,           0, BIRD,         100, 35

	move SMOKESCREEN,  ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 15
	move SAND_ATTACK,  ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 15
	move FLASH,        ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 15

	move SING,         SLEEP_EFFECT,                 0, BIRD,          75, 15
	move SUPERSONIC,   CONFUSION_EFFECT,             0, BIRD,          80, 25
	move DISABLE,      DISABLE_EFFECT,               0, BIRD,          75, 25
	move GLARE,        PARALYZE_EFFECT,              0, BIRD,         100, 20 ; signature.
	move LOVELY_KISS,  SLEEP_EFFECT,                 0, BIRD,          75, 15 ; signature.

	move RECOVER,      HEAL_EFFECT,                  0, BIRD,         100, 15
	move MOONLIGHT,    HEAL_EFFECT,                  0, BIRD,         100, 15 ; new move.
	move REST,         HEAL_EFFECT,                  0, BIRD,         100, 25
	move SOFTBOILED,   HEAL_EFFECT,                  0, BIRD,         100, 20 ; signature.

	move LIGHT_SCREEN, LIGHT_SCREEN_EFFECT,          0, BIRD,         100, 30
	move REFLECT,      REFLECT_EFFECT,               0, BIRD,         100, 30

	move MIMIC,        MIMIC_EFFECT,                 0, BIRD,         100, 15
	move MIRROR_MOVE,  MIRROR_MOVE_EFFECT,           0, BIRD,         100, 20
	move FOCUS_ENERGY, FOCUS_ENERGY_EFFECT,          0, BIRD,         100, 30
	move BIDE,         BIDE_EFFECT,                  0, BIRD,         100, 20
	move METRONOME,    METRONOME_EFFECT,             0, BIRD,         100, 20
	move SUBSTITUTE,   SUBSTITUTE_EFFECT,            0, BIRD,         100, 15
	move TRANSFORM,    TRANSFORM_EFFECT,             0, BIRD,         100, 40 ; signature.
	move SPLASH,       SPLASH_EFFECT,                0, BIRD,         100, 40 ; signature.

	; move MEDITATE,     ATTACK_UP1_EFFECT,            0, BIRD,         100, 35 ; remove.
	; move BARRIER,      DEFENSE_UP2_EFFECT,           0, BIRD,         100, 25 ; remove.
	; move KINESIS,      ACCURACY_DOWN1_EFFECT,        0, BIRD,         100, 15 ; remove.
	; move ROAR,         SWITCH_AND_TELEPORT_EFFECT,   0, BIRD,         100, 35 ; remove.
	; move WHIRLWIND,    SWITCH_AND_TELEPORT_EFFECT,   0, BIRD,         100, 35 ; remove.
	; move CONVERSION,   CONVERSION_EFFECT,            0, BIRD,         100, 30 ; remove.

	move STRUGGLE,     RECOIL_EFFECT,               50, BIRD,         100, 10

	assert_table_length NUM_ATTACKS
