_ViridianSchoolHouseBrunetteGirlText::
	text "Whew! I'm trying"
	line "to memorize all"
	cont "my notes."

	para "CUT is a STEEL-"
	line "type move taught"
	cont "by HM!"

	para "What's this?"
	line "I don't know"
	cont "what type HEAVY"
	cont "SLAM is!"
	done

_ViridianSchoolHouseLittleGirlText::
	text "Sis says #MON"
	line "will evolve"
	cont "if you train them"
	cont "nicely."

	para "There is no need"
	line "to trade them!"
	done

; The teacher's opening, shared by both branches -- ends in @ so a second
; text_far can continue the same box (see scripts/ViridianSchoolHouse_2.asm).
_ViridianSchoolHouseOfferMapText::
	text "Every student"
	line "leaves this"
	cont "school with a"
	cont "TOWN MAP.@"
	text_end

_ViridianSchoolHouseTakeOneText::
	text_start

	para "You can't learn"
	line "KANTO by walking"
	cont "into it blind."

	para "Here. Take one."
	done

_ViridianSchoolHouseAlreadyHasMapText::
	text_start

	para "...Ah. Yours is"
	line "right there in"
	cont "your BAG."

	para "Good. Then read"
	line "the blackboard"
	cont "before you go."
	done

_ViridianSchoolHouseMapBagFullText::
	text "Your BAG is full!"

	para "Come back when"
	line "you have room."
	done
