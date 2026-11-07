Route22_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route22_ScriptPointers
	ld a, [wRoute22CurScript]
	jp CallFunctionInTable

Route22_ScriptPointers:
	def_script_pointers
	dw_const Route22DefaultScript,           SCRIPT_ROUTE22_DEFAULT
	dw_const Route22Rival1StartBattleScript, SCRIPT_ROUTE22_RIVAL1_START_BATTLE
	dw_const Route22Rival1AfterBattleScript, SCRIPT_ROUTE22_RIVAL1_AFTER_BATTLE
	dw_const Route22Rival1ExitScript,        SCRIPT_ROUTE22_RIVAL1_EXIT
	dw_const Route22Rival2StartBattleScript, SCRIPT_ROUTE22_RIVAL2_START_BATTLE
	dw_const Route22Rival2AfterBattleScript, SCRIPT_ROUTE22_RIVAL2_AFTER_BATTLE
	dw_const Route22Rival2ExitScript,        SCRIPT_ROUTE22_RIVAL2_EXIT
	dw_const Route22NoopScript,              SCRIPT_ROUTE22_NOOP

Route22SetDefaultScript:
	xor a ; SCRIPT_ROUTE22_DEFAULT
	ld [wJoyIgnore], a
	ld [wRoute22CurScript], a
Route22NoopScript:
	ret

Route22Script_50ed6:
	ld a, OPP_RIVAL1
	ld [wCurOpponent], a
	ld a, $2
	ld [wTrainerNo], a
	ret

Route22Script_50ee1:
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, [wRivalStarter]
	add 7
	ld [wTrainerNo], a
	ret

; v1.0 (2026-11-07): the doorstep backstop. The redrawn map has two ways west that miss the corridor
; cells: the pond (SURF) and the bottom row (down the east strip by the ledge at (38,17) or the cell
; (39,17), west along row 18, up through the CUT tree at (3,16)), both open by the second battle.
; Every way ends on the gate's doorstep (8,8), the only cell the gate (8,7) is entered from: a rival
; still owed is met there (entry 3 of Route22DefaultScript.Route22RivalBattleCoords). He is not
; walked over from (25,7), seventeen cells away and off-screen, with PIKACHU one step behind the
; player and possibly in his last cell: he is put straight into the doorway, the one neighbour of
; the doorstep PIKACHU cannot be on while the player walks in. The entry is compared as the number
; 3, and the doorway written as numbers, because coord_table_audit replays these scenes from them.
Route22MoveRivalRightScript:
	ld de, Route22RivalMovementData
	ld a, [wSavedCoordIndex]
	cp 3 ; the doorstep
	jr z, .inDoorway
	cp $1
	jr z, .skip_first_right
	inc de
.skip_first_right
	call MoveSprite
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay
.inDoorway
	ld de, Route22RivalStayMovementData ; no step: Route22RivalsToDoorway put him beside the player
	call MoveSprite
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay

Route22RivalStayMovementData:
	db -1 ; end

Route22RivalsToDoorway:
; Both battle scripts call this before the "!". On the doorstep only: both rival objects (only the
; owed one is shown) go to the doorway (8,7), one row above the player, who stands at the screen's
; player position (X $40, Y $3c). The map coordinates carry the engine's +4.
	ld a, [wSavedCoordIndex]
	cp 3 ; the doorstep
	ret nz
	ld hl, wSprite01StateData1YPixels
	call .screenPosition
	ld hl, wSprite02StateData1YPixels
	call .screenPosition
	ld hl, wSprite01StateData2MapY
	ld a, 11 ; 7 + 4
	ld [hli], a
	ld a, 12 ; 8 + 4
	ld [hl], a
	ld hl, wSprite02StateData2MapY
	ld a, 11
	ld [hli], a
	ld a, 12
	ld [hl], a
	jp UpdateSprites ; drawn there before the "!" goes up
.screenPosition
	ld [hl], $3c - $10 ; YPixels
	inc hl
	inc hl
	ld [hl], $40 ; XPixels
	ret

Route22RivalMovementData:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

Route22DefaultScript:
	CheckEvent EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	ret z
	ld hl, .Route22RivalBattleCoords
	call ArePlayerCoordsInArray
	ret nc
	ld a, [wCoordIndex]
	cp 3 ; the doorstep (see Route22MoveRivalRightScript)
	jr nz, .gotEntry
; on the way IN only: out of the gate the player faces down and PIKACHU steps out behind, onto the doorway
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_DOWN
	ret z
	ld a, 3
.gotEntry
	ld [wSavedCoordIndex], a
	xor a
	ldh [hJoyHeld], a
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld b, PLAYER_DIR_LEFT
	ld a, [wSavedCoordIndex]
	cp 3
	jr nz, .gotDirection
	ld b, PLAYER_DIR_UP ; facing the doorway
