CeladonMart5F_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonMart5F_TextPointers:
	def_text_pointers
	dw_const CeladonMart5FGentlemanText,        TEXT_CELADONMART5F_GENTLEMAN
	dw_const CeladonMart5FSailorText,           TEXT_CELADONMART5F_SAILOR
	dw_const CeladonMart5FClerk1Text,           TEXT_CELADONMART5F_CLERK1
	dw_const CeladonMart5FClerk2Text,           TEXT_CELADONMART5F_CLERK2
	dw_const CeladonMart5FCurrentFloorSignText, TEXT_CELADONMART5F_CURRENT_FLOOR_SIGN

CeladonMart5FGentlemanText:
	text_far _CeladonMart5FGentlemanText
	text_end

CeladonMart5FSailorText:
	text_far _CeladonMart5FSailorText
	text_end

CeladonMart5FCurrentFloorSignText:
	text_far _CeladonMart5FCurrentFloorSignText
	text_end

CeladonMart5FClerk1Text::
	; TM clerk: utility/setup TMs.
	script_mart TM_SWORDS_DANCE, TM_BULK_UP, TM_CALM_MIND, TM_AGILITY, TM_INTIMIDATE, TM_CHARM, TM_FAKE_TEARS, TM_SCARY_FACE, TM_REFLECT, TM_LIGHT_SCREEN

CeladonMart5FClerk2Text::
	; TM clerk: early/mid damage TMs. v0.7 (2026-09-05, Forte): up from 2F, so
	; both TM clerks share this counter; the vitamins went down to 2F.
	script_mart TM_FAINT_ATTACK, TM_RAGE, TM_DRAGON_CLAW, TM_SHOCK_WAVE, TM_BIND, TM_SEISMIC_TOSS, TM_FLAME_BURST, TM_AERIAL_ACE, TM_NIGHT_SHADE, TM_ICY_PULSE, TM_QUICK_ATTACK, TM_BODY_SLAM, TM_EXTRASENSORY, TM_ROCK_THROW, TM_IRON_TAIL, TM_WATER_PULSE