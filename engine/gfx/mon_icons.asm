AnimatePartyMon_ForceSpeed1:
	xor a
	ld [wCurrentMenuItem], a
	ld b, a
	inc a
	jr GetAnimationSpeed

; wPartyMenuHPBarColors contains the party mon's health bar colors
; 0: green
; 1: yellow
; 2: red
AnimatePartyMon::
	ld hl, wPartyMenuHPBarColors
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]

GetAnimationSpeed:
	ld c, a
	ld hl, PartyMonSpeeds
	add hl, bc
	ld a, [wOnSGB]
	xor $1
	add [hl]
	ld c, a
	add a
	ld b, a
	ld a, [wAnimCounter]
	and a
	jr z, .resetSprites
	cp c
	jr z, .animateSprite
.incTimer
	inc a
	cp b
	jr nz, .skipResetTimer
	xor a ; reset timer
.skipResetTimer
	ld [wAnimCounter], a
	jp DelayFrame
.resetSprites
	push bc
	ld hl, wMonPartySpritesSavedOAM
	ld de, wShadowOAM
	ld bc, $60
	call CopyData
	pop bc
	xor a
	jr .incTimer
.animateSprite
	push bc
	ld hl, wShadowOAMSprite00TileID
	ld bc, $10
	ld a, [wCurrentMenuItem]
	call AddNTimes
	ld a, [hl] ; contains tile number
	bit 2, a
	jr z, .firstFrame
	sub 8
.firstFrame
	add 4
	ld bc, 4
rept 3
	ld [hl], a
	add hl, bc
	inc a
endr
	ld [hl], a
.done
	pop bc
	ld a, c
	jr .incTimer

; Party mon animations cycle between 2 frames.
; The members of the PartyMonSpeeds array specify the number of V-blanks
; that each frame lasts for green HP, yellow HP, and red HP in order.
; On the naming screen, the yellow HP speed is always used.
PartyMonSpeeds:
	db 5, 16, 32

LoadAnimSpriteGfx:
; Load animated sprite tile patterns into VRAM during V-blank. hl is the address
; of an array of structures that contain arguments for CopyVideoData and a is
; the number of structures in the array.
	ld bc, $0
.loop
	push af
	push bc
	push hl
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyVideoData
	pop hl
	pop bc
	ld a, $6
	add c
	ld c, a
	pop af
	dec a
	jr nz, .loop
	ret

LoadMonPartySpriteGfx: ; nickname screen, etc
	call DisableLCD
	ld a, [wcf91] ; contains mon id
	ld [wd11e], a
	push de
	predef IndexToPokedex
	pop de
	ld a, [wd11e]
	dec a
	ld hl, MonPartyData
	ld e, a
	ld d, 0
	add hl, de

	ld a, [hl] ; read the icon id
	ld [wd11e], a
	cp $80 ; icon IDs >= $80 live in MonIcons2 (icons are split across two banks)
    jr c, .useMonIcons1          ; If the icon ID is < $80, use MonIcons
	; Handling icon IDs >= $80
    sub $80                     ; Subtract $80 from the icon ID
    ld hl, MonIcons2            ; Use MonIcons2
    jr .loadIcon1                ; Jump to the icon loading part
.useMonIcons1:
    ld hl, MonIcons             ; Use MonIcons
.loadIcon1:

	ld bc, $80
	call AddNTimes ; hl now contains pointer to mon icon
	
	ld a, [wd11e]
	cp $80
    jr c, .useMonIcons2          ; If the icon ID is < $80, use MonIcons
	; Handling icon IDs >= $80
    sub $80                     ; Subtract $80 from the icon ID
    ld a, BANK(MonIcons2)
    jr .loadIcon2                ; Jump to the icon loading part
.useMonIcons2:
    ld a, BANK(MonIcons)
.loadIcon2:

	ld de, vSprites
	call FarCopyData
	ld de, vSprites + $38 * $10
	ld hl, TradeBubbleIconGFX
	ld bc, $40
	call CopyData
	ld de, vSprites + $78 * $10
	ld hl, TradeBubbleIconGFX + $40
	ld bc, $40
	call CopyData
	jp EnableLCD

LoadMonPartySpriteGfxWithLCDDisabled: ; party menu
; Load mon party sprite tile patterns into VRAM immediately by disabling the
; LCD.
	call DisableLCD
	xor a
	push af
	ld hl, wPartySpecies
.loop
	; load each party mon's icon gfx into its $80-byte slot in vSprites
	ld a, [hli] ; contains mon id
	push hl
	ld [wd11e], a
	push de
	predef IndexToPokedex
	pop de
	ld a, [wd11e]
	dec a
	ld hl, MonPartyData
	ld e, a
	ld d, 0
	add hl, de
	
	ld a, [hl] ; read the icon id
	ld [wd11e], a

	cp $80 ; icon IDs >= $80 live in MonIcons2 (icons are split across two banks)
    jr c, .useMonIcons1          ; If the icon ID is < $80, use MonIcons

	; Handling icon IDs >= $80
    sub $80                     ; Subtract $80 from the icon ID
    ld hl, MonIcons2            ; Use MonIcons2
    jr .loadIcon1                ; Jump to the icon loading part

