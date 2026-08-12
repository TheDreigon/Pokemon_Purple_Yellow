; BILL's garden. Every Pokemon here is one you are only ever meant to have one
; of, and they are all L10: the point is to raise one, not to catch a finished
; one. L10 is also exactly the level of the EEVEE BILL hands over in his own
; quest, which is where that Eevee came from -- he went out back and fetched it.
;
; The slot odds are NOT the game's usual ones. This map uses its own chance
; table (BillsGardenEncounterSlotChances, data/wild/probabilities.asm) so the
; ten entries come out even instead of running 19.9% down to 1.2%.
;
; The three KANTO starters appear twice each and so sit at 19.9% while the
; other four sit near 10%. That is TEMPORARY: the second entry of each is the
; seat of a JOHTO starter, and swapping those three words puts all ten between
; 9.8% and 10.2%.
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
