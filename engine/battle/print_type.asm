; v1.0 (2026-11-07): dead, kept as a bare ret. Vanilla's "TYPE1/ TYPE2/" printer lost its
; callers to PrintMonTypesList (the status screen, the Pokedex DATA page and the Hall of Fame on
; 2026-11-02, the debug MON TEST on 2026-11-07); its EraseType2Text went with it. The row stays in
; data/predef_pointers.asm: predef ids are positional, so none after it moves.
PrintMonType:
	ret

; a = type
; hl = dest addr
PrintType:
	push hl
	jp PrintType_ ; (v1.0 2026-11-18: jp - "BLOODLESS" put it out of jr reach)

; v1.0 (2026-11-02, three types): a #MON's types as a list under one "TYPES/" label the caller places (the
; status screen, the Pokédex DATA page, the Hall of Fame): one name a row from hl down - type 1, type 2 when
; it differs, the third when it has one. [wd0b5] = the #MON (internal).
PrintMonTypesList:
	call GetPredefRegisters
	push hl
	call GetMonHeader
	pop hl
	ld a, [wMonHType1]
	call .name
	ld a, [wMonHType2]
	ld b, a
	ld a, [wMonHType1]
	cp b
	jr z, .third
	ld a, b
	call .name
.third
	ld a, [wMonHIndex]
	call GetThirdType
	cp -1
	ret z
	; fall through: the third name, the last
.name ; a = the type: its name at hl, then hl one row down
	push hl
	call PrintType
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	ret

; v1.0 (2026-11-02, AIRBORNE): "AIRBORNE" at hl for an AIRBORNE #MON (GetAirborne), "GROUNDED" for a GROUNDED one
; (2026-11-07), nothing for the rest - the status screen's row 15, under the types, row 14 a margin. A trait of
; the species, not an ability. [wMonHIndex] = the #MON (internal): the header PrintMonTypesList just loaded.
; v1.0 (2026-11-18): then "BLOODLESS" for a BLOODLESS #MON (IsSpeciesBloodless, data/pokemon/bloodless.asm, the
; list the bleed's gate reads): on the row after the air trait, or on row 15 itself when it has none. Nine letters
; do not fit the names' column (11-18: column 19 is the panel's right border), so it starts one column left, under
; "TYPES/": columns 10-18. Rows 15 and 16 of the panel hold nothing else.
PrintMonAirborne:
	call GetPredefRegisters
	ld a, [wMonHIndex]
	call GetAirborne
	cp -1
	jr z, .bloodless
	ld de, AirborneText
	cp GROUNDED_TRAIT
	jr nz, .place
	ld de, GroundedText
.place
	push hl
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc ; the next row
.bloodless
	ld a, [wMonHIndex]
	ld c, a
	call IsSpeciesBloodless
	ret nc
	ld de, BloodlessText
	dec hl ; column 10: nine letters end before the border
	jp PlaceString

	ASSERT BANK(IsSpeciesBloodless) == BANK(PrintMonAirborne), "PrintMonAirborne calls soft_status.asm near"

AirborneText:
	db "AIRBORNE@"

GroundedText:
	db "GROUNDED@"

BloodlessText:
	db "BLOODLESS@"

PrintMoveType:
	call GetPredefRegisters
	push hl
	ld a, [wPlayerMoveType]
; fall through

PrintType_:
	add a
	ld hl, TypeNames
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/types/names.asm"
