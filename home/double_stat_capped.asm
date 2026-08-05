; Reflect and Light Screen double a stat, and vanilla never checked the result
; against MAX_STAT_VALUE. The comment that used to sit in the middle of this
; routine said so out loud: "weird things will happen during stats scaling if a
; Pokemon with 512 or more Defense has used Reflect". 512 is reachable -- the
; ceiling on a stat is 999 -- so it is a live overflow rather than a curiosity,
; and doubling past 999 pushes the value into a range the damage scaling below
; is not written for.
;
; Doubles bc and clamps it. Trashes a, which every caller reloads immediately.
DoubleStatCapped::
	sla c
	rl b
; 16-bit compare of bc against MAX_STAT_VALUE + 1, by subtraction: carry means
; bc is below it and needs no clamping. Done this way rather than as two byte
; compares because Battle Core had one byte of room left.
	ld a, c
	sub LOW(MAX_STAT_VALUE + 1)
	ld a, b
	sbc HIGH(MAX_STAT_VALUE + 1)
	ret c
	ld bc, MAX_STAT_VALUE
	ret
