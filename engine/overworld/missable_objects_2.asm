; v1.0 (T23, 2026-09-24): the SECOND hide/show table.
;
; MissableObjects (bank3) is 256/256. Rather than widen the one-byte index that
; runs through wMissableObjectIndex, the per-map list and the predefs, this is
; a parallel table with its own 128-bit flag array (wMissableObjectFlags2) and
; its own constants (HS2_*). The vanilla path is untouched; the join is the
; per-map list: LoadMissableObjects2 appends this table's rows for the current
; map to wMissableObjectList with bit 7 of the sprite-id byte SET (sprite ids
; are 1-14, the bit is free) and IsObjectHidden picks the flag array by that
; bit. No MapHSPointers2: the table is scanned whole on every map load (at
; most 128 rows), so rows can be appended in any order and a map may have
; rows in both tables -- but one object lives in exactly one of them.
; Lives in its own pinned section (layout.link, ROMX $10): bank3 has ~500 B
; left. Flag ops go through predef FlagActionPredef, which is how a routine
; outside bank3 reaches FlagAction.

; Appends the current map's second-table missables to wMissableObjectList.
; Called by MarkTownVisitedAndLoadMissableObjects (bank3) right after it wrote
; table 1's entries and the sentinel; the sentinel is rewritten at the new end.
LoadMissableObjects2::
	ld hl, wMissableObjectList
.findEnd
	ld a, [hli]
	cp -1
	jr nz, .findEnd
	dec hl                     ; the sentinel table 1 wrote: overwrite it
	ld d, h
	ld e, l
	ld a, [wCurMap]
	ld b, a
	ld c, 0                    ; running HS2_* index
	ld hl, MissableObjects2
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	cp b
	jr nz, .skip
	ld a, [hli]                ; map-local object id (1-14)
	set 7, a                   ; tag: the index is into wMissableObjectFlags2
	ld [de], a
	inc de
	ld a, c
	ld [de], a                 ; HS2_* index
	inc de
	inc hl                     ; HIDE/SHOW byte
	inc c
	jr .loop
.skip
	inc hl
	inc hl
	inc c
	jr .loop
.done
	ld a, -1
	ld [de], a                 ; new sentinel
	ret

; New game: clear wMissableObjectFlags2 and set the bit of every HIDE row.
; Called by InitializeMissableObjectsFlags (bank3) when it reaches the end of
; table 1.
InitializeMissableObjectsFlags2::
	ld hl, wMissableObjectFlags2
	ld bc, wMissableObjectFlags2End - wMissableObjectFlags2
	xor a
	call FillMemory
	ld hl, MissableObjects2
	ld c, 0                    ; running HS2_* index
.loop
	ld a, [hli]
	cp -1
	ret z
	inc hl                     ; object id
	ld a, [hli]
	cp HIDE
	jr nz, .next
	push hl
	push bc
	ld hl, wMissableObjectFlags2
	ld b, FLAG_SET
	predef FlagActionPredef    ; set bit c of [hl]
	pop bc
	pop hl
.next
	inc c
	jr .loop

; [wMissableObjectIndex] = HS2_* index. Farcall targets for scripts: the
; second-table twins of predef ShowObject / HideObject. (ShowObject2 is taken:
; it is vanilla's predef alias of ShowObject, data/predef_pointers.asm.)
ShowObject_HS2::
	ld b, FLAG_RESET
	jr HideShowObject_HS2
HideObject_HS2::
	ld b, FLAG_SET
HideShowObject_HS2:
	ld a, [wMissableObjectIndex]
	ld c, a
	ld hl, wMissableObjectFlags2
	predef FlagActionPredef
	jp UpdateSprites

; Hides the missable that map-local sprite a (1-14) maps to, whichever table
; it is in; nothing happens if the sprite is not in the list. The two dynamic
; hiders (PickUpItem, the trainer-header static mons in home/trainers.asm) come
; through here because they know a sprite, not an HS_ constant. (Vanilla's
; trainers.asm used IsInArray and, on a miss, hid whatever index sat after the
; sentinel - that latent closes here.)
HideObjectBySpriteIndex::
	ld b, a
	ld hl, wMissableObjectList
.loop
	ld a, [hli]
	cp -1
	ret z
	ld c, a                    ; raw byte: bit 7 = second table
	and $7f
	cp b
	ld a, [hli]                ; the index
	jr nz, .loop
	ld [wMissableObjectIndex], a
	bit 7, c
	jr nz, HideObject_HS2
	predef_jump HideObject
