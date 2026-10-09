HandleLedges::
	ld a, [wd736]
	bit 6, a ; already jumping down ledge
	ret nz
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	ret nz
	predef GetTileAndCoordsInFrontOfPlayer
	ld a, [wSpritePlayerStateData1FacingDirection]
	ld b, a
	lda_coord 8, 9
	ld c, a
	ld a, [wTileInFrontOfPlayer]
	ld d, a
	ld hl, LedgeTiles
.loop
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jr nz, .nextLedgeTile1
	ld a, [hli]
	cp c
	jr nz, .nextLedgeTile2
	ld a, [hli]
	cp d
	jr nz, .nextLedgeTile3
	ld a, [hl]
	ld e, a
	jr .foundMatch
.nextLedgeTile1
	inc hl
.nextLedgeTile2
	inc hl
.nextLedgeTile3
	inc hl
	jr .loop
.foundMatch
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_DOWN
	lda_coord  8, 13
	jr z, .checkCollision
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_LEFT
	lda_coord  4,  9
	jr z, .checkCollision
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_RIGHT
	lda_coord 12,  9
	jr z, .checkCollision
.noCollisionTile
	ldh a, [hJoyHeld]
	and e
	ret z
	call LedgeLandingIsTaken ; v1.0 (R18a): never land on a person
	ret c
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld hl, wd736
	set 6, [hl] ; jumping down ledge
	call StartSimulatingJoypadStates
	ld a, e
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	ld a, $2
	ld [wSimulatedJoypadStatesIndex], a
	call LoadHoppingShadowOAM
	ld a, SFX_LEDGE
	call PlaySound
	ret

.checkCollision
	cp $00
	jr z, .noCollisionTile
	cp $10
	jr z, .noCollisionTile
	cp $20
	jr z, .noCollisionTile
	cp $21
	jr z, .noCollisionTile
	cp $23
	jr z, .noCollisionTile
	cp $2c
	jr z, .noCollisionTile
	cp $2e
	jr z, .noCollisionTile
	cp $30
	jr z, .noCollisionTile
	cp $39
	jr z, .noCollisionTile
	cp $3c
	jr z, .noCollisionTile
	cp $52
	jr z, .noCollisionTile
	cp $5b
	jr z, .noCollisionTile
	ret

; v1.0 (R18a, 2026-10-07): the guard above reads only the landing TILE (the
; ledge-into-a-tree check); this reads the map objects. Map coordinates, not
; screen pixels: TryWalking writes an NPC's destination into its MAPY/MAPX the
; frame it sets off, so an NPC walking INTO the landing cell is refused too - a
; screen-pixel test (IsSpriteInFrontOfPlayer2 with d = $20) only sees one that
; stands still. Only the wNumSprites map objects are read: the follower PIKACHU
; is slot 15, outside that count (no map has more than 14 objects), and walks
; behind anyway. An object hidden by hide/show keeps its coordinates, so
; IMAGEINDEX $ff (not drawn) is skipped: a picked-up item ball below a ledge must
; not wall it off. UpdateNPCSprite holds every ready NPC still while wd736 bit
; 6 is set, a random walker or one on a MoveSprite path (delayed, no step
; skipped), so nobody sets off into the cell between this check and the landing.
; Out: carry = a visible object stands on, or is walking into, the landing cell.
LedgeLandingIsTaken:
	ld a, [wYCoord]
	add 4 ; SPRITESTATEDATA2_MAPY/MAPX are map coordinates + 4
	ld d, a
	ld a, [wXCoord]
	add 4
	ld b, a ; not e: HandleLedges still needs the input mask in e
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_LEFT
	jr z, .left
	cp SPRITE_FACING_RIGHT
	jr z, .right
	inc d ; SPRITE_FACING_DOWN (LedgeTiles has no upward ledge)
	inc d
	jr .scan
.left
	dec b
	dec b
	jr .scan
.right
	inc b
	inc b
.scan
	ld a, [wNumSprites]
	and a
	ret z ; no objects: carry clear
	ld c, a
	ld hl, wSprite01StateData1ImageIndex
.loop
	ld a, [hl]
	inc a ; $ff = not drawn
	jr z, .next
	inc h ; wSpriteStateData2, same slot
	inc l
	inc l ; IMAGEINDEX (2) -> MAPY (4)
	ld a, [hli]
	cp d
	jr nz, .back
	ld a, [hl]
	cp b
	jr z, .taken
.back
	dec h
	ld a, l
	and $f0
	or SPRITESTATEDATA1_IMAGEINDEX
	ld l, a
.next
	ld a, l
	add $10
	ld l, a
	dec c
	jr nz, .loop
	and a
	ret
.taken
	scf
	ret

INCLUDE "data/tilesets/ledge_tiles.asm"

LoadHoppingShadowOAM:
	ld hl, vChars1 tile $7f
	ld de, LedgeHoppingShadow
	lb bc, BANK(LedgeHoppingShadow), (LedgeHoppingShadowEnd - LedgeHoppingShadow) / $8
	call CopyVideoDataDouble
	ld hl, LedgeHoppingShadowOAM
	ld de, wShadowOAMSprite36
	ld bc, LedgeHoppingShadowOAMEnd - LedgeHoppingShadowOAM
	call CopyData
	ld a, $a0
	ld [wShadowOAMSprite38YCoord], a
	ld [wShadowOAMSprite39YCoord], a
	ret

LedgeHoppingShadow:
	INCBIN "gfx/overworld/shadow.1bpp"
LedgeHoppingShadowEnd:

LedgeHoppingShadowOAM:
	dbsprite  9, 11,  0,  0, $ff, 0
	dbsprite 10, 11,  0,  0, $ff, OAM_HFLIP
LedgeHoppingShadowOAMEnd:
