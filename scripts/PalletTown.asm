PalletTown_Script:
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr z, .next
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
.next
	call EnableAutoTextBoxDrawing
; v0.7: checked HERE, before the dispatch, and not inside PalletTownDefaultScript.
; After the intro this map does not sit on the DEFAULT state -- it rests on
; SCRIPT_PALLETTOWN_DAISY -- so a check hidden inside DEFAULT never runs again
; for the rest of the game. Found by walking a save out of the north exit and
; watching nothing happen.
	call PalletTownTrainerManualCheck
	ld hl, PalletTown_ScriptPointers
	ld a, [wPalletTownCurScript]
	jp CallFunctionInTable

PalletTown_ScriptPointers:
	def_script_pointers
	dw_const PalletTownDefaultScript,              SCRIPT_PALLETTOWN_DEFAULT
	dw_const PalletTownOakHeyWaitScript,           SCRIPT_PALLETTOWN_OAK_HEY_WAIT
	dw_const PalletTownOakWalksToPlayerScript,     SCRIPT_PALLETTOWN_OAK_WALKS_TO_PLAYER
	dw_const PalletTownOakGreetsPlayerScript,      SCRIPT_PALLETTOWN_OAK_GREETS_PLAYER
	dw_const PalletTownPikachuBattleScript,        SCRIPT_PALLETTOWN_PIKACHU_BATTLE
	dw_const PalletTownAfterPikachuBattleScript,   SCRIPT_PALLETTOWN_AFTER_PIKACHU_BATTLE
	dw_const PalletTownOakNotSafeComeWithMeScript, SCRIPT_PALLETTOWN_OAK_NOT_SAFE_COME_WITH_ME
	dw_const PalletTownPlayerFollowsOakScript,     SCRIPT_PALLETTOWN_PLAYER_FOLLOWS_OAK
	dw_const PalletTownDaisyScript,                SCRIPT_PALLETTOWN_DAISY
	dw_const PalletTownNoopScript,                 SCRIPT_PALLETTOWN_NOOP
; v0.7: the TRAINER MANUAL scene, appended so no existing state is renumbered
; -- wPalletTownCurScript is inside the saved block and an old save can be
; sitting on any of the ids above.
	dw_const PalletTownMomCallsScript,             SCRIPT_PALLETTOWN_MOM_CALLS
	dw_const PalletTownMomWalksScript,             SCRIPT_PALLETTOWN_MOM_WALKS
	dw_const PalletTownMomGivesScript,             SCRIPT_PALLETTOWN_MOM_GIVES
	dw_const PalletTownMomLeavesScript,            SCRIPT_PALLETTOWN_MOM_LEAVES
	dw_const PalletTownMomHidesScript,             SCRIPT_PALLETTOWN_MOM_HIDES

PalletTownDefaultScript:
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	ret nz
	ld a, [wYCoord]
	cp 0 ; is player at north exit?
	ret nz
	ResetEvent EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
	ld a, [wXCoord]
	cp 10
	jr z, .asm_18e40
	SetEventReuseHL EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
.asm_18e40
	xor a
	ldh [hJoyHeld], a
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	call StopAllMusic
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK ; "oak appears" music
	call PlayMusic
	SetEvent EVENT_OAK_APPEARED_IN_PALLET

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_HEY_WAIT
	ld [wPalletTownCurScript], a
	ret

; v0.7: the TRAINER MANUAL. Once Oak is done with this map his intercept above
; returns immediately, which leaves the north exit free -- and the north exit is
; the right tile for it: it is the moment the player is walking out of town for
; good, and it is the same tile Oak watches, so a player who never goes home
; still cannot leave without the manual.
;
; The player's mother is hidden the rest of the time (HS_PALLET_TOWN_MOM), so
; nothing here runs twice: the event is set by her text script when she hands it
; over, and this returns on it.
PalletTownTrainerManualCheck:
	ld a, [wPalletTownCurScript]
	cp SCRIPT_PALLETTOWN_MOM_CALLS
	ret nc ; her scene is already running; do not restart it every step
	CheckEvent EVENT_GOT_TRAINER_MANUAL
	ret nz
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	ret z ; the intro owns this tile until Oak has walked the player to the lab
	CheckEvent EVENT_GOT_POKEDEX
	ret z ; the manual is a POKéDEX-holder's book; it waits until Oak's errand
	ld a, [wYCoord]
	and a ; north exit?
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
; The same sting Oak stops the player with at the start of the game. It is the
; game's "someone is about to catch you" cue and this is the other time that
; happens; PlayDefaultMusic puts the town back afterwards.
	call StopAllMusic
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK
	call PlayMusic
	ld a, SCRIPT_PALLETTOWN_MOM_CALLS
	ld [wPalletTownCurScript], a
	ret

