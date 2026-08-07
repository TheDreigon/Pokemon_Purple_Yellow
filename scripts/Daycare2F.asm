Daycare2F_Script:
	jp EnableAutoTextBoxDrawing

Daycare2F_TextPointers:
	def_text_pointers
	dw_const Daycare2FNurseText,    TEXT_DAYCARE2F_NURSE
	dw_const Daycare2FChanseyText,  TEXT_DAYCARE2F_CHANSEY
	dw_const Daycare2FMrMimeText,   TEXT_DAYCARE2F_MR_MIME
	dw_const Daycare2FNidoranFText, TEXT_DAYCARE2F_NIDORAN_F
	dw_const Daycare2FCuboneText,   TEXT_DAYCARE2F_CUBONE

Daycare2FNurseText:
	text_far _Daycare2FNurseText
	text_end

Daycare2FChanseyText:
	text_asm
	ld a, CHANSEY
	call PlayCry ; ring out over the text box; waiting here delayed the text (Forte)
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _Daycare2FChanseyText
	text_end

Daycare2FMrMimeText:
	text_asm
	ld a, MR_MIME
	call PlayCry ; ring out over the text box; waiting here delayed the text (Forte)
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _Daycare2FMrMimeText
	text_end

Daycare2FNidoranFText:
	text_asm
	ld a, NIDORAN_F
	call PlayCry ; ring out over the text box; waiting here delayed the text (Forte)
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _Daycare2FNidoranFText
	text_end

Daycare2FCuboneText:
	text_asm
	ld a, CUBONE
	call PlayCry ; ring out over the text box; waiting here delayed the text (Forte)
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _Daycare2FCuboneText
	text_end
