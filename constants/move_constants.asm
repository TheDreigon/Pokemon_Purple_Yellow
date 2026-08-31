; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - AttackAnimationPointers (see data/moves/animations.asm)
; - MoveSoundTable (see data/moves/sfx.asm)
;
; Order: alphabetical by TYPE, ascending POWER within type, status moves last
; within type, signature/pool moves at the bottom of each type (POISON
; deviates deliberately; BIRD = typeless/status group at the end). Mirrors
; the authoritative header in data/moves/moves.asm.
; STRUGGLE must remain the last move (engine asserts NUM_ATTACKS == STRUGGLE).
;
; WARNING — ORDER IS LOAD-BEARING: the engine indexes all four tables above
; by (move id - 1), so the row order in moves.asm, names.asm, the
; AttackAnimationPointers table, and sfx.asm must EXACTLY match the const
; order here. Reordering rows in only one file silently gives moves another
; move's data in-game (the build still passes — the length asserts can't see
; it). Run `python .claude/check_move_alignment.py` after any reorder.
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
	const SHOCK_WAVE
	const THUNDERBOLT
	const THUNDER
	const THUNDER_WAVE
	const VOLT_TACKLE

; === FAIRY ===
	const DOUBLESLAP
	const FAIRY_WIND
	const DRAINING_KISS
	const DAZZLE_GLEAM
	const PLAY_ROUGH
	const LOVELY_KISS
	const SING
	const MOONBLAST

; === FIGHTING ===
	const SEISMIC_TOSS
	const LOW_KICK
	const COMET_PUNCH
	const BIND
	const MACH_PUNCH
	const KARATE_CHOP
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
	const HAZE
	const POISON_GAS

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
	const STUN_POWDER
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
	const FROST_BREATH
	const ICY_PULSE
	const AURORA_BEAM
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
	const FALSE_SWIPE ; v0.7 new move (2026-08-30)

; === POISON ===
	const POISON_STING
	const POISON_BITE
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
	const ROLLOUT
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
; Group order: ATK-buffs / DEF-buffs / SPC-buffs / SPD-buffs / EVA-buffs /
; ATK-debuffs / DEF-debuffs / SPC-debuffs / SPD-debuffs / ACC-debuffs /
; heals / screens / utility (Tri Attack, the lone damaging typeless move,
; leads the group).
	const TRI_ATTACK
	const SWORDS_DANCE
	const BULK_UP
	const COIL
	const FIERCE_ROAR
	const HONE_CLAWS
	const IRON_DEFENSE
	const DEFENSE_CURL
	const HARDEN
	const WITHDRAW
	const GROWTH
	const CALM_MIND
	const NASTY_PLOT
	const AMNESIA
	const QUIVER_DANCE
	const TAILWIND
	const AGILITY
	const DOUBLE_TEAM
	const TELEPORT
	const CHARM
	const INTIMIDATE
	const GROWL
	const LEER
	const CORRODE
	const TICKLE
	const TAIL_WHIP
	const FAKE_TEARS
	const METAL_SOUND
	const SCREECH
	const EERIE_IMPULSE
	const SCARY_FACE
	const HINDER
	const STRING_SHOT
	const PSYCHIC_BIND
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
	const METRONOME
	const STRUGGLE

DEF NUM_ATTACKS EQU const_value - 1

; v0.7 anim split (2026-08-31, Forte's GO - the expansion prep): the 35
; SPECIAL battle animations no longer share the move-id byte. They live in
; their own 1-based id space, played through PlaySpecialAnimation (or by
; writing SPECIAL_ANIM_MARKER into wAnimationID with the index in
; hSpecialAnimIndex) and resolved via SpecialAnimationPointers. Moves now
; own ids 1..254 outright. Before the split, 220 moves + these 35 filled
; the byte at exactly 255 and the movelist could never grow again.
;
; $FF doubles as the marker AND stays reserved as the -1 list terminator -
; a real move id can never be $FF (see the 254 assert below).
DEF SPECIAL_ANIM_MARKER EQU $FF

	const_def 1
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
	; back when these shared the move-id byte. Slots are cheap now (2
	; pointer bytes each) - the placeholders stay to keep the order stable.
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

DEF NUM_SPECIAL_ANIMS EQU const_value - 1
ASSERT NUM_SPECIAL_ANIMS == 35, "the special-anim census (and its pointer table) is 35 entries"
ASSERT NUM_SPECIAL_ANIMS < SPECIAL_ANIM_MARKER, "special anim indexes must stay below the marker"
; structural pins the engine arithmetic depends on (hWhoseTurn `add` pairs
; and the trade-ball palette range test):
ASSERT XSTATITEM_DUPLICATE_ANIM == XSTATITEM_ANIM + 1, "Bide/X-item +turn pair broke"
ASSERT ANIM_B1 == SHRINKING_SQUARE_ANIM + 1, "Thrash +turn pair broke"
ASSERT TRADE_BALL_POOF_ANIM == TRADE_BALL_DROP_ANIM + 3, "the trade-ball run of 4 broke"
; The blessed expansion ceiling (Forte, 2026-08-31): up to 254 moves - $FF
; stays reserved (list terminators), and 248/256 are forbidden counts
; (movedex_seen's % 8 assert). See Notes/"Tecto de moves 220-250".
ASSERT NUM_ATTACKS <= 254, "the blessed move ceiling is 254 ($FF is reserved)"
; v0.7 expansion prep (2026-08-31): the SAVED movedex bitfield is pre-sized
; to this capacity (32 bytes) so move additions stop breaking the save
; format - the ceiling above keeps NUM_ATTACKS inside it forever.
DEF MOVEDEX_FLAG_CAPACITY EQU 256
ASSERT NUM_ATTACKS < MOVEDEX_FLAG_CAPACITY, "the movedex outgrew its saved bitfield"
