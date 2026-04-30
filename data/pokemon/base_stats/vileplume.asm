	db DEX_VILEPLUME ; pokedex id
	base_stat_row 110, 95, 85, 95, 45 ; hp atk def spc spd
	db GRASS, FUNGUS ; type
	db 45 ; catch rate
	db 184 ; base exp

	INCBIN "gfx/pokemon/front/vileplume.pic", 0, 1 ; sprite dimensions
	dw VileplumePicFront, VileplumePicBack

	db POISONPOWDER, STUN_POWDER, SLEEP_POWDER, PETAL_DANCE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3 (Forte review): apex Rafflesia bloom — powder warfare
	; specialist. Gloom's 3 + 6 Vileplume additions: BODY_SLAM (mass —
	; not in levelup but anatomical), LEECH_LIFE¹ (insect drain levelup),
	; TAKE_DOWN, DOUBLE_EDGE (apex slams), DOUBLE_TEAM (powder cloud
	; cover), EXTRASENSORY (Forte add).
	tmhm GIGA_DRAIN,   TOXIC,        BODY_SLAM,    LEECH_LIFE,   TAKE_DOWN, \
	     DOUBLE_EDGE,  EXTRASENSORY, MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME
	; end

	db 0 ; padding
