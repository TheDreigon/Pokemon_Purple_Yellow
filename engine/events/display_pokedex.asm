_DisplayPokedex::
; v0.7: say which page we want, instead of inheriting one.
;
; ShowPokedexDataInternal picks its page from wMoveListCounter and treats every
; value except 1 (and now 2) as the description page. This caller never wrote
; the byte, so it took whatever was left there - and PrepareLevelUpMoveList
; parks a MOVE COUNT in it. A player who had opened MOVE on a mon with exactly
; one level-up move would get the move page from a signpost the next time one
; showed him a POKeMON. Latent before #24 added a second mode; a plain bug now.
	xor a
	ld [wMoveListCounter], a
	ld hl, wd730
	set 6, [hl]
	predef ShowPokedexData
	ld hl, wd730
	res 6, [hl]
	call ReloadMapData
	ld c, 10
	call DelayFrames
	predef IndexToPokedex
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_SET
	ld hl, wPokedexSeen
	predef FlagActionPredef
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret
