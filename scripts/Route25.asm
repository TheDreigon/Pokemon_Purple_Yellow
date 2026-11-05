Route25_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route25TrainerHeaders
	ld de, Route25_ScriptPointers
	ld a, [wRoute25CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute25CurScript], a
	call Route25ShowHideBillScript
	ret

Route25ShowHideBillScript:
	ld hl, wd492
	res 2, [hl]
	res 3, [hl]
	res 4, [hl]
	res 7, [hl]
	xor a
	ld [wBillsHouseCurScript], a
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
; v1.0 (2026-09-24): BILL's LAB's fly slot is marked on entering his house
; (InteriorFlySlots, engine/overworld/missable_objects_2.asm), not here.
	CheckEventHL EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ret nz
	CheckEventReuseHL EVENT_MET_BILL_2
	jr nz, .met_bill
	ResetEventReuseHL EVENT_BILL_SAID_USE_CELL_SEPARATOR
	ld a, HS_BILL_POKEMON
	ld [wMissableObjectIndex], a
	predef ShowObject
	jr .done
.met_bill
	CheckEventAfterBranchReuseHL EVENT_GOT_SS_TICKET, EVENT_MET_BILL_2
	jr z, .done
	SetEventReuseHL EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ld a, HS_NUGGET_BRIDGE_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_BILL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_BILL_2
	ld [wMissableObjectIndex], a
	predef ShowObject
.done
	ret

Route25_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE25_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE25_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE25_END_BATTLE

Route25_TextPointers:
	def_text_pointers
	dw_const Route25Youngster1Text,    TEXT_ROUTE25_YOUNGSTER1
	dw_const Route25Youngster2Text,    TEXT_ROUTE25_YOUNGSTER2
	dw_const Route25CooltrainerMText,  TEXT_ROUTE25_COOLTRAINER_M
	dw_const Route25CooltrainerF1Text, TEXT_ROUTE25_COOLTRAINER_F1
	dw_const Route25Youngster3Text,    TEXT_ROUTE25_YOUNGSTER3
	dw_const Route25CooltrainerF2Text, TEXT_ROUTE25_COOLTRAINER_F2
	dw_const Route25Hiker1Text,        TEXT_ROUTE25_HIKER1
	dw_const Route25Hiker2Text,        TEXT_ROUTE25_HIKER2
	dw_const Route25Hiker3Text,        TEXT_ROUTE25_HIKER3
	dw_const PickUpItemText,           TEXT_ROUTE25_TM_SEISMIC_TOSS
	dw_const Route25CooltrainerM2Text, TEXT_ROUTE25_COOLTRAINER_M2
	dw_const Route25BillSignText,      TEXT_ROUTE25_BILL_SIGN

Route25TrainerHeaders:
	def_trainers
Route25TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_0, TEXT_ROUTE25_YOUNGSTER1, Route25Youngster1BattleText, Route25Youngster1EndBattleText, Route25Youngster1AfterBattleText
Route25TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_1, TEXT_ROUTE25_YOUNGSTER2, Route25Youngster2BattleText, Route25Youngster2EndBattleText, Route25Youngster2AfterBattleText
Route25TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_2, TEXT_ROUTE25_COOLTRAINER_M, Route25CooltrainerMBattleText, Route25CooltrainerMEndBattleText, Route25CooltrainerMAfterBattleText
Route25TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_3, TEXT_ROUTE25_COOLTRAINER_F1, Route25CooltrainerF1BattleText, Route25CooltrainerF1EndBattleText, Route25CooltrainerF1AfterBattleText
Route25TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_4, TEXT_ROUTE25_YOUNGSTER3, Route25Youngster3BattleText, Route25Youngster3EndBattleText, Route25Youngster3AfterBattleText
Route25TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_5, TEXT_ROUTE25_COOLTRAINER_F2, Route25CooltrainerF2BattleText, Route25CooltrainerF2EndBattleText, Route25CooltrainerF2AfterBattleText
Route25TrainerHeader6:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_6, TEXT_ROUTE25_HIKER1, Route25Hiker1BattleText, Route25Hiker1EndBattleText, Route25Hiker1AfterBattleText
Route25TrainerHeader7:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_7, TEXT_ROUTE25_HIKER2, Route25Hiker2BattleText, Route25Hiker2EndBattleText, Route25Hiker2AfterBattleText
Route25TrainerHeader8:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_8, TEXT_ROUTE25_HIKER3, Route25Hiker3BattleText, Route25Hiker3EndBattleText, Route25Hiker3AfterBattleText
	db -1 ; end

Route25Youngster1Text:
	text_asm
	ld hl, Route25TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route25Youngster2Text:
	text_asm
	ld hl, Route25TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route25CooltrainerMText:
	text_asm
	ld hl, Route25TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route25CooltrainerF1Text:
	text_asm
	ld hl, Route25TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route25Youngster3Text:
	text_asm
	ld hl, Route25TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route25CooltrainerF2Text:
	text_asm
	ld hl, Route25TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route25Hiker1Text:
	text_asm
	ld hl, Route25TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route25Hiker2Text:
	text_asm
	ld hl, Route25TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route25Hiker3Text:
	text_asm
	ld hl, Route25TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route25Youngster1BattleText:
	text_far _Route25Youngster1BattleText
	text_end

Route25Youngster1EndBattleText:
	text_far _Route25Youngster1EndBattleText
	text_end

Route25Youngster1AfterBattleText:
	text_far _Route25Youngster1AfterBattleText
	text_end

Route25Youngster2BattleText:
	text_far _Route25Youngster2BattleText
	text_end

Route25Youngster2EndBattleText:
	text_far _Route25Youngster2EndBattleText
	text_end

