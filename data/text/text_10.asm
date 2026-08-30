; Text bank 10 (v0.7, 2026-08-30): opened when Text 9 ran down to 99 free
; bytes (the bank_slack_audit tripwire caught it). New far texts go here
; until this one fills too.
; v0.7 (2026-08-30, Forte's design): PROF.OAK's two aides wait here with
; the parcels. Both item descriptions are borrowed from the old gate text
; files; these are the duo's own lines.
_SaffronAidesGreetingText::
	text "Hey, <PLAYER>!"
	line "We've been"
	cont "looking all over"
	cont "for you!"

	para "PROF.OAK sent us"
	line "to deliver these"
	cont "parcels. He sent"
	cont "<RIVAL> his own"
	cont "already."

	para "We figured you'd"
	line "pass through"
	cont "SAFFRON sooner"
	cont "or later!"

	para "Here, this one's"
	line "from my pack!"
	prompt

_SaffronAidesMakeRoomText::
	text "Whoa, your BAG"
	line "is packed! We"
	cont "need room for"
	cont "BOTH parcels."

	para "Two free slots,"
	line "<PLAYER> - then"
	cont "we talk!"
	prompt

_SaffronAideItemfinderReceivedText::
	text "<PLAYER> received"
	line "the ITEMFINDER!@"
	text_end

_SaffronAideExpShareIntroText::
	text "And this one is"
	line "from MY pack!"
	prompt

_SaffronAideExpShareReceivedText::
	text "<PLAYER> received"
	line "the EXP.SHARE!@"
	text_end

_SaffronAide1FearText::
	text "Parcels"
	line "delivered! Now we"
	cont "just walk home"
	cont "past TEAM"
	cont "ROCKET..."

	para "...any decade"
	line "now."
	done

_SaffronAide2FearText::
	text "I'm not stepping"
	line "outside while"
	cont "TEAM ROCKET owns"
	cont "this town."

	para "PROF.OAK will"
	line "understand."
	done

_SaffronAidesSafeText::
	text "SAFFRON is safe"
	line "again! We're"
	cont "packing for the"
	cont "trip back to the"
	cont "lab."

	para "Thank you,"
	line "<PLAYER>!"
	done
