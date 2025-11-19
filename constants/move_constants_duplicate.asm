; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - AttackAnimationPointers (see data/moves/animations.asm)
; - MoveSoundTable (see data/moves/sfx.asm)
	const_def
	const NO_MOVE      ; 00

	; === BUG TYPE ===
	const PIN_MISSILE  ; 2c
	const TWINEEDLE    ; 2d
	const LEECH_LIFE   ; 2e
	const CUT          ; 2f
	const STRING_SHOT  ; 30

	; === DRAGON TYPE ===
	const DRAGON_RAGE  ; 31
	const SLAM         ; 32

	; === ELECTRIC TYPE ===
	const THUNDERSHOCK ; 33
	const THUNDERPUNCH ; 34
	const THUNDERBOLT  ; 35
	const THUNDER      ; 36
	const THUNDER_WAVE ; 37

	; === FIGHTING TYPE ===
	const COUNTER      ; 38
	const SEISMIC_TOSS ; 39
	const DOUBLE_KICK  ; 3a
	const KARATE_CHOP  ; 3b
	const LOW_KICK     ; 3c
	const ROLLING_KICK ; 3d
	const SUBMISSION   ; 3e
	const JUMP_KICK    ; 3f
	const HI_JUMP_KICK ; 40

	; === FIRE TYPE ===
	const FIRE_SPIN    ; 41
	const EMBER        ; 42
	const FIRE_PUNCH   ; 43
	const FLAMETHROWER ; 44
	const FIRE_BLAST   ; 45

	; === FLYING TYPE ===
	const PECK         ; 46
	const GUST         ; 47
	const WING_ATTACK  ; 48
	const FLY          ; 49
	const DRILL_PECK   ; 4a
	const SKY_ATTACK   ; 4b
	const MIRROR_MOVE  ; 4c

	; === GHOST TYPE ===
	const LICK         ; 4d
	const NIGHT_SHADE  ; 4e
	const CONFUSE_RAY  ; 4f

	; === GRASS TYPE ===
	const ABSORB       ; 50
	const VINE_WHIP    ; 51
	const RAZOR_LEAF   ; 52
	const MEGA_DRAIN   ; 53
	const PETAL_DANCE  ; 54
	const EGG_BOMB     ; 55
	const SOLARBEAM    ; 56
	const LEECH_SEED   ; 57
	const POISONPOWDER ; 58
	const STUN_SPORE   ; 59
	const SLEEP_POWDER ; 5a
	const SPORE        ; 5b

	; === GROUND TYPE ===
	const FISSURE      ; 5c
	const BONEMERANG   ; 5d
	const BONE_CLUB    ; 5e
	const DIG          ; 5f
	const EARTHQUAKE   ; 60

	; === ICE TYPE ===
	const AURORA_BEAM  ; 61
	const ICE_PUNCH    ; 62
	const ICE_BEAM     ; 63
	const BLIZZARD     ; 64
	const MIST         ; 65

	; === NORMAL TYPE ===
	const GUILLOTINE   ; 66
	const HORN_DRILL   ; 67
	const SONICBOOM    ; 68
	const SUPER_FANG   ; 69
	const BIND         ; 6a
	const WRAP         ; 6b
	const FURY_ATTACK  ; 6c
	const DOUBLESLAP   ; 6d
	const SPIKE_CANNON ; 6e
	const BARRAGE      ; 6f
	const FURY_SWIPES  ; 70
	const COMET_PUNCH  ; 71
	const TACKLE       ; 72
	const POUND        ; 73
	const SCRATCH      ; 74
	const QUICK_ATTACK ; 75
	const CONSTRICT    ; 76
	const VICEGRIP     ; 77
	const PAY_DAY      ; 78
	const BITE         ; 79
	const SWIFT        ; 7a
	const RAGE         ; 7b
	const STOMP        ; 7c
	const HORN_ATTACK  ; 7d
	const HEADBUTT     ; 7e
	const SLASH        ; 7f
	const DIZZY_PUNCH  ; 80
	const MEGA_PUNCH   ; 81
	const RAZOR_WIND   ; 82
	const STRENGTH     ; 83
	const HYPER_FANG   ; 84
	const BODY_SLAM    ; 85
	const TRI_ATTACK   ; 86
	const THRASH       ; 87
	const TAKE_DOWN    ; 88
	const SKULL_BASH   ; 89
	const MEGA_KICK    ; 8a
	const DOUBLE_EDGE  ; 8b
	const HYPER_BEAM   ; 8c
	const SELFDESTRUCT ; 8d
	const EXPLOSION    ; 8e

	; === POISON TYPE ===
	const POISON_STING ; 8f
	const SMOG         ; 90
	const ACID         ; 91
	const SLUDGE       ; 92
	const TOXIC        ; 93
	const POISON_GAS   ; 94

	; === PSYCHIC_TYPE ===
	const PSYWAVE      ; 95
	const CONFUSION    ; 96
	const PSYBEAM      ; 97
	const PSYCHIC_M    ; 98
	const DREAM_EATER  ; 99
	const HYPNOSIS     ; 9a
	const TELEPORT     ; 9b

	; === ROCK TYPE ===
	const ROCK_THROW   ; 9c
	const ROCK_SLIDE   ; 9d

	; === WATER TYPE ===
	const BUBBLE       ; 9e
	const CLAMP        ; 9f
	const WATER_GUN    ; a0
	const BUBBLEBEAM   ; a1
	const WATERFALL    ; a2
	const SURF         ; a3
	const CRABHAMMER   ; a4
	const HYDRO_PUMP   ; a5

	; === BIRD TYPE ===
	const SWORDS_DANCE ; 02
	const WHIRLWIND    ; 03
	const SAND_ATTACK  ; 04
	const TAIL_WHIP    ; 05
	const LEER         ; 06
	const GROWL        ; 07
	const ROAR         ; 08
	const SING         ; 09
	const SUPERSONIC   ; 0a
	const DISABLE      ; 0b
	const GROWTH       ; 0c
	const MEDITATE     ; 0d
	const AGILITY      ; 0e
	const MIMIC        ; 0f
	const SCREECH      ; 10
	const DOUBLE_TEAM  ; 11
	const RECOVER      ; 12
	const HARDEN       ; 13
	const MINIMIZE     ; 14
	const SMOKESCREEN  ; 15
	const WITHDRAW     ; 16
	const DEFENSE_CURL ; 17
	const BARRIER      ; 18
	const LIGHT_SCREEN ; 19
	const HAZE         ; 1a
	const REFLECT      ; 1b
	const FOCUS_ENERGY ; 1c
	const BIDE         ; 1d
	const METRONOME    ; 1e
	const AMNESIA      ; 1f
	const KINESIS      ; 20
	const SOFTBOILED   ; 21
	const GLARE        ; 22
	const LOVELY_KISS  ; 23
	const TRANSFORM    ; 24
	const FLASH        ; 25
	const SPLASH       ; 26
	const ACID_ARMOR   ; 27
	const REST         ; 28
	const SHARPEN      ; 29
	const CONVERSION   ; 2a
	const SUBSTITUTE   ; 2b
	const STRUGGLE     ; 01

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
