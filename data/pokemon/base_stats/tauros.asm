	db DEX_TAUROS ; pokedex id
	base_stat_row 90, 120, 90, 50, 100 ; hp atk def spc spd

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 211 ; base exp

	INCBIN "gfx/pokemon/front/tauros.pic", 0, 1 ; sprite dimensions
	dw TaurosPicFront, TaurosPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Raging horned bull, heavy physical bruiser. Horns drive
	; MEGAHORN/IRON_HEAD. Powerful legs power BULLDOZE/EARTHQUAKE/STRENGTH.
	; Last-stage fun moves via TM.
	tmhm BULLDOZE, RAGE, BODY_SLAM, BULK_UP, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, IRON_HEAD, MEGAHORN, \
	     INTIMIDATE, SCARY_FACE, TAKE_DOWN, SWORDS_DANCE, EARTHQUAKE, \
	     DOUBLE_EDGE, THRASH, OUTRAGE, STRENGTH
	; end

	db 0 ; padding
