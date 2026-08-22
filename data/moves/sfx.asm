; MoveSoundTable: one `db <SFX>, <pitch byte>, <tempo byte>` row per move, in
; move-id order (constants/move_constants.asm). GetMoveSound (engine/battle/
; animations.asm) reads a row whenever an animation script's battle_anim names
; that move as its SOUND (the first argument) -- so a move's own row is only
; ever heard if some script names it. 13 rows are named by no script at all,
; and the LEECH_SEED row is named by 22 scripts: changing a row changes every
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
; SFX. That is the mechanism behind "curto, agudo, esquisito".
;
; Forte's rule for tuning (2026-08-21): within a family, the stronger move
; should sound deeper and fuller -- GUNK SHOT below ACID, THUNDER below
; THUNDERSHOCK. Deeper means a SMALLER pitch byte on a tone SFX (and never
; past the fold) and a BIGGER one on a noise SFX. Rows tagged MEASURED record
; what their bytes do; "Forte feedback #N" rows record his words, and those
; still stand -- the bytes under them were chosen against the wrong model.
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
	db SFX_BATTLE_1E,          $20, $60 ; MEGAHORN
	db SFX_BATTLE_0F,          $00, $80 ; GUILLOTINE
	db SFX_BATTLE_0F,          $20, $80 ; VICEGRIP ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $20, $80 ; TWINEEDLE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === DARK ===
	db SFX_BATTLE_25,          $f0, $80 ; FAINT_ATTACK ; Forte feedback #3: was BATTLE_2B (whoosh — sounded too "flying"). Dash SFX deep-pitched reads as a sneaky deceptive lunge instead of a bird swooping. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_26,          $f0, $80 ; RAGE ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2B,          $f0, $a0 ; NIGHT_SLASH ; Forte feedback #4: my previous BATTLE_0F (sharp cut) sounded "esquisito, nada assustador ou fixe". Dark whoosh deep-pitched reads as the sinister night-strike. -- MEASURED: tone +4..+6 st; noise 1 oct UP; tempo 1.12x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_22,          $f8, $80 ; BRUTAL_SWING ; Forte feedback #5: deeper pitch ($00→$f8 ~ -1 oct) for grave/heavy feel. -- MEASURED: noise 1 oct UP; LFSR width flip on 2 note(s) (metallic); tempo byte inert (noise-only SFX); pitch $00 was [noise +0 st]; OPPOSITE OF INTENT (went UP vs the old value)
	db SFX_PSYCHIC_M,          $20, $80 ; DARK_PULSE
	db SFX_BATTLE_1E,          $f0, $a0 ; GORE_ATTACK ; Forte feedback #6: deeper pitch + longer tempo for the brutal goring impact (paired with the reworked anim). -- MEASURED: tone +3 st; noise 1 oct UP; tempo 1.12x; OPPOSITE OF INTENT (went UP)
	db SFX_SILPH_SCOPE,        $00, $ff ; PAY_DAY
	db SFX_BATTLE_35,          $42, $01 ; DREAM_EATER
	db SFX_BATTLE_35,          $00, $60 ; DEEP_SLEEP
; === DRAGON ===
	db SFX_BATTLE_29,          $f0, $80 ; DRAGON_RAGE
	db SFX_BATTLE_2B,          $f0, $a0 ; DRAGON_CLAW ; Forte feedback #7: same problem as NIGHT_SLASH (BATTLE_0F sounded esquisito). Dark whoosh deep-pitched reads as a draconic raking slash with weight. -- MEASURED: tone +4..+6 st; noise 1 oct UP; tempo 1.12x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_19,          $f0, $80 ; DRAGON_BREATH ; Forte feedback #8: longer tempo ($40→$ff) for a sustained continuous breath sound matching the longer anim. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); tempo $40->$ff changed nothing (inert); TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_22,          $f0, $80 ; DRAGON_SLAM ; Forte feedback #9: "podia soar mais pesado, grave". Pitch dropped ($20→$f0 ~ -1.5 oct) for the felt mass. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); pitch $20 was [noise 2 oct DOWN]; OPPOSITE OF INTENT (went UP vs the old value) -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_22,          $f8, $80 ; OUTRAGE ; Forte feedback #10: "ligeiramente mais impactante". Deeper pitch + longer tempo for the locked-in 2-3 turn rage. -- MEASURED: noise 1 oct UP; LFSR width flip on 2 note(s) (metallic); tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) / TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_36,          $00, $80 ; HYPER_BEAM
