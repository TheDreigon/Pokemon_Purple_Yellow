	db DEX_KAKUNA ; pokedex id
	base_stat_row 45, 25, 75, 25, 5 ; hp atk def spc spd

	db BUG, POISON ; type
	db 200 ; catch rate  ; set by hand: an immobile cocoon whose only move is to harden
	db 40 ; base exp  ; escolha dele

	INCBIN "gfx/pokemon/front/kakuna.pic", 0, 1 ; sprite dimensions
	dw KakunaPicFront, KakunaPicBack

	db POISON_STING, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Silk cocoon, dormant pre-evo. Only SUBSTITUTE: shed-skin decoy
	; fits the hardened shell.
	tmhm SUBSTITUTE
	; end

	db BANK(KakunaPicFront) ; which bank this mon's pics live in
	assert BANK(KakunaPicFront) == BANK(KakunaPicBack), \
	    "Kakuna: front and back pics must share a bank"
