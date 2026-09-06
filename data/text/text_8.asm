_FlashLightsAreaText::
	text "A blinding FLASH"
	line "lights the area!"
	prompt

_WarpToLastPokemonCenterText::
	text "Warp to the last"
	line "#MON CENTER."
	done

_CannotUseTeleportNowText::
	text_ram wcd6d
	text " can't"
	line "use TELEPORT now."
	prompt

_CannotFlyHereText::
	text_ram wcd6d
	text " can't"
	line "FLY here."
	prompt

_NotHealthyEnoughText::
	text "Not healthy"
	line "enough."
	prompt

_NewBadgeRequiredText::
	text "No! A new BADGE"
	line "is required."
	prompt

; v0.7 (2026-09-06, Forte): a level-up CUT is a battle move until HM01 (the
; S.S.ANNE captain's) is in hand - the ship stays on the critical path. The
; text names neither: Forte wants no hand-holding.
_CutNeedsTechniqueText::
	text "It knows CUT, but"
	line "it lacks the"
	cont "right technique!"
	prompt

_CannotUseItemsHereText::
	text "You can't use items"
	line "here."
	prompt

_CannotGetOffHereText::
	text "You can't get off"
	line "here."
	prompt

_UsedStrengthText::
	text_ram wcd6d
	text " used"
	line "STRENGTH.@"
	text_end

_CanMoveBouldersText::
	text_ram wcd6d
	text " can"
	line "move boulders."
	done

_CurrentTooFastText::
	text "The current is"
	line "much too fast!"
	prompt

_CyclingIsFunText::
	text "Cycling is fun!"
	line "Forget SURFing!"
	prompt

_GotMonText::
	text "<PLAYER> got"
	line "@"
	text_ram wcd6d
	text "!@"
	text_end

_SentToBoxText::
	text "There's no more"
	line "room for #MON!"
	cont "@"
	text_ram wBoxMonNicks
	text " was"
	cont "sent to #MON"
	cont "BOX @"
	text_ram wStringBuffer
	text " on PC!"
	done

_BoxIsFullText::
	text "There's no more"
	line "room for #MON!"

	para "The #MON BOX"
	line "is full and can't"
	cont "accept any more!"

	para "Change the BOX at"
	line "a #MON CENTER!"
	done

_BoxIsFullReminderText::
	text "The #MON BOX"
	line "is now full."
	cont "It won't hold"
	cont "more #MON."

	para "Change the BOX at"
	line "a #MON CENTER!"
	prompt