; The north exit is TWO tiles wide -- columns 10 and 11, both walkable from the
; edge down to y=4 -- and she comes up the one the player is NOT standing on.
;
; 🔴 That is the whole point. Walking her up the player's own column put her on
; the tile directly behind him, which is where the follower PIKACHU stands: she
; walked straight over it and it vanished. Beside him, there is nothing to walk
; over and both of them are on screen for the conversation.
;
; SPRITESTATEDATA2_MAPY/MAPX are map coordinates plus four, so y=4 is 8 and the
; two columns are 14 and 15.
PalletTownMomCallsScript:
	ld hl, wSprite04StateData2MapY
; 🔴 Row SIX. She used to start on row 3, which is inside the visible screen --
; she did not walk in from off-stage, she blinked into being two tiles from the
; player. Row 6 is below the bottom edge with the player standing on row 0.
; (SPRITESTATEDATA2_MAPY/MAPX are map coordinates plus four.)
;
; Always column 10: it is the only column walkable the whole way down (11 is
; blocked at row 5), and it is not PALLETTOWN_OAK's tile, which is (10,4) -- two
; objects on one square flicker against each other. She steps across into
; column 11 higher up, where the passage widens, if the player is on 10.
	ld a, 10 ; map row 6, below the bottom of the screen
	ld [hli], a
	ld a, 14 ; map column 10
	ld [hl], a
	ld a, HS_PALLET_TOWN_MOM
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, $2
	ld [wSprite04StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite04StateData1FacingDirection], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_MOM_WALKS
	ld [wPalletTownCurScript], a
	ret

; A written-out movement rather than FindPathToPlayer: pathfinding aims at the
; player's tile, and the whole point here is to arrive next to him instead.
PalletTownMomWalksScript:
	call Delay3
; Which lane she ends in decides the route: straight up if the player is on the
; right tile, or up-across-up to reach the left-hand one if he is on 10.
	ld de, PalletTownMomWalkUpMovement
	ld a, [wXCoord]
	cp 10
	jr nz, .gotRoute
	ld de, PalletTownMomWalkUpAcrossMovement
.gotRoute
	ld a, PALLETTOWN_MOM
	ldh [hSpriteIndex], a
	call MoveSprite

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_MOM_GIVES
	ld [wPalletTownCurScript], a
	ret

PalletTownMomGivesScript:
; wd730 bit 0 is "a sprite is being walked by a script"; MoveSprite clears it
; when she arrives. 🔴 Never talk before it clears -- a script that waits on a
; sprite which cannot move is exactly the Oak's Lab soft-lock.
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, $2
	ld [wSprite04StateData1MovementStatus], a
; She is beside him now, so she turns to face him rather than staring north.
	ld a, [wXCoord]
	cp 10
	ld a, SPRITE_FACING_LEFT ; she is on his right
	jr z, .facing
	ld a, SPRITE_FACING_RIGHT
.facing
	ld [wSprite04StateData1FacingDirection], a
	ld a, TEXT_PALLETTOWN_MOM
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID ; hands the manual over and sets the event

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_MOM_LEAVES
	ld [wPalletTownCurScript], a
	ret

; She walks back the way she came instead of blinking out of existence. Only
; then is the object hidden -- the flag persists, so leaving her shown would
; leave her standing at the town gate for the rest of the game.
PalletTownMomLeavesScript:
	ld a, $2
	ld [wSprite04StateData1MovementStatus], a
	ld de, PalletTownMomWalkBackMovement
	ld a, [wXCoord]
	cp 10
	jr nz, .gotRoute
	ld de, PalletTownMomWalkBackAcrossMovement
.gotRoute
	ld a, PALLETTOWN_MOM
	ldh [hSpriteIndex], a
	call MoveSprite

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_MOM_HIDES
	ld [wPalletTownCurScript], a
	ret

PalletTownMomHidesScript:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_PALLET_TOWN_MOM
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_PALLETTOWN_DEFAULT
	ld [wPalletTownCurScript], a
	ret

