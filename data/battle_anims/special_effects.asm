MACRO anim_special_effect
	db \1
	dw \2
ENDM

AnimationIdSpecialEffects:
	; animation id, effect routine address
	anim_special_effect GUILLOTINE,            AnimationFlashScreen
	anim_special_effect HEAVY_SLAM,            AnimationFlashScreen
	anim_special_effect HEADBUTT,              AnimationFlashScreen
	anim_special_effect TAIL_WHIP,             TailWhipAnimationUnused
	anim_special_effect GROWL,                 DoGrowlSpecialEffects
	anim_special_effect DISABLE,               AnimationFlashScreen
	anim_special_effect BLIZZARD,              DoBlizzardSpecialEffects
	anim_special_effect BUBBLEBEAM,            AnimationFlashScreen
	anim_special_effect HYPER_BEAM,            FlashScreenEveryFourFrameBlocks
	anim_special_effect THUNDERBOLT,           FlashScreenEveryEightFrameBlocks
	anim_special_effect REFLECT,               AnimationFlashScreen
	anim_special_effect SPORE,                 FlashScreenEveryFourFrameBlocks
	anim_special_effect EXPLOSION,             DoExplodeSpecialEffects
	anim_special_effect ROCK_SLIDE,            DoRockSlideSpecialEffects
	db -1 ; end

; v0.7 anim split (2026-08-31): the SPECIAL animations' effect rows live in
; their own table now - their indexes (1..35) overlap move ids, so sharing
; the move-keyed table above would collide. Looked up by hSpecialAnimIndex
; when wAnimationID carries SPECIAL_ANIM_MARKER.
SpecialAnimIdSpecialEffects:
	anim_special_effect TRADE_BALL_DROP_ANIM,  TradeHidePokemon
	anim_special_effect TRADE_BALL_SHAKE_ANIM, TradeShakePokeball
	anim_special_effect TRADE_BALL_TILT_ANIM,  TradeJumpPokeball
	anim_special_effect TOSS_ANIM,             DoBallTossSpecialEffects
	anim_special_effect SHAKE_ANIM,            DoBallShakeSpecialEffects
	anim_special_effect POOF_ANIM,             DoPoofSpecialEffects
	anim_special_effect GREATTOSS_ANIM,        DoBallTossSpecialEffects
	anim_special_effect ULTRATOSS_ANIM,        DoBallTossSpecialEffects
	db -1 ; end
