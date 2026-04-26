; v0.7 review pass: ~25 SFX assignments retuned. Most fixes are obvious
; mismatches (WATER_GUN was using drain, SPLASH was using slash, REST was
; using whip, etc.) that survived the v0.5 placeholder pass + v0.7 port.
; Comments inline mark each `; v0.7 reviewed` row. Power-tier moves also
; get pitch tweaks for heavier feel where the visual got more dramatic.

MoveSoundTable:
	table_width 3, MoveSoundTable
	; ID, pitch mod, tempo mod

; === BUG ===
	db SFX_BATTLE_14,          $0f, $80 ; CONSTRICT
	db SFX_BATTLE_1E,          $00, $80 ; BUG_BITE
	db SFX_BATTLE_24,          $00, $80 ; LEECH_LIFE
	db SFX_PSYBEAM,            $10, $80 ; BUG_BUZZ
	db SFX_BATTLE_1E,          $20, $60 ; MEGAHORN
	db SFX_BATTLE_0F,          $00, $80 ; GUILLOTINE
	db SFX_BATTLE_0F,          $20, $40 ; VICEGRIP
	db SFX_BATTLE_1B,          $20, $c0 ; TWINEEDLE
; === DARK ===
	db SFX_BATTLE_2B,          $00, $80 ; FAINT_ATTACK
	db SFX_BATTLE_26,          $f0, $20 ; RAGE
	db SFX_BATTLE_0F,          $f0, $ff ; NIGHT_SLASH ; v0.7 reviewed: was NOT_VERY_EFFECTIVE (the "tink" miss sound — wrong for a connecting slash). Sharp cut at low pitch reads as a dark slashing strike.
	db SFX_BATTLE_22,          $00, $80 ; BRUTAL_SWING
	db SFX_PSYCHIC_M,          $20, $80 ; DARK_PULSE
	db SFX_BATTLE_1E,          $30, $80 ; GORE_ATTACK
	db SFX_SILPH_SCOPE,        $00, $ff ; PAY_DAY
	db SFX_BATTLE_35,          $42, $01 ; DREAM_EATER
	db SFX_BATTLE_31,          $09, $ff ; GLARE ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; eye-piercing tone fits the predatory stare that paralyzes.
	db SFX_BATTLE_35,          $00, $60 ; DEEP_SLEEP
; === DRAGON ===
	db SFX_BATTLE_29,          $f0, $80 ; DRAGON_RAGE
	db SFX_BATTLE_0F,          $f0, $a0 ; DRAGON_CLAW ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; deep cut SFX matches a draconic raking slash.
	db SFX_BATTLE_19,          $f0, $40 ; DRAGON_BREATH ; v0.7 reviewed: was BATTLE_29 (boom); fire breath sound at low pitch reads as exhaled flame, not explosion.
	db SFX_BATTLE_22,          $20, $a0 ; DRAGON_SLAM
	db SFX_BATTLE_22,          $30, $c0 ; OUTRAGE
	db SFX_BATTLE_36,          $00, $80 ; HYPER_BEAM
; === ELECTRIC ===
	db SFX_BATTLE_2F,          $00, $40 ; NUZZLE
	db SFX_BATTLE_2F,          $00, $20 ; THUNDERSHOCK
	db SFX_BATTLE_2F,          $10, $60 ; DISCHARGE
	db SFX_BATTLE_2F,          $20, $80 ; THUNDERBOLT
	db SFX_BATTLE_29,          $f0, $40 ; THUNDER ; v0.7 reviewed: was BATTLE_26; deep boom at low pitch sells the 115 BP thunder strike better than the generic crash.
	db SFX_BATTLE_2E,          $12, $60 ; THUNDER_WAVE
	db SFX_BATTLE_2F,          $30, $20 ; VOLT_TACKLE
