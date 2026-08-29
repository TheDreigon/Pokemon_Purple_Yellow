FuchsiaGym_Script:
	call .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, FuchsiaGymTrainerHeaders
	ld de, FuchsiaGym_ScriptPointers
	ld a, [wFuchsiaGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wFuchsiaGymCurScript], a
	ret

.LoadNames:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	ret

.CityName:
	db "FUCHSIA CITY@"

.LeaderName:
	db "KOGA@"

FuchsiaGymResetScripts:
	xor a ; SCRIPT_FUCHSIAGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wFuchsiaGymCurScript], a
	ld [wCurMapScript], a
	ret

FuchsiaGym_ScriptPointers:
	def_script_pointers
	dw_const FuchsiaGymDefaultScript,              SCRIPT_FUCHSIAGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_FUCHSIAGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_FUCHSIAGYM_END_BATTLE
	dw_const FuchsiaGymKogaPostBattleScript,        SCRIPT_FUCHSIAGYM_KOGA_POST_BATTLE
	dw_const FuchsiaGymGateKickoutScript,          SCRIPT_FUCHSIAGYM_GATE_KICKOUT

; Badge-gating (strict gym order): requires RAINBOWBADGE.
; Entering without it auto-triggers the gate text and the player is shoved
; back out the door (Route 22 gate pattern).
FuchsiaGymDefaultScript:
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jp nz, CheckFightingMapTrainers
	ld hl, FuchsiaGymGateCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_FUCHSIAGYM_GATE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

FuchsiaGymGateCoords: ; the two door/warp tiles
	dbmapcoord  4, 17
	dbmapcoord  5, 17
	db -1 ; end

FuchsiaGymGateKickoutScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_FUCHSIAGYM_DEFAULT
	ld [wFuchsiaGymCurScript], a
	ld [wCurMapScript], a
	ret

FuchsiaGymKogaPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FuchsiaGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, KogaRematchPostBattle
; fallthrough
FuchsiaGymReceiveGifts:
	ld a, TEXT_FUCHSIAGYM_KOGA_SOUL_BADGE_INFO
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KOGA
	CheckEvent EVENT_GOT_KOGA_TM
	jr nz, .tryCandy
	lb bc, TM_TOXIC, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_FUCHSIAGYM_KOGA_RECEIVED_TM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_KOGA_TM
.tryCandy
	CheckEvent EVENT_GOT_KOGA_CANDY
	jr nz, .gymVictory
	lb bc, RARE_CANDY, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_FUCHSIAGYM_KOGA_RECEIVED_CANDY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_KOGA_CANDY
	jr .gymVictory
.bagFull
	ld a, TEXT_FUCHSIAGYM_KOGA_TM_NO_ROOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_SOULBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_SOULBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, EVENT_BEAT_FUCHSIA_GYM_TRAINER_5

	jp FuchsiaGymResetScripts

KogaRematchPostBattle:
	; reached only on a win (the post-battle script bails to ResetScripts when
	; the player blacked out), so losing does not burn the rematch
	SetEvent EVENT_REMATCHED_KOGA
	ld a, TEXT_FUCHSIAGYM_REMATCH_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp FuchsiaGymResetScripts

