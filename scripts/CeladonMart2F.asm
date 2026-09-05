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

; v0.7 (2026-09-05, Forte): the counter was regular shop (left) + damage TMs
; (right). The TMs moved up to 5F to sit beside the other TM clerk, the
; vitamins came down in their place, and the two here swapped so that the
; vitamins are on the LEFT and the regular shop on the RIGHT.
CeladonMart2FClerk1Text::
	; Item order follows the stats-screen stat order (ATK/DEF/SPC/SPD -
	; see StatsText in engine/pokemon/status_screen.asm), then ACC/HIT/GUARD.
	script_mart HP_UP, PROTEIN, IRON, CALCIUM, CARBOS, X_ATTACK, X_DEFEND, X_SPECIAL, X_SPEED, X_ACCURACY, DIRE_HIT, GUARD_SPEC

CeladonMart2FClerk2Text::
	; One of the two "elite" tiered mart clerks (the other: Indigo
	; Plateau). Sells T0..T8 like every regular mart, plus the post-E4
	; elite items (ETHER, ELIXIR, PP_UP, MAX_REVIVE) once the Elite Four
	; are beaten, plus the post-rematch elite items (MAX_ETHER,
	; MAX_ELIXIR, PP_MAX, RARE_CANDY) after the first E4 rematch.
	script_tiered_mart_elite