; === ELECTRIC ===
	db SFX_BATTLE_2F,          $00, $40 ; NUZZLE
	db SFX_BATTLE_2F,          $00, $20 ; THUNDERSHOCK
	db SFX_BATTLE_2F,          $10, $60 ; SHOCK_WAVE
	db SFX_BATTLE_2F,          $20, $80 ; THUNDERBOLT
	db SFX_BATTLE_29,          $f0, $40 ; THUNDER ; v0.7 reviewed: was BATTLE_26; deep boom at low pitch sells the 115 BP thunder strike better than the generic crash. -- MEASURED: tone +3 st; noise 1 oct UP; tempo 0.75x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_2E,          $12, $60 ; THUNDER_WAVE ; ROW NEVER READ: ThunderWaveAnim names LEECH_SEED/THUNDERBOLT as its sound
	db SFX_BATTLE_2F,          $50, $20 ; VOLT_TACKLE ; Forte feedback #13: "som um pouco menos grave". Pitch raised $30→$50. -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +1..+1 st; noise 5 oct DOWN; tempo 0.62x; pitch $30 was [tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +1..+1 st; noise 3 oct DOWN]; CHORD BROKEN; the two 2032/2018 notes already folded at $30; raising to $50 only dropped the noise layer two more octaves
; === FAIRY ===
	db SFX_DOUBLESLAP,         $00, $80 ; DOUBLESLAP
	db SFX_BATTLE_12,          $00, $80 ; FAIRY_WIND
	db SFX_BATTLE_24,          $20, $80 ; DRAINING_KISS
	db SFX_BATTLE_28,          $20, $60 ; DAZZLE_GLEAM
	db SFX_BATTLE_26,          $40, $80 ; PLAY_ROUGH ; Forte feedback #16: "som menos grave". Pitch raised $10→$40. -- MEASURED: noise 4 oct DOWN; tempo byte inert (noise-only SFX); pitch $10 was [noise 1 oct DOWN]; OPPOSITE OF INTENT (went DOWN vs the old value)
	db SFX_BATTLE_09,          $30, $80 ; LOVELY_KISS ; Forte feedback #18: "som mais cute". Higher pitch ($88→$30) + longer tempo ($10→$80) for the affectionate sparkle. -- MEASURED: tone +1 st; tempo 1.00x; pitch $88 was [tone +3 st]; tempo 0.56x -> 1.00x; OPPOSITE OF INTENT (went DOWN vs the old value)
	db SFX_BATTLE_35,          $00, $80 ; SING
	db SFX_BATTLE_28,          $f8, $40 ; MOONBLAST ; v0.7 reviewed: lowered pitch ($30→$f8 ~ -2 oct) + slower tempo for 180 BP charge weight. -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +60..+62 st; noise +0 st; LFSR width flip on 2 note(s) (metallic); tempo 0.75x; pitch $30 was [tone +4..+25 st; noise 3 oct DOWN]; CHORD BROKEN / OPPOSITE OF INTENT (went UP vs the old value)
