; v0.7: MOVE INFO description tables.
;
; Lives in the same bank as ShowMoveInfo, because TextCommandProcessor reads
; through hl in whatever bank is switched in. The strings themselves float in
; their own text section and are reached through text_far, which is the same
; arrangement the Pokedex uses for its entries.

; Per-move overrides, checked before the effect table. A move only belongs here
; when the shared effect line would be wrong or would waste the move's
; character. Format: move id, pointer. Terminated by -1.
MoveDescriptionOverrides:
	db DRAGON_RAGE,
	dw MoveDesc_DragonRage
	db SONICBOOM,    
	dw MoveDesc_Sonicboom
	db REST,         
	dw MoveDesc_Rest
	db SOFTBOILED,   
	dw MoveDesc_Softboiled
	db NIGHT_SLASH,  
	dw MoveDesc_HighCrit
	db DRAGON_CLAW,  
	dw MoveDesc_HighCrit
	db VOLT_TACKLE,  
	dw MoveDesc_HighCritPriority
	db MACH_PUNCH,   
	dw MoveDesc_Priority
	db KARATE_CHOP,  
	dw MoveDesc_HighCrit
	db SKY_UPPERCUT, 
	dw MoveDesc_HighCrit
	db SHADOW_SNEAK, 
	dw MoveDesc_Priority
	db RAZOR_LEAF,   
	dw MoveDesc_HighCrit
	db QUICK_ATTACK, 
	dw MoveDesc_Priority
	db SLASH,        
	dw MoveDesc_HighCrit
	db EXTREMESPEED, 
	dw MoveDesc_ExtremeSpeed
	db CUT,          
	dw MoveDesc_HighCrit
	db BULLET_PUNCH, 
	dw MoveDesc_Priority
	db AQUA_JET,     
	dw MoveDesc_Priority
	db -1