.gotDirection
	ld a, b
	ld [wPlayerMovingDirection], a
	CheckEvent EVENT_1ST_ROUTE22_RIVAL_BATTLE
	jr nz, Route22FirstRivalBattleScript
	CheckEventReuseA EVENT_2ND_ROUTE22_RIVAL_BATTLE
	jp nz, Route22SecondRivalBattleScript
	ret

.Route22RivalBattleCoords
; 🔴 These followed the RIVAL down the map, they are not vanilla's any more.
; Vanilla stands him at (25,5) and triggers at (29,4)/(29,5): one row above him
; and his own row, four tiles east. A map polish pass moved him to (25,7) and
; left the coords behind -- and rows 4 and 5 became SOLID, so the trigger sat on
; two tiles the player can never occupy and neither RIVAL1 nor RIVAL2 could ever
; fire. Same relationship as vanilla, two rows down.
;
; The order still matters: entry 1 is the player standing ABOVE him (the scripts
; below read wSavedCoordIndex == 1 to face the player down and the rival up, and
; give the rival his extra step east so he lands directly underneath), entry 2
; is the player on his own row, entry 3 the gate's doorstep, the backstop for
; the ways round the corridor (see Route22MoveRivalRightScript).
	dbmapcoord 29,  6
	dbmapcoord 29,  7
	dbmapcoord  8,  8 ; the doorstep, right below the gate's doorway (8,7)
	db -1 ; end

Route22FirstRivalBattleScript:
	call Route22RivalsToDoorway
	ld a, ROUTE22_RIVAL1
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	call StopAllMusic
.walking
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld a, ROUTE22_RIVAL1
	ldh [hSpriteIndex], a
	call Route22MoveRivalRightScript
	ld a, SCRIPT_ROUTE22_RIVAL1_START_BATTLE
	ld [wRoute22CurScript], a
	ret

Route22Rival1StartBattleScript:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, [wSavedCoordIndex]
	cp 1 ; 1 = first, upper entry in Route22DefaultScript.Route22RivalBattleCoords (wCoordIndex is 1-based)
	jr nz, .set_rival_facing_right
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	jr .set_rival_facing_direction
.set_rival_facing_right
	cp 3 ; the doorstep
	ld a, SPRITE_FACING_DOWN ; the doorway, above the player (who faces up already)
	jr z, .set_rival_facing_direction
	ld a, SPRITE_FACING_RIGHT
.set_rival_facing_direction
	ldh [hSpriteFacingDirection], a
	ld a, ROUTE22_RIVAL1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_ROUTE22_RIVAL1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, Route22Rival1DefeatedText
	ld de, Route22Rival1VictoryText
	call SaveEndBattleTextPointers
	call Route22Script_50ed6
	ld a, SCRIPT_ROUTE22_RIVAL1_AFTER_BATTLE
	ld [wRoute22CurScript], a
	ret

Route22Rival1DefeatedText:
	text_far _Route22Rival1DefeatedText
	text_end

Route22Rival1VictoryText:
	text_far _Route22Rival1VictoryText
	text_end

Route22Rival1AfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route22SetDefaultScript
	ld a, [wRivalStarter]
	cp RIVAL_STARTER_FLAREON
	jr nz, .keep_rival_starter
	ld a, RIVAL_STARTER_JOLTEON
	ld [wRivalStarter], a
.keep_rival_starter
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	jr nz, .not_facing_down
	ld a, SPRITE_FACING_UP
	jr .set_rival_facing
.not_facing_down
	cp SPRITE_FACING_UP
	ld a, SPRITE_FACING_DOWN ; the doorstep: he is in the doorway above
	jr z, .set_rival_facing
	ld a, SPRITE_FACING_RIGHT
.set_rival_facing
	ldh [hSpriteFacingDirection], a
	ld a, ROUTE22_RIVAL1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_ROUTE22_RIVAL_1ST_BATTLE
	ld a, TEXT_ROUTE22_RIVAL1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, [wSavedCoordIndex]
	cp 1 ; 1 = first, upper entry in Route22DefaultScript.Route22RivalBattleCoords (wCoordIndex is 1-based)
	jr nz, .exit_movement_2
	call .RivalExit1Script
	jr .next_script
.exit_movement_2
	cp 3 ; the doorstep
	jr z, .next_script ; no walk out of the doorway: the exit script hides him at once
	call .RivalExit2Script
.next_script
	ld a, SCRIPT_ROUTE22_RIVAL1_EXIT
	ld [wRoute22CurScript], a
	ret

.RivalExit1Script:
	ld de, Route22Rival1ExitMovementData1
	jr Route22MoveRival1

.RivalExit2Script:
	ld de, Route22Rival1ExitMovementData2
Route22MoveRival1:
	ld a, ROUTE22_RIVAL1
	ldh [hSpriteIndex], a
	jp MoveSprite

