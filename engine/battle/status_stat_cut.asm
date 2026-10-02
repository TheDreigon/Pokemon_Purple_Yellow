; v1.0 (N5, 2026-09-27; a status's side effect - PARALYZE's speed cut, BURN's attack cut - is
; always cured with the status): whatever ends a burn or a
; paralysis puts the stat back: the side's five battle stats = unmodified x stages (the badge
; boost lives in the unmodified stats, so it stays; no cut). Exact, and right whether or not a
; cut was there - the old "double it back" (UndoBurnParStats) lost the odd point and doubled a
; stat that had no cut. On a side with no BRN or PAR it changes nothing. (It used to put two
; cases right; neither exists any more: a TRANSFORMed #MON no longer carries the target's cut -
; D6, UserStatsWithOwnCut below - and a lowering no longer leaves a stat above 999 - D7,
; effects.asm.)
; Needs stage bytes 1-13 (every writer keeps them there).
; Trashes a, bc, de, hl, f, hMath and wd11e; keeps hWhoseTurn.
PlayerStatusGone:: ; the nap, the player's items
	xor a
SideStatusGone: ; a = the side (0 the player, 1 the enemy): its bad POISON goes, its stats lose any cut
	ld hl, wPlayerBattleStatus3
	and a
	jr z, .gotStatus3
	ld hl, wEnemyBattleStatus3
.gotStatus3
	res BADLY_POISONED, [hl] ; (TOXIC by the Gen 3 rule, toxic_carry.asm: or the next ordinary POISON would tick as TOX)
RecalcSideStats:
	ld [wCalculateWhoseStats], a
	farjp CalculateModifiedStats
TargetStatusGone:: ; SLEEP on a recharging target (it skips the "already statused" test)
	ldh a, [hWhoseTurn]
	xor 1
	jr SideStatusGone
UserStatusGone: ; RECOVER, SOFTBOILED, REST
	ldh a, [hWhoseTurn]
	jr SideStatusGone

; v1.0 (D6, 2026-09-28; the two TRANSFORM bugs found):
; TRANSFORM (transform.asm), once the target's unmodified stats and stages are copied. Vanilla
; copied the target's five battle stats, the TARGET's burn / paralysis cut with them, and the
; user lost its own (TRANSFORM never copies the status). Now the user's five stats = the copied
; unmodified x the copied stages, then the user's OWN cut: the order of every send-out, and
; what a level-up of a TRANSFORMed #MON already did (experience.asm .recalcStatChanges). Both
; sides. With no burn or paralysis on either side it equals the copy.
; Needs the copied stage bytes 1-13. Trashes a, bc, de, hl, f, hMath and wd11e; keeps hWhoseTurn.
UserStatsWithOwnCut:
	ldh a, [hWhoseTurn]
	push af
	call RecalcSideStats ; a = the user's side (0 the player, 1 the enemy)
	pop af
	push af
	xor 1 ; HalveSpeedDueToParalysis / HalveAttackDueToBurn cut the side hWhoseTurn is NOT: the user
	ldh [hWhoseTurn], a
	farcall HalveSpeedDueToParalysis
	farcall HalveAttackDueToBurn
	pop af
	ldh [hWhoseTurn], a
	ret
