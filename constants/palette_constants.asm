; monochrome palette color ids
	const_def
	const SHADE_WHITE ; %00
	const SHADE_LIGHT ; %01
	const SHADE_DARK  ; %10
	const SHADE_BLACK ; %11
DEF NUM_PAL_COLORS EQU const_value

DEF PAL_COLOR_SIZE EQU 2
DEF PALETTE_SIZE EQU NUM_PAL_COLORS * PAL_COLOR_SIZE

DEF NUM_ACTIVE_PALS EQU 4

; wMapPalOffset: how many bytes before FadePal4 LoadGBPal reads a map's palettes (home/fade.asm)
DEF DARKNESS_DIM  EQU 3 ; FadePal3: darker, and everything still reads
DEF DARKNESS_DARK EQU 6 ; FadePal2: the player and the boulders vanish into the floor

; pal/blk packets
; SetPalFunctions indexes (see engine/gfx/palettes.asm)
	const_def
	const SET_PAL_BATTLE_BLACK             ; $00
	const SET_PAL_BATTLE                   ; $01
	const SET_PAL_TOWN_MAP                 ; $02
	const SET_PAL_STATUS_SCREEN            ; $03
	const SET_PAL_POKEDEX                  ; $04
	const SET_PAL_SLOTS                    ; $05
	const SET_PAL_TITLE_SCREEN             ; $06
	const SET_PAL_GENERIC                  ; $07
	const SET_PAL_OVERWORLD                ; $08
	const SET_PAL_PARTY_MENU               ; $09
	const SET_PAL_POKEMON_WHOLE_SCREEN     ; $0A
	const SET_PAL_GAME_FREAK_INTRO         ; $0B
	const SET_PAL_TRAINER_CARD             ; $0C
	const SET_PAL_SURFING_PIKACHU_TITLE    ; $0D
	const SET_PAL_SURFING_PIKACHU_MINIGAME ; $0E

DEF SET_PAL_PARTY_MENU_HP_BARS EQU $fc
DEF SET_PAL_DEFAULT EQU $ff

