; BILL's garden. Every Pokemon here is one you are only ever meant to have one
; of, and they are all L10: the point is to raise one, not to catch a finished
; one. L10 is also exactly the level of the EEVEE BILL hands over in his own
; quest, which is where that Eevee came from -- he went out back and fetched it.
;
; ⏳ These use the GAME'S NORMAL slot odds, so they are NOT equally common:
; 19.9 / 19.9 / 15.2 / 9.8 / 9.8 / 9.8 / 5.1 / 5.1 / 4.3 / 1.2 percent, in the
; order below. The flat table this map is meant to have did not fit -- see the
; note in data/wild/probabilities.asm, which needs room in bank $4 first.
; Until then the last entry is a 1-in-85 rarity, which is nobody's design.
;
; The three KANTO starters appear twice each, so they are the two 19.9% slots
; plus more. Their second entries are seats being kept for the JOHTO starters.
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
