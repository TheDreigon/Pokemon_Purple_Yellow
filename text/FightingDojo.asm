; v0.7 (Forte, 2026-08-18): the dojo losing SAFFRON's gym to the psychics is
; canon, but vanilla only ever gestures at it - the third student's line,
; "The only thing that frightens us is psychic power!", is the whole hint and
; it never says the word GYM. The master now says it outright, the first and
; only time the player meets him: once he is beaten he switches to the
; "stay and train" text below, so this fires exactly once per save.
;
; It also plants the post-League turn. "A GYM is not a building, it is
; whoever can hold it" is the man who later takes VIRIDIAN explaining
; himself in advance.
;
; Widths: this is a plain DisplayTextID box, NOT an end-battle text, so
; there is no "<CLASS>: " prefix eating the first row - text/line/para get
; all 18 tiles and cont gets 17.
_FightingDojoKarateMasterText::
	text "Grunt!"

	para "I am the KARATE"
	line "MASTER! I am the"
	cont "LEADER here!"

	para "Here. Not out"
	line "there. SAFFRON"
	cont "had one GYM once,"
	cont "and it was this"
	cont "floor."

	para "A GYM is not a"
	line "building. It is"
	cont "whoever can hold"
	cont "it."

	para "Show me you can."
	line "Expect no mercy!"

	para "Fwaaa!"
	done

_FightingDojoKarateMasterDefeatedText::
	text "Hwa!"
	line "Arrgh! Beaten!"
	prompt

_FightingDojoKarateMasterIWillGiveYouAPokemonText::
	text "Indeed, I have"
	line "lost!"

	para "But, I beseech"
	line "you, do not take"
	cont "our emblem as"
	cont "your trophy!"

	para "In return, I will"
	line "give you a prized"
	cont "fighting #MON!"

	para "Choose whichever"
	line "one you like!"
	done

_FightingDojoKarateMasterStayAndTrainWithUsText::
	text "Ho!"

	para "Stay and train at"
	line "Karate with us!"
	done

_FightingDojoBlackbelt1BattleText::
	text "Hoargh! Take your"
	line "shoes off!"
	done

_FightingDojoBlackbelt1EndBattleText::
	text "I give"
	line "up!"
	prompt

_FightingDojoBlackbelt1AfterBattleText::
	text "You wait 'til you"
	line "see our Master!"

	para "I'm a small fry"
	line "compared to him!"
	done

_FightingDojoBlackbelt2BattleText::
	text "I hear you're"
	line "good! Show me!"
	done

_FightingDojoBlackbelt2EndBattleText::
	text "Judge!"
	line "1 point!"
	prompt

_FightingDojoBlackbelt2AfterBattleText::
	text "Our Master is a"
	line "pro fighter!"
	done

_FightingDojoBlackbelt3BattleText::
	text "Nothing tough"
	line "frightens me!"

	para "I break boulders"
	line "for training!"
	done

_FightingDojoBlackbelt3EndBattleText::
	text "Yow!"
	line "Stubbed fingers!"
	prompt

_FightingDojoBlackbelt3AfterBattleText::
	text "The only thing"
	line "that frightens us"
	cont "is psychic power!"
	done

_FightingDojoBlackbelt4BattleText::
	text "Hoohah!"

	para "You're trespassing"
	line "in our FIGHTING"
	cont "DOJO!"
	done

_FightingDojoBlackbelt4EndBattleText::
	text "Oof!"
	line "I give up!"
	prompt

_FightingDojoBlackbelt4AfterBattleText::
	text "The prime fighters"
	line "across the land"
	cont "train here."
	done

_FightingDojoHitmonleePokeBallText::
	text "You want the"
	line "hard-kicking"
	cont "HITMONLEE?"
	done

_FightingDojoHitmonchanPokeBallText::
	text "You want the"
	line "piston-punching"
	cont "HITMONCHAN?"
	done

_FightingDojoBetterNotGetGreedyText::
	text "Better not get"
	line "greedy..."
	done
