; v0.7 FALSE SWIPE (2026-08-30): the move damages normally but always leaves
; the target with at least 1 HP - it can never score a KO.
;
; Both entry points are reached via callfar from the very top of
; ApplyDamageToEnemyPokemon / ApplyDamageToPlayerPokemon in
; engine/battle/core.asm, before wDamage is consumed (no registers are live
; there). Each entry refuses to act unless the hit really is the attacker's
; own FALSE SWIPE on its own turn: confusion self-hits and crash damage
; route through the "other side's" Apply routine with hWhoseTurn pointing at
; the attacker, so the turn check exempts them (a confused user CAN still
; knock itself out). A hit absorbed by a SUBSTITUTE is also exempt - the
; doll may break normally.

CheckFalseSwipeEnemy::
; the player's attack is about to hit the enemy mon
	ldh a, [hWhoseTurn]
	and a
	ret nz ; not the player's own attack
	ld a, [wPlayerMoveEffect]
	cp FALSE_SWIPE_EFFECT
	ret nz
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	ret nz
	ld hl, wEnemyMonHP
	jr ClampFalseSwipeDamage

CheckFalseSwipePlayer::
; the enemy's attack is about to hit the player's mon
	ldh a, [hWhoseTurn]
	and a
	ret z ; not the enemy's own attack
	ld a, [wEnemyMoveEffect]
	cp FALSE_SWIPE_EFFECT
	ret nz
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	ret nz
	ld hl, wBattleMonHP
	; fallthrough

ClampFalseSwipeDamage:
; if wDamage >= target HP (at hl), rewrite wDamage = HP - 1.
; On a 1 HP target the damage becomes 0, which the Apply routine's existing
; zero check turns into a clean no-damage hit.
	ld a, [hli]
	ld d, a
	ld e, [hl] ; de = target's current HP
	ld a, [wDamage]
	ld b, a
	ld a, [wDamage + 1]
	ld c, a ; bc = damage
	ld a, b
	cp d
	ret c ; damage high byte below HP's -> cannot KO, leave it
	jr nz, .clamp
	ld a, c
	cp e
	ret c ; damage < HP -> cannot KO, leave it
.clamp
	ld a, e
	sub 1
	ld [wDamage + 1], a
	ld a, d
	sbc 0
	ld [wDamage], a
	ret
