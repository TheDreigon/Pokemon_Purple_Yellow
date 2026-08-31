DisplayItemDescription::
	ld a, [wcf91]
	dec a
	cp a, HM01 - 1
	jr c, .ok
	sub HM01 - FLOOR_B2F
.ok
	ld hl, ItemDescriptionPointers
	ld bc, 5
	call AddNTimes
	jp PrintText

; v0.7: the table is POSITIONAL and the stride above is 5 -- one text_far plus
; its text_end. A single entry too many or too few does not fail to build, it
; hands every item past the slip the NEXT item's text, or reads past the table.
; PP MAX shipped from v0.5 to v0.7 reading the dead-id placeholder because
; nothing here said how long this was supposed to be. The length is derived
; from the same constants DisplayItemDescription folds with, so inserting an
; ordinary item moves both sides together and only a real mistake trips it.
	table_width 5, ItemDescriptionPointers
ItemDescriptionPointers:
	text_far _MasterBallDescription
	text_end
	text_far _UltraBallDescription
	text_end
	text_far _GreatBallDescription
	text_end
	text_far _PokeBallDescription
	text_end
	text_far _TownMapDescription
	text_end
	text_far _BicycleDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _MoonStoneDescription
	text_end
	text_far _PoisonHealDescription
	text_end
	text_far _BurnHealDescription
	text_end
	text_far _IceHealDescription
	text_end
	text_far _SleepHealDescription
	text_end
	text_far _ParalysisHealDescription
	text_end
	text_far _FullRestoreDescription
	text_end
	text_far _MaxPotionDescription
	text_end
	text_far _HyperPotionDescription
	text_end
	text_far _SuperPotionDescription
	text_end
	text_far _PotionDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _EscapeRopeDescription
	text_end
	text_far _RepelDescription
	text_end
	text_far _OldAmberDescription
	text_end
	text_far _FireStoneDescription
	text_end
	text_far _ThunderStoneDescription
	text_end
	text_far _WaterStoneDescription
	text_end
	text_far _HPUpDescription
	text_end
	text_far _ProteinDescription
	text_end
	text_far _IronDescription
	text_end
	text_far _CarbosDescription
	text_end
	text_far _CalciumDescription
	text_end
	text_far _RareCandyDescription
	text_end
	text_far _DomeFossilDescription
	text_end
	text_far _HelixFossilDescription
	text_end
	text_far _SecretKeyDescription
	text_end
; v0.7: item $2C, the phantom slot that became the TRAINER MANUAL.
	text_far _TrainerManualDescription
	text_end
	text_far _BikeVoucherDescription
	text_end
	text_far _XAccuracyDescription
	text_end
	text_far _LeafStoneDescription
	text_end
	text_far _CardKeyDescription
	text_end
	text_far _NuggetDescription
	text_end
	text_far _PPMaxDescription
	text_end
	text_far _PokeDollDescription
	text_end
	text_far _FullHealDescription
	text_end
	text_far _ReviveDescription
	text_end
	text_far _MaxReviveDescription
	text_end
	text_far _GuardSpecDescription
	text_end
	text_far _SuperRepelDescription
	text_end
	text_far _MaxRepelDescription
	text_end
	text_far _DireHitDescription
	text_end
	text_far _UnusedItemDescription
	text_end
	text_far _FreshWaterDescription
	text_end
	text_far _SodaPopDescription
	text_end
	text_far _LemonadeDescription
	text_end
	text_far _SSTicketDescription
	text_end
	text_far _GoldTeethDescription
	text_end
	text_far _XAttackDescription
	text_end
	text_far _XDefendDescription
	text_end
	text_far _XSpeedDescription
	text_end
	text_far _XSpecialDescription
	text_end
	text_far _CoinCaseDescription
	text_end
	text_far _OaksParcelDescription
	text_end
	text_far _ItemfinderDescription
	text_end
	text_far _SilphScopeDescription
	text_end
	text_far _PokeFluteDescription
	text_end
	text_far _LiftKeyDescription
	text_end
	text_far _ExpShareDescription
	text_end
	text_far _OldRodDescription
	text_end
	text_far _GoodRodDescription
	text_end
	text_far _SuperRodDescription
	text_end
	text_far _PPUpDescription
	text_end
	text_far _EtherDescription
	text_end
	text_far _MaxEtherDescription
	text_end
	text_far _ElixirDescription
	text_end
	text_far _MaxElixirDescription
	text_end
	text_far _BillsChipDescription
	text_end
	text_far _HM01Description
	text_end
	text_far _HM02Description
	text_end
	text_far _HM03Description
	text_end
	text_far _HM04Description
	text_end
	text_far _HM05Description
	text_end
	text_far _TM01Description
	text_end
	text_far _TM02Description
	text_end
	text_far _TM03Description
	text_end
	text_far _TM04Description
	text_end
	text_far _TM05Description
	text_end
	text_far _TM06Description
	text_end
	text_far _TM07Description
	text_end
	text_far _TM08Description
	text_end
	text_far _TM09Description
	text_end
	text_far _TM10Description
	text_end
	text_far _TM11Description
	text_end
	text_far _TM12Description
	text_end
	text_far _TM13Description
	text_end
	text_far _TM14Description
	text_end
	text_far _TM15Description
	text_end
	text_far _TM16Description
	text_end
	text_far _TM17Description
	text_end
	text_far _TM18Description
	text_end
	text_far _TM19Description
	text_end
	text_far _TM20Description
	text_end
	text_far _TM21Description
	text_end
	text_far _TM22Description
	text_end
	text_far _TM23Description
	text_end
	text_far _TM24Description
	text_end
	text_far _TM25Description
	text_end
	text_far _TM26Description
	text_end
	text_far _TM27Description
	text_end
	text_far _TM28Description
	text_end
	text_far _TM29Description
	text_end
	text_far _TM30Description
	text_end
	text_far _TM31Description
	text_end
	text_far _TM32Description
	text_end
	text_far _TM33Description
	text_end
	text_far _TM34Description
	text_end
	text_far _TM35Description
	text_end
	text_far _TM36Description
	text_end
	text_far _TM37Description
	text_end
	text_far _TM38Description
	text_end
	text_far _TM39Description
	text_end
	text_far _TM40Description
	text_end
	text_far _TM41Description
	text_end
	text_far _TM42Description
	text_end
	text_far _TM43Description
	text_end
	text_far _TM44Description
	text_end
	text_far _TM45Description
	text_end
	text_far _TM46Description
	text_end
	text_far _TM47Description
	text_end
	text_far _TM48Description
	text_end
	text_far _TM49Description
	text_end
	text_far _TM50Description
	text_end
	text_far _TM51Description
	text_end
	text_far _TM52Description
	text_end
	text_far _TM53Description
	text_end
	text_far _TM54Description
	text_end
	text_far _TM55Description
	text_end
	assert_table_length TM01 + NUM_TMS - 1 - (HM01 - FLOOR_B2F)
