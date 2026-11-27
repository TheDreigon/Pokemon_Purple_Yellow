; MEWTWO's floor: the static L75 MEWTWO stands here (data/maps/objects/CeruleanCaveB1F.asm).
; The cave has three floors: 1F is the entrance, 2F is the one above it, B1F is this one.
; v1.0 (2026-11-27): the psychic and the ghosts that MEWTWO draws, and the DITTO that copy them.
CeruleanCaveB1FWildMons:
	def_grass_wildmons 25 ; encounter rate
	db 63, HAUNTER
	db 63, DITTO
	db 63, MAROWAK
	db 64, KADABRA
	db 63, JYNX
	db 64, HYPNO
	db 64, DITTO
	db 64, HAUNTER
	db 65, HYPNO
	db 65, GENGAR
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db 60, POLIWRATH
	db 61, GOLDUCK
	db 62, SLOWBRO
	db 62, STARMIE
	db 63, GOLDUCK
	db 63, POLIWRATH
	db 64, SLOWBRO
	db 64, GOLDUCK
	db 64, STARMIE
	db 65, STARMIE
	end_water_wildmons
