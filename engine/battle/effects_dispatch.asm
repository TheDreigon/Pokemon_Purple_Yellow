; The move-effect dispatcher's doorway, kept in Battle Core.
;
; Everything it dispatches to -- _JumpMoveEffect, MoveEffectPointerTable and all
; 98 handlers -- lives in the "Battle Effects" section now. This four-line
; doorway stays because fourteen places call it, and ten of those are
; CONDITIONAL (`jp z,`, `jp c,`, `call c,`, `call nc,`). farcall is a macro and
; cannot carry a condition, so converting them would have meant restructuring
; ten branches inside the very bank being relieved. Leaving the doorway here
; keeps all fourteen byte-for-byte identical and costs six bytes.
;
; Safe to farcall from here: _JumpMoveEffect takes nothing in registers -- it
; reads hWhoseTurn and the move effect out of WRAM and overwrites a, b, c and hl
; on entry. farcall preserves d and e, which is all that survives anyway. And
; `ld b, $1` still runs after the call, so the b=1 contract is unchanged (the
; Bankswitch pops bc, but that happens before this line).
JumpMoveEffect:
	farcall _JumpMoveEffect
	ld b, $1
	ret