; One entry per move effect, indexed by effect id. Must stay in constant order
; and must stay complete -- an effect with no entry would read whatever follows
; the table as a pointer. Generated from constants/move_effect_constants.asm.
MoveEffectDescriptions:
	table_width 2, MoveEffectDescriptions
	dw MoveDesc_NoAdditionalEffect ; NO_ADDITIONAL_EFFECT
	dw MoveDesc_Unused ; EFFECT_01
	dw MoveDesc_PoisonSide1 ; POISON_SIDE_EFFECT1
	dw MoveDesc_DrainHP ; DRAIN_HP_EFFECT
	dw MoveDesc_BurnSide1 ; BURN_SIDE_EFFECT1
	dw MoveDesc_FreezeSide1 ; FREEZE_SIDE_EFFECT1
	dw MoveDesc_ParalyzeSide1 ; PARALYZE_SIDE_EFFECT1
	dw MoveDesc_Explode ; EXPLODE_EFFECT
	dw MoveDesc_DreamEater ; DREAM_EATER_EFFECT
	dw MoveDesc_MirrorMove ; MIRROR_MOVE_EFFECT
	dw MoveDesc_AttackUp1 ; ATTACK_UP1_EFFECT
	dw MoveDesc_DefenseUp1 ; DEFENSE_UP1_EFFECT
	dw MoveDesc_SpeedUp1 ; SPEED_UP1_EFFECT
	dw MoveDesc_SpecialUp1 ; SPECIAL_UP1_EFFECT
	dw MoveDesc_AccuracyUp1 ; ACCURACY_UP1_EFFECT
	dw MoveDesc_EvasionUp1 ; EVASION_UP1_EFFECT
	dw MoveDesc_PayDay ; PAY_DAY_EFFECT
	dw MoveDesc_Swift ; SWIFT_EFFECT
	dw MoveDesc_AttackDown1 ; ATTACK_DOWN1_EFFECT
	dw MoveDesc_DefenseDown1 ; DEFENSE_DOWN1_EFFECT
	dw MoveDesc_SpeedDown1 ; SPEED_DOWN1_EFFECT
	dw MoveDesc_SpecialDown1 ; SPECIAL_DOWN1_EFFECT
	dw MoveDesc_AccuracyDown1 ; ACCURACY_DOWN1_EFFECT
	dw MoveDesc_EvasionDown1 ; EVASION_DOWN1_EFFECT
	dw MoveDesc_Conversion ; CONVERSION_EFFECT
	dw MoveDesc_Haze ; HAZE_EFFECT
	dw MoveDesc_Bide ; BIDE_EFFECT
	dw MoveDesc_ThrashPetalDance ; THRASH_PETAL_DANCE_EFFECT
	dw MoveDesc_SwitchAndTeleport ; SWITCH_AND_TELEPORT_EFFECT
	dw MoveDesc_TwoToFiveAttacks ; TWO_TO_FIVE_ATTACKS_EFFECT
	dw MoveDesc_Unused ; EFFECT_1E
	dw MoveDesc_FlinchSide1 ; FLINCH_SIDE_EFFECT1
	dw MoveDesc_Sleep ; SLEEP_EFFECT
	dw MoveDesc_PoisonSide2 ; POISON_SIDE_EFFECT2
	dw MoveDesc_BurnSide2 ; BURN_SIDE_EFFECT2
	dw MoveDesc_FreezeSide2 ; FREEZE_SIDE_EFFECT2
	dw MoveDesc_ParalyzeSide2 ; PARALYZE_SIDE_EFFECT2
	dw MoveDesc_FlinchSide2 ; FLINCH_SIDE_EFFECT2
	dw MoveDesc_OHKO ; OHKO_EFFECT
	dw MoveDesc_Charge ; CHARGE_EFFECT
	dw MoveDesc_SuperFang ; SUPER_FANG_EFFECT
	dw MoveDesc_SpecialDamage ; UNUSED_SPECIAL_DAMAGE_EFFECT
	dw MoveDesc_Trapping ; TRAPPING_EFFECT
	dw MoveDesc_Fly ; FLY_EFFECT
	dw MoveDesc_AttackTwice ; ATTACK_TWICE_EFFECT
	dw MoveDesc_JumpKick ; JUMP_KICK_EFFECT
	dw MoveDesc_Mist ; MIST_EFFECT
	dw MoveDesc_FocusEnergy ; FOCUS_ENERGY_EFFECT
	dw MoveDesc_Recoil ; RECOIL_EFFECT
	dw MoveDesc_Confusion ; CONFUSION_EFFECT
	dw MoveDesc_AttackUp2 ; ATTACK_UP2_EFFECT
	dw MoveDesc_DefenseUp2 ; DEFENSE_UP2_EFFECT
	dw MoveDesc_SpeedUp2 ; SPEED_UP2_EFFECT
	dw MoveDesc_SpecialUp2 ; SPECIAL_UP2_EFFECT
	dw MoveDesc_AccuracyUp2 ; ACCURACY_UP2_EFFECT
	dw MoveDesc_EvasionUp2 ; EVASION_UP2_EFFECT
	dw MoveDesc_Heal ; HEAL_EFFECT
	dw MoveDesc_Transform ; TRANSFORM_EFFECT
	dw MoveDesc_AttackDown2 ; ATTACK_DOWN2_EFFECT
	dw MoveDesc_DefenseDown2 ; DEFENSE_DOWN2_EFFECT
	dw MoveDesc_SpeedDown2 ; SPEED_DOWN2_EFFECT
	dw MoveDesc_SpecialDown2 ; SPECIAL_DOWN2_EFFECT
	dw MoveDesc_AccuracyDown2 ; ACCURACY_DOWN2_EFFECT
	dw MoveDesc_EvasionDown2 ; EVASION_DOWN2_EFFECT
	dw MoveDesc_LightScreen ; LIGHT_SCREEN_EFFECT
	dw MoveDesc_Reflect ; REFLECT_EFFECT
	dw MoveDesc_Poison ; POISON_EFFECT
	dw MoveDesc_Paralyze ; PARALYZE_EFFECT
	dw MoveDesc_AttackDownSide ; ATTACK_DOWN_SIDE_EFFECT
	dw MoveDesc_DefenseDownSide ; DEFENSE_DOWN_SIDE_EFFECT
	dw MoveDesc_SpeedDownSide ; SPEED_DOWN_SIDE_EFFECT
	dw MoveDesc_SpecialDownSide ; SPECIAL_DOWN_SIDE_EFFECT
	dw MoveDesc_AttackDefenseUp1 ; ATTACK_DEFENSE_UP1_EFFECT
	dw MoveDesc_AccuracyEvasionDown1 ; ACCURACY_EVASION_DOWN1_EFFECT
	dw MoveDesc_Burn ; BURN_EFFECT
	dw MoveDesc_PoisonSide3 ; POISON_SIDE_EFFECT3
	dw MoveDesc_ConfusionSide1 ; CONFUSION_SIDE_EFFECT1
	dw MoveDesc_Twineedle ; TWINEEDLE_EFFECT
	dw MoveDesc_AttackAccuracyUp1 ; ATTACK_ACCURACY_UP1_EFFECT
	dw MoveDesc_Substitute ; SUBSTITUTE_EFFECT
	dw MoveDesc_HyperBeam ; HYPER_BEAM_EFFECT
	dw MoveDesc_Rage ; RAGE_EFFECT
	dw MoveDesc_Mimic ; MIMIC_EFFECT
	dw MoveDesc_Metronome ; METRONOME_EFFECT
	dw MoveDesc_LeechSeed ; LEECH_SEED_EFFECT
	dw MoveDesc_Splash ; SPLASH_EFFECT
	dw MoveDesc_Disable ; DISABLE_EFFECT
	dw MoveDesc_SpeedEvasionUp1 ; SPEED_EVASION_UP1_EFFECT
	dw MoveDesc_ConfusionSide2 ; CONFUSION_SIDE_EFFECT2
	dw MoveDesc_SpecialSpeedDown1 ; SPECIAL_SPEED_DOWN1_EFFECT
	dw MoveDesc_AttackUp1Down1 ; ATTACK_UP1_DOWN1_EFFECT
	dw MoveDesc_SpecialUp1Heal ; SPECIAL_UP1_HEAL_EFFECT
	dw MoveDesc_TriStatusSide ; TRI_STATUS_SIDE_EFFECT
	dw MoveDesc_ConfusionSide3 ; CONFUSION_SIDE_EFFECT3
	dw MoveDesc_SpeedEvasionDown1 ; SPEED_EVASION_DOWN1_EFFECT
	dw MoveDesc_SpecialSpeedUp1 ; SPECIAL_SPEED_UP1_EFFECT
	dw MoveDesc_ParalyzeSide3 ; PARALYZE_SIDE_EFFECT3
	dw MoveDesc_SpecialAccuracyUp1 ; SPECIAL_ACCURACY_UP1_EFFECT
	dw MoveDesc_BurnSide3 ; BURN_SIDE_EFFECT3
	dw MoveDesc_FalseSwipe ; FALSE_SWIPE_EFFECT
	dw MoveDesc_TargetLevelDamage ; TARGET_LEVEL_DAMAGE_EFFECT
	dw MoveDesc_LevelDamage ; USER_LEVEL_DAMAGE_EFFECT
	dw MoveDesc_SpecialDamage ; SET_DAMAGE_EFFECT
	dw MoveDesc_SpecialDown2Flinch ; SPECIAL_DOWN2_FLINCH_EFFECT
	dw MoveDesc_SpecialDown1Flinch ; SPECIAL_DOWN1_FLINCH_EFFECT
	assert_table_length NUM_MOVE_EFFECTS + 1

