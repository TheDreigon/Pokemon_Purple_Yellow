_CinnabarGymBlainePreBattleText::
	text "Hah!"

	para "I am BLAINE! I"
	line "am the LEADER of"
	cont "CINNABAR GYM!"

	para "My fiery #MON"
	line "will incinerate"
	cont "all challengers!"

	para "Hah! You better"
	line "have BURN HEAL!"
	done

_CinnabarGymBlaineReceivedVolcanoBadgeText::
	text "I have"
	line "burnt out!"

	para "You have earned"
	line "the VOLCANOBADGE!@"
	text_end

_CinnabarGymBlainePostBattleAdviceText::
	text "FIRE BLAST is the"
	line "ultimate fire"
	cont "technique!"

	para "Don't waste it on"
	line "water #MON!"
	done

_CinnabarGymRematchPreBattle1Text::
	text "Ah! The CHAMP!"
    
    para "I've stoked my"
    line "flames hotter"
    cont "than ever before!"
    
    para "Let's see if you"
    line "can withstand"
    cont "my inferno now!"
    
    para "Ready for a"
    line "rematch, CHAMP?"
	done

_CinnabarGymPreRematchBattle2Text::
	text "Hah! Fired up!"
    
    para "This battle will"
    line "be scorching!"
    done

_CinnabarGymRematchPostBattleText::
	text "Scorching!"
    
    para "Your strength"
    line "exceeds even the"
    cont "wildest flames!"
    
    para "Truly, you are a"
    line "worthy CHAMPION."
	done

_CinnabarGymBlaineVolcanoBadgeInfoText::
	text "Hah!"

; v1.0 (the SPECIAL split, 2026-09-06): VOLCANO lends SP.ATK.
	para "The VOLCANOBADGE"
	line "heightens the"
	cont "SP.ATK of your"
	cont "#MON!"

	para "Here, you can"
	line "have this too!"
	done

_CinnabarGymBlaineReceivedTMText::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_CinnabarGymBlaineTMExplanationText::
	text_start

	para "TM45 contains"
	line "FLAMETHROWER!"

	para "A scorching jet"
	line "of flames - may"
	cont "burn the foe!"

	para "Hot pick: VULPIX"
	line "or PONYTA!"
	done

_CinnabarGymBlaineTMNoRoomText::
	text "Make room for my"
	line "gift!"
	done

_CinnabarGymBlaineReceivedCandyText::
	text "<PLAYER> received"
	line "a RARE CANDY!@"
	text_end

_CinnabarGymBlaineCandyCommentText::
	text_start

	para "Stoke that fire"
	line "inside you!"
	done

; v1.0 (the gym rework, 2026-09-06): the first room is EVAN's (Pokemon
; Adventures - the Camper who looked after the gym while Blaine was away).
; The end line keeps a 5-tile first row: "JR.TRAINER♂: " goes first.
_CinnabarGymSuperNerd1BattleText::
	text "I'm EVAN! I mind"
	line "the GYM while"
	cont "BLAINE is away!"

	para "My HAUNTER's not"
	line "fire, but it will"
	cont "give you chills!"
	done

_CinnabarGymSuperNerd1EndBattleText::
	text "Aw,"
	line "nuts!"
	prompt

_CinnabarGymSuperNerd1AfterBattleText::
	text "Beat my HAUNTER?"

	para "Then go on, and"
	line "get ready for"
	cont "the quiz!"
	done

_CinnabarGymSuperNerd2BattleText::
	text "I was a thief, but"
	line "I became straight"
	cont "as a trainer!"
	done

_CinnabarGymSuperNerd2EndBattleText::
	text "I"
	line "surrender!"
	prompt

_CinnabarGymSuperNerd2AfterBattleText::
	text "I can't help"
	line "stealing other"
	cont "people's #MON!"
	done

_CinnabarGymSuperNerd3BattleText::
	text "You can't win!"
	line "I have studied"
	cont "#MON totally!"
	done

_CinnabarGymSuperNerd3EndBattleText::
	text "Waah!"
	line "My studies!"
	prompt

_CinnabarGymSuperNerd3AfterBattleText::
	text "My theories are"
	line "too complicated"
	cont "for you!"
	done

_CinnabarGymSuperNerd4BattleText::
	text "I just like using"
	line "fire #MON!"
	done

_CinnabarGymSuperNerd4EndBattleText::
	text "Too hot"
	line "to handle!"
	prompt

_CinnabarGymSuperNerd4AfterBattleText::
	text "I wish there was"
	line "a thief #MON!"
	cont "I'd use that!"
	done

_CinnabarGymSuperNerd5BattleText::
	text "I know why BLAINE"
	line "became a trainer!"
	
	para "I'll tell you if"
	line "you beat me!"
	done

_CinnabarGymSuperNerd5EndBattleText::
	text "Ow!"
	prompt

_CinnabarGymSuperNerd5AfterBattleText::
	text "BLAINE was lost"
	line "in the mountains"
	cont "when a fiery bird"
	cont "#MON appeared."

	para "Its light enabled"
	line "BLAINE to find"
	cont "his way down!"
	done

_CinnabarGymSuperNerd6BattleText::
	text "I've been to many"
	line "GYMs, but this is"
	cont "my favorite!"
	done

_CinnabarGymSuperNerd6EndBattleText::
	text "Yowza!"
	line "Too hot!"
	prompt

_CinnabarGymSuperNerd6AfterBattleText::
; v1.0 (2026-09-07): his own pair (VULPIX, NINETALES), not PONYTA - the audit's catch
	text "Us fire #MON"
	line "fans like VULPIX"
	cont "and NINETALES!"
	done

_CinnabarGymSuperNerd7BattleText::
	text "Fire is weak"
	line "against H2O!"
	done

_CinnabarGymSuperNerd7EndBattleText::
	text "Oh!"
	line "Snuffed out!"
	prompt

_CinnabarGymSuperNerd7AfterBattleText::
	text "Water beats fire!"
	line "But, fire melts"
	cont "ice #MON!"
	done

_CinnabarGymGymGuideBeatBlaineText::
	text "<PLAYER>! You beat"
	line "that fire brand!"
	done

_CinnabarGymText_1::
	text "This GYM is also"
	line "known as the QUIZ"
	cont "GYM."

	para "You have to take a"
	line "quiz if you want"
	cont "to see BLAINE."

	para "You don't have to"
	line "fight us if you"
	cont "get it right."
	done

_CinnabarGymText_2::
	text "Think you can do"
	line "it?"
	done

_CinnabarGymText_3::
	text "This one's tricky!"
	done

_CinnabarGymText_4::
	text "#MON enjoy"
	line "quizzes too!"
	done

_CinnabarGymText_5::
	text "I like it here at"
	line "QUIZ GYM."
	done

_CinnabarGymText_6::
	text "This is the last"
	line "question."
	done

_CinnabarGymText_7::
	text "Come on, answer"
	line "the question!"
	done
