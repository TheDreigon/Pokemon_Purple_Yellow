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

; The battle HUD's status letters on the GBC (v1.0, 2026-11-12): the fifteen tiles of
; gfx/font/status_letters.png, in this order, loaded for the length of a battle over
; cells the font leaves blank (LoadStatusLetterTiles, engine/gfx/bg_map_attributes.asm)
; and written by engine/battle/hud_status.asm. They are the font's own letters drawn in
; colour index 2 (the persistent statuses) and 1 (CNF) instead of 3, so the status
; cells' palettes (BG 5 and 6) can give them an ink without touching the black of
; every other text. .claude/status_letters_build.py builds the PNG from the font and
; reads this list for the order.
; Two runs, because not every blank cell is free for a whole battle: $c0-$c8 is the
; EXP bar, $c9 the naming screen draws as a blank, $d0 is the HUD's ball, $d1 the "+",
; and $d3-$d4 are the STATS page's DEX label (reachable from the battle's party menu).
; $d2, $de and $df stay free.
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
	const CNF_TILE_C    ; $db
	const CNF_TILE_N    ; $dc
	const CNF_TILE_F    ; $dd
DEF NUM_STATUS_TILES_2 EQU const_value - STATUS_TILE_B

; The ink ids of the persistent-status labels (v1.0, 2026-11-12): what the INK REGISTER holds (hStatusLetterInk,
; one byte per side) and what the selector returns (BattlerStatusInkID, engine/battle/hud_status.asm). Ink id n
; is entry n - 1 of StatusInkTable (engine/gfx/bg_map_attributes.asm) and row n - 1 of StatusLetterTileIDs
; (hud_status.asm); ASSERTs next to both tables hold them to this order. 0 is "no status ink": the status slot
; of the palette then shows the text colour. CNF's ink is not an id: its palette slot is static.
	const_def
	const STATUS_INK_NONE    ; 0
	const STATUS_INK_PSN     ; 1
	const STATUS_INK_TOX     ; 2
	const STATUS_INK_BRN     ; 3
	const STATUS_INK_BRN_OUT ; 4 ; reserved (a burn whose fire is out: BRN's letters, another ink); nothing returns it yet
	const STATUS_INK_PAR     ; 5
	const STATUS_INK_SLP     ; 6
	const STATUS_INK_FRZ     ; 7
	const STATUS_INK_BLEED   ; 8 ; reserved; nothing returns it yet and it has no tiles
DEF NUM_STATUS_INKS EQU const_value - 1

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
