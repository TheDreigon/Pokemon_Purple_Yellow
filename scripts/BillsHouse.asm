BillsHouse_Script:
	call BillsHouseScript_1e09e
	call EnableAutoTextBoxDrawing
	ld a, [wBillsHouseCurScript]
	ld hl, BillsHouse_ScriptPointers
	call CallFunctionInTable
	ret

BillsHouse_ScriptPointers:
	def_script_pointers
	dw_const BillsHouseScript0, SCRIPT_BILLSHOUSE_SCRIPT0
	dw_const BillsHouseScript1, SCRIPT_BILLSHOUSE_SCRIPT1
	dw_const BillsHouseScript2, SCRIPT_BILLSHOUSE_SCRIPT2
	dw_const BillsHouseScript3, SCRIPT_BILLSHOUSE_SCRIPT3
	dw_const BillsHouseScript4, SCRIPT_BILLSHOUSE_SCRIPT4
	dw_const BillsHouseScript5, SCRIPT_BILLSHOUSE_SCRIPT5
	dw_const BillsHouseScript6, SCRIPT_BILLSHOUSE_SCRIPT6
	dw_const BillsHouseScript7, SCRIPT_BILLSHOUSE_SCRIPT7
	dw_const BillsHouseScript8, SCRIPT_BILLSHOUSE_SCRIPT8
	dw_const BillsHouseScript9, SCRIPT_BILLSHOUSE_SCRIPT9
	dw_const BillsHouseScript10, SCRIPT_BILLSHOUSE_SCRIPT10
	dw_const BillsHouseScript11, SCRIPT_BILLSHOUSE_SCRIPT11
	dw_const BillsHousePostBattleScript, SCRIPT_BILLSHOUSE_POST_BATTLE

BillsHouseScript_1e09e:
	ld hl, wd492
	bit 7, [hl]
	set 7, [hl]
	ret nz
	CheckEventHL EVENT_MET_BILL_2
	jr z, .asm_1e0af
	jr .asm_1e0b3

.asm_1e0af
	ld a, SCRIPT_BILLSHOUSE_SCRIPT0
	jr .asm_1e0b5

.asm_1e0b3
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
.asm_1e0b5
	ld [wBillsHouseCurScript], a
	ret

BillsHouseScript0:
	ld a, [wd472]
	bit 7, a
	jr z, .asm_1e0d2
	callfar CheckPikachuFaintedOrStatused
	jr c, .asm_1e0d2
	callfar Func_f24d5
.asm_1e0d2
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_BILLSHOUSE_SCRIPT1
	ld [wBillsHouseCurScript], a
	ret

BillsHouseScript1:
	ret

BillsHouseScript2:
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	ld de, MovementData_1e79c
	jr nz, .notDown
	call CheckPikachuFollowingPlayer
	jr nz, .asm_1e0f8
	callfar Func_f250b
.asm_1e0f8
	ld de, MovementData_1e7a0
.notDown
	ld a, BILLSHOUSE_BILL_POKEMON
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_BILLSHOUSE_SCRIPT3
	ld [wBillsHouseCurScript], a
	ret

MovementData_1e79c:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; make Bill walk around the player
MovementData_1e7a0:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db -1 ; end

BillsHouseScript3:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_BILL_POKEMON
	ld [wMissableObjectIndex], a
	predef HideObject
	call CheckPikachuFollowingPlayer
	jr z, .asm_1e13e
	ld hl, PikachuMovementData_1e14d
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	jr nz, .asm_1e133
	ld hl, PikachuMovementData_1e152
.asm_1e133
	call ApplyPikachuMovementData
	callfar InitializePikachuTextID
.asm_1e13e
	xor a
	ld [wJoyIgnore], a
	SetEvent EVENT_BILL_SAID_USE_CELL_SEPARATOR
	ld a, SCRIPT_BILLSHOUSE_SCRIPT4
	ld [wBillsHouseCurScript], a
	ret

