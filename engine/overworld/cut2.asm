AnimCut:
	ld a, [wCutTile]
	cp $52
	jr z, .grass
	ld c, $8
.cutTreeLoop
	push bc
	ld hl, wShadowOAMSprite36XCoord
	ld a, 1
	ld [wCoordAdjustmentAmount], a
	ld c, 2
	call Cut_AdjustOAMBlockXPos2
	ld hl, wShadowOAMSprite38XCoord
	ld a, -1
	ld [wCoordAdjustmentAmount], a
	ld c, 2
	call Cut_AdjustOAMBlockXPos2
	ldh a, [rOBP1]
	xor $64
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	call DelayFrame
	pop bc
	dec c
	jr nz, .cutTreeLoop
	ret
.grass
	ld c, 2
.cutGrassLoop
	push bc
	ld c, $8
	call AnimCutGrass_UpdateOAMEntries
	call AnimCutGrass_SwapOAMEntries
	ld c, $8
	call AnimCutGrass_UpdateOAMEntries
	call AnimCutGrass_SwapOAMEntries
	ld hl, wShadowOAMSprite36YCoord
	ld a, 2
	ld [wCoordAdjustmentAmount], a
	ld c, 4
	call Cut_AdjustOAMBlockYPos2
	pop bc
	dec c
	jr nz, .cutGrassLoop
	ret

AnimCutGrass_UpdateOAMEntries:
	push bc
	ld hl, wShadowOAMSprite36XCoord
	ld a, 1
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call Cut_AdjustOAMBlockXPos2
	ld hl, wShadowOAMSprite37XCoord
	ld a, 2
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call Cut_AdjustOAMBlockXPos2
	ld hl, wShadowOAMSprite38XCoord
	ld a, -2
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call Cut_AdjustOAMBlockXPos2
	ld hl, wShadowOAMSprite39XCoord
	ld a, -1
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call Cut_AdjustOAMBlockXPos2
	ldh a, [rOBP1]
	xor $64
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	call DelayFrame
	pop bc
	dec c
	jr nz, AnimCutGrass_UpdateOAMEntries
	ret

AnimCutGrass_SwapOAMEntries:
	ld hl, wShadowOAMSprite36
	ld de, wBuffer
	ld bc, $8
	call CopyData
	ld hl, wShadowOAMSprite38
	ld de, wShadowOAMSprite36
	ld bc, $8
	call CopyData
	ld hl, wBuffer
	ld de, wShadowOAMSprite38
	ld bc, $8
	jp CopyData

; Private copies of two OAM adjusters from engine/battle/animations.asm.
;
; cut2.asm was moved out of bank1E in the v0.7 bank reorg, but these seven
; calls kept targeting the originals that stayed behind -- a near call into
; another bank executes whatever sits at that address in THIS bank. It stayed
; latent because nobody had used CUT on a tree since the reorg. farcall cannot
; carry these calls: hl and c are the arguments and the macro overwrites hl.
; So the two tiny loops are duplicated here under their own names (~50 bytes).
; Found by cross_bank_call_audit.
Cut_AdjustOAMBlockXPos2:
	ld de, 4
.loop
	ld a, [wCoordAdjustmentAmount]
	ld b, a
	ld a, [hl]
	add b
	cp 168
	jr c, .skipPuttingEntryOffScreen
	dec hl
	ld a, 160
	ld [hli], a
.skipPuttingEntryOffScreen
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

Cut_AdjustOAMBlockYPos2:
	ld de, 4
.loop
	ld a, [wCoordAdjustmentAmount]
	ld b, a
	ld a, [hl]
	add b
	cp 112
	jr c, .skipSettingPreviousEntrysAttribute
	dec hl
	ld a, 160 ; vanilla quirk preserved: sets the previous OAM entry's attribute
	ld [hli], a
.skipSettingPreviousEntrysAttribute
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret
