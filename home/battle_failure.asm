; The two battle-failure text scripts, kept in the home bank.
;
; They belong beside AttackMissedText in Battle Core, and there is no room:
; that bank runs within single digits of its 16 KB in debug builds, which is
; also why the type-matchup lookups were moved out of it in v0.7. The home bank
; is mapped at all times, so PrintText follows an hl pointing here without any
; banking -- the only cost is that the labels need `::` to be visible from
; main.asm's object file.
MoveEvadedText::
	text_far _MoveEvadedText
	text_end

NoScratchText::
	text_far _NoScratchText
	text_end

; Moved here from Battle Core for the same reason: the bank had no room left.
; PrintText is a home routine, so this costs nothing but the `::`.
PrintDoesntAffectText::
	ld hl, DoesntAffectMonText
	jp PrintText

DoesntAffectMonText::
	text_far _DoesntAffectMonText
	text_end
