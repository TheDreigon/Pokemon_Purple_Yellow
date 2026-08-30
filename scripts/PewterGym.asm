PewterGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, PewterGymTrainerHeaders
	ld de, PewterGym_ScriptPointers
	ld a, [wPewterGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPewterGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	ret

.CityName:
	db "PEWTER CITY@"

.LeaderName:
	db "BROCK@"

PewterGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
	ret

PewterGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_PEWTERGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_PEWTERGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_PEWTERGYM_END_BATTLE
	dw_const PewterGymBrockPostBattle,              SCRIPT_PEWTERGYM_BROCK_POST_BATTLE

PewterGymBrockPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PewterGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, BrockRematchPostBattle
; fallthrough
PewterGymScriptReceiveGifts:
	ld a, TEXT_PEWTERGYM_BROCK_WAIT_TAKE_THIS
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BROCK
	CheckEvent EVENT_GOT_BROCK_TM
	jr nz, .tryCandy
	lb bc, TM_ROCK_THROW, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_PEWTERGYM_RECEIVED_TM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_BROCK_TM
.tryCandy
	CheckEvent EVENT_GOT_BROCK_CANDY
	jr nz, .gymVictory
	lb bc, RARE_CANDY, 1
	call GiveItem
	jr nc, .bagFull
	ld a, TEXT_PEWTERGYM_RECEIVED_CANDY
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_BROCK_CANDY
	jr .gymVictory
.bagFull
	ld a, TEXT_PEWTERGYM_TM_NO_ROOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_BOULDERBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_BOULDERBADGE, [hl]

	ld a, HS_GYM_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef HideObject

	ResetEvents EVENT_1ST_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE

	; deactivate gym trainers
	SetEvent EVENT_BEAT_PEWTER_GYM_TRAINER_0

	jp PewterGymResetScripts

BrockRematchPostBattle:
	; reached only on a win (the post-battle script bails to ResetScripts when
	; the player blacked out), so losing does not burn the rematch
	SetEvent EVENT_REMATCHED_BROCK
	ld a, TEXT_PEWTERGYM_REMATCH_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp PewterGymResetScripts

PewterGym_TextPointers:
	def_text_pointers
	dw_const PewterGymBrockText,             TEXT_PEWTERGYM_BROCK
	dw_const PewterGymCooltrainerMText,      TEXT_PEWTERGYM_COOLTRAINER_M
	dw_const PewterGymGuideText,             TEXT_PEWTERGYM_GYM_GUIDE
	dw_const PewterGymBrockWaitTakeThisText, TEXT_PEWTERGYM_BROCK_WAIT_TAKE_THIS
	dw_const PewterGymReceivedTMText,        TEXT_PEWTERGYM_RECEIVED_TM
	dw_const PewterGymTMNoRoomText,          TEXT_PEWTERGYM_TM_NO_ROOM
	dw_const PewterGymReceivedCandyText,     TEXT_PEWTERGYM_RECEIVED_CANDY
	dw_const PewterGymRematchPostBattleText, TEXT_PEWTERGYM_REMATCH_POST_BATTLE

PewterGymTrainerHeaders:
	def_trainers 2
PewterGymTrainerHeader0:
	trainer EVENT_BEAT_PEWTER_GYM_TRAINER_0, TEXT_PEWTERGYM_COOLTRAINER_M, PewterGymCooltrainerMBattleText, PewterGymCooltrainerMEndBattleText, PewterGymCooltrainerMAfterBattleText
	db -1 ; end

PewterGymBrockText:
	text_asm
	CheckEvent EVENT_BEAT_BROCK
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_BROCK_TM
	jr z, .needGifts
	CheckEvent EVENT_GOT_BROCK_CANDY
	jr nz, .afterBeat
.needGifts
	call PewterGymScriptReceiveGifts
	call DisableWaitingAfterTextDisplay
	jp .done ; jp: the rematch-cooldown check pushed .done out of jr range
.afterBeat
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jp nz, .BrockRematch ; jp: the hard-mode party gate pushed it out of jr range
	ld hl, .PostBattleAdviceText
	call PrintText
	jp .done ; jp: the hard-mode party gate pushed it out of jr range
.beforeBeat
; v0.7 hard mode (2026-08-30): the badge match caps the challenger's party
; at the leader's own count. Seed the opponent ids for the gate (the engage
; path re-sets them); on refusal it zeroes wCurOpponent and prints the rule.
	ld a, OPP_BROCK
	ld [wCurOpponent], a
	ld a, 1 ; the object_event's party id
	ld [wTrainerNo], a
	callfar HardModeGymPartyGate
	ld a, [wCurOpponent]
	and a
	jp z, TextScriptEnd
	ld hl, .PreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, PewterGymBrockReceivedBoulderBadgeText
	ld de, PewterGymBrockReceivedBoulderBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $1
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	jr .endBattle
; v0.7 rematch cooldown: one rematch per League run. The flag is set by
; BrockRematchPostBattle on a win and cleared again for every leader by
; HallOfFameResetEventsAndSaveScript.
.BrockRematch
	CheckEvent EVENT_REMATCHED_BROCK
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
	ld a, OPP_BROCK
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, $4
	ld [wPewterGymCurScript], a
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
.endBattle
	ld a, SCRIPT_PEWTERGYM_BROCK_POST_BATTLE
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.PreBattleText:
	text_far _PewterGymBrockPreBattleText
	text_end

