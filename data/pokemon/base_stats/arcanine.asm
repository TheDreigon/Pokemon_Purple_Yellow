	db DEX_ARCANINE ; pokedex id
	base_stat_row 100, 100, 80, 80, 95 ; hp atk def spc spd
	db FIRE, NORMAL ; type
	db 75 ; catch rate
	db 213 ; base exp

	INCBIN "gfx/pokemon/front/arcanine.pic", 0, 1 ; sprite dimensions
	dw ArcaninePicFront, ArcaninePicBack

	db BITE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex legendary Fire canine. auto
	; AGILITY/TAKE_DOWN/FLAMETHROWER/SWORDS_DANCE/CUT/STRENGTH. bonus
	; QUICK_ATTACK/FAINT_ATTACK/RAGE/BODY_SLAM/FLAME_BURST/IGNITE/INTIMIDATE/SCARY_FACE/DOUBLE_EDGE/THRASH.
	; HM CUT/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, BODY_SLAM, FLAME_BURST, \
	     IGNITE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     AGILITY, INTIMIDATE, SCARY_FACE, TAKE_DOWN, FLAMETHROWER, \
	     SWORDS_DANCE, DOUBLE_EDGE, THRASH, CUT, STRENGTH
	; end

	db 0 ; padding
