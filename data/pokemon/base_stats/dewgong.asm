	db DEX_DEWGONG ; pokedex id
	base_stat_row 90, 70, 80, 90, 75 ; hp atk def spc spd

	db WATER, ICE ; type
	db 90 ; catch rate  ; final stage, BST 405, easy to approach
	db 176 ; base exp

	INCBIN "gfx/pokemon/front/dewgong.pic", 0, 1 ; sprite dimensions
	dw DewgongPicFront, DewgongPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Water/Ice seal. HM SURF/STRENGTH. Fun moves (last-stage)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, BODY_SLAM, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, FAKE_TEARS, CHARM, \
	     TAKE_DOWN, ICE_BEAM, DOUBLE_EDGE, SURF, STRENGTH
	; end

	db 0 ; padding