; === FIGHTING ===
	db SFX_BATTLE_26,          $01, $80 ; SEISMIC_TOSS ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_23,          $00, $80 ; LOW_KICK
	db SFX_BATTLE_0C,          $01, $80 ; COMET_PUNCH ; v0.7 reviewed: was BATTLE_0B (cry); proper punch sound for a punch. -- MEASURED: noise -12..-3 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_14,          $00, $80 ; BIND
	db SFX_BATTLE_0C,          $20, $80 ; MACH_PUNCH ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0C,          $10, $80 ; KARATE_CHOP
	db SFX_BATTLE_26,          $20, $80 ; STRENGTH ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $00, $80 ; TAKE_DOWN ; v0.7 reviewed: was SUPER_EFFECTIVE (clean BAM); heavy thud reads as the body-mass tackle that lowers user's def. -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_17,          $10, $80 ; LEEK_STRIKE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_09,          $40, $40 ; DIZZY_PUNCH ; Forte feedback #26: irritante. Pitch lowered $ff→$40 + tempo $04→$40 for a less piercing dizzy tone. -- MEASURED: tone +2 st; tempo 0.75x; pitch $ff was [tone +7 st]; tempo 0.52x -> 0.75x
	db SFX_BATTLE_17,          $10, $80 ; ROLLING_KICK ; v0.7 reviewed: was BATTLE_21 (whip); proper kick SFX matches the visual + DOUBLE_KICK family. -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_23,          $01, $80 ; SUBMISSION ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0C,          $00, $80 ; SKY_UPPERCUT ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_17,          $01, $80 ; HI_JUMP_KICK ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === FIRE ===
	db SFX_BATTLE_19,          $10, $80 ; EMBER ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_19,          $15, $80 ; FLAME_CHARGE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_19,          $20, $80 ; FLAME_BURST ; Forte feedback #31: tightened pitch + tempo for the burst (paired with the reworked anim). -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX); TEMPO REQUEST HAD NO EFFECT
	db SFX_BATTLE_19,          $f8, $80 ; FLAMETHROWER ; Forte feedback #32: lower pitch + max tempo for the deep "real fire" feel closer to Fire Blast. -- MEASURED: noise 1 oct UP; LFSR width flip on 3 note(s) (metallic); tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) / TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_29,          $1f, $ff ; FIRE_BLAST ; Forte feedback #33: tempo $20→$ff for the longer roar matching the bigger anim. -- MEASURED: tone +0 st; noise -20..-19 st; tempo 1.50x; tempo 0.62x -> 1.50x
	db SFX_BATTLE_19,          $00, $80 ; IGNITE
	db SFX_BATTLE_34,          $f0, $ff ; EXPLOSION ; v0.7 reviewed: lower pitch ($10→$f0) for catastrophic 200 BP feel matching the new multi-burst anim. -- MEASURED: tone +4 st; noise 1 oct UP; tempo 1.50x; pitch $10 was [tone +0 st; noise 1 oct DOWN]; OPPOSITE OF INTENT (went UP vs the old value)
; === FLYING ===
	db SFX_PECK,               $01, $80 ; PECK ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_12,          $00, $80 ; GUST ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_12,          $10, $80 ; WING_ATTACK ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $30, $80 ; AERIAL_ACE ; Forte feedback #35: was BATTLE_2B (whoosh) — too pesado/duradouro. Dash SFX with mid pitch + short tempo for "rápido, preciso". -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX); TEMPO REQUEST HAD NO EFFECT -- tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_12,          $20, $80 ; FLY ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; wind whoosh fits the dive much better than a "tink". -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_13,          $f0, $80 ; HURRICANE ; Forte feedback #37: deeper pitch + max tempo for the sustained storm sound matching the multi-tornado anim. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) / TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2B,          $48, $ff ; SKY_ATTACK ; v0.7 reviewed: was BATTLE_25 (dash); deep whoosh sells the dive-bomb on the new charge anim. -- MEASURED: tone +1..+2 st; noise 4 oct DOWN; LFSR width flip on 6 note(s) (metallic); tempo 1.50x
	db SFX_BATTLE_13,          $f0, $80 ; DRILL_PECK ; ROW NEVER READ: DrillPeckAnim names HORN_DRILL/PECK as its sound -- tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
; === FUNGUS ===
	db SFX_BATTLE_1C,          $11, $80 ; SPORE_DAZE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_24,          $40, $80 ; PARASITE
	db SFX_BATTLE_1C,          $01, $80 ; SPORE ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
; === GAS ===
	db SFX_BATTLE_2A,          $10, $ff ; SMOG ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; sludge-like wheeze fits the cloud-toss visual. -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.50x
	db SFX_BATTLE_2A,          $f0, $ff ; HAZE ; Forte feedback #45: was BATTLE_0F (cut), bad sound. Sludge family deep-pitched + max tempo for sustained gas-cloud feel. -- MEASURED: tone +6..+24 st; noise 1 oct UP; tempo 1.50x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_1C,          $00, $80 ; POISON_GAS ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
