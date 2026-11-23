; v1.0 (2026-11-22): the seven fixed encounters - the two SNORLAX, ARTICUNO, ZAPDOS, MOLTRES, MEWTWO and MEW - have
; a moveset chosen by hand instead of the last four moves of their learnset (ApplyFixedWildMoveset, from
; LoadEnemyMonData), and they choose their moves with layers 1-3 of the trainers' AI instead of at random
; (SelectEnemyMove asks FindFixedWildMoveset; AIGetMoveChoiceList hands a wild battle FixedWildAIMods).
; The key is (map, species). None of these species is in the wild or fishing tables of its map
; (emu_test_fixed_wild_movesets.py checks it), so an ordinary wild #MON never matches. The species is
; wEnemyMonSpecies2, the one that was sent out: TRANSFORM changes wEnemyMonSpecies, not this one. A #MON caught
; here keeps the set: ItemUseBall reloads it through LoadEnemyMonData on the same map. Moves that the species does
; not learn (NASTY PLOT, TELEPORT) stay with it until it forgets them; the relearner offers only its own.
; The same in both difficulties. The PP are the moves' own (LoadEnemyMonData's .loadMovePPs runs after).

; Far. IN wCurMap, wEnemyMonSpecies2. OUT carry = one of the seven encounters, hl = its four moves;
; no carry = any other #MON. Clobbers a, de.
FindFixedWildMoveset::
	ld a, [wCurMap]
	ld d, a
	ld a, [wEnemyMonSpecies2]
	ld e, a
	ld hl, FixedWildMovesets
.loop
	ld a, [hli]
	cp -1
	jr z, .none
	cp d
	ld a, [hli] ; ld keeps the flags of the map's cp
	jr nz, .next
	cp e
	jr z, .found
.next
	inc hl
	inc hl
	inc hl
	inc hl
	jr .loop
.found
	scf
	ret
.none
	and a
	ret

; Far, from LoadEnemyMonData: a wild #MON's moves, right after WriteMonMoves and before its PP are loaded. One of
; the seven encounters gets its four moves written over the learnset's. Clobbers a, bc, de, hl.
ApplyFixedWildMoveset::
	call FindFixedWildMoveset
	ret nc
	ld de, wEnemyMonMoves
	ld bc, NUM_MOVES
	jp CopyData

; map, species, then the four moves in the order they show in the FIGHT menu. The levels are the encounters' own
; (30 for the two SNORLAX in scripts/Route12.asm and Route16.asm; 50 and 70 in the maps' object events).
FixedWildMovesets:
	db ROUTE_12,            SNORLAX,  REST,       AMNESIA,     BODY_SLAM,    BULLDOZE   ; the one asleep on the road
	db ROUTE_16,            SNORLAX,  BODY_SLAM,  CRUNCH,      BULK_UP,      THRASH     ; the one woken up in a mood
	db SEAFOAM_ISLANDS_B4F, ARTICUNO, BLIZZARD,   ICY_PULSE,   HURRICANE,    FLASH
	db POWER_PLANT,         ZAPDOS,   THUNDER,    SHOCK_WAVE,  DRILL_PECK,   FLASH
	db VICTORY_ROAD_2F,     MOLTRES,  FIRE_BLAST, FLAME_BURST, HURRICANE,    FLASH
	db CERULEAN_CAVE_B1F,   MEWTWO,   PSYCHIC_M,  DARK_PULSE,  EXTREMESPEED, NASTY_PLOT
	db POKEMON_MANSION_B1F, MEW,      PSYCHIC_M,  PLAY_ROUGH,  METRONOME,    TELEPORT
	db -1 ; end
