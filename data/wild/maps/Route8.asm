Route8WildMons:
; v1.0 (2026-09-07, Forte): the poison pass - KOFFING 10% (was RATTATA, still on 7/16/18/21),
; GRIMER 10% (was PIDGEOTTO, still on 12/13/15/21) and WEEZING 31 at 1% (was KADABRA 28, still
; in Cerulean Cave / the Mansion / the Power Plant, and Abra evolves at 16). Route 7 mirrors it
; with MUK as the rare.
	def_grass_wildmons 15 ; encounter rate
	db 20, GROWLITHE
	db 18, ABRA
	db 21, PIDGEY
	db 21, VULPIX
	db 22, KOFFING
	db 23, GRIMER
	db 24, JIGGLYPUFF
	db 27, MR_MIME
	db 22, EXEGGCUTE
	db 31, WEEZING
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
