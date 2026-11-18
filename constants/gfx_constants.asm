DEF TILE_WIDTH EQU 8 ; pixels
DEF LEN_1BPP_TILE EQU 1 * TILE_WIDTH ; bytes
DEF LEN_2BPP_TILE EQU 2 * TILE_WIDTH ; bytes

DEF SCREEN_WIDTH  EQU 20
DEF SCREEN_HEIGHT EQU 18
DEF SCREEN_WIDTH_PX  EQU SCREEN_WIDTH  * TILE_WIDTH ; pixels
DEF SCREEN_HEIGHT_PX EQU SCREEN_HEIGHT * TILE_WIDTH ; pixels

DEF BG_MAP_WIDTH  EQU 32 ; tiles
DEF BG_MAP_HEIGHT EQU 32 ; tiles

DEF SPRITEBUFFERSIZE EQU 7 * 7 * LEN_1BPP_TILE

; DMGPalToGBCPal
DEF CONVERT_BGP  EQU 0
DEF CONVERT_OBP0 EQU 1
DEF CONVERT_OBP1 EQU 2

; HP bar
DEF HP_BAR_GREEN  EQU 0
DEF HP_BAR_YELLOW EQU 1
DEF HP_BAR_RED    EQU 2

; wShadowOAM
DEF NUM_SPRITE_OAM_STRUCTS EQU 40

; hAutoBGTransferEnabled
DEF TRANSFERTOP    EQU 0
DEF TRANSFERMIDDLE EQU 1
DEF TRANSFERBOTTOM EQU 2

; hRedrawRowOrColumnMode
DEF REDRAW_COL EQU 1
DEF REDRAW_ROW EQU 2

; tile list ids
; TileIDListPointerTable indexes (see data/tilemaps.asm)
	const_def
	const TILEMAP_MON_PIC
	const TILEMAP_SLIDE_DOWN_MON_PIC_7X5
	const TILEMAP_SLIDE_DOWN_MON_PIC_7X3
	const TILEMAP_GENGAR_INTRO_1
	const TILEMAP_GENGAR_INTRO_2
	const TILEMAP_GENGAR_INTRO_3
	const TILEMAP_GAME_BOY
	const TILEMAP_LINK_CABLE
DEF NUM_TILEMAPS EQU const_value

; The battle HUD's status letters on the GBC (v1.0, 2026-11-12): the fourteen tiles of
; gfx/font/status_letters.png, in this order, loaded for the length of a battle over
; cells the font leaves blank (LoadStatusLetterTiles, engine/gfx/bg_map_attributes.asm)
; and written by engine/battle/hud_status.asm. They are the font's own letters drawn in
; colour index 2 instead of 3, so the status cells' palettes (BG 5 and 6) can give them
; the ink of the label on screen without touching the black of every other text.
; v1.0 (2026-11-17): every label's letters are in index 2 (CNF's were in index 1 until
; then), and the set is the fourteen capitals the labels need. Every label is capitals:
; BRN and BRN_OUT share their letters and differ in ink alone.
; .claude/status_letters_build.py builds the PNG from the font and reads this list for
; the order; a constant of another name inside it is an error there.
; Two runs, because not every blank cell is free for a whole battle: $c0-$c8 is the
; EXP bar, $c9 the naming screen draws as a blank, $d0 is the HUD's ball, $d1 the "+",
; and $d3-$d4 are the STATS page's DEX label (reachable from the battle's party menu).
; $d2 and $dd stay free on the GBC; $de and $df are only the trainer card's, which no battle
; reaches. On the DMG and the SGB (hGBC = 0) these letters are never loaded, and
; $ca-$cf, $d2 and $d5-$de hold the SUBSTITUTE doll's tube instead (SUBBAR_DMG_*, data/battle/substitute_bar.asm;
; the GBC keeps the tube in VRAM bank 1).
	const_def $ca
	const STATUS_TILE_P ; $ca
	const STATUS_TILE_S ; $cb
	const STATUS_TILE_N ; $cc
	const STATUS_TILE_T ; $cd
	const STATUS_TILE_O ; $ce
	const STATUS_TILE_X ; $cf
