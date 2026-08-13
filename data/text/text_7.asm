_PokemartGreetingText::
	text "Hi there!"
	next "May I help you?"
	done

_PokemonFaintedText::
	text_ram wcd6d
	text_start
	line "fainted!"
	done

_PlayerBlackedOutText::
	text "<PLAYER> is out of"
	line "useable #MON!"

	para "<PLAYER> blacked"
	line "out!"
	prompt

_RepelWoreOffText::
	text "Repel's effect"
	line "wore off."
	done

_RepelWoreOffUseAnotherText::
	text_ram wStringBuffer
	text "'s"
	line "effect wore off."

	para "Use another?"
	done

_PokemartBuyingGreetingText::
	text "Take your time."
	done

_PokemartTellBuyPriceText::
	text_ram wStringBuffer
	text "?"
	line "That will be"
	cont "¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text ". OK?"
	done

_PokemartBoughtItemText::
	text "Here you are!"
	line "Thank you!"
	prompt

_PokemartNotEnoughMoneyText::
	text "You don't have"
	line "enough money."
	prompt

_PokemartItemBagFullText::
	text "You can't carry"
	line "any more items."
	prompt

_PokemonSellingGreetingText::
	text "What would you"
	line "like to sell?"
	done

_PokemartTellSellPriceText::
	text "I can pay you"
	line "¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text " for that."
	done

_PokemartItemBagEmptyText::
	text "You don't have"
	line "anything to sell."
	prompt

_PokemartUnsellableItemText::
	text "I can't put a"
	line "price on that."
	prompt

_PokemartThankYouText::
	text "Thank you!"
	done

_PokemartAnythingElseText::
	text "Is there anything"
	line "else I can do?"
	done

_LearnedMove1Text::
	text_ram wLearnMoveMonName
	text " learned"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_WhichMoveToForgetText::
	text "Which move should"
	next "be forgotten?"
	done

; v0.7: forgetting a move used to happen the instant it was chosen, with no way
; back from a mis-press. Both moves are named, because the whole point of the
; five-move window is the comparison and the confirmation should not throw it
; away.
;
; wStringBuffer holds the move being LEARNED for the length of the flow (the
; callers fill it before predef LearnMove and the TM path saves it around the
; party menu); GetMoveName writes the one being dropped into wcd6d and leaves
; wStringBuffer alone -- which the shipped game already relies on, since
; "<MON> learned X!" prints from wStringBuffer after "forgot Y!" printed from
; wcd6d.
;
; ⚠️ Both lines land on EXACTLY 18 tiles at the longest move name (12), which is
; the whole budget. "Forget <OLD> and learn <NEW>?" -- the phrasing this is
; standing in for -- needs 19 on its first line alone.
; 🔴 text_start before the line break is load-bearing. `line` is only the
; newline CHARACTER (db "<LINE>"), and after a text_ram the processor reads the
; next byte as a COMMAND -- so a bare `line` there is not a command id, the text
; stops dead, and the second line never appears. text_start reopens a character
; run, which is what _ForgotAndText does for the same reason.
_ConfirmForgetMoveText::
	text "Learn @"
	text_ram wStringBuffer
	text_start
	line "over @"
	text_ram wcd6d
	text "?"
	done

_AbandonLearningText::
	text "Abandon learning"
	line "@"
	text_ram wStringBuffer
	text "?"
	done

_DidNotLearnText::
	text_ram wLearnMoveMonName
	text_start
	line "did not learn"
	cont "@"
	text_ram wStringBuffer
	text "!"
	prompt

_TryingToLearnText::
	text_ram wLearnMoveMonName
	text " is"
	line "trying to learn"
	cont "@"
	text_ram wStringBuffer
	text "!"

	para "But, @"
	text_ram wLearnMoveMonName
	text_start
	line "can't learn more"
	cont "than 4 moves!"

	para "Delete an older"
	line "move to make room"
	cont "for @"
	text_ram wStringBuffer
	text "?"
	done

_OneTwoAndText::
	text "1, 2 and...@"
	text_end

_PoofText::
	text " Poof!@"
	text_end

_ForgotAndText::
	text_start
	para "@"
	text_ram wLearnMoveMonName
	text " forgot"
	line "@"
	text_ram wcd6d
	text "!"

	para "And..."
	prompt

_HMCantDeleteText::
	text "HM techniques"
	line "can't be deleted!"
	prompt

_PokemonCenterWelcomeText::
	text "Welcome to our"
	line "#MON CENTER!"

	para "We heal your"
	line "#MON back to"
	cont "perfect health!"
	prompt

_ShallWeHealYourPokemonText::
	text "Shall we heal your"
	line "#MON?"
	done

_NeedYourPokemonText::
	text "OK. We'll need"
	line "your #MON."
	done

_TemPokemonOuNao::
	text "You don't have"
	line "any #MON!"
	done

_PokemonFightingFitText::
	text "Thank you!"
	line "Your #MON are"
	cont "fighting fit!"
	prompt

_PokemonCenterFarewellText::
	text "We hope to see"
	line "you again!"
	done

_LooksContentText::
	text "It looks very"
	line "content asleep."
	done