.useMonIcons1:
    ld hl, MonIcons             ; Use MonIcons
.loadIcon1:

	ld bc, $80
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	pop af
	push af
	push hl
	ld h, d
	ld l, e
	push hl
	ld hl, vSprites
	ld bc, $80
	call AddNTimes
	ld d, h
	ld e, l

	ld a, [wd11e]

	cp $80
    jr c, .useMonIcons2          ; If the icon ID is < $80, use MonIcons

	; Handling icon IDs >= $80
    sub $80                     ; Subtract $80 from the icon ID
    ld a, BANK(MonIcons2)
    jr .loadIcon2                ; Jump to the icon loading part

.useMonIcons2:
    ld a, BANK(MonIcons)
.loadIcon2:

	ld bc, $80
	pop hl
	call FarCopyData
	pop hl
	ld a, [wPartyCount]
	ld b, a
	pop af
	inc a
	cp b
	jr z, .done
	push af
	jr .loop
.done
	jp EnableLCD

WriteMonPartySpriteOAMByPartyIndex:
; Write OAM blocks for the party mon in [hPartyMonIndex].
	push hl
	push de
	push bc
	call GetPartyMonSpriteID
; v1.0 (2026-11-10): a = the species, for the icon's OBJ palette (SetIconOBJPalette)
	ldh a, [hPartyMonIndex]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	call WriteMonPartySpriteOAM
	pop bc
	pop de
	pop hl
	ret

.asm_7191f
	ld hl, wShadowOAM
	ld de, wMonPartySpritesSavedOAM
	ld bc, $60
	call CopyData
	pop bc
	pop de
	pop hl
	ret

WriteMonPartySpriteOAMBySpecies:
; Write OAM blocks for the party sprite of the species in [wcf91] (the naming
; screen and the trade animation both set it; the tiles came from it too,
; LoadMonPartySpriteGfx). v1.0 (2026-11-10): it read wMonPartySpriteSpecies,
; a value GetPartyMonSpriteID overwrote and the trade never wrote (that byte is
; wIconOBJPalActive now); wcf91 is read after that call, as the species for the
; icon's OBJ palette.
	xor a
	ldh [hPartyMonIndex], a
	call GetPartyMonSpriteID
	ld a, [wcf91]

WriteMonPartySpriteOAM:
; Write the OAM blocks for the first animation frame into the OAM buffer and
; make a copy at wMonPartySpritesSavedOAM. In: a = the species (v1.0,
; 2026-11-10: SetIconOBJPalette gives its icon an OBJ palette of its own).
	push af
	ld c, $10
	ld h, HIGH(wShadowOAM)
	ldh a, [hPartyMonIndex]
	swap a
	ld l, a
	add $10
	ld b, a
	call WriteAsymmetricMonPartySpriteOAM ; reads wOAMBaseTile, not a; hl ends past the 4th entry
	pop af
	dec hl ; the attribute byte of the fourth entry
	call SetIconOBJPalette
; Make a copy of the OAM buffer with the first animation frame written so that
; we can flip back to it from the second frame by copying it back.
.makeCopy
	ld hl, wShadowOAM
	ld de, wMonPartySpritesSavedOAM
	ld bc, $60
	jp CopyData

GetPartyMonSpriteID:
	ld a, [hPartyMonIndex]
	add a
	add a
	add a
	ld [wOAMBaseTile], a
	ret

SetIconOBJPalette:
; v1.0 (2026-11-10): DREADROW's icon is the one icon with colours of its own on
; the GBC: OBJ palette ICON_OBJ_PAL, which LoadIconSlotPalette fills from
; DreadrowIconColors. Every other icon keeps the screen's OBJ palette 0.
; In: a = the species, hl = the attribute byte of the last of the icon's four
; OAM entries (4 bytes apart). Writes the whole byte: both callers
; (WriteMonPartySpriteOAM, LoadTownMap_Fly) come straight from
; WriteAsymmetricMonPartySpriteOAM, which wrote 0 there (no flip, no priority,
; DMG palette OBP0), so 7 only sets the GBC palette bits; the DMG and the SGB
; ignore those bits. Then it raises wIconOBJPalActive, so palette 7 is the
; icon's until the next palette command but the party menu's (other sprites use
; palette 7 elsewhere: the GAME FREAK splash's falling stars), and on the GBC
; loads it at once: the FLY map and the nickname screen draw the icon after
; their palette command. Clobbers a, b, de, hl (DREADROW only).
	cp DREADROW
	ret nz
	ld de, -4
	ld b, 4
.loop
	ld [hl], ICON_OBJ_PAL
	add hl, de
	dec b
	jr nz, .loop
	ld [wIconOBJPalActive], a ; DREADROW: nonzero
	ldh a, [hGBC]
	and a
	ret z
	jp LoadIconSlotPalette

INCLUDE "data/pokemon/menu_icons.asm"

TradeBubbleIconGFX:  INCBIN "gfx/trade/bubble.2bpp"