DEF NUM_STATUS_TILES_1 EQU const_value - STATUS_TILE_P
	const_def $d5
	const STATUS_TILE_B ; $d5
	const STATUS_TILE_R ; $d6
	const STATUS_TILE_A ; $d7
	const STATUS_TILE_L ; $d8
	const STATUS_TILE_F ; $d9
	const STATUS_TILE_Z ; $da
	const STATUS_TILE_C ; $db
	const STATUS_TILE_D ; $dc
DEF NUM_STATUS_TILES_2 EQU const_value - STATUS_TILE_B
	ASSERT const_value <= $e0 ; the run ends where the font's cells end

; The ink ids of the HUD's labels (v1.0, 2026-11-12; one id space for every label since 2026-11-17): what the
; INK REGISTER holds (hStatusLetterInk, one byte per side: the id of the label that side's cells show) and what
; HUDLabelInkID returns (engine/battle/hud_status.asm). Ink id n is entry n - 1 of StatusInkTable
; (engine/gfx/bg_map_attributes.asm) and row n - 1 of StatusLetterTileIDs and of StatusLetterFontIDs
; (hud_status.asm); an ASSERT per id next to each table holds them to this order. 0 is "no ink": the status
; slot of the palette then shows the text colour. An id never exists without its row in every table
; (BuildStatusLetterPalette indexes the ink table by the register with no bound), and none is ever inserted.
	const_def
	const STATUS_INK_NONE    ; 0
	const STATUS_INK_PSN     ; 1
	const STATUS_INK_TOX     ; 2
	const STATUS_INK_BRN     ; 3
	const STATUS_INK_BRN_OUT ; 4 ; a burn whose fire is out (B R N, another ink); BattlerStatusInkID returns it since 2026-11-17
	const STATUS_INK_PAR     ; 5
	const STATUS_INK_SLP     ; 6
	const STATUS_INK_FRZ     ; 7
	const STATUS_INK_BLEED   ; 8 ; B L D, a #MON that bleeds; HUDLabelInkID returns it since 2026-11-18
	const STATUS_INK_CNF     ; 9
DEF NUM_STATUS_INKS EQU const_value - 1

; THE LABEL LIST (v1.0, 2026-11-17): the labels a side has at once, a bit each, in the order of precedence (bit 0
; first). BattlerStatusLabels (engine/battle/hud_status.asm) answers it; the PRIMARY label is the lowest bit set.
	const_def
	const STATUS_LABEL_HARD ; 0 ; the persistent status: TOX, PSN, BRN, FRZ, PAR or SLP (BattlerStatusInkID)
	const STATUS_LABEL_CNF  ; 1 ; confusion
	const STATUS_LABEL_BLD  ; 2 ; BLEED: the side bleeds (IsBattlerBleeding; since 2026-11-18)
	const STATUS_LABEL_SCR  ; 3 ; reserved for FEAR: never set yet
DEF NUM_STATUS_LABELS EQU const_value

; The form BuildStatusLetterPalette is asked for in b (engine/gfx/bg_map_attributes.asm): any non-zero value is
; the silhouette form.
DEF STATUS_PAL_FORM_COMMAND    EQU 0 ; what the last palette command asks for
DEF STATUS_PAL_FORM_SILHOUETTE EQU 1 ; black letters, whatever the command: the command that brings them has not run yet

; The scanlines (rLY) on which the letters' two palettes may start to be written while the battle screen is
; shown: below both rows of status cells (the enemy's on scanlines 8-23 at the most, the player's on 64-79: the
; window is never lower than WY 8 in a battle), and early enough for what the caller does next to be over before
; V-blank: palettes 0-3 on an rBGP change, BG palettes 0 and 1 of SET_PAL_BATTLE_BLACK after the silhouette
; preamble. The eight colours take one H-blank each, from the line that passed the test or the one after it.
DEF STATUS_PAL_WINDOW_FIRST_LY    EQU 80
DEF STATUS_PAL_WINDOW_LAST_LY     EQU 112 ; an rBGP change (PreloadStatusLetterPalettes)
DEF STATUS_PAL_SILHOUETTE_LAST_LY EQU 100 ; in front of SET_PAL_BATTLE_BLACK (PreloadSilhouetteLetterPalettes)
; The scanline a new label's ink is written on (WriteStatusLetterPaletteSynced): the first of V-blank, whose
; handler then copies the label's tiles.
DEF STATUS_PAL_SYNC_LY EQU SCREEN_HEIGHT_PX
