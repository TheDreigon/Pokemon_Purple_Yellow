_MrFujisHouseSuperNerdMrFujiIsntHereText::
	text "That's odd, MR.FUJI"
	line "isn't here."
	cont "Where'd he go?"
	done

_MrFujisHouseSuperNerdMrFujiHadBeenPrayingText::
	text "MR.FUJI had been"
	line "praying alone for"
	cont "CUBONE's mother."
	done

_MrFujisHouseLittleGirlThisIsMrFujisHouseText::
	text "This is really"
	line "MR.FUJI's house."

	para "He's really kind!"

	para "He looks after"
	line "abandoned and"
	cont "orphaned #MON!"
	done

_MrFujisHouseLittleGirlPokemonAreNiceToHugText::
	text "It's so warm!"
	line "#MON are so"
	cont "nice to hug!"
	done

_MrFujisHousePsyduckText::
	text "PSYDUCK: Gwappa!@"
	text_end

_MrFujisHouseNidorinoText::
	text "NIDORINO: Gaoo!@"
	text_end

_MrFujisHouseMrFujiIThinkThisMayHelpYourQuestText::
	text "MR.FUJI: <PLAYER>."

	para "Your #DEX quest"
	line "may fail without"
	cont "love for your"
	cont "#MON."

	para "I think this may"
	line "help your quest."
	prompt

_MrFujisHouseMrFujiReceivedPokeFluteText::
	text "<PLAYER> received"
	line "a @"
	text_ram wStringBuffer
	text "!@"
	text_end

_MrFujisHouseMrFujiPokeFluteExplanationText::
; v1.0 (2026-11-07): ItemUsePokeflute wakes the SNORLAX on ROUTE 12 and 16, plays PIKACHU's waking scene in
; the PEWTER #MON CENTER when PIKACHU is right beside the player, and is refused in battle (ItemUseNotTime);
; the vanilla lines said it woke every sleeping #MON
	text_start

	para "Upon hearing #"
	line "FLUTE, a sleeping"
	cont "SNORLAX will"
	cont "spring awake."

	para "It is no use in"
	line "battle, though."
	done

_MrFujisHouseMrFujiPokeFluteNoRoomText::
	text "You must make"
	line "room for this!"
	done

_MrFujisHouseMrFujiPokedexText::
	text "#MON Monthly"
	line "Grand Prize"
	cont "Drawing!"

	para "The application"
	line "form is..."

	para "Gone! It's been"
	line "clipped out!"
	done