; === FAIRY ===
	db SFX_DOUBLESLAP,         $00, $80 ; DOUBLESLAP
	db SFX_BATTLE_12,          $00, $80 ; FAIRY_WIND
	db SFX_BATTLE_24,          $20, $80 ; DRAINING_KISS
	db SFX_BATTLE_28,          $20, $60 ; DAZZLE_GLEAM
	db SFX_BATTLE_26,          $10, $80 ; PLAY_ROUGH
	db SFX_BATTLE_28,          $f8, $40 ; MOONBLAST ; v0.7 reviewed: lowered pitch ($30→$f8 ~ -2 oct) + slower tempo for 180 BP charge weight.
	db SFX_BATTLE_09,          $88, $10 ; LOVELY_KISS
	db SFX_BATTLE_35,          $00, $80 ; SING
; === FIGHTING ===
	db SFX_BATTLE_26,          $01, $60 ; SEISMIC_TOSS
	db SFX_BATTLE_0C,          $01, $80 ; COMET_PUNCH ; v0.7 reviewed: was BATTLE_0B (cry); proper punch sound for a punch.
	db SFX_BATTLE_23,          $00, $80 ; LOW_KICK
	db SFX_BATTLE_14,          $00, $80 ; BIND
	db SFX_BATTLE_0C,          $20, $40 ; MACH_PUNCH
	db SFX_BATTLE_0C,          $10, $80 ; KARATE_CHOP
	db SFX_BATTLE_17,          $f0, $40 ; DOUBLE_KICK
	db SFX_BATTLE_26,          $20, $40 ; STRENGTH
	db SFX_BATTLE_18,          $00, $a0 ; TAKE_DOWN ; v0.7 reviewed: was SUPER_EFFECTIVE (clean BAM); heavy thud reads as the body-mass tackle that lowers user's def.
	db SFX_BATTLE_17,          $10, $a0 ; LEEK_STRIKE
	db SFX_BATTLE_09,          $ff, $04 ; DIZZY_PUNCH ; v0.7 reviewed: was FAINT_FALL; high-pitch sparkle reads as the dizzy/woozy effect.
	db SFX_BATTLE_17,          $10, $80 ; ROLLING_KICK ; v0.7 reviewed: was BATTLE_21 (whip); proper kick SFX matches the visual + DOUBLE_KICK family.
	db SFX_BATTLE_23,          $01, $c0 ; SUBMISSION
	db SFX_BATTLE_0C,          $00, $a0 ; SKY_UPPERCUT
	db SFX_BATTLE_17,          $01, $e0 ; HI_JUMP_KICK
; === FIRE ===
	db SFX_BATTLE_19,          $10, $a0 ; EMBER
	db SFX_BATTLE_19,          $15, $c0 ; FLAME_CHARGE
	db SFX_BATTLE_19,          $30, $e0 ; FLAME_BURST
	db SFX_BATTLE_19,          $21, $e0 ; FLAMETHROWER
	db SFX_BATTLE_29,          $1f, $20 ; FIRE_BLAST
	db SFX_BATTLE_19,          $00, $80 ; IGNITE
	db SFX_BATTLE_34,          $f0, $ff ; EXPLOSION ; v0.7 reviewed: lower pitch ($10→$f0) for catastrophic 200 BP feel matching the new multi-burst anim.
; === FLYING ===
	db SFX_PECK,               $01, $a0 ; PECK
	db SFX_BATTLE_12,          $00, $c0 ; GUST
	db SFX_BATTLE_12,          $10, $a0 ; WING_ATTACK
	db SFX_BATTLE_2B,          $10, $80 ; AERIAL_ACE
	db SFX_BATTLE_12,          $20, $c0 ; FLY ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; wind whoosh fits the dive much better than a "tink".
	db SFX_BATTLE_13,          $20, $c0 ; HURRICANE
	db SFX_BATTLE_2B,          $48, $ff ; SKY_ATTACK ; v0.7 reviewed: was BATTLE_25 (dash); deep whoosh sells the dive-bomb on the new charge anim.
	db SFX_BATTLE_13,          $f0, $20 ; DRILL_PECK
