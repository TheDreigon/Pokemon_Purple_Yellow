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
; v1.0 (2026-11-10): a SWITCH swaps two slots' species under their OBJ palettes, and RedrawPartyMenu_ runs its
; palette command only after all six icons are drawn again: rebuild the slot palettes here, with the screen still
; off (the writes take no wait and show nothing), so both icons reappear in their new species' colours. On a first
; opening the last command is another screen's and nothing is loaded, or the slots get what the screen's next
; palette update would give them. GBC only, like LoadIconPalettes' two other callers (it writes rOBPI / rOBPD).
	ldh a, [hGBC]
	and a
	call nz, LoadIconPalettes
	jp EnableLCD

WriteMonPartySpriteOAMByPartyIndex:
; Write OAM blocks for the party mon in [hPartyMonIndex].
	push hl
	push de
	push bc
	call GetPartyMonSpriteID
	call WriteMonPartySpriteOAM
	pop bc
	pop de
	pop hl
	ret

; v1.0 (2026-11-10): the 16 bytes of vanilla's `.asm_7191f` (the $ff "no icon" branch, which copied wShadowOAM to
; the saved copy and returned) are gone: Yellow Legacy removed the `cp $ff / jr z` that reached it.

WriteMonPartySpriteOAMBySpecies:
; Write the OAM blocks of the one icon of the naming screen and the trade, in slot 0. Its graphics are the species
; in wcf91's (LoadMonPartySpriteGfx), and so are its colours (LoadIconPalettes, after SET_PAL_GENERIC_ICON).
	xor a
	ldh [hPartyMonIndex], a
	call GetPartyMonSpriteID

WriteMonPartySpriteOAM:
; Write the OAM blocks for the first animation frame into the OAM buffer and
; make a copy at wMonPartySpritesSavedOAM. v1.0 (2026-11-10): the push/pop af that
; kept a around WriteAsymmetricMonPartySpriteOAM went: that routine reads
; wOAMBaseTile, not a, and no caller passes anything in a.
	ld c, $10
	ld h, HIGH(wShadowOAM)
	ldh a, [hPartyMonIndex]
	swap a
	ld l, a
	add $10
	ld b, a
; v1.0 (2026-11-10): interrupts off from the attribute 0 that WriteAsymmetricMonPartySpriteOAM writes to the slot's
; palette, so the V-blank's OAM DMA never puts the icon on OBJ palette 0 for a frame (it did on redraws of the party
; menu with the screen on). Every caller runs with interrupts on; ~230 M-cycles, about two scanlines.
	di
	call WriteAsymmetricMonPartySpriteOAM ; hl ends past the 4th entry
	ldh a, [hPartyMonIndex]
	call SetIconOBJPalette ; before the copy: the animation flips back to it
	ei
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
; v1.0 (2026-11-10): a = the icon's party slot, hl = just past its four OAM entries (WriteAsymmetricMonPartySpriteOAM
; leaves it there). Their attribute bytes, written 0, get the slot's OBJ palette, IconOBJPalettes[a]: on the GBC the
; icon shows that palette, which LoadIconPalettes fills with the species' colours. Writes the whole byte: both
; callers (WriteMonPartySpriteOAM, LoadTownMap_Fly) come straight from WriteAsymmetricMonPartySpriteOAM, which wrote
; 0 there (no flip, no priority, DMG palette OBP0), so only the GBC palette bits are set; the DMG and the SGB read
; bit 4 there, which stays 0. Clobbers a, b, de, hl.
	ld de, IconOBJPalettes
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld a, [de]
	ld de, -4
	ld b, 4
	dec hl
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret

INCLUDE "data/pokemon/menu_icons.asm"

TradeBubbleIconGFX:  INCBIN "gfx/trade/bubble.2bpp"
