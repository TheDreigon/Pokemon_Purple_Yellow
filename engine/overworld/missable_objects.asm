MarkTownVisitedAndLoadMissableObjects::
	ld a, [wCurMap]
	cp FIRST_ROUTE_MAP
	ld c, a ; a town's fly slot is its own map id (ld c, a leaves the flags alone)
	jr c, .mark
; v1.0 (2026-09-24): the two POKeMON CENTERs that stand on a route are fly
; destinations too, and they mark their slot the moment the player walks in --
; the same rule as a town (entering is what counts, not healing).
; BuildFlyLocationsList turns the slot back into the route the CENTER stands on.
	ld c, MT_MOON_FLY_SLOT
	cp MT_MOON_POKECENTER
	jr z, .mark
	ld c, ROCK_TUNNEL_FLY_SLOT
	cp ROCK_TUNNEL_POKECENTER
	jr nz, .notInTown
.mark
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag   ; mark town as visited (for flying)
	predef FlagActionPredef
; BILL's LAB is a fly destination that is NOT a city map, so it cannot mark
; itself here. ROUTE 25 marks its own slot, in its own map script -- see
; Route25ShowHideBillScript. Keeping the oddity in the map that owns it also
; keeps it out of this routine, which every map in the game runs.
.notInTown
	ld hl, MapHSPointers
	ld a, [wCurMap]
	ld b, $0
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]                ; load missable objects pointer in hl
	ld h, [hl]
	ld l, a
	push hl
	ld a, l
	sub LOW(MissableObjects)   ; calculate difference between out pointer and the base pointer
	ld l, a
	ld a, h
	sbc HIGH(MissableObjects)
	ld h, a
	ld a, h
	ldh [hDividend], a
	ld a, l
	ldh [hDividend+1], a
	xor a
	ldh [hDividend+2], a
	ldh [hDividend+3], a
	ld a, $3
	ldh [hDivisor], a
	ld b, $2
	call Divide                ; divide difference by 3, resulting in the global offset (number of missable items before ours)
	ld a, [wCurMap]
	ld b, a
	ldh a, [hDividend+3]
	ld c, a                    ; store global offset in c
	ld de, wMissableObjectList
	pop hl
.writeMissableObjectsListLoop
	ld a, [hli]
	cp -1
	jr z, .done     ; end of list
	cp b
	jr nz, .done    ; not for current map anymore
	ld a, [hli]
	inc hl
	ld [de], a                 ; write (map-local) sprite ID
	inc de
	ld a, c
	inc c
	ld [de], a                 ; write (global) missable object index
	inc de
	jr .writeMissableObjectsListLoop
.done
	ld a, -1
	ld [de], a                 ; write sentinel
	farcall LoadMissableObjects2 ; v1.0 (T23): this map's second-table rows, tagged; rewrites the sentinel
	ret

InitializeMissableObjectsFlags:
	ld hl, wMissableObjectFlags
	ld bc, wMissableObjectFlagsEnd - wMissableObjectFlags
	xor a
	call FillMemory ; clear missable objects flags
	ld hl, MissableObjects
	xor a
	ld [wMissableObjectCounter], a
.missableObjectsLoop
	ld a, [hli]
	cp -1           ; end of list
	jr z, .table2
	push hl
	inc hl
	ld a, [hl]
	cp HIDE
	jr nz, .skip
	ld hl, wMissableObjectFlags
	ld a, [wMissableObjectCounter]
	ld c, a
	ld b, FLAG_SET
	call MissableObjectFlagAction ; set flag if Item is hidden
.skip
	ld hl, wMissableObjectCounter
	inc [hl]
	pop hl
	inc hl
	inc hl
	jr .missableObjectsLoop
.table2
	farcall InitializeMissableObjectsFlags2 ; v1.0 (T23): the second table's HIDE defaults
	ret

; tests if current sprite is a missable object that is hidden/has been removed
IsObjectHidden:
	ldh a, [hCurrentSpriteOffset]
	swap a
	ld b, a
	ld hl, wMissableObjectList
.loop
	ld a, [hli]
	cp -1
	jr z, .notHidden ; not missable -> not hidden
	ld c, a          ; v1.0 (T23): raw byte, bit 7 = second table
	and $7f
	cp b
	ld a, [hli]
	jr nz, .loop
	ld hl, wMissableObjectFlags
	bit 7, c
	jr z, .table1
	ld hl, wMissableObjectFlags2
.table1
	ld c, a
	ld b, FLAG_TEST
	call MissableObjectFlagAction
	ld a, c
	and a
	jr nz, .hidden
.notHidden
	xor a
.hidden
	ldh [hIsHiddenMissableObject], a
	ret

; adds missable object (items, leg. pokemon, etc.) to the map
; [wMissableObjectIndex]: index of the missable object to be added (global index)
ShowObject:
ShowObject2:
	ld hl, wMissableObjectFlags
	ld a, [wMissableObjectIndex]
	ld c, a
	ld b, FLAG_RESET
	call MissableObjectFlagAction   ; reset "removed" flag
	jp UpdateSprites

; removes missable object (items, leg. pokemon, etc.) from the map
; [wMissableObjectIndex]: index of the missable object to be removed (global index)
HideObject:
	ld hl, wMissableObjectFlags
	ld a, [wMissableObjectIndex]
	ld c, a
	ld b, FLAG_SET
	call MissableObjectFlagAction   ; set "removed" flag
	jp UpdateSprites

MissableObjectFlagAction:
; identical to FlagAction

	push hl
	push de
	push bc

	; bit
	ld a, c
	ld d, a
	and 7
	ld e, a

	; byte
	ld a, d
	srl a
	srl a
	srl a
	add l
	ld l, a
	jr nc, .ok
	inc h
.ok

	; d = 1 << e (bitmask)
	inc e
	ld d, 1
.shift
	dec e
	jr z, .shifted
	sla d
	jr .shift
.shifted

	ld a, b
	and a
	jr z, .reset
	cp 2
	jr z, .read

.set
	ld a, [hl]
	ld b, a
	ld a, d
	or b
	ld [hl], a
	jr .done

.reset
	ld a, [hl]
	ld b, a
	ld a, d
	xor $ff
	and b
	ld [hl], a
	jr .done

.read
	ld a, [hl]
	ld b, a
	ld a, d
	and b

.done
	pop bc
	pop de
	pop hl
	ld c, a
	ret
