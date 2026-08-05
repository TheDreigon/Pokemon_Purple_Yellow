VictoryRoad2F_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, VictoryRoad2FResetBoulderEventScript
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, VictoryRoad2FCheckBoulderEventScript
	call EnableAutoTextBoxDrawing
	call VictoryRoad2FShowSmithIfEarned
	ld hl, VictoryRoad2TrainerHeaders
	ld de, VictoryRoad2F_ScriptPointers
	ld a, [wVictoryRoad2FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wVictoryRoad2FCurScript], a
	ret

VictoryRoad2FResetBoulderEventScript:
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
; fallthrough
VictoryRoad2FCheckBoulderEventScript:
	CheckEvent EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	jr z, .not_on_switch
	push af
	ld a, $15
	lb bc, 4, 3
	call VictoryRoad2FReplaceTileBlockScript
	pop af
.not_on_switch
	bit 7, a
	ret z
	ld a, $1d
	lb bc, 7, 11
VictoryRoad2FReplaceTileBlockScript:
	ld [wNewTileBlockID], a
	predef ReplaceTileBlock
	ret

; Show the relocated Smith self-insert once Moltres is gone AND the League is beaten.
; EndTrainerBattle sets EVENT_BEAT_MOLTRES on WIN or CATCH (only a loss is skipped),
; so "Moltres dealt with" covers both. Idempotent: ShowObject just clears the hide flag.
VictoryRoad2FShowSmithIfEarned:
	CheckEvent EVENT_BEAT_MOLTRES
	ret z
	ld a, [wGameStage]
	and a
	ret z
	ld a, HS_VICTORY_ROAD_2F_SMITH
	ld [wMissableObjectIndex], a
	predef ShowObject
	ret

VictoryRoad2F_ScriptPointers:
	def_script_pointers
	dw_const VictoryRoad2FDefaultScript,            SCRIPT_VICTORYROAD2F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VICTORYROAD2F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VICTORYROAD2F_END_BATTLE
	dw_const VictoryRoad2FSmithPostBattleScript,    SCRIPT_VICTORYROAD2F_SMITH_POST_BATTLE

VictoryRoad2FDefaultScript:
	ld hl, .SwitchCoords
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	ldh a, [hSpriteIndexOrTextID]
	cp $f
	jp z, CheckFightingMapTrainers
	EventFlagAddress hl, EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	ld a, [wCoordIndex]
	cp $2
	jr z, .second_switch
	CheckEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	SetEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	ret nz
	ld a, 1
	ld [wBoulderSFXCheck], a
	jr .set_script_flag
.second_switch
	CheckEventAfterBranchReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH2, EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	SetEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH2
	ret nz
	ld a, 1
	ld [wBoulderSFXCheck], a
.set_script_flag
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ret

.SwitchCoords:
	dbmapcoord  1, 16
	dbmapcoord  9, 16
	db -1 ; end

VictoryRoad2F_TextPointers:
	def_text_pointers
	dw_const VictoryRoad2FHikerText,        TEXT_VICTORYROAD2F_HIKER
	dw_const VictoryRoad2FJuggler1Text,   	TEXT_VICTORYROAD2F_JUGGLER1
	dw_const VictoryRoad2FTamerText, 		TEXT_VICTORYROAD2F_TAMER
	dw_const VictoryRoad2FPokemaniacText,   TEXT_VICTORYROAD2F_POKEMANIAC
	dw_const VictoryRoad2FJuggler2Text,   	TEXT_VICTORYROAD2F_JUGGLER2
	dw_const VictoryRoad2FMoltresText,      TEXT_VICTORYROAD2F_MOLTRES
	dw_const PickUpItemText,                TEXT_VICTORYROAD2F_TM_DOUBLE_EDGE
	dw_const PickUpItemText,                TEXT_VICTORYROAD2F_ESCAPE_ROPE
	dw_const PickUpItemText,                TEXT_VICTORYROAD2F_TM_PETAL_DANCE
	dw_const PickUpItemText,                TEXT_VICTORYROAD2F_GUARD_SPEC
	dw_const BoulderText,                   TEXT_VICTORYROAD2F_BOULDER1
	dw_const BoulderText,                   TEXT_VICTORYROAD2F_BOULDER2
	dw_const BoulderText,                   TEXT_VICTORYROAD2F_BOULDER3
	dw_const VictoryRoad2FSmithText,          TEXT_VICTORYROAD2F_SMITH
	dw_const VictoryRoad2FSmithEndBattleText, TEXT_VICTORYROAD2F_SMITH_END_BATTLE

VictoryRoad2TrainerHeaders:
	def_trainers
