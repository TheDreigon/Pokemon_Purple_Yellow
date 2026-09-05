_ViridianForestYoungster1Text::
	text "I came here with"
	line "some friends!"

	para "They're out for"
	line "#MON fights!"
	done

_ViridianForestYoungster2BattleText::
	text "Hey! You have"
	line "#MON! Come on!"
	cont "Let's battle 'em!"
	done

_ViridianForestYoungster2EndBattleText::
	text "No!"
	line "CATERPIE can't"
	cont "cut it!"
	prompt

_ViridianForestYoungster2AfterBattleText::
	text "Ssh! You'll scare"
	line "the bugs away!"
	done

_ViridianForestYoungster3BattleText::
	text "Yo! You can't jam"
	line "out if you're a"
	cont "#MON trainer!"
	done

_ViridianForestYoungster3EndBattleText::
	text "Huh?"
	line "I ran out of"
	cont "#MON!"
	prompt

_ViridianForestYoungster3AfterBattleText::
	text "Darn! I'm going"
	line "to catch some"
	cont "stronger ones!"
	done

; v0.7 (2026-09-05, Forte): he guards the two-wide shortcut opened at
; (18-19, 20-21) in eff99feb - sight 1 LEFT covers (18,19), the only other
; entrance tile, so the gate is total. (Not the shortcut LASS, slot 8.)
_ViridianForestYoungster4BattleText::
	text "This way is a bit"
	line "of a shortcut..."

	para "But I'm not going"
	line "to let you pass!"
	done

; end-battle: "BUG CATCHER: " is 13 tiles, so the first row gets 5.
_ViridianForestYoungster4EndBattleText::
	text "Oh,"
	line "you can pass..."
	cont "You're strong."
	prompt

_ViridianForestYoungster4AfterBattleText::
	text "Go on, take the"
	line "shortcut."

	para "Sometimes you can"
	line "find stuff on the"
	cont "ground in here!"
	done

_ViridianForestCooltrainerFBattleText::
	text "Hi, do you have a"
	line "PIKACHU?"
	done

_ViridianForestCooltrainerFEndBattleText::
	text "Oh no,"
	line "really?"
	prompt

_ViridianForestCooltrainerFAfterBattleText::
	text "I looked forever,"
	line "but I never found"
	cont "a PIKACHU here!"

	para "I did run"
	line "into an ODDISH"
	cont "though!"
	done

_ViridianForestYoungster5BattleText::
	text "I'm gonna be the"
	line "best. You just"
	cont "can't beat me!"
	done

_ViridianForestYoungster5EndBattleText::
	text "After"
	line "all I did..."
	prompt

_ViridianForestYoungster5AfterBattleText::
	text "A METAPOD is cool"
	line "because its"
	cont "attack is its"
	cont "defense!"
	done

_ViridianForestYoungster6Text::
	text "I ran out of #"
	line "BALLs to catch"
	cont "#MON with!"

	para "You should carry"
	line "extras!"
	done


; v0.7 (2026-08-30, Forte): the western-corridor toll gate. His class tag
; renders "COOLTRAINER(m): " (12 tiles), so the end-battle first row gets 4.
_ViridianForestCooltrainerMBattleText::
	text "Check out my"
	line "SCYTHER and my"
	cont "PINSIR! So cool,"
	cont "so strong!"

	para "Planning to reach"
	line "PEWTER CITY to"
	cont "challenge BROCK?"

	para "Hah! You'll have"
	line "to get past me"
	cont "first!"
	done

_ViridianForestCooltrainerMEndBattleText::
	text "Ugh!"
	line "Cool isn't"
	cont "enough..."
	prompt

_ViridianForestCooltrainerMAfterBattleText::
	text "Fine, they're"
	line "cool AND you're"
	cont "strong."

	para "BROCK's rock-hard"
	line "team is next."
	cont "Good luck!"
	done