MoveDesc_AccuracyDown1:
	text_far _MoveDesc_AccuracyDown1
	text_end

MoveDesc_AccuracyDown2:
	text_far _MoveDesc_AccuracyDown2
	text_end

MoveDesc_AccuracyEvasionDown1:
	text_far _MoveDesc_AccuracyEvasionDown1
	text_end

MoveDesc_AccuracyUp1:
	text_far _MoveDesc_AccuracyUp1
	text_end

MoveDesc_AccuracyUp2:
	text_far _MoveDesc_AccuracyUp2
	text_end

MoveDesc_AttackAccuracyUp1:
	text_far _MoveDesc_AttackAccuracyUp1
	text_end

MoveDesc_AttackDefenseUp1:
	text_far _MoveDesc_AttackDefenseUp1
	text_end

MoveDesc_AttackDown1:
	text_far _MoveDesc_AttackDown1
	text_end

MoveDesc_AttackDown2:
	text_far _MoveDesc_AttackDown2
	text_end

MoveDesc_AttackDownSide:
	text_far _MoveDesc_AttackDownSide
	text_end

MoveDesc_AttackTwice:
	text_far _MoveDesc_AttackTwice
	text_end

MoveDesc_AttackUp1:
	text_far _MoveDesc_AttackUp1
	text_end

MoveDesc_AttackUp1Down1:
	text_far _MoveDesc_AttackUp1Down1
	text_end

MoveDesc_AttackUp2:
	text_far _MoveDesc_AttackUp2
	text_end

MoveDesc_Bide:
	text_far _MoveDesc_Bide
	text_end

MoveDesc_Burn:
	text_far _MoveDesc_Burn
	text_end

MoveDesc_BurnSide1:
	text_far _MoveDesc_BurnSide1
	text_end

MoveDesc_BurnSide2:
	text_far _MoveDesc_BurnSide2
	text_end

MoveDesc_BurnSide3:
	text_far _MoveDesc_BurnSide3
	text_end

MoveDesc_Charge:
	text_far _MoveDesc_Charge
	text_end

