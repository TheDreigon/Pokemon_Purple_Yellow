PrintBlackboardLinkCableText:
	call EnableAutoTextBoxDrawing
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, [wHiddenObjectFunctionArgument]
	call PrintPredefTextID
	ret

; v0.7: LinkCableHelp and its four texts lived here -- the CELADON MANSION roof
; house board that taught HOW TO LINK / COLOSSEUM / TRADE CENTER. They went with
; the link cable. PrintBlackboardLinkCableText above is NOT link-specific in
; anything but its name: the VIRIDIAN SCHOOL blackboard goes through it too.

ViridianSchoolBlackboard::
	text_asm
	call SaveScreenTilesToBuffer1
	ld hl, ViridianSchoolBlackboardText1
	call PrintText
	xor a
	ld [wMenuItemOffset], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	; v0.7: three headings a column. The board carried a QUIT row until Forte
	; pointed out that it is grouped with things that are WRITTEN on the
	; blackboard, and "QUIT" is not one of them -- B leaves, as it does
	; everywhere. Losing it turned 4+3 back into an even 3+3.
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
.blackboardLoop
	ld hl, wd730
	set 6, [hl]
	hlcoord 0, 0
	lb bc, 6, 10
	call TextBoxBorder
	hlcoord 1, 2
	ld de, StatusAilmentText1
	call PlaceString
	hlcoord 6, 2
	ld de, StatusAilmentText2
	call PlaceString
	ld hl, ViridianSchoolBlackboardText2
	call PrintText
	call HandleMenuInput ; pressing up and down is handled in here
	bit BIT_B_BUTTON, a ; pressed b
	jr nz, .exitBlackboard
	bit BIT_D_RIGHT, a
	jr z, .didNotPressRight
	; move cursor to right column
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 6
	ld [wTopMenuItemX], a
	ld a, 3 ; in the right column, use an offset to prevent overlap
	ld [wMenuItemOffset], a
	jr .blackboardLoop
.didNotPressRight
	bit BIT_D_LEFT, a
	jr z, .didNotPressLeftOrRight
	; move cursor to left column
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	xor a
	ld [wMenuItemOffset], a
	jr .blackboardLoop
.didNotPressLeftOrRight
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wMenuItemOffset]
	add b
	; every row is a heading now, so A always prints one
	ld hl, wd730
	res 6, [hl]
	ld hl, ViridianBlackboardStatusPointers
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jp .blackboardLoop
.exitBlackboard
	ld hl, wd730
	res 6, [hl]
	call LoadScreenTilesFromBuffer1
	jp TextScriptEnd

ViridianSchoolBlackboardText1:
	text_far _ViridianSchoolBlackboardText1
	text_end

ViridianSchoolBlackboardText2:
	text_far _ViridianSchoolBlackboardText2
	text_end

StatusAilmentText1:
	db   " SLP"
	next " PSN"
	next " PAR@"

StatusAilmentText2:
	db   " BRN"
	next " FRZ"
	next " CNF@"

	db "@" ; unused

ViridianBlackboardStatusPointers:
; order must match the headings: left column 0-2, right column 3-5
	dw ViridianBlackboardSleepText
	dw ViridianBlackboardPoisonText
	dw ViridianBlackboardPrlzText
	dw ViridianBlackboardBurnText
	dw ViridianBlackboardFrozenText
	dw ViridianBlackboardConfusionText

ViridianBlackboardSleepText:
	text_far _ViridianBlackboardSleepText
	text_end

ViridianBlackboardPoisonText:
	text_far _ViridianBlackboardPoisonText
	text_end

ViridianBlackboardPrlzText:
	text_far _ViridianBlackboardPrlzText
	text_end

ViridianBlackboardBurnText:
	text_far _ViridianBlackboardBurnText
	text_end

ViridianBlackboardFrozenText:
	text_far _ViridianBlackboardFrozenText
	text_end

ViridianBlackboardConfusionText:
	text_far _ViridianBlackboardConfusionText
	text_end
