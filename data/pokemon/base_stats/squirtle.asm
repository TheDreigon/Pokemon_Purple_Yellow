	db DEX_SQUIRTLE ; pokedex id
	base_stat_row 50, 50, 65, 55, 45 ; hp atk def spc spd

	db WATER, WATER ; type
	db 45 ; catch rate
	db 66 ; base exp

	INCBIN "gfx/pokemon/front/squirtle.pic", 0, 1 ; sprite dimensions
	dw SquirtlePicFront, SquirtlePicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: baby water turtle. Levelup-doubles for Water Pulse, Body
	; Slam, Surf. Defensive turtle screens (Light Screen, Reflect — shell
	; framing). HM Cut for small claws. No HYDRO_PUMP TM — no shell-cannons
	; (anatomical, parallel to Charmander/no FLY without wings). NO fun
	; moves (per Forte's revised rule — turtles don't fit Mimic/Mirror Move/
	; Substitute/Metronome anatomy/lore).
	tmhm WATER_PULSE,  BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  LIGHT_SCREEN, \
	     REFLECT,      CUT,          SURF
	; end

	db 0 ; padding
