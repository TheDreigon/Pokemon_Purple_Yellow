; v0.7: MOVE INFO descriptions, keyed by move EFFECT.
;
; One block per effect id, shared by every move that uses it -- 219 moves run on
; 83 distinct effects, which is what makes this affordable. Moves that need
; their own words get a per-move override instead; see
; MoveDescriptionOverrides in data/moves/descriptions.asm.
;
; These state MECHANICS, not flavour. The effects are the part this game
; changed, so "45% chance to PARALYZE" is the useful sentence and "a blow to the
; mind" is not.
;
; TWO limits, both enforced by .claude/emu_test_moveinfo.py:
;   18 characters per line (the description box interior; `#` renders as 4)
;   5 lines per description -- `<NEXT>` moves down 2 rows (home/text.asm:64),
;   so the 9-row box holds 5 lines of text, not 9.
;
; The Gen 1 font has no `%` glyph (see constants/charmap.asm), so chances are
; written "N in 100" -- the same number a player would read off a percent sign,
; with no arithmetic asked of them.
;
; Percentages here are read off engine/battle/effects.asm, not assumed:
;   _SIDE_EFFECT1 = 15%   _SIDE_EFFECT2 = 30%   _SIDE_EFFECT3 = 45%
;   the four stat-lowering side effects = 33%
;   FLINCH_SIDE_EFFECT1 = 15%, FLINCH_SIDE_EFFECT2 = 30%

_MoveDesc_NoAdditionalEffect::
	text "A straight attack"
	next "with no added"
	next "effect."
	done

_MoveDesc_FalseSwipe::
	text "Never KOs: the"
	next "target is always"
	next "left with 1HP."
	done

_MoveDesc_Unused::
	text "Nothing is known"
	next "of this move."
	done

_MoveDesc_PoisonSide1::
	text "15 in 100 chance"
	next "to POISON the foe."
	done

_MoveDesc_PoisonSide2::
	text "30 in 100 chance"
	next "to POISON the foe."
	done

_MoveDesc_PoisonSide3::
	text "45 in 100 chance"
	next "to POISON the foe."
	done

_MoveDesc_DrainHP::
	text "The user is"
	next "healed by half"
	next "the damage it"
	next "deals."
	done

_MoveDesc_BurnSide1::
	text "15 in 100 chance"
	next "to BURN the foe."
	done

_MoveDesc_BurnSide2::
	text "30 in 100 chance"
	next "to BURN the foe."
	done

_MoveDesc_BurnSide3::
	text "45 in 100 chance"
	next "to BURN the foe."
	done

_MoveDesc_FreezeSide1::
	text "15 in 100 chance"
	next "to FREEZE the foe."
	done

_MoveDesc_FreezeSide2::
	text "30 in 100 chance"
	next "to FREEZE the foe."
	done

_MoveDesc_ParalyzeSide1::
	text "15 in 100 chance"
	next "to PARALYZE the"
	next "foe."
	done

_MoveDesc_ParalyzeSide2::
	text "30 in 100 chance"
	next "to PARALYZE the"
	next "foe."
	done

_MoveDesc_ParalyzeSide3::
	text "45 in 100 chance"
	next "to PARALYZE the"
	next "foe."
	done

_MoveDesc_Explode::
	text "The user faints,"
	next "but the foe's"
	next "DEFENSE is halved"
	next "first."
	done

_MoveDesc_DreamEater::
	text "Works only on a"
	next "sleeping foe. The"
	next "user is healed by"
	next "half the damage."
	done

_MoveDesc_MirrorMove::
	text "Uses the move the"
	next "foe used last. It"
	next "fails if the foe"
	next "has not moved."
	done

_MoveDesc_AttackUp1::
	text "Raises the user's"
	next "ATTACK one step."
	done

_MoveDesc_DefenseUp1::
	text "Raises the user's"
	next "DEFENSE one step."
	done

_MoveDesc_SpeedUp1::
	text "Raises the user's"
	next "SPEED one step."
	done

_MoveDesc_SpecialUp1::
	text "Raises the user's"
	next "SPECIAL one step."
	done

_MoveDesc_AccuracyUp1::
	text "Raises the user's"
	next "ACCURACY one"
	next "step."
	done

_MoveDesc_EvasionUp1::
	text "Raises the user's"
	next "EVASION one step."
	done

_MoveDesc_PayDay::
	text "Scatters coins."
	next "You pick them up"
	next "after the battle."
	done

_MoveDesc_Swift::
	text "Never misses, no"
	next "matter the foe's"
	next "EVASION."
	done

_MoveDesc_AttackDown1::
	text "Lowers the foe's"
	next "ATTACK one step."
	done

_MoveDesc_DefenseDown1::
	text "Lowers the foe's"
	next "DEFENSE one step."
	done

_MoveDesc_SpeedDown1::
	text "Lowers the foe's"
	next "SPEED one step."
	done

_MoveDesc_SpecialDown1::
	text "Lowers the foe's"
	next "SPECIAL one step."
	done

_MoveDesc_AccuracyDown1::
	text "Lowers the foe's"
	next "ACCURACY one"
	next "step."
	done

