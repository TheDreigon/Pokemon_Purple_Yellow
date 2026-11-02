UsedCut:
	xor a
	ld [wActionResultOrTookBattleTurn], a ; initialise to failure value
; v1.0 (2026-11-02): the tree of this tileset (CutTreeTiles: OVERWORLD, GYM and, new, FOREST), and OVERWORLD's tall
; grass as before
	call IsTileInFrontCutTree ; carry: a cut tree (a = the tile)
	jr c, .canCut
	cp $52 ; grass
	jr nz, .nothingToCut
	ld a, [wCurMapTileset]
	and a ; OVERWORLD's grass alone
	ld a, $52 ; (ld keeps the flags)
	jr z, .canCut
.nothingToCut
	ld hl, .NothingToCutText
	jp PrintText

.NothingToCutText
	text_far _NothingToCutText
	text_end

.canCut
	ld [wCutTile], a
	ld a, 1
	ld [wActionResultOrTookBattleTurn], a ; used cut
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadMapData
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call Delay3
	call LoadGBPal
	call LoadCurrentMapView
	call SaveScreenTilesToBuffer2
	call Delay3
	xor a
	ldh [hWY], a
	; fall through
Cut2::
	ld hl, UsedCutText
	call PrintText
	call LoadScreenTilesFromBuffer2
	ld hl, wd730
	res 6, [hl]
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call InitCutAnimOAM
	ld de, CutTreeBlockSwaps
	call ReplaceTreeTileBlock
	call RedrawMapView
	farcall AnimCut
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	ld a, SFX_CUT
	call PlaySound
	ld a, $90
	ldh [hWY], a
	call UpdateSprites
	jp RedrawMapView

UsedCutText:
	text_far _UsedCutText
	text_end

; v1.0 (2026-11-02): carry when tile a is the cuttable tree of the current tileset (CutTreeTiles); keeps a, bc, de,
; hl. IsTileInFrontCutTree asks it of the tile in front of the player (UsedCut; IsCutTile by farcall: Bankswitch's
; `pop bc` leaves the flags). The tile reader in front of the player calls IsCutTreeTile too (player_state.asm).
IsTileInFrontCutTree::
	ld a, [wTileInFrontOfPlayer]
IsCutTreeTile:
	push hl
	push bc
	ld b, a ; the tile
	ld a, [wCurMapTileset]
	ld c, a
	ld hl, CutTreeTiles
.loop
	ld a, [hli]
	cp -1
	jr z, .no
	cp c
	ld a, [hli] ; this tileset's tree tile (a load keeps the flags)
	jr nz, .loop
	cp b
	jr nz, .no
	scf
	jr .done
.no
	and a ; no carry
.done
	ld a, b
	pop bc
	pop hl
	ret

InitCutAnimOAM:
	xor a
	ld [wWhichAnimationOffsets], a
	ld a, %11100100
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	ld a, [wCutTile]
	cp $52
	jr z, .grass
; tree
	ld a, [wCurMapTileset]
	cp FOREST
	jr z, .forestTree ; v1.0 (2026-11-02): the forest's own tree, on its ground
	ld de, Overworld_GFX tile $2d ; cuttable tree sprite top row
	ld hl, vChars1 tile $7c
	lb bc, BANK(Overworld_GFX), 2
	call CopyVideoData
	ld de, Overworld_GFX tile $3d ; cuttable tree sprite bottom row
	ld hl, vChars1 tile $7e
	lb bc, BANK(Overworld_GFX), 2
	call CopyVideoData
	jr WriteCutOrBoulderDustAnimationOAMBlock
.forestTree
	ld de, Forest_GFX tile $10 ; top row ($10 $11)
	ld hl, vChars1 tile $7c
	lb bc, BANK(Forest_GFX), 2
	call CopyVideoData
	ld de, Forest_GFX tile $58 ; bottom row ($58 $59)
	ld hl, vChars1 tile $7e
	lb bc, BANK(Forest_GFX), 2
	call CopyVideoData
	jr WriteCutOrBoulderDustAnimationOAMBlock
.grass
	ld hl, vChars1 tile $7c
	call LoadCutGrassAnimationTilePattern
	ld hl, vChars1 tile $7d
	call LoadCutGrassAnimationTilePattern
	ld hl, vChars1 tile $7e
	call LoadCutGrassAnimationTilePattern
	ld hl, vChars1 tile $7f
	call LoadCutGrassAnimationTilePattern
	call WriteCutOrBoulderDustAnimationOAMBlock
	ld hl, wShadowOAMSprite36Attributes
	ld de, 4
	ld a, $30
	ld c, e
