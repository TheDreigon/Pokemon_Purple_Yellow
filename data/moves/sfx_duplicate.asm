MoveSoundTable:
	table_width 3, MoveSoundTable
	; ID, pitch mod, tempo mod

	; === BUG TYPE ===
	db SFX_BATTLE_14,          $0f, $80 ; CONSTRICT
	db SFX_BATTLE_1E,          $00, $80 ; BUG_BITE (novo - similar Bite)
	db SFX_BATTLE_24,          $00, $80 ; LEECH_LIFE
	db SFX_BATTLE_0F,          $20, $40 ; VICEGRIP
	db SFX_PSYBEAM,            $10, $80 ; BUG_BUZZ (novo - similar Psybeam, buzz sound)
	db SFX_BATTLE_1E,          $20, $60 ; MEGAHORN (novo - similar Horn Attack)
	db SFX_BATTLE_1B,          $20, $c0 ; TWINEEDLE
	db SFX_BATTLE_0F,          $00, $80 ; GUILLOTINE (mudou para Bug!)

	; === DARK TYPE ===
	db SFX_BATTLE_2B,          $00, $80 ; FAINT_ATTACK (novo - similar Swift)
	db SFX_BATTLE_26,          $f0, $20 ; RAGE
	db SFX_NOT_VERY_EFFECTIVE, $01, $ff ; NIGHT_SLASH (novo - similar Slash)
	db SFX_BATTLE_22,          $00, $80 ; BRUTAL_SWING (novo - similar Slam)
	db SFX_PSYCHIC_M,          $20, $80 ; DARK_PULSE (novo - similar Psychic, pulse)
	db SFX_BATTLE_1E,          $30, $80 ; GORE_ATTACK (novo - similar Bite, violent)
	db SFX_BATTLE_22,          $11, $c0 ; THRASH (mudou para Dark!)
	db SFX_BATTLE_35,          $00, $60 ; DEEP_SLEEP (novo - similar Hypnosis)
	db SFX_SILPH_SCOPE,        $00, $ff ; PAY_DAY (mudou para Dark!)
	db SFX_BATTLE_35,          $42, $01 ; DREAM_EATER (mudou para Dark!)

	; === DRAGON TYPE ===
	db SFX_BATTLE_29,          $f0, $80 ; DRAGON_RAGE
	db SFX_NOT_VERY_EFFECTIVE, $10, $a0 ; DRAGON_CLAW (novo - similar Cut, claws)
	db SFX_BATTLE_29,          $00, $c0 ; DRAGON_BREATH (novo - similar Dragon Rage)
	db SFX_BATTLE_22,          $20, $a0 ; DRAGON_SLAM (novo - similar Slam)
	db SFX_BATTLE_22,          $30, $c0 ; OUTRAGE (novo - similar Thrash)
	db SFX_BATTLE_36,          $00, $80 ; HYPER_BEAM (mudou para Dragon!)

	; === ELECTRIC TYPE ===
	db SFX_BATTLE_2F,          $00, $40 ; NUZZLE (novo - similar Thundershock, weak)
	db SFX_BATTLE_2F,          $00, $20 ; THUNDERSHOCK
	db SFX_BATTLE_2F,          $10, $60 ; DISCHARGE (novo - similar Thunderbolt)
	db SFX_BATTLE_2F,          $20, $80 ; THUNDERBOLT
	db SFX_BATTLE_26,          $00, $80 ; THUNDER
	db SFX_BATTLE_2E,          $12, $60 ; THUNDER_WAVE
	db SFX_BATTLE_2F,          $30, $20 ; VOLT_ATTACK (novo - similar Quick Attack + electric)

	; === FAIRY TYPE ===
	db SFX_DOUBLESLAP,         $00, $80 ; DOUBLESLAP (mudou para Fairy!)
	db SFX_BATTLE_12,          $00, $80 ; FAIRY_WIND (novo - similar Gust)
	db SFX_BATTLE_24,          $20, $80 ; DRAINING_KISS (novo - similar Absorb)
	db SFX_BATTLE_28,          $20, $60 ; DAZE_GLEAM (novo - similar Aurora Beam, gleam)
	db SFX_BATTLE_26,          $10, $80 ; PLAY_ROUGH (novo - similar Strength, rough)
	db SFX_BATTLE_28,          $30, $a0 ; MOONBLAST (novo - similar Ice Beam, blast)

	; === FIGHTING TYPE ===
	db SFX_BATTLE_26,          $01, $60 ; SEISMIC_TOSS
	db SFX_BATTLE_23,          $00, $80 ; LOW_KICK
	db SFX_BATTLE_14,          $00, $80 ; BIND
	db SFX_BATTLE_0C,          $10, $80 ; KARATE_CHOP
	db SFX_BATTLE_17,          $f0, $40 ; DOUBLE_KICK
	db SFX_BATTLE_26,          $20, $40 ; STRENGTH
	db SFX_SUPER_EFFECTIVE,    $00, $a0 ; TAKE_DOWN
	db SFX_BATTLE_17,          $00, $80 ; JUMP_KICK
	db SFX_FAINT_FALL,         $ff, $04 ; DIZZY_PUNCH
	db SFX_BATTLE_21,          $10, $80 ; ROLLING_KICK
	db SFX_BATTLE_17,          $10, $a0 ; LEEK_STRIKE (novo - similar Jump Kick)
	db SFX_BATTLE_23,          $01, $c0 ; SUBMISSION
	db SFX_BATTLE_17,          $01, $e0 ; HI_JUMP_KICK

	; === FIRE TYPE ===
	db SFX_BATTLE_19,          $10, $a0 ; EMBER
	db SFX_BATTLE_19,          $20, $c0 ; FLAME_WHEEL (novo - similar Ember, stronger)
	db SFX_BATTLE_19,          $30, $e0 ; FLAME_BURST (novo - similar Flamethrower)
	db SFX_BATTLE_19,          $21, $e0 ; FLAMETHROWER
	db SFX_BATTLE_29,          $1f, $20 ; FIRE_BLAST
	db SFX_BATTLE_19,          $15, $c0 ; FLAME_CHARGE (novo - similar Flame Wheel)
	db SFX_BATTLE_34,          $10, $ff ; EXPLOSION (mudou para Fire!)

	; === FLYING TYPE ===
	db SFX_PECK,               $01, $a0 ; PECK
	db SFX_BATTLE_12,          $00, $c0 ; GUST
	db SFX_BATTLE_12,          $10, $a0 ; WING_ATTACK
	db SFX_BATTLE_2B,          $10, $80 ; AERIAL_ACE (novo - similar Swift)
	db SFX_NOT_VERY_EFFECTIVE, $20, $c0 ; FLY
	db SFX_BATTLE_13,          $20, $c0 ; HURRICANE (novo - similar Petal Dance, whirlwind)
	db SFX_BATTLE_25,          $48, $ff ; SKY_ATTACK
	db SFX_BATTLE_13,          $f0, $20 ; DRILL_PECK (signature)

	; === GAS TYPE ===
	db SFX_NOT_VERY_EFFECTIVE, $10, $ff ; SMOG
	db SFX_BATTLE_1C,          $00, $ff ; POISON_GAS
	db SFX_BATTLE_0F,          $f8, $10 ; HAZE (mudou para Gas!)

	; === GHOST TYPE ===
	db SFX_NOT_VERY_EFFECTIVE, $f0, $e0 ; NIGHT_SHADE
	db SFX_BATTLE_09,          $00, $40 ; LICK
	db SFX_BATTLE_09,          $10, $60 ; ASTONISH (novo - similar Lick)
	db SFX_BATTLE_2B,          $00, $80 ; SHADOW_PUNCH (novo - similar Swift, ghost)
	db SFX_BATTLE_24,          $10, $80 ; SPIRIT_DRAIN (novo - similar Absorb)
	db SFX_PSYCHIC_M,          $10, $80 ; SHADOW_BALL (novo - similar Psychic)
	db SFX_BATTLE_25,          $20, $10 ; SHADOW_SNEAK (novo - similar Quick Attack)
	db SFX_BATTLE_13,          $f1, $ff ; CONFUSE_RAY

	; === GRASS TYPE ===
	db SFX_BATTLE_24,          $00, $80 ; ABSORB
	db SFX_VINE_WHIP,          $01, $80 ; VINE_WHIP
	db SFX_BATTLE_24,          $40, $c0 ; MEGA_DRAIN
	db SFX_BATTLE_12,          $20, $e0 ; RAZOR_LEAF
	db SFX_BATTLE_24,          $60, $e0 ; GIGA_DRAIN (novo - similar Mega Drain, stronger)
	db SFX_BATTLE_13,          $14, $c0 ; PETAL_DANCE
	db SFX_BATTLE_2E,          $00, $80 ; SOLARBEAM
	db SFX_BATTLE_1B,          $03, $60 ; LEECH_SEED
	db SFX_BATTLE_1C,          $00, $80 ; POISONPOWDER
	db SFX_BATTLE_1C,          $11, $a0 ; STUN_SPORE
	db SFX_BATTLE_1C,          $01, $c0 ; SLEEP_POWDER
	db SFX_BATTLE_1C,          $01, $ff ; SPORE

	; === GROUND TYPE ===
	db SFX_BATTLE_20,          $00, $60 ; GROUND_STOMP (novo - similar Stomp)
	db SFX_BATTLE_2A,          $00, $60 ; MUD_SHOT (novo - similar Sludge)
	db SFX_BATTLE_29,          $00, $80 ; BULLDOZE (novo - similar Earthquake)
	db SFX_BATTLE_2A,          $10, $80 ; MUD_BOMB (novo - similar Sludge Bomb)
	db SFX_BATTLE_29,          $0f, $e0 ; EARTHQUAKE
	db SFX_BATTLE_29,          $11, $20 ; FISSURE
	db SFX_BATTLE_32,          $00, $80 ; BONE_CLUB
	db SFX_DAMAGE,             $10, $40 ; DIG

	; === ICE TYPE ===
	db SFX_BATTLE_28,          $00, $40 ; POWDER_SNOW (novo - similar Aurora Beam)
	db SFX_BATTLE_12,          $30, $80 ; ICY_WIND (novo - similar Gust, icy)
	db SFX_BATTLE_28,          $00, $80 ; AURORA_BEAM
	db SFX_BATTLE_28,          $20, $80 ; FROST_BREATH (novo - similar Ice Beam)
	db SFX_BATTLE_28,          $40, $80 ; ICE_BEAM
	db SFX_BATTLE_29,          $f0, $e0 ; BLIZZARD

	; === MAGMA TYPE ===
	db SFX_BATTLE_0D,          $20, $60 ; MAGMA_PUNCH (novo - similar Fire Punch)
	db SFX_BATTLE_29,          $20, $40 ; LAVA_PLUME (novo - similar Fire Blast)

	; === NORMAL TYPE ===
	db SFX_BATTLE_14,          $10, $60 ; WRAP
	db SFX_BATTLE_1E,          $01, $40 ; FURY_ATTACK
	db SFX_BATTLE_0B,          $01, $80 ; COMET_PUNCH
	db SFX_POUND,              $00, $80 ; POUND
	db SFX_DAMAGE,             $00, $80 ; SCRATCH
	db SFX_SUPER_EFFECTIVE,    $10, $a0 ; TACKLE
	db SFX_BATTLE_25,          $00, $10 ; QUICK_ATTACK
	db SFX_BATTLE_1E,          $00, $80 ; BITE
	db SFX_BATTLE_18,          $00, $80 ; HEADBUTT
	db SFX_BATTLE_1E,          $00, $60 ; HORN_ATTACK
	db SFX_NOT_VERY_EFFECTIVE, $01, $ff ; SLASH
	db SFX_BATTLE_0D,          $00, $40 ; MEGA_PUNCH
	db SFX_BATTLE_26,          $00, $60 ; CRUNCH (novo - similar Strength)
	db SFX_BATTLE_20,          $00, $c0 ; BODY_SLAM
	db SFX_BATTLE_1E,          $10, $80 ; HORN_CHARGE (novo - similar Horn Attack)
	db SFX_BATTLE_20,          $10, $e0 ; HEAVY_SLAM (novo - similar Body Slam, heavier)
	db SFX_SUPER_EFFECTIVE,    $20, $c0 ; DOUBLE_EDGE
	db SFX_BATTLE_25,          $10, $10 ; EXTREMESPEED (novo - similar Quick Attack)
	db SFX_BATTLE_26,          $f0, $ff ; SUPER_FANG
	db SFX_BATTLE_1E,          $12, $ff ; HYPER_FANG

	; === POISON TYPE ===
	db SFX_BATTLE_1B,          $00, $80 ; POISON_STING
	db SFX_BATTLE_2A,          $80, $c0 ; ACID
	db SFX_BATTLE_1B,          $10, $a0 ; POISON_FANG (novo - similar Poison Sting)
	db SFX_BATTLE_2A,          $20, $20 ; SLUDGE
	db SFX_BATTLE_2A,          $30, $40 ; SLUDGE_BOMB (novo - similar Sludge)
	db SFX_BATTLE_2A,          $40, $60 ; GUNK_SHOT (novo - similar Sludge Bomb)
	db SFX_BATTLE_0F,          $10, $c0 ; TOXIC
	db SFX_BATTLE_0F,          $20, $a0 ; NEUROTOXIN (novo - similar Toxic)
	db SFX_BATTLE_2A,          $10, $80 ; SLUDGE_WAVE (novo - similar Sludge)

	; === PSYCHIC_TYPE ===
	db SFX_BATTLE_0C,          $f0, $f0 ; PSYWAVE
	db SFX_BATTLE_14,          $00, $20 ; CONFUSION
	db SFX_BATTLE_14,          $10, $40 ; EXTRASENSORY (novo - similar Confusion)
	db SFX_PSYBEAM,            $00, $80 ; PSYBEAM
	db SFX_PSYCHIC_M,          $00, $80 ; PSYCHIC_M
	db SFX_PSYCHIC_M,          $20, $60 ; MIND_BREAK (novo - similar Psychic)
	db SFX_BATTLE_35,          $11, $18 ; HYPNOSIS

	; === ROCK TYPE ===
	db SFX_BATTLE_0D,          $10, $60 ; ROCK_PUNCH (novo - similar Fire Punch, rock)
	db SFX_BATTLE_14,          $01, $e0 ; ROCK_THROW
	db SFX_BATTLE_29,          $10, $60 ; ROCK_TOMB (novo - similar Earthquake)
	db SFX_BATTLE_36,          $f0, $20 ; ROCK_SLIDE
	db SFX_NOT_VERY_EFFECTIVE, $10, $40 ; STONE_EDGE (novo - similar Cut, sharp)
	db SFX_BATTLE_0F,          $1f, $ff ; CLAMP
	db SFX_BATTLE_2B,          $f0, $60 ; BONEMERANG
	db SFX_SUPER_EFFECTIVE,    $f0, $ff ; CRABHAMMER
	db SFX_HORN_DRILL,         $00, $a0 ; HORN_DRILL (mudou para Rock!)

	; === STEEL TYPE ===
	db SFX_NOT_VERY_EFFECTIVE, $00, $a0 ; CUT (mudou para Steel!)
	db SFX_BATTLE_26,          $10, $60 ; IRON_TAIL (novo - similar Strength)
	db SFX_BATTLE_18,          $10, $80 ; IRON_HEAD (novo - similar Headbutt)
	db SFX_BATTLE_2B,          $20, $80 ; MAGNET_BOMB (novo - similar Swift)
	db SFX_BATTLE_27,          $00, $80 ; SONICBOOM (mudou para Steel!)
	db SFX_BATTLE_25,          $00, $20 ; BULLET_PUNCH (novo - similar Quick Attack)

	; === WATER TYPE ===
	db SFX_BATTLE_24,          $20, $60 ; WATER_GUN
	db SFX_BATTLE_2A,          $f0, $60 ; BUBBLEBEAM
	db SFX_BATTLE_24,          $30, $80 ; WATER_PULSE (novo - similar Water Gun)
	db SFX_BATTLE_25,          $2f, $80 ; WATERFALL
	db SFX_BATTLE_2C,          $00, $80 ; SURF
	db SFX_BATTLE_2A,          $00, $80 ; HYDRO_PUMP
	db SFX_BATTLE_25,          $30, $20 ; AQUA_JET (novo - similar Quick Attack + water)

	; === BIRD TYPE ===
	db SFX_BATTLE_29,          $f8, $ff ; TRI_ATTACK (mudou para Bird!)
	db SFX_NOT_VERY_EFFECTIVE, $10, $c0 ; SWORDS_DANCE
	db SFX_BATTLE_31,          $80, $04 ; SHARPEN
	db SFX_BATTLE_0B,          $10, $c0 ; HOWL (novo - similar Growl)
	db SFX_NOT_VERY_EFFECTIVE, $20, $a0 ; HONE_CLAWS (novo - similar Cut)
	db SFX_BATTLE_09,          $30, $c0 ; WORK_UP (novo - similar Meditate)
	db SFX_BATTLE_0D,          $f0, $ff ; ACID_ARMOR
	db SFX_BATTLE_14,          $11, $20 ; HARDEN
	db SFX_BATTLE_14,          $33, $30 ; WITHDRAW
	db SFX_BATTLE_32,          $40, $c0 ; DEFENSE_CURL
	db SFX_BATTLE_14,          $44, $40 ; AQUA_VEIL (novo - similar Withdraw)
	db SFX_BATTLE_25,          $20, $e0 ; CALM_MIND (novo - similar Growth)
	db SFX_BATTLE_25,          $30, $e0 ; NASTY_PLOT (novo - similar Growth)
	db SFX_BATTLE_25,          $40, $e0 ; AROMATIC_MIST (novo - similar Growth)
	db SFX_BATTLE_25,          $11, $e0 ; GROWTH
	db SFX_BATTLE_09,          $f8, $10 ; AMNESIA
	db SFX_FAINT_FALL,         $20, $c0 ; AGILITY
	db SFX_FAINT_FALL,         $30, $c0 ; TAILWIND (novo - similar Agility)
	db SFX_FAINT_FALL,         $40, $c0 ; ROCK_POLISH (novo - similar Agility)
	db SFX_FAINT_FALL,         $50, $c0 ; QUIVER_DANCE (novo - similar Agility)
	db SFX_BATTLE_14,          $22, $10 ; MINIMIZE
	db SFX_BATTLE_33,          $80, $40 ; DOUBLE_TEAM
	db SFX_BATTLE_33,          $f0, $c0 ; TELEPORT
	db SFX_BATTLE_0B,          $20, $c0 ; CHARM (novo - similar Growl)
	db SFX_BATTLE_0B,          $30, $c0 ; INTIMIDATE (novo - similar Growl)
	db SFX_BATTLE_0B,          $40, $c0 ; NOBLE_ROAR (novo - similar Growl)
	db SFX_BATTLE_31,          $ff, $40 ; LEER
	db SFX_BATTLE_0B,          $00, $c0 ; GROWL
	db SFX_BATTLE_12,          $40, $80 ; FEATHER_DANCE (novo - similar Gust)
	db SFX_BATTLE_31,          $10, $80 ; TAUNT (novo - similar Screech)
	db SFX_BATTLE_2A,          $90, $c0 ; CORRODE (novo - similar Acid)
	db SFX_BATTLE_21,          $00, $80 ; TAIL_WHIP
	db SFX_BATTLE_21,          $10, $80 ; TICKLE (novo - similar Tail Whip)
	db SFX_BATTLE_2A,          $10, $40 ; DECAY (novo - similar Acid)
	db SFX_BATTLE_35,          $20, $40 ; FAKE_TEARS (novo - similar Sing)
	db SFX_BATTLE_31,          $20, $80 ; METAL_SOUND (novo - similar Screech)
	db SFX_BATTLE_31,          $00, $80 ; SCREECH
	db SFX_BATTLE_2F,          $40, $60 ; EERIE_IMPULSE (novo - similar Thunder Wave)
	db SFX_BATTLE_09,          $10, $40 ; CONFIDE (novo - similar Mimic)
	db SFX_BATTLE_31,          $30, $80 ; SCARY_FACE (novo - similar Screech)
	db SFX_PSYCHIC_M,          $30, $80 ; PSYCHIC_BIND (novo - similar Psychic)
	db SFX_BATTLE_2A,          $50, $80 ; SLUDGE_TRAP (novo - similar Sludge)
	db SFX_BATTLE_1C,          $20, $c0 ; SWEET_SCENT (novo - similar Spore)
	db SFX_BATTLE_14,          $20, $80 ; HINDER (novo - similar Bind)
	db SFX_BATTLE_1B,          $02, $a0 ; STRING_SHOT
	db SFX_BATTLE_1B,          $f1, $ff ; SMOKESCREEN
	db SFX_BATTLE_1B,          $01, $a0 ; SAND_ATTACK
	db SFX_BATTLE_13,          $f8, $ff ; FLASH
	db SFX_BATTLE_35,          $00, $80 ; SING
	db SFX_BATTLE_27,          $40, $60 ; SUPERSONIC
	db SFX_BATTLE_27,          $ff, $40 ; DISABLE
	db SFX_NOT_VERY_EFFECTIVE, $09, $ff ; GLARE
	db SFX_BATTLE_09,          $88, $10 ; LOVELY_KISS
	db SFX_BATTLE_33,          $00, $80 ; RECOVER
	db SFX_BATTLE_33,          $10, $80 ; MOONLIGHT (novo - similar Recover)
	db SFX_BATTLE_21,          $12, $10 ; REST
	db SFX_BATTLE_32,          $08, $40 ; SOFTBOILED
	db SFX_BATTLE_0E,          $f0, $10 ; LIGHT_SCREEN
	db SFX_NOT_VERY_EFFECTIVE, $f0, $10 ; REFLECT
	db SFX_BATTLE_09,          $f0, $40 ; MIMIC
	db SFX_BATTLE_09,          $f2, $20 ; MIRROR_MOVE
	db SFX_BATTLE_25,          $00, $80 ; FOCUS_ENERGY
	db SFX_BATTLE_18,          $00, $c0 ; BIDE
	db SFX_BATTLE_2C,          $d8, $04 ; SUBSTITUTE
	db SFX_FAINT_FALL,         $ff, $ff ; TRANSFORM
	db SFX_BATTLE_0F,          $08, $10 ; SPLASH
	db SFX_BATTLE_32,          $c0, $ff ; METRONOME
	db SFX_BATTLE_0B,          $00, $80 ; STRUGGLE

	assert_table_length NUM_ATTACKS
	db SFX_BATTLE_0B,          $00, $80
