; Stats that move effects can raise or lower
; The relevant move effect IDs correspond to the stats

StatModTextStrings:
	list_start StatModTextStrings
	li "ATTACK"
	li "DEFENSE"
	li "SPEED"
	li "SPECIAL"
	assert_list_length SPATK_DOWN_SIDE_EFFECT - ATTACK_DOWN_SIDE_EFFECT + 1
	li "SP.DEF" ; MOD_SPDEF (the split, F2a): no ladder id of its own, reached through wStatModIndexOverride
	assert_list_length MOD_SPDEF + 1
	li "ACCURACY"
	li "EVASION"
	assert_list_length NUM_STAT_MODS - 1 ; one byte is unused

; effects.asm turns an effect id into a ladder POSITION by subtracting the
; ladder's first id (StatModifierUpEffect / StatModifierDownEffect, and the
; side-effect map "sub ATTACK_DOWN_SIDE_EFFECT"), then into a stat-mod index:
; positions below MOD_SPDEF are the index, positions at or above it are one
; less than it (the split's F2a inserted SP.DEF's stage byte before ACCURACY;
; SP.DEF itself has no ladder id and is reached through wStatModIndexOverride).
; Each ladder must therefore list the stats in MOD_* order from MOD_ATTACK == 0,
; and the first position that needs the +1 must be ACCURACY's.
ASSERT MOD_ATTACK == 0, "the stat-mod indexes start at 0: effects.asm adds (effect - ladder base) to wPlayerMonStatMods"
ASSERT ACCURACY_UP1_EFFECT - ATTACK_UP1_EFFECT == MOD_SPDEF, "the shim's threshold: ACCURACY's ladder position is where SP.DEF's stage byte was inserted"
ASSERT DEFENSE_UP1_EFFECT - ATTACK_UP1_EFFECT == MOD_DEFENSE && SPEED_UP1_EFFECT - ATTACK_UP1_EFFECT == MOD_SPEED && SPATK_UP1_EFFECT - ATTACK_UP1_EFFECT == MOD_SPATK && ACCURACY_UP1_EFFECT - ATTACK_UP1_EFFECT + 1 == MOD_ACCURACY && EVASION_UP1_EFFECT - ATTACK_UP1_EFFECT + 1 == MOD_EVASION, "the +1 effect ladder must follow the MOD_* order (ACCURACY/EVASION one past SP.DEF)"
ASSERT DEFENSE_DOWN1_EFFECT - ATTACK_DOWN1_EFFECT == MOD_DEFENSE && SPEED_DOWN1_EFFECT - ATTACK_DOWN1_EFFECT == MOD_SPEED && SPATK_DOWN1_EFFECT - ATTACK_DOWN1_EFFECT == MOD_SPATK && ACCURACY_DOWN1_EFFECT - ATTACK_DOWN1_EFFECT + 1 == MOD_ACCURACY && EVASION_DOWN1_EFFECT - ATTACK_DOWN1_EFFECT + 1 == MOD_EVASION, "the -1 effect ladder must follow the MOD_* order (ACCURACY/EVASION one past SP.DEF)"
ASSERT DEFENSE_UP2_EFFECT - ATTACK_UP2_EFFECT == MOD_DEFENSE && SPEED_UP2_EFFECT - ATTACK_UP2_EFFECT == MOD_SPEED && SPATK_UP2_EFFECT - ATTACK_UP2_EFFECT == MOD_SPATK && ACCURACY_UP2_EFFECT - ATTACK_UP2_EFFECT + 1 == MOD_ACCURACY && EVASION_UP2_EFFECT - ATTACK_UP2_EFFECT + 1 == MOD_EVASION, "the +2 effect ladder must follow the MOD_* order (ACCURACY/EVASION one past SP.DEF)"
ASSERT DEFENSE_DOWN2_EFFECT - ATTACK_DOWN2_EFFECT == MOD_DEFENSE && SPEED_DOWN2_EFFECT - ATTACK_DOWN2_EFFECT == MOD_SPEED && SPATK_DOWN2_EFFECT - ATTACK_DOWN2_EFFECT == MOD_SPATK && ACCURACY_DOWN2_EFFECT - ATTACK_DOWN2_EFFECT + 1 == MOD_ACCURACY && EVASION_DOWN2_EFFECT - ATTACK_DOWN2_EFFECT + 1 == MOD_EVASION, "the -2 effect ladder must follow the MOD_* order (ACCURACY/EVASION one past SP.DEF)"
ASSERT DEFENSE_DOWN_SIDE_EFFECT - ATTACK_DOWN_SIDE_EFFECT == MOD_DEFENSE && SPEED_DOWN_SIDE_EFFECT - ATTACK_DOWN_SIDE_EFFECT == MOD_SPEED && SPATK_DOWN_SIDE_EFFECT - ATTACK_DOWN_SIDE_EFFECT == MOD_SPATK, "the -1 side-effect ladder must follow the MOD_* order"
