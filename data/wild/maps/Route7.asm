Route7WildMons:
; v1.0 (2026-09-07, Forte): the poison pass on both sides of SAFFRON - GRIMER 10% + KOFFING
; 10% + a 1% evolved rare (MUK here, WEEZING on Route 8; both evolve at 31 in this hack).
; The 20% KOFFING slot is MEOWTH now (the city cat, up from Route 5's 15); the second
; KOFFING slot stays; PIDGEOTTO's slot is the GRIMER (Pidgeotto stays on 12/13/15/21).
	def_grass_wildmons 15 ; encounter rate
	db 22, MEOWTH
	db 23, DROWZEE
	db 20, RATTATA
	db 21, PIDGEY
	db 24, KOFFING
	db 23, GRIMER
	db 23, ABRA
	db 25, RATICATE
	db 22, JIGGLYPUFF
	db 31, MUK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
