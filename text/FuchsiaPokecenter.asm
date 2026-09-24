_FuchsiaPokecenterRockerText::
	text "You can't win"
	line "with just one"
	cont "strong #MON."

	para "It's tough, but"
	line "you have to raise"
	cont "them evenly."
	done

_FuchsiaPokecenterCooltrainerFText::
	text "There's a narrow"
	line "trail west of"
	cont "VIRIDIAN CITY."

	para "It goes to #MON"
	line "LEAGUE HQ."
	cont "The HQ governs"
	cont "all trainers."
	done

; v0.7 (#38): JOY's six texts moved to text/daycare_additions.asm with her. She
; is the DAYCARE gentleman's daughter now, and this is an ordinary POKeMON
; CENTER again.

; v1.0 (2026-09-25, Forte): the CHAMPION's room on a title defence: the rival names
; himself the challenger and the player the champ. It was in Text 9 (at its floor;
; Text 10 is full in the debug ROM) and was rewritten here, in Text 5.
_ChampionsRoomRivalRematchIntroText::
	text "Back again?"
	line "I've waited for"
	cont "you, <PLAYER>!"

	para "This time I'm the"
	line "challenger, and"
	cont "you're the champ."

	para "My team is ready"
	line "to take you down!"

	para "Ready to hand"
	line "over that title?"

	para "Let's do this!"
	line "No holding back!"
	done
