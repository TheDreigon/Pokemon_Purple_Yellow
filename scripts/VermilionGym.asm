VermilionGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	push hl
	call nz, .LoadNames
	pop hl
	bit 6, [hl]
	res 6, [hl]
	call nz, VermilionGymSetDoorTile
	call EnableAutoTextBoxDrawing
	ld hl, VermilionGymTrainerHeaders
	ld de, VermilionGym_ScriptPointers
	ld a, [wVermilionGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wVermilionGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "VERMILION CITY@"

.LeaderName:
	db "LT.SURGE@"

VermilionGymSetDoorTile:
	CheckEvent EVENT_2ND_LOCK_OPENED
	jr nz, .doorsOpen
	ld a, $24 ; double door tile ID
	jr .replaceTile
.doorsOpen
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, $5 ; clear floor tile ID
.replaceTile
	ld [wNewTileBlockID], a
	lb bc, 2, 2
	predef_jump ReplaceTileBlock

VermilionGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
	ret

VermilionGym_ScriptPointers:
	def_script_pointers
	dw_const VermilionGymDefaultScript,              SCRIPT_VERMILIONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VERMILIONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VERMILIONGYM_END_BATTLE
	dw_const VermilionGymLTSurgeAfterBattleScript,  SCRIPT_VERMILIONGYM_LT_SURGE_AFTER_BATTLE
	dw_const VermilionGymGateKickoutScript,          SCRIPT_VERMILIONGYM_GATE_KICKOUT

; v0.7 badge-gating (strict gym order): requires CASCADEBADGE.
; Entering without it auto-triggers the gate text and the player is shoved
; back out the door (Route 22 gate pattern).
VermilionGymDefaultScript:
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jp nz, CheckFightingMapTrainers
	ld hl, VermilionGymGateCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_VERMILIONGYM_GATE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

VermilionGymGateCoords: ; the two door/warp tiles
	dbmapcoord  4, 17
	dbmapcoord  5, 17
	db -1 ; end

VermilionGymGateKickoutScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_VERMILIONGYM_DEFAULT
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
	ret

VermilionGymLTSurgeAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff ; did we lose?
	jp z, VermilionGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, SurgeRematchPostBattle
; fallthrough
VermilionGymLTSurgeReceiveGiftsScript:
	ld a, TEXT_VERMILIONGYM_LT_SURGE_THUNDER_BADGE_INFO
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_LT_SURGE
	CheckEvent EVENT_GOT_SURGE_TM
	jr nz, .try_candy
	lb bc, TM_SHOCK_WAVE, 1
	call GiveItem
	jr nc, .bag_full
	ld a, TEXT_VERMILIONGYM_LT_SURGE_RECEIVED_TM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_SURGE_TM
.try_candy
	CheckEvent EVENT_GOT_SURGE_CANDY
	jr nz, .gym_victory
	lb bc, RARE_CANDY, 1
	call GiveItem
	jr nc, .bag_full
	ld a, TEXT_VERMILIONGYM_LT_SURGE_RECEIVED_CANDY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_SURGE_CANDY
	jr .gym_victory
.bag_full
	ld a, TEXT_VERMILIONGYM_LT_SURGE_TM_NO_ROOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gym_victory
	ld hl, wObtainedBadges
	set BIT_THUNDERBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_THUNDERBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_VERMILION_GYM_TRAINER_0, EVENT_BEAT_VERMILION_GYM_TRAINER_2

	jp VermilionGymResetScripts

SurgeRematchPostBattle:
	; reached only on a win (the post-battle script bails to ResetScripts when
	; the player blacked out), so losing does not burn the rematch
	SetEvent EVENT_REMATCHED_LT_SURGE
	ld a, TEXT_VERMILIONGYM_REMATCH_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp VermilionGymResetScripts

; v0.7 badge-gating: refusal + shove-out (auto-triggered by the default
; script when the player enters without the required badge).
VermilionGymGateText:
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
	ld a, SCRIPT_VERMILIONGYM_GATE_KICKOUT
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

.NoBadgeText:
	text_far _VermilionGymGateNoBadgeText
	text_end

VermilionGym_TextPointers:
	def_text_pointers
	dw_const VermilionGymLTSurgeText,                 TEXT_VERMILIONGYM_LT_SURGE
	dw_const VermilionGymGentlemanText,               TEXT_VERMILIONGYM_GENTLEMAN
	dw_const VermilionGymSuperNerdText,               TEXT_VERMILIONGYM_SUPER_NERD
	dw_const VermilionGymSailorText,                  TEXT_VERMILIONGYM_SAILOR
	dw_const VermilionGymGymGuideText,                TEXT_VERMILIONGYM_GYM_GUIDE
	dw_const VermilionGymLTSurgeThunderBadgeInfoText, TEXT_VERMILIONGYM_LT_SURGE_THUNDER_BADGE_INFO
	dw_const VermilionGymLTSurgeReceivedTMText,     TEXT_VERMILIONGYM_LT_SURGE_RECEIVED_TM
	dw_const VermilionGymLTSurgeTMNoRoomText,       TEXT_VERMILIONGYM_LT_SURGE_TM_NO_ROOM
	dw_const VermilionGymLTSurgeReceivedCandyText,  TEXT_VERMILIONGYM_LT_SURGE_RECEIVED_CANDY
	dw_const VermilionGymRematchPostBattleText, 	  TEXT_VERMILIONGYM_REMATCH_POST_BATTLE
	dw_const VermilionGymGateText,                  TEXT_VERMILIONGYM_GATE

VermilionGymTrainerHeaders:
	def_trainers 2
VermilionGymTrainerHeader0:
	trainer EVENT_BEAT_VERMILION_GYM_TRAINER_0, 3, VermilionGymGentlemanBattleText, VermilionGymGentlemanEndBattleText, VermilionGymGentlemanAfterBattleText
VermilionGymTrainerHeader1:
	trainer EVENT_BEAT_VERMILION_GYM_TRAINER_1, 2, VermilionGymSuperNerdBattleText, VermilionGymSuperNerdEndBattleText, VermilionGymSuperNerdAfterBattleText
VermilionGymTrainerHeader2:
	trainer EVENT_BEAT_VERMILION_GYM_TRAINER_2, 3, VermilionGymSailorBattleText, VermilionGymSailorEndBattleText, VermilionGymSailorAfterBattleText
	db -1 ; end

VermilionGymLTSurgeText:
	text_asm
	CheckEvent EVENT_BEAT_LT_SURGE
	jr z, .before_beat
	CheckEventReuseA EVENT_GOT_SURGE_TM
	jr z, .need_gifts
	CheckEvent EVENT_GOT_SURGE_CANDY
	jr nz, .gifts_done
.need_gifts
	call VermilionGymLTSurgeReceiveGiftsScript
	call DisableWaitingAfterTextDisplay
	jp .text_script_end ; jp: badge-gate check pushed label out of jr range
.gifts_done
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, .SurgeRematch
	ld hl, .PostBattleAdviceText
	call PrintText
	jp .text_script_end ; jp: the rematch-cooldown check pushed the label out of jr range
.before_beat
; v0.7 badge-gating: the leader also refuses without the previous badge
; (belt-and-braces - the door gate normally fires first).
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
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
	ld hl, VermilionGymLTSurgeReceivedThunderBadgeText
	ld de, VermilionGymLTSurgeReceivedThunderBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $3
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	jr .endBattle
; v0.7 rematch cooldown: one rematch per League run. The flag is set by
; SurgeRematchPostBattle on a win and cleared again for every leader by
; HallOfFameResetEventsAndSaveScript.
.SurgeRematch
	CheckEvent EVENT_REMATCHED_LT_SURGE
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
	ld a, OPP_LT_SURGE
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, $4
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
	jr .endBattle
.rematchSpent
	ld hl, .RematchCooldownText
	call PrintText
	jr .text_script_end
.refused
	ld hl, .PreBattleRematchRefusedText
	call PrintText
	jr .text_script_end
.endBattle
	ld a, SCRIPT_VERMILIONGYM_LT_SURGE_AFTER_BATTLE
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
.text_script_end
	jp TextScriptEnd

.PreBattleText:
	text_far _VermilionGymLTSurgePreBattleText
	text_end

.NoBadgeText:
	text_far _VermilionGymSurgeNoBadgeText
	text_end

.PostBattleAdviceText:
	text_far _VermilionGymLTSurgePostBattleAdviceText
	text_end

.PreBattleRematch1Text
	text_far _VermilionGymRematchPreBattle1Text
	text_end

.PreBattleRematchRefusedText
	text_far _GymRematchRefusedText
	text_end

.RematchCooldownText
	text_far _GymRematchCooldownText
	text_end

.PreBattleRematch2Text
	text_far _VermilionGymPreRematchBattle2Text
	text_end

VermilionGymRematchPostBattleText:
	text_far _VermilionGymRematchPostBattleText
	text_end

VermilionGymLTSurgeThunderBadgeInfoText:
	text_far _VermilionGymLTSurgeThunderBadgeInfoText
	text_end

VermilionGymLTSurgeReceivedTMText:
	text_far _VermilionGymLTSurgeReceivedTMText
	sound_get_key_item
	text_far _VermilionGymLTSurgeTMExplanationText
	text_end

VermilionGymLTSurgeTMNoRoomText:
	text_far _VermilionGymLTSurgeTMNoRoomText
	text_end

VermilionGymLTSurgeReceivedCandyText:
	text_far _VermilionGymLTSurgeReceivedCandyText
	sound_get_item_1
	text_far _VermilionGymLTSurgeCandyCommentText
	text_end

VermilionGymLTSurgeReceivedThunderBadgeText:
	text_far _VermilionGymLTSurgeReceivedThunderBadgeText
	text_end

VermilionGymGentlemanText:
	text_asm
	ld hl, VermilionGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VermilionGymGentlemanBattleText:
	text_far _VermilionGymGentlemanBattleText
	text_end

VermilionGymGentlemanEndBattleText:
	text_far _VermilionGymGentlemanEndBattleText
	text_end

VermilionGymGentlemanAfterBattleText:
	text_far _VermilionGymGentlemanAfterBattleText
	text_end

VermilionGymSuperNerdText:
	text_asm
	ld hl, VermilionGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VermilionGymSuperNerdBattleText:
	text_far _VermilionGymSuperNerdBattleText
	text_end

VermilionGymSuperNerdEndBattleText:
	text_far _VermilionGymSuperNerdEndBattleText
	text_end

VermilionGymSuperNerdAfterBattleText:
	text_far _VermilionGymSuperNerdAfterBattleText
	text_end

VermilionGymSailorText:
	text_asm
	ld hl, VermilionGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

VermilionGymSailorBattleText:
	text_far _VermilionGymSailorBattleText
	text_end

VermilionGymSailorEndBattleText:
	text_far _VermilionGymSailorEndBattleText
	text_end

VermilionGymSailorAfterBattleText:
	text_far _VermilionGymSailorAfterBattleText
	text_end

VermilionGymGymGuideText:
	text_asm
	ld a, [wBeatGymFlags]
	bit BIT_THUNDERBADGE, a
	jr nz, .got_thunderbadge
	ld hl, .ChampInMakingText
	call PrintText
	jr .text_script_end
.got_thunderbadge
	ld hl, .BeatLTSurgeText
	call PrintText
.text_script_end
	jp TextScriptEnd

.ChampInMakingText:
	text_far _VermilionGymGymGuideChampInMakingText
	text_end

.BeatLTSurgeText:
	text_far _VermilionGymGymGuideBeatLTSurgeText
	text_end
