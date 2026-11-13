LoadBGMapAttributes::
; v1.0 (2026-11-12): the battle's attributes (packet 10) point the six status cells at BG palettes 5 and 6.
; Both are written first, here: before the attributes are, so no cell is ever pointed at a palette that was not
; written, and before the di below. (This routine waits for scanline 144 exactly, twice, with interrupts off:
; two V-blank handlers are skipped as it is. The eight colours take a scanline each with the screen on, and
; inside the di they could carry it past a line 144 and cost a third.) c is kept. The status letters' design
; is further down.
	ld a, c
	cp 10 ; BGMapAttributes_Battle, its place in BGMapAttributesPointers (an ASSERT at the table holds the number)
	call z, PreloadPacket10LetterPalettes
	ld hl, BGMapAttributesPointers
	ld a, c ; c = which packet
	push af ; save for later (to determine if we're handling the trainer card or party menu)
	dec a         ; read this code as:
	add a         ;	dec a
	ld e, a       ; add a
	xor a         ; ld e, a
	ld d, a       ; ld d, 0
	add hl, de    ; add hl, de
	ld a, [hli]   ; ld a, [hli]
	ld e, a       ; ld h, [hl]
	ld a, [hl]    ; ld l, a
	ld h, a
	ld a, e
	ld l, a

	di
	ld a, $1
	ldh [rVBK], a
	push hl
	ld a, [hl]
	ld c, a ; save attribute count for later
	ld de, $10
	add hl, de
	ld a, h
	ldh [rHDMA1], a
	ld a, l
	ldh [rHDMA2], a
	ld de, vBGMap0
	ld a, d
	ldh [rHDMA3], a
	ld a, e
	ldh [rHDMA4], a

	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK ; is LCD off?
	jr z, .lcdOff ; if off, transfer immediately
; wait for VBlank if LCD is on
.waitForVBlankLoop1
	ldh a, [rLY]
	cp $90
	jr nz, .waitForVBlankLoop1
.waitForAccessibleVRAMLoop1
	ldh a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .waitForAccessibleVRAMLoop1 ; loop until we're in a safe period to transfer to VRAM
.lcdOff
	ld a, c ; number of BG attributes to transfer, plus 1 times 16
	ldh [rHDMA5], a ; initiate transfer
	call Func_3082 ; update audio so it doesn't "lag"
	pop hl
	ld a, [hli]
	ld c, a     ; number of BG attributes to transfer, plus 1 times 16
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a    ; offset of the attributes
	add hl, de ; hl = new pointer
	ld a, h
	ldh [rHDMA1], a
	ld a, l
	ldh [rHDMA2], a
	ld de, vBGMap1 ; copy to vBGMap1
	ld a, d
	ldh [rHDMA3], a
	ld a, e
	ldh [rHDMA4], a
; LCD check again
	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK ; is LCD off?
	jr z, .lcdOff2 ; if off, transfer immediately
; wait for VBlank if LCD is on
.waitForVBlankLoop2
	ldh a, [rLY]
	cp $90
	jr nz, .waitForVBlankLoop2
.waitForAccessibleVRAMLoop2
	ldh a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .waitForAccessibleVRAMLoop2 ; loop until we're in a safe period to transfer to VRAM
.lcdOff2
	ld a, c
	ldh [rHDMA5], a
	pop af
	dec a
	dec a
	dec a
	dec a
	jr nz, .checkIfHandlingPartyMenu
	call HandleBadgeFaceAttributes
	jr .done
.checkIfHandlingPartyMenu
	dec a
	jr nz, .checkIfHandlingBattle
	call HandlePartyHPBarAttributes
	jr .done
.checkIfHandlingBattle
; the battle attributes (packet 10) point the EXP bar row at BG palette 4,
; which nothing in the vanilla engine ever loads -- load it here so those
; cells are never left pointing at an uninitialized palette
	sub 10 - 5 ; a = packet - 5 here; the battle attributes are packet 10
	call z, LoadEXPBarPalette
.done
	call Func_3082
	ldh a, [rIF]
	res VBLANK, a
	ldh [rIF], a
	xor a
	ldh [rVBK], a
	ei
	ret

BGMapAttributesPointers:
	dw BGMapAttributes_Unknown1
	dw BGMapAttributes_Unknown2
	dw BGMapAttributes_GameFreakIntro
	dw BGMapAttributes_TrainerCard
	dw BGMapAttributes_PartyMenu
	dw BGMapAttributes_TitleScreen
	dw BGMapAttributes_Slots
	dw BGMapAttributes_Pokedex
	dw BGMapAttributes_StatusScreen
.battle
	dw BGMapAttributes_Battle
	dw BGMapAttributes_WholeScreen
	dw BGMapAttributes_Unknown13
; v1.0 (2026-11-12): the battle's attributes are packet 10, a number that code writes as a literal in three
; places: the head and the tail of LoadBGMapAttributes (`cp 10`, `sub 10 - 5`) and AnimationShakeEnemyHUD
; (`ld c, 10`, engine/battle/animations.asm).
	ASSERT BGMapAttributesPointers.battle - BGMapAttributesPointers == (10 - 1) * 2

HandleBadgeFaceAttributes:
; zero out the attributes if the player doesn't have the respective badge
; BOULDERBADGE
	ld hl, vBGMap1 + $183
	ld de, wTrainerCardBadgeAttributes + 6 * 0
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; CASCADEBADGE
	ld hl, vBGMap1 + $187
	ld de, wTrainerCardBadgeAttributes + 6 * 1
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; THUNDERBADGE
	ld hl, vBGMap1 + $18b
	ld de, wTrainerCardBadgeAttributes + 6 * 2
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; RAINBOWBADGE
	ld hl, vBGMap1 + $18f
	ld de, wTrainerCardBadgeAttributes + 6 * 3
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; SOULBADGE
	ld hl, vBGMap1 + $1e3
	ld de, wTrainerCardBadgeAttributes + 6 * 6
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; GOLDBADGE
	ld hl, vBGMap1 + $1e7
	ld de, wTrainerCardBadgeAttributes + 6 * 7
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; VOLCANOBADGE
	ld hl, vBGMap1 + $1eb
	ld de, wTrainerCardBadgeAttributes + 6 * 8
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
; EARTHBADGE
	ld hl, vBGMap1 + $1ef
	ld de, wTrainerCardBadgeAttributes + 6 * 9
	ld a, [de]
	and a
	call z, ZeroOutCurrentBadgeAttributes
	ret

ZeroOutCurrentBadgeAttributes:
	push hl
	xor a
	ld [hli], a
	ld [hl], a
	ld bc, $1f
	add hl, bc
	ld [hli], a
	ld [hl], a
	pop hl
	ret

HandlePartyHPBarAttributes:
; hp bars require 3 (green, orange, red) colours, when there are only 2 "free" colours per palette
; therefore, we must transfer individual bg attributes where the locations of the hp bars are in vram
	ld hl, vBGMap1 + $25 ; location of start of the HP bar in vram
	ld de, wPartyHPBarAttributes
	ld c, PARTY_LENGTH
.loop
	push bc
	push hl
	ld a, [de]
	and $3 ; 4 possible palettes
REPT 7 ; hp bar length in tiles
	ld [hli], a
ENDR
	pop hl
	ld bc, $40 ; get 2nd party location
	add hl, bc
	push hl

	push de ; (inefficiently) copy de to hl
	pop hl

	ld bc, $6
	add hl, bc ; get the next palette

	push hl
	pop de ; copy back to de

	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret

ExpBarBluePalette:
; started as a source-level copy of PAL_CYANMON (data/sgb/sgb_palettes.asm).
; The bar tiles only use color indices 0, 2 and 3; colors 0 and 3 match the
; HP-bar palettes (white frame, black outline), and color 2 is the fill.
; v0.7 (playtest, 2026-08-28): fill went from blue 00,17,31 to a lighter cyan.
; v1.0 (2026-09-08, in-game review): the fill is now CRYSTAL's exp-bar blue
; (pokecrystal gfx/battle/exp_bar.pal, its second colour: four, seventeen,
; thirty-one) - checked in the game, the Crystal colour was brought back.
; Colours 0 and 3 stay the HP bars' white and black (Crystal's bar sits on
; cream; ours on white). No "RGB" + digits in these comments: the audit and
; emu_test_expbarblue read the first such token after the label as the data.
; Living here instead of GBCBasePalettes costs bank1C nothing (it had 1 byte free on 2026-08-16).
	RGB 31,31,31, 16,26,31, 04,17,31, 03,03,03

