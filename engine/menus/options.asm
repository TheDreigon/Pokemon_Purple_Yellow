DisplayOptionMenu_:
	call InitOptionsMenu
.optionMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitOptionMenu
	call OptionsControl
	jr c, .dpadDelay
	call GetOptionPointer
	jr c, .exitOptionMenu
.dpadDelay
	call OptionsMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .optionMenuLoop
.exitOptionMenu
	ret

GetOptionPointer:
	ld a, [wOptionsCursorLocation]
	ld e, a
	ld d, $0
	ld hl, OptionMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted option

; v0.7: entry 4 was PRINT (Game Boy Printer darkness). The printer is gone, so
; the row is gone with it; the cursor now steps straight from SOUND (3) to
; CANCEL (7) and 4-6 are unreachable. See OptionsControl below.
OptionMenuJumpTable:
	dw OptionsMenu_TextSpeed
	dw OptionsMenu_BattleAnimations
	dw OptionsMenu_BattleStyle
	dw OptionsMenu_SpeakerSettings
	dw OptionsMenu_Dummy
	dw OptionsMenu_Dummy
	dw OptionsMenu_Dummy
	dw OptionsMenu_Cancel

OptionsMenu_TextSpeed:
	call GetTextSpeed
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $2
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, $3
.decrease
	dec c
	ld a, d
.save
	ld b, a
	ld a, [wOptions]
	and $f0
	or b
	ld [wOptions], a
.nonePressed
	ld b, $0
	ld hl, TextSpeedStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 2
	call PlaceString
	and a
	ret

TextSpeedStringsPointerTable:
	dw FastText
	dw MidText
	dw SlowText

FastText:
	db "FAST@"
MidText:
	db "MID @"
SlowText:
	db "SLOW@"

GetTextSpeed:
	ld a, [wOptions]
	and $f
	cp $5
	jr z, .slowTextOption
	cp $1
	jr z, .fastTextOption
; mid text option
	ld c, $1
	lb de, 1, 5
	ret
.slowTextOption
	ld c, $2
	lb de, 3, 1
	ret
.fastTextOption
	ld c, $0
	lb de, 5, 3
	ret

OptionsMenu_BattleAnimations:
	ldh a, [hJoy5]
	and D_RIGHT | D_LEFT
	jr nz, .asm_41d33
	ld a, [wOptions]
	and $80 ; mask other bits
	jr .asm_41d3b
.asm_41d33
	ld a, [wOptions]
	xor $80
	ld [wOptions], a
.asm_41d3b
	ld bc, $0
	sla a
	rl c
	ld hl, AnimationOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 4
	call PlaceString
	and a
	ret

AnimationOptionStringsPointerTable:
	dw AnimationOnText
	dw AnimationOffText

AnimationOnText:
	db "ON @"
AnimationOffText:
	db "OFF@"

OptionsMenu_BattleStyle:
; v0.7: Hard mode is always SET, and the menu now says so instead of lying.
; The switch prompt is skipped outright for a hard-mode battle (core.asm,
; just before .DontForceSetMode), so the player could flip this row to SHIFT
; and watch nothing change - the option read as broken rather than as locked.
; Now the bit is forced on and left/right are ignored while Hard mode is
; active, so the row shows SET and stays there. Normal mode is untouched.
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jr z, .styleIsSelectable
	ld a, [wOptions]
	set BIT_BATTLE_SHIFT, a ; bit set = SET (see the string table below)
	ld [wOptions], a
	jr .asm_41d73
.styleIsSelectable
	ldh a, [hJoy5]
	and D_LEFT | D_RIGHT
	jr nz, .asm_41d6b
	ld a, [wOptions]
	and $40 ; mask other bits
	jr .asm_41d73
.asm_41d6b
	ld a, [wOptions]
	xor $40
	ld [wOptions], a
.asm_41d73
	ld bc, $0
	sla a
	sla a
	rl c
	ld hl, BattleStyleOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 6
	call PlaceString
	and a
	ret

BattleStyleOptionStringsPointerTable:
	dw BattleStyleShiftText
	dw BattleStyleSetText

