; BILL's garden. Every Pokemon here is one you are only ever meant to have one
; of, and they are all L10: the point is to raise one, not to catch a finished
; one. L10 is also exactly the level of the EEVEE BILL hands over in his own
; quest, which is where that Eevee came from -- he went out back and fetched it.
;
; v1.0 (2026-11-07): the ten slots are drawn on the garden's own, flat odds
; (BillsGardenEncounterSlotChances in data/wild/probabilities.asm, picked by
; TryDoWildEncounter on this map): 10.2 / 9.8 / 10.2 / 9.8 / 10.2 / 9.8 / 10.2 /
; 9.8 / 10.2 / 10.2 percent, in the order below.
;
; The three KANTO starters appear twice each, so each of them is 19.9% and the
; other four about 10%. Their second entries are seats being kept for the JOHTO
; starters; once those take them, all ten are equally common.
BillsGardenWildMons:
	def_grass_wildmons 20 ; encounter rate
	db 10, BULBASAUR
	db 10, BULBASAUR  ; -> CHIKORITA when Johto exists
	db 10, CHARMANDER
	db 10, CHARMANDER ; -> CYNDAQUIL
	db 10, SQUIRTLE
	db 10, SQUIRTLE   ; -> TOTODILE
	db 10, PIKACHU
	db 10, PORYGON
	db 10, EEVEE
	db 10, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; no water
	end_water_wildmons