LoadEXPBarPalette::
; Rebuild BG palette 4 from ExpBarBluePalette, shaded through the current
; rBGP value so the EXP bar whites out and fades with the rest of the screen.
; Called from two places: the packet-10 hook above (battle attribute load),
; and home's UpdateGBCPal_BGP right after _UpdateGBCPal_BGP, which only
; rebuilds palettes 0-3 (NUM_ACTIVE_PALS).
;
; This mirrors DMGPalToGBCPal (CONVERT_BGP case) + TransferCurBGPData with
; a = 4 rather than farcalling them: both take their argument in a, and a
; does not survive rst _Bankswitch (Bankswitch does `ld a, b` to map the
; callee's bank before dispatching). It deliberately does NOT write wLastBGP,
; so it can never mask a pending palette 0-3 rebuild in UpdateGBCPal_BGP.
;
; v1.0 (2026-11-12): palette 4 and nothing else. The status letters' palettes (BG 5 and 6) have writers of
; their own below, each of which runs BEFORE the palettes or the attributes it must not lag behind: written
; here, after palettes 0-3, they would reach the enemy's row (the top of the screen) a frame late on every
; fade. The four colours go out through TransferBGPalColors, which those writers share.
	ldh a, [hGBC]
	and a
	ret z
	ld de, ExpBarBluePalette
	ldh a, [rBGP]
	FOR color_index, NUM_PAL_COLORS
		ld b, a
		and %11
		add a ; 2 bytes per color
		ld l, a
		xor a
		ld h, a
		add hl, de
		ld a, [hli]
		ld [wGBCPal + color_index * 2], a
		ld a, [hl]
		ld [wGBCPal + color_index * 2 + 1], a

		IF color_index < NUM_PAL_COLORS - 1
			ld a, b
			rrca
			rrca
		ENDC
	ENDR

	ld a, (4 << 3) | $80 ; BG palette 4, color 0, auto-increment
	ldh [rBGPI], a
	ld hl, wGBCPal
	ld c, NUM_PAL_COLORS
; fall through

TransferBGPalColors:
; Write c colours from hl to BG palette RAM, from the index rBGPI holds (auto-increment).
; With the LCD on, one colour (two bytes) per H-blank or V-blank, as TransferPalColorLCDEnabled does: wait for
; the blanking period we may be in to end, then for the next one to start. The second byte is then written at
; most 18 M-cycles after the blank began, and the shortest H-blank lasts 21: palette RAM drops a write made
; while the line is being drawn. With the LCD off, no wait.
	ld de, rBGPD
	ld b, %10 ; mask for non-V-blank/non-H-blank STAT mode
	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK
	jr z, .write
.waitForBlankEnd
; in case we're already in H-blank or V-blank, wait for it to end, so the
; two writes below can't straddle the end of a blanking period
	ldh a, [rSTAT]
	and b
	jr z, .waitForBlankEnd
.waitForBlank
	ldh a, [rSTAT]
	and b
	jr nz, .waitForBlank
.write
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	dec c
	ret z
	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK
	jr nz, .waitForBlankEnd
	jr .write

; v1.0 (2026-11-12): the battle HUD's three status letters take a colour per status on the GBC.
; The DMG and the SGB keep the font's black letters (engine/battle/hud_status.asm).
;
; The letters cannot simply be recoloured: they are font tiles, drawn in colour index 3, the black
; of every text, and the bag's list, YES/NO, the level-up boxes and the MOVE INFO card are drawn
; over the same six cells. So the EXP bar's recipe is used instead:
;   - tiles: copies of the font's letters with the ink in colour index 2 (the persistent statuses)
;     and index 1 (CNF), loaded over blank font cells for the battle (LoadStatusLetterTiles);
;   - cells: the six status cells are on BG palettes 5 (the enemy's) and 6 (the player's) in
;     BGMapAttributes_Battle and BGMapAttributes_Unknown13 (data/cgb/bg_map_attributes.asm);
;   - palettes: 5 and 6 are background / CNF's ink / the status's ink / text colour. Slots 0 and 3
;     are the HP bar's next to the cells, so any other text there looks as it does around them. With
;     both inks in the palette at once, the 2-second status / CNF alternation only swaps tiles
;     (AlternateHUDStatus) and never writes a palette.
; BG palette 7 stays free.
;
; No frame may show a status cell in a colour that is not the HUD's background, the ink of the label
; that is on screen in that frame, or the text colour. Four things hold that.
;
; 1. THE INK REGISTER (hStatusLetterInk, a byte per side) names the ink of the persistent-status label
;    that side's cells last got. Every build of a palette reads the REGISTER, never the status bytes:
;    a status byte changes when a move lands or a cure is used, the label only at the next HUD draw,
;    and a rebuild in between (a flash, a fade, a palette command) must not recolour letters that are
;    still on screen. The register is written by the HUD draw that changes the label and by nothing else
;    (and zeroed when a battle starts). It follows that a restore of a saved screen must never bring back a
;    label that a HUD draw has since replaced: no HUD draw that gives a side another label falls between a
;    save of the screen and its restore (MimicEffect, engine/battle/effects.asm, saves the screen right
;    before its list for that).
;
; 2. THE SHADING RULE (BuildStatusLetterPalette). m0 and m3 are the shades rBGP gives slots 0 and 3:
;        slot 0 = the side's HP-bar palette at m0     what the cells around the letters show
;        slot 3 = the side's HP-bar palette at m3     the text colour (the overlays' text)
;        slot 1 (CNF) and slot 2 (the status):
;            m3 = m0                                      -> the colour of slot 0: no text is visible, they hide
;            else no ink (register 0), or the silhouette  -> the colour of slot 3: the text colour
;            else                                         -> the ink, unshaded
;    So the letters are visible exactly when the other text is, and then always in their own ink: a
;    shaded ink is another colour (the bar's black or white, under ACID's or THUNDERBOLT's palettes,
;    for as long as the animation holds them).
;    The silhouette form: the last palette command is SET_PAL_BATTLE_BLACK (a black out, a surrender,
;    the slide-in), or the caller asks for it. CNF's slot is the text colour in it too, and it never
;    reads the register: a battle's first SET_PAL_BATTLE_BLACK runs before the register is zeroed.
;
; 3. WHEN THE PALETTES ARE WRITTEN: before, or together with, what they must not lag behind.
;      - An rBGP change on a battle screen: PreloadStatusLetterPalettes, called by home's
;        UpdateGBCPal_BGP BEFORE palettes 0-3 are rebuilt. Those are written at the next V-blank; 5 and
;        6 are written below both rows of status cells of the frame being drawn, in a raster window that
;        leaves the rebuild time to finish before that V-blank: the whole screen changes shade in one frame.
;      - A new label: WriteStatusLetterPaletteSynced, from the tail of the HUD draw that drew it
;        (SyncStatusLetterInk, engine/battle/hud_status.asm). The ink is written at the start of the
;        V-blank whose handler copies the label's tiles: ink and tiles are new in the same frame.
;      - The battle's attributes (packet 10): PreloadPacket10LetterPalettes, at the head of
;        LoadBGMapAttributes, before the attributes point any cell at palette 5 or 6.
;      - SET_PAL_BATTLE_BLACK with a HUD on screen (the black out, the surrender):
;        PreloadSilhouetteLetterPalettes, called in front of the command: the letters turn black in the
;        frame the HP bars do.
;    The gate of all four is hGBC and "the last palette command is a battle's" (wLastPalCommand below
;    2). Never wIsInBattle: EndOfBattle zeroes it BEFORE the battle's last white-out, and the letters
;    would stay in colour on the white screen until the map loads.
;
; 4. EVERY PALETTE ACCESS IS A WRITE IN A BLANKING PERIOD. Palette RAM drops a write made while a line
;    is being drawn, and nothing here ever reads it (which is why the register is in HRAM). One colour
;    per H-blank through TransferBGPalColors, or the eight bytes of one palette under di at the start
;    of V-blank (WriteStatusLetterPaletteSynced).

