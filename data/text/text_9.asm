_ItemUseBallText00::
	text "It dodged the"
	line "thrown BALL!"

	para "This #MON"
	line "can't be caught!"
	prompt

_ItemUseBallText01::
	text "You missed the"
	line "#MON!"
	prompt

_ItemUseBallText02::
	text "Darn! The #MON"
	line "broke free!"
	prompt

_ItemUseBallText03::
	text "Aww! It appeared"
	line "to be caught! "
	prompt

_ItemUseBallText04::
	text "Shoot! It was so"
	line "close too!"
	prompt

_ItemUseBallText05::
	text "All right!"
	line "@"
	text_ram wEnemyMonNick
	text " was"
	cont "caught!@"
	text_end

_ItemUseBallText07::
	text_ram wBoxMonNicks
	text " was"
	line "transferred to"
	cont "BILL's PC!"
	prompt

_ItemUseBallText08::
	text_ram wBoxMonNicks
	text " was"
	line "transferred to"
	cont "someone's PC!"
	prompt

_ItemUseBallText06::
	text "New #DEX data"
	line "will be added for"
	cont "@"
	text_ram wEnemyMonNick
	text "!@"
	text_end

_SurfingGotOnText::
	text "<PLAYER> got on"
	line "@"
	text_ram wcd6d
	text "!"
	prompt

_SurfingNoPlaceToGetOffText::
	text "There's no place"
	line "to get off!"
	prompt

_RefusingText::
	text_ram wcd6d
	text_start
	line "is refusing!"
	prompt

_VitaminStatRoseText::
	text_ram wcd6d
	text "'s"
	line "@"
	text_ram wStringBuffer
	text " rose."
	prompt

_VitaminNoEffectText::
	text "It won't have any"
	line "effect."
	prompt

_ThrewBaitText::
	text "<PLAYER> threw"
	line "some BAIT."
	done

_ThrewRockText::
	text "<PLAYER> threw a"
	line "ROCK."
	done

_PlayedFluteNoEffectText::
	text "Played the #"
	line "FLUTE."

	para "Now, that's a"
	line "catchy tune!"
	prompt

_FluteWokeUpText::
	text "All sleeping"
	line "#MON woke up."
	prompt

_PlayedFluteHadEffectText::
	text "<PLAYER> played the"
	line "# FLUTE.@"
	text_end

_CoinCaseNumCoinsText::
	text "Coins"
	line "@"
	text_bcd wPlayerCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " "
	prompt

_ItemfinderFoundItemText::
	text "Yes! ITEMFINDER"
	line "indicates there's"
	cont "an item nearby."
	prompt

_ItemfinderFoundNothingText::
	text "Nope! ITEMFINDER"
	line "isn't responding."
	prompt

_RaisePPWhichTechniqueText::
	text "Raise PP of which"
	line "technique?"
	done

_RestorePPWhichTechniqueText::
	text "Restore PP of"
	line "which technique?"
	done

_PPMaxedOutText::
	text_ram wStringBuffer
	text "'s PP"
	line "is maxed out."
	prompt

_PPIncreasedText::
	text_ram wStringBuffer
	text "'s PP"
	line "increased."
	prompt

_PPRestoredText::
	text "PP was restored."
	prompt

_BootedUpTMText::
	text "Booted up a TM!"
	prompt

_BootedUpHMText::
	text "Booted up an HM!"
	prompt

_TeachMachineMoveText::
	text "It contained"
	line "@"
	text_ram wStringBuffer
	text "!"

	para "Teach @"
	text_ram wStringBuffer
	text_start
	line "to a #MON?"
	done

_MonCannotLearnMachineMoveText::
	text_ram wcd6d
	text " is not"
	line "compatible with"
	cont "@"
	text_ram wStringBuffer
	text "."

	para "It can't learn"
	line "@"
	text_ram wStringBuffer
	text "."
	prompt

_ItemUseNotTimeText::
	text "OAK: <PLAYER>!"
	line "This isn't the"
	cont "time to use that! "
	prompt

_ItemUseNotYoursToUseText::
	text "This isn't yours"
	line "to use!"
	prompt

_ItemUseNoEffectText::
	text "It won't have any"
	line "effect."
	prompt

