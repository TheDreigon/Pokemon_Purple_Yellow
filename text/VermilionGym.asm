_VermilionGymLTSurgePreBattleText::
	text "Ten-hut! Welcome"
	line "to VERMILION GYM!"

	para "Will you look at"
	line "that, a pint-size"
	cont "challenger!"

	para "Hahaha! You've got"
	line "big and brassy"
	cont "nerves to take me"
	cont "on with your puny"
	cont "power!"

	para "A #MON battle"
	line "is war! I'll show"
	cont "you, civilian!"

	para "I'll shock you"
	line "into surrender!"
	done

_VermilionGymLTSurgePostBattleAdviceText::
	text "A little word of"
	line "advice, kid!"

	para "Electricity is"
	line "sure powerful!"

	para "But, it's useless"
	line "against ground-"
	cont "type #MON!"
	done

_VermilionGymRematchPreBattle1Text::
	text "CHAMPION, huh?"
	line "I've powered up!"

    para "This'll be a"
	line "surge of power"
	cont "you've never"
	cont "seen before!"

	para "Care for a jolt"
	line "of reality,"
	cont "CHAMP?"
	done

_VermilionGymPreRematchBattle2Text::
	text "That's the"
	line "spirit!"
	
	para "No holding back!"
	done

_VermilionGymRematchPostBattleText::
	text "Your team's"
	line "electrifying"
	cont "strength..."

	para "You're the real"
	line "deal!"

	para "You've proven"
	line "yourself again,"
	cont "CHAMPION."

	para "Until next time,"
    line "stay charged!"
	done

_VermilionGymLTSurgeThunderBadgeInfoText::
; v1.0 (the SPECIAL split, 2026-09-06): Forte's badge map - THUNDER lends
; SPEED (it was DEFENSE).
	text "The THUNDERBADGE"
	line "cranks up the"
	cont "SPEED of your"
	cont "#MON!"

	para "It also lets your"
	line "#MON use FLASH"
	cont "anytime, kid!"

	para "You're special,"
	line "kid! Take this!"
	done

_VermilionGymLTSurgeReceivedTMText::
	text "<PLAYER> received "
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_VermilionGymLTSurgeTMExplanationText::
	text_start

	para "TM12 packs"
	line "SHOCK WAVE, kid!"

	para "An electric jolt"
	line "that NEVER misses"
	cont "its target, kid!"
	done

_VermilionGymLTSurgeTMNoRoomText::
	text "Yo kid, make room"
	line "in your pack!"
	done

_VermilionGymLTSurgeReceivedCandyText::
	text "<PLAYER> received"
	line "a RARE CANDY!@"
	text_end

_VermilionGymLTSurgeCandyCommentText::
	text_start

	para "Power up,"
	line "recruit!"
	done

_VermilionGymLTSurgeReceivedThunderBadgeText::
	text "Whoa!"

	para "You're the real"
	line "deal, kid!"

	para "Fine then, take"
	line "the THUNDERBADGE!"
	prompt

_VermilionGymGentlemanBattleText::
	text "When I was in the"
	line "Army, LT.SURGE"
	cont "was my strict CO!"
	done

_VermilionGymGentlemanEndBattleText::
	text "Stop!"
	line "You're very good!"
	prompt

_VermilionGymGentlemanAfterBattleText::
	text "The door won't"
	line "open?"

	para "LT.SURGE always"
	line "was cautious!"
	done

_VermilionGymSuperNerdBattleText::
	text "I'm a lightweight,"
	line "but I'm good with"
	cont "electricity!"
	done

_VermilionGymSuperNerdEndBattleText::
	text "Fried!"
	prompt

_VermilionGymSuperNerdAfterBattleText::
	text "OK, I'll talk!"

	para "LT.SURGE said he"
	line "hid door switches"
	cont "inside something!"
	done

_VermilionGymSailorBattleText::
	text "This is no place"
	line "for kids!"
	done

