LoadBGMapAttributes::
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
; the battle attributes (packet 11) point the EXP bar row at BG palette 4,
; which nothing in the vanilla engine ever loads -- load it here so those
; cells are never left pointing at an uninitialized palette
	sub 11 - 5 ; a = packet - 5 here; the battle attributes are packet 11
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
	dw BGMapAttributes_NidorinoIntro
	dw BGMapAttributes_TitleScreen
	dw BGMapAttributes_Slots
	dw BGMapAttributes_Pokedex
	dw BGMapAttributes_StatusScreen
	dw BGMapAttributes_Battle
	dw BGMapAttributes_WholeScreen
	dw BGMapAttributes_Unknown13

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
; MARSHBADGE
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
; v0.7 (his playtest, 2026-08-28): fill went from blue 00,17,31 to a lighter
; cyan per his request ("cor passar a ser cyan, mais claro do que é agora").
; Living here instead of GBCBasePalettes costs bank1C nothing (it has 1 byte).
	RGB 31,31,31, 16,26,31, 06,28,31, 03,03,03

LoadEXPBarPalette::
; Rebuild BG palette 4 from ExpBarBluePalette, shaded through the current
; rBGP value so the EXP bar whites out and fades with the rest of the screen.
; Called from two places: the packet-11 hook above (battle attribute load),
; and home's UpdateGBCPal_BGP right after _UpdateGBCPal_BGP, which only
; rebuilds palettes 0-3 (NUM_ACTIVE_PALS).
;
; This mirrors DMGPalToGBCPal (CONVERT_BGP case) + TransferCurBGPData with
; a = 4 rather than farcalling them: both take their argument in a, and a
; does not survive rst _Bankswitch (Bankswitch does `ld a, b` to map the
; callee's bank before dispatching). It deliberately does NOT write wLastBGP,
; so it can never mask a pending palette 0-3 rebuild in UpdateGBCPal_BGP.
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
	ld de, rBGPD
	ld hl, wGBCPal
	ld b, %10 ; mask for non-V-blank/non-H-blank STAT mode
	ldh a, [rLCDC]
	and rLCDC_ENABLE_MASK
	jr nz, .lcdEnabled
	REPT NUM_PAL_COLORS
		call .transferColorLCDDisabled
	ENDR
	ret
.lcdEnabled
	REPT NUM_PAL_COLORS
		call .transferColorLCDEnabled
	ENDR
	ret

.transferColorLCDEnabled
; in case we're already in H-blank or V-blank, wait for it to end, so the
; two writes below can't straddle the end of a blanking period
	ldh a, [rSTAT]
	and b
	jr z, .transferColorLCDEnabled
.notInBlankingPeriod
	ldh a, [rSTAT]
	and b
	jr nz, .notInBlankingPeriod
; fall through
.transferColorLCDDisabled
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld [de], a
	ret
