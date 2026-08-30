FightingDojo_Script:
	call FightingDojoPostLeagueState
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, FightingDojoOnEntry
	call EnableAutoTextBoxDrawing
	ld hl, FightingDojoTrainerHeaders
	ld de, FightingDojo_ScriptPointers
	ld a, [wFightingDojoCurScript]
	call ExecuteCurMapScriptInTable
	ld [wFightingDojoCurScript], a
	ret

; v0.7: the dojo-master takeover. Post-League the master holds the Viridian
; Gym instead and all four students retire their pre-League teams: their
; beat-events are set here so nobody charges, and each Text handler below
; grows a wGameStage branch — the senior at (3,4) speaks (and fights, once)
; as the new master, the other three offer their own one-shot rebattles.
; Idempotent, runs every tick like its three show-if-earned siblings.
FightingDojoPostLeagueState:
	ld a, [wGameStage]
	and a
	ret z
	ld a, HS_FIGHTING_DOJO_MASTER
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEventRange EVENT_BEAT_FIGHTING_DOJO_TRAINER_0, EVENT_BEAT_FIGHTING_DOJO_TRAINER_3
; 2026-08-30 (Forte): with the master gone the prize fight is gone too, so
; a player who never beat him can never open the balls — leaving them
; visible would be an unreachable tease. Hide both. A player who DID beat
; him keeps the earned, still-claimable choice (and FightingDojoOnEntry
; already retires the unchosen one after a pick).
	CheckEvent EVENT_BEAT_KARATE_MASTER
	ret nz
	ld a, HS_FIGHTING_DOJO_GIFT_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_FIGHTING_DOJO_GIFT_2
	ld [wMissableObjectIndex], a
	predef HideObject
	ret

; The unchosen prize ball vanishes once the player has LEFT with the other —
; run once per map entry, so it still sits there while they stand in the hall
; with their new partner, and is gone the next time they walk in.
FightingDojoOnEntry:
	CheckEvent EVENT_GOT_HITMONLEE
	jr z, .notLee
	ld a, HS_FIGHTING_DOJO_GIFT_2
	jr .hide
.notLee
	CheckEvent EVENT_GOT_HITMONCHAN
	ret z ; neither chosen yet: both balls stay
	ld a, HS_FIGHTING_DOJO_GIFT_1
.hide
	ld [wMissableObjectIndex], a
	predef HideObject
	ret

FightingDojoResetScripts:
	xor a ; SCRIPT_FIGHTINGDOJO_DEFAULT
	ld [wJoyIgnore], a
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	ret

FightingDojo_ScriptPointers:
	def_script_pointers
	dw_const FightingDojoDefaultScript,                SCRIPT_FIGHTINGDOJO_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle,    SCRIPT_FIGHTINGDOJO_START_BATTLE
	dw_const EndTrainerBattle,                         SCRIPT_FIGHTINGDOJO_END_BATTLE
	dw_const FightingDojoKarateMasterPostBattleScript, SCRIPT_FIGHTINGDOJO_KARATE_MASTER_POST_BATTLE
	dw_const FightingDojoRebattlePostBattleScript,     SCRIPT_FIGHTINGDOJO_REBATTLE_POST_BATTLE

FightingDojoDefaultScript:
	CheckEvent EVENT_DEFEATED_FIGHTING_DOJO
	ret nz
	call CheckFightingMapTrainers
	ld a, [wTrainerHeaderFlagBit]
	and a
	ret nz
	CheckEvent EVENT_BEAT_KARATE_MASTER
	ret nz
	ld a, [wGameStage]
	and a
	ret nz ; post-League the master is HIDDEN — auto-facing a hidden sprite
	       ; is the freeze the Bill walk taught us to fear
	xor a
	ldh [hJoyHeld], a
	ld [wSavedCoordIndex], a
	ld a, [wYCoord]
	cp 3
	ret nz
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, 1
	ld [wSavedCoordIndex], a
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, FIGHTINGDOJO_KARATE_MASTER
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_FIGHTINGDOJO_KARATE_MASTER
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

FightingDojoKarateMasterPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FightingDojoResetScripts
	ld a, [wSavedCoordIndex]
	and a ; nz if the player was at (4, 3), left of the Karate Master
	jr z, .already_facing
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, FIGHTINGDOJO_KARATE_MASTER
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
.already_facing
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	SetEventRange EVENT_BEAT_KARATE_MASTER, EVENT_BEAT_FIGHTING_DOJO_TRAINER_3
	ld a, TEXT_FIGHTINGDOJO_KARATE_MASTER_I_WILL_GIVE_YOU_A_POKEMON
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a ; SCRIPT_FIGHTINGDOJO_DEFAULT
	ld [wJoyIgnore], a
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	ret