; From map row 6 up to row 0, in column 10, when the player is on column 11.
PalletTownMomWalkUpMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; The same climb, stepping into column 11 at row 2 where the passage widens,
; when the player is standing on column 10. Column 11 is a wall at row 5, which
; is why the crossing happens up here and not at the bottom.
PalletTownMomWalkUpAcrossMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

PalletTownMomWalkBackMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

PalletTownMomWalkBackAcrossMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

PalletTownOakHeyWaitScript:
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	xor a
	ld [wOakWalkedToPlayer], a
	ld a, TEXT_PALLETTOWN_OAK
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld hl, wSprite01StateData2MapY
	ld a, 8
	ld [hli], a ; SPRITESTATEDATA2_MAPY
	ld a, 14
	ld [hl], a ; SPRITESTATEDATA2_MAPX
	ld a, HS_PALLET_TOWN_OAK
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_WALKS_TO_PLAYER
	ld [wPalletTownCurScript], a
	ret

PalletTownOakWalksToPlayerScript:
	call Delay3
	ld a, 0
	ld [wYCoord], a
	ld a, 1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, 1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ld hl, hNPCPlayerYDistance
	dec [hl]
	predef FindPathToPlayer ; load Oak's movement into wNPCMovementDirections2
	ld de, wNPCMovementDirections2
	ld a, PALLETTOWN_OAK
	ldh [hSpriteIndex], a
	call MoveSprite

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_GREETS_PLAYER
	ld [wPalletTownCurScript], a
	ret

PalletTownOakGreetsPlayerScript:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, 1
	ld [wOakWalkedToPlayer], a
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, TEXT_PALLETTOWN_OAK
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; oak faces the horizontally adjacent patch of grass to face pikachu
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	CheckEvent EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
	ld a, SPRITE_FACING_RIGHT
	jr z, .asm_18f01
	ld a, SPRITE_FACING_LEFT
.asm_18f01
	ld [wSprite01StateData1FacingDirection], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_PIKACHU_BATTLE
	ld [wPalletTownCurScript], a
	ret

PalletTownPikachuBattleScript:
	; start the pikachu battle
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	xor a
	ld [wListScrollOffset], a
	ld a, BATTLE_TYPE_PIKACHU
	ld [wBattleType], a
	ld a, STARTER_PIKACHU
	ld [wCurOpponent], a
	ld a, 5
	ld [wCurEnemyLVL], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_AFTER_PIKACHU_BATTLE
	ld [wPalletTownCurScript], a
	ret

PalletTownAfterPikachuBattleScript:
	ld a, 2
	ld [wOakWalkedToPlayer], a
	ld a, TEXT_PALLETTOWN_OAK
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, TEXT_PALLETTOWN_OAK_COME_WITH_ME
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_NOT_SAFE_COME_WITH_ME
	ld [wPalletTownCurScript], a
	ret

PalletTownOakNotSafeComeWithMeScript:
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, PALLETTOWN_OAK
	ld [wSpriteIndex], a
	xor a
	ld [wNPCMovementScriptFunctionNum], a
	ld a, 1
	ld [wNPCMovementScriptPointerTableNum], a
	ldh a, [hLoadedROMBank]
	ld [wNPCMovementScriptBank], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_PLAYER_FOLLOWS_OAK
	ld [wPalletTownCurScript], a
	ret

PalletTownPlayerFollowsOakScript:
	ld a, [wNPCMovementScriptPointerTableNum]
	and a ; is the movement script over?
	ret nz

	; Check and see if we didn't make it to Oak's Lab
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	jr nz, .followed_oak
	; move player one tile left
	ld hl, wd736
	set 1, [hl]
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_LEFT | B_BUTTON
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wSpritePlayerStateData1ImageIndex], a
	jp StartSimulatingJoypadStates

.followed_oak
	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_DAISY
	ld [wPalletTownCurScript], a
	ret

PalletTownDaisyScript:
	CheckEvent EVENT_DAISY_WALKING
	jr nz, .next
	CheckBothEventsSet EVENT_GOT_TOWN_MAP, EVENT_ENTERED_BLUES_HOUSE, 1
	jr nz, .next
	SetEvent EVENT_DAISY_WALKING
	ld a, HS_DAISY_SITTING
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_DAISY_WALKING
	ld [wMissableObjectIndex], a
	predef_jump ShowObject
.next
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	ret z
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
PalletTownNoopScript:
	ret