Route22Rival1ExitMovementData1:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route22Rival1ExitMovementData2:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route22Rival1ExitScript:
	ld a, [wd730]
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	ResetEvents EVENT_1ST_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	ld a, SCRIPT_ROUTE22_DEFAULT
	ld [wRoute22CurScript], a
	ret

Route22SecondRivalBattleScript:
	call Route22RivalsToDoorway
	ld a, ROUTE22_RIVAL2
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	call StopAllMusic
.walking
	call StopAllMusic
	farcall Music_RivalAlternateTempo
	ld a, ROUTE22_RIVAL2
	ldh [hSpriteIndex], a
	call Route22MoveRivalRightScript
	ld a, SCRIPT_ROUTE22_RIVAL2_START_BATTLE
	ld [wRoute22CurScript], a
	ret

Route22Rival2StartBattleScript:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, ROUTE22_RIVAL2
	ldh [hSpriteIndex], a
	ld a, [wSavedCoordIndex]
	cp 1 ; 1 = first, upper entry in Route22DefaultScript.Route22RivalBattleCoords (wCoordIndex is 1-based)
	jr nz, .set_player_direction_left
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	jr .set_rival_facing_direction
.set_player_direction_left
	cp 3 ; the doorstep
	ld a, SPRITE_FACING_DOWN ; the doorway, above the player (who faces up already)
	jr z, .set_rival_facing_direction
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
.set_rival_facing_direction
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_ROUTE22_RIVAL2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, Route22Rival2DefeatedText
	ld de, Route22Rival2VictoryText
	call SaveEndBattleTextPointers
	call Route22Script_50ee1
	ld a, SCRIPT_ROUTE22_RIVAL2_AFTER_BATTLE
	ld [wRoute22CurScript], a
	ret

Route22Rival2DefeatedText:
	text_far _Route22Rival2DefeatedText
	text_end

Route22Rival2VictoryText:
	text_far _Route22Rival2VictoryText
	text_end

Route22Rival2AfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route22SetDefaultScript
	ld a, ROUTE22_RIVAL2
	ldh [hSpriteIndex], a
	ld a, [wSavedCoordIndex]
	cp 1 ; 1 = first, upper entry in Route22DefaultScript.Route22RivalBattleCoords (wCoordIndex is 1-based)
	jr nz, .set_player_direction_left
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	jr .set_rival_facing_direction
.set_player_direction_left
	cp 3 ; the doorstep
	ld a, SPRITE_FACING_DOWN ; the doorway, above the player (who faces up already)
	jr z, .set_rival_facing_direction
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
.set_rival_facing_direction
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_ROUTE22_RIVAL_2ND_BATTLE
	ld a, TEXT_ROUTE22_RIVAL2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call StopAllMusic
	farcall Music_RivalAlternateStartAndTempo
	ld a, [wSavedCoordIndex]
	cp 1 ; 1 = first, upper entry in Route22DefaultScript.Route22RivalBattleCoords (wCoordIndex is 1-based)
	jr nz, .exit_movement_2
	call .RivalExit1Script
	jr .next_script
.exit_movement_2
	cp 3 ; the doorstep
	jr z, .next_script ; no walk out of the doorway: the exit script hides him at once
	call .RivalExit2Script
.next_script
	ld a, SCRIPT_ROUTE22_RIVAL2_EXIT
	ld [wRoute22CurScript], a
	ret

.RivalExit1Script:
	ld de, Route22Rival2ExitMovementData1
	jr Route22MoveRival2

.RivalExit2Script:
	ld de, Route22Rival2ExitMovementData2
Route22MoveRival2:
	ld a, ROUTE22_RIVAL2
	ldh [hSpriteIndex], a
	jp MoveSprite

Route22Rival2ExitMovementData1:
	db NPC_MOVEMENT_LEFT
Route22Rival2ExitMovementData2:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db -1 ; end

Route22Rival2ExitScript:
	ld a, [wd730]
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_22_RIVAL_2
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	ResetEvents EVENT_2ND_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	ld a, SCRIPT_ROUTE22_NOOP
	ld [wRoute22CurScript], a
	ret

Route22_TextPointers:
	def_text_pointers
	dw_const Route22Rival1Text,            TEXT_ROUTE22_RIVAL1
	dw_const Route22Rival2Text,            TEXT_ROUTE22_RIVAL2
	dw_const Route22PokemonLeagueSignText, TEXT_ROUTE22_POKEMON_LEAGUE_SIGN

Route22Rival1Text:
	text_asm
	farcall Route22PrintRival1Text
	jp TextScriptEnd

Route22Rival2Text:
	text_asm
	farcall Route22PrintRival2Text
	jp TextScriptEnd

Route22PokemonLeagueSignText:
	text_asm
	farcall Route22PrintPokemonLeagueSignText
	jp TextScriptEnd
