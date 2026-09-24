DEF NOT_VISITED EQU $fe

DisplayTownMap:
	call LoadTownMap
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	ld a, $1
	ldh [hJoy7], a
	ld a, [wCurMap]
	push af
	ld b, $0
	call DrawPlayerOrBirdSprite ; player sprite
	hlcoord 1, 0
	ld de, wcd6d
	call PlaceString
	ld hl, wShadowOAM
	ld de, wTileMapBackup
	ld bc, $10
	call CopyData
	ld hl, vSprites tile $04
	ld de, TownMapCursor
	lb bc, BANK(TownMapCursor), (TownMapCursorEnd - TownMapCursor) / $8
	call CopyVideoDataDouble
	xor a
	ld [wWhichTownMapLocation], a
	pop af
	jr .enterLoop

.townMapLoop
	hlcoord 0, 0
	lb bc, 1, 20
	call ClearScreenArea
	ld hl, TownMapOrder
	ld a, [wWhichTownMapLocation]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
.enterLoop
	push af ; the map id, for the twin cursor below
	call LoadTownMapEntry ; c = x, b = y, hl = name (v1.0 T32: two-byte coordinates)
	push hl
	call TownMapCoordsToOAMCoords
	ld a, $4
	ld [wOAMBaseTile], a
	ld hl, wShadowOAMSprite04
	call WriteTownMapSpriteOAM ; town map cursor sprite
	pop hl
	pop af
	push hl
	call DrawTwinCursor ; a = map id: DIGLETT's CAVE's other mouth, or hide it
	pop hl
	ld de, wcd6d
.copyMapName
	ld a, [hli]
	ld [de], a
	inc de
	cp $50
	jr nz, .copyMapName
	hlcoord 1, 0
	ld de, wcd6d
	call PlaceString
	ld hl, wShadowOAMSprite04
	ld de, wTileMapBackup + 16
	ld bc, $20 ; both cursor blocks, sprites 4-11 (the blink restores from here)
	call CopyData
.inputLoop
	call TownMapSpriteBlinkingAnimation
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON | D_UP | D_DOWN
	jr z, .inputLoop
	ld a, SFX_TINK
	call PlaySound
	bit 6, b
	jr nz, .pressedUp
	bit 7, b
	jr nz, .pressedDown
	xor a
	ld [wTownMapSpriteBlinkingEnabled], a
	ldh [hJoy7], a
	ld [wAnimCounter], a
	call ExitTownMap
	pop hl
	pop af
	ld [hl], a
	ret
.pressedUp
	ld a, [wWhichTownMapLocation]
	inc a
	cp TownMapOrderEnd - TownMapOrder ; number of list items
	jr nz, .noOverflow
	xor a
.noOverflow
	ld [wWhichTownMapLocation], a
	call IsTownMapStopHidden ; v1.0: a secret not yet visited - keep walking
	jr c, .pressedUp
	jp .townMapLoop
.pressedDown
	ld a, [wWhichTownMapLocation]
	dec a
	cp -1
	jr nz, .noUnderflow
	ld a, TownMapOrderEnd - TownMapOrder - 1 ; index of the last list item
.noUnderflow
	ld [wWhichTownMapLocation], a
	call IsTownMapStopHidden
	jr c, .pressedDown
	jp .townMapLoop

INCLUDE "data/maps/town_map_order.asm"

IsTownMapStopHidden:
; v1.0 (2026-09-24, Forte): three stops are secrets until the player has been
; inside - BILL's LAB, the POWER PLANT and the CERULEAN CAVE. They share the
; FLY slots' visited bits, so the Town Map skips them until then. Carry set =
; skip the stop at wWhichTownMapLocation. PALLET TOWN is never a secret, so
; the callers' loops always stop. Clobbers a, bc, hl.
	ld hl, TownMapOrder
	ld a, [wWhichTownMapLocation]
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl] ; the map id of the stop
	ld hl, TownMapSecretStops
.loop
	ld a, [hli]
	cp -1
	jr z, .shown ; not a secret
	cp b
	ld a, [hli] ; the fly slot (ld leaves the flags alone)
	jr nz, .loop
	ld c, a
	ld b, FLAG_TEST
	ld hl, wTownVisitedFlag
	predef FlagActionPredef ; c = the bit
	ld a, c
	and a
	jr nz, .shown
	scf
	ret
