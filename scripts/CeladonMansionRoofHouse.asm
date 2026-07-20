CeladonMansionRoofHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonMansionRoofHouse_TextPointers:
	def_text_pointers
	dw_const CeladonMansionRoofHouseProgrammerText,    TEXT_CELADONMANSION_ROOF_HOUSE_PROGRAMMER
	dw_const CeladonMansionRoofHousePrototypeBallText, TEXT_CELADONMANSION_ROOF_HOUSE_PROTOTYPE_BALL

; v0.7: the roof-house hiker is now PURPLE the PROGRAMMER, whose
; 8-question canon quiz unlocks the prototype PORYGON in the ball
; (replaces the free Eevee ball; logic in CeladonMansionRoofHouse_2.asm)
CeladonMansionRoofHouseProgrammerText:
	text_asm
	farcall RoofHouseProgrammerScript
	jp TextScriptEnd

CeladonMansionRoofHousePrototypeBallText:
	text_asm
	farcall RoofHousePrototypeBallScript
	jp TextScriptEnd
