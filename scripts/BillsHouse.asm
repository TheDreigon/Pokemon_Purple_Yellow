BillsHouse_Script:
	call BillsHouseShowOrHideGardenWall
	call BillsHouseScript_1e09e
	call EnableAutoTextBoxDrawing
	ld a, [wBillsHouseCurScript]
	ld hl, BillsHouse_ScriptPointers
	call CallFunctionInTable
	ret

BillsHouseGardenWallBlock  EQU $20 ; the divider: floor on top, wall underneath
BillsHouseGardenOpenBlock  EQU $0E ; the room's plain floor block
BillsHouseGardenWallY      EQU 1   ; in BLOCKS, not cells
BillsHouseGardenWallX      EQU 6

BillsHouseShowOrHideGardenWall::
; The wall that hides the back door to BILL's garden, put back on every entry to
; the map so the state survives leaving and reloading -- the same shape as
; BrunoShowOrHideExitBlock in scripts/BrunosRoom.asm.
;
; The two blocked cells (12,3) and (13,3) share ONE block, (6,1), so this is a
; single replacement rather than two. Opening it also opens the path: (12,3) ->
; (12,2) -> (11,2) -> (11,1) -> (11,0), which is the door.
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z ; only on map entry, not on every script tick
; CheckEvent leaves Z set when the event is CLEAR, and `ld a, n` does not touch
; flags, so the two loads can sit between the test and the branch.
	CheckEvent EVENT_BILL_OPENED_GARDEN
	ld a, BillsHouseGardenWallBlock
	jr z, .notOpenedYet
	ld a, BillsHouseGardenOpenBlock
.notOpenedYet
	ld [wNewTileBlockID], a
	lb bc, BillsHouseGardenWallY, BillsHouseGardenWallX
	predef_jump ReplaceTileBlock

BillsHouseGardenWalkScript:
; BILL crosses the room to the wall he is about to take down. Started by
; BillsHouseOfferRematch after he has said "come with me"; MoveSprite sets
; wJoyIgnore to $FF itself, so from here until the wall is open the player
; cannot walk off, open a menu, or leave the map. The scene is atomic on
; purpose: EVENT_BILL_OPENED_GARDEN is only set at the very end, so even an
; interrupted run just leaves him back at his desk on the next map load.
; Ask which BILL is on the map rather than naming one. Today the scene can only
; start from BILL2's text so BILL2 is necessarily the visible one, but the two
; other scenes in this file both needed this helper, and moving a hidden sprite
; would hang the scene waiting for a walk nobody can see.
	call BillsHouseVisibleBill
	ret c ; neither is on the map: do nothing rather than move a ghost
	ldh [hSpriteIndex], a
; If the player is facing LEFT they are standing at (5,4), the one cell that is
; in his way -- so he goes around by row 5, the way vanilla's own Bill walk
; picks a detour off the player's facing a few routines above.
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_LEFT
	ld de, BillsHouseGardenWalkStraight
	jr nz, .go
	ld de, BillsHouseGardenWalkAround
.go
	call MoveSprite
	ld a, SCRIPT_BILLSHOUSE_GARDEN_FOLLOW
	ld [wBillsHouseCurScript], a
	ret

BillsHouseGardenFollowScript:
; He has crossed the room; now the player is pulled after him, so that the
; camera -- which follows the PLAYER, not BILL -- is looking at the wall when it
; opens. Without this the whole scene played off-screen: BILL ends at x=13 and
; the wall is at x=12-13, while the player stood at x=4 and saw an empty room.
;
; The route is chosen by the player's actual COORDINATES, the way PewterGuys
; does it for the Pewter guides, rather than by their facing. Facing is only a
; proxy for where they are, and the thing we need is where they are.
	ld a, [wd730]
	bit 0, a
	ret nz ; BILL is still walking
	call StartSimulatingJoypadStates
	call BillsHouseGardenPlayerRoute ; de = the button list for this start cell
	ld hl, wSimulatedJoypadStatesEnd
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	ld a, SCRIPT_BILLSHOUSE_GARDEN_OPEN
	ld [wBillsHouseCurScript], a
	ret