_ThrowBallAtTrainerMonText1::
	text "The trainer"
	line "blocked the BALL!"
	prompt

_ThrowBallAtTrainerMonText2::
	text "Don't be a thief!"
	prompt

_NoCyclingAllowedHereText::
	text "No cycling"
	next "allowed here."
	prompt

_NoSurfingHereText::
	text "No SURFing on"
	line "@"
	text_ram wcd6d
	text " here!"
	prompt

_BoxFullCannotThrowBallText::
	text "The #MON BOX"
	line "is full! Can't"
	cont "use that item!"
	prompt

_DontHavePokemonText::
	text "You don't have a "
	line "#MON!"
	prompt

_ItemUseText001::
	text "<PLAYER> used@"
	text_end

_ItemUseText002::
	text_ram wStringBuffer
	text "!"
	done

_GotOnBicycleText1::
	text "<PLAYER> got on the@"
	text_end

_GotOnBicycleText2::
	text_ram wStringBuffer
	text "!"
	prompt

_GotOffBicycleText1::
	text "<PLAYER> got off@"
	text_end

_GotOffBicycleText2::
	text "the @"
	text_ram wStringBuffer
	text "."
	prompt

_ThrewAwayItemText::
	text "Threw away"
	line "@"
	text_ram wcd6d
	text "."
	prompt

_IsItOKToTossItemText::
	text "Is it OK to toss"
	line "@"
	text_ram wStringBuffer
	text "?"
	prompt

_TooImportantToTossText::
	text "That's too impor-"
	line "tant to toss!"
	prompt

_TooImportantToDepositText::
	text "That's too impor-"
	line "tant to deposit!"
	prompt

_AlreadyKnowsText::
	text_ram wcd6d
	text " knows"
	line "@"
	text_ram wStringBuffer
	text "!"
	prompt

_ConnectCableText::
	text "Okay, connect the"
	line "cable like so!"
	prompt

_TradedForText::
	text "<PLAYER> traded"
	line "@"
	text_ram wInGameTradeGiveMonName
	text " for"
	cont "@"
	text_ram wInGameTradeReceiveMonName
	text "!@"
	text_end

_WannaTrade1Text::
	text "I'm looking for"
	line "@"
	text_ram wInGameTradeGiveMonName
	text "! Wanna"

	para "trade one for"
	line "@"
	text_ram wInGameTradeReceiveMonName
	text "? "
	done

_NoTrade1Text::
	text "Awww!"
	line "Oh well..."
	done

_WrongMon1Text::
	text "What? That's not"
	line "@"
	text_ram wInGameTradeGiveMonName
	text "!"

	para "If you get one,"
	line "come back here!"
	done

_Thanks1Text::
	text "Hey thanks!"
	done

_AfterTrade1Text::
	text "Isn't my old"
	line "@"
	text_ram wInGameTradeReceiveMonName
	text " great?"
	done

_WannaTrade2Text::
	text "Hello there! Do"
	line "you want to trade"

	para "your @"
	text_ram wInGameTradeGiveMonName
	text_start
	line "for @"
	text_ram wInGameTradeReceiveMonName
	text "?"
	done

_NoTrade2Text::
	text "Well, if you"
	line "don't want to..."
	done

_WrongMon2Text::
	text "Hmmm? This isn't"
	line "@"
	text_ram wInGameTradeGiveMonName
	text "."

	para "Think of me when"
	line "you get one."
	done

_Thanks2Text::
	text "Thanks!"
	done

_AfterTrade2Text::
	text "Hello there! Your"
	line "old @"
	text_ram wInGameTradeGiveMonName
	text " is"
	cont "magnificent!"
	done

_WannaTrade3Text::
	text "Hi! Do you have"
	line "@"
	text_ram wInGameTradeGiveMonName
	text "?"

	para "Want to trade it"
	line "for @"
	text_ram wInGameTradeReceiveMonName
	text "?"
	done

_NoTrade3Text::
	text "That's too bad."
	done

_WrongMon3Text::
	text "...This is no"
	line "@"
	text_ram wInGameTradeGiveMonName
	text "."

	para "If you get one,"
	line "trade it with me!"
	done

_Thanks3Text::
	text "Thanks, pal!"
	done

