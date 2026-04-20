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
	; Phase B.2: Cinnabar Mart (mid-tier damage). Medical items kept; 8 TMs per spec.
	script_mart ULTRA_BALL, HYPER_POTION, MAX_REPEL, ESCAPE_ROPE, FULL_HEAL, REVIVE, TM_DRAGON_RAGE, TM_EXTRASENSORY, TM_POISON_FANG, TM_DAZE_GLEAM, TM_BULLDOZE, TM_LEECH_LIFE, TM_IRON_HEAD, TM_TAKE_DOWN