BillsHouseGardenPlayerRoute:
; To talk to BILL at (4,4) the player must be on one of four cells, and each
; needs its own way east. All four end on (12,4), beside him and under the wall.
; Row 4 is clear from x=3 to x=13 and he has vacated (4,4) by now, so every
; route is a straight run once the player is on that row.
	ld a, [wYCoord]
	cp 3
	jr z, .fromAbove
	cp 5
	jr z, .fromBelow
	ld a, [wXCoord]
	cp 3
	jr z, .fromWest
	ld de, BillsHouseGardenRouteFromEast
	ret
.fromWest
	ld de, BillsHouseGardenRouteFromWest
	ret
.fromAbove
	ld de, BillsHouseGardenRouteFromAbove
	ret
.fromBelow
	ld de, BillsHouseGardenRouteFromBelow
	ret

BillsHouseGardenRouteFromWest:  ; (3,4)
	db D_RIGHT, 9
	db -1 ; end
BillsHouseGardenRouteFromEast:  ; (5,4)
	db D_RIGHT, 7
	db -1 ; end
BillsHouseGardenRouteFromAbove: ; (4,3)
	db D_DOWN, 1
	db D_RIGHT, 8
	db -1 ; end
BillsHouseGardenRouteFromBelow: ; (4,5)
	db D_UP, 1
	db D_RIGHT, 8
	db -1 ; end

; (4,4) -> (13,4), nine steps along a row that is clear from x=3 to x=13.
BillsHouseGardenWalkStraight:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

; the same, one row lower, for when the player is standing on his first step
BillsHouseGardenWalkAround:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end

BillsHouseGardenOpenScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz ; the player is still being walked over
; 🔴 MoveSprite leaves wJoyIgnore at $FF (home/pathfinding.asm:41), and the text
; below has a page break, which waits on WaitForTextScrollButtonPress -- and
; _Joypad masks A and B out of hJoy5 while that flag is set. Printing first and
; clearing after was a HARD FREEZE with no way out but a reset, and because
; EVENT_BILL_OPENED_GARDEN is set further down, the reset landed the player back
; before the scene to freeze again. Clear it BEFORE the text, the way
; BillsHouseScript3 and BillsHouseScript11 in this same file already do.
	xor a
	ld [wJoyIgnore], a
	ld hl, BillsHouseGardenThisWayText
	call PrintText
	ld a, SFX_GO_INSIDE
	call PlaySound
	call WaitForSoundToFinish
	ld a, BillsHouseGardenOpenBlock
	ld [wNewTileBlockID], a
	lb bc, BillsHouseGardenWallY, BillsHouseGardenWallX
	predef ReplaceTileBlock
