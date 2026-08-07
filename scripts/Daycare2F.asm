Daycare2F_Script:
	jp EnableAutoTextBoxDrawing

Daycare2F_TextPointers:
	def_text_pointers
	dw_const Daycare2FNurseText,    TEXT_DAYCARE2F_NURSE
	dw_const Daycare2FChanseyText,  TEXT_DAYCARE2F_CHANSEY
	dw_const Daycare2FMrMimeText,   TEXT_DAYCARE2F_MR_MIME
	dw_const Daycare2FNidoranMText, TEXT_DAYCARE2F_NIDORAN_M
	dw_const Daycare2FCuboneText,   TEXT_DAYCARE2F_CUBONE
	dw_const Daycare2FSeelText,     TEXT_DAYCARE2F_SEEL
	dw_const Daycare2FClefairyText, TEXT_DAYCARE2F_CLEFAIRY

Daycare2FNurseText:
	text_far _Daycare2FNurseText
	text_end

Daycare2FChanseyText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FChanseyText
	text_asm
	ld a, CHANSEY
	call PlayCry
	jp TextScriptEnd

Daycare2FMrMimeText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FMrMimeText
	text_asm
	ld a, MR_MIME
	call PlayCry
	jp TextScriptEnd

Daycare2FNidoranMText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FNidoranMText
	text_asm
	ld a, NIDORAN_M
	call PlayCry
	jp TextScriptEnd

Daycare2FCuboneText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FCuboneText
	text_asm
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd

Daycare2FSeelText:
	text_far _Daycare2FSeelText
	text_asm
	ld a, SEEL
	call PlayCry
	jp TextScriptEnd

Daycare2FClefairyText:
	text_far _Daycare2FClefairyText
	text_asm
	ld a, CLEFAIRY
	call PlayCry
	jp TextScriptEnd
