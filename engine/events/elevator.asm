DisplayElevatorFloorMenu:
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wPrintItemPrices], a
.menuLoop
	ld hl, wd730
	ld a, [hl]
	push af
	set 6, [hl]
	ld hl, WhichFloorText
	call PrintText
	pop af
	ld [wd730], a
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .done ; B: the car stays where it is
	ld hl, wElevatorWarpMaps
	ld a, [wWhichPokemon]
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
; v1.0 (2026-09-24, Forte): the door's warp already points at the floor the
; car is on (the map-load callback copies wWarpedFromWhichMap into it and
; every ride rewrites it below), so its destination map IS the current floor.
; Picking it again says so and reopens the list (cursor kept) instead of
; shaking the car for nothing.
	ld a, [wWarpEntries + 3] ; destination map of the door's first warp
	cp c
	jr z, .alreadyOnThisFloor
	ld hl, wCurrentMapScriptFlags
	set 7, [hl]
	ld hl, wWarpEntries
	call .UpdateWarp
	call .UpdateWarp
.done
	pop af
	ld [wListScrollOffset], a
	ret

.alreadyOnThisFloor
	ld hl, ElevatorSameFloorText
	call PrintText
	jr .menuLoop

.UpdateWarp
	inc hl
	inc hl
	ld a, b
	ld [hli], a ; destination warp ID
	ld a, c
	ld [hli], a ; destination map ID
	ret

WhichFloorText:
	text_far _WhichFloorText
	text_end

ElevatorSameFloorText:
	text_far _ElevatorSameFloorText
	text_end
