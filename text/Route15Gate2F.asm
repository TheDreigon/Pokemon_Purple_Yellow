; v0.7 (2026-08-30): the EXP.SHARE aide moved to the SAFFRON Pokecenter;
; his hi/receipt/no-room lines went with him. The description below stays
; here and is borrowed by Saffron's script (text_far reaches any bank).
; His old spot now holds a bird-counting YOUNGSTER.

_Route15Gate2FWatcherText::
	text "From up here I"
	line "can count the"
	cont "BIRD KEEPERS on"
	cont "the route."

	para "Nine! No, wait."
	line "Ten!"
	done

_Route15Gate2FOaksAideExpShareText::
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
