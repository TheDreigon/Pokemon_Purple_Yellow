MrPsychicsHouse_Script:
	jp EnableAutoTextBoxDrawing

MrPsychicsHouse_TextPointers:
	def_text_pointers
	dw_const MrPsychicsHouseMrPsychicText, TEXT_MRPSYCHICSHOUSE_MR_PSYCHIC

MrPsychicsHouseMrPsychicText:
	text_asm
	CheckEvent EVENT_GOT_TM35
	jr nz, .got_item
	ld hl, .YouWantedThisText
	call PrintText
	lb bc, TM_EXTRASENSORY, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedTM35Text
	call PrintText
	SetEvent EVENT_GOT_TM35
	jr .done
.bag_full
	ld hl, .TM35NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .TM35ExplanationText
	call PrintText
.done
	jp TextScriptEnd

.YouWantedThisText:
	text_far _MrPsychicsHouseMrPsychicYouWantedThisText
	text_end

.ReceivedTM35Text:
	text_far _MrPsychicsHouseMrPsychicReceivedTM35Text
	sound_get_item_1
	text_end

.TM35ExplanationText:
	text_far _MrPsychicsHouseMrPsychicTM35ExplanationText
	text_end

.TM35NoRoomText:
	text_far _MrPsychicsHouseMrPsychicTM35NoRoomText
	text_end
