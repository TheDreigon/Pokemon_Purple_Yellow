; v1.0 (2026-11-27): I redid the cave's three floors. 1F, the entrance, is a stronger VICTORY ROAD: rock, ground and
; fighting, the bats and the snakes, and ROUTE 23's NIDOKING and NIDOQUEEN. In its water, TENTACRUEL and a rare
; GYARADOS. 2F, the floor above, is the dark one; B1F is MEWTWO's.
CeruleanCave1FWildMons:
	def_grass_wildmons 10 ; encounter rate
	db 62, GOLBAT
	db 63, RHYDON
	db 63, GOLEM
	db 63, NIDOKING
	db 63, NIDOQUEEN
	db 63, ARBOK
	db 63, MACHAMP
	db 64, ONIX
	db 64, SANDSLASH
	db 65, RHYDON
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db 57, TENTACRUEL
	db 56, GOLDUCK
	db 57, POLIWRATH
	db 58, SLOWBRO
	db 59, TENTACRUEL
	db 59, POLIWRATH
	db 60, GOLDUCK
	db 60, STARMIE
	db 61, TENTACRUEL
	db 62, GYARADOS
	end_water_wildmons
