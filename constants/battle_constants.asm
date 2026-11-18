DEF MAX_LEVEL EQU 100

; wMoveMissed values. It is a REASON, not a boolean: the box that reports a
; failure can then say which failure it was, instead of calling everything a
; miss. Every other reader tests it with `and a` and only cares whether the
; move connected, so any non-zero value behaves exactly as 1 always did --
; checked against all fifteen read sites before these were introduced. Since
; PROTECT (2026-11-02) three more failure lines read the reason, to stay silent
; on MOVE_FAILED_PROTECTED: PrintButItFailedText_, PrintStatusMoveFailure (v1.0
; 2026-11-17, in place of PrintDidntAffectText; it also prints MoveEvadedText on
; MOVE_FAILED_EVADED) and LEECH SEED's miss line.
DEF MOVE_HIT               EQU 0
DEF MOVE_FAILED            EQU 1 ; an ordinary accuracy miss
DEF MOVE_FAILED_EVADED     EQU 2 ; the 1-in-256 roll on a 100%-accurate move
DEF MOVE_FAILED_NO_SCRATCH EQU 3 ; it connected, and the damage rounded to zero
DEF MOVE_FAILED_PROTECTED  EQU 4 ; v1.0 (2026-11-02): the target PROTECTed itself; MoveHitTest has said so

; v1.0 (2026-11-17): the cause a refused status move hands PrintStatusMoveFailure in c
; (engine/battle/status_failure.asm): one line for each.
DEF STATUS_FAIL_SUBSTITUTE EQU 0 ; "But, it failed!"
DEF STATUS_FAIL_STATUSED   EQU 1 ; "<TARGET>'s / already <the status it has>"
DEF STATUS_FAIL_CONFUSED   EQU 2 ; "<TARGET>'s / already confused!"
DEF STATUS_FAIL_IMMUNE     EQU 3 ; "It doesn't affect <TARGET>!"
DEF STATUS_FAIL_MISS       EQU 4 ; what PrintMoveFailureText says from wMoveMissed

; v1.0 (2026-11-17): what TargetStatusSlot (engine/battle/soft_status.asm) is asked in c: one of the two
; gates, or else the new status byte itself, which lands on the target (every status byte that lands is
; at least 1 << PSN, above both gates).
DEF TARGET_SLOT_ANY    EQU 0 ; is the target's hard-status slot taken?
DEF TARGET_SLOT_FREEZE EQU 1 ; the same, for a freeze: a slot that holds only sleep is open to it

; v1.0 (2026-11-17): a battle conditions byte (wPlayerMonConds / wEnemyMonConds, one per slot;
; engine/battle/soft_status.asm reads and writes them).
DEF BURN_BITES_MASK   EQU %00000111 ; the burn's bites left; 0 with BRN set = the fire is out
DEF BLEED_BITES_MASK  EQU %00111000 ; the bleed's bites left; 0 = not bleeding
DEF BLEED_LAYERS_MASK EQU %11000000 ; the bleed's layers minus 1, while it bleeds
DEF BURN_BITES_MIN    EQU 2 ; a burn bites 2 to 4 times, drawn uniformly when it is inflicted
DEF BURN_BITES_MAX    EQU 4
DEF BLEED_BITES_MIN   EQU 2 ; v1.0 (2026-11-18): a bleed bites 2 to 4 times, drawn uniformly at each infliction
DEF BLEED_BITES_MAX   EQU 4
DEF BLEED_LAYERS_MAX  EQU 4 ; a further bleed adds a layer, up to 4 (stored as layers minus 1)
	ASSERT BLEED_BITES_MAX << 3 <= BLEED_BITES_MASK && (BLEED_LAYERS_MAX - 1) << 6 == BLEED_LAYERS_MASK

; wBattleResult (ram/wram.asm): $00 won, $01 lost, $02 drew / ran / caught.
; v1.0 (2026-09-24): bit 7 rides on the $01 when the player gave a TRAINER
; battle up (RUN -> YES). TrainerBattleSurrenderPrompt sets it,
; PartyStandsAfterBattle reads it, ResetStatusAndHalveMoneyOnBlackout zeroes
; the byte. Every other reader tests the byte with `and a` (EndOfBattle,
; GetSavedEndBattleTextPointer, OaksLab.asm, PokemonTower6F on a wild battle) or
; `cp $2` on a wild battle (Route12/Route16), so the bit changes nothing they see.
DEF BATTLE_RESULT_LOSE EQU $01
DEF BATTLE_RESULT_SURRENDERED_F EQU 7

; maximum moves known per mon
DEF NUM_MOVES EQU 4

