TextScriptEndingText::
	text_end

TextScriptEnd::
	ld hl, TextScriptEndingText
	ret

ExclamationText::
	text_far _ExclamationText
	text_end

GroundRoseText::
	text_far _GroundRoseText
	text_end

BoulderText::
	text_far _BoulderText
	text_asm
	ld a, [wObtainedBadges]
; v0.7 HM remap (2026-08-31): STRENGTH is SABRINA's unlock now (was a
; hard-coded `bit 3` for RAINBOW). Mirror gate: .strength in
; engine/menus/start_sub_menus.asm.
	bit BIT_MARSHBADGE, a
	jr z, .done
	ld d, STRENGTH
	callfar HasPartyMove
	ld a, [wWhichTrade]
	and a 
	jr nz, .done 
	ld a, [wWhichPokemon]
	push af 
	call ManualTextScroll
	pop af 
	ld [wWhichPokemon], a 
	call GetPartyMonName2 
	ld a, [wWhichPokemon]
	ld hl, wPartySpecies
	ld c, a
	ld a, l
	add a, c
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]
	ld [wcf91], a
	predef PrintStrengthTxt
.done 
    jp TextScriptEnd 

MartSignText::
	text_far _MartSignText
	text_end

PokeCenterSignText::
	text_far _PokeCenterSignText
	text_end

PickUpItemText::
	text_asm
	predef PickUpItem
	jp TextScriptEnd
