	db DEX_SEAKING ; pokedex id
	base_stat_row 90, 90, 70, 80, 75 ; hp atk def spc spd

	db WATER, WATER ; type
	db 60 ; catch rate
	db 170 ; base exp

	INCBIN "gfx/pokemon/front/seaking.pic", 0, 1 ; sprite dimensions
	dw SeakingPicFront, SeakingPicBack

	db TAIL_WHIP, WATER_GUN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex horned river guardian. auto
	; WATER_PULSE/ICY_PULSE/RAGE/AGILITY/MEGAHORN/ICE_BEAM/SURF. bonus
	; BODY_SLAM/SCARY_FACE/TAKE_DOWN. HM SURF/STRENGTH. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, RAGE, BODY_SLAM, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, MEGAHORN, \
	     SCARY_FACE, TAKE_DOWN, ICE_BEAM, SURF, STRENGTH
	; end

	db 0 ; padding
