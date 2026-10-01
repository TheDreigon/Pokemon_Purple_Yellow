; Type-effectiveness lookups for Pokémon Purple Yellow.
;
; v0.7: extracted from engine/battle/core.asm (bank $0F) because the
; expanded type matchups table pushed Battle Core past 16 KB in debug
; builds. Both lookup loops now live in bank $30 alongside the data
; table itself; core.asm `farcall`s into them.
;
; Both functions read TypeEffects (defined in data/types/type_matchups.asm,
; INCLUDEd at the bottom of this file) and use only HRAM/WRAM and
; home-bank routines (Multiply, Divide), so they run unchanged in any
; bank.

; Walk TypeEffects and apply every matching multiplier to wDamage,
; chained (so dual-typed defenders get 4x / 0.25x as expected). Sets
; wMoveMissed if a chained multiplier collapses damage to 0.
; In: d = defender type 1, e = defender type 2.
; Reads wMoveType, wDamage, wDamageMultipliers, hWhoseTurn and that side's
; w*MoveNum (v1.0, F4: MIND BREAK); writes wDamage, wDamageMultipliers,
; wMoveMissed. Clobbers bc.
ApplyTypeEffectivenessToDamage::
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .gotMove
	ld a, [wEnemyMoveNum]
.gotMove
	ld c, a ; v1.0 (F4): c = the move being used, for TypeRowMultiplier (the walk never reads c; push bc keeps it)
	ld a, [wMoveType]
	ld b, a
	ld hl, TypeEffects
.loop
	ld a, [hli] ; a = "attacking type" of the current type pair
	cp $ff
	ret z
	cp b ; does move type match "attacking type"?
	jr nz, .nextTypePair
	ld a, [hl] ; a = "defending type" of the current type pair
	cp d ; does type 1 of defender match "defending type"?
	jr z, .matchingPairFound
	cp e ; does type 2 of defender match "defending type"?
	jr z, .matchingPairFound
	jr .nextTypePair
.matchingPairFound
; if the move type matches the "attacking type" and one of the defender's types matches the "defending type"
	push hl
	push bc
	inc hl
	ld a, [wDamageMultipliers]
	and $80
	ld b, a
	ld a, [hl] ; a = damage multiplier
	call TypeRowMultiplier ; v1.0 (F4): MIND BREAK on DARK's row reads NOT_VERY_EFFECTIVE
	ldh [hMultiplier], a
	and a  ; cp NO_EFFECT
	jr z, .gotMultiplier
	cp NOT_VERY_EFFECTIVE
	jr nz, .nothalf
	ld a, [wDamageMultipliers]
	and $7f
	srl a
	jr .gotMultiplier
.nothalf
	cp SUPER_EFFECTIVE
	jr nz, .gotMultiplier
	ld a, [wDamageMultipliers]
	and $7f
	sla a
.gotMultiplier
	add b
	ld [wDamageMultipliers], a
	xor a
	ldh [hMultiplicand], a
	ld hl, wDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld [hli], a
	ld b, a
	ldh a, [hQuotient + 3]
	ld [hl], a
	or b ; is damage 0?
	jr nz, .skipTypeImmunity
.typeImmunity
; if damage is 0, make the move miss
; this only occurs if a move that would do 2 or 3 damage is 0.25x effective against the target
;
; v0.7: it did connect -- it just could not scratch the paint. Reporting that
; as a miss is the one case where Gen 1 lies about what happened, and it is the
; case a player is most likely to blame on bad luck rather than on the matchup.
; The reason code makes PrintMoveFailureText say so; every other reader still
; only asks whether the move landed.
	ld a, MOVE_FAILED_NO_SCRATCH
	ld [wMoveMissed], a
.skipTypeImmunity
	pop bc
	pop hl
.nextTypePair
	inc hl
	inc hl
	jp .loop


; function to tell how effective the type of an enemy attack is on the player's current pokemon
; the result is stored in [wTypeEffectiveness]
; used by the AI's move-scoring layers (1, 3 and 5, through trainer_ai.asm's AIMoveEffectiveness and
; AIDamageEffectiveness - v1.0 R9); AITypeMatchup below reuses its
; chain loop for any attacking type against any defender (the switch-in picker)
;
; v0.7 FIX: this used to RETURN at the first matching row, so a dual-typed
; defender was judged on one of its two types — whichever the table happened
; to list first. Measured against the current 188-row table and the 151
; base_stats, 317 (defender, attacking type) combinations disagreed with the
; real damage result, and in 27 of them the move is actually a NO_EFFECT
; immunity that the AI was reading as neutral or super effective: a boss with
; EARTHQUAKE scored 20 (super effective) against a FIRE/FLYING Charizard,
; ELECTRIC scored 5 instead of 0 against the ROCK/GROUND Geodude line, and
; FIGHTING scored 20 instead of 0 against a GHOST/DARK Gengar. The AI would
; then actively prefer a move that cannot deal a single point of damage.
; Now every matching row is chained into the running multiplier, exactly like
; ApplyTypeEffectivenessToDamage above, so an immunity anywhere in the chain
; collapses the whole score to 0. Each (attacking type, defending type) pair
; appears once in the table, so a single-typed defender - which stores its
; type twice - still applies its row only once.
AIGetTypeEffectiveness::
	ld a, [wEnemyMoveType]
	ld d, a                    ; d = type of enemy move
	ld a, [wEnemyMoveNum]
	ld e, a                    ; v1.0 (F4): e = the enemy's move (layers 1, 3 and 5 ReadMove it first)
	ld hl, wBattleMonType
	ld b, [hl]                 ; b = type 1 of player's pokemon
	inc hl
	ld c, [hl]                 ; c = type 2 of player's pokemon
AIGetTypeEffectivenessDBC:     ; d = attacking type, b and c = the defender's types, e = the move (NO_MOVE: types alone)
	; initialize to neutral effectiveness
	ld a, EFFECTIVE ; v0.7 fix: was $10 (=16), a vanilla Gen 1 bug that made
	ld [wTypeEffectiveness], a ; the AI read untabled (neutral) matchups as super-effective
	ld hl, TypeEffects
.loop
	ld a, [hli]
	cp $ff
	ret z
	cp d                      ; match the type of the move
	jr nz, .nextTypePair1
	ld a, [hli]
	cp b                      ; match with type 1 of pokemon
	jr z, .matchingPairFound
	cp c                      ; or match with type 2 of pokemon
	jr z, .matchingPairFound
	jr .nextTypePair2
.nextTypePair1
	inc hl
.nextTypePair2
	inc hl
	jr .loop
.matchingPairFound
	; v0.7: removed vanilla Yellow's "40% chance for Lorelei's Dewgong to
	; ignore type effectiveness" quirk. It was the only trainer+species
	; hardcoded AI special-case in the engine, was never properly
	; documented (the disassembly comment ended in `?`), and clashed with
	; this hack's philosophy of explicit, controlled difficulty tuning.
	; If softening is wanted for the first E4, do it via team / moveset /
	; level — not via a hidden 40% random nerf on one specific Pokémon.
	;
	; hl points at this row's multiplier; chain it in and keep scanning:
	;   wTypeEffectiveness = wTypeEffectiveness * multiplier / 10
	; The running value never exceeds 40 (20 * 20 / 10), so only the low
	; quotient byte matters.
	; home Multiply preserves only hl and bc, so d (the move type this loop
	; compares against) is saved explicitly rather than relying on _Multiply
	; happening to leave de alone.
	push bc
	push de
	push hl
	ld c, e                    ; v1.0 (F4): the move, for TypeRowMultiplier (c is back at pop bc)
	ld a, [hl]                 ; a = damage multiplier of this row
	call TypeRowMultiplier
	ldh [hMultiplier], a
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wTypeEffectiveness]
	ldh [hMultiplicand + 2], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld [wTypeEffectiveness], a
	pop hl
	pop de
	pop bc
	jr .nextTypePair2          ; a defender's OTHER type may still have a row

AITypeMatchup::
; v1.0 (2026-09-26, the switch-in picker): the same chained lookup for ANY
; attacking type against ANY defender, for AIPickSwitchTarget in bank $0E. A
; farcall hands over only c, d and e and gives back only de and hl, so:
; in: d = the attacking type, e and c = the defender's two types (a single
; type stored twice, as everywhere). Out: e (and wTypeEffectiveness) = the
; multiplier: EFFECTIVE = neutral, 0 = immune, above it super effective.
	ld b, e
	ld e, NO_MOVE ; v1.0 (F4): types alone - the picker weighs types, not moves
	call AIGetTypeEffectivenessDBC
	ld a, [wTypeEffectiveness]
	ld e, a
	ret

; v1.0 (F4, 2026-09-30; Forte: "na verdade, podes tambem abrir excepcao para o Mind Break, para se
; diferenciar ainda mais como uma versao mais forte do move psychic", then "mind break vs dark a
; 0.5x, sim."): the chart's one exception, shared by the damage walk and the AI's walk so the two
; can never disagree. In: a = the multiplier of the row that matched, hl -> it (the row's defending
; type at hl - 1), c = the move (NO_MOVE: types alone). Out: a = NOT_VERY_EFFECTIVE for MIND BREAK
; on a NO_EFFECT row whose defending type is DARK (MIND BREAK is PSYCHIC: the PSYCHIC -> DARK row),
; else a unchanged. MIND BREAK's paralysis (45%) comes with the hit. Keeps bc, de, hl.
ASSERT NO_EFFECT == 0, "TypeRowMultiplier tests NO_EFFECT with `and a`"
TypeRowMultiplier:
	and a ; NO_EFFECT?
	ret nz
	ld a, c
	cp MIND_BREAK
	jr nz, .immune
	dec hl
	ld a, [hl] ; the row's defending type
	inc hl
	cp DARK
	ld a, NOT_VERY_EFFECTIVE
	ret z
.immune
	xor a ; NO_EFFECT
	ret


INCLUDE "data/types/type_matchups.asm"