; === GHOST ===
	db SFX_BATTLE_24,          $f0, $80 ; NIGHT_SHADE ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; drain SFX deep-pitched fits the spectral life-leech feel. -- MEASURED: tone +48 st; noise 1 oct UP; tempo 1.00x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_09,          $10, $60 ; LICK ; Forte feedback #48: swapped SFX values with ASTONISH. -- MEASURED: tone +0 st; tempo 0.88x -- ROW NEVER READ: LickAnim names LEECH_SEED as its sound
	db SFX_BATTLE_09,          $00, $40 ; ASTONISH ; Forte feedback #48: swapped SFX values with LICK. -- MEASURED: tone +0 st; tempo 0.75x
	db SFX_BATTLE_25,          $20, $80 ; SHADOW_SNEAK ; tempo $10 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0C,          $f0, $80 ; SHADOW_PUNCH ; Forte feedback #50: was BATTLE_2B (whoosh — sounded like a gust). Punch SFX deep-pitched for proper imperceptible-fist feel. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_24,          $10, $80 ; SPIRIT_DRAIN
	db SFX_BATTLE_24,          $f0, $a0 ; SHADOW_BALL ; Forte feedback #52: was PSYCHIC_M (sounded like Psybeam). Drain family deep-pitched for ghostly impact. -- MEASURED: tone +48 st; noise 1 oct UP; tempo 1.12x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_13,          $f1, $80 ; CONFUSE_RAY ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_19,          $40, $80 ; WILL_O_WISP ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === GRASS ===
	db SFX_BATTLE_24,          $00, $80 ; ABSORB
	db SFX_VINE_WHIP,          $01, $80 ; VINE_WHIP
	db SFX_BATTLE_24,          $40, $c0 ; MEGA_DRAIN
	db SFX_BATTLE_12,          $20, $80 ; RAZOR_LEAF ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_24,          $f0, $ff ; GIGA_DRAIN ; Forte feedback #54: deeper pitch + max tempo for more intensity. -- MEASURED: tone +48 st; noise 1 oct UP; tempo 1.50x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_13,          $14, $80 ; PETAL_DANCE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2E,          $00, $80 ; SOLARBEAM ; ROW NEVER READ: SolarBeamAnim names HYPER_BEAM/LEECH_SEED as its sound
	db SFX_BATTLE_1B,          $03, $80 ; LEECH_SEED ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1C,          $00, $80 ; POISONPOWDER
	db SFX_BATTLE_1C,          $11, $80 ; STUN_POWDER ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1C,          $01, $80 ; SLEEP_POWDER ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === GROUND ===
	db SFX_BATTLE_20,          $00, $80 ; GROUND_STOMP ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $f0, $80 ; MUD_SHOT ; Forte feedback #59: was BATTLE_2A (sludge — too toxic). Sting family at low pitch reads as gritty mud particles. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_29,          $00, $80 ; BULLDOZE
	db SFX_BATTLE_29,          $f0, $80 ; MUD_BOMB ; Forte feedback #61: was BATTLE_2A (toxic). Boom family deep-pitched matches "BOMB" + the new SAND-led anim. -- MEASURED: tone +3 st; noise 1 oct UP; tempo 1.00x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_29,          $0f, $e0 ; EARTHQUAKE
	db SFX_BATTLE_29,          $11, $20 ; FISSURE
	db SFX_BATTLE_18,          $00, $80 ; BONE_CLUB ; v0.7 reviewed: was BATTLE_32 (squeak); thud SFX fits the club-bashing visual. -- MEASURED: noise +0 st; tempo byte inert (noise-only SFX)
	db SFX_BATTLE_29,          $f0, $40 ; DIG ; v0.7 reviewed: was DAMAGE (generic hit); deep boom for the underground emergence. -- MEASURED: tone +3 st; noise 1 oct UP; tempo 0.75x; OPPOSITE OF INTENT (went UP)
