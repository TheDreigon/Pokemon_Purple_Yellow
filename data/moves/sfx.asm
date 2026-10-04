; MoveSoundTable: one `db <SFX>, <pitch byte>, <tempo byte>` row per move, in
; move-id order (constants/move_constants.asm). GetMoveSound (engine/battle/
; animations.asm) reads a row whenever an animation script's battle_anim names
; that move as its SOUND (the first argument) -- so a move's own row is only
; ever heard if some script names it. 16 rows are named by no script at all,
; and the LEECH_SEED row is named by 25 scripts: changing a row changes every
; animation that borrows it. `.claude/sfx_model_audit.py --table` lists who
; reads what.
;
; HOW THE TWO BYTES REALLY WORK (measured 2026-08-21/22 in audio/engine_1.asm;
; invariant 172; guard: .claude/sfx_model_audit.py). For months the comments
; below said "$f0 ~ -1 octave". That is false. The pitch add is UNSIGNED, and
; it means a different thing on each kind of channel:
;
;   PITCH on a tone channel (Ch5/Ch6): added, unsigned and 11-bit, to every
;     note's frequency register (Audio1_ApplyFrequencyModifier). Because
;     f = 131072 / (2048 - x), a BIGGER byte is always HIGHER: $10 on a ~1800
;     note is about +1 semitone, $f0 is one to two octaves up. There is no
;     byte that makes a tone channel deeper -- except by accident: when
;     note + byte passes 2047 the register wraps and that note FOLDS to
;     ~64 Hz. If only some of an SFX's notes fold, the chord breaks in two
;     (the guard calls this partial-wrap; it is never what anyone wanted).
;   PITCH on the noise channel (Ch8): added mod 256 to NR43, whose high
;     nibble is the LFSR shift clock. Here a BIGGER byte is LOWER: one octave
;     per $10. So $f0 (= -$10 mod 256) is one octave UP, $10 is one octave
;     DOWN. Bit 3 of NR43 is the LFSR width: a byte that flips it turns white
;     noise into a metallic buzz. Shift clock 14 or 15 is silence.
;   TEMPO: Audio1_SetSfxTempo makes the tone channels' notes last
;     ($80 + byte) / 256 as long -- $80 = 1.0x, $ff = 1.5x, $00 = 0.5x. The
;     noise channel SKIPS it (Audio1_note_length: `cp CHAN8 / jr z, .skip`).
;     On a noise-only SFX the byte does nothing at all. Those rows are kept
;     at $80 (normalised 2026-08-22; the old value is noted on the row) so
;     that every tempo byte that is not $80 is one that actually does
;     something.
;
; Put together: the same $f0 pushes a tone layer up a few semitones AND the
; noise layer up a whole octave, and never touches the length of a noise-only
; SFX. That is the mechanism behind the short, shrill, odd-sounding results.
;
; The tuning rule (2026-08-21): within a family, the stronger move should
; sound deeper and fuller -- GUNK SHOT below ACID, THUNDER below
; THUNDERSHOCK. Deeper means a SMALLER pitch byte on a tone SFX (and never
; past the fold) and a BIGGER one on a noise SFX. Rows tagged MEASURED record
; what their bytes do; "Anim pass #N" rows record the intended effect, and
; those still stand -- the bytes under them were chosen against the wrong
; model.
;
; GROWL is the one structural exception: IsCryMove plays the species' own cry
; and ADDS this row's two bytes to the cry's modifiers; its SFX id is ignored.
;
; v0.7 review pass (earlier): ~25 SFX assignments retuned for obvious
; mismatches (WATER_GUN was using drain, SPLASH was using slash, REST was
; using whip, etc.). Rows marked `; v0.7 reviewed`.

MoveSoundTable:
	table_width 3, MoveSoundTable
	; ID, pitch mod, tempo mod

