CeruleanBadgeHouse_Script:
	ld a, TRUE
	ld [wAutoTextBoxDrawingControl], a
	dec a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

CeruleanBadgeHouse_TextPointers:
	def_text_pointers
	dw_const CeruleanBadgeHouseMiddleAgedManText, TEXT_CERULEANBADGEHOUSE_MIDDLE_AGED_MAN

CeruleanBadgeHouseMiddleAgedManText:
	text_asm
	ld hl, .Text
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
.loop
	ld hl, .WhichBadgeText
	call PrintText
	ld hl, .BadgeItemList
	call LoadItemList
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld [wMenuItemToSwap], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .done
	ld hl, CeruleanBadgeHouseBadgeTextPointers
	ld a, [wcf91]
	sub BOULDERBADGE
	add a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .loop
.done
	xor a
	ld [wListScrollOffset], a
	ld hl, .VisitAnyTimeText
	call PrintText
	jp TextScriptEnd

.BadgeItemList:
	table_width 1, .BadgeItemList
	db NUM_BADGES ; #
	db BOULDERBADGE
	db CASCADEBADGE
	db THUNDERBADGE
	db RAINBOWBADGE
	db SOULBADGE
	db GOLDBADGE
	db VOLCANOBADGE
	db EARTHBADGE
	db -1 ; end
	assert_table_length NUM_BADGES + 2

.Text:
	text_far _CeruleanBadgeHouseMiddleAgedManText
	text_end

.WhichBadgeText:
	text_far _CeruleanBadgeHouseMiddleAgedManWhichBadgeText
	text_end

.VisitAnyTimeText:
	text_far _CeruleanBadgeHouseMiddleAgedManVisitAnyTimeText
	text_end

CeruleanBadgeHouseBadgeTextPointers:
	table_width 2, CeruleanBadgeHouseBadgeTextPointers
	dw CeruleanBadgeHouseBoulderBadgeText
	dw CeruleanBadgeHouseCascadeBadgeText
	dw CeruleanBadgeHouseThunderBadgeText
	dw CeruleanBadgeHouseRainbowBadgeText
	dw CeruleanBadgeHouseSoulBadgeText
	dw CeruleanBadgeHouseGoldBadgeText
	dw CeruleanBadgeHouseVolcanoBadgeText
	dw CeruleanBadgeHouseEarthBadgeText
	assert_table_length NUM_BADGES

CeruleanBadgeHouseBoulderBadgeText:
; v1.0 (the SPECIAL split, 2026-09-06): no boost on either road any more, so
; the knob #17 twin is gone
	text_far _CeruleanBadgeHouseBoulderBadgeText
	text_end

CeruleanBadgeHouseCascadeBadgeText:
	text_far _CeruleanBadgeHouseCascadeBadgeText
	text_end

CeruleanBadgeHouseThunderBadgeText:
; v0.7 knob #17 (2026-09-01): no boost claim on hard
	text_asm
	ld hl, .normal
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jr z, .print
	ld hl, .hard
.print
	call PrintText
	jp TextScriptEnd
.normal
	text_far _CeruleanBadgeHouseThunderBadgeText
	text_end
.hard
	text_far _CeruleanBadgeHouseThunderBadgeHardText
	text_end

CeruleanBadgeHouseRainbowBadgeText:
; v1.0 (the SPECIAL split, 2026-09-06): RAINBOW lends DEFENSE now, so the entry
; gets the knob #17 twin - no boost claim on hard
	text_asm
	ld hl, .normal
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jr z, .print
	ld hl, .hard
.print
	call PrintText
	jp TextScriptEnd
.normal
	text_far _CeruleanBadgeHouseRainbowBadgeText
	text_end
.hard
	text_far _CeruleanBadgeHouseRainbowBadgeHardText
	text_end

CeruleanBadgeHouseSoulBadgeText:
; v0.7 knob #17 (2026-09-01): no boost claim on hard
	text_asm
	ld hl, .normal
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jr z, .print
	ld hl, .hard
.print
	call PrintText
	jp TextScriptEnd
.normal
	text_far _CeruleanBadgeHouseSoulBadgeText
	text_end
.hard
	text_far _CeruleanBadgeHouseSoulBadgeHardText
	text_end

CeruleanBadgeHouseGoldBadgeText:
; v1.0 (the SPECIAL split, 2026-09-06): GOLD lends SP.DEF now, so the entry
; gets the knob #17 twin - no boost claim on hard
	text_asm
	ld hl, .normal
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jr z, .print
	ld hl, .hard
.print
	call PrintText
	jp TextScriptEnd
.normal
	text_far _CeruleanBadgeHouseGoldBadgeText
	text_end
.hard
	text_far _CeruleanBadgeHouseGoldBadgeHardText
	text_end

CeruleanBadgeHouseVolcanoBadgeText:
; v0.7 knob #17 (2026-09-01): no boost claim on hard
	text_asm
	ld hl, .normal
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jr z, .print
	ld hl, .hard
.print
	call PrintText
	jp TextScriptEnd
.normal
	text_far _CeruleanBadgeHouseVolcanoBadgeText
	text_end
.hard
	text_far _CeruleanBadgeHouseNoBoostHardText
	text_end

CeruleanBadgeHouseEarthBadgeText:
	text_far _CeruleanBadgeHouseEarthBadgeText
	text_end
