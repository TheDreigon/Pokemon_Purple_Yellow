SetDebugNewGameParty: ; unreferenced except in _DEBUG
	ld de, DebugNewGameParty
.loop
	ld a, [de]
	cp -1
	ret z
	ld [wcf91], a
	inc de
	ld a, [de]
	ld [wCurEnemyLVL], a
	inc de
	call AddPartyMon
	jr .loop

DebugNewGameParty: ; unreferenced except in _DEBUG
	db SNORLAX, 80
	db PERSIAN, 80
	db JIGGLYPUFF, 15
	db STARTER_PIKACHU, 5
	db -1 ; end

PrepareNewGameDebug: ; dummy except in _DEBUG
IF DEF(_DEBUG)
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a

	; Fly anywhere.
	dec a ; $ff (all bits)
	ld [wTownVisitedFlag], a
	ld [wTownVisitedFlag + 1], a

	; Get all badges except Earth Badge.
	ld a, ~(1 << BIT_EARTHBADGE)
	ld [wObtainedBadges], a

	call SetDebugNewGameParty

	; Pikachu gets Surf.
	ld a, SURF
	ld hl, wPartyMon4Moves + 2
	ld [hl], a

	; Snorlax gets four HM moves.
	ld hl, wPartyMon1Moves
	ld a, FLY
	ld [hli], a
	ld a, CUT
	ld [hli], a
	ld a, SURF
	ld [hli], a
	ld a, STRENGTH
	ld [hl], a

	; Get some debug items.
	ld hl, wNumBagItems
	ld de, DebugItemsList
.items_loop
	ld a, [de]
	cp -1
	jr z, .items_end
	ld [wcf91], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .items_loop
.items_end

	; Complete the Pokédex.
	ld hl, wPokedexOwned
	call DebugSetPokedexEntries
	ld hl, wPokedexSeen
	call DebugSetPokedexEntries
	SetEvent EVENT_GOT_POKEDEX

	; Rival chose Jolteon.
	ld hl, wRivalStarter
	ld a, RIVAL_STARTER_JOLTEON
	ld [hli], a
	ld a, NUM_POKEMON
	ld [hli], a ; hl = wUnknownDebugByte
	ld a, STARTER_PIKACHU
	ld [hl], a ; hl = wPlayerStarter

	; Give max money.
	ld hl, wPlayerMoney
	ld a, $99
	ld [hli], a
	ld [hli], a
	ld [hl], a

	; BILL's whole thread, done, so his garden can be tested without playing to
	; the League first: fly to BILL's LAB (every fly point is set above),
	; walk in, talk to him.
	;
	; EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING is deliberately NOT set. It is the
	; one Route25ShowHideBillScript sets itself, and setting it is how that
	; script knows to hide BILL1 and SHOW BILL2 -- do it here and BILL2 never
	; appears, and there is nobody in the house to talk to.
	; Grouped by flag BYTE and set with SetEventReuseHL, which only reloads hl
	; when the byte changes: five of these live in byte 171 and two in 315, so
	; this is 25 bytes instead of 45. Debug code still has to fit.
	SetEvent EVENT_MET_BILL                          ; byte 170
	SetEventReuseHL EVENT_BEAT_BILL                  ; byte 171, and the one
	SetEventReuseHL EVENT_USED_CELL_SEPARATOR_ON_BILL ; that opens the garden
	SetEventReuseHL EVENT_GOT_SS_TICKET
	SetEventReuseHL EVENT_MET_BILL_2
	SetEventReuseHL EVENT_BILL_SAID_USE_CELL_SEPARATOR
	SetEventReuseHL EVENT_GOT_BILL_EEVEE             ; byte 315
	SetEventReuseHL EVENT_GOT_BILL_EEVEELUTION_STONE

	; ...and count as League Champion, which gates the rematch and the garden.
	ld a, 1
	ld [wGameStage], a

	ret

DebugSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %01111111
	ret

DebugItemsList:
	db MASTER_BALL, 99
	db TOWN_MAP, 1
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db ESCAPE_ROPE, 99
	db RARE_CANDY, 99
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db FULL_HEAL, 99
	db REVIVE, 99
	db FRESH_WATER, 99
	db S_S_TICKET, 1
	db LIFT_KEY, 1
	db PP_UP, 99
	db -1 ; end

DebugUnusedList:
	db OLD_AMBER, 1
	db DOME_FOSSIL, 1
	db HELIX_FOSSIL, 1
	db X_ACCURACY, 99
	db DIRE_HIT, 99
	db FRESH_WATER, 1
	db S_S_TICKET, 1
	db GOLD_TEETH, 1
	db COIN_CASE, 1
	db SILPH_SCOPE, 1
	db POKE_FLUTE, 1
	db LIFT_KEY, 1
	db ETHER, 99
	db MAX_ETHER, 99
	db ELIXIR, 99
	db MAX_ELIXIR, 99
	db TM_AERIAL_ACE, 10
	db TM_FAINT_ATTACK, 10
	db TM_TAKE_DOWN, 10
	db TM_THRASH, 10
	db TM_METRONOME, 10
	db TM_DARK_PULSE, 10
	db TM_DRAGON_CLAW, 10
	db TM_MIMIC, 10
	db TM_ROCK_THROW, 10
	db TM_METRONOME, 10
	db TM_INTIMIDATE, 10
	db TM_AERIAL_ACE, 10
	db TM_SWORDS_DANCE, 10
	db TM_CALM_MIND, 10
	db TM_IRON_TAIL, 10
	db TM_SUBSTITUTE, 10
	db -1 ; end
ELSE
	ret
ENDC
