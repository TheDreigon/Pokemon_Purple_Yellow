; The two battle failures that Gen 1 reported as an ordinary miss.
;
; Its own floating section: "Text 2", where _AttackMissedText and its
; neighbours live, is pinned in layout.link and has no room -- the SAFARI sign
; had to move out of it in the same session. text_far reaches here from
; anywhere.
;
; <TARGET> is the defender, which is who both of these lines are about: one
; dodged, and the other shrugged the hit off.

_MoveEvadedText::
	text "<TARGET>"
	line "slipped aside!"
	prompt

_NoScratchText::
	text "It didn't leave a"
	line "scratch on"
	cont "<TARGET>!"
	prompt
