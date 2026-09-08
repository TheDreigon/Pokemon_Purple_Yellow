	db DEX_KAKUNA ; pokedex id
	base_stat_row 40, 35, 60, 20, 40, 10 ; hp atk def spatk spdef spd

	db BUG, POISON ; type
	db 200 ; catch rate  ; set by hand: an immobile cocoon whose only move is to harden
	db 45 ; base exp  ; BST 205

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
