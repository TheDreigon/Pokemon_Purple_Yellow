SilphCo5F_Script:
	call SilphCo5FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo5TrainerHeaders
	ld de, SilphCo5F_ScriptPointers
	ld a, [wSilphCo5FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo5FCurScript], a
	ret

SilphCo5FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	ld hl, .GateCoordinates
	call SilphCo4F_SetCardKeyDoorYScript
	call SilphCo5F_SetUnlockedSilphCoDoorsScript
	CheckEvent EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	jr nz, .unlock_door1
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 2, 3
	predef ReplaceTileBlock
	pop af
.unlock_door1
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_5_UNLOCKED_DOOR2, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	jr nz, .unlock_door2
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef ReplaceTileBlock
	pop af
.unlock_door2
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_5_UNLOCKED_DOOR3, EVENT_SILPH_CO_5_UNLOCKED_DOOR2
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 5, 7
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  3,  2
	dbmapcoord  3,  6
	dbmapcoord  7,  5
	db -1 ; end

SilphCo5F_SetUnlockedSilphCoDoorsScript:
	EventFlagAddress hl, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	cp $1
	jr nz, .unlock_door1
	SetEventReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret
.unlock_door1
	cp $2
	jr nz, .unlock_door2
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR2, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret
.unlock_door2
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR3, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret

SilphCo5F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SILPHCO5F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO5F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO5F_END_BATTLE

SilphCo5F_TextPointers:
	def_text_pointers
	dw_const SilphCo5FSilphWorkerMText,   TEXT_SILPHCO5F_SILPH_WORKER_M
	dw_const SilphCo5FRocket1Text,        TEXT_SILPHCO5F_ROCKET1
	dw_const SilphCo5FScientistText,      TEXT_SILPHCO5F_SCIENTIST
	dw_const SilphCo5FRockerText,         TEXT_SILPHCO5F_ROCKER
	dw_const SilphCo5FRocket2Text,        TEXT_SILPHCO5F_ROCKET2
	dw_const PickUpItemText,              TEXT_SILPHCO5F_TM_SCARY_FACE
	dw_const PickUpItemText,              TEXT_SILPHCO5F_CALCIUM
	dw_const PickUpItemText,              TEXT_SILPHCO5F_CARD_KEY
	dw_const SilphCo5FPokemonReport1Text, TEXT_SILPHCO5F_POKEMON_REPORT1
	dw_const SilphCo5FPokemonReport2Text, TEXT_SILPHCO5F_POKEMON_REPORT2
	dw_const SilphCo5FPokemonReport3Text, TEXT_SILPHCO5F_POKEMON_REPORT3

SilphCo5TrainerHeaders:
	def_trainers 2
SilphCo5TrainerHeader0:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_0, TEXT_SILPHCO5F_ROCKET1, SilphCo5FRocket1BattleText, SilphCo5FRocket1EndBattleText, SilphCo5FRocket1AfterBattleText
SilphCo5TrainerHeader1:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_1, TEXT_SILPHCO5F_SCIENTIST, SilphCo5FScientistBattleText, SilphCo5FScientistEndBattleText, SilphCo5FScientistAfterBattleText
SilphCo5TrainerHeader2:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_2, TEXT_SILPHCO5F_ROCKER, SilphCo5FRockerBattleText, SilphCo5FRockerEndBattleText, SilphCo5FRockerAfterBattleText
SilphCo5TrainerHeader3:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_3, TEXT_SILPHCO5F_ROCKET2, SilphCo5FRocket2BattleText, SilphCo5FRocket2EndBattleText, SilphCo5FRocket2AfterBattleText
	db -1 ; end

SilphCo5FSilphWorkerMText:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	jr z, .rocketStillHere
	CheckEvent EVENT_GOT_SILPH_PORYGON
	jr nz, .alreadyGave
; Silph liberated, prototype not yet handed out -> give PORYGON L30 (manga: the
; man-made mon is only trusted to a Trainer who just cleared the building).
	ld hl, .PorygonOfferText
	call PrintText
	lb bc, PORYGON, 30
	call GivePokemon
	jr nc, .done ; party + box full -> bail, retry on next talk
	ld a, [wSimulatedJoypadStatesEnd]
	and a
	call z, WaitForTextScrollButtonPress
	call EnableAutoTextBoxDrawing
	ld hl, .PorygonDescText
	call PrintText
	SetEvent EVENT_GOT_SILPH_PORYGON
	jr .done
.rocketStillHere
	ld hl, .ThatsYouRightText
	call PrintText
	jr .done
.alreadyGave
	ld hl, .YoureOurHeroText
	call PrintText
.done
	jp TextScriptEnd

.ThatsYouRightText:
	text_far _SilphCo5FSilphWorkerMThatsYouRightText
	text_end

.YoureOurHeroText:
	text_far _SilphCo5FSilphWorkerMYoureOurHeroText
	text_end

.PorygonOfferText:
	text_far _SilphCo5FSilphWorkerMPorygonOfferText
	text_end

.PorygonDescText:
	text_far _SilphCo5FSilphWorkerMPorygonDescText
	text_end

SilphCo5FRocket1Text:
	text_asm
	ld hl, SilphCo5TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FRocket1BattleText:
	text_far _SilphCo5FRocket1BattleText
	text_end

SilphCo5FRocket1EndBattleText:
	text_far _SilphCo5FRocket1EndBattleText
	text_end

SilphCo5FRocket1AfterBattleText:
	text_far _SilphCo5FRocket1AfterBattleText
	text_end

SilphCo5FScientistText:
	text_asm
	ld hl, SilphCo5TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FScientistBattleText:
	text_far _SilphCo5FScientistBattleText
	text_end

SilphCo5FScientistEndBattleText:
	text_far _SilphCo5FScientistEndBattleText
	text_end

SilphCo5FScientistAfterBattleText:
	text_far _SilphCo5FScientistAfterBattleText
	text_end

SilphCo5FRockerText:
	text_asm
	ld hl, SilphCo5TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FRockerBattleText:
	text_far _SilphCo5FRockerBattleText
	text_end

SilphCo5FRockerEndBattleText:
	text_far _SilphCo5FRockerEndBattleText
	text_end

SilphCo5FRockerAfterBattleText:
	text_far _SilphCo5FRockerAfterBattleText
	text_end

SilphCo5FRocket2Text:
	text_asm
	ld hl, SilphCo5TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FRocket2BattleText:
	text_far _SilphCo5FRocket2BattleText
	text_end

SilphCo5FRocket2EndBattleText:
	text_far _SilphCo5FRocket2EndBattleText
	text_end

SilphCo5FRocket2AfterBattleText:
	text_far _SilphCo5FRocket2AfterBattleText
	text_end

SilphCo5FPokemonReport1Text:
	text_far _SilphCo5FPokemonReport1Text
	text_end

SilphCo5FPokemonReport2Text:
	text_far _SilphCo5FPokemonReport2Text
	text_end

SilphCo5FPokemonReport3Text:
	text_far _SilphCo5FPokemonReport3Text
	text_end
