; TypeNames indexes (see data/types/names.asm)
	const_def

DEF PHYSICAL EQU const_value
	const NORMAL       ; $00
	const FIGHTING     ; $01
	const FLYING       ; $02
	const POISON       ; $03
	const GROUND       ; $04
	const ROCK         ; $05
	const BIRD         ; $06
	const BUG          ; $07

DEF SPECIAL EQU const_value
	const GHOST        ; $08
	const DARK         ; $09  ; new type (Purple Yellow)
	const FAIRY        ; $0A  ; new type (Purple Yellow)
	const STEEL        ; $0B  ; new type (Purple Yellow)
	const GAS          ; $0C  ; new type (Purple Yellow)
	const MAGMA        ; $0D  ; new type (Purple Yellow)
	const FUNGI        ; $0E  ; new type (Purple Yellow)

DEF UNUSED_TYPES EQU const_value
	const_next 20
DEF UNUSED_TYPES_END EQU const_value

; SPECIAL continued, doing this maintains trade functionality with crystal
	const FIRE         ; $14
	const WATER        ; $15
	const GRASS        ; $16
	const ELECTRIC     ; $17
	const PSYCHIC_TYPE ; $18
	const ICE          ; $19
	const DRAGON       ; $1A

DEF NUM_TYPES EQU const_value