; Badge-gating: refusal + shove-out (auto-triggered by the default
; script when the player enters without the required badge).
FuchsiaGymGateText:
	text_asm
	ld hl, .NoBadgeText
	call PrintText
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN | B_BUTTON
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_FUCHSIAGYM_GATE_KICKOUT
	ld [wFuchsiaGymCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

.NoBadgeText:
	text_far _FuchsiaGymGateNoBadgeText
	text_end

FuchsiaGym_TextPointers:
	def_text_pointers
	dw_const FuchsiaGymKogaText,              TEXT_FUCHSIAGYM_KOGA
	dw_const FuchsiaGymRocker1Text,           TEXT_FUCHSIAGYM_ROCKER1
	dw_const FuchsiaGymRocker2Text,           TEXT_FUCHSIAGYM_ROCKER2
	dw_const FuchsiaGymJanineText,            TEXT_FUCHSIAGYM_JANINE
	dw_const FuchsiaGymRocker4Text,           TEXT_FUCHSIAGYM_ROCKER4
	dw_const FuchsiaGymRocker5Text,           TEXT_FUCHSIAGYM_ROCKER5
	dw_const FuchsiaGymRocker6Text,           TEXT_FUCHSIAGYM_ROCKER6
	dw_const FuchsiaGymGymGuideText,          TEXT_FUCHSIAGYM_GYM_GUIDE
	dw_const FuchsiaGymKogaSoulBadgeInfoText, TEXT_FUCHSIAGYM_KOGA_SOUL_BADGE_INFO
	dw_const FuchsiaGymKogaReceivedTMText,  TEXT_FUCHSIAGYM_KOGA_RECEIVED_TM
	dw_const FuchsiaGymKogaTMNoRoomText,    TEXT_FUCHSIAGYM_KOGA_TM_NO_ROOM
	dw_const FuchsiaGymKogaReceivedCandyText, TEXT_FUCHSIAGYM_KOGA_RECEIVED_CANDY
	dw_const FuchsiaGymRematchPostBattleText, TEXT_FUCHSIAGYM_REMATCH_POST_BATTLE
	dw_const FuchsiaGymGateText,              TEXT_FUCHSIAGYM_GATE

FuchsiaGymTrainerHeaders:
	def_trainers 2
FuchsiaGymTrainerHeader0:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, 2, FuchsiaGymRocker1BattleText, FuchsiaGymRocker1EndBattleText, FuchsiaGymRocker1AfterBattleText
FuchsiaGymTrainerHeader1:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_1, 2, FuchsiaGymRocker2BattleText, FuchsiaGymRocker2EndBattleText, FuchsiaGymRocker2AfterBattleText
FuchsiaGymTrainerHeader2:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_2, 4, FuchsiaGymJanineBattleText, FuchsiaGymJanineEndBattleText, FuchsiaGymJanineAfterBattleText
FuchsiaGymTrainerHeader3:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_3, 2, FuchsiaGymRocker4BattleText, FuchsiaGymRocker4EndBattleText, FuchsiaGymRocker4AfterBattleText
FuchsiaGymTrainerHeader4:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_4, 2, FuchsiaGymRocker5BattleText, FuchsiaGymRocker5EndBattleText, FuchsiaGymRocker5AfterBattleText
FuchsiaGymTrainerHeader5:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_5, 2, FuchsiaGymRocker6BattleText, FuchsiaGymRocker6EndBattleText, FuchsiaGymRocker6AfterBattleText
	db -1 ; end

FuchsiaGymKogaText:
	text_asm
	CheckEvent EVENT_BEAT_KOGA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_KOGA_TM
	jr z, .needGifts
	CheckEvent EVENT_GOT_KOGA_CANDY
	jr nz, .afterBeat
.needGifts
	call FuchsiaGymReceiveGifts
	call DisableWaitingAfterTextDisplay
	jr .todone
.afterBeat
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, .KogaRematch
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .todone
.beforeBeat
; Badge-gating: the leader also refuses without the previous badge
; (belt-and-braces - the door gate normally fires first).
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr nz, .hasPrevBadge
	ld hl, .NoBadgeText
	call PrintText
	jp TextScriptEnd
.hasPrevBadge
	ld hl, .BeforeBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, .ReceivedSoulBadgeText
	ld de, .ReceivedSoulBadgeText
	call SaveEndBattleTextPointers
; v0.7 (2026-08-17): gym order is strictly linear in this hack — 4 badges is
; the only possible count here, so the free-order dispatch and its ghost
; branch (party 2, a copy of 1) were removed. Koga is always the 5th.
	jr .Koga5thGym
.todone
	jr .done
; v0.7 rematch cooldown: one rematch per League run. The flag is set by
; KogaRematchPostBattle on a win and cleared again for every leader by
; HallOfFameResetEventsAndSaveScript.
.KogaRematch
	CheckEvent EVENT_REMATCHED_KOGA
	jr nz, .rematchSpent
	ld hl, .PreBattleRematch1Text
	call PrintText
	xor a
	ld [wMenuJoypadPollCount], a ; menu hygiene: a stale Cable Club poll-count would phantom-accept and force this L60+ rematch
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	ld hl, .PreBattleRematch2Text
	call PrintText
	call Delay3
	ld a, OPP_KOGA
	ld [wCurOpponent], a
	ld a, 2 ; the rematch — party 2 since the ghost copy went (2026-08-17)
	ld [wTrainerNo], a
	ld a, $4
	ld [wFuchsiaGymCurScript], a
	ld [wCurMapScript], a
	jr .endBattle
.rematchSpent
	ld hl, .RematchCooldownText
	call PrintText
	jr .done
.refused
	ld hl, .PreBattleRematchRefusedText
	call PrintText
	jr .done
.Koga5thGym
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
.afterBatttle
	ld a, $5
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
.endBattle
	ld a, SCRIPT_FUCHSIAGYM_KOGA_POST_BATTLE
	ld [wFuchsiaGymCurScript], a
.done
	jp TextScriptEnd

.BeforeBattleText:
	text_far _FuchsiaGymKogaBeforeBattleText
	text_end

.NoBadgeText:
	text_far _FuchsiaGymKogaNoBadgeText
	text_end

.ReceivedSoulBadgeText:
	text_far _FuchsiaGymKogaReceivedSoulBadgeText
	text_end

.PostBattleAdviceText:
	text_far _FuchsiaGymKogaPostBattleAdviceText
	text_end

.PreBattleRematch1Text
	text_far _FuchsiaGymRematchPreBattle1Text
	text_end

.PreBattleRematchRefusedText
	text_far _GymRematchRefusedText
	text_end

.RematchCooldownText
	text_far _GymRematchCooldownText
	text_end

.PreBattleRematch2Text
	text_far _FuchsiaGymPreRematchBattle2Text
	text_end

FuchsiaGymRematchPostBattleText:
	text_far _FuchsiaGymRematchPostBattleText
	text_end

FuchsiaGymKogaSoulBadgeInfoText:
	text_far _FuchsiaGymKogaSoulBadgeInfoText
	text_end

FuchsiaGymKogaReceivedTMText:
	text_far _FuchsiaGymKogaReceivedTMText
	sound_get_key_item
	text_far _FuchsiaGymKogaTMExplanationText
	text_end

FuchsiaGymKogaTMNoRoomText:
	text_far _FuchsiaGymKogaTMNoRoomText
	text_end

FuchsiaGymKogaReceivedCandyText:
	text_far _FuchsiaGymKogaReceivedCandyText
	sound_get_item_1
	text_far _FuchsiaGymKogaCandyCommentText
	text_end

FuchsiaGymRocker1Text:
	text_asm
	ld hl, FuchsiaGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker1BattleText:
	text_far _FuchsiaGymRocker1BattleText
	text_end

FuchsiaGymRocker1EndBattleText:
	text_far _FuchsiaGymRocker1EndBattleText
	text_end

FuchsiaGymRocker1AfterBattleText:
	text_far _FuchsiaGymRocker1AfterBattleText
	text_end

FuchsiaGymRocker2Text:
	text_asm
	ld hl, FuchsiaGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker2BattleText:
	text_far _FuchsiaGymRocker2BattleText
	text_end

FuchsiaGymRocker2EndBattleText:
	text_far _FuchsiaGymRocker2EndBattleText
	text_end

FuchsiaGymRocker2AfterBattleText:
	text_far _FuchsiaGymRocker2AfterBattleText
	text_end

FuchsiaGymJanineText:
	text_asm
	ld hl, FuchsiaGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymJanineBattleText:
	text_far _FuchsiaGymJanineBattleText
	text_end

FuchsiaGymJanineEndBattleText:
	text_far _FuchsiaGymJanineEndBattleText
	text_end

FuchsiaGymJanineAfterBattleText:
	text_far _FuchsiaGymJanineAfterBattleText
	text_end

FuchsiaGymRocker4Text:
	text_asm
	ld hl, FuchsiaGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker4BattleText:
	text_far _FuchsiaGymRocker4BattleText
	text_end

FuchsiaGymRocker4EndBattleText:
	text_far _FuchsiaGymRocker4EndBattleText
	text_end

FuchsiaGymRocker4AfterBattleText:
	text_far _FuchsiaGymRocker4AfterBattleText
	text_end

FuchsiaGymRocker5Text:
	text_asm
	ld hl, FuchsiaGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker5BattleText:
	text_far _FuchsiaGymRocker5BattleText
	text_end

FuchsiaGymRocker5EndBattleText:
	text_far _FuchsiaGymRocker5EndBattleText
	text_end

FuchsiaGymRocker5AfterBattleText:
	text_far _FuchsiaGymRocker5AfterBattleText
	text_end

FuchsiaGymRocker6Text:
	text_asm
	ld hl, FuchsiaGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker6BattleText:
	text_far _FuchsiaGymRocker6BattleText
	text_end

FuchsiaGymRocker6EndBattleText:
	text_far _FuchsiaGymRocker6EndBattleText
	text_end

FuchsiaGymRocker6AfterBattleText:
	text_far _FuchsiaGymRocker6AfterBattleText
	text_end

FuchsiaGymGymGuideText:
	text_asm
; v0.7 (his 2026-08-29 request): the first ELIGIBLE pre-badge visit earns a
; FRESH WATER. Eligible = previous badge in hand; once per gym,
; and a full bag defers the gift to the next talk (flag set only on success).
	CheckEvent EVENT_GOT_GYM_GUIDE_WATER_FUCHSIA
	jr nz, .noFreshWater
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr z, .noFreshWater ; not yet eligible for this gym
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	jr nz, .noFreshWater ; already holds THIS gym's badge
	lb bc, FRESH_WATER, 1
	call GiveItem
	jr nc, .noFreshWater ; bag full: defer
	ld hl, FuchsiaGymGuideFreshWaterText
	call PrintText
	SetEvent EVENT_GOT_GYM_GUIDE_WATER_FUCHSIA
.noFreshWater
	CheckEvent EVENT_BEAT_KOGA
	ld hl, .BeatKogaText
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
.afterBeat
	call PrintText
	jp TextScriptEnd

.ChampInMakingText:
	text_far _FuchsiaGymGymGuideChampInMakingText
	text_end

.BeatKogaText:
	text_far _FuchsiaGymGymGuideBeatKogaText
	text_end


FuchsiaGymGuideFreshWaterText:
	text_far _GymGuideFreshWaterText
	sound_get_item_1
	text_promptbutton
	text_end
