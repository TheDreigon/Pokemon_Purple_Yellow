; PIKACHU'S BEACH hi-score board, shown by the machine in the SUMMER BEACH
; HOUSE.
;
; v0.7: this was the drawing half of PrintSurfingMinigameHighScore. The screen
; was already reachable without a Game Boy Printer — answering "no" to the old
; "PRINT it out?" prompt drew exactly this and waited for a button — so the
; removal of the printer only cost the prompt, not the board.

DisplaySurfingMinigameHighScore::
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	ld de, SurfingPikachu2Graphics
	ld hl, vChars2
	lb bc, BANK(SurfingPikachu2Graphics), (SurfingPikachu2GraphicsEnd - SurfingPikachu2Graphics) / $10
	call CopyVideoData
	hlcoord 0, 0
	call .PlaceRowAlternatingTiles
	hlcoord 0, 17
	call .PlaceRowAlternatingTiles
	hlcoord 0, 0
	call .PlaceColumnAlternatingTiles
	hlcoord 19, 0
	call .PlaceColumnAlternatingTiles
	ld a, $4
	hlcoord 0, 0
	ld [hl], a
	hlcoord 0, 17
	ld [hl], a
	hlcoord 19, 0
	ld [hl], a
	hlcoord 19, 17
	ld [hl], a
	ld de, .Tilemap1
	hlcoord 10, 8
	lb bc, 3, 8
	call SurfingHiScore_CopyBox
	ld de, .Tilemap2
	hlcoord 2, 11
	lb bc, 6, 16
	call SurfingHiScore_CopyBox
	ld de, .PikachusBeachString
	hlcoord 3, 2
	call PlaceString
	ld de, .HiScoreString
	hlcoord 9, 4
	call PlaceString
	ld de, .PointsString
	hlcoord 12, 6
	call PlaceString
	ld de, wPlayerName
	ld hl, wPlayerName
	ld bc, 0
.find_end_of_name
	ld a, [hli]
	inc c
	cp "@"
	jr nz, .find_end_of_name
	ld a, 8
	sub c
	jr nc, .got_name_length
	xor a
.got_name_length
	ld c, a
	hlcoord 2, 4
	add hl, bc
	call PlaceString
	call CopySurfingMinigameScore
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	call GBPalNormal
	ret

.PlaceRowAlternatingTiles:
	ld c, SCREEN_WIDTH / 2
.row_loop
	ld [hl], $0
	inc hl
	ld [hl], $1
	inc hl
	dec c
	jr nz, .row_loop
	ret

.PlaceColumnAlternatingTiles:
	ld c, SCREEN_HEIGHT / 2
	ld de, SCREEN_WIDTH
.col_loop
	ld [hl], $2
	add hl, de
	ld [hl], $3
	add hl, de
	dec c
	jr nz, .col_loop
	ret

.Tilemap1:
	db $7f, $7f, $10, $11, $12, $13, $14, $15
	db $0f, $3c, $3d, $3e, $20, $21, $30, $31
	db $4c, $4d, $4e, $50, $34, $1a, $51, $2d

.Tilemap2:
	db $7f, $7f, $7f, $7f, $7f, $7f, $16, $17, $18, $19, $7f, $1b, $1c, $1d, $1e, $1f
	db $7f, $7f, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $7f, $2e, $2f
	db $7f, $7f, $32, $33, $33, $35, $36, $37, $38, $39, $3a, $3b, $7f, $7f, $7f, $3f
	db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $40, $40, $40, $4f
	db $52, $52, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5d, $5e
	db $7f, $7f, $7f, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $7f, $7f, $7f

.PikachusBeachString:
	db "Pikachu's Beach@"
.HiScoreString:
	db "'s Hi-Score@"
.PointsString:
	db "Points@"

; b = height, c = width, de = source tilemap, hl = top-left tilemap address
; v0.7: was Diploma_Surfing_CopyBox. Its other caller was the diploma's PLAY
; TIME page, which only ever existed as printer output (it was drawn with
; auto BG transfer off and never reached the screen), so it went with the
; printer and this helper is now the hi-score board's alone.
SurfingHiScore_CopyBox:
.y
	push bc
	push hl
.x
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .x
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .y
	ret

CopySurfingMinigameScore:
	ld de, wSurfingMinigameHiScore + 1
	hlcoord 7, 6
	ld a, [de]
	call .BCDConvertScore
	ld a, [de]
.BCDConvertScore:
	ld c, a
	swap a
	and $f
	add -10
	ld [hli], a
	ld a, c
	and $f
	add -10
	ld [hli], a
	dec de
	ret

SurfingPikachu2Graphics: INCBIN "gfx/surfing_pikachu/surfing_pikachu_2.2bpp"
SurfingPikachu2GraphicsEnd:
