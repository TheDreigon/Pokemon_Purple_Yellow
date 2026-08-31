FieldMoveDisplayData:
	; move id, FieldMoveNames index, leftmost tile
	; (leftmost tile = -1 + tile column in which the first
	;  letter of the move's name should be displayed)
	db CUT,        1, $0C
	db FLY,        2, $0C
	; v0.7 anim split (2026-08-31): the dead 'db ANIM_B4' filler row was
	; REMOVED - with special indexes now 1-based and small, it would have
	; collided with a real move id in this move-keyed list.
	db SURF,       4, $0C
	db STRENGTH,   5, $0A
	db FLASH,      6, $0C
	db DIG,        7, $0C
	db TELEPORT,   8, $0A
	db SOFTBOILED, 9, $08
	db -1 ; end
