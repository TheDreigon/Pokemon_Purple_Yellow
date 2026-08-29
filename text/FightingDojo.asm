; v0.7 (Forte, 2026-08-18): the dojo losing SAFFRON's gym to the psychics is
; canon and the game already tells it - but only from the winners' side. The
; Saffron Gym psychic says "There used to be 2 #MON GYMs in SAFFRON. The
; FIGHTING DOJO next door lost its GYM status when we went and creamed them!"
; (text/SaffronGym.asm), while the dojo itself never mentions it - its own
; students only manage "the only thing that frightens us is psychic power".
; The master now answers, in the one text every player who fights him reads.
;
; The COUNT here is load-bearing: SAFFRON had TWO gyms, not one, and this line
; must keep agreeing with the psychic across town. An earlier draft said "one
; GYM once" and contradicted him.
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

	para "SAFFRON had two"
	line "GYMs. They beat"
	cont "us, so now it"
	cont "has one."

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

_FightingDojoPrizeNotEarnedText::
	text "A prize #MON"
	line "sleeps in this"
	cont "BALL."

	para "Only those who"
	line "beat our MASTER"
	cont "may choose!"
	done
