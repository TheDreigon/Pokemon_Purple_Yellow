CinnabarMart_Script:
	jp EnableAutoTextBoxDrawing

CinnabarMart_TextPointers:
	def_text_pointers
	dw_const CinnabarMartClerkText,        TEXT_CINNABARMART_CLERK
	dw_const CinnabarMartSilphWorkerFText, TEXT_CINNABARMART_SILPH_WORKER_F
	dw_const CinnabarMartScientistText,    TEXT_CINNABARMART_SCIENTIST

CinnabarMartSilphWorkerFText:
	text_far _CinnabarMartSilphWorkerFText
	text_end

CinnabarMartScientistText:
	text_far _CinnabarMartScientistText
	text_end

CinnabarMartClerkText::
	; v0.7 TM rework (Forte spec): mid-tier damage. 6 TMs.
	; Regular items now come from the global tiered mart inventory; the
	; TMs below are appended as fixed extras.
	script_tiered_mart TM_LEECH_LIFE, TM_DAZZLE_GLEAM, TM_TAKE_DOWN, TM_BULLDOZE, TM_POISON_FANG, TM_IRON_HEAD