_MoveDesc_EvasionDown1::
	text "Lowers the foe's"
	next "EVASION one step."
	done

_MoveDesc_Conversion::
	text "The user takes on"
	next "the foe's types."
	done

_MoveDesc_Haze::
	text "Clears every"
	next "raised and"
	next "lowered stat on"
	next "both sides."
	done

_MoveDesc_Bide::
	text "The user waits,"
	next "then strikes back"
	next "for twice the"
	next "damage it took."
	done

_MoveDesc_ThrashPetalDance::
	text "Attacks for 2 to"
	next "3 turns without"
	next "stopping, then"
	next "confuses the user."
	done

_MoveDesc_SwitchAndTeleport::
	text "Ends a wild"
	next "battle. Against a"
	next "trainer the foe"
	next "is switched out."
	done

_MoveDesc_TwoToFiveAttacks::
	text "Strikes 2 to 5"
	next "times in one"
	next "turn."
	done

_MoveDesc_FlinchSide1::
	text "15 in 100 chance"
	next "to make the foe"
	next "flinch."
	done

_MoveDesc_FlinchSide2::
	text "30 in 100 chance"
	next "to make the foe"
	next "flinch."
	done

_MoveDesc_Sleep::
	text "Puts the foe to"
	next "SLEEP for 2 to 5"
	next "turns."
	done

_MoveDesc_OHKO::
	text "Faints the foe in"
	next "one hit. It fails"
	next "if the foe is"
	next "faster."
	done

_MoveDesc_Charge::
	text "Takes a turn to"
	next "prepare, then"
	next "strikes on the"
	next "next turn."
	done

_MoveDesc_SuperFang::
	text "Halves the foe's"
	next "current HP,"
	next "whatever it is."
	done

_MoveDesc_SpecialDamage::
	text "Deals a fixed"
	next "amount of damage."
	done

_MoveDesc_Trapping::
	text "Traps the foe for"
	next "2 to 5 turns. It"
	next "cannot act while"
	next "held."
	done

_MoveDesc_Fly::
	text "Rises out of"
	next "reach, then"
	next "strikes on the"
	next "next turn."
	done

_MoveDesc_AttackTwice::
	text "Strikes twice in"
	next "one turn."
	done

_MoveDesc_JumpKick::
	text "If it misses, the"
	next "user is hurt by"
	next "the fall."
	done

_MoveDesc_Mist::
	text "Guards the user's"
	next "stats from being"
	next "lowered."
	done

_MoveDesc_FocusEnergy::
	text "Triples the user's"
	next "critical hit rate"
	next "and raises"
	next "ACCURACY one step."
	done

_MoveDesc_Recoil::
	text "The user takes a"
	next "quarter of the"
	next "damage it deals."
	done

_MoveDesc_Confusion::
	text "Confuses the foe"
	next "for 2 to 5 turns."
	done

_MoveDesc_AttackUp2::
	text "Raises the user's"
	next "ATTACK two steps."
	done

_MoveDesc_DefenseUp2::
	text "Raises the user's"
	next "DEFENSE two"
	next "steps."
	done

_MoveDesc_SpeedUp2::
	text "Raises the user's"
	next "SPEED two steps."
	done

_MoveDesc_SpecialUp2::
	text "Raises the user's"
	next "SPECIAL two"
	next "steps."
	done

_MoveDesc_AccuracyUp2::
	text "Raises the user's"
	next "ACCURACY two"
	next "steps."
	done

_MoveDesc_EvasionUp2::
	text "Raises the user's"
	next "EVASION two"
	next "steps."
	done

_MoveDesc_Heal::
	text "Restores half of"
	next "the user's full"
	next "HP."
	done

_MoveDesc_Transform::
	text "The user becomes"
	next "a copy of the"
	next "foe."
	done

_MoveDesc_AttackDown2::
	text "Lowers the foe's"
	next "ATTACK two steps."
	done

_MoveDesc_DefenseDown2::
	text "Lowers the foe's"
	next "DEFENSE two"
	next "steps."
	done

_MoveDesc_SpeedDown2::
	text "Lowers the foe's"
	next "SPEED two steps."
	done

_MoveDesc_SpecialDown2::
	text "Lowers the foe's"
	next "SPECIAL two"
	next "steps."
	done

_MoveDesc_AccuracyDown2::
	text "Lowers the foe's"
	next "ACCURACY two"
	next "steps."
	done

_MoveDesc_EvasionDown2::
	text "Lowers the foe's"
	next "EVASION two"
	next "steps."
	done

_MoveDesc_LightScreen::
	text "Doubles the user's"
	next "SPECIAL against"
	next "special attacks."
	done

_MoveDesc_Reflect::
	text "Doubles the user's"
	next "DEFENSE against"
	next "physical attacks."
	done

_MoveDesc_Poison::
	text "POISONs the foe."
	next "POISON costs an"
	next "eighth of full HP"
	next "each turn."
	done

_MoveDesc_Paralyze::
	text "PARALYZEs the"
	next "foe. It halves"
	next "SPEED and costs"
	next "one turn in four."
	done