StatusLetterTiles:
	INCBIN "gfx/font/status_letters.2bpp"
StatusLetterTilesEnd:
	ASSERT StatusLetterTilesEnd - StatusLetterTiles == (NUM_STATUS_TILES_1 + NUM_STATUS_TILES_2) * LEN_2BPP_TILE

LoadStatusLetterTiles::
; Called once per battle, by SlidePlayerAndEnemySilhouettesOnScreen (engine/battle/core.asm) right
; after the font and the HUD tiles, WITH THE LCD OFF (plain copies to VRAM). That is the only font
; load of a battle, and no screen reachable from one writes these cells (see the constants).
; On the DMG and the SGB the cells stay blank: nothing draws these ids there.
; The INK REGISTER is zeroed here too: a battle starts with no label on either HUD.
	ldh a, [hGBC]
	and a
	ret z
	xor a
	ASSERT STATUS_INK_NONE == 0
	ldh [hStatusLetterInk], a
	ldh [hStatusLetterInk + 1], a
	ld hl, StatusLetterTiles
	ld de, vFont tile (STATUS_TILE_P - $80)
	ld bc, NUM_STATUS_TILES_1 tiles
	call CopyData
	ld de, vFont tile (STATUS_TILE_B - $80)
	ld bc, NUM_STATUS_TILES_2 tiles
	jp CopyData

