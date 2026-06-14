	db DEX_RAPIDASH ; pokedex id
	base_stat_row 70, 100, 70, 85, 100 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 60 ; catch rate
	db 192 ; base exp

	INCBIN "gfx/pokemon/front/rapidash.pic", 0, 1 ; sprite dimensions
	dw RapidashPicFront, RapidashPicBack

	db EMBER, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex equino unicornio Fire com chifre. auto
	; BODY_SLAM/IGNITE/DAZZLE_GLEAM/AGILITY/TAKE_DOWN/FLAMETHROWER/DOUBLE_EDGE.
	; bonus QUICK_ATTACK/BULLDOZE/FLAME_BURST/MEGAHORN. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, BULLDOZE, BODY_SLAM, FLAME_BURST, IGNITE, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, \
	     AGILITY, MEGAHORN, TAKE_DOWN, FLAMETHROWER, DOUBLE_EDGE
	; end

	db 0 ; padding
