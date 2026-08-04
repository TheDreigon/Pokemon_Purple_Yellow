; The player's MOTHER handing over the TRAINER MANUAL in Pallet Town.
; Kept out of text/PalletTown.asm because that file lives in "Text 8", pinned
; to bank $2D alongside "NPC Sprites 4", and this block ran it past the end of
; the bank. "Text 9" floats, so it is where text goes when a pinned bank is
; full -- and text is never the tight resource here, only the pinned banks are.

; v0.7: the TRAINER MANUAL hand-over. She catches the player at the north edge
; of town after the POKéDEX; the same manual is handed over indoors, in her own
; words, if the player goes home to say goodbye first.
_PalletTownMomCaughtYouText::
	text "MOM: <PLAYER>!"
	line "Wait!"

	para "You were going to"
	line "go explore KANTO"
	cont "without this."
	done

_PalletTownMomGotManualText::
	text "<PLAYER> received"
	line "the TRAINER"
	cont "MANUAL!@"
	text_end

_PalletTownMomExplainText::
	text "Every trainer's"
	line "first book."

	para "It won't catch a"
	line "#MON for you."

	para "But when you're"
	line "stuck, it will"
	cont "tell you why."
	done

_PalletTownMomBagFullText::
	text "Your pack is full,"
	line "dear."

	para "Make room and I'll"
	line "still be here."
	done

_PalletTownMomGoodbyeText::
	text "Read it when you"
	line "need it."

	para "And eat something."
	done

; Indoors: she was waiting, so there is no "wait!" -- she is pleased instead.
_RedsHouse1FMomGoodbyeManualText::
	text "MOM: You came to"
	line "say goodbye."

	para "That's my <PLAYER>."

	para "Then take this"
	line "with you."
	done
