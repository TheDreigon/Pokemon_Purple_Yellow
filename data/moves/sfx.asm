MoveSoundTable:
	table_width 3, MoveSoundTable
	; ID, pitch mod, tempo mod
	;
	; PURPLE YELLOW v0.5: every move uses the POUND SFX as a placeholder.
	; Each entry is labeled with its move name in the comment so that each
	; row can be customised independently later.

MACRO placeholder_sfx
	db SFX_POUND, $00, $80 ; \1
ENDM

; === BUG ===
	placeholder_sfx CONSTRICT
	placeholder_sfx BUG_BITE
	placeholder_sfx LEECH_LIFE
	placeholder_sfx BUG_BUZZ
	placeholder_sfx MEGAHORN
	placeholder_sfx GUILLOTINE
	placeholder_sfx VICEGRIP
	placeholder_sfx TWINEEDLE
; === DARK ===
	placeholder_sfx FAINT_ATTACK
	placeholder_sfx RAGE
	placeholder_sfx NIGHT_SLASH
	placeholder_sfx BRUTAL_SWING
	placeholder_sfx DARK_PULSE
	placeholder_sfx GORE_ATTACK
	placeholder_sfx THRASH
	placeholder_sfx DEEP_SLEEP
	placeholder_sfx PAY_DAY
	placeholder_sfx DREAM_EATER
; === DRAGON ===
	placeholder_sfx DRAGON_RAGE
	placeholder_sfx DRAGON_CLAW
	placeholder_sfx DRAGON_BREATH
	placeholder_sfx DRAGON_SLAM
	placeholder_sfx HYPER_BEAM
; === ELECTRIC ===
	placeholder_sfx NUZZLE
	placeholder_sfx THUNDERSHOCK
	placeholder_sfx DISCHARGE
	placeholder_sfx THUNDERBOLT
	placeholder_sfx THUNDER
	placeholder_sfx THUNDER_WAVE
	placeholder_sfx VOLT_TACKLE
; === FAIRY ===
	placeholder_sfx DOUBLESLAP
	placeholder_sfx FAIRY_WIND
	placeholder_sfx DRAINING_KISS
	placeholder_sfx DAZE_GLEAM
	placeholder_sfx PLAY_ROUGH
	placeholder_sfx MOONBLAST
; === FIGHTING ===
	placeholder_sfx SEISMIC_TOSS
	placeholder_sfx LOW_KICK
	placeholder_sfx BIND
	placeholder_sfx KARATE_CHOP
	placeholder_sfx DOUBLE_KICK
	placeholder_sfx STRENGTH
	placeholder_sfx TAKE_DOWN
	placeholder_sfx JUMP_KICK
	placeholder_sfx DIZZY_PUNCH
	placeholder_sfx ROLLING_KICK
	placeholder_sfx LEEK_STRIKE
	placeholder_sfx SUBMISSION
	placeholder_sfx HI_JUMP_KICK
; === FIRE ===
	placeholder_sfx EMBER
	placeholder_sfx FLAME_CHARGE
	placeholder_sfx FLAME_BURST
	placeholder_sfx FLAMETHROWER
	placeholder_sfx FIRE_BLAST
	placeholder_sfx EXPLOSION
; === FLYING ===
	placeholder_sfx PECK
	placeholder_sfx GUST
	placeholder_sfx WING_ATTACK
	placeholder_sfx AERIAL_ACE
	placeholder_sfx FLY
	placeholder_sfx HURRICANE
	placeholder_sfx DRILL_PECK
; === FUNGI ===
	placeholder_sfx PARASITE
	placeholder_sfx SPORE
; === GAS ===
	placeholder_sfx SMOG
	placeholder_sfx POISON_GAS
	placeholder_sfx HAZE
; === GHOST ===
	placeholder_sfx NIGHT_SHADE
	placeholder_sfx LICK
	placeholder_sfx ASTONISH
	placeholder_sfx SHADOW_SNEAK
	placeholder_sfx SHADOW_PUNCH
	placeholder_sfx SPIRIT_DRAIN
	placeholder_sfx SHADOW_BALL
	placeholder_sfx CONFUSE_RAY
; === GRASS ===
	placeholder_sfx ABSORB
	placeholder_sfx VINE_WHIP
	placeholder_sfx MEGA_DRAIN
	placeholder_sfx RAZOR_LEAF
	placeholder_sfx GIGA_DRAIN
	placeholder_sfx PETAL_DANCE
	placeholder_sfx SOLARBEAM
	placeholder_sfx LEECH_SEED
	placeholder_sfx POISONPOWDER
	placeholder_sfx STUN_SPORE
	placeholder_sfx SLEEP_POWDER
; === GROUND ===
	placeholder_sfx GROUND_STOMP
	placeholder_sfx MUD_SHOT
	placeholder_sfx BULLDOZE
	placeholder_sfx MUD_BOMB
	placeholder_sfx EARTHQUAKE
	placeholder_sfx FISSURE
	placeholder_sfx BONE_CLUB
	placeholder_sfx DIG
; === ICE ===
	placeholder_sfx POWDER_SNOW
	placeholder_sfx ICY_WIND
	placeholder_sfx AURORA_BEAM
	placeholder_sfx FROST_BREATH
	placeholder_sfx ICE_BEAM
	placeholder_sfx BLIZZARD
