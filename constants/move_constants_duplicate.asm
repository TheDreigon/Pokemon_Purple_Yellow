; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - AttackAnimationPointers (see data/moves/animations.asm)
; - MoveSoundTable (see data/moves/sfx.asm)
	const_def
	const NO_MOVE      ; 00

	; === BUG TYPE (8 moves) ===
	const CONSTRICT    ; 01
	const BUG_BITE     ; 02
	const LEECH_LIFE   ; 03
	const VICEGRIP     ; 04
	const BUG_BUZZ     ; 05
	const MEGAHORN     ; 06
	const TWINEEDLE    ; 07
	const GUILLOTINE   ; 08

	; === DARK TYPE (10 moves) ===
	const FAINT_ATTACK ; 09
	const RAGE         ; 0a
	const NIGHT_SLASH  ; 0b
	const BRUTAL_SWING ; 0c
	const DARK_PULSE   ; 0d
	const GORE_ATTACK  ; 0e
	const THRASH       ; 0f
	const DEEP_SLEEP   ; 10
	const PAY_DAY      ; 11
	const DREAM_EATER  ; 12

	; === DRAGON TYPE (6 moves) ===
	const DRAGON_RAGE  ; 13
	const DRAGON_CLAW  ; 14
	const DRAGON_BREATH ; 15
	const DRAGON_SLAM  ; 16
	const OUTRAGE      ; 17
	const HYPER_BEAM   ; 18

	; === ELECTRIC TYPE (7 moves) ===
	const NUZZLE       ; 19
	const THUNDERSHOCK ; 1a
	const DISCHARGE    ; 1b
	const THUNDERBOLT  ; 1c
	const THUNDER      ; 1d
	const THUNDER_WAVE ; 1e
	const VOLT_ATTACK  ; 1f

	; === FAIRY TYPE (6 moves) ===
	const DOUBLESLAP   ; 20
	const FAIRY_WIND   ; 21
	const DRAINING_KISS ; 22
	const DAZE_GLEAM ; 23
	const PLAY_ROUGH   ; 24
	const MOONBLAST    ; 25

	; === FIGHTING TYPE (13 moves) ===
	const SEISMIC_TOSS ; 26
	const LOW_KICK     ; 27
	const BIND         ; 28
	const KARATE_CHOP  ; 29
	const DOUBLE_KICK  ; 2a
	const STRENGTH     ; 2b
	const TAKE_DOWN    ; 2c
	const JUMP_KICK    ; 2d
	const DIZZY_PUNCH  ; 2e
	const ROLLING_KICK ; 2f
	const LEEK_STRIKE  ; 30
	const SUBMISSION   ; 31
	const HI_JUMP_KICK ; 32

	; === FIRE TYPE (7 moves) ===
	const EMBER        ; 33
	const FLAME_WHEEL  ; 34
	const FLAME_BURST  ; 35
	const FLAMETHROWER ; 36
	const FIRE_BLAST   ; 37
	const FLAME_CHARGE ; 38
	const EXPLOSION    ; 39

	; === FLYING TYPE (8 moves) ===
	const PECK         ; 3a
	const GUST         ; 3b
	const WING_ATTACK  ; 3c
	const AERIAL_ACE   ; 3d
	const FLY          ; 3e
	const HURRICANE    ; 3f
	const SKY_ATTACK   ; 40
	const DRILL_PECK   ; 41

	; === GAS TYPE (3 moves) ===
	const SMOG         ; 42
	const POISON_GAS   ; 43
	const HAZE         ; 44

	; === GHOST TYPE (8 moves) ===
	const NIGHT_SHADE  ; 45
	const LICK         ; 46
	const ASTONISH     ; 47
	const SHADOW_PUNCH ; 48
	const SPIRIT_DRAIN ; 49
	const SHADOW_BALL  ; 4a
	const SHADOW_SNEAK ; 4b
	const CONFUSE_RAY  ; 4c

	; === GRASS TYPE (12 moves) ===
	const ABSORB       ; 4d
	const VINE_WHIP    ; 4e
	const MEGA_DRAIN   ; 4f
	const RAZOR_LEAF   ; 50
	const GIGA_DRAIN   ; 51
	const PETAL_DANCE  ; 52
	const SOLARBEAM    ; 53
	const LEECH_SEED   ; 54
	const POISONPOWDER ; 55
	const STUN_SPORE   ; 56
	const SLEEP_POWDER ; 57
	const SPORE        ; 58

	; === GROUND TYPE (8 moves) ===
	const GROUND_STOMP ; 59
	const MUD_SHOT     ; 5a
	const BULLDOZE     ; 5b
	const MUD_BOMB     ; 5c
	const EARTHQUAKE   ; 5d
	const FISSURE      ; 5e
	const BONE_CLUB    ; 5f
	const DIG          ; 60

	; === ICE TYPE (6 moves) ===
	const POWDER_SNOW  ; 61
	const ICY_WIND     ; 62
	const AURORA_BEAM  ; 63
	const FROST_BREATH ; 64
	const ICE_BEAM     ; 65
	const BLIZZARD     ; 66

	; === MAGMA TYPE (2 moves) ===
	const MAGMA_PUNCH  ; 67
	const LAVA_PLUME   ; 68

	; === NORMAL TYPE (20 moves) ===
	const WRAP         ; 69
	const FURY_ATTACK  ; 6a
	const COMET_PUNCH  ; 6b
	const POUND        ; 6c
	const SCRATCH      ; 6d
	const TACKLE       ; 6e
	const QUICK_ATTACK ; 6f
	const BITE         ; 70
	const HEADBUTT     ; 71
	const HORN_ATTACK  ; 72
	const SLASH        ; 73
	const MEGA_PUNCH   ; 74
	const CRUNCH       ; 75
	const BODY_SLAM    ; 76
	const HORN_CHARGE  ; 77
	const HEAVY_SLAM   ; 78
	const DOUBLE_EDGE  ; 79
	const EXTREMESPEED ; 7a
	const SUPER_FANG   ; 7b
	const HYPER_FANG   ; 7c

	; === POISON TYPE (9 moves) ===
	const POISON_STING ; 7d
	const ACID         ; 7e
	const POISON_FANG  ; 7f
	const SLUDGE       ; 80
	const SLUDGE_BOMB  ; 81
	const GUNK_SHOT    ; 82
	const TOXIC        ; 83
	const NEUROTOXIN   ; 84
	const SLUDGE_WAVE  ; 85

	; === PSYCHIC_TYPE (7 moves) ===
	const PSYWAVE      ; 86
	const CONFUSION    ; 87
	const EXTRASENSORY ; 88
	const PSYBEAM      ; 89
	const PSYCHIC_M    ; 8a
	const MIND_BREAK   ; 8b
	const HYPNOSIS     ; 8c

	; === ROCK TYPE (10 moves) ===
	const ROCK_BLAST   ; 8d
	const ROCK_PUNCH   ; 8e
	const ROCK_THROW   ; 8f
	const ROCK_TOMB    ; 90
	const ROCK_SLIDE   ; 91
	const STONE_EDGE   ; 92
	const CLAMP        ; 93
	const BONEMERANG   ; 94
	const CRABHAMMER   ; 95
	const HORN_DRILL   ; 96

	; === STEEL TYPE (6 moves) ===
	const CUT          ; 97
	const IRON_TAIL    ; 98
	const IRON_HEAD    ; 99
	const MAGNET_BOMB  ; 9a
	const SONICBOOM    ; 9b
	const BULLET_PUNCH ; 9c

	; === WATER TYPE (7 moves) ===
	const WATER_GUN    ; 9d
	const BUBBLEBEAM   ; 9e
	const WATER_PULSE  ; 9f
	const WATERFALL    ; a0
	const SURF         ; a1
	const HYDRO_PUMP   ; a2
	const AQUA_JET     ; a3

	; === BIRD TYPE (65 moves) ===
	const TRI_ATTACK   ; a4
	const SWORDS_DANCE ; a5
	const SHARPEN      ; a6
	const HOWL         ; a7
	const HONE_CLAWS   ; a8
	const WORK_UP      ; a9
	const ACID_ARMOR   ; aa
	const HARDEN       ; ab
	const WITHDRAW     ; ac
	const DEFENSE_CURL ; ad
	const AQUA_VEIL    ; ae
	const CALM_MIND    ; af
	const NASTY_PLOT   ; b0
	const AROMATIC_MIST ; b1
	const GROWTH       ; b2
	const AMNESIA      ; b3
	const AGILITY      ; b4
	const TAILWIND     ; b5
	const ROCK_POLISH  ; b6
	const QUIVER_DANCE ; b7
	const MINIMIZE     ; b8
	const DOUBLE_TEAM  ; b9
	const TELEPORT     ; ba
	const CHARM        ; bb
	const INTIMIDATE   ; bc
	const NOBLE_ROAR   ; bd
	const LEER         ; be
	const GROWL        ; bf
	const FEATHER_DANCE ; c0
	const TAUNT        ; c1
	const CORRODE      ; c2
	const TAIL_WHIP    ; c3
	const TICKLE       ; c4
	const DECAY        ; c5
	const FAKE_TEARS   ; c6
	const METAL_SOUND  ; c7
	const SCREECH      ; c8
	const EERIE_IMPULSE ; c9
	const CONFIDE      ; ca
	const SCARY_FACE   ; cb
	const PSYCHIC_BIND ; cc
	const SLUDGE_TRAP  ; cd
	const SWEET_SCENT  ; ce
	const HINDER       ; cf
	const STRING_SHOT  ; d0
	const SMOKESCREEN  ; d1
	const SAND_ATTACK  ; d2
	const FLASH        ; d3
	const SING         ; d4
	const SUPERSONIC   ; d5
	const DISABLE      ; d6
	const GLARE        ; d7
	const LOVELY_KISS  ; d8
	const RECOVER      ; d9
	const MOONLIGHT    ; da
	const REST         ; db
	const SOFTBOILED   ; dc
	const LIGHT_SCREEN ; dd
	const REFLECT      ; de
	const MIMIC        ; df
	const MIRROR_MOVE  ; e0
	const FOCUS_ENERGY ; e1
	const BIDE         ; e2
	const SUBSTITUTE   ; e3
	const TRANSFORM    ; e4
	const SPLASH       ; e5
	const METRONOME    ; e6
	const STRUGGLE     ; e7