MoveDesc_Confusion:
	text_far _MoveDesc_Confusion
	text_end

MoveDesc_ConfusionSide1:
	text_far _MoveDesc_ConfusionSide1
	text_end

MoveDesc_ConfusionSide2:
	text_far _MoveDesc_ConfusionSide2
	text_end

MoveDesc_ConfusionSide3:
	text_far _MoveDesc_ConfusionSide3
	text_end

MoveDesc_Conversion:
	text_far _MoveDesc_Conversion
	text_end

MoveDesc_DefenseDown1:
	text_far _MoveDesc_DefenseDown1
	text_end

MoveDesc_DefenseDown2:
	text_far _MoveDesc_DefenseDown2
	text_end

MoveDesc_DefenseDownSide:
	text_far _MoveDesc_DefenseDownSide
	text_end

MoveDesc_DefenseUp1:
	text_far _MoveDesc_DefenseUp1
	text_end

MoveDesc_DefenseUp2:
	text_far _MoveDesc_DefenseUp2
	text_end

MoveDesc_Disable:
	text_far _MoveDesc_Disable
	text_end

MoveDesc_DrainHP:
	text_far _MoveDesc_DrainHP
	text_end

MoveDesc_DreamEater:
	text_far _MoveDesc_DreamEater
	text_end

MoveDesc_EvasionDown1:
	text_far _MoveDesc_EvasionDown1
	text_end

MoveDesc_EvasionDown2:
	text_far _MoveDesc_EvasionDown2
	text_end

MoveDesc_EvasionUp1:
	text_far _MoveDesc_EvasionUp1
	text_end

MoveDesc_EvasionUp2:
	text_far _MoveDesc_EvasionUp2
	text_end

MoveDesc_Explode:
	text_far _MoveDesc_Explode
	text_end

MoveDesc_FlinchSide1:
	text_far _MoveDesc_FlinchSide1
	text_end

MoveDesc_FlinchSide2:
	text_far _MoveDesc_FlinchSide2
	text_end

MoveDesc_Fly:
	text_far _MoveDesc_Fly
	text_end

MoveDesc_FocusEnergy:
	text_far _MoveDesc_FocusEnergy
	text_end

MoveDesc_FreezeSide1:
	text_far _MoveDesc_FreezeSide1
	text_end

MoveDesc_FreezeSide2:
	text_far _MoveDesc_FreezeSide2
	text_end

MoveDesc_Haze:
	text_far _MoveDesc_Haze
	text_end

MoveDesc_Heal:
	text_far _MoveDesc_Heal
	text_end

MoveDesc_HyperBeam:
	text_far _MoveDesc_HyperBeam
	text_end

MoveDesc_JumpKick:
	text_far _MoveDesc_JumpKick
	text_end

MoveDesc_LeechSeed:
	text_far _MoveDesc_LeechSeed
	text_end

MoveDesc_LightScreen:
	text_far _MoveDesc_LightScreen
	text_end

MoveDesc_Metronome:
	text_far _MoveDesc_Metronome
	text_end

MoveDesc_Mimic:
	text_far _MoveDesc_Mimic
	text_end

MoveDesc_MirrorMove:
	text_far _MoveDesc_MirrorMove
	text_end

MoveDesc_Mist:
	text_far _MoveDesc_Mist
	text_end

MoveDesc_NoAdditionalEffect:
	text_far _MoveDesc_NoAdditionalEffect
	text_end

MoveDesc_FalseSwipe:
	text_far _MoveDesc_FalseSwipe
	text_end

MoveDesc_TargetLevelDamage:
	text_far _MoveDesc_TargetLevelDamage
	text_end

MoveDesc_OHKO:
	text_far _MoveDesc_OHKO
	text_end

MoveDesc_Paralyze:
	text_far _MoveDesc_Paralyze
	text_end

MoveDesc_ParalyzeSide1:
	text_far _MoveDesc_ParalyzeSide1
	text_end

MoveDesc_ParalyzeSide2:
	text_far _MoveDesc_ParalyzeSide2
	text_end

MoveDesc_ParalyzeSide3:
	text_far _MoveDesc_ParalyzeSide3
	text_end

MoveDesc_PayDay:
	text_far _MoveDesc_PayDay
	text_end

MoveDesc_Poison:
	text_far _MoveDesc_Poison
	text_end

MoveDesc_PoisonSide1:
	text_far _MoveDesc_PoisonSide1
	text_end

MoveDesc_PoisonSide2:
	text_far _MoveDesc_PoisonSide2
	text_end