.shown
	and a
	ret

TownMapSecretStops:
; map id (as TownMapOrder lists it), fly slot
	db BILLS_HOUSE,      BILLS_LAB_FLY_SLOT
	db POWER_PLANT,      POWER_PLANT_FLY_SLOT
	db CERULEAN_CAVE_1F, CERULEAN_CAVE_FLY_SLOT
	db -1

DrawTwinCursor:
; a = map id. v1.0 (2026-09-22, Forte): DIGLETT's CAVE has two mouths, so
; when the cursor is on either, a second cursor (sprites 8-11) marks the
; other; on every other place those four sprites are parked off-screen ($a0,
; the value the blink itself uses to hide sprites).
	cp DIGLETTS_CAVE
	jr z, .route11
	cp DIGLETTS_CAVE_ROUTE_11
	jr z, .cave
	ld hl, wShadowOAMSprite08
	ld de, 4
	ld a, $a0
	ld [hl], a
	add hl, de
	ld [hl], a
	add hl, de
	ld [hl], a
	add hl, de
	ld [hl], a
	ret
.route11
	ld a, DIGLETTS_CAVE_ROUTE_11
	jr .draw
.cave
	ld a, DIGLETTS_CAVE
.draw
	call LoadTownMapEntry
	ld hl, wShadowOAMSprite08 ; TownMapCoordsToOAMCoords stores y/x through hl: aim it at the block itself
	call TownMapCoordsToOAMCoords
	ld a, $4
	ld [wOAMBaseTile], a
	ld hl, wShadowOAMSprite08
	jp WriteTownMapSpriteOAM

TownMapCursor:
	INCBIN "gfx/town_map/town_map_cursor.1bpp"
TownMapCursorEnd:

LoadTownMap_Nest:
	call LoadTownMap
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	call DisplayWildLocations
	call GetMonName
	hlcoord 1, 0
	call PlaceString
	ld h, b
	ld l, c
	ld de, MonsNestText
	call PlaceString
	call WaitForTextScrollButtonPress
	call ExitTownMap
	pop hl
	pop af
	ld [hl], a
	ret

MonsNestText:
	db "'s NEST@"

LoadTownMap_Fly::
	call ClearSprites
	call LoadTownMap
	ld a, $1
	ldh [hJoy7], a
	call LoadPlayerSpriteGraphics
	call LoadFontTilePatterns
	call LoadFlyMonIcon ; v1.0 (2026-09-24, Forte): the flier's own icon where the BIRD sprite went
	ld de, TownMapUpArrow
	ld hl, vChars1 tile $6d
	lb bc, BANK(TownMapUpArrow), (TownMapUpArrowEnd - TownMapUpArrow) / $8
	call CopyVideoDataDouble
	call BuildFlyLocationsList
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	hlcoord 0, 0
	ld de, ToText
	call PlaceString
	ld a, [wCurMap]
	ld b, $0
	call DrawPlayerOrBirdSprite
	ld hl, wFlyLocationsList
	decoord 18, 0
.townMapFlyLoop
	ld a, " "
	ld [de], a
	push hl
	push hl
	hlcoord 3, 0
	lb bc, 1, 15
	call ClearScreenArea
	pop hl
	ld a, [hl]
	ld b, $4
	call DrawPlayerOrBirdSprite ; draw bird sprite
	hlcoord 3, 0
	ld de, wcd6d
	call PlaceString
	ld c, 15
	call DelayFrames
	hlcoord 18, 0
	ld [hl], "▶"
	hlcoord 19, 0
	ld [hl], "▼"
	pop hl
.inputLoop
	push hl
	call DelayFrame
	call AnimateFlyMonIcon ; v1.0: the icon's two frames, in step with the blink counter
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	pop hl
	and A_BUTTON | B_BUTTON | D_UP | D_DOWN
	jr z, .inputLoop
	bit 0, b
	jr nz, .pressedA
	ld a, SFX_TINK
	call PlaySound
	bit 6, b
	jr nz, .pressedUp
	bit 7, b
	jr nz, .pressedDown
	jr .pressedB
.pressedA
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld a, [hl]
	ld [wDestinationMap], a
	ld hl, wd732
	set 3, [hl]
	inc hl
	set 7, [hl]
