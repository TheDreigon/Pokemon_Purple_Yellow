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

; Phase B.3 (partial): spec wants 8 TMs at Game Corner but the existing
; menu UI is hardcoded for 3 prize slots. Picked 3 spec TMs that cover
; the price range (500/1000/1500 coins) and feel "Game Corner classic".
; The other 5 spec TMs (Confuse Ray, Thunder Wave, Ignite, Toxic,
; Mirror Move) need a dedicated Phase B.3 to expand the menu UI to 8
; entries per submenu (or split into 2-3 NPCs).
PrizeMenuTMsEntries:
	db TM_MIMIC
	db TM_SUBSTITUTE
	db TM_METRONOME
	db "@"

PrizeMenuTMsCost:
	bcd2 500
	bcd2 1000
	bcd2 1500
	db "@"