; The chip goes with the garden -- it is the same reward, for the same reason.
; farcall because BillsHouse_2.asm is in another bank ("Maps 22" against this
; file's "Maps 4"), which is how this file already reaches its other half.
	farcall BillsHouseGiveChip
	SetEvent EVENT_BILL_OPENED_GARDEN
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
	ld [wBillsHouseCurScript], a
	ret

BillsHouseGardenThisWayText:
	text_far _BillsHouseGardenThisWayText
	text_end

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
	dw_const BillsHouseGardenWalkScript, SCRIPT_BILLSHOUSE_GARDEN_WALK
	dw_const BillsHouseGardenFollowScript, SCRIPT_BILLSHOUSE_GARDEN_FOLLOW
	dw_const BillsHouseGardenOpenScript, SCRIPT_BILLSHOUSE_GARDEN_OPEN

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
	ld a, [wXCoord]
	cp 2
	jr z, .onDoorColumn
	cp 3
	ret nz
.onDoorColumn
	ld b, a ; the column, kept across the row check below
	ld a, [wYCoord]
	cp 6
	jr z, .oneStepFromTheMat
	cp 7
	ret nz
	ld a, b
	push af ; the column decides how far he walks
; Which Bill is actually on the map? ASK, do not infer. This used to guess from
; EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING, and when the guess was wrong it ordered
; a hidden sprite to walk - CheckSpriteAvailability refuses to move an invisible
; sprite, so the movement never finished and the wait below never ended. Forte
; froze on the doormat. Guessing was the bug; the engine already knows.
	call BillsHouseVisibleBill
	jr c, .nobodyToWalk
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
	ld hl, wd492
	ld a, [hl]
	and $c0 ; keep the two flag bits this byte already owns
	or BILLSHOUSE_WALK_TIMEOUT
	ld [hl], a
	ld a, SCRIPT_BILLSHOUSE_SCRIPT11
	ld [wBillsHouseCurScript], a
	ret
.oneStepFromTheMat
; The player is standing on a door column with the mat one step below, and BILL
; still owes them an EEVEE. Ask the next warp to not happen.
;
; 2026-08-14, from Forte's playtest: a held Down walked STRAIGHT OUT of the
; house while BILL was calling him back. CheckWarpsNoCollision decides the warp
; at the END of the step that lands on the mat, and re-reads the joypad right
; there -- before the overworld loop returns to the top and runs this script. A
; map script gets one frame per completed step and that frame comes after the
; warp, so it can never win the race by being fast. It has to close the door
; one step early instead. The player still takes that step and still stops ON
; the mat, which is where he wanted the scene to happen; only the door refuses,
; once, and SCRIPT10 fires on the very next frame to freeze him properly.
	ld a, 1
	ld [wBlockNextWarp], a
	ret
.nobodyToWalk
; Neither Bill is on the map. Nothing can walk, so say the line where he stands
; rather than wait for a step that will never happen.
	pop af
	ld a, TEXT_BILLSHOUSE_BILL_EEVEE_GIFT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jr .disarm
.disarm
	xor a
	ld [wBlockNextWarp], a ; nothing left holding the door
	ld a, SCRIPT_BILLSHOUSE_SCRIPT9
	ld [wBillsHouseCurScript], a
	ret

BillsHouseVisibleBill:
; Returns the sprite index of whichever Bill is currently on the map, or carry
; set if neither is. IsObjectHidden reads the sprite OFFSET (index * 16) out of
; hCurrentSpriteOffset, and the overworld loop rewrites that every frame for
; every sprite, so borrowing it here costs nothing.
	ld a, BILLSHOUSE_BILL1 * $10
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsHiddenMissableObject]
	and a
	ld a, BILLSHOUSE_BILL1
	ret z
	ld a, BILLSHOUSE_BILL2 * $10
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsHiddenMissableObject]
	and a
	ld a, BILLSHOUSE_BILL2
	ret z
	scf
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
;
; The wait is BOUNDED. An earlier version waited on wd730 bit 0 alone, and when
; the movement could not start it waited for ever with the player's input
; ignored - a freeze on the doormat, which Forte hit. The cause below is fixed
; too, but a scripted scene that CAN hang is not worth the six bytes saved: on
; timeout the scene simply plays out from wherever he is standing.
	ld a, [wd730]
	bit 0, a
	jr z, .arrived
	ld hl, wd492
	ld a, [hl]
	and $3f ; the low six bits are this scene's countdown
	jr z, .giveUp
	dec a
	ld b, a
	ld a, [hl]
	and $c0
	or b
	ld [hl], a
	ret
.giveUp
	ld hl, wd730
	res 0, [hl] ; release the scripted-movement hold...
	xor a
	ld [wJoyIgnore], a ; ...and the player's controls with it
.arrived
	call BillsHouseVisibleBill
	jr c, .noTurn
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
.noTurn
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
