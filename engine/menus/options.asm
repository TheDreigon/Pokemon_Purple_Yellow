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
; the row went with it. v1.0: slot 4 is BIKE MUSIC, drawn and selectable only
; once the BICYCLE is owned; the cursor steps SOUND (3) -> BIKE MUSIC (4) ->
; CANCEL (7), or straight 3 -> 7 while the row is hidden. 5-6 stay unreachable.
; See OptionsControl below.
OptionMenuJumpTable:
	dw OptionsMenu_TextSpeed
	dw OptionsMenu_BattleAnimations
	dw OptionsMenu_BattleStyle
	dw OptionsMenu_SpeakerSettings
	dw OptionsMenu_BikeMusic ; v1.0: row 10, drawn only once the BICYCLE is owned
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
	cp 3 ; the last entry (SLOW) wraps to INSTANT
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
	ld c, 4 ; INSTANT wraps to SLOW
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
	dw InstantText
	dw FastText
	dw MidText
	dw SlowText

; 5 cells at (14,2): the box border is column 19, so "INSTANT" does not fit ("INSTA", Forte 2026-09-24).
InstantText:
	db "INSTA@"
FastText:
	db "FAST @"
MidText:
	db "MID  @"
SlowText:
	db "SLOW @"

; c = entry index (0 INSTANT, 1 FAST, 2 MID, 3 SLOW); d = the value to the LEFT,
; e = the value to the RIGHT (OptionsMenu_TextSpeed saves d on LEFT, e on RIGHT).
GetTextSpeed:
	ld a, [wOptions]
	and $f
	jr z, .instantTextOption
	cp TEXT_DELAY_SLOW
	jr z, .slowTextOption
	cp TEXT_DELAY_FAST
	jr z, .fastTextOption
; mid text option
	ld c, 2
	lb de, TEXT_DELAY_FAST, TEXT_DELAY_SLOW
	ret
.slowTextOption
	ld c, 3
	lb de, TEXT_DELAY_MEDIUM, TEXT_DELAY_INSTANT
	ret
.fastTextOption
	ld c, 1
	lb de, TEXT_DELAY_INSTANT, TEXT_DELAY_MEDIUM
	ret
.instantTextOption
	ld c, 0
	lb de, TEXT_DELAY_SLOW, TEXT_DELAY_FAST
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
	; v0.7 fix: the lock only means anything inside a running game. From
	; the title screen (wOptionsShowDifficulty = 0) LoadSAV has already
	; copied the OLD save's wDifficulty into WRAM, the forced bit survived
	; PrepareOakSpeech's push/pop of wOptions, and a NEW normal-mode game
	; started with BATTLE STYLE silently forced to SET. Same guard as the
	; DIFFICULTY row below.
	ld a, [wOptionsShowDifficulty]
	and a ; opened from the title screen?
	jr z, .styleIsSelectable
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

; v1.0 (2026-09-24): BIKE MUSIC, jump-table slot 4 = screen row 10 (PRINT's old
; row). Drawn and selectable only inside a running game (same guard as the
; DIFFICULTY row) and only once the BIKE SHOP has handed over the BICYCLE
; (EVENT_GOT_BICYCLE, never cleared). YES = the bike theme whenever you ride
; (vanilla). NO = only on the Cycling Road; everywhere else the map's own
; music keeps playing, and mounting or dismounting leaves it alone.
OptionsMenu_BikeMusic:
	call OptionsMenu_IsBikeRowShown
	jr z, OptionsMenu_Dummy ; hidden: nothing to draw, nothing to toggle
	ldh a, [hJoy5]
	and D_RIGHT | D_LEFT
	jr z, .draw
	ld a, [wOptions2]
	xor 1 << BIT_BIKE_MUSIC_ROAD_ONLY
	ld [wOptions2], a
; Apply it now. The menu only opens from the START menu, so the map's music is
; playing under it. PlayDefaultMusicCommon with no fade (c = d = 0) and
; wLastMusicSoundID left alone swaps the track only if the new rule picks a
; different one; PlayDefaultMusic itself zeroes wLastMusicSoundID first and
; would restart whatever it lands on.
	xor a
	ld c, a
	ld d, a
	call PlayDefaultMusicCommon
.draw
	ld a, [wOptions2]
	and 1 << BIT_BIKE_MUSIC_ROAD_ONLY ; bit 0: 0 = YES, 1 = NO
	ld c, a
	ld b, 0
	ld hl, BikeMusicOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 10
	call PlaceString
	and a
	ret

BikeMusicOptionStringsPointerTable:
	dw BikeMusicYesText
	dw BikeMusicNoText

BikeMusicYesText:
	db "YES@"
BikeMusicNoText:
	db "NO @"

; nz = the BIKE MUSIC row exists (running game, BICYCLE owned). Keeps hl and b:
; OptionsControl holds the cursor pointer in hl across it.
OptionsMenu_IsBikeRowShown:
	ld a, [wOptionsShowDifficulty]
	and a
	ret z
	CheckEvent EVENT_GOT_BICYCLE
	ret

; a = the last selectable setting: 3 (SOUND) or 4 (BIKE MUSIC). Keeps hl.
OptionsMenu_LastSetting:
	call OptionsMenu_IsBikeRowShown
	ld a, 3
	ret z
	inc a
	ret

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
	ld b, a
	call OptionsMenu_LastSetting ; a = 3 (SOUND), or 4 with the BIKE MUSIC row (v1.0)
	cp b ; already on it?
	jr nz, .regularIncrement
	ld [hl], $6 ; 6 + 1 = CANCEL
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp $7
	jr nz, .doNotJumpToLastSetting
	call OptionsMenu_LastSetting
	ld [hl], a
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
; v0.7 put DIFFICULTY on row 11 (two rows under SOUND once PRINT left row 10).
; v1.0: the BIKE MUSIC label takes row 10 once the BICYCLE is owned, and the
; read-only DIFFICULTY row moves from 11 to 13 so it keeps its two blank rows
; under the last setting. hlcoord is a bare `ld hl`: the flags survive it.
	call OptionsMenu_IsBikeRowShown
	hlcoord 2, 11
	jr z, .difficultyRow
	hlcoord 2, 10
	ld de, OptionMenuBikeMusicText
	call PlaceString
	hlcoord 2, 13
.difficultyRow
	ld de, OptionMenuDifficultyText
	call PlaceString ; hl comes back unchanged (PlaceString pushes it)
	ld de, 11
	add hl, de ; column 13, same row
	ld a, [wDifficulty]
	and a ; NORMAL_MODE == 0?
	ld de, OptionDifficultyNormalText
	jr z, .gotDifficultyValue
	ld de, OptionDifficultyHardText
.gotDifficultyValue
	call PlaceString
.skipDifficultyRow
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through (BIKE MUSIC draws nothing while hidden)
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
OptionMenuBikeMusicText:
	db "BIKE MUSIC :@"
OptionDifficultyNormalText:
	db "NORMAL@"
OptionDifficultyHardText:
	db "HARD@"
