; v0.7: the MOVE INFO card.
;
; One full screen describing a single move: its name, TYPE, whether it strikes
; with the body or with the mind, POWER, ACCURACY, PP, and what its effect does.
; Nothing in the game showed any of this before -- the FIGHT menu shows only
; TYPE and PP -- which matters here because a large share of the 219 moves are
; new or reworked and a player has no shared knowledge to fall back on.
;
; Reached from START on the battle FIGHT menu (see the .select block in
; MoveSelectionMenu, engine/battle/core.asm). It deliberately takes its move
; from wPlayerSelectedMove and reads nothing else battle-specific, so the
; ATTACKDEX can drive the very same routine later with no battle running.
;
; Clobbering the wPlayerMove* block is safe: ExecutePlayerMove calls
; GetCurrentMove (core.asm:3392) before a move is ever executed, so every field
; there is re-derived from wPlayerSelectedMove on the way to using it. That is
; also why the accuracy conversion below may write its result back over
; wPlayerMoveAccuracy instead of needing a WRAM byte of its own -- and WRAM has
; none to give, being full at 8192/8192.
;
; INPUT: wPlayerSelectedMove = move to display.

ShowMoveInfo::
	ld a, [wPlayerSelectedMove]
	and a
	ret z ; empty move slot: nothing to show

	xor a
	ldh [hAutoBGTransferEnabled], a

; Copy the move's row out of the move table. Same fetch GetCurrentMove does,
; repeated here rather than called because GetCurrentMove is bank-local to the
; Battle Core and this routine has to work from the overworld too.
	ld a, [wPlayerSelectedMove]
	ld [wd11e], a
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wPlayerMoveNum
	ld a, BANK(Moves)
	call FarCopyData

; Two boxes covering all 18 rows, so no ClearScreen is needed: the card on top,
; the effect description underneath.
;
; The card is five rows rather than six, and the type shares its row with the
; category, to buy the description a fifth line. `<NEXT>` moves down two rows
; (home/text.asm:64), so every row given back here is only half a line gained --
; which is why the "TYPE/" label had to go. The longest pairing is ELECTRIC
; PHYSICAL: 8 + 8 in an 18-wide interior, so it fits with two columns to spare.
	hlcoord 0, 0
	lb bc, 5, 18
	call TextBoxBorder
	hlcoord 0, 7
	lb bc, 9, 18
	call TextBoxBorder

; name
	call GetMoveName ; de = wcd6d
	hlcoord 1, 1
	call PlaceString

; type
	hlcoord 1, 2
	predef PrintMoveType

; PHYSICAL, SPECIAL or UTILITY.
;
; For a damaging move the split is decided entirely by the type id -- everything
; below SPECIAL uses ATTACK against DEFENSE (constants/type_constants.asm) -- so
; it costs no data of its own.
;
; A move that deals no damage has no meaningful side of that split, and saying
; GROWL is "PHYSICAL" because NORMAL happens to sit in the physical range is
; just false. Worse, it was inconsistent: DISABLE and HYPNOSIS would have read
; "SPECIAL" purely because they are PSYCHIC. A third category is the honest
; answer and it makes every non-damaging move agree with every other one.
;
; UTILITY, not STATUS, which is what a modern game would say. This game has
; already spent the word "status" on sleep/poison/burn/paralysis/freeze: FULL
; RESTORE "restores HP and status", FULL HEAL "eliminates all status problems",
; and the Trainer School blackboard teaches exactly those six under that name.
; Only 16 of the 66 moves in this bucket inflict any of them -- 36 just move
; stats and 14 are neither -- so reusing the word here would contradict the
; lesson the game itself gives.
;
; "Deals no damage" is decided by the effect, not by power alone: NIGHT_SHADE
; is written with power 0 and still takes HP off. SUPER_FANG and the other
; fixed-damage moves carry power 1, so they fall out of the first test anyway.
	ld a, [wPlayerMovePower]
	and a
	jr nz, .damaging
	ld a, [wPlayerMoveEffect]
	cp SPECIAL_DAMAGE_EFFECT ; NIGHT_SHADE, SEISMIC TOSS, DRAGON RAGE...
	jr z, .damaging
	cp SUPER_FANG_EFFECT
	jr z, .damaging
	cp OHKO_EFFECT
	jr z, .damaging
	ld de, MoveInfoUtilityText
	jr .gotCategory
.damaging
	ld a, [wPlayerMoveType]
	cp SPECIAL
	ld de, MoveInfoPhysicalText
	jr c, .gotCategory
	ld de, MoveInfoSpecialText
.gotCategory
	hlcoord 11, 2 ; alongside the type, not under it
	call PlaceString

; POWER
	hlcoord 1, 3
	ld de, MoveInfoPowerText
	call PlaceString
	ld a, [wPlayerMovePower]
	and a
	jr z, .noPower
	hlcoord 11, 3
	ld de, wPlayerMovePower
	lb bc, 1, 3
	call PrintNumber
	jr .accuracy
.noPower
	hlcoord 13, 3
	ld de, MoveInfoDashText
	call PlaceString

.accuracy
	hlcoord 1, 4
	ld de, MoveInfoAccuracyText
	call PlaceString
; Accuracy is stored pre-scaled by the `percent` macro (`* $ff / 100`), so a
; move written as 100 is $FF in the ROM and has to be converted back for
; display. Seeding the sum with 255 makes the /256 round instead of truncate.
; Checked at the edges: $FF -> 100, 229 -> 90.
	ld a, [wPlayerMoveAccuracy]
	ld c, a
	ld b, 0
	ld hl, 255
	ld a, 100
	call AddNTimes ; hl = 255 + 100 * accuracy
	ld a, h        ; = the same divided by 256
	ld [wPlayerMoveAccuracy], a ; safe to clobber -- see the header comment
	hlcoord 11, 4
	ld de, wPlayerMoveAccuracy
	lb bc, 1, 3
	call PrintNumber


