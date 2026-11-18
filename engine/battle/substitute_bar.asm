; The SUBSTITUTE doll's HP tube beside each battle HUD.
;
; While a doll stands, a small vertical tube shows its HP: the player's in cells (19,9) (19,10) (19,11) under a
; mark at (19,8), the enemy's in (0,2) (0,3) under a mark at (0,1). It fills from the bottom; the fill pixels are
;   f = clamp(dollHP * capacity / dollMax, 1, capacity), dollMax = max(1, maxHP >> 2)
; (the doll's maximum is not stored: SubstituteEffect_ computes it the same way), capacity 19 for the player and
; 11 for the enemy. The tube's tiles and the f-to-ids tables are generated (.claude/substitute_bar_build.py,
; data/battle/substitute_bar.asm). The two marks are painted by hand: gfx/battle/substitute_mark.png, the player's
; then the enemy's, in colour indices 0, 1 and 3 only (2 is the HP bar's colour in these cells' palette).
;
; Everything is static: the patterns are loaded once per battle, LCD off (LoadSubstituteBarTiles), and a draw is
; tilemap writes only, like the HP bar. No palette is written: the fill is colour index 1 of the cells' own
; palette (0), which no other HUD tile uses.
;   - GBC: the patterns sit in VRAM bank 1, ids $00-$24. The cells that show them have attribute bit 3 set in the
;     battle's attribute tables (data/cgb/bg_map_attributes.asm), so they read bank 1 for EVERY id: bank 1 also
;     gets a copy of what else is ever drawn there (the font at $80-$FF and the $62-$7F set: box frames, blank),
;     by the same two loaders run again with rVBK = 1.
;   - DMG / SGB (hGBC = 0): the patterns sit in bank 0 over font cells that only the GBC's coloured status
;     letters use ($ca-$cf, $d5-$dc), plus $d2, $dd and $de; fewer patterns, so the tube moves in coarser steps.
; The enemy HUD's frame is one pixel shorter on the left in every battle, to make room: its vertical line at
; (1,2) has an id of its own (EnemyBattleHUDGraphicsTiles, engine/battle/draw_hud_pokeball_gfx.asm), its corner
; ($74) and the "owned" ball ($d0, font) are drawn one pixel right, and the ball's last column spills into (2,1).
;
; Draws: in both HUD draws, which call DrawHUDStatusAndSubstituteBar where they print the status label (both have
; just cleared the tube's cells), and in AttackSubstitute (engine/battle/core.asm) when the doll holds a hit and
; when it breaks (RedrawTargetSubstituteBar).

INCLUDE "data/battle/substitute_bar.asm"

; The two HUD draws (DrawPlayerHUDAndHPBar, DrawEnemyHUDAndHPBar) callfar this where they print the status.
; IN  c = 0 for the player's HUD, 1 for the enemy's
; Registers are not kept; the callers read none after the call.
DrawHUDStatusAndSubstituteBar::
	push bc
	call PrintStatusOrConfusion
	pop bc
	ld a, c
	and a
	call nz, PlaceOwnedBallSpill ; keeps bc
	; fall through

; IN  c = 0 for the player's tube, 1 for the enemy's
; A doll up (HAS_SUBSTITUTE_UP) on a #MON whose HP is not 0: the mark and the tube. Otherwise " " in the mark's
; cell and the tube's. The doll's HP byte is never the gate: it keeps 0 or a wrapped value after a break.
; No Multiply / Divide: the math scratch may be live at the call sites.
DrawSubstituteBar:
	ld a, c
	and a
	jr nz, .enemy
	hlcoord 19, 8
	ld a, [wPlayerBattleStatus2]
	ld de, wBattleMonHP
	call SubstituteBarShown
	ld c, 4 ; the mark and three tube cells
	jr z, SubstituteBarBlank
	ld a, [wPlayerSubstituteHP]
	ld de, wBattleMonMaxHP
	ld b, SUBBAR_PLAYER_CAP
	call SubstituteBarFill
	ld c, a
	add a
	add c ; a = 3f (rows of three ids)
	ld c, a
	ldh a, [hGBC]
	and a
	ld de, SubstituteBarPlayerDMG - 3
	ld b, SUBBAR_DMG_MARK_P
	jr z, .gotPlayerSet
	ld de, SubstituteBarPlayerGBC - 3
	ld b, SUBBAR_GBC_MARK_P
.gotPlayerSet
	ld a, c
	ld c, 3
	jr SubstituteBarPlace

.enemy
	hlcoord 0, 1
	ld a, [wEnemyBattleStatus2]
	ld de, wEnemyMonHP
	call SubstituteBarShown
	ld c, 3 ; the mark and two tube cells
	jr z, SubstituteBarBlank
	ld a, [wEnemySubstituteHP]
	ld de, wEnemyMonMaxHP
	ld b, SUBBAR_ENEMY_CAP
	call SubstituteBarFill
	add a ; a = 2f (rows of two ids)
	ld c, a
	ldh a, [hGBC]
	and a
	ld de, SubstituteBarEnemyDMG - 2
	ld b, SUBBAR_DMG_MARK_E
	jr z, .gotEnemySet
	ld de, SubstituteBarEnemyGBC - 2
	ld b, SUBBAR_GBC_MARK_E
.gotEnemySet
	ld a, c
	ld c, 2
	; fall through

; IN  hl = the mark's cell, b = the mark's id, c = tube cells under it,
;     de + a = the table row (one id per tube cell, top first)
SubstituteBarPlace:
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld [hl], b
.loop
	ld a, l
	add SCREEN_WIDTH
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [de]
	inc de
	ld [hl], a
	dec c
	jr nz, .loop
	ret

; IN  hl = the mark's cell, c = cells to blank from it down (the mark included)
SubstituteBarBlank:
	ld de, SCREEN_WIDTH
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	ret

; IN  a = the side's BattleStatus2, de = its #MON's HP (2 bytes)
; OUT NZ = a doll is up and the #MON's HP is not 0
SubstituteBarShown:
	bit HAS_SUBSTITUTE_UP, a
	ret z
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	ret

; IN  a = the doll's HP, de = its owner's max HP (2 bytes, big-endian), b = the tube's capacity
; OUT a = f, 1..capacity. hl is kept; bc and de are not.
SubstituteBarFill:
	push hl
	ld c, a
; de = dollMax = max(1, maxHP >> 2)
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld l, a
	srl h
	rr l
	srl h
	rr l
	ld a, h
	or l
	jr nz, .gotMax
	inc l
.gotMax
	ld d, h
	ld e, l
; hl = dollHP * capacity (at most 255 * 19)
	ld hl, 0
	push bc
.multiply
	ld a, l
	add c
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	dec b
	jr nz, .multiply
	pop bc
; c = how many times dollMax fits in hl, counting no further than the capacity
	ld c, 0
.divide
	ld a, c
	cp b
	jr nc, .gotFill
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	jr c, .gotFill
	inc c
	jr .divide
.gotFill
	ld a, c
	and a
	jr nz, .done
	inc a ; a doll with any HP shows one pixel
.done
	pop hl
	ret

; When the enemy HUD's (1,1) holds the "owned" ball, its last column (drawn one pixel right) goes in (2,1).
PlaceOwnedBallSpill:
	hlcoord 1, 1
	ld a, [hli]
	cp $d0 ; the ball (DrawEnemyHUDAndHPBar)
	ret nz
	ldh a, [hGBC]
	and a
	ld a, SUBBAR_DMG_SPILL
	jr z, .gotSpill
	ld a, SUBBAR_GBC_SPILL
.gotSpill
	ld [hl], a
	ret

; AttackSubstitute (engine/battle/core.asm) jpfars / callfars this when the doll's HP changes with no HUD draw:
; a hit it holds, and its break (the bit is clear by then, so the cells are blanked).
; The side is the target: hWhoseTurn names the attacker. The BG transfer is held off while the cells are written,
; so the mark and the tube reach the screen together, and restored as it was.
RedrawTargetSubstituteBar::
	ldh a, [hAutoBGTransferEnabled]
	push af
	xor a
	ldh [hAutoBGTransferEnabled], a
	ldh a, [hWhoseTurn]
	xor 1
	ld c, a
	call DrawSubstituteBar
	pop af
	ldh [hAutoBGTransferEnabled], a
	ret

; Called once per battle by SlidePlayerAndEnemySilhouettesOnScreen (engine/battle/core.asm), right after the
; status letters, with the LCD OFF: plain copies into VRAM. With the LCD on it does nothing (a VRAM write in
; mode 3 is lost).
LoadSubstituteBarTiles::
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	ret nz
	ldh a, [hGBC]
	and a
	jr z, .dmg
; GBC: VRAM bank 1. The two loaders take their LCD-off branch (plain copies), so they land in bank 1 too: the
; copy of the font and of the $62-$7F set that the bit-3 cells read for anything but the tube.
	ld a, 1
	ldh [rVBK], a
	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns
	ld hl, SubstituteBarTilesGBC
	ld de, vChars2
	ld bc, NUM_SUBBAR_GBC_TILES tiles
	call CopyData
	xor a
	ldh [rVBK], a
	ret

.dmg
	ld hl, SubstituteBarTilesDMG
	ld de, vFont tile (SUBBAR_DMG_RUN1 - $80)
	ld bc, SUBBAR_DMG_RUN1_LEN tiles
	call CopyData
	ld de, vFont tile (SUBBAR_DMG_RUN2 - $80)
	ld bc, SUBBAR_DMG_RUN2_LEN tiles
	call CopyData
	ld de, vFont tile (SUBBAR_DMG_RUN3 - $80)
	ld bc, SUBBAR_DMG_RUN3_LEN tiles
	jp CopyData

; Each set is its generated sheet, then the two hand-painted marks: the set's last two ids (SUBBAR_*_MARK_*).
SubstituteBarTilesGBC:
	INCBIN "gfx/battle/substitute_bar_gbc.2bpp"
.marks
	INCBIN "gfx/battle/substitute_mark.2bpp"
SubstituteBarTilesGBCEnd:
	ASSERT SubstituteBarTilesGBCEnd - SubstituteBarTilesGBC.marks == NUM_SUBBAR_MARK_TILES * LEN_2BPP_TILE
	ASSERT SubstituteBarTilesGBCEnd - SubstituteBarTilesGBC == NUM_SUBBAR_GBC_TILES * LEN_2BPP_TILE

SubstituteBarTilesDMG:
	INCBIN "gfx/battle/substitute_bar_dmg.2bpp"
.marks
	INCBIN "gfx/battle/substitute_mark.2bpp"
SubstituteBarTilesDMGEnd:
	ASSERT SubstituteBarTilesDMGEnd - SubstituteBarTilesDMG.marks == NUM_SUBBAR_MARK_TILES * LEN_2BPP_TILE
	ASSERT SubstituteBarTilesDMGEnd - SubstituteBarTilesDMG == NUM_SUBBAR_DMG_TILES * LEN_2BPP_TILE
