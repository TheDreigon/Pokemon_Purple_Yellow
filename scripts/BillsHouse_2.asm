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
; v0.7 Bill's Eevee quest — part 2 dispatch
	CheckEvent EVENT_GOT_BILL_EEVEE
	jr z, .default_chat
	CheckEvent EVENT_GOT_BILL_EEVEELUTION_STONE
	jr nz, .after_quest
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jr z, .no_badge_yet
	call BillsHouseCheckEeveeInParty
	jr nz, .no_eevee
	jp BillsHouseEeveelutionQuiz
.default_chat
	ld hl, .WhyDontYouGoInsteadOfMeText
	call PrintText
	ret
.no_badge_yet
	ld hl, .GoBeatMistyText
	call PrintText
	ret
.no_eevee
	ld hl, .WheresEeveeText
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

.WheresEeveeText:
	text_far _BillsHouseBillWheresEeveeText
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
; v0.7 Bill's Eevee quest — BILL2 is the Bill of every RETURN visit
; (Route 25's script swaps BILL1 out after the first exit), so the
; quest must dispatch from here too.
	CheckEvent EVENT_GOT_BILL_EEVEE
	jr z, .offer_eevee
	CheckEvent EVENT_GOT_BILL_EEVEELUTION_STONE
	jr nz, .after_quest
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jr z, .no_badge_yet
	call BillsHouseCheckEeveeInParty
	jr nz, .no_eevee
	jp BillsHouseEeveelutionQuiz
.offer_eevee
; only reachable when the door gift failed on a full party+box
	jp BillsHouseGiveEevee
.no_badge_yet
	ld hl, .GoBeatMistyText
	call PrintText
	ret
.no_eevee
	ld hl, .WheresEeveeText
	call PrintText
	ret
.after_quest
	ld hl, .HowsTheTeamText
	call PrintText
	ret

.GoBeatMistyText:
	text_far _BillsHouseBillGoBeatMistyText
	text_end

.WheresEeveeText:
	text_far _BillsHouseBillWheresEeveeText
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

; v0.7 Bill's Eevee quest — part 1: Bill catches the player at the
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

; returns z if an unevolved EEVEE is in the party
BillsHouseCheckEeveeInParty::
	ld hl, wPartySpecies
.loop
	ld a, [hli]
	cp $ff
	jr z, .not_found
	cp EEVEE
	jr nz, .loop
	xor a
	ret
.not_found
	or 1
	ret

; part 2 payoff: the favorite-eeveelution question -> matching stone
BillsHouseEeveelutionQuiz::
	ld hl, .YouBeatMistyText
	call PrintText
	ld hl, wd730
	set 6, [hl]
	ld hl, .WhichEvolutionText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
; the start-menu wrap QoL leaves wMenuWatchMovingOutOfBounds set;
; stale nonzero lets Up/Down at the menu edges bypass the A/B filter
; and instantly lock in a stone — clear it (two-option-menu hygiene)
	ld [wMenuWatchMovingOutOfBounds], a
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
	ld c, 12
	call TextBoxBorder
	call UpdateSprites
	hlcoord 2, 2
	ld de, .VaporeonName
	call PlaceString
	hlcoord 2, 4
	ld de, .JolteonName
	call PlaceString
	hlcoord 2, 6
	ld de, .FlareonName
	call PlaceString
	ld hl, wd730
	res 6, [hl]
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .take_your_time
	ld a, [wCurrentMenuItem]
	and a
	jr z, .vaporeon
	cp 1
	jr z, .jolteon
; flareon
	ld hl, .FlareonNerdText
	call PrintText
	lb bc, FIRE_STONE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .FireStoneReceivedText
	call PrintText
	jr .done
.vaporeon
	ld hl, .VaporeonNerdText
	call PrintText
	lb bc, WATER_STONE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .WaterStoneReceivedText
	call PrintText
	jr .done
.jolteon
	ld hl, .JolteonNerdText
	call PrintText
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

.VaporeonName:
	db "VAPOREON@"
.JolteonName:
	db "JOLTEON@"
.FlareonName:
	db "FLAREON@"

.YouBeatMistyText:
	text_far _BillsHouseBillYouBeatMistyText
	text_end

.WhichEvolutionText:
	text_far _BillsHouseBillWhichEvolutionText
	text_end

.VaporeonNerdText:
	text_far _BillsHouseBillVaporeonText
	text_end

.JolteonNerdText:
	text_far _BillsHouseBillJolteonText
	text_end

.FlareonNerdText:
	text_far _BillsHouseBillFlareonText
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
