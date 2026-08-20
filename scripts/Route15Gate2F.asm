Route15Gate2F_Script:
	jp DisableAutoTextBoxDrawing

Route15Gate2F_TextPointers:
	def_text_pointers
	dw_const Route15Gate2FOaksAideText,   TEXT_ROUTE15GATE2F_OAKS_AIDE
	dw_const Route15Gate2FBinocularsText, TEXT_ROUTE15GATE2F_BINOCULARS

Route15Gate2FOaksAideText:
	text_asm
	CheckEvent EVENT_GOT_EXP_ALL
	jr nz, .got_item
	ld hl, .Route15Gate2FOaksAideHiText
	call PrintText
	lb bc, EXP_ALL, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .Route15Gate2FOaksAideGotItemText
	call PrintText
	SetEvent EVENT_GOT_EXP_ALL
	jr .got_item
.bag_full
	ld hl, .Route15Gate2FOaksAideNoRoomText
	call PrintText
.got_item
	ld hl, .ExpAllText
	call PrintText
	jp TextScriptEnd
	
.Route15Gate2FOaksAideHiText:
	text_far _Route15Gate2FOaksAideHiText
	text_end
; The EXP.SHARE was the one gift in the game handed over in silence -- 55 of
; the 56 GiveItem sites play a get-item sound and this did not. The wait has to
; come from text_promptbutton rather than from a `prompt` inside the far text:
; PromptText waits and then falls into DoneText, so a jingle after the text_far
; would sound after the button instead of with the line. Sound, then wait, which
; is the order every other gift uses -- and the wait matters here because
; .got_item prints the EXP.SHARE explanation immediately afterwards.
.Route15Gate2FOaksAideGotItemText:
	text_far _Route15Gate2FOaksAideGotItemText
	sound_get_key_item
	text_promptbutton
	text_end
.Route15Gate2FOaksAideNoRoomText:
	text_far _Route15Gate2FOaksAideNoRoomText
	text_end
.ExpAllText:
	text_far _Route15Gate2FOaksAideExpAllText
	text_end

Route15Gate2FBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text_far _Route15Gate2FBinocularsText
	text_end
