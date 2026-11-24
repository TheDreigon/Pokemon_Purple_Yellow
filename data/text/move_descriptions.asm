; v0.7: MOVE INFO descriptions, keyed by move EFFECT.
;
; One block per effect id, shared by every move that uses it -- 227 moves run on
; 102 distinct effects, which is what makes this affordable. Moves that need
; their own words get a per-move override instead; see
; MoveDescriptionOverrides in data/moves/descriptions.asm.
;
; These state MECHANICS, not flavour. The effects are the part this game
; changed, so "45% chance to PARALYZE" is the useful sentence and "a blow to the
; mind" is not.
;
; TWO limits, both enforced by .claude/emu_test_moveinfo.py:
;   18 characters per line (the description box interior; `#` renders as 4)
;   9 lines per description -- the card prints single-spaced (hUILayoutFlags
;   bit 2, home/text.asm:65-68), and the move's flavour and a blank row come
;   first in the same 9 rows (.claude/flavor_build.py fits the flavour to them).
;
; The Gen 1 font has no `%` glyph (see constants/charmap.asm), so chances are
; written "N in 100" -- the same number a player would read off a percent sign,
; with no arithmetic asked of them.
;
; Percentages here are read off engine/battle/effects.asm, not assumed:
;   _SIDE_EFFECT1 = 15%   _SIDE_EFFECT2 = 30%   _SIDE_EFFECT3 = 45%
;   the five stat-lowering side effects = 33% (SP.DEF's rolls through SP.ATK's id)
;   FLINCH_SIDE_EFFECT1 = 15%, FLINCH_SIDE_EFFECT2 = 30%
;   v1.0 (2026-11-16): the two bad-POISON side effects do not follow the suffix. Each
;   rolls once: POISON_TOXIC_SIDE_EFFECT1 (TOXIC FANGS) 15% bad POISON, else 30%
;   POISON; POISON_TOXIC_SIDE_EFFECT2 (GUNK SHOT) 25% bad POISON, else 25% POISON.

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

_MoveDesc_PoisonToxicSide1::
	text "30 in 100 to"
	next "POISON, 15 in 100"
	next "to badly POISON."
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
	text "The user faints."
	next "Never misses, no"
	next "matter the foe's"
	next "EVASION."
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

_MoveDesc_SpAtkUp1::
	text "Raises the user's"
	next "SP.ATK one step."
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

_MoveDesc_SpAtkDown1::
	text "Lowers the foe's"
	next "SP.ATK one step."
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
	next "can't act or"
	next "leave while held."
	done

_MoveDesc_Fly::
	text "Rises high, then"
	next "strikes on the"
	next "next turn. Few"
	next "moves reach it."
	done

_MoveDesc_Dig::
	text "Digs in, then"
	next "strikes on the"
	next "next turn. Few"
	next "moves reach it."
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
	next "stats from foes."
	next "A freeze still"
	next "lowers SPEED."
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
	next "for 1 to 4 turns."
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

_MoveDesc_SpAtkUp2::
	text "Raises the user's"
	next "SP.ATK two steps."
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
	next "full HP and clears"
	next "a status. A bad"
	next "POISON only eases."
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

_MoveDesc_SpAtkDown2::
	text "Lowers the foe's"
	next "SP.ATK two steps."
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
	next "SP.DEF against"
	next "special attacks."
	done

_MoveDesc_Protect::
	text "Goes first, and no"
	next "move aimed at the"
	next "user lands. Fails"
	next "twice in a row."
	done

_MoveDesc_LockOn::
	text "The user's moves"
	next "never miss the foe"
	next "until either one"
	next "leaves the field."
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

; TOXIC's own card (v1.0 D13, 2026-09-28: the card states the true effect; a per-move
; override until 2026-11-13, TOXIC_EFFECT's row since). The tick is the toxic count x 1/16 of the max HP, at least 1
; (core.asm HandlePoisonBurnLeechSeed_DecreaseOwnHP, D8), and the count starts
; again when the #MON is sent back in (toxic_carry.asm, both sides). Five lines:
; TOXIC's flavour takes three rows and the blank one, of nine. Fractions, like
; SOFTBOILED's 3/4. What a bad POISON does after the battle (v1.0 2026-11-11: it
; stays, and it is the only poison that bites on the map) is on manual page 4_5.
_MoveDesc_Toxic::
	text "Badly POISONs the"
	next "foe: 1/16 of full"
	next "HP, then 2/16, and"
	next "so on. A switch-in"
	next "starts it at 1/16."
	done

