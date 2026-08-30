SaffronGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, SaffronGymTrainerHeaders
	ld de, SaffronGym_ScriptPointers
	ld a, [wSaffronGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSaffronGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "SAFFRON CITY@"

.LeaderName:
	db "SABRINA@"

SaffronGymResetScripts:
	xor a ; SCRIPT_SAFFRONGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wSaffronGymCurScript], a
	ld [wCurMapScript], a
	ret

SaffronGym_ScriptPointers:
	def_script_pointers
	dw_const SaffronGymDefaultScript,              SCRIPT_SAFFRONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SAFFRONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SAFFRONGYM_END_BATTLE
	dw_const SaffronGymSabrinaPostBattle,           SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE
	dw_const SaffronGymGateKickoutScript,          SCRIPT_SAFFRONGYM_GATE_KICKOUT

; v0.7 badge-gating (strict gym order): requires SOULBADGE.
; Entering without it auto-triggers the gate text and the player is shoved
; back out the door (Route 22 gate pattern).
SaffronGymDefaultScript:
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	jp nz, CheckFightingMapTrainers
	ld hl, SaffronGymGateCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_SAFFRONGYM_GATE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

SaffronGymGateCoords: ; the two door/warp tiles
	dbmapcoord  8, 17
	dbmapcoord  9, 17
	db -1 ; end

SaffronGymGateKickoutScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_SAFFRONGYM_DEFAULT
	ld [wSaffronGymCurScript], a
	ld [wCurMapScript], a
	ret

SaffronGymSabrinaPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SaffronGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, SabrinaRematchPostBattle
; fallthrough
SaffronGymSabrinaReceiveGiftsScript:
	ld a, TEXT_SAFFRONGYM_SABRINA_MARSH_BADGE_INFO
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA
	CheckEvent EVENT_GOT_SABRINA_TM
	jr nz, .tryCandy
	lb bc, TM_PSYCHIC_M, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_RECEIVED_TM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_SABRINA_TM
.tryCandy
	CheckEvent EVENT_GOT_SABRINA_CANDY
	jr nz, .gymVictory
	lb bc, RARE_CANDY, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_RECEIVED_CANDY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_SABRINA_CANDY
	jr .gymVictory
.bagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_TM_NO_ROOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_MARSHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_MARSHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_SAFFRON_GYM_TRAINER_0, EVENT_BEAT_SAFFRON_GYM_TRAINER_6

	jp SaffronGymResetScripts

SabrinaRematchPostBattle:
	; reached only on a win (the post-battle script bails to ResetScripts when
	; the player blacked out), so losing does not burn the rematch
	SetEvent EVENT_REMATCHED_SABRINA
	ld a, TEXT_SAFFRONGYM_REMATCH_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp SaffronGymResetScripts