; significant stat values
DEF BASE_STAT_LEVEL EQU 7
DEF MAX_STAT_LEVEL EQU 13

; VitaminStats indexes (see data/battle/stat_names.asm)
	const_def 1
	const STAT_HEALTH
	const STAT_ATTACK
	const STAT_DEFENSE
	const STAT_SPEED
	const STAT_SPATK
	const STAT_SPDEF ; the split (2026-09-06): its own stat exp word and stat word; shares the Special DV
DEF NUM_STATS EQU const_value - 1
; The stat words after MaxHP in a mon struct (Attack..SP.DEF): what the badge
; bake, Haze and Transform copy, and what the "unmodified" blocks hold.
DEF NUM_BATTLE_STATS EQU NUM_STATS - 1
; The stats that have a stage byte (Attack, Defense, Speed, SP.ATK, SP.DEF):
; what the stage recalc loop and the badge walk cover, and
; where the ACCURACY byte starts. Every battle stat has one since the split's
; F2a (2026-09-06); the name survives for the places that mean "the staged
; ones" rather than "the stat words".
DEF NUM_STAGED_STATS EQU NUM_BATTLE_STATS

; StatModTextStrings indexes (see data/battle/stat_mod_names.asm)
	const_def
	const MOD_ATTACK
	const MOD_DEFENSE
	const MOD_SPEED
	const MOD_SPATK
	const MOD_SPDEF ; the split (F2a, 2026-09-06): its own stage byte, before ACCURACY (Gen 2 order); no ladder id, see effects.asm
	const MOD_ACCURACY
	const MOD_EVASION
	const_skip 1
DEF NUM_STAT_MODS EQU const_value
ASSERT MOD_SPDEF == MOD_SPATK + 1 && MOD_ACCURACY == MOD_SPDEF + 1 && MOD_EVASION == MOD_ACCURACY + 1, "the stage bytes follow the battle-stat order, then ACCURACY and EVASION"
; effects.asm gates the accuracy/evasion legs on "index >= MOD_ACCURACY", and the
; stage recalc walks NUM_STAGED_STATS stats: the two must agree.
ASSERT MOD_ACCURACY == NUM_STAGED_STATS, "the stat-stage bytes before ACCURACY must be exactly the NUM_STAGED_STATS staged stats"
ASSERT NUM_STAGED_STATS <= NUM_BATTLE_STATS, "a staged stat must exist as a stat word"

; Moves struct fields (see data/moves/moves.asm)
rsreset
DEF MOVE_ANIM   rb
DEF MOVE_EFFECT rb
DEF MOVE_POWER  rb
DEF MOVE_TYPE   rb
DEF MOVE_ACC    rb
DEF MOVE_PP     rb
DEF MOVE_LENGTH EQU _RS

; D733 flags
DEF BIT_TEST_BATTLE EQU 0