; === ICE ===
	db SFX_BATTLE_28,          $20, $20 ; POWDER_SNOW ; Forte feedback #66: tempo $40→$20 to fit the visual (no more SFX-after-visual gap). -- MEASURED: tone +2..+12 st; noise 2 oct DOWN; tempo 0.62x; tempo 0.75x -> 0.62x
	db SFX_BATTLE_12,          $50, $80 ; ICY_WIND ; Forte feedback #67: pitch $30→$50 (less pesado/grave). -- MEASURED: noise 5 oct DOWN; tempo byte inert (noise-only SFX); pitch $30 was [noise 3 oct DOWN]; OPPOSITE OF INTENT (went DOWN vs the old value)
	db SFX_BATTLE_28,          $20, $ff ; FROST_BREATH ; Forte feedback #69: tempo $80→$ff (more duradouro). -- MEASURED: tone +2..+12 st; noise 2 oct DOWN; tempo 1.50x; tempo 1.00x -> 1.50x
	db SFX_BATTLE_28,          $30, $a0 ; ICY_PULSE ; new move v0.7. ICE family SFX, mid pitch, mid tempo. Pulse-like. -- MEASURED: tone +4..+25 st; noise 3 oct DOWN; tempo 1.12x
	db SFX_BATTLE_28,          $00, $ff ; AURORA_BEAM ; Forte feedback #68: tempo $80→$ff (more duradouro). -- MEASURED: tone +0 st; noise +0 st; tempo 1.50x; tempo 1.00x -> 1.50x
	db SFX_BATTLE_28,          $40, $ff ; ICE_BEAM ; Forte feedback #70: tempo $80→$ff (more duradouro, paired with slower beam). -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +5..+5 st; noise 4 oct DOWN; tempo 1.50x; tempo 1.00x -> 1.50x; CHORD BROKEN (pitch is vanilla's)
	db SFX_BATTLE_29,          $f8, $80 ; BLIZZARD ; Forte feedback #71: tempo shortened $ff→$80 — was irritante. -- MEASURED: tone +3 st; noise +0..+12 st; LFSR width flip on 5 note(s) (metallic); tempo 1.00x; tempo 1.50x -> 1.00x
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
	db SFX_BATTLE_0F,          $30, $80 ; SLASH ; Forte feedback #78: pitch raised $01→$30 for a sharper / more agudo cut. -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX); pitch $01 was [noise -7..-4 st]; OPPOSITE OF INTENT (went DOWN vs the old value) -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_20,          $00, $80 ; BODY_SLAM ; ROW NEVER READ: BodySlamAnim names LEECH_SEED as its sound -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_22,          $f0, $80 ; CRUNCH ; Forte feedback #80: was BATTLE_1E (sounded like Bug Bite / Poison Sting). Slam family deep-pitched gives the grinding crunch feel. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1E,          $10, $80 ; HORN_CHARGE
	db SFX_BATTLE_22,          $11, $80 ; THRASH ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_20,          $10, $80 ; HEAVY_SLAM ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $f0, $80 ; DOUBLE_EDGE ; Forte feedback #84: was SUPER_EFFECTIVE (clean BAM). Heavy thud deep-pitched + max tempo for the crushing recoil-tier impact. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) / TEMPO REQUEST HAD NO EFFECT -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $10, $80 ; EXTREMESPEED ; tempo $10 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_27,          $40, $60 ; SUPERSONIC
	db SFX_BATTLE_1E,          $f8, $ff ; SUPER_FANG ; v0.7 reviewed: was BATTLE_26 (heavy crash); proper bite SFX deep-pitched fits "fang" name + 50%-HP mechanic. -- MEASURED: tone +3 st; noise 1 oct UP; LFSR width flip on 4 note(s) (metallic); tempo 1.50x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_1E,          $12, $ff ; HYPER_FANG
; === POISON ===
	db SFX_BATTLE_1B,          $00, $80 ; POISON_STING
	db SFX_BATTLE_1B,          $10, $80 ; POISON_BITE ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_1B,          $20, $80 ; TOXIC_FANGS
	db SFX_BATTLE_2A,          $80, $c0 ; ACID
	db SFX_BATTLE_2A,          $20, $80 ; SLUDGE ; tempo $20→$80 to fit the longer anim (no SFX-cuts-short). -- MEASURED: tone +1..+2 st; noise 2 oct DOWN; tempo 1.00x; tempo 0.62x -> 1.00x
	db SFX_BATTLE_2A,          $10, $80 ; SLUDGE_WAVE
	db SFX_BATTLE_2A,          $f0, $ff ; GUNK_SHOT ; deeper pitch + max tempo for the 115 BP launch-and-splat weight. -- MEASURED: tone +6..+24 st; noise 1 oct UP; tempo 1.50x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_2F,          $20, $a0 ; NEUROTOXIN ; v0.7 reviewed: was BATTLE_0F (cut); electric-crackle SFX fits the neuro-paralysis theme that the new lightning-ball anim ends on. -- MEASURED: tone PARTIAL-WRAP: 2 of 4 notes fold to ~64 Hz, the rest +0..+0 st; noise 2 oct DOWN; tempo 1.12x; CHORD BROKEN
	db SFX_BATTLE_2A,          $10, $c0 ; TOXIC ; v0.7 reviewed: was BATTLE_0F (cut); sludge SFX matches the BLOB_DRIP anim and the badly-poisoned theme. -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.25x
