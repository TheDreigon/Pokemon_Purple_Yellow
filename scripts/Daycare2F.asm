Daycare2F_Script:
; v0.7 (#38): this map had no script table at all -- it was one line, an
; EnableAutoTextBoxDrawing. It needs one now because JOY's battle has to leave
; a post-battle state behind, the same shape the FUCHSIA POKeMON CENTER used to
; carry before she moved up here.
	call EnableAutoTextBoxDrawing
	ld hl, Daycare2F_ScriptPointers
	ld a, [wDaycare2FCurScript]
	call CallFunctionInTable
	ret

Daycare2F_ScriptPointers:
	def_script_pointers
	dw_const Daycare2FDefaultScript, SCRIPT_DAYCARE2F_DEFAULT
	dw_const JoyPostBattleScript,    SCRIPT_DAYCARE2F_POST_BATTLE

Daycare2F_TextPointers:
	def_text_pointers
	dw_const Daycare2FNurseText,    TEXT_DAYCARE2F_NURSE
	dw_const Daycare2FChanseyText,  TEXT_DAYCARE2F_CHANSEY
	dw_const Daycare2FMrMimeText,   TEXT_DAYCARE2F_MR_MIME
	dw_const Daycare2FNidoranMText, TEXT_DAYCARE2F_NIDORAN_M
	dw_const Daycare2FCuboneText,   TEXT_DAYCARE2F_CUBONE
	dw_const Daycare2FSeelText,     TEXT_DAYCARE2F_SEEL
	dw_const Daycare2FClefairyText, TEXT_DAYCARE2F_CLEFAIRY
	dw_const NurseJoyAfterBattleText, TEXT_DAYCARE2F_POST_BATTLE

Daycare2FDefaultScript:
	ret

JoyPostBattleScript:
	ld a, [wIsInBattle]
	inc a
	jr z, .skip	; Kick out if the player lost.
	SetEvent EVENT_BEAT_NURSE_JOY
	SetEvent EVENT_REMATCHED_NURSE_JOY ; v0.7: spend this League run's battle (win only)
	ld a, TEXT_DAYCARE2F_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.skip
	ld a, SCRIPT_DAYCARE2F_DEFAULT
	ld [wDaycare2FCurScript], a
	ld [wCurMapScript], a
	ret

NurseJoyAfterBattleText:
	text_far _NurseJoyAfterBattleText
	text_end

Daycare2FNurseText:
; She talks first and offers the battle after, the same order the POKeMON
; CENTER version ran in.
;
; The NewPageButtonPressCheck is NOT optional and it is not about the healing
; dialogue it used to follow. Her page above ends in `done`, and `done` does not
; wait -- so without this, the next PrintText writes straight over the last page
; she just said. That is the same bug the BILL commits were caught with on
; 2026-08-12, in four texts at once. One call here covers all three branches
; below; the CENTER version needed three because it checked further down.
;
; What IS dropped is the wPlayerMovingDirection nudge the CENTER version
; carried: that byte is read in exactly two places, both inside the overworld
; walking loop, so it has nothing to do with printing text.
	text_asm
	ld hl, Daycare2FJoyText
	call PrintText
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr z, .done
	farcall NewPageButtonPressCheck
; v0.7 rematch cooldown: one battle per League run. REMATCHED is set on every
; win (including the first), BEAT only picks the "another battle?" wording, so
; re-beating the League re-arms her without resetting the dialogue stage.
	CheckEvent EVENT_REMATCHED_NURSE_JOY
	jr nz, .rematchSpent
	CheckEvent EVENT_BEAT_NURSE_JOY
	jr nz, .NotFirstBattle
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
	ld a, SCRIPT_DAYCARE2F_POST_BATTLE
	ld [wDaycare2FCurScript], a
	ld [wCurMapScript], a
	jr .done
.refused
	ld hl, NurseJoyRefusedText
	call PrintText
.done
	jp TextScriptEnd
.NotFirstBattle
	ld hl, NurseJoyPreBattleText2
	jr .continue
.rematchSpent
	ld hl, NurseJoyRematchCooldownText
	call PrintText
	jp TextScriptEnd

Daycare2FJoyText:
	text_far _Daycare2FNurseText
	text_end
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

Daycare2FChanseyText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FChanseyText
	text_asm
	ld a, CHANSEY
	call PlayCry
	jp TextScriptEnd

Daycare2FMrMimeText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FMrMimeText
	text_asm
	ld a, MR_MIME
	call PlayCry
	jp TextScriptEnd

Daycare2FNidoranMText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FNidoranMText
	text_asm
	ld a, NIDORAN_M
	call PlayCry
	jp TextScriptEnd

Daycare2FCuboneText:
; Melanie-house pattern: the text prints first and the cry rings over
; the open box -- PlayCry itself waits for the sound to finish
; (home/pokemon.asm), so a cry-first handler holds the text hostage.
	text_far _Daycare2FCuboneText
	text_asm
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd

Daycare2FSeelText:
	text_far _Daycare2FSeelText
	text_asm
	ld a, SEEL
	call PlayCry
	jp TextScriptEnd

Daycare2FClefairyText:
	text_far _Daycare2FClefairyText
	text_asm
	ld a, CLEFAIRY
	call PlayCry
	jp TextScriptEnd