MoveDesc_PoisonSide3:
	text_far _MoveDesc_PoisonSide3
	text_end

MoveDesc_Rage:
	text_far _MoveDesc_Rage
	text_end

MoveDesc_Recoil:
	text_far _MoveDesc_Recoil
	text_end

MoveDesc_Reflect:
	text_far _MoveDesc_Reflect
	text_end

MoveDesc_Sleep:
	text_far _MoveDesc_Sleep
	text_end

MoveDesc_SpecialAccuracyUp1:
	text_far _MoveDesc_SpecialAccuracyUp1
	text_end

MoveDesc_SpecialDamage:
	text_far _MoveDesc_SpecialDamage
	text_end

MoveDesc_SpecialDown1:
	text_far _MoveDesc_SpecialDown1
	text_end

MoveDesc_SpecialDown2:
	text_far _MoveDesc_SpecialDown2
	text_end

MoveDesc_SpecialDownSide:
	text_far _MoveDesc_SpecialDownSide
	text_end

MoveDesc_SpecialSpeedDown1:
	text_far _MoveDesc_SpecialSpeedDown1
	text_end

MoveDesc_SpecialSpeedUp1:
	text_far _MoveDesc_SpecialSpeedUp1
	text_end

MoveDesc_SpecialUp1:
	text_far _MoveDesc_SpecialUp1
	text_end

MoveDesc_SpecialUp1Heal:
	text_far _MoveDesc_SpecialUp1Heal
	text_end

MoveDesc_SpecialUp2:
	text_far _MoveDesc_SpecialUp2
	text_end

MoveDesc_SpeedDown1:
	text_far _MoveDesc_SpeedDown1
	text_end

MoveDesc_SpeedDown2:
	text_far _MoveDesc_SpeedDown2
	text_end

MoveDesc_SpeedDownSide:
	text_far _MoveDesc_SpeedDownSide
	text_end

MoveDesc_SpeedEvasionDown1:
	text_far _MoveDesc_SpeedEvasionDown1
	text_end

MoveDesc_SpeedEvasionUp1:
	text_far _MoveDesc_SpeedEvasionUp1
	text_end

MoveDesc_SpeedUp1:
	text_far _MoveDesc_SpeedUp1
	text_end

MoveDesc_SpeedUp2:
	text_far _MoveDesc_SpeedUp2
	text_end

MoveDesc_Splash:
	text_far _MoveDesc_Splash
	text_end

MoveDesc_Substitute:
	text_far _MoveDesc_Substitute
	text_end

MoveDesc_SuperFang:
	text_far _MoveDesc_SuperFang
	text_end

MoveDesc_Swift:
	text_far _MoveDesc_Swift
	text_end

MoveDesc_SwitchAndTeleport:
	text_far _MoveDesc_SwitchAndTeleport
	text_end

MoveDesc_ThrashPetalDance:
	text_far _MoveDesc_ThrashPetalDance
	text_end

MoveDesc_Transform:
	text_far _MoveDesc_Transform
	text_end

MoveDesc_Trapping:
	text_far _MoveDesc_Trapping
	text_end

MoveDesc_TriStatusSide:
	text_far _MoveDesc_TriStatusSide
	text_end

MoveDesc_Twineedle:
	text_far _MoveDesc_Twineedle
	text_end

MoveDesc_TwoToFiveAttacks:
	text_far _MoveDesc_TwoToFiveAttacks
	text_end

MoveDesc_Unused:
	text_far _MoveDesc_Unused
	text_end

MoveDesc_DragonRage:
	text_far _MoveDesc_DragonRage
	text_end

MoveDesc_ExtremeSpeed:
	text_far _MoveDesc_ExtremeSpeed
	text_end

MoveDesc_HighCrit:
	text_far _MoveDesc_HighCrit
	text_end

MoveDesc_HighCritPriority:
	text_far _MoveDesc_HighCritPriority
	text_end

MoveDesc_LevelDamage:
	text_far _MoveDesc_LevelDamage
	text_end

MoveDesc_Priority:
	text_far _MoveDesc_Priority
	text_end

MoveDesc_Rest:
	text_far _MoveDesc_Rest
	text_end

MoveDesc_Softboiled:
	text_far _MoveDesc_Softboiled
	text_end

MoveDesc_Sonicboom:
	text_far _MoveDesc_Sonicboom
	text_end

MoveDesc_SpecialDown2Flinch:
	text_far _MoveDesc_SpecialDown2Flinch
	text_end

MoveDesc_SpecialDown1Flinch:
	text_far _MoveDesc_SpecialDown1Flinch
	text_end