_VermilionGymSailorEndBattleText::
	text "Wow!"
	line "Surprised me!"
	prompt

_VermilionGymSailorAfterBattleText::
	text "LT.SURGE set up"
	line "double locks!"
	cont "Here's a hint!"

	para "When you open the"
	line "1st lock, the 2nd"
	cont "lock is right"
	cont "next to it!"
	done

_VermilionGymGymGuideChampInMakingText::
	text "Yo! Champ in"
	line "making!"

	para "LT.SURGE runs a"
	line "squad of 4, and"
	cont "RAICHU is the"
	cont "big gun at the"
	cont "back!"

	para "His VOLTORB and"
	line "MAGNEMITE are"
	cont "part steel-type!"

	para "Poison bounces"
	line "right off them,"
	cont "but ground moves"
	cont "wreck them!"

	para "Birds and water"
	line "#MON are at"
	cont "risk! And every"
	cont "one of his 4 can"
	cont "paralyze you!"

	para "Bring a ground-"
	line "type and some"
	cont "PARALYSIS HEAL!"
	done

_VermilionGymGymGuideBeatLTSurgeText::
	text "Whew! That match"
	line "was animated!"
	done


; v0.7 (2026-09-05): the three gym-guide advice texts rewritten on the run
; feedback outgrew Text 7 (bank $2C, floor 162); they live here, in Text 6
; (bank $2B, room in both builds; Text 10 is full in the debug build). The scripts' text_far pointers follow the labels.
; from text/FuchsiaGym.asm
_FuchsiaGymGymGuideChampInMakingText::
	text "Yo! CHAMP in"
	line "making!"

	para "FUCHSIA GYM is"
	line "riddled with"
	cont "poison-types!"

	para "That might appear"
	line "easy, but KOGA"
	cont "does well to"
	cont "cover his ground-"
	cont "type weakness."

	para "Most of his 5"
	line "#MON fly or"
	cont "float over it."

	para "Try electric"
	line "moves instead -"
	cont "they zap 4 of"
	cont "his 5!"

	para "And nearly all"
	line "of them spread"
	cont "TOXIC! Pack a"
	cont "POISON HEAL or"
	cont "two!"
	done

; from text/SaffronGym.asm
_SaffronGymGuideChampInMakingText::
	text "Yo! Champ in"
	line "making!"

	para "SABRINA's psychic"
	line "#MON are"
	cont "incredibly"
	cont "powerful!"

	para "With high SPECIAL,"
	line "they land huge"
	cont "damage and take"
	cont "non-physical"
	cont "hits quite well."

	para "But not all 5"
	line "are pure psychic:"
	cont "HYPNO is part"
	cont "dark, and her"
	cont "VENOMOTH is a"
	cont "bug!"

	para "Bug and ghost"
	line "moves hit most of"
	cont "them hard - HYPNO"
	cont "doubly so!"

	para "No bug or ghost?"
	line "Bring a #MON"
	cont "with high ATTACK!"

	para "And don't nod"
	line "off - HYPNO and"
	cont "VENOMOTH both"
	cont "put you to sleep!"
	done

; from text/CinnabarGym.asm
_CinnabarGymGymGuideChampInMakingText::
	text "Yo! Champ in"
	line "making!"

	para "The hot-headed"
	line "BLAINE is a fire"
	cont "#MON pro!"

	para "Douse his spirits"
	line "with water! All"
	cont "5 of his #MON"
	cont "hate it - even"
	cont "his RHYDON, who"
	cont "isn't fire-type"
	cont "at all!"

	para "But be careful"
	line "of his counters!"

	para "EARTHQUAKE and"
	line "MEGAHORN check"
	cont "the #MON you"
	cont "send, and MAGMAR"
	cont "at the back is"
	cont "part magma-type:"
	cont "fire won't even"
	cont "scratch it!"
	done
