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
	; v0.5 TM rework (rev8 spec): utility/setup. 11 TMs per spec.
	script_mart TM_SWORDS_DANCE, TM_BULK_UP, TM_HONE_CLAWS, TM_CALM_MIND, TM_AGILITY, TM_DOUBLE_TEAM, TM_INTIMIDATE, TM_FAKE_TEARS, TM_SCARY_FACE, TM_REFLECT, TM_LIGHT_SCREEN

CeladonMart5FClerk2Text::
	; v0.5 mart rework: vitamins reordered (CALCIUM before CARBOS so the
	; Special vitamin sits ahead of Speed, matching the engine's stat
	; order); X-items reordered to ATK/DEF/SPC/SPD then ACC/HIT/GUARD.
	script_mart HP_UP, PROTEIN, IRON, CALCIUM, CARBOS, X_ATTACK, X_DEFEND, X_SPECIAL, X_SPEED, X_ACCURACY, DIRE_HIT, GUARD_SPEC