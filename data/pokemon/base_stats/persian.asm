	db DEX_PERSIAN ; pokedex id
	base_stat_row 90, 80, 50, 60, 115 ; hp atk def spc spd
	db NORMAL, DARK ; type
	db 90 ; catch rate
	db 148 ; base exp

	INCBIN "gfx/pokemon/front/persian.pic", 0, 1 ; sprite dimensions
	dw PersianPicFront, PersianPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex Normal/Dark feline, smart sleek cat. auto
	; FAINT_ATTACK/RAGE/AGILITY/INTIMIDATE. bonus
	; QUICK_ATTACK/IRON_TAIL/NIGHT_SHADE/SCARY_FACE/DARK_PULSE/SWORDS_DANCE.
	; HM CUT/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, RAGE, IRON_TAIL, NIGHT_SHADE, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     INTIMIDATE, SCARY_FACE, DARK_PULSE, SWORDS_DANCE, CUT, \
	     STRENGTH
	; end

	db 0 ; padding
