DEF BAG_ITEM_CAPACITY EQU 59
DEF PC_ITEM_CAPACITY  EQU 50

; text box IDs
	const_def 1
	const MESSAGE_BOX                       ; $01
	const_skip                              ; $02
	const MENU_TEMPLATE_03                  ; $03 unused
	const FIELD_MOVE_MON_MENU               ; $04
	const JP_MOCHIMONO_MENU_TEMPLATE        ; $05
	const USE_INFO_TOSS_MENU_TEMPLATE       ; $06
	const MENU_TEMPLATE_07                  ; $07 unused
	const JP_SAVE_MESSAGE_MENU_TEMPLATE     ; $08
	const JP_SPEED_OPTIONS_MENU_TEMPLATE    ; $09
	const_skip                              ; $0a
	const BATTLE_MENU_TEMPLATE              ; $0b
	const SWITCH_STATS_CANCEL_MENU_TEMPLATE ; $0c
	const LIST_MENU_BOX                     ; $0d
	const BUY_SELL_QUIT_MENU_TEMPLATE       ; $0e
	const MONEY_BOX_TEMPLATE                ; $0f
	const MENU_TEMPLATE_10                  ; $10 unused
	const MON_SPRITE_POPUP                  ; $11
	const JP_AH_MENU_TEMPLATE               ; $12
	const MONEY_BOX                         ; $13
	const TWO_OPTION_MENU                   ; $14
	const BUY_SELL_QUIT_MENU                ; $15
	const_skip                              ; $16
	const_skip                              ; $17
	const_skip                              ; $18
	const_skip                              ; $19
	const JP_POKEDEX_MENU_TEMPLATE          ; $1a
	const SAFARI_BATTLE_MENU_TEMPLATE       ; $1b

; two option menu constants
; TwoOptionMenuStrings indexes (see data/yes_no_menu_strings.asm)
	const_def
	const YES_NO_MENU       ; 0
	const NORTH_WEST_MENU   ; 1
	const SOUTH_EAST_MENU   ; 2
	const WIDE_YES_NO_MENU  ; 3
	const NORTH_EAST_MENU   ; 4
	const TRADE_CANCEL_MENU ; 5
	const HEAL_CANCEL_MENU  ; 6
	const NO_YES_MENU       ; 7
	const DIFFICULTY_SELECTION_MENU ; 8
DEF NUM_TWO_OPTION_MENUS EQU const_value

; menu exit method constants for list menus and the buy/sell/quit menu
DEF CHOSE_MENU_ITEM   EQU 1 ; pressed A
DEF CANCELLED_MENU    EQU 2 ; pressed B

; menu exit method constants for two-option menus
DEF CHOSE_FIRST_ITEM  EQU 1
DEF CHOSE_SECOND_ITEM EQU 2

; move mon constants
	const_def
	const BOX_TO_PARTY     ; 0
	const PARTY_TO_BOX     ; 1
	const DAYCARE_TO_PARTY ; 2
	const PARTY_TO_DAYCARE ; 3

; party menu types
; PartyMenuMessagePointers indexes (see engine/menus/party_menu.asm)
	const_def
	const NORMAL_PARTY_MENU    ; $00
	const USE_ITEM_PARTY_MENU  ; $01
	const BATTLE_PARTY_MENU    ; $02
	const TMHM_PARTY_MENU      ; $03
	const SWAP_MONS_PARTY_MENU ; $04
	const EVO_STONE_PARTY_MENU ; $05
; party menu message IDs
; PartyMenuItemUseMessagePointers indexes (see engine/menus/party_menu.asm)
	const_next $F0
DEF FIRST_PARTY_MENU_TEXT_ID EQU const_value
	const ANTIDOTE_MSG         ; $F0
	const BURN_HEAL_MSG        ; $F1
	const ICE_HEAL_MSG         ; $F2
	const AWAKENING_MSG        ; $F3
	const PARALYZ_HEAL_MSG     ; $F4
	const POTION_MSG           ; $F5
	const FULL_HEAL_MSG        ; $F6
	const REVIVE_MSG           ; $F7
	const RARE_CANDY_MSG       ; $F8

; naming screen types
	const_def
	const NAME_PLAYER_SCREEN ; 0
	const NAME_RIVAL_SCREEN  ; 1
	const NAME_MON_SCREEN    ; 2

; status screen protocol (see engine/pokemon/status_screen.asm)
; The party menu drives the screen's two pages from outside, so each predef has
; to say which button ended it - and a predef cannot answer in a register,
; because Predef ends in `pop af` and restores both the flags and a. The answer
; travels through wStatusScreenPageChange instead: the caller writes a mode
; byte on the way in, the predef overwrites it with an answer on the way out.
;
; Mode byte, written by the caller. A caller that does not set STATUS_OPTIN
; (battle, Bill's PC, the cable club) gets vanilla behaviour untouched: A or B
; ends the page and the d-pad does nothing.
DEF STATUS_OPTIN    EQU %10000000 ; "I drive the pages and read the answer back"
DEF STATUS_QUIET    EQU %00000001 ; compose behind the page already on screen:
                                  ; no white-out, BG transfer off until it is done
DEF STATUS_NOCRY    EQU %00000010 ; do not play the mon's cry on this draw
DEF STATUS_NOWAIT   EQU %00000100 ; draw and return; another page draws over it
DEF STATUS_CRYAFTER EQU %00001000 ; page 2: play the cry once the page is up
DEF STATUS_KEEPPIC  EQU %00010000 ; same mon as the page just left: its picture
                                  ; is already in VRAM, so put the tile map
                                  ; entries back instead of decompressing again

; Answer, written by the predef. All have bit 7 clear, so a value left behind by
; an earlier visit can never be mistaken for an opt-in - but note that they DO
; share their low bits with the flags above (STATUS_OTHER_PAGE is bit-for-bit
; STATUS_QUIET | STATUS_NOCRY). Both predefs therefore start by calling
; StatusScreen_NormalizeMode, which zeroes the byte when bit 7 is clear, so no
; flag test below the opt-in has to worry about a stale answer.
	const_def
	const STATUS_CLOSED     ; 0
	const STATUS_PREV_MON   ; 1
	const STATUS_NEXT_MON   ; 2
	const STATUS_OTHER_PAGE ; 3

; How many frames Bill's doorway walk is allowed before the scene gives up and
; plays out where he stands. Lives in the low six bits of wd492, whose top two
; bits Bill's house already uses, so it costs no new WRAM. The walk itself is
; four steps, well under this.
DEF BILLSHOUSE_WALK_TIMEOUT EQU 60
