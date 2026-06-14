	db DEX_SEADRA ; pokedex id
	base_stat_row 60, 70, 90, 80, 80 ; hp atk def spc spd
	db WATER, DRAGON ; type
	db 75 ; catch rate
	db 155 ; base exp

	INCBIN "gfx/pokemon/front/seadra.pic", 0, 1 ; sprite dimensions
	dw SeadraPicFront, SeadraPicBack

	db WATER_GUN, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Water/Dragon last-stage; Horsea backbone plus dragon
	; apex. auto WATER_PULSE/ICY_PULSE/AGILITY/ICE_BEAM. bonus
	; TOXIC/SCARY_FACE/OUTRAGE. HM SURF. fun (4 via TM, regra global
	; last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, AGILITY, TOXIC, SCARY_FACE, ICE_BEAM, \
	     OUTRAGE, SURF
	; end

	db 0 ; padding