Route25Youngster2AfterBattleText:
	text_far _Route25Youngster2AfterBattleText
	text_end

Route25CooltrainerMBattleText:
	text_far _Route25CooltrainerMBattleText
	text_end

Route25CooltrainerMEndBattleText:
	text_far _Route25CooltrainerMEndBattleText
	text_end

Route25CooltrainerMAfterBattleText:
	text_far _Route25CooltrainerMAfterBattleText
	text_end

Route25CooltrainerF1BattleText:
	text_far _Route25CooltrainerF1BattleText
	text_end

Route25CooltrainerF1EndBattleText:
	text_far _Route25CooltrainerF1EndBattleText
	text_end

Route25CooltrainerF1AfterBattleText:
	text_far _Route25CooltrainerF1AfterBattleText
	text_end

Route25Youngster3BattleText:
	text_far _Route25Youngster3BattleText
	text_end

Route25Youngster3EndBattleText:
	text_far _Route25Youngster3EndBattleText
	text_end

Route25Youngster3AfterBattleText:
	text_far _Route25Youngster3AfterBattleText
	text_end

Route25CooltrainerF2BattleText:
	text_far _Route25CooltrainerF2BattleText
	text_end

Route25CooltrainerF2EndBattleText:
	text_far _Route25CooltrainerF2EndBattleText
	text_end

Route25CooltrainerF2AfterBattleText:
	text_far _Route25CooltrainerF2AfterBattleText
	text_end

Route25Hiker1BattleText:
	text_far _Route25Hiker1BattleText
	text_end

Route25Hiker1EndBattleText:
	text_far _Route25Hiker1EndBattleText
	text_end

Route25Hiker1AfterBattleText:
	text_far _Route25Hiker1AfterBattleText
	text_end

Route25Hiker2BattleText:
	text_far _Route25Hiker2BattleText
	text_end

Route25Hiker2EndBattleText:
	text_far _Route25Hiker2EndBattleText
	text_end

Route25Hiker2AfterBattleText:
	text_far _Route25Hiker2AfterBattleText
	text_end

Route25Hiker3BattleText:
	text_far _Route25Hiker3BattleText
	text_end

Route25Hiker3EndBattleText:
	text_far _Route25Hiker3EndBattleText
	text_end

Route25Hiker3AfterBattleText:
	text_far _Route25Hiker3AfterBattleText
	text_end

Route25BillSignText:
	text_far _Route25BillSignText
	text_end

; v1.0 (2026-11-05): DAMIAN came from ROUTE_24 with the top of that route (its labels were Route24...: the
; CHARMANDER gift and, once CHAMPION, the scene where he wants it back).
Route25CooltrainerM2Text:
	text_asm
	CheckEvent EVENT_54F
	jr nz, .asm_515d5
	ld hl, Route25DamianText1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_515d0
	ld a, CHARMANDER
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, CHARMANDER, 10
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, Route25DamianText2
	call PrintText
	SetEvent EVENT_54F
	jp TextScriptEnd

.asm_515d0
	ld hl, Route25DamianText3
	jr .asm_515d8

.asm_515d5
; v1.0 (2026-09-23): once the player is CHAMPION and the party holds a
; CHARMELEON or a CHARIZARD (only those two - the point is that it grew; any
; one of that line counts, the game cannot tell which CHARMANDER it was), he
; wants it back; the Pokemon answers for itself (its cry, his '!') and he
; backs down. Once only; afterwards a shorter line. A Champion who never took
; the CHARMANDER never reaches this arm (EVENT_54F stays clear).
	ld a, [wGameStage]
	and a
	jr z, .stillHauling
	CheckEvent EVENT_DAMIAN_WANTED_IT_BACK
	jr nz, .afterRefusal
	call Route25FindCharLine
	jr nc, .stillHauling
	push af ; the species, for its cry
	call GetPartyMonName2 ; wcd6d = its nickname (wWhichPokemon = the slot)
	ld hl, Route25DamianGiveItBackText
	call PrintText
	pop af
	call PlayCry
	ld a, ROUTE25_COOLTRAINER_M2 ; DAMIAN's own sprite
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	SetEvent EVENT_DAMIAN_WANTED_IT_BACK
	ld hl, Route25DamianRefusedText
	jr .asm_515d8
.afterRefusal
	ld hl, Route25DamianAfterText
	jr .asm_515d8
.stillHauling
	ld hl, Route25DamianText4
.asm_515d8
	call PrintText
	jp TextScriptEnd

Route25FindCharLine:
; carry set when the party holds a CHARMELEON or a CHARIZARD: a = the species,
; wWhichPokemon = its slot. Walks the $ff-terminated wPartySpecies list (not
; PARTY_LENGTH slots: deposited remnants live in the tail).
	ld hl, wPartySpecies
	ld b, 0
.loop
	ld a, [hli]
	cp $ff
	jr z, .none
	cp CHARMELEON
	jr z, .found
	cp CHARIZARD
	jr z, .found
	inc b
	jr .loop
.found
	ld c, a
	ld a, b
	ld [wWhichPokemon], a
	ld a, c
	scf
	ret
.none
	and a
	ret

Route25DamianText1:
	text_far _Route25DamianText1
	text_end

Route25DamianText2:
	text_far _Route25DamianText2
	text_waitbutton
	text_end

Route25DamianText3:
	text_far _Route25DamianText3
	text_end

Route25DamianText4:
	text_far _Route25DamianText4
	text_end

Route25DamianGiveItBackText:
	text_far _Route25DamianGiveItBackText
	text_end

Route25DamianRefusedText:
	text_far _Route25DamianRefusedText
	text_end

Route25DamianAfterText:
	text_far _Route25DamianAfterText
	text_end
