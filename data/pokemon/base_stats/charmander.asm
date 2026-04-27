	db DEX_CHARMANDER ; pokedex id
	base_stat_row 50, 55, 40, 55, 65 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 65 ; base exp

	INCBIN "gfx/pokemon/front/charmander.pic", 0, 1 ; sprite dimensions
	dw CharmanderPicFront, CharmanderPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: baby fire reptile. 4 universals + 4 universal-exception
	; "fun moves" (Mimic/Mirror Move/Substitute/Metronome — these break the
	; realism rule by Forte's design). Levelup-doubles for fire/dragon TMs
	; the line learns naturally. HM05 Flash because fire pokes light caves.
	tmhm MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME,    QUICK_ATTACK, \
	     HONE_CLAWS,   TAKE_DOWN,    DRAGON_CLAW,  DRAGON_RAGE,  IGNITE,       \
	     FLAMETHROWER, FIRE_BLAST,   OUTRAGE,      CUT,          FLASH
	; end

	db 0 ; padding
