Route5_Script:
	jp EnableAutoTextBoxDrawing

Route5_TextPointers:
	def_text_pointers
	dw_const Route5LittleGirlText,          TEXT_ROUTE5_LITTLE_GIRL
	dw_const Route5YoungsterText,           TEXT_ROUTE5_YOUNGSTER
	dw_const Route5UndergroundPathSignText, TEXT_ROUTE5_UNDERGROUND_PATH_SIGN
	dw_const Route5DaycareSignText,         TEXT_ROUTE5_DAYCARE_SIGN

Route5LittleGirlText:
	text_far _Route5LittleGirlText
	text_end

Route5YoungsterText:
; Complains about the gate guard until one of the Saffron guards gets his
; drink (wd728 bit 6, the same latch the gates themselves read), then
; celebrates the mood swing.
	text_asm
	ld a, [wd728]
	bit 6, a
	jr nz, .guardsAppeased
	ld hl, .StuckText
	call PrintText
	jp TextScriptEnd
.guardsAppeased
	ld hl, .AppeasedText
	call PrintText
	jp TextScriptEnd

.StuckText:
	text_far _Route5YoungsterText
	text_end

.AppeasedText:
	text_far _Route5YoungsterAppeasedText
	text_end

Route5UndergroundPathSignText:
	text_far _Route5UndergroundPathSignText
	text_end

Route5DaycareSignText:
	text_far _Route5DaycareSignText
	text_end
