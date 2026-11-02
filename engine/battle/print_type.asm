; [wd0b5] = pokemon ID
; hl = dest addr
PrintMonType:
	call GetPredefRegisters
	push hl
	call GetMonHeader
	pop hl
	push hl
	ld a, [wMonHType1]
	call PrintType
	ld a, [wMonHType1]
	ld b, a
	ld a, [wMonHType2]
	cp b
	pop hl
	jr z, EraseType2Text
	ld bc, SCREEN_WIDTH * 2
	add hl, bc

; a = type
; hl = dest addr
PrintType:
	push hl
	jr PrintType_

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

; v1.0 (2026-11-02, AIRBORNE): "AIRBORNE" at hl for an AIRBORNE #MON (GetAirborne), nothing for the rest - the
; status screen's row 15, under the types, row 14 a margin. A trait of the species, not an ability.
; [wMonHIndex] = the #MON (internal): the header PrintMonTypesList just loaded.
PrintMonAirborne:
	call GetPredefRegisters
	ld a, [wMonHIndex]
	call GetAirborne
	cp -1
	ret z
	ld de, AirborneText
	jp PlaceString

AirborneText:
	db "AIRBORNE@"

; erase "TYPE2/" if the mon only has 1 type
EraseType2Text:
	ld a, " "
	ld bc, $13
	add hl, bc
	ld bc, $6
	jp FillMemory

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