BattleStyleShiftText:
	db "SHIFT@"
BattleStyleSetText:
	db "SET  @"

OptionsMenu_SpeakerSettings:
	ld a, [wOptions]
	and $30
	swap a
	ld c, a
	ldh a, [hJoy5]
	bit 4, a
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .asm_41dca
.pressedRight
	ld a, c
	inc a
	and $3
	jr .asm_41dba
.pressedLeft
	ld a, c
	dec a
	and $3
.asm_41dba
	ld c, a
	swap a
	ld b, a
	xor a
	ldh [rNR51], a
	ld a, [wOptions]
	and $cf
	or b
	ld [wOptions], a
.asm_41dca
	ld b, $0
	ld hl, SpeakerOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 8
	call PlaceString
	and a
	ret

SpeakerOptionStringsPointerTable:
	dw MonoSoundText
	dw Earphone1SoundText
	dw Earphone2SoundText
	dw Earphone3SoundText

MonoSoundText:
	db "MONO     @"
Earphone1SoundText:
	db "EARPHONE1@"
Earphone2SoundText:
	db "EARPHONE2@"
Earphone3SoundText:
	db "EARPHONE3@"

OptionsMenu_Dummy:
	and a
	ret

OptionsMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

OptionsControl:
	ld hl, wOptionsCursorLocation
	ldh a, [hJoy5]
	cp D_DOWN
	jr z, .pressedDown
	cp D_UP
	jr z, .pressedUp
	and a
	ret
.pressedDown
	ld a, [hl]
	cp $7
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp $3 ; SOUND, the last selectable setting since PRINT was removed
	jr c, .regularIncrement
	ld [hl], $6
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp $7
	jr nz, .doNotJumpToLastSetting
	ld [hl], $3
	scf
	ret
.doNotJumpToLastSetting
	and a
	jr nz, .regularDecrement
	ld [hl], $8
.regularDecrement
	dec [hl]
	scf
	ret

OptionsMenu_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, 16
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, SCREEN_WIDTH * 2
	ld a, [wOptionsCursorLocation]
	call AddNTimes
	ld [hl], "▶"
	ret

InitOptionsMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, AllOptionsText
	call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	; v0.7: read-only difficulty indicator (informational; it is NOT in
	; OptionMenuJumpTable / the cursor path, so it can't be selected or
	; changed here). Drawn once; wDifficulty is fixed for the run.
	;
	; Skipped entirely on the title screen. wDifficulty lives inside the saved
	; block and CONTINUE copies the save into WRAM while its menu is still up,
	; so opening OPTION from the title used to report the OLD SAVE's difficulty
	; to a player who might be about to start a new game — and on a fresh
	; cartridge it asserted NORMAL before the choice existed at all. The value
	; is only really decided during Oak's speech.
	ld a, [wOptionsShowDifficulty]
	and a
	jr z, .skipDifficultyRow
	; v0.7: row 11, not 13. It sat three rows under the last setting when that
	; setting was PRINT on row 10; PRINT is gone, so it follows SOUND up.
	hlcoord 2, 11
	ld de, OptionMenuDifficultyText
	call PlaceString
	ld a, [wDifficulty]
	and a ; NORMAL_MODE == 0?
	ld de, OptionDifficultyNormalText
	jr z, .gotDifficultyValue
	ld de, OptionDifficultyHardText
.gotDifficultyValue
	hlcoord 13, 11
	call PlaceString
.skipDifficultyRow
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 4 ; the number of options to loop through
.loop
	push bc
	call GetOptionPointer ; updates the next option
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl] ; moves the cursor for the highlighted option
	dec c
	jr nz, .loop
	xor a
	ld [wOptionsCursorLocation], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret

AllOptionsText:
	db "TEXT SPEED :"
	next "ANIMATION  :"
	next "BATTLESTYLE:"
	next "SOUND:@"

OptionMenuCancelText:
	db "CANCEL@"

OptionMenuDifficultyText:
	db "DIFFICULTY:@"
OptionDifficultyNormalText:
	db "NORMAL@"
OptionDifficultyHardText:
	db "HARD@"
