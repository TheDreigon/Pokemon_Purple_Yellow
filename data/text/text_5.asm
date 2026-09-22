_IsEvolvingText::
	text "What? @"
	text_ram wStringBuffer
	text_start
	line "is evolving!"
	done

_FellAsleepText::
	text "<TARGET>"
	line "fell asleep!"
	prompt

_AlreadyAsleepText::
	text "<TARGET>'s"
	line "already asleep!"
	prompt

_PoisonedText::
	text "<TARGET>"
	line "was poisoned!"
	prompt

_BadlyPoisonedText::
	text "<TARGET>'s"
	line "badly poisoned!"
	prompt

_BurnedText::
	text "<TARGET>"
	line "was burned!"
	prompt

_FrozenText::
	text "<TARGET>"
	line "was frozen solid!"
	prompt

_FireDefrostedText::
	text "Fire defrosted"
	line "<TARGET>!"
	prompt

_MonsStatsRoseText::
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer
	text "@"
	text_end

_GreatlyRoseText::
	text "<SCROLL>sharply@"
	text_end

_RoseText::
	text " rose!"
	prompt

; Shown when a stat is already at +6 (stat name is loaded into
; wStringBuffer by the caller).
_StatWontGoHigherText::
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer
	text " won't"
	cont "go any higher!"
	prompt

_MonsStatsFellText::
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer
	text "@"
	text_end

_GreatlyFellText::
	text "<SCROLL>sharply@"
	text_end

_FellText::
	text " fell!"
	prompt

; Shown when a stat is already at -6 (stat name is loaded into
; wStringBuffer by the caller).
_StatWontGoLowerText::
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer
	text " won't"
	cont "go any lower!"
	prompt

_ChargeMoveEffectText::
	text "<USER>@"
	text_end

_MadeWhirlwindText::
	text_start
	line "made a whirlwind!"
	prompt

_TookInSunlightText::
	text_start
	line "took in sunlight!"
	prompt

_LoweredItsHeadText::
	text_start
	line "lowered its head!"
	prompt

_SkyAttackGlowingText::
	text_start
	line "soared sky-high!"
	prompt

_FlewUpHighText::
	text_start
	line "flew up high!"
	prompt

_DugAHoleText::
	text_start
	line "dug a hole!"
	prompt

_GatheredMoonlightText::
	text_start
	line "took in moonlight"
	prompt

_BecameConfusedText::
	text "<TARGET>"
	line "became confused!"
	prompt

_MimicLearnedMoveText::
	text "<USER>"
	line "learned"
	cont "@"
	text_ram wcd6d
	text "!"
	prompt

_MoveWasDisabledText::
	text "<TARGET>'s"
	line "@"
	text_ram wcd6d
	text " was"
	cont "disabled!"
	prompt

_NothingHappenedText::
	text "Nothing happened!"
	prompt

_NoEffectText::
	text "No effect!"
	prompt

_ButItFailedText::
	text "But, it failed! "
	prompt

_DidntAffectText::
	text "It didn't affect"
	line "<TARGET>!"
	prompt

_IsUnaffectedText::
	text "<TARGET>"
	line "is unaffected!"
	prompt

_ParalyzedMayNotAttackText::
	text "<TARGET>'s"
	line "paralyzed! It may"
	cont "not attack!"
	prompt

_SubstituteText::
	text "It created a"
	line "SUBSTITUTE!"
	prompt

_HasSubstituteText::
	text "<USER>"
	line "has a SUBSTITUTE!"
	prompt

_TooWeakSubstituteText::
	text "Too weak to make"
	line "a SUBSTITUTE!"
	prompt

_WasSeededText::
	text "<TARGET>"
	line "was seeded!"
	prompt

_EvadedAttackText::
	text "<TARGET>"
	line "evaded attack!"
	prompt

_HitWithRecoilText::
	text "<USER>'s"
	line "hit with recoil!"
	prompt

_StatusChangesEliminatedText::
	text "All STATUS changes"
	line "are eliminated!"
	prompt

_GettingPumpedText::
	text "<USER>'s"
	line "critical hit rate"
	cont "sharply rose!"
	prompt

_FocusEnergyAlreadyText::
	text "<USER>'s"
	line "crit rate is"
	cont "already boosted!"
	prompt

_StartedSleepingEffect::
	text "<USER>"
	line "started sleeping!"
	done

_FellAsleepBecameHealthyText::
	text "<USER>"
	line "fell asleep and"
	cont "became healthy!"
	done

_RegainedHealthText::
	text "<USER>"
	line "regained health!"
	prompt

_RegainedStatusText::
	text "<USER>"
	line "felt refreshed!"
	prompt

_TransformedText::
	text "<USER>"
	line "transformed into"
	cont "@"
	text_ram wcd6d
	text "!"
	prompt

_LightScreenProtectedText::
	text "<USER>'s"
	line "protected against"
	cont "special attacks!"
	prompt

_ReflectGainedArmorText::
	text "<USER>"
	line "gained armor!"
	prompt

_ShroudedInMistText::
	text "<USER>'s"
	line "shrouded in mist!"
	prompt

_CoinsScatteredText::
	text "Coins scattered"
	line "everywhere!"
	prompt

_SuckedHealthText::
	text "Sucked health from"
	line "<TARGET>!"
	prompt

_DreamWasEatenText::
	text "<TARGET>'s"
	line "dream was eaten!"
	prompt

_TradeCenterOpponentText::
	text "!"
	done

_ColosseumOpponentText::
	text "!"
	done

; ---- NPC trade dialogues, Route 11 gate and Route 18 gate (moved from Text 9,
; 2026-09-22; the other six trades are in data/text/text_9.asm) ----

; v1.0 (2026-09-22, Forte): his PONYTA replaces the DUGTRIO. Same complaint, the
; animal that explains it: a runner with no room on an upper floor kicks the walls.
_WannaTradeColtText::
	text "This gate rattles"
	line "day and night!"

	para "No room to run,"
	line "so my PONYTA"
	cont "kicks the walls!"

	para "Swap me a lazy"
	line "LICKITUNG?"
	done

_NoTradeColtText::
	text "Then the kicking"
	line "goes on..."
	done

_WrongMonColtText::
	text "That's no"
	line "LICKITUNG! My"
	cont "floor still"
	cont "shakes!"
	done

_ThanksColtText::
	text "Ahh. Peace and"
	line "quiet at last!"
	done

_AfterTradeColtText::
	text "How's COLT? Out"
	line "on the open road?"

	para "My LICKITUNG never"
	line "leaves the rug!"
	done

; v1.0 (2026-09-22, Forte): the gate's COOK. He took in a SEEL pup off the beach,
; it grew into a DEWGONG, and a stove kitchen is no place for a cold-sea animal. He
; lets it go for its own sake and wants a fire-lover that also guards the pantry.
_WannaTradeFloeText::
	text "I took in a SEEL"
	line "pup on the beach."

	para "Now it's a DEWGONG"
	line "and my kitchen's"
	cont "too hot for it!"

	para "Got an ARCANINE?"
	line "Fire won't bother"
	cont "that one!"
	done

_NoTradeFloeText::
	text "Then it pants by"
	line "my stove again..."
	done

_WrongMonFloeText::
	text "That's no"
	line "ARCANINE! I need"
	cont "a fire lover!"
	done

_ThanksFloeText::
	text "Swim cold seas,"
	line "FLOE! Take care!"
	done

_AfterTradeFloeText::
	text "Does FLOE sing to"
	line "the sea still?"

	para "My ARCANINE keeps"
	line "RATTATA out of my"
	cont "pantry!"
	done

