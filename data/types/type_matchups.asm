; Type effectiveness table for Pokémon Purple Yellow.
;
; Spec:
;   Pokemon_Purple_Yellow - Notes/Type matchups Pokemon Purple Yellow.asm
;
; Each entry is `db ATTACKER, DEFENDER, MULTIPLIER`.
; MULTIPLIER is one of SUPER_EFFECTIVE / NOT_VERY_EFFECTIVE / NO_EFFECT.
; Anything not listed defaults to EFFECTIVE (1x). Terminator is `db -1`.
;
; Sections grouped by attacker; within a section: SE first, then NVE,
; then NO_EFFECT. Bilateral consistency verified against the spec doc
; (every offensive entry matches the defender's defensive view).
;
; Highlights vs vanilla Gen 1:
;  - New types: Steel, Dark, Fairy, Magma, Fungus, Gas.
;  - Dragon moved to PHYSICAL; gains Fighting/Steel/Fairy/Ice weaknesses.
;  - Bug becomes the anti-mental specialist: SE vs Psychic + Dark + Ghost,
;    and resists all three.
;  - Ghost SE vs Dark; Ghost vs Normal is now neutral (no longer no-effect).
;  - Normal weak TO Dark + Fighting; no longer immune to Ghost.
;  - Magma is immune to Fire (only Magmar exists as a Magma-type here).
;  - Gas is immune to Ground (the obvious physics joke).
;  - Steel keeps its huge resist list but loses Psychic/Dark/Ghost resists.
;  - Ice continues SE vs Dragon (convention) and gains Fungus/Bug/Gas SE coverage.
;  - Poison gets Fairy + Fungus SE; can't hit Steel.
;  - Fighting gets Dragon + Steel + Dark SE; weak TO Fairy.

TypeEffects:
	;  attacker,     defender,     *=

; ===== NORMAL =====
	db NORMAL,       ROCK,         NOT_VERY_EFFECTIVE
	db NORMAL,       FIGHTING,     NOT_VERY_EFFECTIVE
	db NORMAL,       STEEL,        NOT_VERY_EFFECTIVE
	db NORMAL,       DARK,         NOT_VERY_EFFECTIVE
	db NORMAL,       GAS,          NOT_VERY_EFFECTIVE
	db NORMAL,       MAGMA,        NOT_VERY_EFFECTIVE
	db NORMAL,       GHOST,        NO_EFFECT

; ===== FIRE =====
	db FIRE,         GRASS,        SUPER_EFFECTIVE
	db FIRE,         ICE,          SUPER_EFFECTIVE
	db FIRE,         BUG,          SUPER_EFFECTIVE
	db FIRE,         STEEL,        SUPER_EFFECTIVE
	db FIRE,         FAIRY,        SUPER_EFFECTIVE
	db FIRE,         GAS,          SUPER_EFFECTIVE
	db FIRE,         FUNGUS,       SUPER_EFFECTIVE
	db FIRE,         FIRE,         NOT_VERY_EFFECTIVE
	db FIRE,         WATER,        NOT_VERY_EFFECTIVE
	db FIRE,         ROCK,         NOT_VERY_EFFECTIVE
	db FIRE,         GROUND,       NOT_VERY_EFFECTIVE
	db FIRE,         DRAGON,       NOT_VERY_EFFECTIVE
	db FIRE,         MAGMA,        NO_EFFECT

; ===== WATER =====
	db WATER,        FIRE,         SUPER_EFFECTIVE
	db WATER,        GROUND,       SUPER_EFFECTIVE
	db WATER,        ROCK,         SUPER_EFFECTIVE
	db WATER,        MAGMA,        SUPER_EFFECTIVE
	db WATER,        WATER,        NOT_VERY_EFFECTIVE
	db WATER,        GRASS,        NOT_VERY_EFFECTIVE
	db WATER,        GAS,          NOT_VERY_EFFECTIVE
	db WATER,        DRAGON,       NOT_VERY_EFFECTIVE
	db WATER,        FUNGUS,       NOT_VERY_EFFECTIVE

; ===== GRASS =====
	db GRASS,        WATER,        SUPER_EFFECTIVE
	db GRASS,        GROUND,       SUPER_EFFECTIVE
	db GRASS,        ROCK,         SUPER_EFFECTIVE
	db GRASS,        FIRE,         NOT_VERY_EFFECTIVE
	db GRASS,        GRASS,        NOT_VERY_EFFECTIVE
	db GRASS,        POISON,       NOT_VERY_EFFECTIVE
	db GRASS,        FLYING,       NOT_VERY_EFFECTIVE
	db GRASS,        BUG,          NOT_VERY_EFFECTIVE
	db GRASS,        STEEL,        NOT_VERY_EFFECTIVE
	db GRASS,        FAIRY,        NOT_VERY_EFFECTIVE
	db GRASS,        MAGMA,        NOT_VERY_EFFECTIVE
	db GRASS,        FUNGUS,       NOT_VERY_EFFECTIVE
	db GRASS,        DRAGON,       NOT_VERY_EFFECTIVE

; ===== ELECTRIC =====
	db ELECTRIC,     WATER,        SUPER_EFFECTIVE
	db ELECTRIC,     FLYING,       SUPER_EFFECTIVE
	db ELECTRIC,     BUG,          SUPER_EFFECTIVE
	db ELECTRIC,     GAS,          SUPER_EFFECTIVE
	db ELECTRIC,     STEEL,        SUPER_EFFECTIVE
	db ELECTRIC,     GRASS,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     NOT_VERY_EFFECTIVE
	db ELECTRIC,     ROCK,         NOT_VERY_EFFECTIVE
	db ELECTRIC,     DRAGON,       NOT_VERY_EFFECTIVE
	db ELECTRIC,     GROUND,       NO_EFFECT

; ===== ICE =====
	db ICE,          GRASS,        SUPER_EFFECTIVE
	db ICE,          GROUND,       SUPER_EFFECTIVE
	db ICE,          FLYING,       SUPER_EFFECTIVE
	db ICE,          BUG,          SUPER_EFFECTIVE
	db ICE,          GAS,          SUPER_EFFECTIVE
	db ICE,          FUNGUS,       SUPER_EFFECTIVE
	db ICE,          DRAGON,       SUPER_EFFECTIVE
	db ICE,          FIRE,         NOT_VERY_EFFECTIVE
	db ICE,          ICE,          NOT_VERY_EFFECTIVE
	db ICE,          MAGMA,        NOT_VERY_EFFECTIVE
	db ICE,          STEEL,        NOT_VERY_EFFECTIVE

; ===== FIGHTING =====
	db FIGHTING,     ICE,          SUPER_EFFECTIVE
	db FIGHTING,     ROCK,         SUPER_EFFECTIVE
	db FIGHTING,     DRAGON,       SUPER_EFFECTIVE
	db FIGHTING,     DARK,         SUPER_EFFECTIVE
	db FIGHTING,     STEEL,        SUPER_EFFECTIVE
	db FIGHTING,     NORMAL,       SUPER_EFFECTIVE
	db FIGHTING,     POISON,       NOT_VERY_EFFECTIVE
	db FIGHTING,     FLYING,       NOT_VERY_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db FIGHTING,     BUG,          NOT_VERY_EFFECTIVE
	db FIGHTING,     FAIRY,        NOT_VERY_EFFECTIVE
	db FIGHTING,     GHOST,        NO_EFFECT

; ===== POISON =====
	db POISON,       GRASS,        SUPER_EFFECTIVE
	db POISON,       BUG,          SUPER_EFFECTIVE
	db POISON,       FAIRY,        SUPER_EFFECTIVE
	db POISON,       FUNGUS,       SUPER_EFFECTIVE
	db POISON,       POISON,       NOT_VERY_EFFECTIVE
	db POISON,       GROUND,       NOT_VERY_EFFECTIVE
	db POISON,       ROCK,         NOT_VERY_EFFECTIVE
	db POISON,       GHOST,        NOT_VERY_EFFECTIVE
	db POISON,       PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db POISON,       ICE,          NOT_VERY_EFFECTIVE
	db POISON,       FIGHTING,     NOT_VERY_EFFECTIVE
	db POISON,       MAGMA,        NOT_VERY_EFFECTIVE
	db POISON,       STEEL,        NO_EFFECT

; ===== GROUND =====
	db GROUND,       FIRE,         SUPER_EFFECTIVE
	db GROUND,       ELECTRIC,     SUPER_EFFECTIVE
	db GROUND,       POISON,       SUPER_EFFECTIVE
	db GROUND,       ROCK,         SUPER_EFFECTIVE
	db GROUND,       STEEL,        SUPER_EFFECTIVE
	db GROUND,       MAGMA,        SUPER_EFFECTIVE
	db GROUND,       GRASS,        NOT_VERY_EFFECTIVE
	db GROUND,       BUG,          NOT_VERY_EFFECTIVE
	db GROUND,       GHOST,        NOT_VERY_EFFECTIVE
	db GROUND,       FUNGUS,       NOT_VERY_EFFECTIVE
	db GROUND,       FLYING,       NO_EFFECT
	db GROUND,       GAS,          NO_EFFECT

; ===== FLYING =====
	db FLYING,       GRASS,        SUPER_EFFECTIVE
	db FLYING,       FIGHTING,     SUPER_EFFECTIVE
	db FLYING,       BUG,          SUPER_EFFECTIVE
	db FLYING,       GAS,          SUPER_EFFECTIVE
	db FLYING,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db FLYING,       ROCK,         NOT_VERY_EFFECTIVE
	db FLYING,       STEEL,        NOT_VERY_EFFECTIVE

; ===== BUG =====
	db BUG,          GRASS,        SUPER_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, SUPER_EFFECTIVE
	db BUG,          DARK,         SUPER_EFFECTIVE
	db BUG,          GHOST,        SUPER_EFFECTIVE
	db BUG,          FIRE,         NOT_VERY_EFFECTIVE
	db BUG,          FIGHTING,     NOT_VERY_EFFECTIVE
	db BUG,          FLYING,       NOT_VERY_EFFECTIVE
	db BUG,          ROCK,         NOT_VERY_EFFECTIVE
	db BUG,          STEEL,        NOT_VERY_EFFECTIVE
	db BUG,          FAIRY,        NOT_VERY_EFFECTIVE
	db BUG,          GAS,          NOT_VERY_EFFECTIVE
	db BUG,          MAGMA,        NOT_VERY_EFFECTIVE
	db BUG,          FUNGUS,       NOT_VERY_EFFECTIVE

; ===== ROCK =====
	db ROCK,         ICE,          SUPER_EFFECTIVE
	db ROCK,         FLYING,       SUPER_EFFECTIVE
	db ROCK,         BUG,          SUPER_EFFECTIVE
	db ROCK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db ROCK,         GROUND,       NOT_VERY_EFFECTIVE
	db ROCK,         STEEL,        NOT_VERY_EFFECTIVE
	db ROCK,         GAS,          NOT_VERY_EFFECTIVE

; ===== DRAGON =====
	db DRAGON,       DRAGON,       SUPER_EFFECTIVE
	db DRAGON,       STEEL,        NOT_VERY_EFFECTIVE
	db DRAGON,       FAIRY,        NOT_VERY_EFFECTIVE

; ===== GHOST =====
	db GHOST,        PSYCHIC_TYPE, SUPER_EFFECTIVE
	db GHOST,        DARK,         SUPER_EFFECTIVE
	db GHOST,        BUG,          NOT_VERY_EFFECTIVE
	db GHOST,        GHOST,        NOT_VERY_EFFECTIVE

; ===== PSYCHIC =====
	db PSYCHIC_TYPE, FIGHTING,     SUPER_EFFECTIVE
	db PSYCHIC_TYPE, PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, BUG,          NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         NO_EFFECT

; ===== DARK =====
	db DARK,         PSYCHIC_TYPE, SUPER_EFFECTIVE
	db DARK,         GHOST,        SUPER_EFFECTIVE
	db DARK,         NORMAL,       SUPER_EFFECTIVE
	db DARK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db DARK,         DARK,         NOT_VERY_EFFECTIVE
	db DARK,         FAIRY,        NOT_VERY_EFFECTIVE
	db DARK,         BUG,          NOT_VERY_EFFECTIVE

; ===== STEEL =====
	db STEEL,        ICE,          SUPER_EFFECTIVE
	db STEEL,        ROCK,         SUPER_EFFECTIVE
	db STEEL,        DRAGON,       SUPER_EFFECTIVE
	db STEEL,        FAIRY,        SUPER_EFFECTIVE
	db STEEL,        FLYING,       SUPER_EFFECTIVE
	db STEEL,        FIRE,         NOT_VERY_EFFECTIVE
	db STEEL,        FIGHTING,     NOT_VERY_EFFECTIVE
	db STEEL,        ELECTRIC,     NOT_VERY_EFFECTIVE
	db STEEL,        STEEL,        NOT_VERY_EFFECTIVE
	db STEEL,        MAGMA,        NOT_VERY_EFFECTIVE
	db STEEL,        GAS,          NOT_VERY_EFFECTIVE

; ===== FAIRY =====
	db FAIRY,        FIGHTING,     SUPER_EFFECTIVE
	db FAIRY,        DRAGON,       SUPER_EFFECTIVE
	db FAIRY,        DARK,         SUPER_EFFECTIVE
	db FAIRY,        FIRE,         NOT_VERY_EFFECTIVE
	db FAIRY,        POISON,       NOT_VERY_EFFECTIVE
	db FAIRY,        STEEL,        NOT_VERY_EFFECTIVE

; ===== GAS (new) =====
	db GAS,          BUG,          SUPER_EFFECTIVE
	db GAS,          GRASS,        SUPER_EFFECTIVE
	db GAS,          ROCK,         NOT_VERY_EFFECTIVE
	db GAS,          GHOST,        NOT_VERY_EFFECTIVE
	db GAS,          FLYING,       NOT_VERY_EFFECTIVE
	db GAS,          FIRE,         NOT_VERY_EFFECTIVE
	db GAS,          MAGMA,        NOT_VERY_EFFECTIVE
	db GAS,          STEEL,        NOT_VERY_EFFECTIVE

; ===== MAGMA (new) =====
	db MAGMA,        GRASS,        SUPER_EFFECTIVE
	db MAGMA,        ICE,          SUPER_EFFECTIVE
	db MAGMA,        BUG,          SUPER_EFFECTIVE
	db MAGMA,        STEEL,        SUPER_EFFECTIVE
	db MAGMA,        FAIRY,        SUPER_EFFECTIVE
	db MAGMA,        FUNGUS,       SUPER_EFFECTIVE
	db MAGMA,        GAS,          SUPER_EFFECTIVE
	db MAGMA,        MAGMA,        NOT_VERY_EFFECTIVE
	db MAGMA,        DRAGON,       NOT_VERY_EFFECTIVE
	db MAGMA,        FIRE,         NOT_VERY_EFFECTIVE
	db MAGMA,        GROUND,       NOT_VERY_EFFECTIVE

; ===== FUNGUS (new) =====
	db FUNGUS,       GRASS,        SUPER_EFFECTIVE
	db FUNGUS,       BUG,          SUPER_EFFECTIVE
	db FUNGUS,       FIRE,         NOT_VERY_EFFECTIVE
	db FUNGUS,       ICE,          NOT_VERY_EFFECTIVE
	db FUNGUS,       POISON,       NOT_VERY_EFFECTIVE
	db FUNGUS,       MAGMA,        NOT_VERY_EFFECTIVE
	db FUNGUS,       STEEL,        NOT_VERY_EFFECTIVE

	db -1 ; end
