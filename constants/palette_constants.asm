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
	                               ;       + CUBONE + AERODACTYL. A linha
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
	                                 ;       and 06,06,06, that table's own black, in the SGB row. The DAY CARE's
	                                 ;       map palette since 2026-11-04 (both floors); no species uses it.
	                                 ;       APPENDED, never inserted.
	const PAL_SAFARI                 ; $34 - the SAFARI ZONE's map palette (the gate, the four areas, the five
	                                 ;       houses): terracotta for colour 1 (the ground, the roofs, the floors,
	                                 ;       the sprites: PAL_BROWNMON's, the colour of most of its Pokemon; since
	                                 ;       2026-11-08 about half of its browns wear PAL_DARKBROWNMON instead) and
	                                 ;       green for colour 2 (the trees, the water, the walls). GetPal_Overworld
	                                 ;       picks it by map id. APPENDED, never inserted.
; v1.0 (2026-11-04): six map palettes for interiors that took the colours of the town or route outside. Colour 1 paints
; the floor and the sprites' middle tone, colour 2 the details (wall stripes, machines, portholes, the tunnels' grid).
; GetPal_Overworld picks each by map id. APPENDED, never inserted.
	const PAL_ELECTRICA              ; $35 - the POWER PLANT: mustard and steel blue
	const PAL_MARINHO                ; $36 - the S.S. ANNE's ten interior maps (the dock keeps VERMILION's) and the
	                                 ;       three fishing brothers' houses (2026-11-05): navy, a third of the way to
	                                 ;       petrol blue since 2026-11-05 (apart from PAL_MART's blue)
	const PAL_PORYGON                ; $37 - the ROCKET HIDEOUT, and SILPH CO until GIOVANNI is beaten there:
	                                 ;       PORYGON's own blue and red (PAL_CINNABAR's two colours, swapped)
	const PAL_VEGAS                  ; $38 - the GAME CORNER and its prize room: purple and gold
	const PAL_TIJOLO                 ; $39 - the two underground paths, the FIGHTING DOJO and BRUNO's room (2026-11-05): brick
	const PAL_VINHO                  ; $3A - the POKEMON MANSION's four floors: wine and a dull purple
; v1.0 (2026-11-04): the routes' own palettes. Until v1.0 every route took PAL_ROUTE; RoutePalettes (engine/gfx/
; palettes.asm) gives each route its palette, and routes 1, 2, 15, 16, 18, 22 and 23 keep PAL_ROUTE (and 25 since 2026-11-05). Colour 1 paints
; the ground and a third of the tall grass (and the sprites' middle tone), colour 2 the water, the trees and another
; third of the tall grass: one colour for all three, so a route's water changes with its trees. Two routes that meet on
; foot stay within a CIEDE2000 distance of about 6 of each other on both colours, but for 16-17, 17-18, 19-20 and, since 2026-11-05, 24-25 (all chosen). APPENDED, never inserted.
	const PAL_ROUTE_SOPE             ; $3B - routes 3 and 9, at the foot of the mountains: a slightly drier green
	const PAL_ROUTE_PONTE            ; $3C - routes 4, 10, 11, 13 and 14: half-way between PAL_ROUTE and MARINHA
	const PAL_ROUTE_MENTA            ; $3D - routes 5 and 6: a fresh mint green
	const PAL_ROUTE_TOXICA           ; $3E - routes 7 and 8: a toxic green, purple trees and water
	const PAL_ROUTE_MARINHA          ; $3F - routes 12 and 24: a sea green, a deeper water
	const PAL_ROUTE_DOENTE           ; $40 - route 17: a sickly green, PAL_ROUTE's water
	const PAL_ROUTE_PRAIA            ; $41 - routes 19 and 21: sand, PAL_ROUTE's water
	const PAL_ROUTE_ROCHA_GELADA     ; $42 - route 20: a cold grey-green on the islands, PAL_ROUTE's water
	const PAL_ROUTE_BRISA            ; $43 - route 25 until 2026-11-05 (route 24's water, a green half-way to PONTE); UNUSED since route 25 took PAL_ROUTE, kept while Forte tries it in game
	const PAL_LAB                    ; $44 - the labs: OAK's LAB, BILL's house, the HALL OF FAME and CINNABAR LAB's
	                                 ;       four maps (2026-11-05). PAL_PALLET's vanilla colours in both tables, the
	                                 ;       lilac OAK's LAB had in vanilla. APPENDED, never inserted.
; v1.0 (2026-11-05): the Pokemon Centers, the marts, the CHAMPION's room and the passage houses. GetPal_InheritedNoMore
; picks the Centers, the marts and the passage houses by tileset (LAVENDER's two and the CELADON HOTEL, the INDIGO
; PLATEAU's lobby keep their town's colours) and the CHAMPION's room by its id. APPENDED, never inserted.
	const PAL_POKECENTER             ; $45 - every Pokemon Center: red
	const PAL_MART                   ; $46 - every mart: blue
	const PAL_CHAMPION               ; $47 - the CHAMPION's room: gold
	const PAL_GATE                   ; $48 - every passage house (the GATE and FOREST_GATE tilesets): a light peach
	                                 ;       floor, the bushes and the details green
	const PAL_DARKBROWNMON           ; $49 - PAL_BROWNMON x0.90, a touch darker (2026-11-08): the heavier and the
	                                 ;       final browns (PIDGEOT, RATICATE, the DIGLETT line, DODRIO, the HITMONs,
	                                 ;       KANGASKHAN, PINSIR, the KABUTO line) and FEAROW, a smaller step to its
	                                 ;       evolution DREADROW's darker browns; the rest keep PAL_BROWNMON
	const PAL_DREADROW               ; $4A - DREADROW's own (2026-11-09, the owner's pick "I1"): white, a dark
	                                 ;       brown 18,9,6, a near-black 4,2,1 and a pure black outline. APPENDED
DEF NUM_SGB_PALS EQU const_value

; v1.0 (2026-11-02): the same colours as another palette in both tables, so no row of their own: 16 bytes each. To give
; one colours of its own again, make it a const and add its two rows at the end of the tables. Every id is used by name
; (the `.town` rule reads the cities' ids, $01-$0B, and PAL_GREENBAR + a bar colour reads $1F-$21: neither moved).
DEF PAL_BADGE            EQU PAL_CAVE
DEF PAL_PIKACHU_PORTRAIT EQU PAL_MEWMON ; the overworld emotes
DEF PAL_PIKAMON          EQU PAL_MEWMON ; PIKACHU, real and fake; RAICHU, SANDSHREW and WEEDLE keep PAL_YELLOWMON

; v1.0 (2026-11-10): the GBC OBJ palette of DREADROW's party icon, the one icon with colours of its own
; (SetIconOBJPalette, engine/gfx/mon_icons.asm). Palette 7 has other users - the GAME FREAK splash draws five of its
; falling stars on it (SmallStarsWave*Coords, engine/movie/splash.asm) - so it is the icon's only while
; wIconOBJPalActive is set: from the icon's drawing to the next palette command but the party menu's, the only
; window in which LoadIconSlotPalette (engine/gfx/palettes.asm) rebuilds it. On the screens that show party icons
; (the party menu, also in battle; the nickname screen; the FLY map) no other sprite uses it.
DEF ICON_OBJ_PAL EQU 7
