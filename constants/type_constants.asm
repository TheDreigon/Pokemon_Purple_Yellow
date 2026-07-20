; TypeNames indexes (see data/types/names.asm)
;
; PURPLE YELLOW: the physical/special split is TYPE-BASED (Gen 1 convention):
; types with ID < SPECIAL use Attack/Defense, types >= SPECIAL use Special.
; We extended the PHYSICAL range to $00-$0C to fit the new physical types
; (DRAGON moved down from $1A; DARK, STEEL, MAGMA, FUNGUS added). FAIRY and
; GAS are in the SPECIAL range. GHOST moved from $08 to $0D so that the
; SPECIAL constant sits just above the extended physical block. The gap
; between SPECIAL/GHOST and FIRE is preserved to keep the trade slot layout.
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
	const DRAGON       ; $08  ; new physical (Purple Yellow; moved from $1A)
	const DARK         ; $09  ; new type (Purple Yellow)
	const STEEL        ; $0A  ; new type (Purple Yellow)
	const MAGMA        ; $0B  ; new type (Purple Yellow)
	const FUNGUS       ; $0C  ; new type (Purple Yellow)

DEF SPECIAL EQU const_value
	const GHOST        ; $0D  ; moved from $08 so SPECIAL sits above the extended physical range

DEF UNUSED_TYPES EQU const_value
	const_next 20
DEF UNUSED_TYPES_END EQU const_value

; SPECIAL continued. The gap above is kept so that trade layouts with
; Crystal still line up at $14 for FIRE onwards.
	const FIRE         ; $14
	const WATER        ; $15
	const GRASS        ; $16
	const ELECTRIC     ; $17
	const PSYCHIC_TYPE ; $18
	const ICE          ; $19
	const FAIRY ; $1A  ; new type (Purple Yellow)
	const GAS ; $1B  ; new type (Purple Yellow)

DEF NUM_TYPES EQU const_value
