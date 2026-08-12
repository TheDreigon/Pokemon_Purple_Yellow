; Bill's post-League battle. He is not a trainer and the writing does not let
; him pretend to be one: he does not challenge, he asks; he does not want to
; win, he wants the readings. The player's whole team has passed through his
; storage system, so he has been looking at their data for years without ever
; meeting it.

_BillsHouseBillRematchChallengeText::
	text "CHAMPION! I saw"
	line "the whole thing"
	cont "happen from here."

	para "Every #MON you"
	line "ever caught has"
	cont "come through my"
	cont "storage system."

	para "I have read your"
	line "data for years."

	para "I would very much"
	line "like to meet it."

	para "Would you battle"
	line "a researcher?"
	done

_BillsHouseBillRematchAgainText::
	text "One more set of"
	line "readings? I never"
	cont "tire of them."
	done

_BillsHouseBillRematchAcceptedText::
	text "Wonderful! Please"
	line "don't hold back."

	para "Bad data is worse"
	line "than no data!"
	done

_BillsHouseBillRematchRefusedText::
	text "No trouble! I'll"
	line "be right here"
	cont "with my machines."
	done

_BillsHouseBillRematchCooldownText::
	text "I'm still working"
	line "through what you"
	cont "showed me!"

	para "Come and see me"
	line "after your next"
	cont "LEAGUE run."
	done

; He built the storage system, so he finds out the moment it is logged.
_BillsHouseBillMewText::
	text "Wait. WAIT!"

	para "The system logged"
	line "something new."

	para "You caught a MEW?"
	line "An actual MEW?"

	para "I turned myself"
	line "into a #MON to"
	cont "understand them."

	para "You went and"
	line "found the one"
	cont "that can be all"
	cont "of them."

	para "...I need to sit"
	line "down."
; prompt, not done: whatever he says next -- the garden offer, the rematch, the
; cooldown line -- is printed immediately after this, and `done` would wipe this
; last page before it could be read.
	prompt

_BillsHouseBillComeWithMeText::
	text "Ha! Nothing less"
	line "from a CHAMPION."

	para "There's something"
	line "I've wanted to"
	cont "show you for a"
	cont "long while."

	para "My garden. Come"
	line "with me!"
	done

; said at the wall, once he has crossed the room
_BillsHouseGardenThisWayText::
	text "It's through"
	line "here."

	para "Nobody goes in"
	line "but me. Consider"
	cont "it a CHAMPION's"
	cont "privilege."
	done

; the once-only follow-up, and only for a player who actually went in
_BillsHouseBillHowWasTheGardenText::
	text "So! What did you"
	line "think of the"
	cont "garden?"

	para "Don't tell a"
	line "soul. It's a"
	cont "secret."
	prompt ; falls through to the rematch offer, which prints straight after

; ...and the nudge for one who opened it and never went, which repeats
_BillsHouseBillGardenStillOutThereText::
	text "Well? It's still"
	line "out there."

	para "Go on. The back"
	line "way is open now."
	prompt ; same -- the rematch offer follows immediately

_BillsHouseBillPostBattleText::
	text "Fascinating! They"
	line "fight the way you"
	cont "raised them."

	para "I could see that"
	line "in the numbers,"
	cont "but seeing it is"
	cont "not the same."

	para "Thank you. That's"
	line "a paper, that is!"
	done