StatusInkTable:
; One GBC colour per ink (red, green, blue, 0-31). Chosen on 2026-11-12.
; In the order of the ink ids (STATUS_INK_*, constants/gfx_constants.asm): ink id n is entry n - 1, which is
; how BuildStatusLetterPalette reads it. CNF's ink, the last, is not an id: it has a palette slot of its own.
.psn:    RGB 22,10,28
.tox:    RGB 13,02,18
.brn:    RGB 30,03,02
.brnOut: RGB 30,15,00 ; not used yet: a burn whose fire is out
.par:    RGB 27,22,00
.slp:    RGB 04,08,20
.frz:    RGB 08,22,31
.bleed:  RGB 20,02,04 ; not used yet
.cnf:    RGB 00,17,15
	ASSERT StatusInkTable.psn    - StatusInkTable == (STATUS_INK_PSN     - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.tox    - StatusInkTable == (STATUS_INK_TOX     - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.brn    - StatusInkTable == (STATUS_INK_BRN     - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.brnOut - StatusInkTable == (STATUS_INK_BRN_OUT - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.par    - StatusInkTable == (STATUS_INK_PAR     - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.slp    - StatusInkTable == (STATUS_INK_SLP     - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.frz    - StatusInkTable == (STATUS_INK_FRZ     - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.bleed  - StatusInkTable == (STATUS_INK_BLEED   - 1) * PAL_COLOR_SIZE
	ASSERT StatusInkTable.cnf    - StatusInkTable == NUM_STATUS_INKS * PAL_COLOR_SIZE

BuildStatusLetterPalette:
; One side's letter palette by the shading rule (above), from the INK REGISTER and the rBGP of this moment.
; IN  c = 0 the player's letters, 1 the enemy's
;     b = the form: STATUS_PAL_FORM_COMMAND (0), what the last palette command asks for; anything else
;         (STATUS_PAL_FORM_SILHOUETTE), the silhouette form
;     de = where to build it: PALETTE_SIZE bytes that are not wGBCPal
; OUT de = the byte after it; bc kept; a and hl are not
; Slots 0 and 3 come from the side's HP bar: its base palette (BG palette 0 the player's, 1 the enemy's: the
; palettes of the cells around the letters) is read through wGBCBasePalPointers, as _UpdateGBCPal_BGP reads
; it, and copied to wGBCPal. Under a command that is not a battle's those pointers are another screen's: the
; callers have checked.
	push bc
	push de
	ld hl, wGBCBasePalPointers ; BG palette 0: the player's HP bar
	dec c
	jr nz, .gotBar
	inc hl
	inc hl ; BG palette 1: the enemy's
.gotBar
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wGBCPal
	ld bc, PALETTE_SIZE
	ld a, BANK(GBCBasePalettes)
	call FarCopyData
	pop de
	pop bc
	push bc
; b is made non-zero when the two ink slots take the text colour (slot 3's) and not an ink: in the silhouette
; form, and when slot 3's shade is slot 0's. In that last case all four slots are one colour, the one the cells
; around show: the letters hide with every other text.
	ldh a, [rBGP]
	ld l, a
	rlca
	rlca
	xor l
	and %11 ; slot 3's shade (bits 7-6 of rBGP) against slot 0's (bits 1-0)
	jr z, .noInks
	ld a, [wLastPalCommand]
	and a
	ASSERT SET_PAL_BATTLE_BLACK == 0
	jr nz, .gotForm
.noInks
	ld b, STATUS_PAL_FORM_SILHOUETTE
.gotForm
; slot 0: the bar's colour at slot 0's shade
	ldh a, [rBGP]
	call .barColor
	call .putColor
; hl = the text colour: the bar's colour at slot 3's shade
	ldh a, [rBGP]
	rlca
	rlca
	call .barColor
	inc b
	dec b
	jr nz, .slot1
	push hl
	ld hl, StatusInkTable.cnf
	call .putColor ; slot 1: CNF's ink
	ld hl, hStatusLetterInk
	add hl, bc ; b = 0 here and c = the side: this side's byte of the INK REGISTER
	ld a, [hl]
	and a
	ASSERT STATUS_INK_NONE == 0
	jr z, .noStatusInk
	ld c, a
	ld hl, StatusInkTable - PAL_COLOR_SIZE
	add hl, bc
	add hl, bc
	ASSERT PAL_COLOR_SIZE == 2
	call .putColor ; slot 2: the ink the register names
	pop hl
	jr .slot3
.noStatusInk
	pop hl
	jr .slot2
.slot1
	call .putColor
.slot2
	call .putColor
.slot3
	call .putColor
	pop bc
	ret

.barColor
; IN  a = rBGP turned so that the slot's two bits are bits 1-0
; OUT hl = the address in wGBCPal of the bar's colour at that shade
	and %11
	add a
	ASSERT PAL_COLOR_SIZE == 2
	add LOW(wGBCPal)
	ld l, a
	ld h, HIGH(wGBCPal)
	ASSERT HIGH(wGBCPal) == HIGH(wGBCPal + PALETTE_SIZE - 1)
	ret

.putColor
; One colour from hl to de. hl is kept; de is the next slot.
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	inc de
	ret

PreloadPacket10LetterPalettes:
; LoadBGMapAttributes's, at its head, for packet 10: both palettes in the form the command asks for, before
; the attributes are loaded. With the LCD on the eight colours take an H-blank each, wherever the beam is,
; and that cannot show: everything that comes here either writes what the palettes already hold (the same
; register and rBGP, and every HP-bar palette and PAL_BLACK share their colours 0 and 3: a palette command
; with the HUD up, and AnimationShakeEnemyHUD, which loads packet 10 with no command), or runs on a
; whited-out screen, or has no HUD on screen (a battle's first), or had PreloadSilhouetteLetterPalettes write
; the same values in its raster window. bc kept.
	push bc
	ld b, STATUS_PAL_FORM_COMMAND
	ld de, wBGPPalsBuffer
	ld c, 1
	call BuildStatusLetterPalette ; the enemy's: BG palette 5
	dec c
	call BuildStatusLetterPalette ; the player's: BG palette 6
	call WriteStatusLetterPalettes
	pop bc
	ret

PreloadSilhouetteLetterPalettes::
; Called in front of a SET_PAL_BATTLE_BLACK that runs with a HUD on screen (the black out: HandlePlayerBlackOut,
; engine/battle/core.asm; the surrender: engine/battle/surrender.asm): both palettes in the silhouette form,
; written in a raster window below the status cells. The command that follows writes BG palette 0 (the
; player's HP bar) and BG palette 1 (the enemy's) some 12 and 28 scanlines later, in the same frame: bars and
; letters turn black together. Its window closes earlier than an rBGP change's so that BG palette 1 is whole
; before V-blank. The command has not run yet, so the form is asked for (wLastPalCommand has one writer, the
; command itself); rBGP is $E4 at both callers, where this form is what the command's own packet 10 writes again.
; Returns at once on the DMG / SGB, and when the last palette command is not a battle's (no caller is in that
; case today: both sites are on the battle screen).
	ldh a, [hGBC]
	and a
	ret z
	ld a, [wLastPalCommand]
	cp SET_PAL_BATTLE + 1
	ret nc
	ld b, STATUS_PAL_FORM_SILHOUETTE
	jr PreloadStatusLetterPalettes.build

PreloadStatusLetterPalettes::
; Called by home's UpdateGBCPal_BGP on an rBGP change, BEFORE palettes 0-3 are rebuilt, when the last palette
; command is a battle's (home has made both tests of the gate). Both palettes are built for the new rBGP and
; then written while the beam is in a window of scanlines:
;   - not before STATUS_PAL_WINDOW_FIRST_LY: the status cells show on scanlines 8-23 (the enemy's) and 64-79
;     (the player's) at the most, so the frame being drawn keeps the old shade on both rows;
;   - not after STATUS_PAL_WINDOW_LAST_LY: the eight colours take eight or nine scanlines, and
;     _UpdateGBCPal_BGP then needs ten more before it waits for V-blank, where palettes 0-3 are written:
;     that wait starts on scanline 131 at the latest. Later than that line, the write waits for the next
;     frame's window.
; So palettes 5, 6 and 0-3 all change between the same two frames. Nearly every caller comes here early in a
; frame (right after a DelayFrame): the wait for the window's first line is time that the wait for V-blank
; took before.
; With the LCD off there is no beam to wait for (rLY does not move): the colours are written at once.
	ld b, STATUS_PAL_FORM_COMMAND
.build
; both palettes first, side by side in wBGPPalsBuffer (free here: _UpdateGBCPal_BGP, which fills it, runs later)
	ld de, wBGPPalsBuffer
	ld c, 1
	call BuildStatusLetterPalette ; the enemy's: BG palette 5
	dec c
	call BuildStatusLetterPalette ; the player's: BG palette 6
	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK
	jr z, WriteStatusLetterPalettes
	inc b
	dec b ; the form
	ld b, STATUS_PAL_WINDOW_LAST_LY + 1
	jr z, .waitForWindow
	ld b, STATUS_PAL_SILHOUETTE_LAST_LY + 1
.waitForWindow
	ldh a, [rLY]
	cp STATUS_PAL_WINDOW_FIRST_LY
	jr c, .waitForWindow ; above the window: wait for its first line
	cp b
	jr nc, .waitForWindow ; below it: wait for the next frame's
; fall through

WriteStatusLetterPalettes:
; The two palettes built in wBGPPalsBuffer, the enemy's first, to BG palettes 5 and 6.
	ld a, (5 << 3) | $80 ; BG palette 5, color 0, auto-increment: 6 follows it
	ldh [rBGPI], a
	ld hl, wBGPPalsBuffer
	ld c, 2 * NUM_PAL_COLORS
	ASSERT NUM_ACTIVE_PALS >= 2 ; the buffer holds both
	jp TransferBGPalColors

WriteStatusLetterPaletteSynced::
; SyncStatusLetterInk's (engine/battle/hud_status.asm), at the tail of a HUD draw whose persistent-status
; label has another ink than the INK REGISTER held; the register already names the new one.
; IN  c = 0 the player's letters (BG palette 6), 1 the enemy's (BG palette 5)
; That side's palette is written at the very start of a V-blank, and the handler of that same V-blank is made
; to copy the third of the tile map that holds the label: the new ink and the new tiles reach the screen in
; the same frame. (The HUD draw switched the BG transfer off when it began: until now the screen shows the old
; label in the old ink.)
; What this leans on:
;   - the wait under the di is for the V-blank REQUEST (rIF) and for scanline 144, both. Every HUD draw is
;     entered with interrupts enabled (nothing wraps one in a di), so a request seen under the di was raised
;     after it, at the start of scanline 144, and the scanline test passes at once. That test is for the day
;     this stops being true: a stale request then waits for scanline 144, so the burst stays inside V-blank
;     (on its first two scanlines at the latest, when the wait itself begins on scanline 144) instead of going
;     out wherever the beam is (palette RAM drops a write made while a line is being drawn, and the register
;     already names the new ink: no later HUD draw would repair the palette). The scanline does not
;     replace the request: after a request that was cleared (LoadBGMapAttributes ends that way) the ink would
;     be written with no handler behind it to copy the tiles;
;   - only V-blank is ever SERVICED in a battle (rIE holds VBLANK and TIMER and the timer never runs; the
;     STAT request that the Yellow intro leaves selected is raised on every H-blank and never enabled), so
;     holding interrupts off for up to a frame loses nothing: the handler still runs once in that frame;
;   - the handler starts some 70 M-cycles later than it would have (the eight writes are unrolled for that):
;     its tile-map copy and its OAM DMA still end inside V-blank;
;   - forcing the transfer's rotation is harmless (the byte only says which third goes next), and each label
;     lies inside one third: the enemy's HUD is rows 0-3 (the top third), the player's rows 7-11 (the middle).
; Nothing is written while the last palette command is not a battle's: another screen's attributes are loaded,
; and the SET_PAL_BATTLE that brings the battle screen back builds from the register
; (PreloadPacket10LetterPalettes). No HUD draw runs under another screen's command today.
; With the LCD off there is no V-blank to wait for and nothing shows: the four colours are written at once and
; nothing else is touched (no HUD draw runs with the LCD off today either).
	ld a, [wLastPalCommand]
	cp SET_PAL_BATTLE + 1
	ret nc
	ld b, STATUS_PAL_FORM_COMMAND
	ld de, wBGPPalsBuffer
	call BuildStatusLetterPalette ; before any wait
; b = the palette's index byte, c = the third of the tile map its label is in
	ld a, c
	and a
	lb bc, (6 << 3) | $80, TRANSFERMIDDLE ; the player's: BG palette 6, color 0, auto-increment
	jr z, .gotSide
	lb bc, (5 << 3) | $80, TRANSFERTOP ; the enemy's: BG palette 5
.gotSide
	ld hl, wBGPPalsBuffer
	ld de, rBGPD
	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK
	jr nz, .lcdOn
; the LCD is off: no V-blank will come and nothing shows. The four colours, and no di, no switch, no ei.
	ld a, b
	ldh [rBGPI], a
	ld c, NUM_PAL_COLORS
	jp TransferBGPalColors ; hl = wBGPPalsBuffer; with the LCD off it writes without waiting
.lcdOn
	di
.waitForVBlank
	ldh a, [rIF]
	bit VBLANK, a
	jr z, .waitForVBlank
	ldh a, [rLY]
	cp STATUS_PAL_SYNC_LY
	jr nz, .waitForVBlank ; a request that is not this scanline's: wait for scanline 144
.write
	ld a, b
	ldh [rBGPI], a
	ld a, [hli]
SyncedStatusLetterPaletteWrite:: ; the first of the eight palette writes, labelled for the tests
	ld [de], a
REPT PALETTE_SIZE - 1
	ld a, [hli]
	ld [de], a
ENDR
	ld a, c
	ldh [hAutoBGTransferPortion], a
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ei ; the V-blank handler, pending, runs now: its BG transfer copies that third
	ret
