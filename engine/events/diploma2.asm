DEF CIRCLE_TILE_ID EQU $10

_DisplayDiploma:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	ld de, SurfingPikachu3Graphics
	ld hl, vChars2
	lb bc, BANK(SurfingPikachu3Graphics), (SurfingPikachu3GraphicsEnd - SurfingPikachu3Graphics) / $10
	call CopyVideoData

	hlcoord 0, 0
	call Func_e9bdf

	hlcoord 0, 0
	call Func_e9beb

	hlcoord 19, 0
	call Func_e9beb

	ld a, $00
	hlcoord 0, 0
	ld [hl], a
	hlcoord 19, 0
	ld [hl], a

	ld de, DiplomaText
	hlcoord 5, 2
	call PlaceString

	ld de, DiplomaPlayer
	hlcoord 3, 4
	call PlaceString

	ld de, wPlayerName
	hlcoord 10, 4
	call PlaceString

	ld de, DiplomaCongrats
	hlcoord 2, 6
	call PlaceString

	ld de, DiplomaGameFreak
	hlcoord 9, 16
	call PlaceString

	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	ld a, $01
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	call GBPalNormal
	ret

DiplomaText:
	db CIRCLE_TILE_ID, "Diploma", CIRCLE_TILE_ID, "@"

DiplomaPlayer:
	db "Player@"

DiplomaCongrats:
	db   "Congrats! This"
	next "diploma certifies"
	next "that you have"
	next "completed your"
	next "#DEX.@"

DiplomaGameFreak:
	db "GAME FREAK@"

; v0.7: a second diploma page (PLAY TIME, plus bonus art at a full 151 #DEX)
; used to live here as Func_e9ad3. It was print-only: the caller drew it with
; auto BG transfer switched off, copied the tilemap straight into the printer
; buffer and restored the screen, so it never once reached the player's eyes.
; It went with the Game Boy Printer. Its art is still in the repo history
; (and its tiles are still inside surfing_pikachu_3.2bpp) if it is ever wanted
; as a real on-screen page.

Func_e9bdf:
	ld c, 10
.asm_e9be1
	ld [hl], $02
	inc hl
	ld [hl], $01
	inc hl
	dec c
	jr nz, .asm_e9be1
	ret

Func_e9beb:
	ld c, 9
	ld de, SCREEN_WIDTH
.asm_e9bed
	ld [hl], $04
	add hl, de
	ld [hl], $03
	add hl, de
	dec c
	jr nz, .asm_e9bed
	ret

SurfingPikachu3Graphics: INCBIN "gfx/surfing_pikachu/surfing_pikachu_3.2bpp"
SurfingPikachu3GraphicsEnd:
