	db DEX_KAKUNA ; pokedex id
	base_stat_row 45, 25, 75, 25, 5 ; hp atk def spc spd

	db BUG, POISON ; type
	db 120 ; catch rate
	db 71 ; base exp

	INCBIN "gfx/pokemon/front/kakuna.pic", 0, 1 ; sprite dimensions
	dw KakunaPicFront, KakunaPicBack

	db POISON_STING, STRING_SHOT, HARDEN, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: cocoon. Only SUBSTITUTE (per Forte — silk-spinner cocoon
	; can weave a fake stand-in decoy). The other 3 fun moves don't fit;
	; Weedle baby doesn't get SUBSTITUTE either (too primitive).
	tmhm SUBSTITUTE
	; end

	db 0 ; padding
