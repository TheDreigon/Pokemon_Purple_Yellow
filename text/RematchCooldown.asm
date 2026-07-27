; v0.7 post-League rematch cooldown. Shown when the opponent's
; EVENT_REMATCHED_* flag is already set, i.e. the player has spent this
; League run's rematch against them. Beating the Elite Four again clears
; the whole block (scripts/HallOfFame.asm). Lines are <= 17 drawn tiles.
; The seven gym leaders share one text; JOY and JENNY keep their own voice.

_GymRematchCooldownText::
	text "We've already had"
	line "our rematch."

	para "I only take on"
	line "the reigning"
	cont "CHAMPION once."

	para "Defend your title"
	line "at the LEAGUE,"
	cont "then come back."
	done

_NurseJoyRematchCooldownText::
	text "Thank you again"
	line "for the battle!"

	para "But duty calls."
	line "My patients need"
	cont "me."

	para "Win the LEAGUE"
	line "again and I'll"
	cont "gladly ask once"
	cont "more."
	done

_JennyRematchCooldownText::
	text "We've had our"
	line "match already."

	para "I'm back on duty,"
	line "CHAMPION."

	para "Hold your LEAGUE"
	line "title again, and"
	cont "I'll ask for one"
	cont "more round."
	done
