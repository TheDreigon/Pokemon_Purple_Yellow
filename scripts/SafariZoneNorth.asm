SafariZoneNorth_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneNorth_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,                   TEXT_SAFARIZONENORTH_PROTEIN
	dw_const PickUpItemText,                   TEXT_SAFARIZONENORTH_TM_DRAGON_CLAW
	dw_const SafariZoneNorthRestHouseSignText, TEXT_SAFARIZONENORTH_REST_HOUSE_SIGN
	dw_const SafariZoneNorthSignText,          TEXT_SAFARIZONENORTH_SIGN
	dw_const SafariZoneNorthTrainerTips2Text,  TEXT_SAFARIZONENORTH_TRAINER_TIPS_2

SafariZoneNorthRestHouseSignText:
	text_far _SafariZoneNorthRestHouseSignText
	text_end

SafariZoneNorthSignText:
	text_far _SafariZoneNorthSignText
	text_end

SafariZoneNorthTrainerTips2Text:
	text_far _SafariZoneNorthTrainerTips2Text
	text_end
