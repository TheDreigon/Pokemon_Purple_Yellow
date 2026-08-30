CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	call CeruleanCaveB1FShowForteIfEarned
	ld hl, CeruleanCaveB1FTrainerHeaders
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

; Show the Forte / DREIGON self-insert superboss, who stands on MEWTWO's tile,
; once MEWTWO is gone (beaten OR caught -> EVENT_BEAT_MEWTWO) AND the League is
; beaten (wGameStage). Idempotent — ShowObject just clears the hide flag. Forte
; is repeatable: neither this nor his battle consumes a flag that blocks him, so
; he can be re-challenged on every return to the cave after every League win.
CeruleanCaveB1FShowForteIfEarned:
	CheckEvent EVENT_BEAT_MEWTWO
	ret z
	ld a, [wGameStage]
	and a
	ret z
	ld a, HS_CERULEAN_CAVE_B1F_FORTE
	ld [wMissableObjectIndex], a
	predef ShowObject
	ret

CeruleanCaveB1F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_CERULEANCAVEB1F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CERULEANCAVEB1F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CERULEANCAVEB1F_END_BATTLE
	dw_const CeruleanCaveB1FFortePostBattleScript,  SCRIPT_CERULEANCAVEB1F_FORTE_POST_BATTLE

; Forte's post-battle handler (repeatable). On a loss the player has already
; blacked out, so just reset. On a win, remember it (for the "earned my respect"
; rematch line) and show the parting text. Either way drop back to the default
; script so simply talking to Forte again starts a fresh battle.
CeruleanCaveB1FFortePostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanCaveB1FResetScripts
	SetEvent EVENT_FORTE_WON_LAST
	ld a, TEXT_CERULEANCAVEB1F_FORTE_WIN
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; fall through
CeruleanCaveB1FResetScripts:
	xor a ; SCRIPT_CERULEANCAVEB1F_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanCaveB1F_TextPointers:
	def_text_pointers
	dw_const CeruleanCaveB1FMewtwoText,   TEXT_CERULEANCAVEB1F_MEWTWO
	dw_const PickUpItemText,              TEXT_CERULEANCAVEB1F_ESCAPE_ROPE
	dw_const PickUpItemText,              TEXT_CERULEANCAVEB1F_MAX_REVIVE
	dw_const PickUpItemText,              TEXT_CERULEANCAVEB1F_MAX_ELIXIR
	dw_const CeruleanCaveB1FForteText,    TEXT_CERULEANCAVEB1F_FORTE
	dw_const CeruleanCaveB1FForteWinText, TEXT_CERULEANCAVEB1F_FORTE_WIN

CeruleanCaveB1FTrainerHeaders:
	def_trainers
MewtwoTrainerHeader:
	trainer EVENT_BEAT_MEWTWO, TEXT_CERULEANCAVEB1F_MEWTWO, MewtwoBattleText, MewtwoBattleText, MewtwoBattleText
	db -1 ; end

CeruleanCaveB1FMewtwoText:
	text_asm
	ld hl, MewtwoTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MewtwoBattleText:
	text_far _MewtwoBattleText
	text_asm
	ld a, MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; Forte / DREIGON — talk-triggered, repeatable superboss battle. Uses the same
; manual "start a battle from a text handler" sequence a gym leader uses for his
; first fight (wd72d 6/7 + EngageMapTrainer + InitBattleEnemyParameters), which
; pulls his team (party 1) straight from the object. EVENT_FORTE_FOUGHT switches
; the intro to the rematch line; EVENT_FORTE_WON_LAST records the last result for
; the "earned my respect" branch. Neither flag blocks re-challenging him.
CeruleanCaveB1FForteText:
	text_asm
	CheckEvent EVENT_FORTE_FOUGHT
	jr nz, .rematch
	ld hl, ForteFirstText
	jr .prompt
.rematch
	CheckEvent EVENT_FORTE_WON_LAST
	jr nz, .respect
	ld hl, ForteRematchText
	jr .prompt
.respect
	ld hl, ForteRematchWonText
.prompt
	call PrintText
	xor a
	ld [wMenuJoypadPollCount], a ; menu hygiene: a stale Cable Club poll-count would phantom-accept and force this L80 fight with no input
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .accepted
	ld hl, ForteRefusedText
	call PrintText
	jr .done
.accepted
	ld hl, ForteAcceptText
	call PrintText
	call Delay3
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ForteEndBattleText
	ld de, ForteEndBattleText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	xor a
	ld [wGymLeaderNo], a
	SetEvent EVENT_FORTE_FOUGHT
	ResetEvent EVENT_FORTE_WON_LAST
	ld a, SCRIPT_CERULEANCAVEB1F_FORTE_POST_BATTLE
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

ForteFirstText:
	text_far _ForteFirstText
	text_end

ForteRematchText:
	text_far _ForteRematchText
	text_end

ForteRematchWonText:
	text_far _ForteRematchWonText
	text_end

ForteAcceptText:
	text_far _ForteAcceptText
	text_end

ForteEndBattleText:
	text_far _ForteEndBattleText
	text_end

ForteRefusedText:
	text_far _ForteRefusedText
	text_end

CeruleanCaveB1FForteWinText:
	text_far _ForteWinText
	text_end
