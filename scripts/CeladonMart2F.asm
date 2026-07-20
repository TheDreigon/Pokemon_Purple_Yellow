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
	; One of the two "elite" tiered mart clerks (the other: Indigo
	; Plateau). Sells T0..T8 like every regular mart, plus the post-E4
	; elite items (ETHER, ELIXER, PP_UP, MAX_REVIVE) once the Elite Four
	; are beaten, plus the post-rematch elite items (MAX_ETHER,
	; MAX_ELIXER, PP_MAX, RARE_CANDY) after the first E4 rematch.
	script_tiered_mart_elite

CeladonMart2FClerk2Text::
	; TM clerk: early/mid damage TMs.
	script_mart TM_FAINT_ATTACK, TM_RAGE, TM_DRAGON_CLAW, TM_SHOCK_WAVE, TM_BIND, TM_SEISMIC_TOSS, TM_FLAME_BURST, TM_AERIAL_ACE, TM_NIGHT_SHADE, TM_ICY_PULSE, TM_QUICK_ATTACK, TM_BODY_SLAM, TM_EXTRASENSORY, TM_ROCK_THROW, TM_IRON_TAIL, TM_WATER_PULSE
