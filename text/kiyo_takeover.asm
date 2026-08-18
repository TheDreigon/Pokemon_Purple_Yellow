; The dojo-master takeover: KIYO's voice at the Viridian Gym, the promoted
; student's at the Fighting Dojo, and the four one-shot student rebattles
; (Forte approved the lines 2026-08-18). The cooldown line is the shared
; _GymRematchCooldownText — he queues with the other seven leaders.

_ViridianGymKiyoIntroKnowsYouText::
	text "KIYO: Hah! I know"
	line "that stance!"

	para "You are the one"
	line "who cleaned out"
	cont "my DOJO!"

	para "GIOVANNI left"
	line "this GYM standing"
	cont "empty."

	para "An empty GYM is"
	line "an insult to"
	cont "fighting spirit!"

	para "So I came down"
	line "from SAFFRON to"
	cont "hold this floor"
	cont "myself."

	para "My best student"
	line "holds the DOJO."
	cont "I hold VIRIDIAN!"

	para "Show me you are"
	line "still sharp!"
	done

_ViridianGymKiyoIntroStrangerText::
	text "I am KIYO! For"
	line "twenty years I"
	cont "held the FIGHTING"
	cont "DOJO in SAFFRON."

	para "GIOVANNI left"
	line "this GYM standing"
	cont "empty."

	para "An empty GYM is"
	line "an insult to"
	cont "fighting spirit!"

	para "Now this floor is"
	line "mine, and no one"
	cont "crosses it"
	cont "unbeaten!"
	done

_ViridianGymKiyoAcceptText::
	text "KIYO: HYAH!"
	line "Come at me!"
	done

_ViridianGymKiyoRefusedText::
	text "Firm your spirit"
	line "first. This floor"
	cont "waits."
	done

_ViridianGymKiyoWinText::
	text "HAH! Superb!"

	para "Every belt I own"
	line "says that should"
	cont "not have"
	cont "happened!"
	done

_ViridianGymKiyoHonorSpeechText::
	text "Stop! Before you"
	line "go..."

	para "In SAFFRON you"
	line "chose one of my"
	cont "two prize"
	cont "students."

	para "The other trained"
	line "on without you,"
	cont "and never once"
	cont "stopped."

	para "A fighting spirit"
	line "like yours"
	cont "deserves a"
	cont "partner like"
	cont "that."

	para "Take this as your"
	line "reward of honor!"
	done

_ViridianGymKiyoNoRoomText::
	text "...You carry too"
	line "much already."

	para "Make room. I will"
	line "wait, and we do"
	cont "not fight until"
	cont "my student is"
	cont "with you."
	done

; The promoted student of (3,4): his takeover speech is now the challenge of
; his one-shot fight as the new master.
_FightingDojoNewMasterChallengeText::
	text "MASTER KIYO went"
	line "down to VIRIDIAN!"

	para "An empty GYM is"
	line "an insult to"
	cont "fighting spirit!"

	para "He left the DOJO"
	line "in my hands."

	para "We train harder"
	line "than ever! HYAH!"

	para "Show me this"
	line "floor stays"
	cont "sharp!"
	done

_FightingDojoNewMasterDefeatText::
	text "Hwa! Arrgh!"
	line "Beaten, just like"
	cont "the MASTER"
	cont "before me!"
	prompt

_FightingDojoNewMasterAfterText::
	text "A loss is one"
	line "more stone in"
	cont "our wall."

	para "I study every"
	line "art now, even the"
	cont "way of the leek!"

	para "Train with us"
	line "anytime!"
	done

; The other three students' one-shot rebattles — each line echoes the
; student's own vanilla voice (the judge, the boulders, the trespassing).
_FightingDojoBlackbelt2RebattleText::
	text "I hear you're the"
	line "CHAMPION! Show me!"

	para "My POLIWRATH swims"
	line "through punches"
	cont "now!"
	done

_FightingDojoBlackbelt2RebattleEndText::
	text "Judge!"
	line "Full marks..."
	prompt

_FightingDojoBlackbelt2RebattleAfterText::
	text "Our new MASTER"
	line "never lets us"
	cont "slack."

	para "Next bout, the"
	line "judge raises MY"
	cont "hand!"
	done

_FightingDojoBlackbelt3RebattleText::
	text "Nothing tough"
	line "frightens me. And"
	cont "you're the"
	cont "toughest of all!"

	para "My MACHAMP splits"
	line "boulders with any"
	cont "of four arms!"
	done

_FightingDojoBlackbelt3RebattleEndText::
	text "Yow! Four arms,"
	line "and not one"
	cont "landed!"
	prompt

_FightingDojoBlackbelt3RebattleAfterText::
	text "Psychic power"
	line "used to frighten"
	cont "us."

	para "After your team?"
	line "Nothing does!"
	done

_FightingDojoBlackbelt4RebattleText::
	text "Hoohah! The"
	line "CHAMPION, back on"
	cont "our floor!"

	para "We evolved while"
	line "you were away."
	cont "One more bout!"
	done

_FightingDojoBlackbelt4RebattleEndText::
	text "Oof! Evolved, and"
	line "I still give up!"
	prompt

_FightingDojoBlackbelt4RebattleAfterText::
	text "The prime fighters"
	line "across the land"
	cont "train here."

	para "Today the primest"
	line "one taught the"
	cont "class!"
	done

; The eight gym trainers, once KIYO holds the gym. One line each, approved
; by Forte 2026-08-17 — including the Johto rumour.

_ViridianGymCooltrainerM1KiyoEraText::
	text "KIYO drills us"
	line "twice as hard as"
	cont "GIOVANNI did!"
	done

_ViridianGymHiker1KiyoEraText::
	text "The new LEADER"
	line "fights with his"
	cont "fists. I respect"
	cont "that!"
	done

_ViridianGymRocker1KiyoEraText::
	text "At night I still"
	line "hear GIOVANNI's"
	cont "PERSIAN."
	done

_ViridianGymHiker2KiyoEraText::
	text "A DOJO master,"
	line "running a GYM!"
	cont "What a time!"
	done

_ViridianGymCooltrainerM2KiyoEraText::
	text "GIOVANNI? They"
	line "say he fled to"
	cont "JOHTO, alone."
	done

_ViridianGymHiker3KiyoEraText::
	text "KIYO says a GYM"
	line "is a promise to"
	cont "the town."
	done

_ViridianGymRocker2KiyoEraText::
	text "No TEAM ROCKET"
	line "pin on my chest"
	cont "anymore. Good"
	cont "riddance!"
	done

_ViridianGymCooltrainerM3KiyoEraText::
	text "I could not beat"
	line "the old LEADER."

	para "I cannot beat"
	line "this one either!"
	done
