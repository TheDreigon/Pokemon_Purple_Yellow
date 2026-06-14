	db DEX_PONYTA ; pokedex id
	base_stat_row 50, 65, 50, 65, 80 ; hp atk def spc spd

	db FIRE, FIRE ; type
	db 190 ; catch rate
	db 152 ; base exp

	INCBIN "gfx/pokemon/front/ponyta.pic", 0, 1 ; sprite dimensions
	dw PonytaPicFront, PonytaPicBack

	db EMBER, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: potro Fire com mane em chamas, ainda sem chifre. auto
	; BODY_SLAM/IGNITE/AGILITY/TAKE_DOWN/FLAMETHROWER/DOUBLE_EDGE. bonus
	; QUICK_ATTACK/BULLDOZE/FLAME_BURST.
	tmhm QUICK_ATTACK, BULLDOZE, BODY_SLAM, FLAME_BURST, IGNITE, \
	     AGILITY, TAKE_DOWN, FLAMETHROWER, DOUBLE_EDGE
	; end

	db 0 ; padding
