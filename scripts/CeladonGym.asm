CeladonGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, CeladonGymTrainerHeaders
	ld de, CeladonGym_ScriptPointers
	ld a, [wCeladonGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeladonGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "CELADON CITY@"

.LeaderName:
	db "ERIKA@"

CeladonGymResetScripts:
	xor a ; SCRIPT_CELADONGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
	ret

CeladonGym_ScriptPointers:
	def_script_pointers
	dw_const CeladonGymDefaultScript,              SCRIPT_CELADONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CELADONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CELADONGYM_END_BATTLE
	dw_const CeladonGymErikaPostBattleScript,       SCRIPT_CELADONGYM_ERIKA_POST_BATTLE
	dw_const CeladonGymGateKickoutScript,          SCRIPT_CELADONGYM_GATE_KICKOUT

; Badge-gating (strict gym order): requires THUNDERBADGE.
; Entering without it auto-triggers the gate text and the player is shoved
; back out the door (Route 22 gate pattern).
CeladonGymDefaultScript:
	ld a, [wObtainedBadges]
	bit BIT_THUNDERBADGE, a
	jp nz, CheckFightingMapTrainers
	ld hl, CeladonGymGateCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_CELADONGYM_GATE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

CeladonGymGateCoords: ; the two door/warp tiles
	dbmapcoord  4, 17
	dbmapcoord  5, 17
	db -1 ; end

CeladonGymGateKickoutScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_CELADONGYM_DEFAULT
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
	ret

CeladonGymErikaPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeladonGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, ErikaRematchPostBattle
; fallthrough
CeladonGymReceiveGifts:
	ld a, TEXT_CELADONGYM_RAINBOWBADGE_INFO
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_ERIKA
	ld a, HS_REDS_HOUSE_2F_MR_MIME
	ld [wMissableObjectIndex], a
	predef ShowObject
	CheckEvent EVENT_GOT_ERIKA_TM
	jr nz, .tryCandy
	lb bc, TM_GIGA_DRAIN, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_CELADONGYM_RECEIVED_TM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_ERIKA_TM
.tryCandy
	CheckEvent EVENT_GOT_ERIKA_CANDY
	jr nz, .gymVictory
	lb bc, RARE_CANDY, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_CELADONGYM_RECEIVED_CANDY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_ERIKA_CANDY
	jr .gymVictory
.bagFull
	ld a, TEXT_CELADONGYM_TM_NO_ROOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_RAINBOWBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_RAINBOWBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_CELADON_GYM_TRAINER_0, EVENT_BEAT_CELADON_GYM_TRAINER_6

	jp CeladonGymResetScripts

ErikaRematchPostBattle:
	; reached only on a win (the post-battle script bails to ResetScripts when
	; the player blacked out), so losing does not burn the rematch
	SetEvent EVENT_REMATCHED_ERIKA
	ld a, TEXT_CELADONGYM_REMATCH_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp CeladonGymResetScripts

; Badge-gating: refusal + shove-out (auto-triggered by the default
; script when the player enters without the required badge).
CeladonGymGateText:
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
	ld a, SCRIPT_CELADONGYM_GATE_KICKOUT
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

.NoBadgeText:
	text_far _CeladonGymGateNoBadgeText
	text_end

CeladonGym_TextPointers:
	def_text_pointers
	dw_const CeladonGymErikaText,            TEXT_CELADONGYM_ERIKA
	dw_const CeladonGymCooltrainerF1Text,    TEXT_CELADONGYM_COOLTRAINER_F1
	dw_const CeladonGymBeauty1Text,          TEXT_CELADONGYM_BEAUTY1
	dw_const CeladonGymCooltrainerF2Text,    TEXT_CELADONGYM_COOLTRAINER_F2
	dw_const CeladonGymBeauty2Text,          TEXT_CELADONGYM_BEAUTY2
	dw_const CeladonGymCooltrainerF3Text,    TEXT_CELADONGYM_COOLTRAINER_F3
	dw_const CeladonGymBeauty3Text,          TEXT_CELADONGYM_BEAUTY3
	dw_const CeladonGymCooltrainerF4Text,    TEXT_CELADONGYM_COOLTRAINER_F4
	dw_const CeladonGymRainbowBadgeInfoText, TEXT_CELADONGYM_RAINBOWBADGE_INFO
	dw_const CeladonGymReceivedTMText,     TEXT_CELADONGYM_RECEIVED_TM
	dw_const CeladonGymTMNoRoomText,       TEXT_CELADONGYM_TM_NO_ROOM
	dw_const CeladonGymReceivedCandyText,  TEXT_CELADONGYM_RECEIVED_CANDY
	dw_const CeladonGymRematchPostBattleText,TEXT_CELADONGYM_REMATCH_POST_BATTLE
	dw_const CeladonGymGateText,             TEXT_CELADONGYM_GATE

CeladonGymTrainerHeaders:
	def_trainers 2
CeladonGymTrainerHeader0:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_0, 2, CeladonGymBattleText2, CeladonGymEndBattleText2, CeladonGymAfterBattleText2
CeladonGymTrainerHeader1:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_1, 2, CeladonGymBattleText3, CeladonGymEndBattleText3, CeladonGymAfterBattleText3
CeladonGymTrainerHeader2:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_2, 4, CeladonGymBattleText4, CeladonGymEndBattleText4, CeladonGymAfterBattleText4
CeladonGymTrainerHeader3:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_3, 4, CeladonGymBattleText5, CeladonGymEndBattleText5, CeladonGymAfterBattleText5
CeladonGymTrainerHeader4:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_4, 2, CeladonGymBattleText6, CeladonGymEndBattleText6, CeladonGymAfterBattleText6
CeladonGymTrainerHeader5:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_5, 2, CeladonGymBattleText7, CeladonGymEndBattleText7, CeladonGymAfterBattleText7
CeladonGymTrainerHeader6:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_6, 3, CeladonGymBattleText8, CeladonGymEndBattleText8, CeladonGymAfterBattleText8
	db -1 ; end

CeladonGymErikaText:
	text_asm
	CheckEvent EVENT_BEAT_ERIKA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_ERIKA_TM
	jr z, .needGifts
	CheckEvent EVENT_GOT_ERIKA_CANDY
	jr nz, .afterBeat
.needGifts
	call CeladonGymReceiveGifts
	call DisableWaitingAfterTextDisplay
	jr .todone
.afterBeat
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, .ErikaRematch
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .todone
.beforeBeat
; Badge-gating: the leader also refuses without the previous badge
; (belt-and-braces - the door gate normally fires first).
	ld a, [wObtainedBadges]
	bit BIT_THUNDERBADGE, a
	jr nz, .hasPrevBadge
	ld hl, .NoBadgeText
	call PrintText
	jp TextScriptEnd
.hasPrevBadge
	ld hl, .PreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, .ReceivedRainbowBadgeText
	ld de, .ReceivedRainbowBadgeText
	call SaveEndBattleTextPointers
; v0.7 (2026-08-17): gym order is strictly linear in this hack — the badge
; chain makes 3 badges the only possible count here, so the Yellow Legacy
; free-order dispatch and its two ghost branches (parties 2-3, byte-for-byte
; copies of 1) were removed. Erika is always the 4th.
	jr .Erika4thGym
.todone
	jp .done ; jp: the rematch-cooldown check pushed .done out of jr range
; v0.7 rematch cooldown: one rematch per League run. The flag is set by
; ErikaRematchPostBattle on a win and cleared again for every leader by
; HallOfFameResetEventsAndSaveScript.
.ErikaRematch
	CheckEvent EVENT_REMATCHED_ERIKA
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
	ld a, OPP_ERIKA
	ld [wCurOpponent], a
	ld a, 2 ; the rematch — party 2 since the ghost copies went (2026-08-17)
	ld [wTrainerNo], a
	ld a, $4
	ld [wCeladonGymCurScript], a
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
.Erika4thGym
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
.afterBatttle
	ld a, $4
	ld [wGymLeaderNo], a
.endBattle
	ld a, SCRIPT_CELADONGYM_ERIKA_POST_BATTLE
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.PreBattleText:
	text_far _CeladonGymErikaPreBattleText
	text_end

.NoBadgeText:
	text_far _CeladonGymErikaNoBadgeText
	text_end

.ReceivedRainbowBadgeText:
	text_far _CeladonGymErikaReceivedRainbowBadgeText
	text_end

.PostBattleAdviceText:
	text_far _CeladonGymErikaPostBattleAdviceText
	text_end

.PreBattleRematch1Text
	text_far _CeladonGymRematchPreBattle1Text
	text_end

.PreBattleRematchRefusedText
	text_far _GymRematchRefusedText
	text_end

.RematchCooldownText
	text_far _GymRematchCooldownText
	text_end

.PreBattleRematch2Text
	text_far _CeladonGymPreRematchBattle2Text
	text_end

CeladonGymRematchPostBattleText:
	text_far _CeladonGymRematchPostBattleText
	text_end

CeladonGymRainbowBadgeInfoText:
	text_far _CeladonGymRainbowBadgeInfoText
	text_end

CeladonGymReceivedTMText:
	text_far _CeladonGymReceivedTMText
	sound_get_item_1
	text_far _CeladonGymTMExplanationText
	text_end

CeladonGymTMNoRoomText:
	text_far _CeladonGymTMNoRoomText
	text_end

CeladonGymReceivedCandyText:
	text_far _CeladonGymReceivedCandyText
	sound_get_item_1
	text_far _CeladonGymErikaCandyCommentText
	text_end

CeladonGymCooltrainerF1Text:
	text_asm
	ld hl, CeladonGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText2:
	text_far _CeladonGymBattleText2
	text_end

CeladonGymEndBattleText2:
	text_far _CeladonGymEndBattleText2
	text_end

CeladonGymAfterBattleText2:
	text_far _CeladonGymAfterBattleText2
	text_end

CeladonGymBeauty1Text:
	text_asm
	ld hl, CeladonGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText3:
	text_far _CeladonGymBattleText3
	text_end

CeladonGymEndBattleText3:
	text_far _CeladonGymEndBattleText3
	text_end

CeladonGymAfterBattleText3:
	text_far _CeladonGymAfterBattleText3
	text_end

CeladonGymCooltrainerF2Text:
	text_asm
	ld hl, CeladonGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText4:
	text_far _CeladonGymBattleText4
	text_end

CeladonGymEndBattleText4:
	text_far _CeladonGymEndBattleText4
	text_end

CeladonGymAfterBattleText4:
	text_far _CeladonGymAfterBattleText4
	text_end

CeladonGymBeauty2Text:
	text_asm
	ld hl, CeladonGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText5:
	text_far _CeladonGymBattleText5
	text_end

CeladonGymEndBattleText5:
	text_far _CeladonGymEndBattleText5
	text_end

CeladonGymAfterBattleText5:
	text_far _CeladonGymAfterBattleText5
	text_end

CeladonGymCooltrainerF3Text:
	text_asm
	ld hl, CeladonGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText6:
	text_far _CeladonGymBattleText6
	text_end

CeladonGymEndBattleText6:
	text_far _CeladonGymEndBattleText6
	text_end

CeladonGymAfterBattleText6:
	text_far _CeladonGymAfterBattleText6
	text_end

CeladonGymBeauty3Text:
	text_asm
	ld hl, CeladonGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText7:
	text_far _CeladonGymBattleText7
	text_end

CeladonGymEndBattleText7:
	text_far _CeladonGymEndBattleText7
	text_end

CeladonGymAfterBattleText7:
	text_far _CeladonGymAfterBattleText7
	text_end

CeladonGymCooltrainerF4Text:
	text_asm
	ld hl, CeladonGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText8:
	text_far _CeladonGymBattleText8
	text_end

CeladonGymEndBattleText8:
	text_far _CeladonGymEndBattleText8
	text_end

CeladonGymAfterBattleText8:
	text_far _CeladonGymAfterBattleText8
	text_end