; The four one-shot rebattles share this state. The student index (1-4, in
; object order) rides across the battle in wSavedCoordIndex — the same
; in-map carrier the master's pre-League cutscene proves survives a fight —
; and a blackout burns nothing, like every rematch in the house.
FightingDojoRebattlePostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FightingDojoResetScripts
	ld a, [wSavedCoordIndex]
	dec a
	jr z, .master
	dec a
	jr z, .student2
	dec a
	jr z, .student3
	SetEvent EVENT_DOJO_REBATTLE_SPENT_3
	jr .done
.master
	SetEvent EVENT_DOJO_REBATTLE_SPENT_0
	jr .done
.student2
	SetEvent EVENT_DOJO_REBATTLE_SPENT_1
	jr .done
.student3
	SetEvent EVENT_DOJO_REBATTLE_SPENT_2
.done
	jp FightingDojoResetScripts

; Starts a one-shot student rebattle, dojo style — the challenge leads
; straight into the fight, no Yes/No on this floor (Forte, 2026-08-18).
; hl = challenge text · de = end-battle text · b = BLACKBELT party (10-13) ·
; c = student index (1-4) for the shared post-battle state above.
; The same de fills BOTH SaveEndBattleTextPointers slots ON PURPOSE: the
; engine's loss slot is DEAD, vanilla-wide — its only reader sits behind
; the victory path (core.asm:953 with wBattleResult forced 0 at :853), and
; a defeated player just blacks out hearing nothing. A per-student loss
; table lived here for one day (2026-08-29) and was reverted as unreachable
; content; do not split these again without wiring HandlePlayerBlackOut
; to print the loss slot first (idea parked in TASKS, Forte 2026-08-30).
FightingDojoStartRebattle:
	push de
	push bc
	call PrintText
	call Delay3
	pop bc
	pop hl
	ld d, h
	ld e, l
	call SaveEndBattleTextPointers
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld a, OPP_BLACKBELT
	ld [wCurOpponent], a
	ld a, b
	ld [wTrainerNo], a
	ld a, c
	ld [wSavedCoordIndex], a
	ld a, SCRIPT_FIGHTINGDOJO_REBATTLE_POST_BATTLE
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	ret

FightingDojo_TextPointers:
	def_text_pointers
	dw_const FightingDojoKarateMasterText,                          TEXT_FIGHTINGDOJO_KARATE_MASTER
	dw_const FightingDojoBlackbelt1Text,                            TEXT_FIGHTINGDOJO_BLACKBELT1
	dw_const FightingDojoBlackbelt2Text,                            TEXT_FIGHTINGDOJO_BLACKBELT2
	dw_const FightingDojoBlackbelt3Text,                            TEXT_FIGHTINGDOJO_BLACKBELT3
	dw_const FightingDojoBlackbelt4Text,                            TEXT_FIGHTINGDOJO_BLACKBELT4
	dw_const FightingDojoHitmonleePokeBallText,                     TEXT_FIGHTINGDOJO_HITMONLEE_POKE_BALL
	dw_const FightingDojoHitmonchanPokeBallText,                    TEXT_FIGHTINGDOJO_HITMONCHAN_POKE_BALL
	dw_const FightingDojoKarateMasterText.IWillGiveYouAPokemonText, TEXT_FIGHTINGDOJO_KARATE_MASTER_I_WILL_GIVE_YOU_A_POKEMON

FightingDojoTrainerHeaders:
	def_trainers 2
FightingDojoTrainerHeader0:
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_0, TEXT_FIGHTINGDOJO_BLACKBELT1, FightingDojoBlackbelt1BattleText, FightingDojoBlackbelt1EndBattleText, FightingDojoBlackbelt1AfterBattleText
FightingDojoTrainerHeader1:
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_1, TEXT_FIGHTINGDOJO_BLACKBELT2, FightingDojoBlackbelt2BattleText, FightingDojoBlackbelt2EndBattleText, FightingDojoBlackbelt2AfterBattleText
FightingDojoTrainerHeader2:
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_2, TEXT_FIGHTINGDOJO_BLACKBELT3, FightingDojoBlackbelt3BattleText, FightingDojoBlackbelt3EndBattleText, FightingDojoBlackbelt3AfterBattleText
FightingDojoTrainerHeader3:
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_3, TEXT_FIGHTINGDOJO_BLACKBELT4, FightingDojoBlackbelt4BattleText, FightingDojoBlackbelt4EndBattleText, FightingDojoBlackbelt4AfterBattleText
	db -1 ; end