; MIND BREAK's own card (round 7, 2026-09-30: it says it hits DARK types, space
; permitting).
; Its 45 in 100 PARALYZE (PARALYZE_SIDE_EFFECT3, NUZZLE's card too) and, since F4, the DARK
; exception: the one DAMAGING PSYCHIC move that hits a DARK type (0.5x, "not very
; effective"; HYPNOSIS and DISABLE land on DARK since F4 too, being status moves). Three
; lines: the flavour takes five rows and the blank one, of nine.
_MoveDesc_MindBreak::
	text "45 in 100 to"
	next "PARALYZE the foe."
	next "Hits DARK types."
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

_MoveDesc_SpAtkDownSide::
	text "33 in 100 chance"
	next "to lower the foe's"
	next "SP.ATK one step."
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

; v1.0 (2026-11-17): a burn bites 1/16 of the max HP two to four times, then its fire is out
; (engine/battle/soft_status.asm); the ATTACK cut stays until a cure.
_MoveDesc_Burn::
	text "BURNs the foe."
	next "ATTACK is halved,"
	next "1/16 of HP goes"
	next "for 2 to 4 turns."
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

_MoveDesc_SpDefSpeedDown1::
	text "Lowers the foe's"
	next "SP.DEF and SPEED"
	next "one step each."
	done

_MoveDesc_AttackUp1Down1::
	text "Raises the user's"
	next "ATTACK one step"
	next "and lowers the"
	next "foe's one step."
	done

_MoveDesc_AttackSpAtkUp1Heal::
	text "Raises ATTACK and"
	next "SP.ATK a step and"
	next "heals a quarter of"
	next "max HP."
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

_MoveDesc_SpAtkSpeedUp1::
	text "Raises the user's"
	next "SP.ATK and SPEED"
	next "one step each."
	done

_MoveDesc_SpAtkSpDefAccuracyUp1::
	text "Raises the user's"
	next "SP.ATK, SP.DEF and"
	next "ACCURACY a step."
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
	text "Restores 3/4 of"
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


_MoveDesc_SpDefDown2Flinch::
	text "Lowers SP.DEF two"
	next "steps. 30 in 100"
	next "to flinch the foe."
	done

_MoveDesc_SpDefDown1Flinch::
	text "Lowers SP.DEF one"
	next "step. 30 in 100 to"
	next "flinch the foe."
	done

_MoveDesc_AttackDown2Flinch::
	text "Lowers ATTACK two"
	next "steps. 30 in 100"
	next "to flinch the foe."
	done

_MoveDesc_DefenseDown1Flinch::
	text "Lowers DEFENSE one"
	next "step. 30 in 100"
	next "to flinch the foe."
	done

_MoveDesc_SpeedDown1Flinch::
	text "Lowers SPEED one"
	next "step. 30 in 100"
	next "to flinch the foe."
	done

_MoveDesc_SpeedDown2Flinch::
	text "Lowers SPEED two"
	next "steps. 30 in 100"
	next "to flinch the foe."
	done

_MoveDesc_SpDefUp2::
	text "Raises the user's"
	next "SP.DEF two steps."
	done

_MoveDesc_SpDefDown2::
	text "Lowers the foe's"
	next "SP.DEF two steps."
	done

_MoveDesc_SpDefDown1::
	text "Lowers the foe's"
	next "SP.DEF one step."
	done

_MoveDesc_SpDefDownSide::
	text "33 in 100 chance"
	next "to lower the foe's"
	next "SP.DEF one step."
	done

_MoveDesc_DefenseDownSideBurn1::
	text "33 in 100 to lower"
	next "DEFENSE one step."
	next "15 in 100 to BURN"
	next "the foe."
	done

_MoveDesc_DefenseDown1Burn2::
	text "Lowers DEFENSE one"
	next "step. 30 in 100"
	next "to BURN the foe."
	done

_MoveDesc_DefenseDown2Burn3::
	text "Lowers DEFENSE two"
	next "steps. 45 in 100"
	next "to BURN the foe."
	done

_MoveDesc_SpeedDownSidePoison1::
	text "33 in 100 to lower"
	next "SPEED one step."
	next "15 in 100 to"
	next "POISON the foe."
	done

_MoveDesc_PoisonToxicSide2::
	text "25 in 100 to"
	next "POISON, 25 in 100"
	next "to badly POISON."
	done

_MoveDesc_SpDefDownSideHeal::
	text "33 in 100 to lower"
	next "SP.DEF one step."
	next "Heals the user by"
	next "1/8 of full HP."
	done

; v1.0 (2026-11-24): the status chapter's four effects (drafts: the wording is approved from captures).
_MoveDesc_Fear::
	text "FEARs the foe for"
	next "2 to 4 turns. It"
	next "may lose its turn"
	next "and is slower."
	done

_MoveDesc_FearSide::
	text "30 in 100 chance"
	next "to put FEAR in"
	next "the foe."
	done

_MoveDesc_TrappingDrain::
	text "Traps the foe for"
	next "2 to 5 turns. The"
	next "user is healed by"
	next "half of each hit."
	done

_MoveDesc_Spiral::
	text "60 in 100 to put"
	next "the foe to SLEEP,"
	next "60 in 100 to"
	next "CONFUSE it."
	done
