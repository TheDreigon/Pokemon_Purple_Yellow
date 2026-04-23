FuchsiaMart_Script:
	call EnableAutoTextBoxDrawing
	ret

FuchsiaMart_TextPointers:
	def_text_pointers
	dw_const FuchsiaMartClerkText,         TEXT_FUCHSIAMART_CLERK
	dw_const FuchsiaMartMiddleAgedManText, TEXT_FUCHSIAMART_MIDDLE_AGED_MAN
	dw_const FuchsiaMartCooltrainerFText,  TEXT_FUCHSIAMART_COOLTRAINER_F

FuchsiaMartMiddleAgedManText:
	text_far _FuchsiaMartMiddleAgedManText
	text_end

FuchsiaMartCooltrainerFText:
	text_far _FuchsiaMartCooltrainerFText
	text_end

FuchsiaMartClerkText::
	; Phase B.3: 4 status TMs from the Game Corner spec sold here too.
	; Fuchsia is the "status / debuff" mart, fitting the poison theme
	; (Koga's gym town). TM_TOXIC is also Koga's gift, but sold here too
	; so the player isn't blocked if they miss the gift / want extras.
	; Regular items now come from the global tiered mart inventory; the
	; TMs below are appended as fixed extras.
	script_tiered_mart TM_CONFUSE_RAY, TM_THUNDER_WAVE, TM_IGNITE, TM_TOXIC