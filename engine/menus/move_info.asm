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
	hlcoord 0, 0
	lb bc, 6, 18
	call TextBoxBorder
	hlcoord 0, 8
	lb bc, 8, 18
	call TextBoxBorder

; name
	call GetMoveName ; de = wcd6d
	hlcoord 1, 1
	call PlaceString

; TYPE/<type>
	hlcoord 1, 2
	ld de, MoveInfoTypeText
	call PlaceString
	hlcoord 6, 2
	predef PrintMoveType

; PHYSICAL, SPECIAL or STATUS.
;
; For a damaging move the split is decided entirely by the type id -- everything
; below SPECIAL uses ATTACK against DEFENSE (constants/type_constants.asm) -- so
; it costs no data of its own.
;
; A move that deals no damage has no meaningful side of that split, and saying
; GROWL is "PHYSICAL" because NORMAL happens to sit in the physical range is
; just false. Worse, it was inconsistent: DISABLE and HYPNOSIS would have read
; "SPECIAL" purely because they are PSYCHIC. STATUS is the honest third answer
; and it makes every non-damaging move agree with every other one.
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
	ld de, MoveInfoStatusText
	jr .gotCategory
.damaging
	ld a, [wPlayerMoveType]
	cp SPECIAL
	ld de, MoveInfoPhysicalText
	jr c, .gotCategory
	ld de, MoveInfoSpecialText
.gotCategory
	hlcoord 1, 3
	call PlaceString

; POWER
	hlcoord 1, 4
	ld de, MoveInfoPowerText
	call PlaceString
	ld a, [wPlayerMovePower]
	and a
	jr z, .noPower
	hlcoord 11, 4
	ld de, wPlayerMovePower
	lb bc, 1, 3
	call PrintNumber
	jr .accuracy
.noPower
	hlcoord 13, 4
	ld de, MoveInfoDashText
	call PlaceString

.accuracy
	hlcoord 1, 5
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
	hlcoord 11, 5
	ld de, wPlayerMoveAccuracy
	lb bc, 1, 3
	call PrintNumber


; PP. This is the move's own PP out of the table, not this Pokemon's current
; total, because the same card has to make sense in the ATTACKDEX where there
; is no Pokemon in front of it.
	hlcoord 1, 6
	ld de, MoveInfoPPText
	call PlaceString
	hlcoord 11, 6
	ld de, wPlayerMoveMaxPP
	lb bc, 1, 3
	call PrintNumber

; the effect description
	call GetMoveDescription ; hl = text pointer
	bccoord 1, 9
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	call TextCommandProcessor
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

MoveInfoTypeText:
	db "TYPE/@"

MoveInfoPhysicalText:
	db "PHYSICAL@"

MoveInfoSpecialText:
	db "SPECIAL@"

MoveInfoStatusText:
	db "STATUS@"

MoveInfoPowerText:
	db "POWER@"

MoveInfoAccuracyText:
	db "ACCURACY@"

MoveInfoPPText:
	db "PP@"

MoveInfoDashText:
	db "-@"

INCLUDE "data/moves/descriptions.asm"
