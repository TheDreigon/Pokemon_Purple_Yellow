; v1.0 (2026-09-24): AdjustDamageForMoveType, moved out of Battle Core (bank $F)
; when that bank reached its 4000-byte floor. Self-contained: reads the battle
; structs, applies STAB (incl. the PORYGON TRI ATTACK exception), farcalls the
; matchups walk in bank $30 and applies the flat crit bonus. Both callers
; (core.asm, player and enemy damage paths) farcall it; a nested farcall is
; fine, Bankswitch keeps the return bank on the stack.

SECTION "Battle Core Overflow", ROMX

; function to adjust the base damage of an attack to account for type effectiveness
AdjustDamageForMoveType::
; values for player turn
	ld hl, wBattleMonType
	ld a, [hli]
	ld b, a    ; b = type 1 of attacker
	ld c, [hl] ; c = type 2 of attacker
	ld hl, wEnemyMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wPlayerMoveType]
	ld [wMoveType], a
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
; values for enemy turn
	ld hl, wEnemyMonType
	ld a, [hli]
	ld b, a    ; b = type 1 of attacker
	ld c, [hl] ; c = type 2 of attacker
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wEnemyMoveType]
	ld [wMoveType], a
.next
	ld a, [wMoveType]
	cp b ; does the move type match type 1 of the attacker?
	jr z, .sameTypeAttackBonus
	cp c ; does the move type match type 2 of the attacker?
	jr z, .sameTypeAttackBonus
; v0.7: TRI_ATTACK is typed BIRD on purpose, so it is neutral against every
; type (BIRD has no rows in the matchups table) — but that also means it can
; never match Porygon's NORMAL/ELECTRIC and would never earn STAB. Grant it
; here, keyed on move + species. Done this way rather than by giving Porygon
; the BIRD type because a type is also DEFENSIVE: BIRD's blank matchup rows
; would have flattened Porygon's own weaknesses and resistances.
; Only `a` is touched — d/e still hold the defender's types for the
; effectiveness walk below.
	ldh a, [hWhoseTurn]
	and a
	jr nz, .triAttackEnemyTurn
	ld a, [wPlayerMoveNum]
	cp TRI_ATTACK
	jr nz, .skipSameTypeAttackBonus
	ld a, [wBattleMonSpecies2]
	cp PORYGON
	jr z, .sameTypeAttackBonus
	jr .skipSameTypeAttackBonus
.triAttackEnemyTurn
	ld a, [wEnemyMoveNum]
	cp TRI_ATTACK
	jr nz, .skipSameTypeAttackBonus
	ld a, [wEnemyMonSpecies2]
	cp PORYGON
	jr nz, .skipSameTypeAttackBonus
.sameTypeAttackBonus
; if the move type matches one of the attacker's types
	ld hl, wDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a    ; hl = damage
	ld b, h
	ld c, l    ; bc = damage
	srl b
	rr c      ; bc = floor(0.5 * damage)
	add hl, bc ; hl = floor(1.5 * damage)
; store damage
	ld a, h
	ld [wDamage], a
	ld a, l
	ld [wDamage + 1], a
	ld hl, wDamageMultipliers
	set 7, [hl]
.skipSameTypeAttackBonus
; v0.7: the matchups table + walk loop moved to bank $30
; (engine/battle/type_effectiveness.asm). Battle Core was 2 bytes
; over budget in debug builds after the matchups expansion.
	farcall ApplyTypeEffectivenessToDamage
; v0.7 crit rework: a critical hit is a flat x1.5, applied AFTER type
; effectiveness on purpose -- a resisted hit that collapses to 0 must reach
; the "not even a scratch" message above, and 1.5x0 is still 0; putting the
; bonus first would let a crit dodge that message. Same big-endian
; d + (d >> 1) idiom as the STAB block above. Guarded on exactly 1: the OHKO
; scaffolding values ($2/$ff) in wCriticalHitOrOHKO stay out.
	ld a, [wCriticalHitOrOHKO]
	dec a
	ret nz
	ld hl, wDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a    ; hl = damage
	ld b, h
	ld c, l    ; bc = damage
	srl b
	rr c       ; bc = floor(0.5 * damage)
	add hl, bc ; hl = floor(1.5 * damage)
	ld a, h
	ld [wDamage], a
	ld a, l
	ld [wDamage + 1], a
	ret

