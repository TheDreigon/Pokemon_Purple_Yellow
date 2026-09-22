VermilionPidgeyHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

VermilionPidgeyHouse_TextPointers:
	def_text_pointers
	dw_const VermilionPidgeyHouseYoungsterText, TEXT_VERMILIONPIDGEYHOUSE_YOUNGSTER
	dw_const VermilionPidgeyHousePidgeyText,    TEXT_VERMILIONPIDGEYHOUSE_PIDGEY
	dw_const VermilionPidgeyHouseLetterText,    TEXT_VERMILIONPIDGEYHOUSE_LETTER

VermilionPidgeyHouseYoungsterText:
	text_far _VermilionPidgeyHouseYoungsterText
	text_end

VermilionPidgeyHousePidgeyText:
	text_far _VermilionPidgeyHousePidgeyText
	text_asm
	ld a, PIDGEY
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; v1.0 (2026-09-22): the letter keeps up with SAFFRON - after GIOVANNI is
; thrown out of SILPH CO. it no longer reports TEAM ROCKET as a problem.
VermilionPidgeyHouseLetterText:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, .Letter
	jr z, .print
	ld hl, .LetterSafe
.print
	call PrintText
	jp TextScriptEnd

.Letter
	text_far _VermilionPidgeyHouseLetterText
	text_end

.LetterSafe
	text_far _VermilionPidgeyHouseLetterSafeText
	text_end
