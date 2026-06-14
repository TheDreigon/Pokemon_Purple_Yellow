	db DEX_NIDOQUEEN ; pokedex id
	base_stat_row 100, 85, 85, 80, 80 ; hp atk def spc spd

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 194 ; base exp

	INCBIN "gfx/pokemon/front/nidoqueen.pic", 0, 1 ; sprite dimensions
	dw NidoqueenPicFront, NidoqueenPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: matriarch, fairy-tinged Poison/Ground apex. auto
	; BULLDOZE/BODY_SLAM/POISON_FANG/CHARM/TOXIC/TAKE_DOWN/STRENGTH.
	; bonus
	; FAINT_ATTACK/BULK_UP/DAZZLE_GLEAM/FAKE_TEARS/INTIMIDATE/SWORDS_DANCE/CALM_MIND/EARTHQUAKE/ROCK_SLIDE/DOUBLE_EDGE.
	; HM CUT/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm FAINT_ATTACK, BULLDOZE, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, POISON_FANG, \
	     FAKE_TEARS, CHARM, TOXIC, INTIMIDATE, TAKE_DOWN, \
	     SWORDS_DANCE, CALM_MIND, EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, \
	     CUT, STRENGTH
	; end

	db 0 ; padding
