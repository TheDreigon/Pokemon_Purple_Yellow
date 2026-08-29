; BILL's CHIP. Given once, as the garden opens, and offered again on any later
; visit if the bag was full at the time -- losing it to a full bag would be
; losing it for good, since the wall only comes down once.
;
; Exported and farcalled from BillsHouse.asm, which lives in another bank.
BillsHouseGiveChip::
	CheckEvent EVENT_GOT_BILLS_CHIP
	ret nz ; CheckEvent leaves Z SET when the event is clear
	ld hl, .ChipText
	call PrintText
	ld b, BILLS_CHIP
	ld c, 1
	call GiveItem
	jr nc, .noRoom
	ld hl, .GotChipText
	call PrintText
	SetEvent EVENT_GOT_BILLS_CHIP
	ret
.noRoom
	ld hl, .NoRoomText
	jp PrintText

.ChipText:
	text_far _BillsHouseChipText
	text_end

.GotChipText:
	text_far _BillsHouseChipGotItText
; Both of these are load-bearing, and the SS TICKET 100 lines below already
; proves the shape. The jingle is what every other key item in the game plays.
; The wait is what stops the retry path erasing this line unread: .gardenAlreadyOpen
; calls us FIRST and then prints again unconditionally, so without the button
; press the player who had a full bag -- the only player this path exists for --
; would never be told the chip arrived.
	sound_get_key_item
	text_promptbutton
	text_end

.NoRoomText:
	text_far _BillsHouseChipNoRoomText
	text_end

BillsHousePrintBillPokemonText::
	ld hl, .ImNotAPokemonText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .answered_no
.use_machine
	ld hl, .UseSeparationSystemText
	call PrintText
	ld a, SCRIPT_BILLSHOUSE_SCRIPT2
	ld [wBillsHouseCurScript], a
	ret
.answered_no
	ld hl, .NoYouGottaHelpText
	call PrintText
	jr .use_machine

.ImNotAPokemonText:
	text_far _BillsHouseBillImNotAPokemonText
	text_end

.UseSeparationSystemText:
	text_far _BillsHouseBillUseSeparationSystemText
	text_end

.NoYouGottaHelpText:
	text_far _BillsHouseBillNoYouGottaHelpText
	text_end

BillsHousePrintBillSSTicketText::
	CheckEvent EVENT_GOT_SS_TICKET
	jr nz, .got_ss_ticket
	ld hl, .ThankYouText
	call PrintText
	lb bc, S_S_TICKET, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .SSTicketReceivedText
	call PrintText
	SetEvent EVENT_GOT_SS_TICKET
	ld a, HS_CERULEAN_GUARD_1
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_CERULEAN_GUARD_2
	ld [wMissableObjectIndex], a
	predef HideObject
.got_ss_ticket
; Bill's Eevee quest — part 2 dispatch
	CheckEvent EVENT_GOT_BILL_EEVEE
	jr z, .default_chat
	CheckEvent EVENT_GOT_BILL_EEVEELUTION_STONE
	jr nz, .after_quest
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jr z, .no_badge_yet
; 2026-08-29 (Forte): the reward asks only that the gift was handed over
; and MISTY fell — no party scan. Boxing, evolving, even releasing the
; EEVEE no longer matters; the stone is a thank-you, not a custody check.
	jp BillsHouseStoneReward
.default_chat
	ld hl, .WhyDontYouGoInsteadOfMeText
	call PrintText
	ret
.no_badge_yet
	ld hl, .GoBeatMistyText
	call PrintText
	ret
.after_quest
	ld hl, .HowsTheTeamText
	call PrintText
	ret
.bag_full
	ld hl, .SSTicketNoRoomText
	call PrintText
	ret

.GoBeatMistyText:
	text_far _BillsHouseBillGoBeatMistyText
	text_end

.HowsTheTeamText:
	text_far _BillsHouseBillHowsTheTeamText
	text_end

.ThankYouText:
	text_far _BillsHouseBillThankYouText
	text_end

.SSTicketReceivedText:
	text_far _SSTicketReceivedText
	sound_get_key_item
	text_promptbutton
	text_end

.SSTicketNoRoomText:
	text_far _SSTicketNoRoomText
	text_end

