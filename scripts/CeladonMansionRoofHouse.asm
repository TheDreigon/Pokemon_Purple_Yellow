CeladonMansionRoofHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonMansionRoofHouse_TextPointers:
	def_text_pointers
	dw_const CeladonMansionRoofHouseProgrammerText,    TEXT_CELADONMANSION_ROOF_HOUSE_PROGRAMMER

; PURPLE the PROGRAMMER: a perfect score on his 10-question canon quiz earns
; PURPLE'S PATCH (logic in CeladonMansionRoofHouse_2.asm). The BALL that sat
; on his desk (the PORYGON, SILPH's now) was deleted 2026-09-22.
CeladonMansionRoofHouseProgrammerText:
	text_asm
	farcall RoofHouseProgrammerScript
	jp TextScriptEnd
