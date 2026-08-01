FuchsiaPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	call EnableAutoTextBoxDrawing
	ld hl, FuchsiaPokecenter_ScriptPointers
	ld a, [wFuchsiaPokecenterCurScript]
	call CallFunctionInTable
	ret

FuchsiaPokecenter_ScriptPointers:
	def_script_pointers
	dw_const FuchsiaPokecenterScript0,             	SCRIPT_FUCHSIAPOKECENTER_DEFAULT
	dw_const JoyPostBattleScript,                   SCRIPT_FUCHSIAPOKECENTER_POST_BATTLE


FuchsiaPokecenter_TextPointers:
	def_text_pointers
	dw_const FuchsiaPokecenterNurseText,            TEXT_FUCHSIAPOKECENTER_NURSE
	dw_const FuchsiaPokecenterRockerText,           TEXT_FUCHSIAPOKECENTER_ROCKER
	dw_const FuchsiaPokecenterCooltrainerFText,     TEXT_FUCHSIAPOKECENTER_COOLTRAINER_F
	dw_const FuchsiaPokecenterLinkReceptionistText, TEXT_FUCHSIAPOKECENTER_LINK_RECEPTIONIST
	dw_const FuchsiaPokecenterChanseyText,          TEXT_FUCHSIAPOKECENTER_CHANSEY
	dw_const NurseJoyAfterBattleText,       		TEXT_FUCHSIAPOKECENTER_POST_BATTLE

FuchsiaPokecenterScript0:
	ret

JoyPostBattleScript:
	ld a, [wIsInBattle]
	inc a
	jr z, .skip	; Kick out if the player lost.
	SetEvent EVENT_BEAT_NURSE_JOY
	SetEvent EVENT_REMATCHED_NURSE_JOY ; v0.7: spend this League run's battle (win only)
	ld a, TEXT_FUCHSIAPOKECENTER_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.skip
	ld a, SCRIPT_FUCHSIAPOKECENTER_DEFAULT
	ld [wFuchsiaPokecenterCurScript], a
	ld [wCurMapScript], a
	ret
NurseJoyAfterBattleText:
	text_far _NurseJoyAfterBattleText
	text_end

FuchsiaPokecenterNurseText:
	text_asm
	farcall DisplayPokemonCenterDialogue_
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr z, .done
; v0.7 rematch cooldown: one battle per League run. REMATCHED is set on every
; win (including the first), BEAT only picks the "another battle?" wording, so
; re-beating the League re-arms her without resetting the dialogue stage.
	CheckEvent EVENT_REMATCHED_NURSE_JOY
	jr nz, .rematchSpent
	CheckEvent EVENT_BEAT_NURSE_JOY
	jr nz, .NotFirstBattle
	farcall NewPageButtonPressCheck
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld hl, NurseJoyPreBattleText
.continue
	call PrintText
	xor a
	ld [wMenuJoypadPollCount], a ; menu hygiene: a stale Cable Club poll-count would phantom-accept and force this L65 fight
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
; she starts the battle by hand (no EngageMapTrainer), so the encounter jingle
; has to be played explicitly — same idiom the Jessie & James scripts use
	call StopAllMusic
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
	ld hl, NurseJoyAcceptedText
	call PrintText
	call Delay3
	ld a, OPP_JOY
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, $1 ; SCRIPT_FUCHSIAPOKECENTER_POST_BATTLE
	ld [wFuchsiaPokecenterCurScript], a
	ld [wCurMapScript], a
	jr .done
.refused
	ld hl, NurseJoyRefusedText
	call PrintText
.done
	jp TextScriptEnd
.NotFirstBattle
	farcall NewPageButtonPressCheck
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld hl, NurseJoyPreBattleText2
	jr .continue
.rematchSpent
; same page-break handling as the two battle offers: the healing dialogue is
; already on screen, so wait for the button before writing over it
	farcall NewPageButtonPressCheck
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld hl, NurseJoyRematchCooldownText
	call PrintText
	jp TextScriptEnd
NurseJoyPreBattleText:
	text_far _NurseJoyBattleText
	text_end
NurseJoyRefusedText:
	text_far _NurseJoyRefusedText
	text_end
NurseJoyAcceptedText:
	text_far _NurseJoyAcceptedText
	text_end
NurseJoyPreBattleText2:
	text_far _NurseJoyBattleText2
	text_end
NurseJoyRematchCooldownText:
	text_far _NurseJoyRematchCooldownText
	text_end

FuchsiaPokecenterRockerText:
	text_far _FuchsiaPokecenterRockerText
	text_end

FuchsiaPokecenterCooltrainerFText:
	text_far _FuchsiaPokecenterCooltrainerFText
	text_end

FuchsiaPokecenterLinkReceptionistText:
	script_cable_club_receptionist

FuchsiaPokecenterChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd
