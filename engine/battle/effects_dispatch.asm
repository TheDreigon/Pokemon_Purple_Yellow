; The move-effect dispatcher's doorway, kept in Battle Core.
;
; Everything it dispatches to -- _JumpMoveEffect, MoveEffectPointerTable and all
; 53 handlers (113 entries) -- lives in the "Battle Effects" section now. This four-line
; doorway stays because fourteen places call it, and all fourteen are
; CONDITIONAL (`jp z,`, `jp c,`, `call c,`, `call nc,`). farcall is a macro and
; cannot carry a condition, so converting them would have meant restructuring
; fourteen branches inside the very bank being relieved. Leaving the doorway here
; keeps all fourteen byte-for-byte identical and costs three bytes (a six-byte farcall for a three-byte call).
;
; Safe to farcall from here: _JumpMoveEffect takes nothing in registers -- it
; reads hWhoseTurn and the move effect out of WRAM and overwrites a, b, c and hl
; on entry. farcall preserves d and e, which is all that survives anyway. And
; `ld b, $1` still runs after the call, so the b=1 contract is unchanged (the
; Bankswitch pops bc, but that happens before this line).
JumpMoveEffect:
	call SporeBlockedForTurn ; v1.0 (2026-11-27): carry = a spore or powder into a BREATHLESS target
	jr c, .breathless
	farcall _JumpMoveEffect
	ld b, $1
	ret

; v1.0 (2026-11-27): BREATHLESS (data/pokemon/breathless.asm). The effect is not run. A status move (no power) says
; what an immune target makes any status move say (STATUS_FAIL_IMMUNE: "It doesn't affect <TARGET>!"), before its
; own tests, as a refusal that is certain; SPORE DAZE, which has power, has already hit, and its confusion is lost
; silently, as a refused side effect is.
.breathless
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMovePower]
	jr z, .gotPower
	ld a, [wEnemyMovePower]
.gotPower
	and a
	jr nz, .silent
	ld c, STATUS_FAIL_IMMUNE
	farcall PrintStatusMoveFailure
.silent
	ld b, $1
	ret

; IN hWhoseTurn = the attacker. OUT carry = its move is made of spores or powder and its target is BREATHLESS, judged
; by the species that was sent out (wEnemyMonSpecies2 / wBattleMonSpecies2: TRANSFORM changes neither). Keeps bc,
; de, hl.
SporeBlockedForTurn:
	push de
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	ld d, a
	ld a, [wEnemyMonSpecies2]
	jr z, .got
	ld a, [wEnemyMoveNum]
	ld d, a
	ld a, [wBattleMonSpecies2]
.got
	ld e, a
	call SporeMoveBlocked
	pop de
	ret

; Far (the trainer AI's CheckStatusImmunity asks it from bank $0E). IN d = a move, e = a species (internal index).
; OUT carry = the move is made of spores or powder (SporeMoves) and the species is BREATHLESS (BreathlessMons).
; Keeps bc, de, hl.
SporeMoveBlocked::
	push hl
	ld hl, SporeMoves
	ld a, d
	call .inList
	jr nc, .done
	ld hl, BreathlessMons
	ld a, e
	call .inList
.done
	pop hl
	ret

.inList ; carry = a is in the -1-ended list at hl (keeps bc; hl moves)
	push bc
	ld b, a
.loop
	ld a, [hli]
	cp -1
	jr z, .no
	cp b
	jr nz, .loop
	pop bc
	scf
	ret
.no
	pop bc
	and a
	ret

INCLUDE "data/pokemon/breathless.asm"
