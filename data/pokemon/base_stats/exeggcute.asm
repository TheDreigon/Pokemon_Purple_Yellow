	db DEX_EXEGGCUTE ; pokedex id
	base_stat_row 60, 35, 30, 80, 30 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 90 ; catch rate
	db 98 ; base exp

	INCBIN "gfx/pokemon/front/exeggcute.pic", 0, 1 ; sprite dimensions
	dw ExeggcutePicFront, ExeggcutePicBack

	db FURY_ATTACK, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: cacho de ovos Grass/Psychic imovel, backbone curto.
	; auto PSYCHIC_M/DARK_PULSE/PETAL_DANCE.
	tmhm PSYCHIC_M, DARK_PULSE, PETAL_DANCE
	; end

	db 0 ; padding
