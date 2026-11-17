DrawAllPokeballs:
	call LoadPartyPokeballGfx
	call SetupOwnPartyPokeballs
	ld a, [wIsInBattle]
	dec a
	ret z ; return if wild pokémon
	jp SetupEnemyPartyPokeballs

DrawEnemyPokeballs:
	call LoadPartyPokeballGfx
	jp SetupEnemyPartyPokeballs

LoadPartyPokeballGfx:
	ld de, PokeballTileGraphics
	ld hl, vSprites tile $31
	lb bc, BANK(PokeballTileGraphics), (PokeballTileGraphicsEnd - PokeballTileGraphics) / $10
	jp CopyVideoData

SetupOwnPartyPokeballs:
	call PlacePlayerHUDTiles
	ld hl, wPartyMon1
	ld de, wPartyCount
	call SetupPokeballs
	ld a, $60
	ld hl, wBaseCoordX
	ld [hli], a
	ld [hl], a
	ld a, 8
	ld [wHUDPokeballGfxOffsetX], a
	xor a
	ld [wdef5], a
	ld hl, wShadowOAM
	jp WritePokeballOAMData

SetupEnemyPartyPokeballs:
	call PlaceEnemyHUDTiles
	ld hl, wEnemyMons
	ld de, wEnemyPartyCount
	call SetupPokeballs
	ld hl, wBaseCoordX
	ld a, $48
	ld [hli], a
	ld [hl], $20
	ld a, -8
	ld [wHUDPokeballGfxOffsetX], a
	ld a, $1
	ld [wdef5], a
	ld hl, wShadowOAMSprite06
	jp WritePokeballOAMData

SetupPokeballs:
	ld a, [de]
	push af
	ld de, wBuffer
	ld c, PARTY_LENGTH
	ld a, $34 ; empty pokeball
.emptyloop
	ld [de], a
	inc de
	dec c
	jr nz, .emptyloop
	pop af
	ld de, wBuffer
.monloop
	push af
	call PickPokeball
	inc de
	pop af
	dec a
	jr nz, .monloop
	ret

PickPokeball:
	inc hl
	ld a, [hli]
	and a
	jr nz, .alive
	ld a, [hl]
	and a
	ld b, $33 ; crossed ball (fainted)
	jr z, .done_fainted
.alive
	inc hl
	inc hl
	ld a, [hl] ; status
	and a
	ld b, $32 ; black ball (status)
	jr nz, .done
	dec b ; regular ball
	jr .done
.done_fainted
	inc hl
	inc hl
.done
	ld a, b
	ld [de], a
	ld bc, wPartyMon2 - wPartyMon1Status
	add hl, bc ; next mon struct
	ret

WritePokeballOAMData:
	ld de, wBuffer
	ld c, PARTY_LENGTH
.loop
	ld a, [wBaseCoordY]
	ld [hli], a
	ld a, [wBaseCoordX]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ld a, [wdef5]
	ld [hli], a
	ld a, [wBaseCoordX]
	ld b, a
	ld a, [wHUDPokeballGfxOffsetX]
	add b
	ld [wBaseCoordX], a
	inc de
	dec c
	jr nz, .loop
	ret

PlacePlayerHUDTiles:
	ld hl, PlayerBattleHUDGraphicsTiles
	ld de, wHUDGraphicsTiles
	ld bc, $3
	call CopyData
	hlcoord 18, 10
	ld de, -1
	jr PlaceHUDTiles

PlayerBattleHUDGraphicsTiles:
; The tile numbers for specific parts of the battle display for the player's pokemon
	db $73 ; vertical line tile of the HUD
	db $77 ; lower-right corner tile of the HUD
	db $6F ; lower-left triangle tile of the HUD

PlaceEnemyHUDTiles:
	ld hl, EnemyBattleHUDGraphicsTiles
	ld de, wHUDGraphicsTiles
	ld bc, $3
	call CopyData
; The enemy's vertical line has an id of its own, drawn one pixel right of the player's ($73) to leave room for
; the SUBSTITUTE doll's tube in column 0 (engine/battle/substitute_bar.asm). The table holds the GBC id (VRAM
; bank 1: cell (1,2) has attribute bit 3); the DMG / SGB id is a bank-0 one.
	ldh a, [hGBC]
	and a
	jr nz, .gotLine
	ld a, SUBBAR_DMG_LINE_E
	ld [wHUDGraphicsTiles], a
.gotLine
	hlcoord 1, 2
	ld de, $1
	jr PlaceHUDTiles

EnemyBattleHUDGraphicsTiles:
; The tile numbers for specific parts of the battle display for the enemy
	db SUBBAR_GBC_LINE_E ; vertical line tile of the HUD (PlaceEnemyHUDTiles: another id on the DMG / SGB)
	db $74 ; lower-left corner tile of the HUD
	db $78 ; lower-right triangle tile of the HUD

PlaceHUDTiles:
	ld a, [wHUDGraphicsTiles] ; vertical line
	ld [hl], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld a, [wHUDGraphicsTiles + 1] ; leftmost tile
	ld [hl], a
	ld a, 8
.loop
	add hl, de
	ld [hl], $76
	dec a
	jr nz, .loop
	add hl, de
	ld a, [wHUDGraphicsTiles + 2] ; rightmost tile
	ld [hl], a
	ret

; v1.0 (2026-11-07): SetupPlayerAndEnemyPokeballs (both parties' balls side by side) went
; with its only caller, the link battle's VERSUS box (link_battle_versus_text.asm).

; four tiles: pokeball, black pokeball (status ailment), crossed out pokeball (fainted) and pokeball slot (no mon)
PokeballTileGraphics::
	INCBIN "gfx/battle/balls.2bpp"
PokeballTileGraphicsEnd:
