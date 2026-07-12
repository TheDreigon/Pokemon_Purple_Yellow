CeruleanGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanGymTrainerHeaders
	ld de, CeruleanGym_ScriptPointers
	ld a, [wCeruleanGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "CERULEAN CITY@"

.LeaderName:
	db "MISTY@"

CeruleanGymResetScripts:
	xor a ; SCRIPT_CERULEANGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanGym_ScriptPointers:
	def_script_pointers
	dw_const CeruleanGymDefaultScript,              SCRIPT_CERULEANGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CERULEANGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CERULEANGYM_END_BATTLE
	dw_const CeruleanGymMistyPostBattleScript,      SCRIPT_CERULEANGYM_MISTY_POST_BATTLE
	dw_const CeruleanGymGateKickoutScript,          SCRIPT_CERULEANGYM_GATE_KICKOUT

; v0.7 badge-gating (strict gym order): Cerulean is gym #2 and requires the
; BOULDER BADGE. Entering without it triggers the gym guide, who calls out
; and shoves the player back out the door (Route 22 gate pattern) — the gym
; trainers and Misty are unreachable until the badge is earned.
CeruleanGymDefaultScript:
	ld a, [wObtainedBadges]
	bit BIT_BOULDERBADGE, a
	jp nz, CheckFightingMapTrainers
	ld hl, CeruleanGymGateCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_CERULEANGYM_GATE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

CeruleanGymGateCoords: ; the two door/warp tiles
	dbmapcoord  4, 13
	dbmapcoord  5, 13
	db -1 ; end

CeruleanGymGateKickoutScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_CERULEANGYM_DEFAULT
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanGymMistyPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, MistyRematchPostBattle
; fallthrough
CeruleanGymReceiveGifts:
	ld a, TEXT_CERULEANGYM_MISTY_CASCADE_BADGE_INFO
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_MISTY
	CheckEvent EVENT_GOT_MISTY_TM
	jr nz, .tryCandy
	lb bc, TM_WATER_PULSE, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_CERULEANGYM_MISTY_RECEIVED_TM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_MISTY_TM
.tryCandy
	CheckEvent EVENT_GOT_MISTY_CANDY
	jr nz, .gymVictory
	lb bc, RARE_CANDY, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_CERULEANGYM_MISTY_RECEIVED_CANDY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_MISTY_CANDY
	jr .gymVictory
.bagFull
	ld a, TEXT_CERULEANGYM_MISTY_TM_NO_ROOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_CASCADEBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_CASCADEBADGE, [hl]

	; deactivate gym trainers
	SetEvents EVENT_BEAT_CERULEAN_GYM_TRAINER_0, EVENT_BEAT_CERULEAN_GYM_TRAINER_1

	jp CeruleanGymResetScripts

MistyRematchPostBattle:
	ld a, TEXT_CERULEANGYM_REMATCH_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp CeruleanGymResetScripts

CeruleanGym_TextPointers:
	def_text_pointers
	dw_const CeruleanGymMistyText,                 TEXT_CERULEANGYM_MISTY
	dw_const CeruleanGymCooltrainerFText,          TEXT_CERULEANGYM_COOLTRAINER_F
	dw_const CeruleanGymSwimmerText,               TEXT_CERULEANGYM_SWIMMER
	dw_const CeruleanGymGymGuideText,              TEXT_CERULEANGYM_GYM_GUIDE
	dw_const CeruleanGymMistyCascadeBadgeInfoText, TEXT_CERULEANGYM_MISTY_CASCADE_BADGE_INFO
	dw_const CeruleanGymMistyReceivedTMText,     TEXT_CERULEANGYM_MISTY_RECEIVED_TM
	dw_const CeruleanGymMistyTMNoRoomText,       TEXT_CERULEANGYM_MISTY_TM_NO_ROOM
	dw_const CeruleanGymMistyReceivedCandyText,  TEXT_CERULEANGYM_MISTY_RECEIVED_CANDY
	dw_const CeruleanGymRematchPostBattleText, 	   TEXT_CERULEANGYM_REMATCH_POST_BATTLE
	dw_const CeruleanGymGateText,                  TEXT_CERULEANGYM_GATE

; v0.7 badge-gating: refusal + shove-out (auto-triggered by the default
; script when the player enters without the BOULDER BADGE).
CeruleanGymGateText:
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
	ld a, SCRIPT_CERULEANGYM_GATE_KICKOUT
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

.NoBadgeText:
	text_far _CeruleanGymGateNoBadgeText
	text_end

CeruleanGymTrainerHeaders:
	def_trainers 2
CeruleanGymTrainerHeader0:
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_0, 3, CeruleanGymBattleText1, CeruleanGymEndBattleText1, CeruleanGymAfterBattleText1
CeruleanGymTrainerHeader1:
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_1, 3, CeruleanGymBattleText2, CeruleanGymEndBattleText2, CeruleanGymAfterBattleText2
	db -1 ; end

CeruleanGymMistyText:
	text_asm
	CheckEvent EVENT_BEAT_MISTY
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_MISTY_TM
	jr z, .needGifts
	CheckEvent EVENT_GOT_MISTY_CANDY
	jr nz, .afterBeat
.needGifts
	call CeruleanGymReceiveGifts
	call DisableWaitingAfterTextDisplay
	jp .done ; jp: the badge-gate check pushed .done out of jr range
.afterBeat
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, .MistyRematch
	ld hl, .TMExplanationText
	call PrintText
	jr .done
.beforeBeat
; v0.7 badge-gating: Misty herself also checks for the BOULDER BADGE
; (belt-and-braces — the door gate normally fires first).
	ld a, [wObtainedBadges]
	bit BIT_BOULDERBADGE, a
	jr nz, .hasPrevBadge
	ld hl, .NoBadgeText
	call PrintText
	jr .done
.hasPrevBadge
	ld hl, .PreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, CeruleanGymMistyReceivedCascadeBadgeText
	ld de, CeruleanGymMistyReceivedCascadeBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $2
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	jr .endBattle
.MistyRematch
	ld hl, .PreBattleRematch1Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	ld hl, .PreBattleRematch2Text
	call PrintText
	call Delay3
	ld a, OPP_MISTY
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, $4 ; new script
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	jr .endBattle
.refused
	ld hl, .PreBattleRematchRefusedText
	call PrintText
	jr .done
.endBattle
	ld a, SCRIPT_CERULEANGYM_MISTY_POST_BATTLE
	ld [wCeruleanGymCurScript], a
.done
	jp TextScriptEnd

.PreBattleText:
	text_far _CeruleanGymMistyPreBattleText
	text_end

.NoBadgeText:
	text_far _CeruleanGymMistyNoBadgeText
	text_end

.TMExplanationText:
	text_far _CeruleanGymMistyTMExplanationText
	text_end

.PreBattleRematch1Text
	text_far _CeruleanGymRematchPreBattle1Text
	text_end

.PreBattleRematchRefusedText
	text_far _GymRematchRefusedText
	text_end

.PreBattleRematch2Text
	text_far _CeruleanGymPreRematchBattle2Text
	text_end

CeruleanGymRematchPostBattleText:
	text_far _CeruleanGymRematchPostBattleText
	text_end

CeruleanGymMistyCascadeBadgeInfoText:
	text_far _CeruleanGymMistyCascadeBadgeInfoText
	text_end

CeruleanGymMistyReceivedTMText:
	text_far _CeruleanGymMistyReceivedTMText
	sound_get_item_1
	text_end

CeruleanGymMistyTMNoRoomText:
	text_far _CeruleanGymMistyTMNoRoomText
	text_end

CeruleanGymMistyReceivedCandyText:
	text_far _CeruleanGymMistyReceivedCandyText
	sound_get_item_1
	text_far _CeruleanGymMistyCandyCommentText
	text_end

CeruleanGymMistyReceivedCascadeBadgeText:
	text_far _CeruleanGymMistyReceivedCascadeBadgeText
	text_end

CeruleanGymCooltrainerFText:
	text_asm
	ld hl, CeruleanGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymBattleText1:
	text_far _CeruleanGymBattleText1
	text_end

CeruleanGymEndBattleText1:
	text_far _CeruleanGymEndBattleText1
	text_end

CeruleanGymAfterBattleText1:
	text_far _CeruleanGymAfterBattleText1
	text_end

CeruleanGymSwimmerText:
	text_asm
	ld hl, CeruleanGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymBattleText2:
	text_far _CeruleanGymBattleText2
	text_end

CeruleanGymEndBattleText2:
	text_far _CeruleanGymEndBattleText2
	text_end

CeruleanGymAfterBattleText2:
	text_far _CeruleanGymAfterBattleText2
	text_end

CeruleanGymGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_MISTY
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
	call PrintText
	jr .done
.afterBeat
	ld hl, .BeatMistyText
	call PrintText
.done
	jp TextScriptEnd

.ChampInMakingText:
	text_far _CeruleanGymGymGuideChampInMakingText
	text_end

.BeatMistyText:
	text_far _CeruleanGymGymGuideBeatMistyText
	text_end