PalletTown_TextPointers:
	def_text_pointers
	dw_const PalletTownOakText,              TEXT_PALLETTOWN_OAK
	dw_const PalletTownGirlText,             TEXT_PALLETTOWN_GIRL
	dw_const PalletTownFisherText,           TEXT_PALLETTOWN_FISHER
; v0.7: the MOTHER goes here and not at the end. Text ids are positional and
; the object_events must own the low ones -- def_warps_to asserts that a
; bg_event never lands on an id an object could have used -- so a fourth object
; takes id 4 and every sign below moves up one.
	dw_const PalletTownMomText,              TEXT_PALLETTOWN_MOM
	dw_const PalletTownOaksLabSignText,      TEXT_PALLETTOWN_OAKSLAB_SIGN
	dw_const PalletTownSignText,             TEXT_PALLETTOWN_SIGN
	dw_const PalletTownPlayersHouseSignText, TEXT_PALLETTOWN_PLAYERSHOUSE_SIGN
	dw_const PalletTownRivalsHouseSignText,  TEXT_PALLETTOWN_RIVALSHOUSE_SIGN
	dw_const PalletTownOakComeWithMe,        TEXT_PALLETTOWN_OAK_COME_WITH_ME

; The player's MOTHER, out in the street. She is hidden until the TRAINER
; MANUAL scene shows her, so this only ever runs during it.
;
; The give is guarded by the event and the event is only set on success, the
; way the Trainer School's TOWN MAP is: a full bag must not consume the gift.
PalletTownMomText:
	text_asm
	CheckEvent EVENT_GOT_TRAINER_MANUAL
	jr nz, .alreadyGiven
	ld hl, .CaughtYouText
	call PrintText
	lb bc, TRAINER_MANUAL, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_TRAINER_MANUAL
; Two PrintText calls, not one chained block. Chaining a `text_far` straight
; into a second one ran the two together mid-box: the receive line's own
; terminator ended the run, and the explanation started printing into whatever
; was left on screen. text_promptbutton closes the first properly.
	ld hl, .GotItText
	call PrintText
	ld hl, .ExplainText
	jr .print
.bagFull
	ld hl, .BagFullText
	jr .print
.alreadyGiven
	ld hl, .GoodbyeText
.print
	call PrintText
	jp TextScriptEnd

.CaughtYouText
	text_far _PalletTownMomCaughtYouText
	text_end

.GotItText
	text_far _PalletTownMomGotManualText
	sound_get_key_item
	text_promptbutton
	text_end

.ExplainText
	text_far _PalletTownMomExplainText
	text_end

.BagFullText
	text_far _PalletTownMomBagFullText
	text_end

.GoodbyeText
	text_far _PalletTownMomGoodbyeText
	text_end

PalletTownOakText:
	text_asm
	ld a, [wOakWalkedToPlayer]
	and a
	jr nz, .next
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .HeyWaitDontGoOutText
	jr .done
.next
	dec a
	jr nz, .whew
	ld hl, .ThatWasCloseText
	jr .done
.whew
	ld hl, .WhewText
.done
	call PrintText
	jp TextScriptEnd

.HeyWaitDontGoOutText:
	text_far _PalletTownOakHeyWaitDontGoOutText
	text_asm
	ld c, 10
	call DelayFrames
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a ; player's sprite
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	jp TextScriptEnd

.ThatWasCloseText:
	text_far _PalletTownOakThatWasCloseText
	text_end

.WhewText:
	text_far _PalletTownOakWhewText
	text_end

PalletTownOakComeWithMe:
	text_far _PalletTownOakComeWithMe
	text_end

PalletTownGirlText:
	text_far _PalletTownGirlText
	text_end

PalletTownFisherText:
	text_far _PalletTownFisherText 
	text_end

PalletTownOaksLabSignText:
	text_far _PalletTownOaksLabSignText
	text_end

PalletTownSignText:
IF DEF(_DEBUG)
	text_asm
	ld a, 239
	inc a
	ld [wWhichPewterGuy], a
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_decimal wWhichPewterGuy, 1, 3
	text "bit"
	done
ELSE
	text_far _PalletTownSignText
	text_end
ENDC

PalletTownPlayersHouseSignText:
	text_far _PalletTownPlayersHouseSignText
	text_end

PalletTownRivalsHouseSignText:
	text_far _PalletTownRivalsHouseSignText
	text_end
