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
	const CONSTRICT
	const BUG_BITE
	const LEECH_LIFE
	const BUG_BUZZ
	const MEGAHORN
	const GUILLOTINE
	const VICEGRIP
	const TWINEEDLE

; === DARK ===
	const FAINT_ATTACK
	const RAGE
	const NIGHT_SLASH
	const BRUTAL_SWING
	const DARK_PULSE
	const GORE_ATTACK
	const PAY_DAY
	const DREAM_EATER
	const GLARE
	const DEEP_SLEEP

; === DRAGON ===
	const DRAGON_RAGE
	const DRAGON_CLAW
	const DRAGON_BREATH
	const DRAGON_SLAM
	const OUTRAGE
	const HYPER_BEAM

; === ELECTRIC ===
	const NUZZLE
	const THUNDERSHOCK
	const DISCHARGE
	const THUNDERBOLT
	const THUNDER
	const THUNDER_WAVE
	const VOLT_TACKLE

; === FAIRY ===
	const DOUBLESLAP
	const FAIRY_WIND
	const DRAINING_KISS
	const DAZE_GLEAM
	const PLAY_ROUGH
	const MOONBLAST
	const LOVELY_KISS
	const SING

; === FIGHTING ===
	const SEISMIC_TOSS
	const COMET_PUNCH
	const LOW_KICK
	const BIND
	const MACH_PUNCH
	const KARATE_CHOP
	const DOUBLE_KICK
	const STRENGTH
	const TAKE_DOWN
	const LEEK_STRIKE
	const DIZZY_PUNCH
	const ROLLING_KICK
	const SUBMISSION
	const SKY_UPPERCUT
	const HI_JUMP_KICK

; === FIRE ===
	const EMBER
	const FLAME_CHARGE
	const FLAME_BURST
	const FLAMETHROWER
	const FIRE_BLAST
	const IGNITE
	const EXPLOSION

; === FLYING ===
	const PECK
	const GUST
	const WING_ATTACK
	const AERIAL_ACE
	const FLY
	const HURRICANE
	const SKY_ATTACK
	const DRILL_PECK

; === FUNGUS ===
	const SPORE_DAZE
	const PARASITE
	const SPORE

; === GAS ===
	const SMOG
	const POISON_GAS
	const HAZE

; === GHOST ===
	const NIGHT_SHADE
	const LICK
	const ASTONISH
	const SHADOW_SNEAK
	const SHADOW_PUNCH
	const SPIRIT_DRAIN
	const SHADOW_BALL
	const CONFUSE_RAY
	const WILL_O_WISP

; === GRASS ===
	const ABSORB
	const VINE_WHIP
	const MEGA_DRAIN
	const RAZOR_LEAF
	const GIGA_DRAIN
	const PETAL_DANCE
	const SOLARBEAM
	const LEECH_SEED
	const POISONPOWDER
	const STUN_SPORE
	const SLEEP_POWDER

; === GROUND ===
	const GROUND_STOMP
	const MUD_SHOT
	const BULLDOZE
	const MUD_BOMB
	const EARTHQUAKE
	const FISSURE
	const BONE_CLUB
	const DIG

; === ICE ===
	const POWDER_SNOW
	const ICY_WIND
	const AURORA_BEAM
	const FROST_BREATH
	const ICE_BEAM
	const BLIZZARD

; === MAGMA ===
	const MAGMA_PUNCH
	const LAVA_PLUME

; === NORMAL ===
	const WRAP
	const FURY_ATTACK
	const SCRATCH
	const TACKLE
	const BITE
	const QUICK_ATTACK
	const HEADBUTT
	const HORN_ATTACK
	const SLASH
	const BODY_SLAM
	const CRUNCH
	const HORN_CHARGE
	const THRASH
	const HEAVY_SLAM
	const DOUBLE_EDGE
	const EXTREMESPEED
	const SUPERSONIC
	const SUPER_FANG
	const HYPER_FANG

; === POISON ===
	const POISON_STING
	const POISON_FANG
	const TOXIC_FANGS
	const ACID
	const SLUDGE
	const SLUDGE_WAVE
	const GUNK_SHOT
	const NEUROTOXIN
	const TOXIC

; === PSYCHIC ===
	const PSYWAVE
	const CONFUSION
	const EXTRASENSORY
	const PSYBEAM
	const PSYCHIC_M
	const MIND_BREAK
	const DISABLE
	const HYPNOSIS

; === ROCK ===
	const ROCK_THROW
	const ROCK_PUNCH
	const ROCK_TOMB
	const HEAD_SMASH
	const ROCK_SLIDE
	const CLAMP
	const BONEMERANG
	const CRABHAMMER
	const HORN_DRILL

; === STEEL ===
	const CUT
	const IRON_TAIL
	const IRON_HEAD
	const SONICBOOM
	const BULLET_PUNCH
	const MAGNET_BOMB

; === WATER ===
	const WATER_GUN
	const AQUA_JET
	const BUBBLEBEAM
	const WATER_PULSE
	const WATERFALL
	const SURF
	const HYDRO_PUMP

; === BIRD (typeless / status moves) ===
	const TRI_ATTACK
	const BULK_UP
	const HONE_CLAWS
	const SWORDS_DANCE
	const COIL
	const DEFENSE_CURL
	const HARDEN
	const WITHDRAW
	const CALM_MIND
	const AMNESIA
	const GROWTH
	const NASTY_PLOT
	const QUIVER_DANCE
	const TAILWIND
	const AGILITY
	const DOUBLE_TEAM
	const TELEPORT
	const CHARM
	const INTIMIDATE
	const LEER
	const GROWL
	const CORRODE
	const TAIL_WHIP
	const TAUNT
	const TICKLE
	const FAKE_TEARS
	const METAL_SOUND
	const SCREECH
	const EERIE_IMPULSE
	const SCARY_FACE
	const ENTANGLE
	const PSYCHIC_BIND
	const HINDER
	const FLASH
	const SAND_ATTACK
	const SMOKESCREEN
	const RECOVER
	const REST
	const SOFTBOILED
	const LIGHT_SCREEN
	const REFLECT
	const BIDE
	const FOCUS_ENERGY
	const MIMIC
	const MIRROR_MOVE
	const SUBSTITUTE
	const TRANSFORM
	const SPLASH
	const METRONOME
	const STRUGGLE

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
	; PURPLE YELLOW v0.5: removed ANIM_B6/ANIM_B7 (UnusedAnim placeholders)
	; to free 2 slots, raising max NUM_ATTACKS from 218 to 220.
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
