; uncompresses the front or back sprite of the specified mon
; assumes the corresponding mon header is already loaded
; hl contains offset to sprite pointer ($b for front or $d for back)
UncompressMonSprite::
	ld bc, wMonHeader
	add hl, bc
	ld a, [hli]
	ld [wSpriteInputPtr], a    ; fetch sprite input pointer
	ld a, [hl]
	ld [wSpriteInputPtr+1], a
; Which bank a mon's pics live in is stored in the mon itself: the spare byte at
; the end of its base-stats entry, copied into wMonHPicBank along with the rest of
; the header. Pics can therefore live in ANY section, and new sections in any bank
; that has room - which is what makes headroom for more species.
;
; This replaced a ladder of internal-index thresholds (index < TANGELA -> "Pics 1",
; and so on). Under that scheme which section a pic belonged to was decided by the
; mon's index rather than by where there was space, and a pic could only ever move
; to the ADJACENT section. It broke the build on 2026-08-09, the first time a
; sprite pass made a section overflow, and it could not have survived the jump to
; 200 species. Taken from ExtremeYellow, which added several dozen mons this way.
;
; The two fossils and the Ghost are the exception: they have no base-stats entry,
; so GetMonHeader never fills wMonHPicBank for them and it would still hold the
; last mon's value. Their indices are consecutive and their pics share a section,
; so a single range check covers all three. The ASSERTs keep both facts true.
	ASSERT FOSSIL_AERODACTYL == FOSSIL_KABUTOPS + 1
	ASSERT MON_GHOST == FOSSIL_KABUTOPS + 2
	ASSERT BANK(FossilAerodactylPic) == BANK(FossilKabutopsPic), \
	    "the three headerless pics must share a section"
	ASSERT BANK(GhostPic) == BANK(FossilKabutopsPic), \
	    "the three headerless pics must share a section"
	ld a, [wcf91]
	cp FOSSIL_KABUTOPS
	jr c, .fromHeader
	cp MON_GHOST + 1
	jr nc, .fromHeader
	ld a, BANK(FossilKabutopsPic)
	jr .GotBank
.fromHeader
	ld a, [wMonHPicBank]
.GotBank
	jp UncompressSpriteData

; de: destination location
LoadMonFrontSprite::
	push de
	ld hl, wMonHFrontSprite - wMonHeader
	call UncompressMonSprite
	ld hl, wMonHSpriteDim
	ld a, [hli]
	ld c, a
	pop de
	; fall through

; postprocesses uncompressed sprite chunks to a 2bpp sprite and loads it into video ram
; calculates alignment parameters to place both sprite chunks in the center of the 7*7 tile sprite buffers
; de: destination location
; a,c:  sprite dimensions (in tiles of 8x8 each)
LoadUncompressedSpriteData::
	push de
	and $f
	ldh [hSpriteWidth], a ; each byte contains 8 pixels (in 1bpp), so tiles=bytes for width
	ld b, a
	ld a, $7
	sub b      ; 7-w
	inc a      ; 8-w
	srl a      ; (8-w)/2     ; horizontal center (in tiles, rounded up)
	ld b, a
	add a
	add a
	add a
	sub b      ; 7*((8-w)/2) ; skip for horizontal center (in tiles)
	ldh [hSpriteOffset], a
	ld a, c
	swap a
	and $f
	ld b, a
	add a
	add a
	add a     ; 8*tiles is height in bytes
	ldh [hSpriteHeight], a
	ld a, $7
	sub b      ; 7-h         ; skip for vertical center (in tiles, relative to current column)
	ld b, a
	ldh a, [hSpriteOffset]
	add b     ; 7*((8-w)/2) + 7-h ; combined overall offset (in tiles)
	add a
	add a
	add a     ; 8*(7*((8-w)/2) + 7-h) ; combined overall offset (in bytes)
	ldh [hSpriteOffset], a
	ld a, $0
	call SwitchSRAMBankAndLatchClockData
	ld hl, sSpriteBuffer0
	call ZeroSpriteBuffer   ; zero buffer 0
	ld de, sSpriteBuffer1
	ld hl, sSpriteBuffer0
	call AlignSpriteDataCentered    ; copy and align buffer 1 to 0 (containing the MSB of the 2bpp sprite)
	ld hl, sSpriteBuffer1
	call ZeroSpriteBuffer   ; zero buffer 1
	ld de, sSpriteBuffer2
	ld hl, sSpriteBuffer1
	call AlignSpriteDataCentered    ; copy and align buffer 2 to 1 (containing the LSB of the 2bpp sprite)
	call PrepareRTCDataAndDisableSRAM
	pop de
	jp InterlaceMergeSpriteBuffers

; copies and aligns the sprite data properly inside the sprite buffer
; sprite buffers are 7*7 tiles in size, the loaded sprite is centered within this area
AlignSpriteDataCentered::
	ldh a, [hSpriteOffset]
	ld b, $0
	ld c, a
	add hl, bc
	ldh a, [hSpriteWidth]
.columnLoop
	push af
	push hl
	ldh a, [hSpriteHeight]
	ld c, a
.columnInnerLoop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .columnInnerLoop
	pop hl
	ld bc, 7*8    ; 7 tiles
	add hl, bc    ; advance one full column
	pop af
	dec a
	jr nz, .columnLoop
	ret

; fills the sprite buffer (pointed to in hl) with zeros
ZeroSpriteBuffer::
	ld bc, SPRITEBUFFERSIZE
.nextByteLoop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .nextByteLoop
	ret

; combines the (7*7 tiles, 1bpp) sprite chunks in buffer 0 and 1 into a 2bpp sprite located in buffer 1 through 2
; in the resulting sprite, the rows of the two source sprites are interlaced
; de: output address
InterlaceMergeSpriteBuffers::
	ld a, $0
	call SwitchSRAMBankAndLatchClockData
	push de
	ld hl, sSpriteBuffer2 + (SPRITEBUFFERSIZE - 1) ; destination: end of buffer 2
	ld de, sSpriteBuffer1 + (SPRITEBUFFERSIZE - 1) ; source 2: end of buffer 1
	ld bc, sSpriteBuffer0 + (SPRITEBUFFERSIZE - 1) ; source 1: end of buffer 0
	ld a, SPRITEBUFFERSIZE/2 ; $c4
	ldh [hSpriteInterlaceCounter], a
.interlaceLoop
	ld a, [de]
	dec de
	ld [hld], a   ; write byte of source 2
	ld a, [bc]
	dec bc
	ld [hld], a   ; write byte of source 1
	ld a, [de]
	dec de
	ld [hld], a   ; write byte of source 2
	ld a, [bc]
	dec bc
	ld [hld], a   ; write byte of source 1
	ldh a, [hSpriteInterlaceCounter]
	dec a
	ldh [hSpriteInterlaceCounter], a
	jr nz, .interlaceLoop
	ld a, [wSpriteFlipped]
	and a
	jr z, .notFlipped
	ld bc, 2*SPRITEBUFFERSIZE
	ld hl, sSpriteBuffer1
.swapLoop
	swap [hl]    ; if flipped swap nybbles in all bytes
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .swapLoop
.notFlipped
	pop hl
	ld de, sSpriteBuffer1
	ld c, (2*SPRITEBUFFERSIZE)/16 ; $31, number of 16 byte chunks to be copied
	ldh a, [hLoadedROMBank]
	ld b, a
	call CopyVideoData
	jp PrepareRTCDataAndDisableSRAM
