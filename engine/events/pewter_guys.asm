; Appends the pre-steps of the player's cell, from the table of the guy in wWhichPewterGuy, to the
; simulated joypad list (over its last byte). Each table ends in -1: a cell with no row appends
; nothing and returns carry; after a match the carry is clear.
PewterGuys:
	ld hl, wSimulatedJoypadStatesEnd
	ld a, [wSimulatedJoypadStatesIndex]
	dec a ; this decrement causes it to overwrite the last byte before $FF in the list
	ld [wSimulatedJoypadStatesIndex], a
	ld d, 0
	ld e, a
	add hl, de
	ld d, h
	ld e, l
	ld hl, PewterGuysCoordsTable
	ld a, [wWhichPewterGuy]
	add a
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
.findMatchingCoordsLoop
	ld a, [hli]
	cp -1
	jr z, .noMatch
	cp b
	jr nz, .nextEntry1
	ld a, [hli]
	cp c
	jr nz, .nextEntry2
	ld a, [hli]
	ld h, [hl]
	ld l, a
.copyMovementDataLoop
	ld a, [hli]
	cp $ff
	ret z
	ld [de], a
	inc de
	ld a, [wSimulatedJoypadStatesIndex]
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	jr .copyMovementDataLoop
.nextEntry1
	inc hl
.nextEntry2
	inc hl
	inc hl
	jr .findMatchingCoordsLoop
.noMatch
	scf
	ret

PewterGuysCoordsTable:
	dw PewterMuseumGuyCoords
	dw PewterGymGuyCoords

; y, x of the cells the museum guy at (21,14) is talked to from: below, above and to his left (the
; cell to his right is a wall; data/maps/objects/PewterCity.asm). Each points to the steps that put
; the player one step behind him for the main walk, written in reverse (the list is played from
; its end).
PewterMuseumGuyCoords:
	db 15, 21
	dw .down
	db 13, 21
	dw .up
	db 14, 20
	dw .left
	db -1 ; end

.down
	db D_UP, D_UP, $ff
.up
	db D_RIGHT, D_LEFT, $ff
.left
	db D_UP, D_RIGHT, $ff

; y, x of the cells the gym guy at (35,16) is talked to from (west, south, east; north is a ledge)
; and of the four that send him while BROCK is unbeaten (PewterCityPlayerLeavingEastCoords), with
; the player's pre-steps as above; $00 is a pause
PewterGymGuyCoords:
	db 16, 34
	dw .one
	db 17, 35
	dw .two
	db 18, 37
	dw .three
	db 19, 37
	dw .four
	db 17, 36
	dw .five
	db 16, 36
	dw .six
	db -1 ; end

.one
	db D_LEFT, D_DOWN, D_DOWN, D_RIGHT, $ff
.two
	db D_LEFT, D_DOWN, D_RIGHT, D_LEFT, $ff
.three
	db D_LEFT, D_LEFT, D_LEFT, $00, $00, $00, $00, $00, $00, $00, $00, $ff
.four
	db D_LEFT, D_LEFT, D_UP, D_LEFT, $ff
.five
	db D_LEFT, D_DOWN, D_LEFT, $00, $00, $00, $00, $00, $00, $00, $00, $ff
.six
	db D_LEFT, D_DOWN, D_DOWN, D_LEFT, $ff
