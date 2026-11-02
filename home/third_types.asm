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

INCLUDE "data/pokemon/third_types.asm"