PikachuMovementData_1e14d:
	db $00
	db $1e
	db $1e
	db $1e
	db $3f

PikachuMovementData_1e152:
	db $00
	db $1e
	db $1f
	db $1e
	db $1e
	db $20
	db $36
	db $3f

BillsHouseScript4:
	CheckEvent EVENT_USED_CELL_SEPARATOR_ON_BILL
	ret z
	ld a, SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, SCRIPT_BILLSHOUSE_SCRIPT5
	ld [wBillsHouseCurScript], a
	ret

BillsHouseScript5:
	ld a, BILLSHOUSE_BILL1
	ld [wSpriteIndex], a
	ld a, $c
	ldh [hSpriteScreenYCoord], a
	ld a, $40
	ldh [hSpriteScreenXCoord], a
	ld a, 6
	ldh [hSpriteMapYCoord], a
	ld a, 5
	ldh [hSpriteMapXCoord], a
	call SetSpritePosition1
	ld a, HS_BILL_1
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld c, 8
	call DelayFrames
	ld hl, wd472
	bit 7, [hl]
	jr z, .asm_1e1c6
	call CheckPikachuFollowingPlayer
	jr z, .asm_1e1c6
	ld a, BILLSHOUSE_BILL1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld hl, PikachuMovementData_1e1a9
	call ApplyPikachuMovementData
	ld a, $f
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	callfar InitializePikachuTextID
.asm_1e1c6
	ld a, BILLSHOUSE_BILL1
	ldh [hSpriteIndex], a
	ld de, MovementData_1e807
	call MoveSprite
	ld a, SCRIPT_BILLSHOUSE_SCRIPT6
	ld [wBillsHouseCurScript], a
	ret

MovementData_1e807:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db -1 ; end

PikachuMovementData_1e1a9:
	db $00
	db $37
	db $3f

BillsHouseScript6:
	ld a, [wd730]
	bit 0, a
	ret nz
	SetEvent EVENT_MET_BILL_2 ; this event seems redundant
	SetEvent EVENT_MET_BILL
	ld a, SCRIPT_BILLSHOUSE_SCRIPT7
	ld [wBillsHouseCurScript], a
	ret

BillsHouseScript7:
	xor a
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld de, RLE_1e219
	ld hl, wSimulatedJoypadStatesEnd
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_BILLSHOUSE_SCRIPT8
	ld [wBillsHouseCurScript], a
	ret

RLE_1e219:
	db D_RIGHT, $3
	db $FF

BillsHouseScript8:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, BILLSHOUSE_BILL1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_BILLSHOUSE_BILL_SS_TICKET
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
	ld [wBillsHouseCurScript], a
	ret

BillsHouseScript9:
; Bill's Eevee: once the player is fully inside the room, arm
; the door trigger that lets Bill catch them on the way out
	CheckEvent EVENT_GOT_BILL_EEVEE
	ret nz
	ld a, [wYCoord]
	cp 7
	ret nc
	ld a, SCRIPT_BILLSHOUSE_SCRIPT10
	ld [wBillsHouseCurScript], a
	ret

BillsHouseScript10:
; Armed: fire when the player is actually standing ON the doorway - y 7, and
; one of the two door columns.
;
; It used to fire on the whole of row 6, one row short of the mat, for fear that
; standing on the warp would leave the room before Bill could speak. Forte
; tested it: the warp only fires if you press Down while standing there. The old
; rule cost two things - being stopped a tile before the doorway for no visible
; reason, and being stopped anywhere along that row, which could leave half the
; room between the two of you while he handed over an Eevee.
;
; The event can be set while armed (talk-based retry give via BILL2),
; so disarm on it — otherwise the trigger would hand out a second Eevee.
	CheckEvent EVENT_GOT_BILL_EEVEE
	jr nz, .disarm
	ld a, [wYCoord]
	cp 7
	ret nz
	ld a, [wXCoord]
	cp 2
	jr z, .onTheDoor
	cp 3
	ret nz
.onTheDoor
	push af ; the column decides how far he walks
