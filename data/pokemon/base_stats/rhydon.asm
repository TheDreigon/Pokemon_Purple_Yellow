	db DEX_RHYDON ; pokedex id
	base_stat_row 95, 120, 110, 65, 50 ; hp atk def spc spd

	db GROUND, ROCK ; type
	db 60 ; catch rate
	db 204 ; base exp

	INCBIN "gfx/pokemon/front/rhydon.pic", 0, 1 ; sprite dimensions
	dw RhydonPicFront, RhydonPicBack

	db LEER, GROUND_STOMP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex rhinoceros (Ground/Rock) bruiser. auto
	; BULLDOZE/RAGE/BODY_SLAM/IRON_HEAD/TAKE_DOWN/EARTHQUAKE/THRASH/STRENGTH.
	; bonus
	; ROCK_THROW/IRON_TAIL/MEGAHORN/INTIMIDATE/SCARY_FACE/SWORDS_DANCE/DOUBLE_EDGE.
	; HM STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BULLDOZE, RAGE, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, \
	     MEGAHORN, INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, THRASH, STRENGTH, OUTRAGE
	; end

	db 0 ; padding
