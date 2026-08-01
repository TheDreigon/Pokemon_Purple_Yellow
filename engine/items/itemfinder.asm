HiddenItemNear:
	ld hl, HiddenItemCoords
	ld b, 0
.loop
	ld de, 3
	ld a, [wCurMap]
	call IsInRestOfArray
	ret nc ; return if current map has no hidden items
	push bc
	push hl
	ld hl, wObtainedHiddenItemsFlags
	ld c, b
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	pop hl
	pop bc
	inc b
	and a
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	jr nz, .loop ; if the item has already been obtained
; v0.7: detection box is 11x11 centered on the player (+-5 both axes; was
; vanilla's off-center -4/+4 by -4/+5). The lower-bound checks are strict
; (item coord must EXCEED player coord minus 6), hence sub 6 for a -5 reach.
	ld a, [wYCoord]
	call Sub6ClampTo0
	cp d
	jr nc, .loop
	ld a, [wYCoord]
	add 5
	cp d
	jr c, .loop
	ld a, [wXCoord]
	call Sub6ClampTo0
	cp e
	jr nc, .loop
	ld a, [wXCoord]
	add 5
	cp e
	jr c, .loop
	scf
	ret

Sub6ClampTo0:
; subtract 6 but clamp to 0
	sub 6
	cp $f0
	ret c
	xor a
	ret
