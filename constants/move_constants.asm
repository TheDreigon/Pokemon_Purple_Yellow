; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - AttackAnimationPointers (see data/moves/animations.asm)
; - MoveSoundTable (see data/moves/sfx.asm)
;
; Order: alphabetical by TYPE, ascending POWER within type, status moves last
; within type (BIRD = typeless/status group at the end).
; STRUGGLE must remain the last move (engine asserts NUM_ATTACKS == STRUGGLE).
	const_def
	const NO_MOVE      ; 00

; === BUG ===
	const CONSTRICT    ; 01
	const BUG_BITE     ; 02
	const LEECH_LIFE   ; 03
	const BUG_BUZZ     ; 04
	const MEGAHORN     ; 05
	const GUILLOTINE   ; 06
	const VICEGRIP     ; 07
	const TWINEEDLE    ; 08

; === DARK ===
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

; === DRAGON ===
	const DRAGON_RAGE  ; 13
	const DRAGON_CLAW  ; 14
	const DRAGON_BREATH; 15
	const DRAGON_SLAM  ; 16
	const HYPER_BEAM   ; 17

; === ELECTRIC ===
	const NUZZLE       ; 18
	const THUNDERSHOCK ; 19
	const DISCHARGE    ; 1a
	const THUNDERBOLT  ; 1b
	const THUNDER      ; 1c
	const THUNDER_WAVE ; 1d
	const VOLT_TACKLE  ; 1e

; === FAIRY ===
	const DOUBLESLAP   ; 1f
	const FAIRY_WIND   ; 20
	const DRAINING_KISS; 21
	const DAZE_GLEAM   ; 22
	const PLAY_ROUGH   ; 23
	const MOONBLAST    ; 24

; === FIGHTING ===
	const SEISMIC_TOSS ; 25
	const LOW_KICK     ; 26
	const BIND         ; 27
	const KARATE_CHOP  ; 28
	const DOUBLE_KICK  ; 29
	const STRENGTH     ; 2a
	const TAKE_DOWN    ; 2b
	const JUMP_KICK    ; 2c
	const DIZZY_PUNCH  ; 2d
	const ROLLING_KICK ; 2e
	const LEEK_STRIKE  ; 2f
	const SUBMISSION   ; 30
	const HI_JUMP_KICK ; 31

; === FIRE ===
	const EMBER        ; 32
	const FLAME_CHARGE ; 33
	const FLAME_BURST  ; 34
	const FLAMETHROWER ; 35
	const FIRE_BLAST   ; 36
	const EXPLOSION    ; 37

; === FLYING ===
	const PECK         ; 38
	const GUST         ; 39
	const WING_ATTACK  ; 3a
	const AERIAL_ACE   ; 3b
	const FLY          ; 3c
	const HURRICANE    ; 3d
	const DRILL_PECK   ; 3e

; === FUNGUS ===
	const PARASITE     ; 3f
	const SPORE        ; 40

; === GAS ===
	const SMOG         ; 41
	const POISON_GAS   ; 42
	const HAZE         ; 43

; === GHOST ===
	const NIGHT_SHADE  ; 44
	const LICK         ; 45
	const ASTONISH     ; 46
	const SHADOW_SNEAK ; 47
	const SHADOW_PUNCH ; 48
	const SPIRIT_DRAIN ; 49
	const SHADOW_BALL  ; 4a
	const CONFUSE_RAY  ; 4b
	const WILL_O_WISP  ; 4c  ; new move (Purple Yellow)

; === GRASS ===
	const ABSORB       ; 4d
	const VINE_WHIP    ; 4e
	const MEGA_DRAIN   ; 4f
	const RAZOR_LEAF   ; 4f
	const GIGA_DRAIN   ; 50
	const PETAL_DANCE  ; 51
	const SOLARBEAM    ; 52
	const LEECH_SEED   ; 53
	const POISONPOWDER ; 54
	const STUN_SPORE   ; 55
	const SLEEP_POWDER ; 56

; === GROUND ===
	const GROUND_STOMP ; 57
	const MUD_SHOT     ; 58
	const BULLDOZE     ; 59
	const MUD_BOMB     ; 5a
	const EARTHQUAKE   ; 5b
	const FISSURE      ; 5c
	const BONE_CLUB    ; 5d
	const DIG          ; 5e

; === ICE ===
	const POWDER_SNOW  ; 5f
	const ICY_WIND     ; 60
	const AURORA_BEAM  ; 61
	const FROST_BREATH ; 62
	const ICE_BEAM     ; 63
	const BLIZZARD     ; 64

; === MAGMA ===
	const MAGMA_PUNCH  ; 65
	const LAVA_PLUME   ; 66

; === NORMAL ===
	const WRAP         ; 67
	const FURY_ATTACK  ; 68
	const COMET_PUNCH  ; 69
	const SCRATCH      ; 6a
	const TACKLE       ; 6b
	const BITE         ; 6c
	const QUICK_ATTACK ; 6d
	const HEADBUTT     ; 6e
	const HORN_ATTACK  ; 6f
	const SLASH        ; 70
	const BODY_SLAM    ; 71
	const MEGA_PUNCH   ; 72
	const CRUNCH       ; 73
	const HORN_CHARGE  ; 74
	const HEAVY_SLAM   ; 75
	const DOUBLE_EDGE  ; 76
	const EXTREMESPEED ; 77
	const SUPER_FANG   ; 78
	const HYPER_FANG   ; 79

; === POISON ===
	const POISON_STING ; 7a
	const ACID         ; 7b
	const POISON_FANG  ; 7c
	const SLUDGE       ; 7d
	const SLUDGE_BOMB  ; 7e
	const GUNK_SHOT    ; 7f
	const TOXIC        ; 80
	const NEUROTOXIN   ; 81
	const SLUDGE_WAVE  ; 82

; === PSYCHIC ===
	const PSYWAVE      ; 83
	const CONFUSION    ; 84
	const EXTRASENSORY ; 85
	const PSYBEAM      ; 86
	const PSYCHIC_M    ; 87
	const MIND_BREAK   ; 88
	const HYPNOSIS     ; 89

; === ROCK ===
	const ROCK_PUNCH   ; 8a
	const ROCK_THROW   ; 8b
	const ROCK_TOMB    ; 8c
	const HEAD_SMASH   ; 8d
	const ROCK_SLIDE   ; 8e
	const CLAMP        ; 8f
	const BONEMERANG   ; 90
	const CRABHAMMER   ; 91
	const HORN_DRILL   ; 92

; === STEEL ===
	const CUT          ; 93
	const IRON_TAIL    ; 94
	const IRON_HEAD    ; 95
	const SONICBOOM    ; 96
	const BULLET_PUNCH ; 97
	const MAGNET_BOMB  ; 98

; === WATER ===
	const WATER_GUN    ; 99
	const AQUA_JET     ; 9a
	const BUBBLEBEAM   ; 9b
	const WATER_PULSE  ; 9c
	const WATERFALL    ; 9d
	const SURF         ; 9e
	const HYDRO_PUMP   ; 9f

; === BIRD (typeless / status moves) ===
	const TRI_ATTACK   ; a0
	const SWORDS_DANCE ; a1
	const COIL         ; a2
	const BULK_UP      ; a4  ; renamed from FLEX (now dual-stat Atk+Def)
	const HONE_CLAWS   ; a4
	const ACID_ARMOR   ; a5
	const DEFENSE_CURL ; a6
	const HARDEN       ; a7
	const WITHDRAW     ; a8
	const AMNESIA      ; a9
	const CALM_MIND    ; aa
	const GROWTH       ; ab
	const NASTY_PLOT   ; ac
	const AGILITY      ; ad
	const QUIVER_DANCE ; ae
	const ROCK_POLISH  ; af
	const TAILWIND     ; b0
	const DOUBLE_TEAM  ; b1
	const MINIMIZE     ; b2
	const TELEPORT     ; b3
	const CHARM        ; b4
	const INTIMIDATE   ; b5
	const LEER         ; b6
	const GROWL        ; b7
	const CORRODE      ; b8
	const TAIL_WHIP    ; b9
	const TAUNT        ; ba
	const TICKLE       ; bb
	const FAKE_TEARS   ; bc
	const METAL_SOUND  ; bd
	const EERIE_IMPULSE; be
	const SCREECH      ; bf
	const ENTANGLE     ; c0
	const SCARY_FACE   ; c1
	const PSYCHIC_BIND ; c2
	const HINDER       ; c3
	const FLASH        ; c4
	const SAND_ATTACK  ; c5
	const SMOKESCREEN  ; c6
	const DISABLE      ; c7
	const GLARE        ; c8
	const LOVELY_KISS  ; c9
	const SING         ; ca
	const SUPERSONIC   ; cb
	const RECOVER      ; cc
	const REST         ; cd
	const SOFTBOILED   ; ce
	const LIGHT_SCREEN ; cf
	const REFLECT      ; d0
	const BIDE         ; d1
	const FOCUS_ENERGY ; d2
	const MIMIC        ; d3
	const MIRROR_MOVE  ; d4
	const SUBSTITUTE   ; d5
	const TRANSFORM    ; d6
	const SPLASH       ; d7
	const METRONOME    ; d8
	const STRUGGLE     ; d9 (must remain last)
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
