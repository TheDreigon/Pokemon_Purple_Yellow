; This function is used to wait a short period after printing a letter to the
; screen unless the player presses the A/B button or the delay is turned off
; through the [wd730] or [wLetterPrintingDelayFlags] flags.
PrintLetterDelay::
	ld a, [wd730]
	bit 6, a
	ret nz
	ld a, [wLetterPrintingDelayFlags]
	bit BIT_TEXT_DELAY, a
	ret z
	push hl
	push de
	push bc
	ld a, [wLetterPrintingDelayFlags]
	bit BIT_FAST_TEXT_DELAY, a
	jr z, .waitOneFrame
	ld a, [wOptions]
	and $f
	; v1.0: TEXT_DELAY_INSTANT (0). Leave before the pad poll: the old path
	; reached .done with 0 too, but a held A/B took .endWait first and cost one
	; DelayFrame per letter, so "0" was slower with A held than without.
	jr z, .done
	ldh [hFrameCounter], a
	jr .checkButtons
.waitOneFrame
	ld a, 1
	ldh [hFrameCounter], a
.checkButtons
	call Joypad
	ldh a, [hJoyHeld]
.checkAButton
	bit BIT_A_BUTTON, a
	jr z, .checkBButton
	jr .endWait
.checkBButton
	bit BIT_B_BUTTON, a
	jr z, .buttonsNotPressed
.endWait
	call DelayFrame
	jr .done
.buttonsNotPressed ; if neither A nor B is pressed
	ldh a, [hFrameCounter]
	and a
	jr nz, .checkButtons
.done
	pop bc
	pop de
	pop hl
	ret
