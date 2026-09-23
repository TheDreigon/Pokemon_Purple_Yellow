; DAMIAN, who is giving away the CHARMANDER on Route 24.
;
; Vanilla had him mildly apologetic -- "I should release my CHARMANDER because
; it's weak" -- which reads as someone doing the kind thing badly. In the anime
; he is not kind: he leaves the Pokemon behind and tells himself it deserved it.
; That is the version here, in our own words.
;
; Its own floating section: these lines are longer than the ones they replace
; and "Text 4" is pinned in layout.link, so it went 2 bytes over its bank the
; moment they landed in text/Route24.asm. text_far reaches a floating section
; from anywhere, and this is the third time the pinned Text banks have forced
; the same move (see tmhmNames and Cerulean's second TRAINER TIPS sign).

_Route24DamianText1::
	text "I'm DAMIAN, and"
	line "that CHARMANDER"
	cont "is dead weight."

	para "It's slow. It's"
	line "soft. It won't"
	cont "ever be more."

	para "Take it or don't."
	line "Either way I'm"
	cont "leaving it here."
	done

_Route24DamianText2::
	text "Fine. Don't come"
	line "crying when it"
	cont "quits on you.@"
	text_end

_Route24DamianText3::
	text "Suit yourself."

	para "I'll walk it to"
	line "the bridge and"
	cont "leave it. Someone"
	cont "will take it."
	done

_Route24DamianText4::
	text "Still hauling"
	line "that thing"
	cont "around?"

	para "It'll quit on you"
	line "the moment it"
	cont "actually matters."
	done

; v1.0 (Forte, 2026-09-23): the CHAMPION walks past with a CHARMELEON or a
; CHARIZARD. He wants it back; it answers with its cry, and he backs down.
_Route24DamianGiveItBackText::
	text "DAMIAN: Hold on."
	line "That's the"
	cont "CHARMANDER I"
	cont "left here?"

	para "It's... strong."
	line "Look, I've had"
	cont "time to think."

	para "Give it back to"
	line "me. I was its"
	cont "trainer first."
	prompt ; wait here: the cry and his "!" answer the player's press, with the demand still on screen

_Route24DamianRefusedText::
	text_ram wcd6d
	text " turned"
	line "away from DAMIAN!"

	para "DAMIAN: ...Fine."
	line "Keep it."

	para "It never listened"
	line "to me anyway."
	done

_Route24DamianAfterText::
	text "DAMIAN: Don't"
	line "look at me like"
	cont "that. It chose."
	done
