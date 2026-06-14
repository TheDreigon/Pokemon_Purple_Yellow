	db DEX_MAGNEMITE ; pokedex id
	base_stat_row 20, 40, 75, 80, 40 ; hp atk def spc spd
	db ELECTRIC, STEEL ; type
	db 190 ; catch rate
	db 89 ; base exp

	INCBIN "gfx/pokemon/front/magnemite.pic", 0, 1 ; sprite dimensions
	dw MagnemitePicFront, MagnemitePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Electric/Steel magnet pre-evo. auto
	; BODY_SLAM/SHOCK_WAVE/THUNDER_WAVE/IRON_HEAD/THUNDERBOLT. bonus
	; LIGHT_SCREEN/REFLECT.
	tmhm BODY_SLAM, SHOCK_WAVE, THUNDER_WAVE, IRON_HEAD, LIGHT_SCREEN, \
	     REFLECT, THUNDERBOLT
	; end

	db 0 ; padding