; === FUNGUS ===
	db SFX_BATTLE_1C,          $11, $a0 ; SPORE_DAZE
	db SFX_BATTLE_24,          $40, $80 ; PARASITE
	db SFX_BATTLE_1C,          $01, $ff ; SPORE
; === GAS ===
	db SFX_BATTLE_2A,          $10, $ff ; SMOG ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; sludge-like wheeze fits the cloud-toss visual.
	db SFX_BATTLE_1C,          $00, $ff ; POISON_GAS
	db SFX_BATTLE_0F,          $f8, $10 ; HAZE
; === GHOST ===
	db SFX_BATTLE_24,          $f0, $80 ; NIGHT_SHADE ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; drain SFX deep-pitched fits the spectral life-leech feel.
	db SFX_BATTLE_09,          $00, $40 ; LICK
	db SFX_BATTLE_09,          $10, $60 ; ASTONISH
	db SFX_BATTLE_25,          $20, $10 ; SHADOW_SNEAK
	db SFX_BATTLE_2B,          $00, $80 ; SHADOW_PUNCH
	db SFX_BATTLE_24,          $10, $80 ; SPIRIT_DRAIN
	db SFX_PSYCHIC_M,          $10, $80 ; SHADOW_BALL
	db SFX_BATTLE_13,          $f1, $ff ; CONFUSE_RAY
	db SFX_BATTLE_19,          $40, $a0 ; WILL_O_WISP
; === GRASS ===
	db SFX_BATTLE_24,          $00, $80 ; ABSORB
	db SFX_VINE_WHIP,          $01, $80 ; VINE_WHIP
	db SFX_BATTLE_24,          $40, $c0 ; MEGA_DRAIN
	db SFX_BATTLE_12,          $20, $e0 ; RAZOR_LEAF
	db SFX_BATTLE_24,          $60, $e0 ; GIGA_DRAIN
	db SFX_BATTLE_13,          $14, $c0 ; PETAL_DANCE
	db SFX_BATTLE_2E,          $00, $80 ; SOLARBEAM
	db SFX_BATTLE_1B,          $03, $60 ; LEECH_SEED
	db SFX_BATTLE_1C,          $00, $80 ; POISONPOWDER
	db SFX_BATTLE_1C,          $11, $a0 ; STUN_SPORE
	db SFX_BATTLE_1C,          $01, $c0 ; SLEEP_POWDER
; === GROUND ===
	db SFX_BATTLE_20,          $00, $60 ; GROUND_STOMP
	db SFX_BATTLE_2A,          $00, $60 ; MUD_SHOT
	db SFX_BATTLE_29,          $00, $80 ; BULLDOZE
	db SFX_BATTLE_2A,          $10, $80 ; MUD_BOMB
	db SFX_BATTLE_29,          $0f, $e0 ; EARTHQUAKE
	db SFX_BATTLE_29,          $11, $20 ; FISSURE
	db SFX_BATTLE_18,          $00, $80 ; BONE_CLUB ; v0.7 reviewed: was BATTLE_32 (squeak); thud SFX fits the club-bashing visual.
	db SFX_BATTLE_29,          $f0, $40 ; DIG ; v0.7 reviewed: was DAMAGE (generic hit); deep boom for the underground emergence.
; === ICE ===
	db SFX_BATTLE_28,          $00, $40 ; POWDER_SNOW
	db SFX_BATTLE_12,          $30, $80 ; ICY_WIND
	db SFX_BATTLE_28,          $00, $80 ; AURORA_BEAM
	db SFX_BATTLE_28,          $20, $80 ; FROST_BREATH
	db SFX_BATTLE_28,          $40, $80 ; ICE_BEAM
	db SFX_BATTLE_29,          $f8, $ff ; BLIZZARD ; v0.7 reviewed: deeper pitch + longer tempo for 115 BP storm fury (matches new tornado intro in anim).