.pressedB
	xor a
	ld [wTownMapSpriteBlinkingEnabled], a
	ldh [hJoy7], a
	call GBPalWhiteOutWithDelay3
	pop hl
	pop af
	ld [hl], a
	ret
.pressedUp
	decoord 18, 0
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .wrapToStartOfList
	cp NOT_VISITED
	jr z, .pressedUp ; skip past unvisited towns
	jp .townMapFlyLoop
.wrapToStartOfList
	ld hl, wFlyLocationsList
	jp .townMapFlyLoop
.pressedDown
	decoord 19, 0
	dec hl
	ld a, [hl]
	cp $ff
	jr z, .wrapToEndOfList
	cp NOT_VISITED
	jr z, .pressedDown ; skip past unvisited towns
	jp .townMapFlyLoop
.wrapToEndOfList
	ld hl, wFlyLocationsList + NUM_FLY_SLOTS ; the $ff after the last slot
	jr .pressedDown

ToText:
	db "To@"

LoadFlyMonIcon:
; v1.0 (2026-09-24, Forte): the FLY cursor is the party icon of the Pokémon
; about to fly (wWhichPokemon, the party menu's pick), both frames, copied into
; the tiles the BIRD sprite used ($04-$0B; the bird was 12 tiles, an icon is
; 8). An icon's tile order is an overworld frame's (top-left, top-right,
; bottom-left, bottom-right), so WriteTownMapSpriteOAM draws it unchanged.
	ld a, [wWhichPokemon]
	ld hl, wPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	predef IndexToPokedex
	ld a, [wd11e]
	dec a
	ld hl, MonPartyData
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl] ; the icon id: $80 and up live in MonIcons2 (LoadMonPartySpriteGfx)
	ld de, MonIcons
	ld b, BANK(MonIcons)
	cp $80
	jr c, .inBank
	sub $80
	ld de, MonIcons2
	ld b, BANK(MonIcons2)
.inBank
	ld l, a
	ld h, 0
rept 7
	add hl, hl ; id * $80, an icon's size
endr
	add hl, de
	ld d, h
	ld e, l
	ld c, 8 ; tiles: both frames
	ld hl, vSprites tile $04
	jp CopyVideoData

AnimateFlyMonIcon:
; Every frame of LoadTownMap_Fly's input loop: the cursor's four OAM entries
; (sprites 32-35, WritePlayerOrBirdSpriteOAM) show frame 1 (tiles 4-7) or
; frame 2 (tiles 8-11) by bit 3 of a frame counter, eight frames each, the
; party menu's pace for a healthy Pokémon. wAnimCounter is the blink's, but
; the blink (TownMapSpriteBlinkingAnimation) only runs from DisplayTownMap's
; loop and the nest page, never here, so this loop owns the counter (it is
; zeroed on the way out with the blink flag).
	ld hl, wAnimCounter
	inc [hl]
	ld a, [hl]
	and 8
	srl a
	add 4 ; 4 or 8
	ld hl, wShadowOAMSprite32 + 2 ; the tile id of the first entry
	ld de, 4
rept 3
	ld [hl], a
	inc a
	add hl, de
endr
	ld [hl], a
	ret