_AfterTrade3Text::
	text "How is my old"
	line "@"
	text_ram wInGameTradeReceiveMonName
	text "?"

	para "My @"
	text_ram wInGameTradeGiveMonName
	text " is"
	line "doing great!"
	done

_NothingToCutText::
	text "There isn't"
	line "anything to CUT!"
	prompt

_UsedCutText::
	text_ram wcd6d
	text " hacked"
	line "away with CUT!"
	prompt

_WannaTradeTremorText::
	text "This gate rattles"
	line "day and night!"

	para "My DUGTRIO digs"
	line "too much. Got a"
	cont "lazy LICKITUNG?"
	done

_NoTradeTremorText::
	text "Then the shaking"
	line "goes on..."
	done

_WrongMonTremorText::
	text "That's no"
	line "LICKITUNG! My"
	cont "floor still"
	cont "shakes!"
	done

_ThanksTremorText::
	text "Ahh. Peace and"
	line "quiet at last!"
	done

_AfterTradeTremorText::
	text "How's TREMOR?"
	line "Still digging?"

	para "My LICKITUNG"
	line "just naps. Bliss!"
	done

_WannaTradeMilesText::
	text "My MR.MIME"
	line "copies all I do!"

	para "I want a cutie"
	line "instead. Your"
	cont "CLEFAIRY for him?"
	done

_NoTradeMilesText::
	text "MILES... stop"
	line "copying my"
	cont "tears."
	done

_WrongMonMilesText::
	text "That's not a"
	line "CLEFAIRY! MILES"
	cont "mimics my anger!"
	done

_ThanksMilesText::
	text "Wonderful! No"
	line "more mirrors!"
	done

_AfterTradeMilesText::
	text "Does MILES copy"
	line "you too? Ha!"

	para "My CLEFAIRY just"
	line "smiles. Bliss!"
	done

_WannaTradePteraText::
	text "I revived TWO"
	line "ancient flyers!"

	para "One's yours for"
	line "a SCYTHER. A"
	cont "living blade!"
	done

_NoTradePteraText::
	text "Science waits"
	line "for no one..."
	done

_WrongMonPteraText::
	text "This is not a"
	line "SCYTHER! The"
	cont "edge is all"
	cont "wrong!"
	done

_ThanksPteraText::
	text "Magnificent!"
	line "Such an edge!"
	done

_AfterTradePteraText::
	text "Is PTERA loud?"
	line "Prehistoric"
	cont "lungs!"

	para "My SCYTHER"
	line "slices lovely!"
	done

_WannaTradeSporeText::
	text "See my PARASECT?"
	line "The mushroom"
	cont "does the talking!"

	para "Yours for a"
	line "TANGELA?"
	done

_NoTradeSporeText::
	text "The spores are"
	line "disappointed..."
	done

_WrongMonSporeText::
	text "No, no. That's"
	line "not a TANGELA."
	cont "No vines!"
	done

_ThanksSporeText::
	text "The vines! They"
	line "curl so nice!"
	done

_AfterTradeSporeText::
	text "Water SPORE"
	line "daily! Fungus"
	cont "loves the damp!"
	done

_WannaTradeLolaText::
	text "My JYNX dances"
	line "like a dream!"

	para "But that swirl!"
	line "Your POLIWHIRL"
	cont "for my dancer?"
	done

_NoTradeLolaText::
	text "No encore,"
	line "then..."
	done

_WrongMonLolaText::
	text "That one has no"
	line "rhythm! A"
	cont "POLIWHIRL,"
	cont "darling!"
	done

_ThanksLolaText::
	text "That swirl!"
	line "Hypnotic!"
	done

_AfterTradeLolaText::
	text "Does LOLA still"
	line "dance? Teach her"
	cont "a new step!"
	done

_WannaTradeBasaltText::
	text "My RHYDON naps"
	line "on hot lava! I"

	para "need a cool"
	line "head. Your"
	cont "GOLDUCK, maybe?"
	done

_NoTradeBasaltText::
	text "The volcano"
	line "grumbles..."
	done

_WrongMonBasaltText::
	text "Not a GOLDUCK!"
	line "It would boil"
	cont "here!"
	done

_ThanksBasaltText::
	text "So cool-headed!"
	line "Literally!"
	done

_AfterTradeBasaltText::
	text "BASALT fears no"
	line "fire! A true"
	cont "child of the"
	cont "volcano!"
	done