VictoryRoad2TrainerHeader0:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_0, 4, VictoryRoad2FHikerBattleText, VictoryRoad2FHikerEndBattleText, VictoryRoad2FHikerAfterBattleText
VictoryRoad2TrainerHeader1:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_1, 3, VictoryRoad2FJuggler1BattleText, VictoryRoad2FJuggler1EndBattleText, VictoryRoad2FJuggler1AfterBattleText
VictoryRoad2TrainerHeader2:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_2, 3, VictoryRoad2FTamerBattleText, VictoryRoad2FTamerEndBattleText, VictoryRoad2FTamerAfterBattleText
VictoryRoad2TrainerHeader3:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_3, 1, VictoryRoad2FPokemaniacBattleText, VictoryRoad2FPokemaniacEndBattleText, VictoryRoad2FPokemaniacAfterBattleText
VictoryRoad2TrainerHeader4:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_4, 3, VictoryRoad2FJuggler2BattleText, VictoryRoad2FJuggler2EndBattleText, VictoryRoad2FJuggler2AfterBattleText
MoltresTrainerHeader:
	trainer EVENT_BEAT_MOLTRES, 0, VictoryRoad2FMoltresBattleText, VictoryRoad2FMoltresBattleText, VictoryRoad2FMoltresBattleText
	db -1 ; end

VictoryRoad2FHikerText:
	text_asm
	ld hl, VictoryRoad2TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2FJuggler1Text:
	text_asm
	ld hl, VictoryRoad2TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2FTamerText:
	text_asm
	ld hl, VictoryRoad2TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2FPokemaniacText:
	text_asm
	ld hl, VictoryRoad2TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2FJuggler2Text:
	text_asm
	ld hl, VictoryRoad2TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2FMoltresText:
	text_asm
	ld hl, MoltresTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2FSmithText:
	text_asm
	CheckEvent EVENT_BEAT_SMITH
	jr nz, .AlreadyFought
; he starts the battle by hand (no EngageMapTrainer), so the encounter jingle
; has to be played explicitly — same idiom the Jessie & James scripts use
	call StopAllMusic
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, VictoryRoad2FSmithBattleText
	call PrintText
	call Delay3
	ld a, OPP_SMITH
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, SCRIPT_VICTORYROAD2F_SMITH_POST_BATTLE
	ld [wVictoryRoad2FCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.AlreadyFought
	ld hl, VictoryRoad2FSmithAfterBattleText
	call PrintText
	call Delay3
	jp TextScriptEnd

VictoryRoad2FSmithPostBattleScript:
	ld a, [wIsInBattle]
	inc a
	jr z, .done ; player lost the battle -> kick out, don't set the beat flag
	ld a, TEXT_VICTORYROAD2F_SMITH_END_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SMITH
.done
	ld a, SCRIPT_VICTORYROAD2F_DEFAULT
	ld [wVictoryRoad2FCurScript], a
	ld [wCurMapScript], a
	ret

VictoryRoad2FSmithBattleText:
	text_far _VictoryRoad2FSmithBattleText
	text_end

VictoryRoad2FSmithEndBattleText:
	text_far _VictoryRoad2FSmithEndBattleText
	text_end

VictoryRoad2FSmithAfterBattleText:
	text_far _VictoryRoad2FSmithAfterBattleText
	text_end

VictoryRoad2FMoltresBattleText:
	text_far _VictoryRoad2FMoltresBattleText
	text_asm
	ld a, MOLTRES
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

VictoryRoad2FHikerBattleText:
	text_far _VictoryRoad2FHikerBattleText
	text_end

VictoryRoad2FHikerEndBattleText:
	text_far _VictoryRoad2FHikerEndBattleText
	text_end

VictoryRoad2FHikerAfterBattleText:
	text_far _VictoryRoad2FHikerAfterBattleText
	text_end

VictoryRoad2FJuggler1BattleText:
	text_far _VictoryRoad2FJuggler1BattleText
	text_end

VictoryRoad2FJuggler1EndBattleText:
	text_far _VictoryRoad2FJuggler1EndBattleText
	text_end

VictoryRoad2FJuggler1AfterBattleText:
	text_far _VictoryRoad2FJuggler1AfterBattleText
	text_end

VictoryRoad2FTamerBattleText:
	text_far _VictoryRoad2FTamerBattleText
	text_end

VictoryRoad2FTamerEndBattleText:
	text_far _VictoryRoad2FTamerEndBattleText
	text_end

VictoryRoad2FTamerAfterBattleText:
	text_far _VictoryRoad2FTamerAfterBattleText
	text_end

VictoryRoad2FPokemaniacBattleText:
	text_far _VictoryRoad2FPokemaniacBattleText
	text_end

VictoryRoad2FPokemaniacEndBattleText:
	text_far _VictoryRoad2FPokemaniacEndBattleText
	text_end

VictoryRoad2FPokemaniacAfterBattleText:
	text_far _VictoryRoad2FPokemaniacAfterBattleText
	text_end

VictoryRoad2FJuggler2BattleText:
	text_far _VictoryRoad2FJuggler2BattleText
	text_end

VictoryRoad2FJuggler2EndBattleText:
	text_far _VictoryRoad2FJuggler2EndBattleText
	text_end

VictoryRoad2FJuggler2AfterBattleText:
	text_far _VictoryRoad2FJuggler2AfterBattleText
	text_end
