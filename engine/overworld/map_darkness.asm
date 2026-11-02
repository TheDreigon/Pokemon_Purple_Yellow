; v1.0 (2026-11-02): how dark each cave floor is, chosen floor by floor (the levels are in
; Notes/Flash por piso - proposta (2026-11-02).txt). Vanilla had one mark, set on walking into
; ROCK TUNNEL from outside and kept between its floors. Now every map entry works it out again,
; so a floor can differ from the next one and no exit has to clear anything: an escape rope, a
; blackout, FLY and a door all end up here on a map of another tileset.
; DIGLETTS_CAVE and DIGLETTS_CAVE_EAST are joined by a map connection, which does not enter a
; map (CheckMapConnections): the two must hold the same levels.
SetMapDarkness::
	ld a, [wCurMapTileset]
	cp CAVERN
	jr z, .inCave
	ResetEvent EVENT_FLASH_LIT_CAVE
	jr .lit
.inCave
	CheckEvent EVENT_FLASH_LIT_CAVE
	jr nz, .lit
	ld a, [wCurMap]
	ld hl, MapDarknessLevels
	ld de, 3
	call IsInArray
	jr nc, .lit
	inc hl ; Normal
	ld a, [wDifficulty]
	and a
	jr z, .gotLevel
	inc hl ; Hard
.gotLevel
	ld a, [hl]
	jr .store
.lit
	xor a
.store
	ld [wMapPalOffset], a
	ret

MapDarknessLevels:
	; map, Normal, Hard
	db ROCK_TUNNEL_1F,      DARKNESS_DIM,  DARKNESS_DIM
	db ROCK_TUNNEL_B1F,     DARKNESS_DARK, DARKNESS_DARK
	db DIGLETTS_CAVE,       DARKNESS_DIM,  DARKNESS_DARK
	db DIGLETTS_CAVE_EAST,  DARKNESS_DIM,  DARKNESS_DARK
	db SEAFOAM_ISLANDS_B1F, 0,             DARKNESS_DIM
	db SEAFOAM_ISLANDS_B2F, 0,             DARKNESS_DIM
	db SEAFOAM_ISLANDS_B3F, 0,             DARKNESS_DIM
	db SEAFOAM_ISLANDS_B4F, 0,             DARKNESS_DIM
	db CERULEAN_CAVE_2F,    DARKNESS_DIM,  DARKNESS_DIM
	db CERULEAN_CAVE_B1F,   DARKNESS_DIM,  DARKNESS_DARK
	db -1 ; end