FightingDojoKarateMasterText:
	text_asm
	CheckEvent EVENT_DEFEATED_FIGHTING_DOJO
	jp nz, .defeated_dojo
	CheckEventReuseA EVENT_BEAT_KARATE_MASTER
	jp nz, .defeated_master
	ld hl, .Text
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, .DefeatedText
	ld de, .DefeatedText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndexOrTextID]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, SCRIPT_FIGHTINGDOJO_KARATE_MASTER_POST_BATTLE
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	jr .end
.defeated_dojo
	ld hl, .StayAndTrainWithUsText
	call PrintText
	jr .end
.defeated_master
	ld hl, .IWillGiveYouAPokemonText
	call PrintText
.end
	jp TextScriptEnd

.Text:
	text_far _FightingDojoKarateMasterText
	text_end

.DefeatedText:
	text_far _FightingDojoKarateMasterDefeatedText
	text_end

.IWillGiveYouAPokemonText:
	text_far _FightingDojoKarateMasterIWillGiveYouAPokemonText
	text_end

.StayAndTrainWithUsText:
	text_far _FightingDojoKarateMasterStayAndTrainWithUsText
	text_end

FightingDojoBlackbelt1Text:
	text_asm
	ld a, [wGameStage]
	and a
	jr nz, .postLeague
	ld hl, FightingDojoTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd
.postLeague
; the senior of (3,4) holds the DOJO now — his takeover speech is the
; challenge, once ever
	CheckEvent EVENT_DOJO_REBATTLE_SPENT_0
	jr nz, .spent
	ld hl, .ChallengeText
	ld de, .DefeatText
	lb bc, 10, 1
	call FightingDojoStartRebattle
	jp TextScriptEnd
.spent
	ld hl, .AfterText
	call PrintText
	jp TextScriptEnd

.ChallengeText:
	text_far _FightingDojoNewMasterChallengeText
	text_end
.DefeatText:
	text_far _FightingDojoNewMasterDefeatText
	text_end
.AfterText:
	text_far _FightingDojoNewMasterAfterText
	text_end

FightingDojoBlackbelt1BattleText:
	text_far _FightingDojoBlackbelt1BattleText
	text_end

FightingDojoBlackbelt1EndBattleText:
	text_far _FightingDojoBlackbelt1EndBattleText
	text_end

FightingDojoBlackbelt1AfterBattleText:
; pre-League only — post-League his Text handler above never reaches
; TalkToTrainer (the takeover branch owns the talk)
	text_far _FightingDojoBlackbelt1AfterBattleText
	text_end

FightingDojoBlackbelt2Text:
	text_asm
	ld a, [wGameStage]
	and a
	jr nz, .postLeague
	ld hl, FightingDojoTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd
.postLeague
	CheckEvent EVENT_DOJO_REBATTLE_SPENT_1
	jr nz, .spent
	ld hl, .ChallengeText
	ld de, .DefeatText
	lb bc, 11, 2
	call FightingDojoStartRebattle
	jp TextScriptEnd
.spent
	ld hl, .AfterText
	call PrintText
	jp TextScriptEnd

.ChallengeText:
	text_far _FightingDojoBlackbelt2RebattleText
	text_end
.DefeatText:
	text_far _FightingDojoBlackbelt2RebattleEndText
	text_end
.AfterText:
	text_far _FightingDojoBlackbelt2RebattleAfterText
	text_end

FightingDojoBlackbelt2BattleText:
	text_far _FightingDojoBlackbelt2BattleText
	text_end

FightingDojoBlackbelt2EndBattleText:
	text_far _FightingDojoBlackbelt2EndBattleText
	text_end

FightingDojoBlackbelt2AfterBattleText:
	text_far _FightingDojoBlackbelt2AfterBattleText
	text_end

FightingDojoBlackbelt3Text:
	text_asm
	ld a, [wGameStage]
	and a
	jr nz, .postLeague
	ld hl, FightingDojoTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd
.postLeague
	CheckEvent EVENT_DOJO_REBATTLE_SPENT_2
	jr nz, .spent
	ld hl, .ChallengeText
	ld de, .DefeatText
	lb bc, 12, 3
	call FightingDojoStartRebattle
	jp TextScriptEnd
.spent
	ld hl, .AfterText
	call PrintText
	jp TextScriptEnd

.ChallengeText:
	text_far _FightingDojoBlackbelt3RebattleText
	text_end
.DefeatText:
	text_far _FightingDojoBlackbelt3RebattleEndText
	text_end