BuildFlyLocationsList:
; v1.0 (2026-09-24, Forte): the menu lists the fly points in story order, not
; slot order. FlyDisplayOrder is the permutation (slot indices, $ff-terminated);
; the bit of wTownVisitedFlag that a slot owns does NOT move (it is saved, and
; a town's slot is its map id - MarkTownVisitedAndLoadMissableObjects). The
; list keeps NUM_FLY_SLOTS entries followed by $ff, so LoadTownMap_Fly's
; UP/DOWN/wrap code is untouched. Entry 0 must be PALLET TOWN: the menu shows
; entry 0 without the NOT_VISITED skip, and PALLET is the slot every save has.
; The bits are read through FlagActionPredef, so the flag array can be any
; width (three bytes for the nineteen slots).
	ld hl, wFlyAnimUsingCoordList
	ld [hl], $ff
	inc hl ; wFlyLocationsList
	ld de, FlyDisplayOrder
.loop
	ld a, [de] ; the slot to show next, $ff = end of the table
	inc de
	cp $ff
	jr z, .done
	push de
	push hl
	ld c, a ; c = the slot
	push bc
	ld b, FLAG_TEST
	ld hl, wTownVisitedFlag
	predef FlagActionPredef ; c = the bit
	ld a, c
	pop bc ; c = the slot again
	and a
	ld a, NOT_VISITED
	jr z, .store
	ld a, c ; visited: the map id the menu shows and flies to
	cp BILLS_LAB_FLY_SLOT
	jr c, .store ; a town: the slot IS the map id
; the slots past the eleven towns are interiors, listed under their own map id:
; the name and the marker come from that map's row in town_map_entries.asm, and
; FlyWarpDataPtr lands the player one cell below that map's door
	sub BILLS_LAB_FLY_SLOT
	ld hl, FlySlotMaps
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
.store
	pop hl
	pop de
	ld [hli], a
	jr .loop
.done
	ld [hl], $ff ; the terminator .wrapToEndOfList points at: wFlyLocationsList + NUM_FLY_SLOTS
	ret

FlySlotMaps:
; the map id of each slot from BILLS_LAB_FLY_SLOT up, in slot order
	db BILLS_HOUSE            ; BILLS_LAB_FLY_SLOT     -> "BILL's LAB"
	db MT_MOON_POKECENTER     ; MT_MOON_FLY_SLOT       -> "MT.MOON CENTER"
	db ROCK_TUNNEL_POKECENTER ; ROCK_TUNNEL_FLY_SLOT   -> "R.TUNNEL CENTER"
	db DAYCARE                ; DAY_CARE_FLY_SLOT      -> "DAY CARE"
	db POWER_PLANT            ; POWER_PLANT_FLY_SLOT   -> "POWER PLANT"
	db SEAFOAM_ISLANDS_1F     ; SEAFOAM_FLY_SLOT       -> "SEAFOAM ISLANDS"
	db VICTORY_ROAD_1F        ; VICTORY_ROAD_FLY_SLOT  -> "VICTORY ROAD"
	db CERULEAN_CAVE_1F       ; CERULEAN_CAVE_FLY_SLOT -> "CERULEAN CAVE"
FlySlotMapsEnd:
ASSERT FlySlotMapsEnd - FlySlotMaps == NUM_FLY_SLOTS - BILLS_LAB_FLY_SLOT, "FlySlotMaps must name every slot from BILLS_LAB_FLY_SLOT to NUM_FLY_SLOTS - 1, in slot order"

FlyDisplayOrder:
; the FLY menu's order (UP walks forward): the story's (Forte, 2026-09-24)
	db PALLET_TOWN
	db VIRIDIAN_CITY
	db PEWTER_CITY
	db MT_MOON_FLY_SLOT       ; the CENTER at MT.MOON's foot
	db CERULEAN_CITY
	db BILLS_LAB_FLY_SLOT
	db DAY_CARE_FLY_SLOT
	db VERMILION_CITY
	db ROCK_TUNNEL_FLY_SLOT   ; the CENTER at ROCK TUNNEL's north mouth
	db POWER_PLANT_FLY_SLOT
	db LAVENDER_TOWN
	db CELADON_CITY
	db SAFFRON_CITY
	db FUCHSIA_CITY
	db SEAFOAM_FLY_SLOT
	db CINNABAR_ISLAND
	db VICTORY_ROAD_FLY_SLOT
	db INDIGO_PLATEAU
	db CERULEAN_CAVE_FLY_SLOT
FlyDisplayOrderEnd:
	db -1
; the ASSERT proves the COUNT (LoadTownMap_Fly wraps at wFlyLocationsList +
; NUM_FLY_SLOTS); that the table is a permutation of the slots is checked by
; emu_test_flyslots.py, which reads it from this file.
ASSERT FlyDisplayOrderEnd - FlyDisplayOrder == NUM_FLY_SLOTS, "FlyDisplayOrder must have NUM_FLY_SLOTS entries: LoadTownMap_Fly wraps at wFlyLocationsList + NUM_FLY_SLOTS"

TownMapUpArrow:
	INCBIN "gfx/town_map/up_arrow.1bpp"
TownMapUpArrowEnd:

LoadTownMap:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	hlcoord 0, 0
	lb bc, $12, $12
	call TextBoxBorder
	call DisableLCD
	ld hl, WorldMapTileGraphics
	ld de, vChars2 tile $60
	ld bc, WorldMapTileGraphicsEnd - WorldMapTileGraphics
	ld a, BANK(WorldMapTileGraphics)
	call FarCopyData
	ld hl, MonNestIcon
	ld de, vSprites tile $04
	ld bc, MonNestIconEnd - MonNestIcon
	ld a, BANK(MonNestIcon)
	call FarCopyDataDouble
	hlcoord 0, 0
	ld de, CompressedMap
.nextTile
	ld a, [de]
	and a
	jr z, .done
	ld b, a
	and $f
	ld c, a
	ld a, b
	swap a
	and $f
	add $60
.writeRunLoop
	ld [hli], a
	dec c
	jr nz, .writeRunLoop
	inc de
	jr .nextTile
.done
	call EnableLCD
	ld b, SET_PAL_TOWN_MAP
	call RunPaletteCommand
	call Delay3
	call GBPalNormal
	xor a
	ld [wAnimCounter], a
	inc a
	ld [wTownMapSpriteBlinkingEnabled], a
	ret

CompressedMap:
	INCBIN "gfx/town_map/town_map.rle"

ExitTownMap:
; clear town map graphics data and load usual graphics data
	xor a
	ld [wTownMapSpriteBlinkingEnabled], a
	call GBPalWhiteOut
	call ClearScreen
	call ClearSprites
	call LoadPlayerSpriteGraphics
	call LoadFontTilePatterns
	call UpdateSprites
	jp RunDefaultPaletteCommand

DrawPlayerOrBirdSprite:
; a = map number
; b = OAM base tile
	push af
	ld a, b
	ld [wOAMBaseTile], a
	pop af
	call LoadTownMapEntry ; c = x, b = y, hl = name
	push hl
	call TownMapCoordsToOAMCoords
	call WritePlayerOrBirdSpriteOAM
	pop hl
	ld de, wcd6d
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp "@"
	jr nz, .loop
	ld hl, wShadowOAM
	ld de, wTileMapBackup
	ld bc, $a0
	jp CopyData

DisplayWildLocations:
	farcall FindWildLocationsOfMon
	call ZeroOutDuplicatesInList
	ld hl, wShadowOAM
	ld de, wBuffer ; the list of map ids FindWildLocationsOfMon built
.loop
	ld a, [de]
	cp $ff
	jr z, .exitLoop
	and a
	jr z, .nextEntry
	push hl
	call LoadTownMapEntry ; c = x, b = y; the list byte is left alone (it used
	                      ; to be overwritten with the packed coordinate)
	pop hl
	ld a, c
	cp 9 * 2
	jr nz, .draw
	ld a, b
	cp 1 * 2
	jr z, .nextEntry ; skip Cerulean Cave (tile x 9, y 1 - vanilla's `cp $19`; half tiles here)
.draw
	call TownMapCoordsToOAMCoords
	ld a, $4 ; nest icon tile no.
	ld [hli], a
	xor a
	ld [hli], a
.nextEntry
	inc de
	jr .loop
.exitLoop
	ld a, l
	and a ; were any OAM entries written?
	jr nz, .drawPlayerSprite
; if no OAM entries were written, print area unknown text
	hlcoord 1, 7
	lb bc, 2, 15
	call TextBoxBorder
	hlcoord 2, 9
	ld de, AreaUnknownText
	call PlaceString
	jr .done
.drawPlayerSprite
	ld a, [wCurMap]
	ld b, $0
	call DrawPlayerOrBirdSprite
.done
	ld hl, wShadowOAM
	ld de, wTileMapBackup
	ld bc, $a0
	jp CopyData

AreaUnknownText:
	db " AREA UNKNOWN@"

TownMapCoordsToOAMCoords:
; in: b = y, c = x in HALF tiles (v1.0 T32: whole bytes, so the map's 17 rows
;     and 20 columns fit, and a marker can sit between two blocks)
; out: b and [hl] = (y * 4) + 24, c and [hl+1] = (x * 4) + 24
;      - except on the last drawn row (tile row 17, y = 32), two pixels higher
	ld a, b
	add a
	add a
	add 24
; v1.0 (2026-09-25, Forte): on the last drawn row a 16x16 sprite loses its
; bottom four lines to the screen edge; two pixels up keeps fourteen of them,
; and the 8x8 marker underneath is still covered. Nest icons there move too.
	cp 32 * 4 + 24
	jr nz, .notLastRow
	sub 2
.notLastRow
	ld b, a
	ld [hli], a
	ld a, c
	add a
	add a
	add 24
	ld c, a
	ld [hli], a
	ret

WritePlayerOrBirdSpriteOAM:
	ld a, [wOAMBaseTile]
	and a
	ld hl, wShadowOAMSprite36 ; for player sprite
	jr z, WriteTownMapSpriteOAM
	ld hl, wShadowOAMSprite32 ; for bird sprite

WriteTownMapSpriteOAM:
	push hl

; Subtract 4 from c (X coord) and 4 from b (Y coord): c is at least 24, so the
; add always carries into h, which therefore starts at -5. (Vanilla had -4
; there and drew every cursor, bird and "you are here" one pixel low - v1.0,
; 2026-09-25, Forte's call after the cursor audit.)
	lb hl, -5, -4
	add hl, bc

	ld b, h
	ld c, l
	pop hl

WriteAsymmetricMonPartySpriteOAM:
; Writes 4 OAM blocks for a helix mon party sprite, since it does not have
; a vertical line of symmetry.
	lb de, 2, 2
.loop
	push de
	push bc
.innerLoop
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, [wOAMBaseTile]
	ld [hli], a
	inc a
	ld [wOAMBaseTile], a
	xor a
	ld [hli], a
	inc d
	ld a, 8
	add c
	ld c, a
	dec e
	jr nz, .innerLoop
	pop bc
	pop de
	ld a, 8
	add b
	ld b, a
	dec d
	jr nz, .loop
	ret

; v0.7 space pass (2026-08-17): WriteSymmetricMonPartySpriteOAM deleted —
; zero callers, and it lived in bank1C, the palette-starved bank: its 51
; bytes take the palette wall from 1 free byte to 52 (three more palettes).

ZeroOutDuplicatesInList:
; replace duplicate bytes in the list of wild pokemon locations with 0
	ld de, wBuffer
.loop
	ld a, [de]
	inc de
	cp $ff
	ret z
	ld c, a
	ld l, e
	ld h, d
.zeroDuplicatesLoop
	ld a, [hl]
	cp $ff
	jr z, .loop
	cp c
	jr nz, .skipZeroing
	xor a
	ld [hl], a
.skipZeroing
	inc hl
	jr .zeroDuplicatesLoop

LoadTownMapEntry:
; in: a = map number
; out: c = x, b = y (half tiles), hl = address of name. de is preserved.
; v1.0 (2026-09-22, T32): the entries carry x and y as whole bytes in half
; tiles (they were one packed nibble byte of whole tiles, which capped the
; markers at tile row 16 / column 17) and the result goes back in registers
; instead of a WRAM byte.
	cp FIRST_INDOOR_MAP
	jr c, .external
	ld bc, 5
	ld hl, InternalMapEntries
.loop
	cp [hl]
	jr c, .foundEntry
	add hl, bc
	jr .loop
.foundEntry
	inc hl
	jr .readEntry
.external
	ld hl, ExternalMapEntries
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
.readEntry
	ld a, [hli]
	ld c, a ; x
	ld a, [hli]
	ld b, a ; y
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

INCLUDE "data/maps/town_map_entries.asm"

INCLUDE "data/maps/names.asm"

MonNestIcon:
	INCBIN "gfx/town_map/mon_nest_icon.1bpp"
MonNestIconEnd:

TownMapSpriteBlinkingAnimation::
	ld a, [wAnimCounter]
	inc a
	cp 25
	jr z, .hideSprites
	cp 50
	jr nz, .done
; show sprites when the counter reaches 50
	ld hl, wTileMapBackup
	ld de, wShadowOAM
	ld bc, $90
	call CopyData
	xor a
	jr .done
.hideSprites
	ld hl, wShadowOAM
	ld b, $24
	ld de, $4
.hideSpritesLoop
	ld [hl], $a0
	add hl, de
	dec b
	jr nz, .hideSpritesLoop
	ld a, 25
.done
	ld [wAnimCounter], a
	jp DelayFrame
