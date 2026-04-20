CeladonMart2F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart2F_TextPointers:
	def_text_pointers
	dw_const CeladonMart2FClerk1Text,           TEXT_CELADONMART2F_CLERK1
	dw_const CeladonMart2FClerk2Text,           TEXT_CELADONMART2F_CLERK2
	dw_const CeladonMart2FMiddleAgedManText,    TEXT_CELADONMART2F_MIDDLE_AGED_MAN
	dw_const CeladonMart2FGirlText,             TEXT_CELADONMART2F_GIRL
	dw_const CeladonMart2FCurrentFloorSignText, TEXT_CELADONMART2F_CURRENT_FLOOR_SIGN

CeladonMart2FMiddleAgedManText:
	text_far _CeladonMart2FMiddleAgedManText
	text_end

CeladonMart2FGirlText:
	text_far _CeladonMart2FGirlText
	text_end

CeladonMart2FCurrentFloorSignText:
	text_far _CeladonMart2FCurrentFloorSignText
	text_end

CeladonMart2FClerk1Text::
	script_mart POKE_BALL, GREAT_BALL, POTION, SUPER_POTION, REVIVE, SUPER_REPEL, FULL_HEAL, ANTIDOTE, PARLYZ_HEAL, AWAKENING, BURN_HEAL, ICE_HEAL

CeladonMart2FClerk2Text::
	; v0.5 TM rework (rev8 spec): early/mid damage. 12 TMs per spec.
	script_mart TM_FAINT_ATTACK, TM_DRAGON_CLAW, TM_KARATE_CHOP, TM_BIND, TM_SEISMIC_TOSS, TM_AERIAL_ACE, TM_NIGHT_SHADE, TM_QUICK_ATTACK, TM_BODY_SLAM, TM_ROCK_THROW, TM_IRON_TAIL, TM_WATER_PULSE