; v0.7 badge-gating: refusal + shove-out (auto-triggered by the default
; script when the player enters without the required badge).
SaffronGymGateText:
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
	ld a, SCRIPT_SAFFRONGYM_GATE_KICKOUT
	ld [wSaffronGymCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

.NoBadgeText:
	text_far _SaffronGymGateNoBadgeText
	text_end

SaffronGym_TextPointers:
	def_text_pointers
	dw_const SaffronGymSabrinaText,               TEXT_SAFFRONGYM_SABRINA
	dw_const SaffronGymChanneler1Text,            TEXT_SAFFRONGYM_CHANNELER1
	dw_const SaffronGymPsychic1Text,            TEXT_SAFFRONGYM_PSYCHIC1
	dw_const SaffronGymChanneler2Text,            TEXT_SAFFRONGYM_CHANNELER2
	dw_const SaffronGymPsychic2Text,            TEXT_SAFFRONGYM_PSYCHIC2
	dw_const SaffronGymChanneler3Text,            TEXT_SAFFRONGYM_CHANNELER3
	dw_const SaffronGymPsychic3Text,            TEXT_SAFFRONGYM_PSYCHIC3
	dw_const SaffronGymPsychic4Text,            TEXT_SAFFRONGYM_PSYCHIC4
	dw_const SaffronGymGymGuideText,              TEXT_SAFFRONGYM_GYM_GUIDE
	dw_const SaffronGymSabrinaMarshBadgeInfoText, TEXT_SAFFRONGYM_SABRINA_MARSH_BADGE_INFO
	dw_const SaffronGymSabrinaReceivedTMText,   TEXT_SAFFRONGYM_SABRINA_RECEIVED_TM
	dw_const SaffronGymSabrinaTMNoRoomText,     TEXT_SAFFRONGYM_SABRINA_TM_NO_ROOM
	dw_const SaffronGymSabrinaReceivedCandyText, TEXT_SAFFRONGYM_SABRINA_RECEIVED_CANDY
	dw_const SaffronGymRematchPostBattleText,     TEXT_SAFFRONGYM_REMATCH_POST_BATTLE
	dw_const SaffronGymGateText,                  TEXT_SAFFRONGYM_GATE

SaffronGymTrainerHeaders:
	def_trainers 2
SaffronGymTrainerHeader0:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_0, 3, SaffronGymChanneler1BattleText, SaffronGymChanneler1EndBattleText, SaffronGymChanneler1AfterBattleText
SaffronGymTrainerHeader1:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_1, 3, SaffronGymPsychic1BattleText, SaffronGymPsychic1EndBattleText, SaffronGymPsychic1AfterBattleText
SaffronGymTrainerHeader2:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_2, 3, SaffronGymChanneler2BattleText, SaffronGymChanneler2EndBattleText, SaffronGymChanneler2AfterBattleText
SaffronGymTrainerHeader3:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_3, 3, SaffronGymPsychic2BattleText, SaffronGymPsychic2EndBattleText, SaffronGymPsychic2AfterBattleText
SaffronGymTrainerHeader4:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_4, 3, SaffronGymChanneler3BattleText, SaffronGymChanneler3EndBattleText, SaffronGymChanneler3AfterBattleText
SaffronGymTrainerHeader5:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_5, 3, SaffronGymPsychic3BattleText, SaffronGymPsychic3EndBattleText, SaffronGymPsychic3AfterBattleText
SaffronGymTrainerHeader6:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_6, 3, SaffronGymPsychic4BattleText, SaffronGymPsychic4EndBattleText, SaffronGymPsychic4AfterBattleText
	db -1 ; end

SaffronGymSabrinaText:
	text_asm
	CheckEvent EVENT_BEAT_SABRINA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_SABRINA_TM
	jr z, .needGifts
	CheckEvent EVENT_GOT_SABRINA_CANDY
	jr nz, .afterBeat
.needGifts
	call SaffronGymSabrinaReceiveGiftsScript
	call DisableWaitingAfterTextDisplay
	jr .todone
.afterBeat
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, .SabrinaRematch
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .todone
.beforeBeat
; v0.7 badge-gating: the leader also refuses without the previous badge
; (belt-and-braces - the door gate normally fires first).
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	jr nz, .hasPrevBadge
	ld hl, .NoBadgeText
	call PrintText
	jp TextScriptEnd
.hasPrevBadge
; v0.7 hard mode (2026-08-30): the badge match caps the challenger's party
; at the leader's own count (Pewter's note).
	ld a, OPP_SABRINA
	ld [wCurOpponent], a
	ld a, 1 ; the object_event's party id
	ld [wTrainerNo], a
	callfar HardModeGymPartyGate
	ld a, [wCurOpponent]
	and a
	jp z, TextScriptEnd
	ld hl, .Text
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, .ReceivedMarshBadgeText
	ld de, .ReceivedMarshBadgeText
	call SaveEndBattleTextPointers
; v0.7 (2026-08-17): gym order is strictly linear in this hack — 5 badges is
; the only possible count here, so the free-order dispatch and its ghost
; branch (party 2, a copy of 1) were removed. Sabrina is always the 6th.
	jr .Sabrina6thGym
.todone
	jr .done
; v0.7 rematch cooldown: one rematch per League run. The flag is set by
; SabrinaRematchPostBattle on a win and cleared again for every leader by
; HallOfFameResetEventsAndSaveScript.
.SabrinaRematch
	CheckEvent EVENT_REMATCHED_SABRINA
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
	ld a, OPP_SABRINA
	ld [wCurOpponent], a
	ld a, 2 ; the rematch — party 2 since the ghost copy went (2026-08-17)
	ld [wTrainerNo], a
	ld a, $4
	ld [wSaffronGymCurScript], a
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
.Sabrina6thGym
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
.afterBatttle
	ld a, $6
	ld [wGymLeaderNo], a
.endBattle
	ld a, SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE
	ld [wSaffronGymCurScript], a
.done
	jp TextScriptEnd

.Text:
	text_far _SaffronGymSabrinaText
	text_end

.NoBadgeText:
	text_far _SaffronGymSabrinaNoBadgeText
	text_end

.ReceivedMarshBadgeText:
	text_far _SaffronGymSabrinaReceivedMarshBadgeText
	sound_get_key_item ; actually plays the second channel of SFX_BALL_POOF due to the wrong music bank being loaded
	text_promptbutton
	text_end

.PostBattleAdviceText:
	text_far _SaffronGymSabrinaPostBattleAdviceText
	text_end

.PreBattleRematch1Text
	text_far _SaffronGymRematchPreBattle1Text
	text_end

.PreBattleRematchRefusedText
	text_far _GymRematchRefusedText
	text_end

.RematchCooldownText
	text_far _GymRematchCooldownText
	text_end

.PreBattleRematch2Text
	text_far _SaffronGymPreRematchBattle2Text
	text_end

SaffronGymRematchPostBattleText:
	text_far _SaffronGymRematchPostBattleText
	text_end

SaffronGymSabrinaMarshBadgeInfoText:
	text_far _SaffronGymSabrinaMarshBadgeInfoText
	text_end