; === MAGMA ===
	placeholder_sfx MAGMA_PUNCH
	placeholder_sfx LAVA_PLUME
; === NORMAL ===
	placeholder_sfx WRAP
	placeholder_sfx FURY_ATTACK
	placeholder_sfx COMET_PUNCH
	placeholder_sfx SCRATCH
	placeholder_sfx TACKLE
	placeholder_sfx BITE
	placeholder_sfx QUICK_ATTACK
	placeholder_sfx HEADBUTT
	placeholder_sfx HORN_ATTACK
	placeholder_sfx SLASH
	placeholder_sfx BODY_SLAM
	placeholder_sfx MEGA_PUNCH
	placeholder_sfx CRUNCH
	placeholder_sfx HORN_CHARGE
	placeholder_sfx HEAVY_SLAM
	placeholder_sfx DOUBLE_EDGE
	placeholder_sfx EXTREMESPEED
	placeholder_sfx SUPER_FANG
	placeholder_sfx HYPER_FANG
; === POISON ===
	placeholder_sfx POISON_STING
	placeholder_sfx ACID
	placeholder_sfx POISON_FANG
	placeholder_sfx SLUDGE
	placeholder_sfx SLUDGE_BOMB
	placeholder_sfx GUNK_SHOT
	placeholder_sfx TOXIC
	placeholder_sfx NEUROTOXIN
	placeholder_sfx SLUDGE_WAVE
; === PSYCHIC ===
	placeholder_sfx PSYWAVE
	placeholder_sfx CONFUSION
	placeholder_sfx EXTRASENSORY
	placeholder_sfx PSYBEAM
	placeholder_sfx PSYCHIC_M
	placeholder_sfx MIND_BREAK
	placeholder_sfx HYPNOSIS
; === ROCK ===
	placeholder_sfx ROCK_PUNCH
	placeholder_sfx ROCK_THROW
	placeholder_sfx ROCK_TOMB
	placeholder_sfx HEAD_SMASH
	placeholder_sfx ROCK_SLIDE
	placeholder_sfx CLAMP
	placeholder_sfx BONEMERANG
	placeholder_sfx CRABHAMMER
	placeholder_sfx HORN_DRILL
; === STEEL ===
	placeholder_sfx CUT
	placeholder_sfx IRON_TAIL
	placeholder_sfx IRON_HEAD
	placeholder_sfx SONICBOOM
	placeholder_sfx BULLET_PUNCH
	placeholder_sfx MAGNET_BOMB
; === WATER ===
	placeholder_sfx WATER_GUN
	placeholder_sfx AQUA_JET
	placeholder_sfx BUBBLEBEAM
	placeholder_sfx WATER_PULSE
	placeholder_sfx WATERFALL
	placeholder_sfx SURF
	placeholder_sfx HYDRO_PUMP
; === BIRD (typeless) ===
	placeholder_sfx TRI_ATTACK
	placeholder_sfx SWORDS_DANCE
	placeholder_sfx COIL
	placeholder_sfx FLEX
	placeholder_sfx HONE_CLAWS
	placeholder_sfx ACID_ARMOR
	placeholder_sfx DEFENSE_CURL
	placeholder_sfx HARDEN
	placeholder_sfx WITHDRAW
	placeholder_sfx AMNESIA
	placeholder_sfx CALM_MIND
	placeholder_sfx GROWTH
	placeholder_sfx NASTY_PLOT
	placeholder_sfx AGILITY
	placeholder_sfx QUIVER_DANCE
	placeholder_sfx ROCK_POLISH
	placeholder_sfx TAILWIND
	placeholder_sfx DOUBLE_TEAM
	placeholder_sfx MINIMIZE
	placeholder_sfx TELEPORT
	placeholder_sfx CHARM
	placeholder_sfx INTIMIDATE
	placeholder_sfx LEER
	placeholder_sfx GROWL
	placeholder_sfx CORRODE
	placeholder_sfx TAIL_WHIP
	placeholder_sfx TAUNT
	placeholder_sfx TICKLE
	placeholder_sfx FAKE_TEARS
	placeholder_sfx METAL_SOUND
	placeholder_sfx EERIE_IMPULSE
	placeholder_sfx SCREECH
	placeholder_sfx ENTANGLE
	placeholder_sfx SCARY_FACE
	placeholder_sfx PSYCHIC_BIND
	placeholder_sfx HINDER
	placeholder_sfx FLASH
	placeholder_sfx SAND_ATTACK
	placeholder_sfx SMOKESCREEN
	placeholder_sfx DISABLE
	placeholder_sfx GLARE
	placeholder_sfx LOVELY_KISS
	placeholder_sfx SING
	placeholder_sfx SUPERSONIC
	placeholder_sfx RECOVER
	placeholder_sfx REST
	placeholder_sfx SOFTBOILED
	placeholder_sfx LIGHT_SCREEN
	placeholder_sfx REFLECT
	placeholder_sfx BIDE
	placeholder_sfx FOCUS_ENERGY
	placeholder_sfx MIMIC
	placeholder_sfx MIRROR_MOVE
	placeholder_sfx SUBSTITUTE
	placeholder_sfx TRANSFORM
	placeholder_sfx SPLASH
	placeholder_sfx METRONOME
	placeholder_sfx STRUGGLE
	assert_table_length NUM_ATTACKS