.PostBattleAdviceText:
	text_far _PewterGymBrockPostBattleAdviceText
	text_end

.PreBattleRematch1Text
	text_far _PewterGymRematchPreBattle1Text
	text_end

.PreBattleRematchRefusedText
	text_far _GymRematchRefusedText
	text_end

.RematchCooldownText
	text_far _GymRematchCooldownText
	text_end

.PreBattleRematch2Text
	text_far _PewterGymPreRematchBattle2Text
	text_end

PewterGymRematchPostBattleText:
	text_far _PewterGymRematchPostBattleText
	text_end

PewterGymBrockWaitTakeThisText:
	text_far _PewterGymBrockWaitTakeThisText
	text_end

PewterGymReceivedTMText:
	text_far _PewterGymReceivedTMText
	sound_get_item_1
	text_far _PewterGymTMExplanationText
	text_end

PewterGymTMNoRoomText:
	text_far _PewterGymTMNoRoomText
	text_end

PewterGymReceivedCandyText:
	text_far _PewterGymReceivedCandyText
	sound_get_item_1
	text_far _PewterGymBrockCandyCommentText
	text_end

PewterGymBrockReceivedBoulderBadgeText:
	text_far _PewterGymBrockReceivedBoulderBadgeText
	sound_get_item_1
	text_far _PewterGymBrockBoulderBadgeInfoText ; Text to tell that the flash technique can be used
	text_end

PewterGymCooltrainerMText:
	text_asm
	ld hl, PewterGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PewterGymCooltrainerMBattleText:
	text_far _PewterGymCooltrainerMBattleText
	text_end

PewterGymCooltrainerMEndBattleText:
	text_far _PewterGymCooltrainerMEndBattleText
	text_end

PewterGymCooltrainerMAfterBattleText:
	text_far _PewterGymCooltrainerMAfterBattleText
	text_end

PewterGymGuideText:
	text_asm
; v0.7 (his 2026-08-29 request): the first ELIGIBLE pre-badge visit earns a
; FRESH WATER. Eligible = previous badge in hand (none for the first gym); once per gym,
; and a full bag defers the gift to the next talk (flag set only on success).
	CheckEvent EVENT_GOT_GYM_GUIDE_WATER_PEWTER
	jr nz, .noFreshWater
	ld a, [wObtainedBadges]
	bit BIT_BOULDERBADGE, a
	jr nz, .noFreshWater ; already holds THIS gym's badge
	lb bc, FRESH_WATER, 1
	call GiveItem
	jr nc, .noFreshWater ; bag full: defer
	ld hl, PewterGymGuideFreshWaterText
	call PrintText
	SetEvent EVENT_GOT_GYM_GUIDE_WATER_PEWTER
.noFreshWater
	ld a, [wBeatGymFlags]
	bit BIT_BOULDERBADGE, a
	jr nz, .afterBeat
	ld hl, PewterGymGuidePreAdviceText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .PewterGymGuideBeginAdviceText
	ld a, [wd472]
	bit 7, a
	jp nz, .asm_5c3fa
	ld hl, PewterGymGuideBeginAdviceText
	call PrintText
	jr .PewterGymGuideAdviceText
.PewterGymGuideBeginAdviceText
	ld hl, PewterGymGuideFreeServiceText
	call PrintText
.PewterGymGuideAdviceText
	ld hl, PewterGymGuideAdviceText
	call PrintText
	jr .done
.afterBeat
	ld hl, PewterGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd
.asm_5c3fa
	ld hl, PewterGymText_5c41c
	call PrintText
	jp TextScriptEnd

PewterGymGuidePreAdviceText:
	text_far _PewterGymGuidePreAdviceText
	text_end

PewterGymGuideBeginAdviceText:
	text_far _PewterGymGuideBeginAdviceText
	text_end

PewterGymGuideAdviceText:
	text_far _PewterGymGuideAdviceText
	text_end

PewterGymGuideFreeServiceText:
	text_far _PewterGymGuideFreeServiceText
	text_end

PewterGymGuidePostBattleText:
	text_far _PewterGymGuidePostBattleText
	text_end

PewterGymText_5c41c:
	text_far _PewterGymGuyText
	text_end


PewterGymGuideFreshWaterText:
	text_far _GymGuideFreshWaterText
	sound_get_item_1
	text_promptbutton
	text_end