SaffronGymSabrinaReceivedTMText:
	text_far _SaffronGymSabrinaReceivedTMText
	sound_get_item_1
	text_far _SaffronGymSabrinaTMExplanationText
	text_end

SaffronGymSabrinaTMNoRoomText:
	text_far _SaffronGymSabrinaTMNoRoomText
	text_end

SaffronGymSabrinaReceivedCandyText:
	text_far _SaffronGymSabrinaReceivedCandyText
	sound_get_item_1
	text_far _SaffronGymSabrinaCandyCommentText
	text_end

SaffronGymChanneler1Text:
	text_asm
	ld hl, SaffronGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymPsychic1Text:
	text_asm
	ld hl, SaffronGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler2Text:
	text_asm
	ld hl, SaffronGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymPsychic2Text:
	text_asm
	ld hl, SaffronGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler3Text:
	text_asm
	ld hl, SaffronGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymPsychic3Text:
	text_asm
	ld hl, SaffronGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymPsychic4Text:
	text_asm
	ld hl, SaffronGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymGymGuideText:
	text_asm
; v0.7 (his 2026-08-29 request): the first ELIGIBLE pre-badge visit earns a
; FRESH WATER. Eligible = previous badge in hand; once per gym,
; and a full bag defers the gift to the next talk (flag set only on success).
	CheckEvent EVENT_GOT_GYM_GUIDE_WATER_SAFFRON
	jr nz, .noFreshWater
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	jr z, .noFreshWater ; not yet eligible for this gym
	ld a, [wObtainedBadges]
	bit BIT_MARSHBADGE, a
	jr nz, .noFreshWater ; already holds THIS gym's badge
	lb bc, FRESH_WATER, 1
	call GiveItem
	jr nc, .noFreshWater ; bag full: defer
	ld hl, SaffronGymGuideFreshWaterText
	call PrintText
	SetEvent EVENT_GOT_GYM_GUIDE_WATER_SAFFRON
.noFreshWater
	CheckEvent EVENT_BEAT_SABRINA
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
	call PrintText
	jr .done
.afterBeat
	ld hl, .BeatSabrinaText
	call PrintText
.done
	jp TextScriptEnd

.ChampInMakingText:
	text_far _SaffronGymGuideChampInMakingText
	text_end

.BeatSabrinaText:
	text_far _SaffronGymGuideBeatSabrinaText
	text_end

SaffronGymChanneler1BattleText:
	text_far _SaffronGymChanneler1BattleText
	text_end

SaffronGymChanneler1EndBattleText:
	text_far _SaffronGymChanneler1EndBattleText
	text_end

SaffronGymChanneler1AfterBattleText:
	text_far _SaffronGymChanneler1AfterBattleText
	text_end

SaffronGymPsychic1BattleText:
	text_far _SaffronGymPsychic1BattleText
	text_end

SaffronGymPsychic1EndBattleText:
	text_far _SaffronGymPsychic1EndBattleText
	text_end

SaffronGymPsychic1AfterBattleText:
	text_far _SaffronGymPsychic1AfterBattleText
	text_end

SaffronGymChanneler2BattleText:
	text_far _SaffronGymChanneler2BattleText
	text_end

SaffronGymChanneler2EndBattleText:
	text_far _SaffronGymChanneler2EndBattleText
	text_end

SaffronGymChanneler2AfterBattleText:
	text_far _SaffronGymChanneler2AfterBattleText
	text_end

SaffronGymPsychic2BattleText:
	text_far _SaffronGymPsychic2BattleText
	text_end

SaffronGymPsychic2EndBattleText:
	text_far _SaffronGymPsychic2EndBattleText
	text_end

SaffronGymPsychic2AfterBattleText:
	text_far _SaffronGymPsychic2AfterBattleText
	text_end

SaffronGymChanneler3BattleText:
	text_far _SaffronGymChanneler3BattleText
	text_end

SaffronGymChanneler3EndBattleText:
	text_far _SaffronGymChanneler3EndBattleText
	text_end

SaffronGymChanneler3AfterBattleText:
	text_far _SaffronGymChanneler3AfterBattleText
	text_end

SaffronGymPsychic3BattleText:
	text_far _SaffronGymPsychic3BattleText
	text_end

SaffronGymPsychic3EndBattleText:
	text_far _SaffronGymPsychic3EndBattleText
	text_end

SaffronGymPsychic3AfterBattleText:
	text_far _SaffronGymPsychic3AfterBattleText
	text_end

SaffronGymPsychic4BattleText:
	text_far _SaffronGymPsychic4BattleText
	text_end

SaffronGymPsychic4EndBattleText:
	text_far _SaffronGymPsychic4EndBattleText
	text_end

SaffronGymPsychic4AfterBattleText:
	text_far _SaffronGymPsychic4AfterBattleText
	text_end


SaffronGymGuideFreshWaterText:
	text_far _GymGuideFreshWaterText
	sound_get_item_1
	text_promptbutton
	text_end
