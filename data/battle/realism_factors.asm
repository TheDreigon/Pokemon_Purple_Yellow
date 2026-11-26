; v1.0 (2026-11-26): the realism factors. The chance a move's side effect has to give a status changes with the
; target's types: each row below adds or takes 10 points of chance (REALISM_STEP) for a #MON of that type, and the
; rows of all its types (type 1, type 2, its third: data/pokemon/third_types.asm) add up. The immunities stay where
; they are and come first: a WATER/ICE #MON is never frozen, whatever WATER's row says. The sum never takes a chance
; below 5 % (REALISM_FLOOR: only an immunity gives 0 %) nor above 100 %. AdjustStatusChance
; (engine/battle/soft_status.asm) reads it. The status moves' own chances (their accuracy) are not read yet.
; Each row: the status, the type, + or - (one step).

MACRO realism
	ASSERT \1 < NUM_REALISM_STATUSES
	IF STRCMP("\3", "+") == 0
		db \1, \2, REALISM_STEP
	ELIF STRCMP("\3", "-") == 0
		db \1, \2, -REALISM_STEP
	ELSE
		FAIL "realism: the third argument is + or -"
	ENDC
ENDM

RealismFactors:
	realism REALISM_BRN,       GHOST,        -
	realism REALISM_BRN,       WATER,        -
	realism REALISM_BRN,       DRAGON,       -
	realism REALISM_BRN,       GAS,          +
	realism REALISM_BRN,       GRASS,        +
	realism REALISM_BRN,       BUG,          +

	realism REALISM_FRZ,       GHOST,        -
	realism REALISM_FRZ,       GAS,          -
	realism REALISM_FRZ,       FIRE,         -
	realism REALISM_FRZ,       WATER,        +
	realism REALISM_FRZ,       GRASS,        +
	realism REALISM_FRZ,       DRAGON,       +

	realism REALISM_PAR,       GHOST,        -
	realism REALISM_PAR,       GAS,          -
	realism REALISM_PAR,       STEEL,        - ; (every STEEL #MON is ELECTRIC too today: immune)

	realism REALISM_PSN,       GHOST,        -
	realism REALISM_PSN,       GAS,          -
	realism REALISM_PSN,       ROCK,         -
	realism REALISM_PSN,       ICE,          -
	realism REALISM_PSN,       MAGMA,        -
	realism REALISM_PSN,       BUG,          +

	realism REALISM_SLP,       GHOST,        - ; (no move with power puts to sleep: for the status moves)

	realism REALISM_BLEED,     GAS,          -
	realism REALISM_BLEED,     ROCK,         -

	realism REALISM_CONFUSION, PSYCHIC_TYPE, -

	realism REALISM_FEAR,      DARK,         -
	realism REALISM_FEAR,      DRAGON,       -
	realism REALISM_FEAR,      FIGHTING,     -
	realism REALISM_FEAR,      NORMAL,       +

	realism REALISM_FLINCH,    DRAGON,       -
	realism REALISM_FLINCH,    ROCK,         -
	db -1 ; end
