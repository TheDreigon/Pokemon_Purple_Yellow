; v1.0 (Forte, 2026-09-23): the OLD AMBER errand. The museum's researcher asks
; the player by name to carry the amber to the LAB on CINNABAR, the lab
; acknowledges the museum, and the news makes admission free for good. Its own
; section (pinned in layout.link): Text 5, the museum's bank, sits 100 bytes
; above its floor. Every line under the press-A arrow is 17 tiles or less.

_Museum1FScientist2AmberRequestText::
	text "Hey! You're"
	line "<PLAYER>, right?"

	para "PROF.OAK told us"
	line "about you. Could"
	cont "we ask a favor?"

	para "Please take this"
	line "AMBER to the LAB"
	cont "on CINNABAR and"
	cont "tell them PEWTER"
	cont "MUSEUM sent you."

	para "We want to try to"
	line "revive it, but"
	cont "we're swamped"
	cont "right now."

	para "Will you do it?"
	done

_Museum1FScientist2AmberThanksText::
	text "Thank you so"
	line "much!"

	para "When you can,"
	line "come back and"
	cont "tell us how it"
	cont "went."
	done

_Museum1FScientist2AmberRefusedText::
	text "I see. It is a"
	line "lot to ask."

	para "If you pass by"
	line "CINNABAR one day,"
	cont "come see us"
	cont "first."
	done

_Museum1FScientist2AmberWaitingText::
	text "Any news from the"
	line "LAB on CINNABAR?"

	para "Come and tell us"
	line "how it went!"
	done

_Museum1FScientist2AmberRevivedText::
	text "It came back to"
	line "life? As an"
	cont "AERODACTYL!"

	para "You have done"
	line "the MUSEUM a"
	cont "great service."

	para "From now on, you"
	line "never pay to"
	cont "come in here."
	cont "Tell the front"
	cont "desk I said so!"
	done

_Museum1FScientist2AmberOnTheHouseText::
	text "Our AERODACTYL"
	line "friend! Come in"
	cont "any time, it's"
	cont "on the house."
	done

_Museum1FScientist1FreeAdmissionText::
	text "Oh! You're the"
	line "one who revived"
	cont "our AMBER!"

	para "Come right in,"
	line "no charge!"
	done

; the CINNABAR LAB, when the amber is handed in
_CinnabarLabPewterMuseumText::
	text "PEWTER MUSEUM"
	line "sent you? Then I"
	cont "do my very best"
	cont "work!"
	prompt
