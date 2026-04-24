DEF MAX_LEVEL EQU 100

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
	const STAT_SPECIAL
DEF NUM_STATS EQU const_value - 1

; StatModTextStrings indexes (see data/battle/stat_mod_names.asm)
	const_def
	const MOD_ATTACK
	const MOD_DEFENSE
	const MOD_SPEED
	const MOD_SPECIAL
	const MOD_ACCURACY
	const MOD_EVASION
	const_skip 2
DEF NUM_STAT_MODS EQU const_value

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
	const USING_X_ACCURACY    ; 0
	const PROTECTED_BY_MIST   ; 1
	const GETTING_PUMPED      ; 2 ; Focus Energy
	const_skip                ; 3 ; unused
	const HAS_SUBSTITUTE_UP   ; 4
	const NEEDS_TO_RECHARGE   ; 5 ; Hyper Beam
	const USING_RAGE          ; 6
	const SEEDED              ; 7

; wPlayerBattleStatus3 or wEnemyBattleStatus3 bit flags
	const_def
	const BADLY_POISONED      ; 0
	const HAS_LIGHT_SCREEN_UP ; 1
	const HAS_REFLECT_UP      ; 2
	const TRANSFORMED         ; 3
