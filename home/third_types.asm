; v1.0 (2026-11-02): a #MON's third type (data/pokemon/third_types.asm). In the home bank because every
; reader asks it from its own bank: the chart walks (bank $30), STAB (Battle Core Overflow), the effects,
; the trainer AI, the status screen, the Pokédex and the Hall of Fame.
; In: a = the species (internal index). Out: a = the third type, or $FF for none ($FF is no type: it
; matches no row of the chart and no type test). Keeps bc, de, hl.
GetThirdType::
	push hl
	push bc
	ld b, a
	ld hl, ThirdTypes
.loop
	ld a, [hli]
	cp -1
	jr z, .done ; a = $FF: none
	cp b
	ld a, [hli] ; its third type (ld keeps the flags of the cp)
	jr nz, .loop
.done
	pop bc
	pop hl
	ret

; v1.0 (2026-11-02, AIRBORNE): In: a = the species (internal index). Out: a = FLYING when it is AIRBORNE
; (data/pokemon/airborne.asm), GROUNDED_TRAIT when it is GROUNDED (data/pokemon/grounded.asm, 2026-11-07),
; else $FF - FLYING because the chart walks let an AIRBORNE defender take GROUND's row against FLYING, and
; GROUNDED_TRAIT because they let a GROUNDED one skip it. Read by SetDefenderTraits and the status screen.
; Keeps bc, de, hl.
GetAirborne::
	push hl
	push bc
	ld b, a
	ld hl, AirborneMons
	ld c, FLYING
.loop
	ld a, [hli]
	cp -1
	jr z, .endOfList
	cp b
	jr nz, .loop
	ld a, c ; FLYING, or GROUNDED_TRAIT on the second list
	jr .done
.endOfList
	ld a, c
	cp GROUNDED_TRAIT
	ld a, -1
	jr z, .done ; both lists read: $FF, neither
	ld hl, GroundedMons
	ld c, GROUNDED_TRAIT
	jr .loop
.done
	pop bc
	pop hl
	ret

; v1.0 (2026-11-02): what the chart walks read of a defender beyond its two types, from its species -
; wDefenderType3 (GetThirdType) and wDefenderAirborne (GetAirborne), whose GROUND rows alone read it.
; Here, not in bank $30, because the switch-in scorer (bank $0E) sets them for its candidate too.
; In: a = the species (internal index). Keeps bc, de, hl.
SetDefenderTraits::
	push af
	call GetThirdType
	ld [wDefenderType3], a
	pop af
	call GetAirborne
	ld [wDefenderAirborne], a
	ret

INCLUDE "data/pokemon/third_types.asm"
INCLUDE "data/pokemon/airborne.asm"
INCLUDE "data/pokemon/grounded.asm"