_WannaTradeMobyText::
	text "I caught the"
	line "monster of the"
	cont "strait... It"

	para "scares me! Take"
	line "it for a PINSIR!"
	done

_NoTradeMobyText::
	text "Then I sleep"
	line "with one eye"
	cont "open..."
	done

_WrongMonMobyText::
	text "That's no"
	line "PINSIR! I need"
	cont "strong pincers!"
	done

_ThanksMobyText::
	text "Free at last!"
	line "Mind the temper!"
	done

_AfterTradeMobyText::
	text "MOBY obeys you?!"
	line "Incredible!"

	para "My PINSIR guards"
	line "the door now!"
	done

_WannaTradeDuxText::
	text "This old bird"
	line "knows my secret"
	cont "drills! Too keen"

	para "for me now. A"
	line "PIDGEY will do!"
	done

_NoTradeDuxText::
	text "At ease,"
	line "soldier..."
	done

_WrongMonDuxText::
	text "That recruit is"
	line "no PIDGEY!"
	done

_ThanksDuxText::
	text "Dismissed! Treat"
	line "DUX with honor!"
	done

_AfterTradeDuxText::
	text "DUX showed you"
	line "the drill?! Ha!"

	para "My PIDGEY just"
	line "coos. Restful!"
	done

; --- Bill's Eevee quest (v0.7) ---

_BillsHouseBillHeyWaitUpText::
	text "BILL: Hey, wait"
	line "up! I almost"
	cont "forgot something!"

	para "This is one of"
	line "the EEVEEs that"
	cont "have been keeping"
	cont "me company."

	para "I want you to"
	line "have it as thanks"
	cont "for saving me."
	prompt

_BillsHouseBillEeveeHookText::
	text "Oh, one more"
	line "thing! After you"
	cont "beat MISTY at the"
	cont "CERULEAN GYM,"
	cont "come see me with"
	cont "that EEVEE."

	para "I'll have a"
	line "present for you!"
	done

_BillsHouseBillNoRoomForEeveeText::
	text "Whoa, you have no"
	line "room for it!"

	para "Make some space"
	line "and come see me,"
	cont "OK?"
	done

_BillsHouseBillGoBeatMistyText::
	text "How's that EEVEE"
	line "doing?"

	para "Go challenge"
	line "MISTY at the"
	cont "CERULEAN GYM!"

	para "Come back when"
	line "you win!"
	done

_BillsHouseBillWheresEeveeText::
	text "Hey, where's"
	line "EEVEE? Go get it"
	cont "and come right"
	cont "back!"
	done

_BillsHouseBillYouBeatMistyText::
	text "You beat MISTY!"
	line "Nice going!"
	prompt

_BillsHouseBillWhichEvolutionText::
	text "So tell me! Which"
	line "of EEVEE's"
	cont "evolutions is"
	cont "your favorite?"
	done

_BillsHouseBillVaporeonText::
	text "Ah, VAPOREON!"
	line "Cells just like"
	cont "water molecules!"

	para "It melts clean"
	line "out of sight!"
	prompt

_BillsHouseBillJolteonText::
	text "JOLTEON! Every"
	line "mood swing"
	cont "charges it up!"

	para "Shocking choice!"
	prompt

_BillsHouseBillFlareonText::
	text "FLAREON! A flame"
	line "chamber at 1,600"
	cont "degrees! Toasty!"
	prompt

_BillsHouseWaterStoneReceivedText::
	text "<PLAYER> received"
	line "a WATER STONE!@"

_BillsHouseThunderStoneReceivedText::
	text "<PLAYER> received"
	line "a THUNDERSTONE!@"

_BillsHouseFireStoneReceivedText::
	text "<PLAYER> received"
	line "a FIRE STONE!@"

_BillsHouseBillTakeYourTimeText::
	text "No rush! Take"
	line "your time to"
	cont "think it over!"
	done

_BillsHouseBillStoneNoRoomText::
	text "Your bag is full!"
	line "Come back for it,"
	cont "OK?"
	done

_BillsHouseBillHowsTheTeamText::
	text "How's the team"
	line "doing? I hope my"
	cont "PC system is"
	cont "serving you well."

	para "I should get back"
	line "to my research!"
	done
