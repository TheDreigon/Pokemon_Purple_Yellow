; v1.0 (2026-11-27): the dark floor, above the entrance. What lives without light: poison gas and sludge, the bats,
; the moths, the parasites (VILEPLUME, a flower that feeds on others and needs no sun; PARASECT, the fungus) and
; MAROWAK's bones.
CeruleanCave2FWildMons:
	def_grass_wildmons 15 ; encounter rate
	db 63, GOLBAT
	db 63, WEEZING
	db 63, MUK
	db 64, ARBOK
	db 64, VENOMOTH
	db 64, VILEPLUME
	db 63, PARASECT
	db 63, MAROWAK
	db 64, PARASECT
	db 65, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
