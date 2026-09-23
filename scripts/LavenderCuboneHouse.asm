LavenderCuboneHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

LavenderCuboneHouse_TextPointers:
	def_text_pointers
	dw_const LavenderCuboneHouseBrunetteGirlText, TEXT_LAVENDERCUBONEHOUSE_BRUNETTE_GIRL

LavenderCuboneHouseBrunetteGirlText:
	text_asm
; v1.0 (2026-09-23): once the orphan left with the player (MR. FUJI's offer)
	CheckEvent EVENT_GOT_FUJI_CUBONE
	jr nz, .cubone_left
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, .PoorCubonesMotherText
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, .TheGhostIsGoneText
	call PrintText
	jr .done
.cubone_left
	ld hl, .CuboneLeftText
	call PrintText
.done
	jp TextScriptEnd

.PoorCubonesMotherText:
	text_far _LavenderCuboneHouseBrunetteGirlPoorCubonesMotherText
	text_end

.TheGhostIsGoneText:
	text_far _LavenderCuboneHouseBrunetteGirlGhostIsGoneText
	text_end

.CuboneLeftText:
	text_far _LavenderCuboneHouseBrunetteGirlCuboneLeftText
	text_end
