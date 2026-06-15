	db DEX_TENTACRUEL ; pokedex id
	base_stat_row 100, 80, 60, 120, 90 ; hp atk def spc spd

	db WATER, POISON ; type
	db 60 ; catch rate
	db 205 ; base exp

	INCBIN "gfx/pokemon/front/tentacruel.pic", 0, 1 ; sprite dimensions
	dw TentacruelPicFront, TentacruelPicBack

	db POISON_STING, WATER_GUN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex Water/Poison jellyfish (13 TMs, Kingler-tier
	; gold standard). auto BIND/WATER_PULSE/SHOCK_WAVE/TOXIC/SURF. bonus
	; AGILITY/LEECH_LIFE/ICE_BEAM. HM CUT/SURF. fun (4 via TM, regra
	; global last-stage Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, WATER_PULSE, ICY_PULSE, SHOCK_WAVE, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, TOXIC, \
	     LEECH_LIFE, ICE_BEAM, CUT, SURF
	; end

	db 0 ; padding
