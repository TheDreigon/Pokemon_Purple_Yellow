; MEWTWO's floor: the static L70 MEWTWO stands here (data/maps/objects/CeruleanCaveB1F.asm).
; The cave has three floors: 1F is the entrance, 2F is the one above it, B1F is this one.
CeruleanCaveB1FWildMons:
	def_grass_wildmons 25 ; encounter rate
	db 64, HYPNO
	db 63, GOLDUCK
	db 62, GOLBAT
	db 61, SANDSLASH
	db 65, PARASECT
	db 60, SLOWBRO
	db 64, KADABRA
	db 63, DITTO
	db 64, DITTO
	db 65, ALAKAZAM
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
