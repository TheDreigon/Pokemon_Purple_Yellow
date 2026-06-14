	db DEX_CLEFAIRY ; pokedex id
	base_stat_row 70, 45, 50, 70, 45 ; hp atk def spc spd
	db FAIRY, FAIRY ; type
	db 150 ; catch rate
	db 68 ; base exp

	INCBIN "gfx/pokemon/front/clefairy.pic", 0, 1 ; sprite dimensions
	dw ClefairyPicFront, ClefairyPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: mystical moon-fairy pre-evo. auto
	; MIMIC/METRONOME/DAZZLE_GLEAM/CHARM/LIGHT_SCREEN/REFLECT/CALM_MIND.
	; bonus BODY_SLAM/FAKE_TEARS/EXTRASENSORY/PSYCHIC_M. fun (excecao
	; pre-evo aprovada Forte) MIMIC/METRONOME.
	tmhm BODY_SLAM, MIMIC, METRONOME, DAZZLE_GLEAM, FAKE_TEARS, \
	     CHARM, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, REFLECT, \
	     CALM_MIND
	; end

	db 0 ; padding