.WhyDontYouGoInsteadOfMeText:
	text_far _BillsHouseBillWhyDontYouGoInsteadOfMeText
	text_end

BillsHousePrintBillCheckOutMyRarePokemonText::
; Bill's Eevee quest — BILL2 is the Bill of every RETURN visit
; (Route 25's script swaps BILL1 out after the first exit), so the
; quest must dispatch from here too.
	CheckEvent EVENT_GOT_BILL_EEVEE
	jr z, .offer_eevee
	CheckEvent EVENT_GOT_BILL_EEVEELUTION_STONE
	jr nz, .after_quest
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jr z, .no_badge_yet
; same 2026-08-29 reshape as the BILL1 dispatch above: no party scan
	jp BillsHouseStoneReward
.offer_eevee
; only reachable when the door gift failed on a full party+box
	jp BillsHouseGiveEevee
.no_badge_yet
	ld hl, .GoBeatMistyText
	call PrintText
	ret
.after_quest
	jp BillsHouseOfferRematch

.GoBeatMistyText:
	text_far _BillsHouseBillGoBeatMistyText
	text_end

.HowsTheTeamText:
	text_far _BillsHouseBillHowsTheTeamText
	text_end

BillsHouseOfferRematch::
; Post-League, Bill offers a battle. He does not challenge - he asks, and what
; he asks for is readings rather than a win.
;
; Same rematch shape as Nurse Joy and Officer Jenny: REMATCHED is set on every
; win and cleared by the Hall of Fame, so each League run buys exactly one;
; BEAT only picks the shorter wording, so re-winning the League re-arms him
; without resetting what he says.
;
; It lives here, after the routine above has finished with its own local labels,
; rather than inline where it is called from. A global label dropped into the
; middle of a routine takes ownership of every local label after it - which is
; exactly how this broke the first time.
; MEW comes before everything, League or no League. He built the storage system
; the whole region catches into, so he does not need to be told -- and it is the
; one thing that can stop this man mid-sentence.
;
; Keyed on the Pokedex OWNED flag rather than EVENT_BEAT_MEW, because that event
; is set by knocking it out too, and there is nothing to marvel at in that.
	CheckEvent EVENT_BILL_SAW_MEW
	jr nz, .noMewNews
	ld a, MEW
	ld [wd11e], a
	predef IndexToPokedex
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	ld hl, wPokedexOwned
	predef FlagActionPredef
	ld a, c
	and a
	jr z, .noMewNews
	SetEvent EVENT_BILL_SAW_MEW
	ld hl, .MewText
	call PrintText
.noMewNews
	ld a, [wGameStage]
	and a
	jp z, .notChampionYet ; jp, not jr: the garden branch below pushed that label
	                      ; out of a jr's reach
; The garden comes before anything else he might say, and only once he has
; actually been beaten: it is a reward for the relationship, not for the League
; on its own.
	CheckEvent EVENT_BEAT_BILL
	jr z, .rematch
; ...and not before he has handed the EEVEE over, which is where it came from:
; showing you the garden first would be showing you the shelf before the gift.
;
; It also closes the one hole an adversarial pass found. A player can reach the
; post-game with the Eevee still outstanding (a full box at the door), and
; BillsHouseScript9 then arms the doorway scene that hands it over -- a scene
; whose movement assumes he is at his desk. Without this line the garden walk
; could leave him at (13,4) with that armed, and he would set off from the wrong
; side of the room for the rest of the visit.
	CheckEvent EVENT_GOT_BILL_EEVEE
	jr z, .rematch
	CheckEvent EVENT_BILL_OPENED_GARDEN
	jr nz, .gardenAlreadyOpen
	ld hl, .ComeWithMeText
	call PrintText
	ld a, SCRIPT_BILLSHOUSE_GARDEN_WALK
	ld [wBillsHouseCurScript], a
	ld [wCurMapScript], a
	ret
.gardenAlreadyOpen
; The second door into the handover. It is here for exactly one case: a bag
; that was full when the wall came down. The event flag makes the call
; idempotent, so a player who had room already walks straight past it.
	call BillsHouseGiveChip
	CheckEvent EVENT_BILL_ASKED_ABOUT_GARDEN
	jr nz, .rematch
; Opening the wall and walking through it are different things. He only asks how
; it was of someone who went; the other branch is a nudge, and it repeats until
; they do. SetEvent writes through hl, so it has to happen before the text
; pointer is loaded.
	CheckEvent EVENT_ENTERED_BILLS_GARDEN
	jr z, .neverWentIn
	SetEvent EVENT_BILL_ASKED_ABOUT_GARDEN
	ld hl, .HowWasTheGardenText
	call PrintText
	jr .rematch
.neverWentIn
	ld hl, .GardenStillOutThereText
	call PrintText
.rematch
	CheckEvent EVENT_REMATCHED_BILL
	jr nz, .rematchSpent
	CheckEvent EVENT_BEAT_BILL
	ld hl, .ChallengeText
	jr z, .offer
	ld hl, .ChallengeAgainText
.offer
	call PrintText
	xor a
	ld [wMenuJoypadPollCount], a ; menu hygiene: a stale poll count would
	                             ; phantom-accept and force the fight
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
; He starts the battle by hand rather than through EngageMapTrainer, so the
; encounter jingle has to be played explicitly - the same idiom Joy and Jenny use.
	call StopAllMusic
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, .AcceptedText
	call PrintText
	call Delay3
	ld a, OPP_BILL
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, SCRIPT_BILLSHOUSE_POST_BATTLE
	ld [wBillsHouseCurScript], a
	ld [wCurMapScript], a
	ret
.refused
	ld hl, .RefusedText
	call PrintText
	ret
.rematchSpent
	ld hl, .CooldownText
	call PrintText
	ret
.notChampionYet
	ld hl, .HowsTheTeamText
	call PrintText
	ret

.MewText:
	text_far _BillsHouseBillMewText
	text_end

.ComeWithMeText:
	text_far _BillsHouseBillComeWithMeText
	text_end

.HowWasTheGardenText:
	text_far _BillsHouseBillHowWasTheGardenText
	text_end

.GardenStillOutThereText:
	text_far _BillsHouseBillGardenStillOutThereText
	text_end

.ChallengeText:
	text_far _BillsHouseBillRematchChallengeText
	text_end

.ChallengeAgainText:
	text_far _BillsHouseBillRematchAgainText
	text_end

.AcceptedText:
	text_far _BillsHouseBillRematchAcceptedText
	text_end

.RefusedText:
	text_far _BillsHouseBillRematchRefusedText
	text_end

.CooldownText:
	text_far _BillsHouseBillRematchCooldownText
	text_end

.HowsTheTeamText:
	text_far _BillsHouseBillHowsTheTeamText
	text_end


Func_f24ae::
	ld a, [wCurMap]
	cp BILLS_HOUSE
	jr nz, .asm_f24d2
	call CheckPikachuFollowingPlayer
	jr z, .asm_f24d2
	ld a, [wBillsHouseCurScript]
	cp SCRIPT_BILLSHOUSE_SCRIPT5
	ldpikaemotion e, PikachuEmotion27
	ret z
	cp SCRIPT_BILLSHOUSE_SCRIPT0
	ldpikaemotion e, PikachuEmotion23
	ret z
	CheckEventHL EVENT_MET_BILL_2
	ldpikaemotion e, PikachuEmotion32
	ret z
	ldpikaemotion e, PikachuEmotion31
	ret

.asm_f24d2
	ld e, $ff
	ret

Func_f24d5::
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	xor a
	ld [wPlayerMovingDirection], a
	call UpdateSprites
	call UpdateSprites
	ld hl, Data_f2505
	call ApplyPikachuMovementData
	ld a, $f ; pikachu
	ld [wEmotionBubbleSpriteIndex], a
	ld a, QUESTION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	call DisablePikachuFollowingPlayer
	callfar InitializePikachuTextID
	ret

Data_f2505:
	db $00
	db $20
	db $20
	db $20
	db $1e
	db $3f

Func_f250b::
	ld hl, Data_f251c
	ld b, SPRITE_FACING_UP
	call TryApplyPikachuMovementData
	ld hl, Data_f2521
	ld b, SPRITE_FACING_RIGHT
	call TryApplyPikachuMovementData
	ret

Data_f251c:
	db $00
	db $1f
	db $1d
	db $38
	db $3f

Data_f2521:
	db $00
	db $1e
	db $1f
	db $1f
	db $1d
	db $38
	db $3f

; Bill's Eevee quest — part 1: Bill catches the player at the
; door on the way out (fired by BillsHouseScript10)
BillsHouseGiveEevee::
	ld hl, .HeyWaitUpText
	call PrintText
	lb bc, EEVEE, 10
	call GivePokemon
	jr nc, .no_room
	SetEvent EVENT_GOT_BILL_EEVEE
; sent-to-box message has no button wait of its own (Melanie pattern),
; and the party path leaves the no-wait flag set — fix both before
; printing the hook text so its last page cannot self-close unread
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .EeveeHookText
	call PrintText
	ret
.no_room
; let the engine's box-full line be read before Bill's own (same
; pacing class as the sent-to-box wait above)
	call WaitForTextScrollButtonPress
	ld hl, .NoRoomText
	call PrintText
	ret

.HeyWaitUpText:
	text_far _BillsHouseBillHeyWaitUpText
	text_end

.EeveeHookText:
	text_far _BillsHouseBillEeveeHookText
	text_end

.NoRoomText:
	text_far _BillsHouseBillNoRoomForEeveeText
	text_end

; part 2 payoff (reshaped 2026-08-29, Forte): beat MISTY with the EEVEE
; handed over and Bill pays the promised reward — a free pick of the
; three evolution stones, tied to nothing but the two events. The old
; favorite-eeveelution quiz, its party scan, and the 08-25 evolved-EEVEE
; recognition all left with the custody requirement they served.
BillsHouseStoneReward::
	ld hl, .RisingStarText
	call PrintText
	ld hl, wd730
	set 6, [hl]
	ld hl, .WhichStoneText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
; the start-menu wrap QoL leaves wMenuWatchMovingOutOfBounds set;
; stale nonzero lets Up/Down at the menu edges bypass the A/B filter
; and instantly lock in a stone — clear it (fixed-menu hygiene)
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wMenuJoypadPollCount], a ; stale 1 (cable club) would auto-answer
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	hlcoord 0, 0
	ld b, 6
	ld c, 13 ; interior width — "THUNDERSTONE" is 12 plus the cursor column
	call TextBoxBorder
	call UpdateSprites
	hlcoord 2, 2
	ld de, .WaterStoneName
	call PlaceString
	hlcoord 2, 4
	ld de, .ThunderStoneName
	call PlaceString
	hlcoord 2, 6
	ld de, .FireStoneName
	call PlaceString
	ld hl, wd730
	res 6, [hl]
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .take_your_time
	ld a, [wCurrentMenuItem]
	and a
	jr z, .water_stone
	cp 1
	jr z, .thunder_stone