.AfterText:
	text_far _FightingDojoBlackbelt3RebattleAfterText
	text_end

FightingDojoBlackbelt3BattleText:
	text_far _FightingDojoBlackbelt3BattleText
	text_end

FightingDojoBlackbelt3EndBattleText:
	text_far _FightingDojoBlackbelt3EndBattleText
	text_end

FightingDojoBlackbelt3AfterBattleText:
	text_far _FightingDojoBlackbelt3AfterBattleText
	text_end

FightingDojoBlackbelt4Text:
	text_asm
	ld a, [wGameStage]
	and a
	jr nz, .postLeague
	ld hl, FightingDojoTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd
.postLeague
	CheckEvent EVENT_DOJO_REBATTLE_SPENT_3
	jr nz, .spent
	ld hl, .ChallengeText
	ld de, .DefeatText
	lb bc, 13, 4
	call FightingDojoStartRebattle
	jp TextScriptEnd
.spent
	ld hl, .AfterText
	call PrintText
	jp TextScriptEnd

.ChallengeText:
	text_far _FightingDojoBlackbelt4RebattleText
	text_end
.DefeatText:
	text_far _FightingDojoBlackbelt4RebattleEndText
	text_end
.AfterText:
	text_far _FightingDojoBlackbelt4RebattleAfterText
	text_end

FightingDojoBlackbelt4BattleText:
	text_far _FightingDojoBlackbelt4BattleText
	text_end

FightingDojoBlackbelt4EndBattleText:
	text_far _FightingDojoBlackbelt4EndBattleText
	text_end

FightingDojoBlackbelt4AfterBattleText:
	text_far _FightingDojoBlackbelt4AfterBattleText
	text_end

FightingDojoHitmonleePokeBallText:
	text_asm
	CheckEitherEventSet EVENT_GOT_HITMONLEE, EVENT_GOT_HITMONCHAN
	jr z, .PrizeStillHere
	ld hl, FightingDojoBetterNotGetGreedyText
	call PrintText
	jr .done
.PrizeStillHere
; 2026-08-29 (Forte): the prize is earned, never found — post-League the
; master is gone and the hall stands open, so without this gate a player
; who skipped the dojo could walk in and lift a ball for free. The
; Viridian honor reward chains off the GOT_* flags, so this one check
; gates that too; the never-won player catches his in VICTORY ROAD.
	CheckEvent EVENT_BEAT_KARATE_MASTER
	jr nz, .GetMon
	ld hl, FightingDojoPrizeNotEarnedText
	call PrintText
	jr .done
.GetMon
	ld a, HITMONLEE
	call DisplayPokedex
	ld hl, .Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	ld a, [wcf91]
	ld b, a
	ld c, 30
	call GivePokemon
	jr nc, .done

	; once Poké Ball is taken, hide sprite
	ld a, HS_FIGHTING_DOJO_GIFT_1
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvents EVENT_GOT_HITMONLEE, EVENT_DEFEATED_FIGHTING_DOJO
.done
	jp TextScriptEnd

.Text:
	text_far _FightingDojoHitmonleePokeBallText
	text_end

FightingDojoHitmonchanPokeBallText:
	text_asm
	CheckEitherEventSet EVENT_GOT_HITMONLEE, EVENT_GOT_HITMONCHAN
	jr z, .PrizeStillHere
	ld hl, FightingDojoBetterNotGetGreedyText
	call PrintText
	jr .done
.PrizeStillHere
; same earned-not-found gate as the LEE ball above (2026-08-29)
	CheckEvent EVENT_BEAT_KARATE_MASTER
	jr nz, .GetMon
	ld hl, FightingDojoPrizeNotEarnedText
	call PrintText
	jr .done
.GetMon
	ld a, HITMONCHAN
	call DisplayPokedex
	ld hl, .Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	ld a, [wcf91]
	ld b, a
	ld c, 30
	call GivePokemon
	jr nc, .done
	SetEvents EVENT_GOT_HITMONCHAN, EVENT_DEFEATED_FIGHTING_DOJO

	; once Poké Ball is taken, hide sprite
	ld a, HS_FIGHTING_DOJO_GIFT_2
	ld [wMissableObjectIndex], a
	predef HideObject
.done
	jp TextScriptEnd

.Text:
	text_far _FightingDojoHitmonchanPokeBallText
	text_end

FightingDojoBetterNotGetGreedyText:
	text_far _FightingDojoBetterNotGetGreedyText
	text_end

FightingDojoPrizeNotEarnedText:
	text_far _FightingDojoPrizeNotEarnedText
	text_end
