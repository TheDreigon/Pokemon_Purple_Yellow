_MoveDeleterGreetingText::
	text "Want me to make a"
	line "#MON forget a"
	cont "move?"
	done

_MoveDeleterSaidYesText::
	text "Which #MON"
	line "should forget a"
	cont "move?"
	prompt

_MoveDeleterWhichMoveText::
	text "Which move should"
	line "it forget, then?"
	done

_MoveDeleterConfirmText::
	text "Make it forget"
	line "@"
	text_ram wStringBuffer
	text "?"
	prompt

_MoveDeleterForgotText::
	text "@"
	text_ram wStringBuffer
	text " was"
	line "forgotten!"
	prompt

_MoveDeleterByeText::
	text "Come visit me"
	line "again!"
	done

_MoveDeleterOneMoveText::
	text "That #MON"
	line "has one move."
	cont "Pick another?"
	done

; v1.0 (2026-09-24): the last party member that knows CUT or SURF keeps it
_MoveDeleterLastFieldMoveText::
	text "It's the only one"
	line "of yours that"
	cont "knows @"
	text_ram wStringBuffer
	text "!"
	cont "Teach another"
	cont "one first!"
	prompt