; fire stone
	lb bc, FIRE_STONE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .FireStoneReceivedText
	call PrintText
	jr .done
.water_stone
	lb bc, WATER_STONE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .WaterStoneReceivedText
	call PrintText
	jr .done
.thunder_stone
	lb bc, THUNDER_STONE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ThunderStoneReceivedText
	call PrintText
.done
	SetEvent EVENT_GOT_BILL_EEVEELUTION_STONE
	ret
.take_your_time
	ld hl, .TakeYourTimeText
	call PrintText
	ret
.bag_full
	ld hl, .StoneNoRoomText
	call PrintText
	ret

.WaterStoneName:
	db "WATER STONE@"
.ThunderStoneName:
	db "THUNDERSTONE@"
.FireStoneName:
	db "FIRE STONE@"

.RisingStarText:
	text_far _BillsHouseBillYouBeatMistyText
	text_end

.WhichStoneText:
	text_far _BillsHouseBillWhichStoneText
	text_end

.WaterStoneReceivedText:
	text_far _BillsHouseWaterStoneReceivedText
	sound_get_item_1
	text_end

.ThunderStoneReceivedText:
	text_far _BillsHouseThunderStoneReceivedText
	sound_get_item_1
	text_end

.FireStoneReceivedText:
	text_far _BillsHouseFireStoneReceivedText
	sound_get_item_1
	text_end

.TakeYourTimeText:
	text_far _BillsHouseBillTakeYourTimeText
	text_end

.StoneNoRoomText:
	text_far _BillsHouseBillStoneNoRoomText
	text_end
