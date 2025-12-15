; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - AttackAnimationPointers (see data/moves/animations.asm)
; - MoveSoundTable (see data/moves/sfx.asm)
	const_def
	const NO_MOVE      ; 00

	; === BUG TYPE ===
	const CONSTRICT    ; 01
	const BUG_BITE     ; 02
	const LEECH_LIFE   ; 03
	const VICEGRIP     ; 04
	const BUG_BUZZ     ; 05
	const MEGAHORN     ; 06
	const TWINEEDLE    ; 07
	const GUILLOTINE   ; 08

	; === DARK TYPE ===
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

	; === DRAGON TYPE ===
	const DRAGON_RAGE  ; 13
	const DRAGON_CLAW  ; 14
	const DRAGON_BREATH ; 15
	const DRAGON_SLAM  ; 16
	const OUTRAGE      ; 17
	const HYPER_BEAM   ; 18

	; === ELECTRIC TYPE ===
	const NUZZLE       ; 19
	const THUNDERSHOCK ; 1a
	const DISCHARGE    ; 1b
	const THUNDERBOLT  ; 1c
	const THUNDER      ; 1d
	const THUNDER_WAVE ; 1e
	const VOLT_ATTACK  ; 1f

	; === FAIRY TYPE ===
	const DOUBLESLAP   ; 20
	const FAIRY_WIND   ; 21
	const DRAINING_KISS ; 22
	const DAZE_GLEAM   ; 23
	const PLAY_ROUGH   ; 24
	const MOONBLAST    ; 25

	; === FIGHTING TYPE ===
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

	; === FIRE TYPE ===
	const EMBER        ; 33
	const FLAME_WHEEL  ; 34
	const FLAME_BURST  ; 35
	const FLAMETHROWER ; 36
	const FIRE_BLAST   ; 37
	const FLAME_CHARGE ; 38
	const EXPLOSION    ; 39

	; === FLYING TYPE ===
	const PECK         ; 3a
	const GUST         ; 3b
	const WING_ATTACK  ; 3c
	const AERIAL_ACE   ; 3d
	const FLY          ; 3e
	const HURRICANE    ; 3f
	const SKY_ATTACK   ; 40
	const DRILL_PECK   ; 41

	; === GAS TYPE ===
	const SMOG         ; 42
	const POISON_GAS   ; 43
	const HAZE         ; 44

	; === GHOST TYPE ===
	const NIGHT_SHADE  ; 45
	const LICK         ; 46
	const ASTONISH     ; 47
	const SHADOW_PUNCH ; 48
	const SPIRIT_DRAIN ; 49
	const SHADOW_BALL  ; 4a
	const SHADOW_SNEAK ; 4b
	const CONFUSE_RAY  ; 4c

	; === GRASS TYPE ===
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

	; === GROUND TYPE ===
	const GROUND_STOMP ; 59
	const MUD_SHOT     ; 5a
	const BULLDOZE     ; 5b
	const MUD_BOMB     ; 5c
	const EARTHQUAKE   ; 5d
	const FISSURE      ; 5e
	const BONE_CLUB    ; 5f
	const DIG          ; 60

	; === ICE TYPE ===
	const POWDER_SNOW  ; 61
	const ICY_WIND     ; 62
	const AURORA_BEAM  ; 63
	const FROST_BREATH ; 64
	const ICE_BEAM     ; 65
	const BLIZZARD     ; 66

	; === MAGMA TYPE ===
	const MAGMA_PUNCH  ; 67
	const LAVA_PLUME   ; 68

	; === NORMAL TYPE ===
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

	; === POISON TYPE ===
	const POISON_STING ; 7d
	const ACID         ; 7e
	const POISON_FANG  ; 7f
	const SLUDGE       ; 80
	const SLUDGE_BOMB  ; 81
	const GUNK_SHOT    ; 82
	const TOXIC        ; 83
	const NEUROTOXIN   ; 84
	const SLUDGE_WAVE  ; 85

	; === PSYCHIC_TYPE ===
	const PSYWAVE      ; 86
	const CONFUSION    ; 87
	const EXTRASENSORY ; 88
	const PSYBEAM      ; 89
	const PSYCHIC_M    ; 8a
	const MIND_BREAK   ; 8b
	const HYPNOSIS     ; 8c

	; === ROCK TYPE ===
	const ROCK_PUNCH   ; 8d
	const ROCK_THROW   ; 8e
	const ROCK_TOMB    ; 8f
	const ROCK_SLIDE   ; 90
	const STONE_EDGE   ; 91
	const CLAMP        ; 92
	const BONEMERANG   ; 93
	const CRABHAMMER   ; 94
	const HORN_DRILL   ; 95

	; === STEEL TYPE ===
	const CUT          ; 96
	const IRON_TAIL    ; 97
	const IRON_HEAD    ; 98
	const MAGNET_BOMB  ; 99
	const SONICBOOM    ; 9a
	const BULLET_PUNCH ; 9b

	; === WATER TYPE ===
	const WATER_GUN    ; 9c
	const BUBBLEBEAM   ; 9d
	const WATER_PULSE  ; 9e
	const WATERFALL    ; 9f
	const SURF         ; a0
	const HYDRO_PUMP   ; a1
	const AQUA_JET     ; a2

	; === BIRD TYPE ===
	const TRI_ATTACK   ; a3
	const SWORDS_DANCE ; a4
	const SHARPEN      ; a5
	const HOWL         ; a6
	const HONE_CLAWS   ; a7
	const WORK_UP      ; a8
	const ACID_ARMOR   ; a9
	const HARDEN       ; aa
	const WITHDRAW     ; ab
	const DEFENSE_CURL ; ac
	const AQUA_VEIL    ; ad
	const CALM_MIND    ; ae
	const NASTY_PLOT   ; af
	const AROMATIC_MIST ; b0
	const GROWTH       ; b1
	const AMNESIA      ; b2
	const AGILITY      ; b3
	const TAILWIND     ; b4
	const ROCK_POLISH  ; b5
	const QUIVER_DANCE ; b6
	const MINIMIZE     ; b7
	const DOUBLE_TEAM  ; b8
	const TELEPORT     ; b9
	const CHARM        ; ba
	const INTIMIDATE   ; bb
	const NOBLE_ROAR   ; bc
	const LEER         ; bd
	const GROWL        ; be
	const FEATHER_DANCE ; bf
	const TAUNT        ; c0
	const CORRODE      ; c1
	const TAIL_WHIP    ; c2
	const TICKLE       ; c3
	const DECAY        ; c4
	const FAKE_TEARS   ; c5
	const METAL_SOUND  ; c6
	const SCREECH      ; c7
	const EERIE_IMPULSE ; c8
	const CONFIDE      ; c9
	const SCARY_FACE   ; ca
	const PSYCHIC_BIND ; cb
	const SLUDGE_TRAP  ; cc
	const SWEET_SCENT  ; cd
	const HINDER       ; ce
	const STRING_SHOT  ; cf
	const SMOKESCREEN  ; d0
	const SAND_ATTACK  ; d1
	const FLASH        ; d2
	const SING         ; d3
	const SUPERSONIC   ; d4
	const DISABLE      ; d5
	const GLARE        ; d6
	const LOVELY_KISS  ; d7
	const RECOVER      ; d8
	const MOONLIGHT    ; d9
	const REST         ; da
	const SOFTBOILED   ; db
	const LIGHT_SCREEN ; dc
	const REFLECT      ; dd
	const MIMIC        ; de
	const MIRROR_MOVE  ; df
	const FOCUS_ENERGY ; e0
	const BIDE         ; e1
	const SUBSTITUTE   ; e2
	const TRANSFORM    ; e3
	const SPLASH       ; e4
	const METRONOME    ; e5
	const STRUGGLE     ; e6

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