.loop
	ld [hl], a
	add hl, de
	xor $60
	dec c
	jr nz, .loop
	ret

LoadCutGrassAnimationTilePattern:
	ld de, MoveAnimationTiles1 tile 6 ; tile depicting a leaf
	lb bc, BANK(MoveAnimationTiles1), 1
	jp CopyVideoData

WriteCutOrBoulderDustAnimationOAMBlock:
	call GetCutOrBoulderDustAnimationOffsets
	ld a, $9
	ld de, CutOrBoulderDustAnimationTilesAndAttributes
	jp WriteOAMBlock

CutOrBoulderDustAnimationTilesAndAttributes:
	dbsprite  2, -1,  4,  4, $fd, OAM_OBP1 | OAM_HIGH_PALS
	dbsprite  2, -1,  4,  6, $ff, OAM_OBP1 | OAM_HIGH_PALS

GetCutOrBoulderDustAnimationOffsets:
	ld hl, wSpritePlayerStateData1YPixels
	ld a, [hli] ; player's sprite screen Y position
	ld b, a
	inc hl
	ld a, [hli] ; player's sprite screen X position
	ld c, a ; bc holds ypos/xpos of player's sprite
	inc hl
	inc hl
	ld a, [hl] ; a holds direction of player (00: down, 04: up, 08: left, 0C: right)
	srl a
	ld e, a
	ld d, $0 ; de holds direction (00: down, 02: up, 04: left, 06: right)
	ld a, [wWhichAnimationOffsets]
	and a
	ld hl, CutAnimationOffsets
	jr z, .next
	ld hl, BoulderDustAnimationOffsets
.next
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, b
	add d
	ld b, a
	ld a, c
	add e
	ld c, a
	ret

CutAnimationOffsets:
; Each pair represents the x and y pixels offsets from the player of where the cut tree animation should be drawn
	db  8, 36 ; player is facing down
	db  8,  4 ; player is facing up
	db -8, 20 ; player is facing left
	db 24, 20 ; player is facing right

BoulderDustAnimationOffsets:
; Each pair represents the x and y pixels offsets from the player of where the boulder dust animation should be drawn
; These offsets represent 2 blocks away from the player
	db  8,  52 ; player is facing down
	db  8, -12 ; player is facing up
	db -24, 20 ; player is facing left
	db 40,  20 ; player is facing right

ReplaceTreeTileBlock:
; Determine the address of the tile block that contains the tile in front of the
; player (i.e. where the tree is) and replace it with the corresponding tile
; block that doesn't have the tree.
	push de
	ld a, [wCurMapWidth]
	add 6
	ld c, a
	ld b, 0
	ld d, 0
	ld hl, wCurrentTileBlockMapViewPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a
	jr z, .down
	cp SPRITE_FACING_UP
	jr z, .up
	cp SPRITE_FACING_LEFT
	jr z, .left
; right
	ld a, [wXBlockCoord]
	and a
	jr z, .centerTileBlock
	jr .rightOfCenter
.down
	ld a, [wYBlockCoord]
	and a
	jr z, .centerTileBlock
	jr .belowCenter
.up
	ld a, [wYBlockCoord]
	and a
	jr z, .aboveCenter
	jr .centerTileBlock
.left
	ld a, [wXBlockCoord]
	and a
	jr z, .leftOfCenter
	jr .centerTileBlock
.belowCenter
	add hl, bc
.centerTileBlock
	add hl, bc
.aboveCenter
	ld e, $2
	add hl, de
	jr .next
.leftOfCenter
	ld e, $1
	add hl, bc
	add hl, de
	jr .next
.rightOfCenter
	ld e, $3
	add hl, bc
	add hl, de
.next
	pop de
	ld a, [hl]
	ld c, a
.loop ; find the matching tile block in the array
	ld a, [de]
	inc de
	inc de
	cp $ff
	ret z
	cp c
	jr nz, .loop
	dec de
	ld a, [de] ; replacement tile block from matching array entry
	ld [hl], a
	ret

INCLUDE "data/tilesets/cut_tree_blocks.asm"