; Which Bill is actually on the map: Route 25 hides BILL1 and shows BILL2 once
; the player has left after helping him, so that event is the discriminator.
	CheckEvent EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ld a, BILLSHOUSE_BILL1
	jr z, .haveIndex
	ld a, BILLSHOUSE_BILL2
.haveIndex
	ldh [hSpriteIndex], a
	pop af
; Both Bills stand at (4,4). Three steps down puts him on (4,7); from there he
; is already beside a player on (3,7), and one step left reaches a player on
; (2,7). A second left would put him on top of them.
	cp 2
	ld de, BillsHouseEeveeWalkToLeftDoor
	jr z, .walk
	ld de, BillsHouseEeveeWalkToRightDoor
.walk
	call MoveSprite
	ld a, SCRIPT_BILLSHOUSE_SCRIPT11
	ld [wBillsHouseCurScript], a
	ret
.disarm
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
	ld [wBillsHouseCurScript], a
	ret

BillsHouseEeveeWalkToRightDoor:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

BillsHouseEeveeWalkToLeftDoor:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_LEFT
	db -1 ; end

BillsHouseScript11:
; He is walking over. Wait for it, then have the two of them look at each other
; before he says a word - he called the player back, so he is the one who closes
; the distance and he is the one who turns.
	ld a, [wd730]
	bit 0, a
	ret nz
	CheckEvent EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ld a, BILLSHOUSE_BILL1
	jr z, .haveIndex
	ld a, BILLSHOUSE_BILL2
.haveIndex
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	xor a
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	xor a
	ld [wJoyIgnore], a ; MoveSprite left this at $ff; the text needs the A button
	ld a, TEXT_BILLSHOUSE_BILL_EEVEE_GIFT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
	ld [wBillsHouseCurScript], a
	ret

BillsHouse_TextPointers:
	def_text_pointers
	dw_const BillsHouseBillPokemonText,               TEXT_BILLSHOUSE_BILL_POKEMON
	dw_const BillsHouseBillSSTicketText,              TEXT_BILLSHOUSE_BILL_SS_TICKET
	dw_const BillsHouseBillCheckOutMyRarePokemonText, TEXT_BILLSHOUSE_BILL_CHECK_OUT_MY_RARE_POKEMON
	dw_const BillsHouseBillDontLeaveText,             TEXT_BILLSHOUSE_BILL_DONT_LEAVE
	dw_const BillsHouseBillEeveeGiftText,             TEXT_BILLSHOUSE_BILL_EEVEE_GIFT
	dw_const BillsHouseBillPostBattleText,            TEXT_BILLSHOUSE_BILL_POST_BATTLE

BillsHouseBillDontLeaveText:
	text_far _BillsHouseBillDontLeaveText
	text_end

BillsHouseBillPokemonText:
	text_asm
	farcall BillsHousePrintBillPokemonText
	jp TextScriptEnd

BillsHouseBillSSTicketText:
	text_asm
	farcall BillsHousePrintBillSSTicketText
	jp TextScriptEnd

BillsHouseBillCheckOutMyRarePokemonText:
	text_asm
	farcall BillsHousePrintBillCheckOutMyRarePokemonText
	jp TextScriptEnd

BillsHouseBillEeveeGiftText:
	text_asm
	farcall BillsHouseGiveEevee
	jp TextScriptEnd

BillsHouseBillPostBattleText:
	text_far _BillsHouseBillPostBattleText
	text_end

BillsHousePostBattleScript:
; Mirrors the Nurse Joy and Officer Jenny post-battle scripts: the rematch is
; only spent on a WIN, so losing costs the player nothing but the trip.
	ld a, [wIsInBattle]
	inc a
	jr z, .lost
	SetEvent EVENT_BEAT_BILL
	SetEvent EVENT_REMATCHED_BILL ; spend this League run's battle
	ld a, TEXT_BILLSHOUSE_BILL_POST_BATTLE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.lost
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
	ld [wBillsHouseCurScript], a
	ret