; === BUG ===
	db SFX_BATTLE_14,          $0f, $80 ; CONSTRICT
	db SFX_BATTLE_1E,          $00, $80 ; BUG_BITE
	db SFX_BATTLE_24,          $00, $80 ; LEECH_LIFE
	db SFX_PSYBEAM,            $10, $80 ; BUG_BUZZ
	db SFX_BATTLE_1E,            $20, $c0 ; MEGAHORN ; 2026-08-22 (anim pass #2): a longer sound -- MEASURED: tone +0 st; noise 2 oct DOWN; tempo 1.25x
	db SFX_BATTLE_29,            $20, $ff ; GUILLOTINE ; 2026-08-22 (anim pass #3): a much slower, deeper sound -- MEASURED: tone +0 st; noise 2 oct DOWN; tempo 1.50x
	db SFX_BATTLE_0F,          $20, $80 ; VICEGRIP ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $20, $80 ; TWINEEDLE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === DARK ===
	db SFX_BATTLE_25,          $f0, $80 ; FAINT_ATTACK ; Anim pass #3: was BATTLE_2B (whoosh — sounded too much like a FLYING move). Dash SFX deep-pitched reads as a sneaky deceptive lunge instead of a bird swooping. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_26,          $f0, $80 ; RAGE ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0E,            $20, $80 ; NIGHT_SLASH ; Anim pass #4: the previous BATTLE_0F (sharp cut) sounded odd, neither scary nor cool. Dark whoosh deep-pitched reads as the sinister night-strike. -- 2026-08-22 (anim pass #4): it sounded like GUST; a SCRATCH with a stronger sound -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_26,            $30, $80 ; BRUTAL_SWING ; Anim pass #5: deeper pitch ($00→$f8 ~ -1 oct) for grave/heavy feel. -- 2026-08-22 (anim pass #5): an entirely new sound, the old one a keyboard-synth tone (= the $f8 LFSR width flip) -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_PSYCHIC_M,          $20, $80 ; DARK_PULSE
	db SFX_BATTLE_1E,          $f0, $a0 ; GORE_ATTACK ; Anim pass #6: deeper pitch + longer tempo for the brutal goring impact (paired with the reworked anim). -- MEASURED: tone +3 st; noise 1 oct UP; tempo 1.12x; OPPOSITE OF INTENT (went UP)
	db SFX_SILPH_SCOPE,        $00, $ff ; PAY_DAY
	db SFX_BATTLE_35,          $42, $01 ; DREAM_EATER
	db SFX_BATTLE_35,          $00, $60 ; DEEP_SLEEP
; === DRAGON ===
	db SFX_BATTLE_29,          $f0, $80 ; DRAGON_RAGE
	db SFX_BATTLE_0E,            $10, $80 ; DRAGON_CLAW ; Anim pass #7: same problem as NIGHT_SLASH (BATTLE_0F sounded odd). Dark whoosh deep-pitched reads as a draconic raking slash with weight. -- 2026-08-22 (anim pass #8): it sounded like GUST; one more worthy of DRAGON_CLAW -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_19,          $f0, $80 ; DRAGON_BREATH ; Anim pass #8: longer tempo ($40→$ff) for a sustained continuous breath sound matching the longer anim. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); tempo $40->$ff changed nothing (inert); TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_22,            $30, $80 ; DRAGON_SLAM ; Anim pass #9: a heavier, deeper sound. Pitch dropped ($20→$f0 ~ -1.5 oct) for the felt mass. -- 2026-08-22 (anim pass #9): a much deeper sound -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_22,            $40, $80 ; OUTRAGE ; Anim pass #10: slightly more impact. Deeper pitch + longer tempo for the locked-in 2-3 turn rage. -- 2026-08-22 (anim pass #10): the ugly synth-key tone was unacceptable, replaced by something deep -- MEASURED: noise 4 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_36,            $00, $a0 ; HYPER_BEAM ; 2026-08-22 (anim pass #11): a bit slower -- MEASURED: tone +0 st; noise +0 st; tempo 1.12x
; === ELECTRIC ===
	db SFX_BATTLE_2F,            $00, $30 ; NUZZLE ; 2026-08-22 (anim pass #12): a bit shorter -- MEASURED: tone +0 st; noise +0 st; tempo 0.69x
	db SFX_BATTLE_2F,          $00, $20 ; THUNDERSHOCK
	db SFX_BATTLE_2F,          $10, $60 ; SHOCK_WAVE
	db SFX_BATTLE_2F,          $20, $80 ; THUNDERBOLT
	db SFX_BATTLE_29,          $f0, $40 ; THUNDER ; v0.7 reviewed: was BATTLE_26; deep boom at low pitch sells the 115 BP thunder strike better than the generic crash. -- MEASURED: tone +3 st; noise 1 oct UP; tempo 0.75x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_2E,          $12, $60 ; THUNDER_WAVE ; ROW NEVER READ: ThunderWaveAnim names LEECH_SEED/THUNDERBOLT as its sound
	db SFX_BATTLE_2F,            $30, $20 ; VOLT_TACKLE ; Anim pass #13: a slightly less deep sound. Pitch raised $30→$50. -- 2026-08-22 (anim pass #15): a slightly higher sound -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +1..+1 st; noise 3 oct DOWN; tempo 0.62x
; === FAIRY ===
	db SFX_DOUBLESLAP,         $00, $80 ; DOUBLESLAP
	db SFX_BATTLE_12,          $00, $80 ; FAIRY_WIND
	db SFX_BATTLE_24,          $20, $80 ; DRAINING_KISS
	db SFX_BATTLE_28,            $20, $80 ; DAZZLE_GLEAM ; 2026-08-22 (anim pass #18): broken in the animation test -- MEASURED: tone +2..+12 st; noise 2 oct DOWN; tempo 1.00x
	db SFX_BATTLE_26,          $40, $80 ; PLAY_ROUGH ; Anim pass #16: a less deep sound. Pitch raised $10→$40. -- MEASURED: noise 4 oct DOWN; tempo byte inert (noise-only SFX); pitch $10 was [noise 1 oct DOWN]; OPPOSITE OF INTENT (went DOWN vs the old value)
	db SFX_BATTLE_09,          $30, $80 ; LOVELY_KISS ; Anim pass #18: a cuter sound. Higher pitch ($88→$30) + longer tempo ($10→$80) for the affectionate sparkle. -- MEASURED: tone +1 st; tempo 1.00x; pitch $88 was [tone +3 st]; tempo 0.56x -> 1.00x; OPPOSITE OF INTENT (went DOWN vs the old value)
	db SFX_BATTLE_35,          $00, $80 ; SING
	db SFX_BATTLE_36,            $00, $80 ; MOONBLAST ; 2026-08-22 (anim pass #20): the same as SOLARBEAM -- MEASURED: tone +0 st; noise +0 st; tempo 1.00x
; === FIGHTING ===
	db SFX_BATTLE_26,          $01, $80 ; SEISMIC_TOSS ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_23,          $00, $80 ; LOW_KICK
	db SFX_BATTLE_0C,          $01, $80 ; COMET_PUNCH ; v0.7 reviewed: was BATTLE_0B (cry); proper punch sound for a punch. -- MEASURED: noise -12..-3 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_14,            $10, $80 ; BIND ; 2026-08-22 (anim pass #22): a tiny bit slower and deeper -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_0C,          $20, $80 ; MACH_PUNCH ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0C,          $10, $80 ; KARATE_CHOP
	db SFX_BATTLE_26,          $20, $80 ; STRENGTH ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $00, $80 ; TAKE_DOWN ; v0.7 reviewed: was SUPER_EFFECTIVE (clean BAM); heavy thud reads as the body-mass tackle that lowers user's def. -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_17,          $10, $80 ; LEEK_STRIKE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_09,          $40, $40 ; DIZZY_PUNCH ; Anim pass #26: irritating. Pitch lowered $ff→$40 + tempo $04→$40 for a less piercing dizzy tone. -- MEASURED: tone +2 st; tempo 0.75x; pitch $ff was [tone +7 st]; tempo 0.52x -> 0.75x
	db SFX_BATTLE_17,          $10, $80 ; ROLLING_KICK ; v0.7 reviewed: was BATTLE_21 (whip); proper kick SFX matches the visual + DOUBLE_KICK family. -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_23,          $01, $80 ; SUBMISSION ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0C,          $00, $80 ; SKY_UPPERCUT ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_17,          $01, $80 ; HI_JUMP_KICK ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === FIRE ===
	db SFX_BATTLE_19,          $10, $80 ; EMBER ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_19,          $15, $80 ; FLAME_CHARGE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_19,          $20, $80 ; FLAME_BURST ; Anim pass #31: tightened pitch + tempo for the burst (paired with the reworked anim). -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX); TEMPO REQUEST HAD NO EFFECT
	db SFX_BATTLE_29,            $10, $ff ; FLAMETHROWER ; Anim pass #32: lower pitch + max tempo for a deep, real-fire feel closer to Fire Blast. -- 2026-08-22 (anim pass #29): the ugly synth-key tone replaced, with FIRE_BLAST's deep sound -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.50x
	db SFX_BATTLE_29,          $1f, $ff ; FIRE_BLAST ; Anim pass #33: tempo $20→$ff for the longer roar matching the bigger anim. -- MEASURED: tone +0 st; noise -20..-19 st; tempo 1.50x; tempo 0.62x -> 1.50x
	db SFX_BATTLE_19,          $00, $80 ; IGNITE
	db SFX_BATTLE_34,          $f0, $ff ; EXPLOSION ; v0.7 reviewed: lower pitch ($10→$f0) for catastrophic 200 BP feel matching the new multi-burst anim. -- MEASURED: tone +4 st; noise 1 oct UP; tempo 1.50x; pitch $10 was [tone +0 st; noise 1 oct DOWN]; OPPOSITE OF INTENT (went UP vs the old value)
; === FLYING ===
	db SFX_PECK,               $01, $80 ; PECK ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_12,          $00, $80 ; GUST ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_12,          $10, $80 ; WING_ATTACK ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,            $00, $80 ; AERIAL_ACE ; Anim pass #35: was BATTLE_2B (whoosh) — too heavy/long. Dash SFX with mid pitch + short tempo for a fast, precise feel. -- 2026-08-22 (anim pass #31): a higher sound -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_12,          $20, $80 ; FLY ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; wind whoosh fits the dive much better than a "tink". -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_13,          $f0, $80 ; HURRICANE ; Anim pass #37: deeper pitch + max tempo for the sustained storm sound matching the multi-tornado anim. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) / TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2B,          $48, $ff ; SKY_ATTACK ; v0.7 reviewed: was BATTLE_25 (dash); deep whoosh sells the dive-bomb on the new charge anim. -- MEASURED: tone +1..+2 st; noise 4 oct DOWN; LFSR width flip on 6 note(s) (metallic); tempo 1.50x
	db SFX_BATTLE_13,          $f0, $80 ; DRILL_PECK ; ROW NEVER READ: DrillPeckAnim names HORN_DRILL/PECK as its sound -- tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
; === FUNGUS ===
	db SFX_BATTLE_1C,          $11, $80 ; SPORE_DAZE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_24,          $40, $80 ; PARASITE
	db SFX_BATTLE_1C,          $01, $80 ; SPORE ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
; === GAS ===
	db SFX_BATTLE_2A,          $10, $ff ; SMOG ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; sludge-like wheeze fits the cloud-toss visual. -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.50x
	db SFX_BATTLE_2A,          $f0, $ff ; HAZE ; Anim pass #45: was BATTLE_0F (cut), bad sound. Sludge family deep-pitched + max tempo for sustained gas-cloud feel. -- MEASURED: tone +6..+24 st; noise 1 oct UP; tempo 1.50x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_1C,          $00, $80 ; POISON_GAS ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
; === GHOST ===
	db SFX_BATTLE_24,          $f0, $80 ; NIGHT_SHADE ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; drain SFX deep-pitched fits the spectral life-leech feel. -- MEASURED: tone +48 st; noise 1 oct UP; tempo 1.00x; OPPOSITE OF INTENT (went UP) -- ROW NEVER READ: NightShadeAnim names PSYBEAM as its sound
	db SFX_BATTLE_09,          $10, $60 ; LICK ; Anim pass #48: swapped SFX values with ASTONISH. -- MEASURED: tone +0 st; tempo 0.88x -- ROW NEVER READ: LickAnim names LEECH_SEED as its sound
	db SFX_BATTLE_0B,            $00, $80 ; ASTONISH ; Anim pass #48: swapped SFX values with LICK. -- 2026-08-22 (anim pass #38): the sound did not fit and was not a good sound -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_25,            $10, $80 ; SHADOW_SNEAK ; 2026-08-22 (anim pass #39): a bit too deep; the muffled quality stays -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_SUPER_EFFECTIVE,      $00, $80 ; SHADOW_PUNCH ; Anim pass #50: was BATTLE_2B (whoosh — sounded like a gust). Punch SFX deep-pitched for proper imperceptible-fist feel. -- 2026-08-22 (anim pass #40): a plain impact sound is enough -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_24,          $10, $80 ; SPIRIT_DRAIN
	db SFX_BATTLE_29,            $10, $a0 ; SHADOW_BALL ; Anim pass #52: was PSYCHIC_M (sounded like Psybeam). Drain family deep-pitched for ghostly impact. -- 2026-08-22 (anim pass #42): not powerful enough, and muffled (BATTLE_24 at $f0 was an 8 kHz whistle) -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.12x
	db SFX_BATTLE_13,          $f1, $80 ; CONFUSE_RAY ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_19,          $40, $80 ; WILL_O_WISP ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === GRASS ===
	db SFX_BATTLE_24,          $00, $80 ; ABSORB
	db SFX_VINE_WHIP,          $01, $80 ; VINE_WHIP
	db SFX_BATTLE_24,          $40, $c0 ; MEGA_DRAIN
	db SFX_BATTLE_12,          $20, $80 ; RAZOR_LEAF ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_24,            $50, $ff ; GIGA_DRAIN ; Anim pass #54: deeper pitch + max tempo for more intensity. -- 2026-08-22 (anim pass #44): the strongest drain had the weakest sound -- MEASURED: tone +6 st; noise 5 oct DOWN; tempo 1.50x
	db SFX_BATTLE_13,          $14, $80 ; PETAL_DANCE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2E,          $00, $80 ; SOLARBEAM ; ROW NEVER READ: SolarBeamAnim names HYPER_BEAM/LEECH_SEED as its sound
	db SFX_BATTLE_1B,          $03, $80 ; LEECH_SEED ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1C,          $00, $80 ; POISONPOWDER
	db SFX_BATTLE_1C,          $11, $80 ; STUN_POWDER ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1C,          $01, $80 ; SLEEP_POWDER ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === GROUND ===
	db SFX_BATTLE_20,          $00, $80 ; GROUND_STOMP ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $f0, $80 ; MUD_SHOT ; Anim pass #59: was BATTLE_2A (sludge — too toxic). Sting family at low pitch reads as gritty mud particles. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_29,          $00, $80 ; BULLDOZE
	db SFX_BATTLE_29,          $f0, $80 ; MUD_BOMB ; Anim pass #61: was BATTLE_2A (toxic). Boom family deep-pitched matches "BOMB" + the new SAND-led anim. -- MEASURED: tone +3 st; noise 1 oct UP; tempo 1.00x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_29,          $0f, $e0 ; EARTHQUAKE
	db SFX_BATTLE_29,          $11, $20 ; FISSURE
	db SFX_BATTLE_18,          $00, $80 ; BONE_CLUB ; v0.7 reviewed: was BATTLE_32 (squeak); thud SFX fits the club-bashing visual. -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_29,          $f0, $40 ; DIG ; v0.7 reviewed: was DAMAGE (generic hit); deep boom for the underground emergence. -- MEASURED: tone +3 st; noise 1 oct UP; tempo 0.75x; OPPOSITE OF INTENT (went UP)
; === ICE ===
	db SFX_BATTLE_28,            $20, $80 ; POWDER_SNOW ; Anim pass #66: tempo $40→$20 to fit the visual (no more SFX-after-visual gap). -- 2026-08-22 (anim pass #50): broken in the debugger, where it froze it -- MEASURED: tone +2..+12 st; noise 2 oct DOWN; tempo 1.00x
	db SFX_BATTLE_12,            $10, $80 ; ICY_WIND ; Anim pass #67: pitch $30→$50 (less heavy/deep). -- 2026-08-22 (anim pass #51): a very, very deep sound that made no sense -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_28,          $20, $ff ; FROST_BREATH ; Anim pass #69: tempo $80→$ff (longer-lasting). -- MEASURED: tone +2..+12 st; noise 2 oct DOWN; tempo 1.50x; tempo 1.00x -> 1.50x
	db SFX_BATTLE_28,          $30, $a0 ; ICY_PULSE ; new move v0.7. ICE family SFX, mid pitch, mid tempo. Pulse-like. -- MEASURED: tone +4..+25 st; noise 3 oct DOWN; tempo 1.12x
	db SFX_BATTLE_28,            $00, $80 ; AURORA_BEAM ; Anim pass #68: tempo $80→$ff (longer-lasting). -- 2026-08-22 (anim pass #52): a copy of vanilla (was SFX_BATTLE_28 $00 $ff) -- MEASURED: tone +0 st; noise +0 st; tempo 1.00x
	db SFX_BATTLE_28,            $40, $80 ; ICE_BEAM ; Anim pass #70: tempo $80→$ff (longer-lasting, paired with slower beam). -- 2026-08-22 (anim pass #53): vanilla's SOUND (was SFX_BATTLE_28 $40 $ff) -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +5..+5 st; noise 4 oct DOWN; tempo 1.00x
	db SFX_BATTLE_29,            $f0, $e0 ; BLIZZARD ; Anim pass #71: tempo shortened $ff→$80 — was irritating. -- 2026-08-22 (anim pass #54): the ugly synth tone (= $f8 width flip) replaced by vanilla's sound -- MEASURED: tone +3 st; noise 1 oct UP; tempo 1.38x
; === MAGMA ===
	db SFX_BATTLE_0D,          $20, $80 ; MAGMA_PUNCH ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_29,          $20, $40 ; LAVA_PLUME
; === NORMAL ===
	db SFX_BATTLE_14,          $10, $80 ; WRAP ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1E,          $01, $40 ; FURY_ATTACK
	db SFX_DAMAGE,             $00, $80 ; SCRATCH
	db SFX_SUPER_EFFECTIVE,    $10, $80 ; TACKLE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1E,          $00, $80 ; BITE
	db SFX_BATTLE_25,          $00, $80 ; QUICK_ATTACK ; tempo $10 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $00, $80 ; HEADBUTT
	db SFX_BATTLE_1E,          $00, $60 ; HORN_ATTACK
	db SFX_BATTLE_0E,            $30, $80 ; SLASH ; Anim pass #78: pitch raised $01→$30 for a sharper / higher cut. -- 2026-08-22 (anim pass #55): an odd sound that did not fit; SCRATCH with a better sound -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_20,          $00, $80 ; BODY_SLAM ; ROW NEVER READ: BodySlamAnim names LEECH_SEED as its sound -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1E,            $30, $c0 ; CRUNCH ; Anim pass #80: was BATTLE_1E (sounded like Bug Bite / Poison Sting). Slam family deep-pitched gives the grinding crunch feel. -- 2026-08-22 (anim pass #56): BITE, slower and heavier -- MEASURED: tone +1 st; noise 3 oct DOWN; tempo 1.25x
	db SFX_BATTLE_1E,            $30, $a0 ; HORN_CHARGE ; 2026-08-22 (anim pass #57): a new sound, the old one too weak -- MEASURED: tone +1 st; noise 3 oct DOWN; tempo 1.12x
	db SFX_BATTLE_29,            $11, $c0 ; THRASH ; 2026-08-22 (anim pass #58): a slower sound -- MEASURED: tone +0 st; noise -16..-15 st; tempo 1.25x
	db SFX_BATTLE_20,          $10, $80 ; HEAVY_SLAM ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $f0, $80 ; DOUBLE_EDGE ; Anim pass #84: was SUPER_EFFECTIVE (clean BAM). Heavy thud deep-pitched + max tempo for the crushing recoil-tier impact. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) / TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $10, $80 ; EXTREMESPEED ; tempo $10 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_27,          $40, $60 ; SUPERSONIC
	db SFX_BATTLE_26,            $f0, $80 ; SUPER_FANG ; 2026-08-22 (anim pass #62): vanilla's sound -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_1E,          $12, $ff ; HYPER_FANG
	db SFX_BATTLE_0F,          $20, $80 ; FALSE_SWIPE ; borrows VICEGRIP's slice sound (anim is a VICEGRIP variant)
; === POISON ===
	db SFX_BATTLE_1B,          $00, $80 ; POISON_STING
	db SFX_BATTLE_1B,          $10, $80 ; POISON_BITE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $20, $80 ; TOXIC_FANGS
	db SFX_BATTLE_2A,          $80, $c0 ; ACID
	db SFX_BATTLE_2A,          $20, $80 ; SLUDGE ; tempo $20→$80 to fit the longer anim (no SFX-cuts-short). -- MEASURED: tone +1..+2 st; noise 2 oct DOWN; tempo 1.00x; tempo 0.62x -> 1.00x
	db SFX_BATTLE_2A,            $30, $80 ; SLUDGE_WAVE ; 2026-08-22 (anim pass, test ROM of 2026-08-22): one octave under SLUDGE, one above GUNK_SHOT (was SFX_BATTLE_2A $10 $80) -- MEASURED: tone +1..+3 st; noise 3 oct DOWN; tempo 1.00x
	db SFX_BATTLE_2A,            $40, $ff ; GUNK_SHOT ; 2026-08-22 (anim pass, test ROM of 2026-08-22): the 115 BP finisher below ACID in the glug, the hiss a rumble (was +12 st, the highest of the sludge line) (was SFX_BATTLE_2A $f0 $ff) -- MEASURED: tone +1..+4 st; noise 4 oct DOWN; tempo 1.50x
	db SFX_BATTLE_2F,          $20, $a0 ; NEUROTOXIN ; v0.7 reviewed: was BATTLE_0F (cut); electric-crackle SFX fits the neuro-paralysis theme that the new lightning-ball anim ends on. -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +0..+0 st; noise 2 oct DOWN; tempo 1.12x; CHORD BROKEN
	db SFX_BATTLE_2A,          $10, $c0 ; TOXIC ; v0.7 reviewed: was BATTLE_0F (cut); sludge SFX matches the BLOB_DRIP anim and the badly-poisoned theme. -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.25x
; === PSYCHIC ===
	db SFX_PSYBEAM,              $f0, $40 ; PSYWAVE ; 2026-08-22 (anim pass, test ROM of 2026-08-22): 0.75x (was the longest of the family at 35 BP) (was SFX_PSYBEAM $f0 $f0) -- MEASURED: tone +7..+17 st; noise 1 oct UP; tempo 0.75x
	db SFX_BATTLE_14,          $00, $80 ; CONFUSION ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_14,          $10, $80 ; EXTRASENSORY ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_PSYBEAM,            $00, $80 ; PSYBEAM
	db SFX_PSYCHIC_M,          $00, $80 ; PSYCHIC_M
	db SFX_PSYCHIC_M,            $00, $ff ; MIND_BREAK ; 2026-08-22 (anim pass, test ROM of 2026-08-22): PSYCHIC_M's chord at 1.5x (was an octave above it and shorter) (was SFX_PSYCHIC_M $20 $60) -- MEASURED: tone +0 st; noise +0 st; tempo 1.50x
	db SFX_BATTLE_27,          $ff, $40 ; DISABLE ; ROW NEVER READ: DisableAnim names LEECH_SEED/LEER as its sound
	db SFX_BATTLE_35,          $11, $18 ; HYPNOSIS
; === ROCK ===
	db SFX_BATTLE_0D,            $30, $80 ; ROCK_THROW ; 2026-08-22 (anim pass #73): ROCK_PUNCH's sound, just a little deeper -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_0D,          $10, $80 ; ROCK_PUNCH ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_29,          $10, $60 ; ROCK_TOMB
	db SFX_BATTLE_18,          $20, $80 ; HEAD_SMASH ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_36,          $f0, $20 ; ROCK_SLIDE
	db SFX_BATTLE_0F,          $1f, $80 ; CLAMP ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_29,            $f0, $60 ; ROLLOUT ; 2026-08-22 (anim pass, test ROM of 2026-08-22): the row is no longer read (RolloutAnim names LEECH_SEED/BONEMERANG since #76) (was SFX_BATTLE_29 $20 $80) -- MEASURED: tone +3 st; noise 1 oct UP; tempo 0.88x -- ROW NEVER READ: RolloutAnim names BONEMERANG/LEECH_SEED as its sound
	db SFX_BATTLE_2B,          $f0, $60 ; BONEMERANG
	db SFX_BATTLE_22,          $f0, $80 ; CRABHAMMER ; slam SFX deep-pitched fits the hammer-down strike. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_HORN_DRILL,         $00, $80 ; HORN_DRILL ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === STEEL ===
	db SFX_BATTLE_0F,            $00, $80 ; CUT ; 2026-08-22 (anim pass #80): a higher sound -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_26,          $10, $80 ; IRON_TAIL ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $10, $80 ; IRON_HEAD
	db SFX_BATTLE_27,          $00, $80 ; SONICBOOM ; ROW NEVER READ: SonicBoomAnim names SUPERSONIC as its sound
	db SFX_BATTLE_25,          $00, $80 ; BULLET_PUNCH ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2B,          $20, $80 ; MAGNET_BOMB
; === WATER ===
	db SFX_BATTLE_24,            $20, $60 ; WATER_GUN ; 2026-08-22 (anim pass #86): the sound read as poison; vanilla's sound instead -- MEASURED: tone +2 st; noise 2 oct DOWN; tempo 0.88x
	db SFX_BATTLE_25,            $10, $80 ; AQUA_JET ; 2026-08-22 (anim pass #87): a better sound, less deep -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_2A,          $f0, $60 ; BUBBLEBEAM
	db SFX_BATTLE_2A,            $10, $80 ; WATER_PULSE ; 2026-08-22 (anim pass, test ROM of 2026-08-22; #89 changed only the animation order): off BATTLE_27 where half the chord sat at 16 kHz (was SFX_BATTLE_27 $30 $80) -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.00x
	db SFX_BATTLE_25,          $2f, $80 ; WATERFALL ; ROW NEVER READ: WaterfallAnim names HYDRO_PUMP/KARATE_CHOP/LEECH_SEED as its sound
	db SFX_BATTLE_2C,          $00, $80 ; SURF
	db SFX_BATTLE_2A,            $40, $80 ; HYDRO_PUMP ; 2026-08-22 (anim pass, test ROM of 2026-08-22; #92 rewrote only the animation): the 115 BP rung of the family (-48 st), read also by SURF/WATERFALL/BLIZZARD (was SFX_BATTLE_2A $00 $80) -- MEASURED: tone +1..+4 st; noise 4 oct DOWN; tempo 1.00x
; === BIRD (typeless) ===
	db SFX_BATTLE_29,          $f8, $ff ; TRI_ATTACK
	db SFX_NOT_VERY_EFFECTIVE, $10, $80 ; SWORDS_DANCE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_09,            $00, $ff ; BULK_UP ; 2026-08-22 (anim pass #95): slower, with a deeper sound -- MEASURED: tone +0 st; tempo 1.50x
	db SFX_BATTLE_14,            $20, $80 ; COIL ; 2026-08-22 (anim pass, test ROM of 2026-08-22): clean -24 st (the $15 scrambled the chord and flipped the LFSR width) (was SFX_BATTLE_14 $15 $80) -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_0B,          $10, $80 ; FIERCE_ROAR ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0F,            $f0, $80 ; HONE_CLAWS ; 2026-08-22 (anim pass, test ROM of 2026-08-22): the lightest rung of the claw family (+12 st) (was SFX_BATTLE_0F $20 $80) -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_14,            $30, $80 ; IRON_DEFENSE ; 2026-08-22 (anim pass, test ROM of 2026-08-22): -36 st, the heaviest DEF buff; the row is finally read (IronDefenseAnim names it) (was SFX_BATTLE_14 $f0 $80) -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_32,          $40, $c0 ; DEFENSE_CURL
	db SFX_BATTLE_14,          $11, $80 ; HARDEN ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_14,          $33, $80 ; WITHDRAW ; ROW NEVER READ: WithdrawAnim names DEFENSE_CURL as its sound -- tempo $30 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $11, $80 ; GROWTH ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $20, $80 ; CALM_MIND ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $30, $80 ; NASTY_PLOT ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_09,          $f8, $10 ; AMNESIA
	db SFX_BATTLE_09,          $50, $c0 ; QUIVER_DANCE ; v0.7 reviewed: was FAINT_FALL; sparkly tone fits the fluttery dance. -- MEASURED: tone +2 st; tempo 1.25x
	db SFX_BATTLE_12,          $30, $80 ; TAILWIND ; v0.7 reviewed: was FAINT_FALL; literal wind SFX matches the tornado anim. -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,            $f0, $80 ; AGILITY ; 2026-08-22 (anim pass, test ROM of 2026-08-22): a bright quick whoosh (+12 st; was two octaves down) (was SFX_BATTLE_25 $20 $80) -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_33,          $80, $40 ; DOUBLE_TEAM
	db SFX_BATTLE_33,          $f0, $c0 ; TELEPORT
	db SFX_BATTLE_32,            $30, $a0 ; CHARM ; 2026-08-22 (anim pass #100): the sound did not fit, it was not cute -- MEASURED: tone +4 st; tempo 1.12x
	db SFX_BATTLE_0B,          $30, $80 ; INTIMIDATE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22) -- ROW NEVER READ: IntimidateAnim names LEECH_SEED/SCARY_FACE as its sound
	db SFX_BATTLE_0B,          $00, $c0 ; GROWL
	db SFX_BATTLE_31,          $ff, $40 ; LEER
	db SFX_BATTLE_2A,          $90, $c0 ; CORRODE
	db SFX_BATTLE_21,            $00, $80 ; TICKLE ; 2026-08-22 (anim pass #103): a sound just a little higher -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_21,          $00, $80 ; TAIL_WHIP ; ROW NEVER READ: TailWhipAnim names AMNESIA as its sound
	db SFX_BATTLE_35,          $20, $40 ; FAKE_TEARS
	db SFX_BATTLE_31,            $08, $80 ; METAL_SOUND ; 2026-08-22 (anim pass, test ROM of 2026-08-22): a 5.5 kHz screech above SCREECH (the $20 folded every note to a 64 Hz hum) (was SFX_BATTLE_31 $20 $80) -- MEASURED: tone +5 st; tempo 1.00x
	db SFX_BATTLE_31,          $00, $80 ; SCREECH
	db SFX_BATTLE_2F,            $03, $60 ; EERIE_IMPULSE ; 2026-08-22 (anim pass, test ROM of 2026-08-22): the row is no longer read (EerieImpulseAnim names DARK_PULSE since #104) (was SFX_BATTLE_2F $40 $60) -- MEASURED: tone +0..+4 st; noise -12..-10 st; tempo 0.88x -- ROW NEVER READ: EerieImpulseAnim names DARK_PULSE as its sound
	db SFX_BATTLE_31,          $30, $80 ; SCARY_FACE
	db SFX_BATTLE_14,          $20, $80 ; HINDER
	db SFX_BATTLE_1B,          $02, $80 ; STRING_SHOT ; v0.7: was ENTANGLE (-2 spd custom). Restored canon STRING_SHOT (-1 spd, 30 PP). -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_PSYCHIC_M,          $30, $80 ; PSYCHIC_BIND
	db SFX_BATTLE_13,          $f8, $80 ; FLASH ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $01, $80 ; SAND_ATTACK ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $f1, $80 ; SMOKESCREEN ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_33,          $00, $80 ; RECOVER
	db SFX_BATTLE_35,          $12, $10 ; REST ; v0.7 reviewed: was BATTLE_21 (whip!); sleep SFX matches the move literally putting the user to sleep. -- MEASURED: tone +4..+9 st; tempo 0.56x
	db SFX_BATTLE_32,          $08, $40 ; SOFTBOILED
	db SFX_BATTLE_0E,          $f0, $80 ; LIGHT_SCREEN ; tempo $10 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0E,          $00, $80 ; REFLECT ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; same SFX as LIGHT_SCREEN with higher pitch — they're a pair, should sound related. -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX); REFLECT $00 is one octave BELOW LIGHT_SCREEN $f0 on this noise-only SFX, not above -- tempo $10 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $00, $80 ; BIDE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $00, $80 ; FOCUS_ENERGY
	db SFX_BATTLE_09,          $f0, $40 ; MIMIC
	db SFX_BATTLE_09,          $f2, $20 ; MIRROR_MOVE
	db SFX_BATTLE_33,          $d8, $04 ; SUBSTITUTE ; v0.7 reviewed: was BATTLE_2C (water!); poof SFX matches the smoke-and-puppet visual. -- MEASURED: tone +6..+40 st; tempo 0.52x
	db SFX_BATTLE_09,          $ff, $ff ; TRANSFORM ; v0.7 reviewed: was FAINT_FALL; sparkle for the morph effect, same family as DITTO's identity move. -- MEASURED: tone +7 st; tempo 1.50x
	db SFX_BATTLE_32,          $c0, $ff ; METRONOME ; ROW NEVER READ: MetronomeAnim names AMNESIA as its sound
	db SFX_BATTLE_0B,          $00, $80 ; STRUGGLE ; ROW NEVER READ: StruggleAnim names TACKLE as its sound
	assert_table_length NUM_ATTACKS