DEF NUM_ATTACKS EQU const_value - 1

	; Moves do double duty as animation identifiers.

	const SHOWPIC_ANIM
	const STATUS_AFFECTED_ANIM
	const ANIM_A8
	const ENEMY_HUD_SHAKE_ANIM
	const TRADE_BALL_DROP_ANIM
	const TRADE_BALL_SHAKE_ANIM
	const TRADE_BALL_TILT_ANIM
	const TRADE_BALL_POOF_ANIM
	const XSTATITEM_ANIM ; use X Attack/Defense/Speed/Special
	const XSTATITEM_DUPLICATE_ANIM
	const SHRINKING_SQUARE_ANIM
	const ANIM_B1
	const ANIM_B2
	const ANIM_B3
	const ANIM_B4
	const ANIM_B5
	const ANIM_B6
	const ANIM_B7
	const ANIM_B8
	const ANIM_B9
	const BURN_PSN_ANIM ; Plays when a monster is burned or poisoned
	const ANIM_BB
	const SLP_PLAYER_ANIM
	const SLP_ANIM ; sleeping monster
	const CONF_PLAYER_ANIM
	const CONF_ANIM ; confused monster
	const SLIDE_DOWN_ANIM
	const TOSS_ANIM ; toss Poké Ball
	const SHAKE_ANIM ; shaking Poké Ball when catching monster
	const POOF_ANIM ; puff of smoke
	const BLOCKBALL_ANIM ; trainer knocks away Poké Ball
	const GREATTOSS_ANIM ; toss Great Ball
	const ULTRATOSS_ANIM ; toss Ultra Ball or Master Ball
	const SHAKE_SCREEN_ANIM
	const HIDEPIC_ANIM ; monster disappears
	const ROCK_ANIM ; throw rock
	const BAIT_ANIM ; throw bait

DEF NUM_ATTACK_ANIMS EQU const_value - 1
