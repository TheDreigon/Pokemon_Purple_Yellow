PewterMart_Script:
	call EnableAutoTextBoxDrawing
	ld a, TRUE
	ld [wAutoTextBoxDrawingControl], a
; The clerk greets a first-time visitor and explains that the shelves grow with
; your BADGES -- the one thing about this hack's marts a player cannot deduce by
; looking. Fires on entry rather than on talking to him because the tiered-mart
; text script must have its command as the FIRST byte, so no line can precede it
; in the same interaction. Same shape as Viridian's parcel scene.
	CheckEvent EVENT_PEWTER_MART_BADGE_ADVICE
	ret nz
	ld a, TEXT_PEWTERMART_CLERK_BADGE_ADVICE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_PEWTER_MART_BADGE_ADVICE
	ret

PewterMart_TextPointers:
	def_text_pointers
	dw_const PewterMartClerkText,     TEXT_PEWTERMART_CLERK
	dw_const PewterMartYoungsterText, TEXT_PEWTERMART_YOUNGSTER
	dw_const PewterMartSuperNerdText, TEXT_PEWTERMART_SUPER_NERD
	dw_const PewterMartBadgeAdviceText, TEXT_PEWTERMART_CLERK_BADGE_ADVICE

PewterMartYoungsterText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _PewterMartYoungsterText
	text_end

PewterMartSuperNerdText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _PewterMartSuperNerdText
	text_end

PewterMartBadgeAdviceText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _PewterMartBadgeAdviceText
	text_end

PewterMartClerkText::
	script_tiered_mart