; wDifficulty values (set in Oak's speech, persistent for the run).
; Hard mode gates extra boss buffs in v0.7+ (see engine/battle/hard_mode.asm
; for the boss class list and the IsHardModeBossBattle helper). Existing
; non-boss-tied effects (level caps, forced Set mode, hard-mode ban on
; Revive/Max Revive and the Ether/Elixir family in trainer battles, 1/256
; miss preserved) gate on `wDifficulty != NORMAL_MODE`.
DEF NORMAL_MODE EQU 0
DEF HARD_MODE   EQU 1

; Hard mode boss item bag size (knob #10). 4 (item_id, count) pairs = 8 bytes.
; Entries past the boss's actual item count are padded with -1 in the item_id
; slot. wEnemyTrainerItemBag in wram is exactly this many bytes.
DEF BOSS_BAG_SIZE EQU 8

; battle type constants (wBattleType values)
	const_def
	const BATTLE_TYPE_NORMAL  ; 0
	const BATTLE_TYPE_OLD_MAN ; 1
	const BATTLE_TYPE_SAFARI  ; 2
	const BATTLE_TYPE_RUN     ; 3
	const BATTLE_TYPE_PIKACHU ; 4

; damage limits before type effectiveness
DEF MIN_NEUTRAL_DAMAGE EQU 2
DEF MAX_NEUTRAL_DAMAGE EQU 999

; fixed damage constants
DEF SONICBOOM_DAMAGE   EQU 25 ; was 20 (vanilla); buffed per biblia
DEF DRAGON_RAGE_DAMAGE EQU 50 ; was 40 (vanilla); buffed per biblia

; v0.7 crit-rate formula constants. Replaces vanilla Gen 1's broken
; "crit_rate = base_speed/2 (normal) or base_speed*8 capped (high-crit)"
; with a sane base + small speed bonus:
;   crit_rate (in /256 units) = base + base_speed/4
; Memorable as percentage points: 10% + speed/10 for normal moves,
; 20% + speed/10 for high-crit moves. Focus Energy then multiplies the
; final value by 3 (capped at 255). See engine/battle/core.asm
; CriticalHitTest. Vanilla's "guaranteed crit at 255 in normal mode"
; hack was removed (it was compensation for the vanilla speed*8 bug).
DEF CRIT_BASE_NORMAL       EQU 26 ; ~10.16% baseline (was: base_speed/2)
DEF CRIT_BASE_HIGH         EQU 51 ; ~19.92% baseline (was: base_speed*8 cap)
DEF FOCUS_ENERGY_CRIT_MULT EQU 3  ; was 4 in vanilla (the famous *4 not /4)

; type effectiveness factors, scaled by 10
DEF SUPER_EFFECTIVE    EQU 20
DEF MORE_EFFECTIVE     EQU 15
DEF EFFECTIVE          EQU 10
DEF NOT_VERY_EFFECTIVE EQU 05
DEF NO_EFFECT          EQU 00

; non-volatile statuses
DEF SLP_MASK EQU %111 ; 0-7 turns
	const_def 3
	const PSN ; 3
	const BRN ; 4
	const FRZ ; 5
	const PAR ; 6
; v1.0 (2026-11-11): a bad POISON (TOXIC), always together with PSN: a badly poisoned
; #MON's status byte is (1 << PSN) | (1 << TOX) = $88. PoisonEffect sets it when the
; move is TOXIC; it travels wherever the status byte is copied (party, roster, box,
; day care) and it is the only poison that bites out of battle. Read it with PSN: a
; bit 7 alone means nothing. Every cure writes the whole byte; RECOVER's easing of a bad
; POISON (2026-11-13) clears TOX alone, leaving PSN (engine/battle/toxic_carry.asm).
	const TOX ; 7
ASSERT TOX == 7 && PSN == 3, "a bad POISON's status byte is $88"

DEF MAX_STAT_VALUE EQU 999

; trainer dvs
DEF ATKDEFDV_TRAINER EQU $98
DEF SPDSPCDV_TRAINER EQU $88

; wPlayerBattleStatus1 or wEnemyBattleStatus1 bit flags
	const_def
	const STORING_ENERGY           ; 0 ; Bide
	const THRASHING_ABOUT          ; 1 ; e.g. Thrash
	const ATTACKING_MULTIPLE_TIMES ; 2 ; e.g. Double Kick, Fury Attack
	const FLINCHED                 ; 3
	const CHARGING_UP              ; 4 ; e.g. Solar Beam, Fly
	const USING_TRAPPING_MOVE      ; 5 ; e.g. Wrap
	const INVULNERABLE             ; 6 ; charging up Fly/Dig
	const CONFUSED                 ; 7

; wPlayerBattleStatus2 or wEnemyBattleStatus2 bit flags
	const_def
	const LOCKED_ON           ; 0 ; LOCK-ON: the user's moves never miss the target (v1.0 2026-11-02; was X Accuracy's, which nothing set since F7)
	const PROTECTED_BY_MIST   ; 1
	const GETTING_PUMPED      ; 2 ; Focus Energy
	const PROTECTING          ; 3 ; PROTECT worked this turn (v1.0 2026-11-02; was unused)
	const HAS_SUBSTITUTE_UP   ; 4
	const NEEDS_TO_RECHARGE   ; 5 ; Hyper Beam
	const PROTECTED_LAST_TURN ; 6 ; PROTECT worked the turn before: this turn's fails (v1.0 2026-11-02; was RAGE's dead bit)
	const SEEDED              ; 7

; wPlayerBattleStatus3 or wEnemyBattleStatus3 bit flags
	const_def
	const BADLY_POISONED      ; 0 ; the battler's status byte has TOX: kept equal to it by engine/battle/toxic_carry.asm (v1.0 2026-11-11)
	const HAS_LIGHT_SCREEN_UP ; 1
	const HAS_REFLECT_UP      ; 2
	const TRANSFORMED         ; 3
	const MOVED_THIS_TURN     ; 4 ; v1.0 (2026-11-02): this side's move has run this turn (a PROTECT after it fails)

; v1.0 (R11, 2026-10-02): wAITurnOrder's bits - the turn order the trainer AI has SEEN in this matchup
DEF AI_ORDER_PLAYER_FIRST EQU 0 ; the last order the screen showed (the speeds deciding it) had the player first
DEF AI_ORDER_PENDING      EQU 7 ; this turn's order is the speeds' and the player uses a move: the branch commits it