; PP. This is the move's own PP out of the table, not this Pokemon's current
; total, because the same card has to make sense in the ATTACKDEX where there
; is no Pokemon in front of it.
	hlcoord 1, 5
	ld de, MoveInfoPPText
	call PlaceString
	hlcoord 11, 5
	ld de, wPlayerMoveMaxPP
	lb bc, 1, 3
	call PrintNumber

; The effect description, printed SINGLE-SPACED.
;
; hUILayoutFlags bit 2 makes <NEXT> advance one row instead of two
; (home/text.asm:65-68). It costs nothing -- the engine already supports it and
; MoveSelectionMenu already uses it to list four move names on four consecutive
; rows. Double spacing would give this box 5 lines; single spacing gives 9,
; which is the difference between a caption and a description.
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	ldh a, [hUILayoutFlags]
	set 2, a
	ldh [hUILayoutFlags], a

; The flavour paragraph first, if this move has one, then the mechanics under
; it. Two prints rather than one combined block, so the 219 flavour entries can
; each be unique while the mechanics stay shared across the moves that behave
; alike -- repeating "Lowers the foe's SPEED one step." word for word is what
; makes that rule learnable.
;
; The row the mechanics start on comes from a stored line count rather than from
; wherever the first print happened to stop. It is one byte per move and it
; means the layout is decided by the data, not discovered at runtime.
	ld a, [wPlayerMoveNum]
	dec a
	ld c, a
	ld b, 0
	ld hl, MoveFlavorLines
	add hl, bc
	ld a, [hl]
	and a
	jr z, .noFlavor ; moves with nothing to say drop straight to the mechanics
	push af
	ld hl, MoveFlavorPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	bccoord 1, 8
	call TextCommandProcessor
	pop af

; A move with flavour and no effect worth naming stops here. Otherwise TACKLE
; reads "The user throws itself bodily at the foe. Nothing more to it." and then
; immediately "A straight attack with no added effect." -- the same sentence
; twice. The high-crit and first-strike moves share NO_ADDITIONAL_EFFECT but
; carry a per-move override, and those DO have something to add, so the test is
; on the resolved text and not on the effect id.
	push af
	call GetMoveDescription
	ld a, h
	cp HIGH(MoveDesc_NoAdditionalEffect)
	jr nz, .keepMechanics
	ld a, l
	cp LOW(MoveDesc_NoAdditionalEffect)
	jr z, .flavorIsEnough
.keepMechanics
	pop af
	inc a ; a blank row between the two, now that there is room for one
	jr .gotDescriptionRow
.flavorIsEnough
	pop af
	jr .doneDescription
.noFlavor
	xor a
.gotDescriptionRow
; a = rows to drop below row 8; turn that into a tilemap offset
	ld hl, 0
	ld de, SCREEN_WIDTH
	and a
	jr z, .gotRowOffset
.rowLoop
	add hl, de
	dec a
	jr nz, .rowLoop
.gotRowOffset
	push hl
	call GetMoveDescription ; hl = text pointer
	pop de                  ; de = the offset worked out above
	push hl
	bccoord 1, 8
	ld h, b
	ld l, c
	add hl, de
	ld b, h
	ld c, l
	pop hl
	call TextCommandProcessor
.doneDescription

	ldh a, [hUILayoutFlags]
	res 2, a
	ldh [hUILayoutFlags], a
	xor a
	ldh [hClearLetterPrintingDelayFlags], a

	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3

; Read hJoyHeld directly rather than going through JoypadLowSensitivity, and
; bracket the wait with two release loops. This is the Pokedex's
; .waitForButtonPressLetGo pattern (pokedex.asm:932), not its plainer
; .waitForButtonPress one, for a specific reason:
;
; the caller returns straight into MoveSelectionMenu's HandleMenuInput. If we
; returned while A was still down, that same press would be read again as a
; menu selection and the player would fire the move they were only reading
; about. That is the phantom-selection bug this project has already had four
; times, most recently on the Celadon information desk.
.waitForRelease
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr nz, .waitForRelease
.waitForPress
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr z, .waitForPress
.waitForDismissRelease
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr nz, .waitForDismissRelease
	ret

; Resolve the description for the move in wPlayerMoveNum.
; Per-move overrides win; otherwise the move's effect decides, which is what
; keeps this affordable -- 219 moves share 83 effects.
; OUTPUT: hl = text pointer.
GetMoveDescription:
	ld a, [wPlayerMoveNum]
	ld b, a
	ld hl, MoveDescriptionOverrides
.overrideLoop
	ld a, [hli]
	cp -1
	jr z, .byEffect
	cp b
	jr z, .foundOverride
	inc hl ; skip the pointer
	inc hl
	jr .overrideLoop
.foundOverride
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
.byEffect
	ld a, [wPlayerMoveEffect]
	add a ; two bytes per entry; NUM_MOVE_EFFECTS is 98, so this cannot carry
	ld c, a
	ld b, 0
	ld hl, MoveEffectDescriptions
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

MoveInfoPhysicalText:
	db "PHYSICAL@"

MoveInfoSpecialText:
	db "SPECIAL@"

MoveInfoUtilityText:
	db "UTILITY@"

MoveInfoPowerText:
	db "POWER@"

MoveInfoAccuracyText:
	db "ACCURACY@"

MoveInfoPPText:
	db "PP@"

MoveInfoDashText:
	db "-@"

INCLUDE "data/moves/descriptions.asm"
INCLUDE "data/moves/flavor.asm"