; === PSYCHIC ===
	db SFX_PSYBEAM,            $f0, $f0 ; PSYWAVE ; v0.7 reviewed: was BATTLE_0C (punch); psybeam SFX deep-pitched is the wave-reverb feel the name calls for. -- MEASURED: tone +7..+17 st; noise 1 oct UP; tempo 1.44x; OPPOSITE OF INTENT (went UP)
	db SFX_BATTLE_14,          $00, $80 ; CONFUSION ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_14,          $10, $80 ; EXTRASENSORY ; tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_PSYBEAM,            $00, $80 ; PSYBEAM
	db SFX_PSYCHIC_M,          $00, $80 ; PSYCHIC_M
	db SFX_PSYCHIC_M,          $20, $60 ; MIND_BREAK
	db SFX_BATTLE_27,          $ff, $40 ; DISABLE ; ROW NEVER READ: DisableAnim names LEECH_SEED/LEER as its sound
	db SFX_BATTLE_35,          $11, $18 ; HYPNOSIS
; === ROCK ===
	db SFX_BATTLE_36,          $01, $e0 ; ROCK_THROW ; v0.7 reviewed: was BATTLE_14 (squeeze); proper rock-thud SFX matches the falling-rocks anim. -- MEASURED: tone +0 st; noise 1 oct DOWN; tempo 1.38x
	db SFX_BATTLE_0D,          $10, $80 ; ROCK_PUNCH ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_29,          $10, $60 ; ROCK_TOMB
	db SFX_BATTLE_18,          $20, $80 ; HEAD_SMASH ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_36,          $f0, $20 ; ROCK_SLIDE
	db SFX_BATTLE_0F,          $1f, $80 ; CLAMP ; tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_29,          $20, $80 ; ROLLOUT ; v0.7 new: rolling rock multi-hit, similar tone to ROCK_TOMB -- MEASURED: tone +0 st; noise 2 oct DOWN; tempo 1.00x
	db SFX_BATTLE_2B,          $f0, $60 ; BONEMERANG
	db SFX_BATTLE_22,          $f0, $80 ; CRABHAMMER ; slam SFX deep-pitched fits the hammer-down strike. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- tempo $ff -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_HORN_DRILL,         $00, $80 ; HORN_DRILL ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
; === STEEL ===
	db SFX_BATTLE_0F,          $10, $80 ; CUT ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; sharp metallic cut SFX matches a STEEL-type slashing strike. -- MEASURED: noise 1 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_26,          $10, $80 ; IRON_TAIL ; tempo $60 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_18,          $10, $80 ; IRON_HEAD
	db SFX_BATTLE_27,          $00, $80 ; SONICBOOM ; ROW NEVER READ: SonicBoomAnim names SUPERSONIC as its sound
	db SFX_BATTLE_25,          $00, $80 ; BULLET_PUNCH ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2B,          $20, $80 ; MAGNET_BOMB
