PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries, PrizeMenuMon1Cost
	dw PrizeMenuMon2Entries, PrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

; Phase B.3: 4 prizes per Mon counter (matched to TM counter). All starters
; on Counter 1 + Eevee, the 3 elemental "kid" mons + Porygon on Counter 2.
; Flat 1000 coins each, all level 20.
PrizeMenuMon1Entries:
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db EEVEE
	db "@"

PrizeMenuMon1Cost:
	bcd2 1000
	bcd2 1000
	bcd2 1000
	bcd2 1000
	db "@"

PrizeMenuMon2Entries:
	db JYNX
	db ELECTABUZZ
	db MAGMAR
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
	bcd2 1000
	bcd2 1000
	bcd2 1000
	bcd2 1000
	db "@"

; Phase B.3: Game Corner has 4 TMs (all 3 menus use a uniform 4-prize
; layout now). The other 4 spec TMs (Confuse Ray, Thunder Wave, Ignite,
; Toxic) are sold at Fuchsia Mart instead. Tier coverage: 2x500c,
; 1x1000c, 1x1500c.
PrizeMenuTMsEntries:
	db TM_MIRROR_MOVE
	db TM_MIMIC
	db TM_SUBSTITUTE
	db TM_METRONOME
	db "@"

PrizeMenuTMsCost:
	bcd2 500
	bcd2 500
	bcd2 1000
	bcd2 1500
	db "@"
