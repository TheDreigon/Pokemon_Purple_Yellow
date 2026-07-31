Route2_Script:
	jp EnableAutoTextBoxDrawing

Route2_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,             TEXT_ROUTE2_LEAF_STONE
	dw_const PickUpItemText,             TEXT_ROUTE2_ETHER
	dw_const Route2SignText,             TEXT_ROUTE2_SIGN
	dw_const Route2DiglettsCaveSignText, TEXT_ROUTE2_DIGLETTS_CAVE_SIGN
	dw_const Route2ForestNorthSignText,  TEXT_ROUTE2_FOREST_NORTH_SIGN
	dw_const Route2ForestSouthSignText,  TEXT_ROUTE2_FOREST_SOUTH_SIGN

Route2SignText:
	text_far _Route2SignText
	text_end

Route2ForestNorthSignText:
	text_far _Route2ForestNorthSignText
	text_end

Route2ForestSouthSignText:
	text_far _Route2ForestSouthSignText
	text_end

Route2DiglettsCaveSignText:
	text_far _Route2DiglettsCaveSignText
	text_end