; === WATER ===
	db SFX_BATTLE_2A,          $20, $60 ; WATER_GUN ; v0.7 reviewed: was BATTLE_24 (DRAIN!); spray SFX, not absorb-suction. Same family as BUBBLEBEAM/HYDRO_PUMP now. -- MEASURED: tone +1..+2 st; noise 2 oct DOWN; tempo 0.88x
	db SFX_BATTLE_25,          $30, $80 ; AQUA_JET ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_2A,          $f0, $60 ; BUBBLEBEAM
	db SFX_BATTLE_27,          $30, $80 ; WATER_PULSE ; v0.7 reviewed: was BATTLE_24 (drain); sonic-pulse SFX literally fits "PULSE" in the name. -- MEASURED: tone +24..+34 st; noise 3 oct DOWN; tempo 1.00x
	db SFX_BATTLE_25,          $2f, $80 ; WATERFALL ; ROW NEVER READ: WaterfallAnim names HYDRO_PUMP/KARATE_CHOP/LEECH_SEED as its sound
	db SFX_BATTLE_2C,          $00, $80 ; SURF
	db SFX_BATTLE_2A,          $00, $80 ; HYDRO_PUMP
; === BIRD (typeless) ===
	db SFX_BATTLE_29,          $f8, $ff ; TRI_ATTACK
	db SFX_NOT_VERY_EFFECTIVE, $10, $80 ; SWORDS_DANCE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_09,          $35, $c0 ; BULK_UP
	db SFX_BATTLE_14,          $15, $80 ; COIL
	db SFX_BATTLE_0B,          $10, $80 ; FIERCE_ROAR ; tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0F,          $20, $80 ; HONE_CLAWS ; v0.7 reviewed: was NOT_VERY_EFFECTIVE; cut SFX at high pitch reads as claw-on-claw sharpening. -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $a0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_14,          $f0, $80 ; IRON_DEFENSE ; new move v0.7. Same family as HARDEN/WITHDRAW/COIL but deeper pitch ($f0 grave) for iron-clang feel. -- MEASURED: noise 1 oct UP; tempo byte inert (noise-only SFX); OPPOSITE OF INTENT (went UP) -- ROW NEVER READ: IronDefenseAnim plays no sound -- tempo $40 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_32,          $40, $c0 ; DEFENSE_CURL
	db SFX_BATTLE_14,          $11, $80 ; HARDEN ; tempo $20 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_14,          $33, $80 ; WITHDRAW ; ROW NEVER READ: WithdrawAnim names DEFENSE_CURL as its sound -- tempo $30 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $11, $80 ; GROWTH ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $20, $80 ; CALM_MIND ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $30, $80 ; NASTY_PLOT ; tempo $e0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_09,          $f8, $10 ; AMNESIA
	db SFX_BATTLE_09,          $50, $c0 ; QUIVER_DANCE ; v0.7 reviewed: was FAINT_FALL; sparkly tone fits the fluttery dance. -- MEASURED: tone +2 st; tempo 1.25x
	db SFX_BATTLE_12,          $30, $80 ; TAILWIND ; v0.7 reviewed: was FAINT_FALL; literal wind SFX matches the tornado anim. -- MEASURED: noise 3 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_25,          $20, $80 ; AGILITY ; v0.7 reviewed: was FAINT_FALL; dash/zoom SFX fits the speed-shake anim. -- MEASURED: noise 2 oct DOWN; tempo byte inert (noise-only SFX) -- tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_33,          $80, $40 ; DOUBLE_TEAM
	db SFX_BATTLE_33,          $f0, $c0 ; TELEPORT
	db SFX_BATTLE_09,          $20, $c0 ; CHARM ; v0.7 reviewed: was BATTLE_0B (growl-like); sparkle-tone SFX matches the heart-music visual. -- MEASURED: tone +1 st; tempo 1.25x
	db SFX_BATTLE_0B,          $30, $80 ; INTIMIDATE ; tempo $c0 -> $80 (inert: noise-only SFX; 2026-08-22)
	db SFX_BATTLE_0B,          $00, $c0 ; GROWL
	db SFX_BATTLE_31,          $ff, $40 ; LEER
	db SFX_BATTLE_2A,          $90, $c0 ; CORRODE
	db SFX_BATTLE_21,          $10, $80 ; TICKLE
	db SFX_BATTLE_21,          $00, $80 ; TAIL_WHIP ; ROW NEVER READ: TailWhipAnim names AMNESIA as its sound
	db SFX_BATTLE_35,          $20, $40 ; FAKE_TEARS
	db SFX_BATTLE_31,          $20, $80 ; METAL_SOUND
	db SFX_BATTLE_31,          $00, $80 ; SCREECH
	db SFX_BATTLE_2F,          $40, $60 ; EERIE_IMPULSE
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
