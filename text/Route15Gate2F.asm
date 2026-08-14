_Route15Gate2FOaksAideHiText::
	text "Hi! Remember me?"
	line "I'm PROF.OAK's"
	cont "AIDE!"

	para "I'm supposed to"
	line "give you an"
	cont "EXP.SHARE!"
	prompt

_Route15Gate2FOaksAideGotItemText::
	text "<PLAYER> got the"
	line "EXP.SHARE!"
	prompt

_Route15Gate2FOaksAideNoRoomText::
	text "Oh! I see you"
	line "don't have any"
	cont "room for the"
	cont "EXP.SHARE."
	done

_Route15Gate2FOaksAideExpAllText::
; v0.7 (#10): this used to describe the Gen 1 item -- everyone gains, and
; everyone gains LESS. Neither half is true any more, so the whole speech was
; rewritten rather than patched. `cont` lines stop at 17 characters; `#` is
; four tiles, which is why none of these say #MON.
	text "The EXP.SHARE"
	line "decides who gets"
	cont "the EXP you win."

	para "USE it and pick:"
	line "OFF shares with"
	cont "nobody."

	para "ONE gives half to"
	line "the LAST one in"
	cont "your party."

	para "TEAM splits it"
	line "evenly over"
	cont "everyone."

	para "It never makes"
	line "more EXP, mind."
	cont "It only moves it."
	done

_Route15Gate2FBinocularsText::
	text "Looked into the"
	line "binoculars."

	para "It looks like a"
	line "small island!"
	done
