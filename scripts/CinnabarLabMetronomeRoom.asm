CinnabarLabMetronomeRoom_Script:
	jp EnableAutoTextBoxDrawing

CinnabarLabMetronomeRoom_TextPointers:
	def_text_pointers
	dw_const CinnabarLabMetronomeRoomScientist1Text, TEXT_CINNABARLABMETRONOMEROOM_SCIENTIST1
	dw_const CinnabarLabMetronomeRoomScientist2Text, TEXT_CINNABARLABMETRONOMEROOM_SCIENTIST2
	dw_const CinnabarLabMetronomeRoomPCText,         TEXT_CINNABARLABMETRONOMEROOM_PC_KEYBOARD
	dw_const CinnabarLabMetronomeRoomPCText,         TEXT_CINNABARLABMETRONOMEROOM_PC_MONITOR
	dw_const CinnabarLabMetronomeRoomAmberPipeText,  TEXT_CINNABARLABMETRONOMEROOM_AMBER_PIPE

CinnabarLabMetronomeRoomScientist1Text:
	text_asm
	CheckEvent EVENT_GOT_TM22
	jr nz, .got_item
	ld hl, .Text
	call PrintText
	lb bc, TM_METRONOME, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedTM22Text
	call PrintText
	SetEvent EVENT_GOT_TM22
	jr .done
.bag_full
	ld hl, .TM22NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .TM22ExplanationText
	call PrintText
.done
	jp TextScriptEnd

.Text:
	text_far _CinnabarLabMetronomeRoomScientist1Text
	text_end

.ReceivedTM22Text:
	text_far _CinnabarLabMetronomeRoomScientist1ReceivedTM22Text
	sound_get_item_1
	text_end

.TM22ExplanationText:
	text_far _CinnabarLabMetronomeRoomScientist1TM22ExplanationText
	text_end

.TM22NoRoomText:
	text_far _CinnabarLabMetronomeRoomScientist1TM22NoRoomText
	text_end

CinnabarLabMetronomeRoomScientist2Text:
	text_far _CinnabarLabMetronomeRoomScientist2Text
	text_end

CinnabarLabMetronomeRoomPCText:
	text_far _CinnabarLabMetronomeRoomPCText
	text_end

CinnabarLabMetronomeRoomAmberPipeText:
	text_far _CinnabarLabMetronomeRoomAmberPipeText
	text_end