_MoveDesc_AttackDownSide::
	text "33 in 100 chance"
	next "to lower the foe's"
	next "ATTACK one step."
	done

_MoveDesc_DefenseDownSide::
	text "33 in 100 chance"
	next "to lower the foe's"
	next "DEFENSE one step."
	done

_MoveDesc_SpeedDownSide::
	text "33 in 100 chance"
	next "to lower the foe's"
	next "SPEED one step."
	done

_MoveDesc_SpecialDownSide::
	text "33 in 100 chance"
	next "to lower the foe's"
	next "SPECIAL one step."
	done

_MoveDesc_AttackDefenseUp1::
	text "Raises the user's"
	next "ATTACK and"
	next "DEFENSE one step"
	next "each."
	done

_MoveDesc_AccuracyEvasionDown1::
	text "Lowers the foe's"
	next "ACCURACY and"
	next "EVASION one step"
	next "each."
	done

_MoveDesc_Burn::
	text "BURNs the foe."
	next "ATTACK is halved"
	next "and an eighth of"
	next "HP goes each turn."
	done

_MoveDesc_ConfusionSide1::
	text "15 in 100 chance"
	next "to confuse the"
	next "foe."
	done

_MoveDesc_ConfusionSide2::
	text "30 in 100 chance"
	next "to confuse the"
	next "foe."
	done

_MoveDesc_ConfusionSide3::
	text "45 in 100 chance"
	next "to confuse the"
	next "foe."
	done

_MoveDesc_Twineedle::
	text "Strikes twice."
	next "Each hit has a"
	next "chance to POISON."
	done

_MoveDesc_AttackAccuracyUp1::
	text "Raises the user's"
	next "ATTACK and"
	next "ACCURACY one step"
	next "each."
	done

_MoveDesc_Substitute::
	text "Spends a quarter"
	next "of full HP to put"
	next "up a decoy that"
	next "takes the hits."
	done

_MoveDesc_HyperBeam::
	text "The user must"
	next "spend the next"
	next "turn recharging."
	done

_MoveDesc_Rage::
	text "The user keeps"
	next "attacking, growing"
	next "stronger each time"
	next "it is hit."
	done

_MoveDesc_Mimic::
	text "Copies one of the"
	next "foe's moves for"
	next "the rest of the"
	next "battle."
	done

_MoveDesc_Metronome::
	text "Uses any move in"
	next "the world, picked"
	next "at random."
	done

_MoveDesc_LeechSeed::
	text "Steals an eighth"
	next "of the foe's full"
	next "HP each turn for"
	next "the user."
	done

_MoveDesc_Splash::
	text "Nothing at all"
	next "happens."
	done

_MoveDesc_Disable::
	text "Stops the foe"
	next "from using one of"
	next "its moves for a"
	next "few turns."
	done

_MoveDesc_SpeedEvasionUp1::
	text "Raises the user's"
	next "SPEED and EVASION"
	next "one step each."
	done

_MoveDesc_SpecialSpeedDown1::
	text "Lowers the foe's"
	next "SPECIAL and SPEED"
	next "one step each."
	done

_MoveDesc_AttackUp1Down1::
	text "Raises the user's"
	next "ATTACK one step"
	next "and lowers the"
	next "foe's one step."
	done

_MoveDesc_SpecialUp1Heal::
	text "Raises SPECIAL one"
	next "step and heals a"
	next "quarter of max HP."
	done

_MoveDesc_TriStatusSide::
	text "May BURN, FREEZE"
	next "or PARALYZE the"
	next "foe."
	done

_MoveDesc_SpeedEvasionDown1::
	text "Lowers the foe's"
	next "SPEED and EVASION"
	next "one step each."
	done

_MoveDesc_SpecialSpeedUp1::
	text "Raises the user's"
	next "SPECIAL and SPEED"
	next "one step each."
	done

_MoveDesc_SpecialAccuracyUp1::
	text "Raises the user's"
	next "SPECIAL and"
	next "ACCURACY one step"
	next "each."
	done

_MoveDesc_LevelDamage::
	text "Damage equals the"
	next "user's own level."
	done

_MoveDesc_TargetLevelDamage::
	text "Damage equals the"
	next "target's level."
	done

_MoveDesc_DragonRage::
	text "Always deals 50"
	next "damage, whatever"
	next "the foe."
	done

_MoveDesc_Sonicboom::
	text "Always deals 25"
	next "damage, whatever"
	next "the foe."
	done

_MoveDesc_Rest::
	text "Sleeps 2 turns,"
	next "restoring all HP"
	next "and clearing any"
	next "status."
	done

_MoveDesc_Softboiled::
	text "Restores half of"
	next "full HP and clears"
	next "any status."
	done

_MoveDesc_HighCrit::
	text "A critical hit is"
	next "far more likely"
	next "than usual."
	done

_MoveDesc_Priority::
	text "Always strikes"
	next "first, whatever"
	next "the user's SPEED."
	done

_MoveDesc_HighCritPriority::
	text "Strikes first, and"
	next "criticals are far"
	next "more likely."
	done

_MoveDesc_ExtremeSpeed::
	text "Strikes first, and"
	next "before even other"
	next "quick moves."
	done