; === MAGMA ===
	db SFX_BATTLE_0D,          $20, $60 ; MAGMA_PUNCH
	db SFX_BATTLE_29,          $20, $40 ; LAVA_PLUME
; === NORMAL ===
	db SFX_BATTLE_14,          $10, $60 ; WRAP
	db SFX_BATTLE_1E,          $01, $40 ; FURY_ATTACK
	db SFX_DAMAGE,             $00, $80 ; SCRATCH
	db SFX_SUPER_EFFECTIVE,    $10, $a0 ; TACKLE
	db SFX_BATTLE_1E,          $00, $80 ; BITE
	db SFX_BATTLE_25,          $00, $10 ; QUICK_ATTACK
	db SFX_BATTLE_18,          $00, $80 ; HEADBUTT
	db SFX_BATTLE_1E,          $00, $60 ; HORN_ATTACK
	db SFX_BATTLE_0F,          $01, $ff ; SLASH ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; sharp cut SFX matches the actual slashing visual.
	db SFX_BATTLE_20,          $00, $c0 ; BODY_SLAM
	db SFX_BATTLE_1E,          $f8, $60 ; CRUNCH ; v0.7 reviewed: was BATTLE_26 (generic crash); deep bite SFX matches "crunching" with jaws.
	db SFX_BATTLE_1E,          $10, $80 ; HORN_CHARGE
	db SFX_BATTLE_22,          $11, $c0 ; THRASH
	db SFX_BATTLE_20,          $10, $e0 ; HEAVY_SLAM
	db SFX_SUPER_EFFECTIVE,    $20, $c0 ; DOUBLE_EDGE
	db SFX_BATTLE_25,          $10, $10 ; EXTREMESPEED
	db SFX_BATTLE_27,          $40, $60 ; SUPERSONIC
	db SFX_BATTLE_1E,          $f8, $ff ; SUPER_FANG ; v0.7 reviewed: was BATTLE_26 (heavy crash); proper bite SFX deep-pitched fits "fang" name + 50%-HP mechanic.
	db SFX_BATTLE_1E,          $12, $ff ; HYPER_FANG
; === POISON ===
	db SFX_BATTLE_1B,          $00, $80 ; POISON_STING
	db SFX_BATTLE_1B,          $10, $a0 ; POISON_FANG
	db SFX_BATTLE_1B,          $20, $80 ; TOXIC_FANGS
	db SFX_BATTLE_2A,          $80, $c0 ; ACID
	db SFX_BATTLE_2A,          $20, $20 ; SLUDGE
	db SFX_BATTLE_2A,          $10, $80 ; SLUDGE_WAVE
	db SFX_BATTLE_2A,          $40, $60 ; GUNK_SHOT
	db SFX_BATTLE_2F,          $20, $a0 ; NEUROTOXIN ; v0.7 reviewed: was BATTLE_0F (cut); electric-crackle SFX fits the neuro-paralysis theme that the new lightning-ball anim ends on.
	db SFX_BATTLE_2A,          $10, $c0 ; TOXIC ; v0.7 reviewed: was BATTLE_0F (cut); sludge SFX matches the BLOB_DRIP anim and the badly-poisoned theme.
; === PSYCHIC ===
	db SFX_PSYBEAM,            $f0, $f0 ; PSYWAVE ; v0.7 reviewed: was BATTLE_0C (punch); psybeam SFX deep-pitched is the wave-reverb feel the name calls for.
	db SFX_BATTLE_14,          $00, $20 ; CONFUSION
	db SFX_BATTLE_14,          $10, $40 ; EXTRASENSORY
	db SFX_PSYBEAM,            $00, $80 ; PSYBEAM
	db SFX_PSYCHIC_M,          $00, $80 ; PSYCHIC_M
	db SFX_PSYCHIC_M,          $20, $60 ; MIND_BREAK
	db SFX_BATTLE_27,          $ff, $40 ; DISABLE
	db SFX_BATTLE_35,          $11, $18 ; HYPNOSIS
