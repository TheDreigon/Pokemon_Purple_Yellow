Route5_Script:
	jp EnableAutoTextBoxDrawing

Route5_TextPointers:
	def_text_pointers
	dw_const Route5LittleGirlText,          TEXT_ROUTE5_LITTLE_GIRL
	dw_const Route5YoungsterText,           TEXT_ROUTE5_YOUNGSTER
	dw_const Route5UndergroundPathSignText, TEXT_ROUTE5_UNDERGROUND_PATH_SIGN
	dw_const Route5DaycareSignText,         TEXT_ROUTE5_DAYCARE_SIGN

Route5LittleGirlText:
	text_far _Route5LittleGirlText
	text_end

Route5YoungsterText:
	text_far _Route5YoungsterText
	text_end

Route5UndergroundPathSignText:
	text_far _Route5UndergroundPathSignText
	text_end

Route5DaycareSignText:
	text_far _Route5DaycareSignText
	text_end