; sgb palettes
; SuperPalettes indexes (see data/sgb/sgb_palettes.asm)
	const_def
	const PAL_ROUTE                ; $00
	const PAL_PALLET               ; $01
	const PAL_VIRIDIAN             ; $02
	const PAL_PEWTER               ; $03
	const PAL_CERULEAN             ; $04
	const PAL_LAVENDER             ; $05
	const PAL_VERMILION            ; $06
	const PAL_CELADON              ; $07
	const PAL_FUCHSIA              ; $08
	const PAL_CINNABAR             ; $09
	const PAL_INDIGO               ; $0A
	const PAL_SAFFRON              ; $0B
	const PAL_TOWNMAP              ; $0C
	const PAL_LOGO1                ; $0D
	const PAL_LOGO2                ; $0E
	const PAL_CERULEAN_CAVE        ; $0F - a purple that recalls who lives at the bottom. It took the place of vanilla's
	                               ;       PAL_0F, which nothing used, so that no id moved and no row was added.
	const PAL_MEWMON               ; $10
	const PAL_BLUEMON              ; $11
	const PAL_ORANGEMON               ; $12 — era PAL_REDMON. O claro dele
	                               ;       e' 31,17,00: laranja. So' o
	                               ;       escuro e' vermelho.
	const PAL_CYANMON              ; $13
	const PAL_PURPLEMON            ; $14
	const PAL_BROWNMON             ; $15
	const PAL_GREENMON             ; $16
	const PAL_PINKMON              ; $17
	const PAL_YELLOWMON            ; $18
	const PAL_GREYMON              ; $19
	const PAL_SLOTS1               ; $1A
	const PAL_SLOTS2               ; $1B
	const PAL_SLOTS3               ; $1C
	const PAL_SLOTS4               ; $1D
	const PAL_BLACK                ; $1E
	const PAL_GREENBAR             ; $1F
	const PAL_YELLOWBAR            ; $20
	const PAL_REDBAR               ; $21
	const PAL_CAVE                 ; $22
	const PAL_GAMEFREAK            ; $23
	const PAL_PIKACHUS_BEACH       ; $24
	const PAL_PIKACHUS_BEACH_TITLE ; $25
	const PAL_DREIGON              ; $26 — Forte's superboss portrait. APPENDED,
	                               ;       never inserted: these ids index two
	                               ;       fixed tables and a renumber repaints
	                               ;       the whole game.
	const PAL_OLIVEMON             ; $27 — o "cinzento" do vanilla, que nunca
	                               ;       foi cinzento: 20,23,10 e' azeitona.
	                               ;       Trazido de volta para a linha GEODUDE
	                               ;       + CUBONE + ONIX + AERODACTYL. A linha
	                               ;       do MACHOP saiu daqui a 2026-08-18
	                               ;       (STONE/STEEL/IRON), por isso o azeitona
	                               ;       quer dizer ROCHA e mais nada.
	const PAL_AZUREMON             ; $28 — azul intermedio, o ponto medio exacto
	                               ;       entre CYANMON e BLUEMON
	const PAL_ROSEMON                ; $29 — R1 rosa claro
	const PAL_SAGEMON                ; $2A — G1 verde-seco
	const PAL_VIOLETMON              ; $2B — D2 violeta-sujo
	const PAL_LAVENDERMON            ; $2C — P2 lavanda
	const PAL_STONEMON               ; $2D — MACHOP: pedra clara a puxar ao verde-marinho. APPENDADA,
	                                 ;       nunca inserida.
	const PAL_STEELMON               ; $2E — MACHOKE: cinza-aco frio, o meio da linha. APPENDADA,
	                                 ;       nunca inserida.
	const PAL_IRONMON                ; $2F — MACHAMP: aco escuro, o azul da artwork. APPENDADA,
	                                 ;       nunca inserida.
	const PAL_SLATEMON               ; $30 — o cinzento NEUTRO do kep-hack (GREYMON deles), desde
	                                 ;       2026-08-30: MAGNEMITE/MAGNETON/ONIX/RHYHORN/
	                                 ;       RHYDON. O nosso PAL_GREYMON e o rosado vanilla (fica
	                                 ;       para MAROWAK e para a Pokemon Tower). APPENDADA.
	const PAL_FOREST                 ; $31 - VIRIDIAN FOREST's map palette: a drier green for colour 1 and teal
	                                 ;       for colour 2 (the trees; sky blue in PAL_ROUTE). GetPal_Overworld
	                                 ;       picks it by map id. APPENDED, never inserted.
	const PAL_GARDEN                 ; $32 - BILL's GARDEN's map palette: green for colour 1 and coral for
	                                 ;       colour 2 (the trees, half of the tall grass, the roof; sky blue in
	                                 ;       PAL_ROUTE). GetPal_Overworld picks it by map id. APPENDED.
	const PAL_BLOSSOM                ; $33 - light grey and magenta; colour 3 is true black (00,00,00) on GBC
	                                 ;       and 06,06,06, that table's own black, in the SGB row. Kept for later
	                                 ;       use: no map and no species uses it yet. APPENDED, never inserted.
	const PAL_SAFARI                 ; $34 - the SAFARI ZONE's map palette (the gate, the four areas, the five
	                                 ;       houses): terracotta for colour 1 (the ground, the roofs, the floors,
	                                 ;       the sprites: PAL_BROWNMON's, the colour of most of its Pokemon) and
	                                 ;       green for colour 2 (the trees, the water, the walls). GetPal_Overworld
	                                 ;       picks it by map id. APPENDED, never inserted.
DEF NUM_SGB_PALS EQU const_value

; v1.0 (2026-11-02): the same colours as another palette in both tables, so no row of their own: 16 bytes each. To give
; one colours of its own again, make it a const and add its two rows at the end of the tables. Every id is used by name
; (the `.town` rule reads the cities' ids, $01-$0B, and PAL_GREENBAR + a bar colour reads $1F-$21: neither moved).
DEF PAL_BADGE            EQU PAL_CAVE
DEF PAL_PIKACHU_PORTRAIT EQU PAL_MEWMON ; the overworld emotes
DEF PAL_PIKAMON          EQU PAL_MEWMON ; PIKACHU, real and fake; RAICHU, SANDSHREW and WEEDLE keep PAL_YELLOWMON
