AnimateBoulderDust:
	ld a, $1
	ld [wWhichAnimationOffsets], a ; select the boulder dust offsets
	ld a, [wUpdateSpritesEnabled]
	push af
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, %11100100
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	call LoadSmokeTileFourTimes
	farcall WriteCutOrBoulderDustAnimationOAMBlock
	ld c, 8 ; number of steps in animation
.loop
	push bc
	call GetMoveBoulderDustFunctionPointer
	ld bc, .returnAddress
	push bc
	ld c, 4
	jp hl
.returnAddress
	ldh a, [rOBP1]
	xor %01100100
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	call Delay3
	pop bc
	dec c
	jr nz, .loop
	pop af
	ld [wUpdateSpritesEnabled], a
	jp LoadPlayerSpriteGraphics

GetMoveBoulderDustFunctionPointer:
	ld a, [wSpritePlayerStateData1FacingDirection]
	ld hl, MoveBoulderDustFunctionPointerTable
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hli]
	ld [wCoordAdjustmentAmount], a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld hl, wShadowOAMSprite36
	ld d, $0
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ret

MACRO boulder_dust_adjust
	db \1, \2 ; coords
	dw \3 ; function
ENDM

MoveBoulderDustFunctionPointerTable:
	boulder_dust_adjust -1, 0, Dust_AdjustOAMBlockYPos ; down
	boulder_dust_adjust  1, 0, Dust_AdjustOAMBlockYPos ; up
	boulder_dust_adjust  1, 1, Dust_AdjustOAMBlockXPos ; left
	boulder_dust_adjust -1, 1, Dust_AdjustOAMBlockXPos ; right

; Same disease cut2.asm already documents: this file moved out of bank1E in the
; v0.7 bank reorg, but the two `dw` entries above kept pointing at the
; AdjustOAMBlock*Pos that stayed behind in bank1E — and AnimateBoulderDust's
; `jp hl` runs with THIS bank mapped, so every STRENGTH boulder push executed
; BaseStats data at those addresses. cross_bank_call_audit only scans call/jp
; instructions, so a pointer TABLE slipped past it. The loop bodies already
; live in this bank as cut2.asm's private copies; these two thunks just add
; the `ld l, e / ld h, d` preamble the originals have (the caller passes the
; OAM address in de).
Dust_AdjustOAMBlockXPos:
	ld l, e
	ld h, d
	jp Cut_AdjustOAMBlockXPos2

Dust_AdjustOAMBlockYPos:
	ld l, e
	ld h, d
	jp Cut_AdjustOAMBlockYPos2

LoadSmokeTileFourTimes::
	ld hl, vChars1 tile $7c
	ld c, 4
.loop
	push bc
	push hl
	call LoadSmokeTile
	pop hl
	ld bc, 1 tiles
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

LoadSmokeTile:
	ld de, SSAnneSmokePuffTile
	lb bc, BANK(SSAnneSmokePuffTile), (SSAnneSmokePuffTileEnd - SSAnneSmokePuffTile) / $10
	jp CopyVideoData

SSAnneSmokePuffTile:
	INCBIN "gfx/overworld/smoke.2bpp"
SSAnneSmokePuffTileEnd:
