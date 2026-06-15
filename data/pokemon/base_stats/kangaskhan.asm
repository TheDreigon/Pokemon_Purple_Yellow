	db DEX_KANGASKHAN ; pokedex id
	base_stat_row 105, 85, 80, 50, 80 ; hp atk def spc spd
	db NORMAL, FIGHTING ; type
	db 45 ; catch rate
	db 175 ; base exp

	INCBIN "gfx/pokemon/front/kangaskhan.pic", 0, 1 ; sprite dimensions
	dw KangaskhanPicFront, KangaskhanPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: protective canguru mother, Normal/Fighting bruiser
	; with fists + tail. auto
	; BIND/SEISMIC_TOSS/BODY_SLAM/BULK_UP/TAKE_DOWN/THRASH/STRENGTH.
	; bonus IRON_TAIL/INTIMIDATE/EARTHQUAKE. HM STRENGTH. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BIND, BULLDOZE, SEISMIC_TOSS, BODY_SLAM, IRON_TAIL, \
	     BULK_UP, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     INTIMIDATE, TAKE_DOWN, EARTHQUAKE, THRASH, STRENGTH
	; end

	db 0 ; padding