; === ROCK ===
	db SFX_BATTLE_36,          $01, $e0 ; ROCK_THROW ; v0.7 reviewed: was BATTLE_14 (squeeze); proper rock-thud SFX matches the falling-rocks anim.
	db SFX_BATTLE_0D,          $10, $60 ; ROCK_PUNCH
	db SFX_BATTLE_29,          $10, $60 ; ROCK_TOMB
	db SFX_BATTLE_18,          $20, $a0 ; HEAD_SMASH
	db SFX_BATTLE_36,          $f0, $20 ; ROCK_SLIDE
	db SFX_BATTLE_0F,          $1f, $ff ; CLAMP
	db SFX_BATTLE_2B,          $f0, $60 ; BONEMERANG
	db SFX_BATTLE_22,          $f0, $ff ; CRABHAMMER ; v0.7 reviewed: was SUPER_EFFECTIVE (clean BAM); slam SFX deep-pitched fits the high-crit hammer-down strike.
	db SFX_HORN_DRILL,         $00, $a0 ; HORN_DRILL
; === STEEL ===
	db SFX_BATTLE_0F,          $10, $a0 ; CUT ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; sharp metallic cut SFX matches a STEEL-type slashing strike.
	db SFX_BATTLE_26,          $10, $60 ; IRON_TAIL
	db SFX_BATTLE_18,          $10, $80 ; IRON_HEAD
	db SFX_BATTLE_27,          $00, $80 ; SONICBOOM
	db SFX_BATTLE_25,          $00, $20 ; BULLET_PUNCH
	db SFX_BATTLE_2B,          $20, $80 ; MAGNET_BOMB
; === WATER ===
	db SFX_BATTLE_2A,          $20, $60 ; WATER_GUN ; v0.7 reviewed: was BATTLE_24 (DRAIN!); spray SFX, not absorb-suction. Same family as BUBBLEBEAM/HYDRO_PUMP now.
	db SFX_BATTLE_25,          $30, $20 ; AQUA_JET
	db SFX_BATTLE_2A,          $f0, $60 ; BUBBLEBEAM
	db SFX_BATTLE_27,          $30, $80 ; WATER_PULSE ; v0.7 reviewed: was BATTLE_24 (drain); sonic-pulse SFX literally fits "PULSE" in the name.
	db SFX_BATTLE_25,          $2f, $80 ; WATERFALL
	db SFX_BATTLE_2C,          $00, $80 ; SURF
	db SFX_BATTLE_2A,          $00, $80 ; HYDRO_PUMP
