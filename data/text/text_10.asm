; Text bank 10 (v0.7, 2026-08-30): opened when Text 9 ran down to 99 free
; bytes (the bank_slack_audit tripwire caught it). New far texts go here
; until this one fills too.
; v0.7 (2026-08-30, Forte's design): PROF.OAK's two aides wait here with
; the parcels. Both item descriptions are borrowed from the old gate text
; files; these are the duo's own lines.
_SaffronAidesGreetingText::
	text "Hey, <PLAYER>!"
	line "We've been"
	cont "looking all over"
	cont "for you!"

	para "PROF.OAK sent us"
	line "to deliver these"
	cont "parcels. He sent"
	cont "<RIVAL> his own"
	cont "already."

	para "We figured you'd"
	line "pass through"
	cont "SAFFRON sooner"
	cont "or later!"

	para "Here, this one's"
	line "from my pack!"
	prompt

_SaffronAidesMakeRoomText::
	text "Whoa, your BAG"
	line "is packed!"

	para "Two free slots,"
	line "please, <PLAYER> -"
	cont "we have to hand"
	cont "these over and"
	cont "get back to our"
	cont "research with"
	cont "PROF.OAK!"
	prompt

_SaffronAideItemfinderReceivedText::
	text "<PLAYER> received"
	line "the ITEMFINDER!@"
	text_end

_SaffronAideExpShareIntroText::
	text "And this one is"
	line "from MY pack!"
	prompt

_SaffronAideExpShareReceivedText::
	text "<PLAYER> received"
	line "the EXP.SHARE!@"
	text_end

_SaffronAide1FearText::
	text "Parcels"
	line "delivered! Now we"
	cont "just walk home"
	cont "past TEAM"
	cont "ROCKET..."

	para "...any decade"
	line "now."
	done

_SaffronAide2FearText::
	text "I'm not stepping"
	line "outside while"
	cont "TEAM ROCKET owns"
	cont "this town."

	para "PROF.OAK will"
	line "understand."
	done

_SaffronAidesSafeText::
	text "SAFFRON is safe"
	line "again! We're"
	cont "packing for the"
	cont "trip back to the"
	cont "lab."

	para "Thank you,"
	line "<PLAYER>!"
	done

; v0.7 hard mode (2026-08-30): every gym leader's badge-match party cap
; (engine/battle/hard_mode.asm, HardModeGymPartyGate). One shared voice for
; all eight. No HARD MODE name-drop (Forte: keep the 4th wall up), and the
; leader says HOW MANY they field - the gate parks the count in wd11e just
; before printing.
_HardModeGymPartyGateText::
	text "Whoa, hold it!"
	line "I only accept a"
	cont "fair badge match:"
	cont "bring no more"
	cont "#MON than I!"

	para "I field @"
	text_decimal wd11e, 1, 1
	text " #MON."
	done

; v0.7 knob #17 follow-up (Forte, 2026-09-01): the four boost-badge speeches
; and the Badge House entries must not mislead a HARD player - on hard the
; badges lend no stat boost. Same 4th-wall rule as the party-gate text above:
; no mode name-drop; the leaders speak of the player's chosen road instead.
_PewterGymBrockBoulderBadgeInfoHardText::
	text_start

	para "That's an official"
	line "#MON LEAGUE"
	cont "BADGE!"

	para "On the road you"
	line "chose, its power"
	cont "must be your own!"
	prompt

_VermilionGymLTSurgeThunderBadgeInfoHardText::
	text "The THUNDERBADGE"
	line "lets your #MON"
	cont "use FLASH any-"
	cont "time, kid!"

	para "You're special,"
	line "kid! Take this!"
	done

_FuchsiaGymKogaSoulBadgeInfoHardText::
	text "Now that you have"
	line "the SOULBADGE,"
	cont "you can SURF"
	cont "outside of"
	cont "battle!"

	para "Ah! Take this"
	line "too!"
	done

_CinnabarGymBlaineVolcanoBadgeInfoHardText::
	text "Hah!"

	para "The VOLCANOBADGE"
	line "is the mark of"
	cont "true skill!"

	para "Here, you can"
	line "have this too!"
	done

; shared by the BOULDER and VOLCANO Badge House entries on hard - those two
; badges have nothing but the boost to describe
_CeruleanBadgeHouseNoBoostHardText::
	text "On the harder"
	line "path, BADGEs lend"
	cont "no strength."
	prompt

_CeruleanBadgeHouseThunderBadgeHardText::
	text "It lets you use"
	line "FLASH outside"
	cont "of battle."
	prompt

_CeruleanBadgeHouseSoulBadgeHardText::
	text "It lets you use"
	line "SURF outside"
	cont "of battle."
	prompt

_SharedExpText::
; #10 follow-up (2026-09-02): the one box the EXP.SHARE prints per battle.
; The number is the battle's whole handed-out total; the names come composed
; in wMoveBuffer ("between A, B and C" / "with A"), wrapped by the engine.
	text "Shared @"
	text_decimal wExpShareTotal, 2, 5
	text " EXP"
	line "@"
	text_ram wMoveBuffer
	text "!"
	prompt

_ExpShareLonelyText::
	text "There's only one"
	line "#MON with you!"

	para "There's no EXP"
	line "to share."
	prompt
