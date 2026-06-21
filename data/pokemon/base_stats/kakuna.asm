	db DEX_KAKUNA ; pokedex id
	base_stat_row 45, 25, 75, 25, 5 ; hp atk def spc spd

	db BUG, POISON ; type
	db 120 ; catch rate
	db 71 ; base exp

	INCBIN "gfx/pokemon/front/kakuna.pic", 0, 1 ; sprite dimensions
	dw KakunaPicFront, KakunaPicBack

	db POISON_STING, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Silk cocoon, dormant pre-evo. Only SUBSTITUTE: shed-skin decoy
	; fits the hardened shell.
	tmhm SUBSTITUTE
	; end

	db 0 ; padding
