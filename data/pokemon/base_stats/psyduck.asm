	db DEX_PSYDUCK ; pokedex id
	base_stat_row 50, 52, 48, 70, 55 ; hp atk def spc spd

	db WATER, WATER ; type
	db 235 ; catch rate  ; base stage, BST 275, easy to approach
	db 80 ; base exp

	INCBIN "gfx/pokemon/front/psyduck.pic", 0, 1 ; sprite dimensions
	dw PsyduckPicFront, PsyduckPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Aquatic duck with a latent psychic mind (pre-evo backbone):
	; WATER_PULSE/EXTRASENSORY plus ICY_PULSE/ICE_BEAM. HM CUT/SURF.
	tmhm WATER_PULSE, ICY_PULSE, EXTRASENSORY, ICE_BEAM, CUT, \
	     SURF
	; end

	db 0 ; padding
