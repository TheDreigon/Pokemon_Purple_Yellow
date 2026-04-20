PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries, PrizeMenuMon1Cost
	dw PrizeMenuMon2Entries, PrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

PrizeMenuMon1Entries:
	db ABRA
	db SEEL
	db MAGMAR
	db "@"

PrizeMenuMon1Cost:
	bcd2 230
	bcd2 500
	bcd2 1500
	db "@"

PrizeMenuMon2Entries:
	db ELECTABUZZ
	db DRATINI
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
	bcd2 1500
	bcd2 3000
	bcd2 4500
	db "@"

; Phase B.3: Game Corner has 4 TMs (engine extended from 3 to 4 prize slots
; for the TM menu only; Mon menus stay at 3). The other 4 spec TMs (Confuse
; Ray, Thunder Wave, Ignite, Toxic) are sold at Fuchsia Mart instead.
; Tier coverage: 2x500c, 1x1000c, 1x1500c.
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