; === BIRD (typeless) ===
	db SFX_BATTLE_29,          $f8, $ff ; TRI_ATTACK
	db SFX_NOT_VERY_EFFECTIVE, $10, $c0 ; SWORDS_DANCE
	db SFX_BATTLE_09,          $35, $c0 ; BULK_UP
	db SFX_BATTLE_14,          $15, $80 ; COIL
	db SFX_BATTLE_0B,          $10, $a0 ; FIERCE_ROAR
	db SFX_BATTLE_0F,          $20, $a0 ; HONE_CLAWS ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; cut SFX at high pitch reads as claw-on-claw sharpening.
	db SFX_BATTLE_32,          $40, $c0 ; DEFENSE_CURL
	db SFX_BATTLE_14,          $11, $20 ; HARDEN
	db SFX_BATTLE_14,          $33, $30 ; WITHDRAW
	db SFX_BATTLE_25,          $11, $e0 ; GROWTH
	db SFX_BATTLE_25,          $20, $e0 ; CALM_MIND
	db SFX_BATTLE_25,          $30, $e0 ; NASTY_PLOT
	db SFX_BATTLE_09,          $f8, $10 ; AMNESIA
	db SFX_BATTLE_09,          $50, $c0 ; QUIVER_DANCE ; v0.7 reviewed: was FAINT_FALL; sparkly tone fits the fluttery dance.
	db SFX_BATTLE_12,          $30, $c0 ; TAILWIND ; v0.7 reviewed: was FAINT_FALL; literal wind SFX matches the tornado anim.
	db SFX_BATTLE_25,          $20, $c0 ; AGILITY ; v0.7 reviewed: was FAINT_FALL; dash/zoom SFX fits the speed-shake anim.
	db SFX_BATTLE_33,          $80, $40 ; DOUBLE_TEAM
	db SFX_BATTLE_33,          $f0, $c0 ; TELEPORT
	db SFX_BATTLE_09,          $20, $c0 ; CHARM ; v0.7 reviewed: was BATTLE_0B (growl-like); sparkle-tone SFX matches the heart-music visual.
	db SFX_BATTLE_0B,          $30, $c0 ; INTIMIDATE
	db SFX_BATTLE_0B,          $00, $c0 ; GROWL
	db SFX_BATTLE_31,          $ff, $40 ; LEER
	db SFX_BATTLE_2A,          $90, $c0 ; CORRODE
	db SFX_BATTLE_31,          $10, $80 ; TAUNT
	db SFX_BATTLE_21,          $10, $80 ; TICKLE
	db SFX_BATTLE_21,          $00, $80 ; TAIL_WHIP
	db SFX_BATTLE_35,          $20, $40 ; FAKE_TEARS
	db SFX_BATTLE_31,          $20, $80 ; METAL_SOUND
	db SFX_BATTLE_31,          $00, $80 ; SCREECH
	db SFX_BATTLE_2F,          $40, $60 ; EERIE_IMPULSE
	db SFX_BATTLE_31,          $30, $80 ; SCARY_FACE
	db SFX_BATTLE_14,          $20, $80 ; HINDER
	db SFX_BATTLE_1B,          $02, $a0 ; STRING_SHOT ; v0.7: was ENTANGLE (-2 spd custom). Restored canon STRING_SHOT (-1 spd, 30 PP).
	db SFX_PSYCHIC_M,          $30, $80 ; PSYCHIC_BIND
	db SFX_BATTLE_13,          $f8, $ff ; FLASH
	db SFX_BATTLE_1B,          $01, $a0 ; SAND_ATTACK
	db SFX_BATTLE_1B,          $f1, $ff ; SMOKESCREEN
	db SFX_BATTLE_33,          $00, $80 ; RECOVER
	db SFX_BATTLE_35,          $12, $10 ; REST ; v0.7 reviewed: was BATTLE_21 (whip!); sleep SFX matches the move literally putting the user to sleep.
	db SFX_BATTLE_32,          $08, $40 ; SOFTBOILED
	db SFX_BATTLE_0E,          $f0, $10 ; LIGHT_SCREEN
	db SFX_BATTLE_0E,          $00, $10 ; REFLECT ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; same SFX as LIGHT_SCREEN with higher pitch — they're a pair, should sound related.
	db SFX_BATTLE_18,          $00, $c0 ; BIDE
	db SFX_BATTLE_25,          $00, $80 ; FOCUS_ENERGY
	db SFX_BATTLE_09,          $f0, $40 ; MIMIC
	db SFX_BATTLE_09,          $f2, $20 ; MIRROR_MOVE
	db SFX_BATTLE_33,          $d8, $04 ; SUBSTITUTE ; v0.7 reviewed: was BATTLE_2C (water!); poof SFX matches the smoke-and-puppet visual.
	db SFX_BATTLE_09,          $ff, $ff ; TRANSFORM ; v0.7 reviewed: was FAINT_FALL; sparkle for the morph effect, same family as DITTO's identity move.
	db SFX_BATTLE_2C,          $08, $10 ; SPLASH ; v0.7 reviewed: was BATTLE_0F (cut!); literal water-splash SFX. The move is doing nothing, but at least the sound matches the name.
	db SFX_BATTLE_32,          $c0, $ff ; METRONOME
	db SFX_BATTLE_0B,          $00, $80 ; STRUGGLE
	assert_table_length NUM_ATTACKS
