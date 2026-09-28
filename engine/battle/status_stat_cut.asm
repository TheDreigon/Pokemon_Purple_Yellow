; v1.0 (N5, 2026-09-27; Forte: "esses side-effects dos status (paralyze-speed e burn-attack)
; deverão sempre tambem ser curados quando o status é curado"): whatever ends a burn or a
; paralysis puts the stat back: the side's five battle stats = unmodified x stages (the badge
; boost lives in the unmodified stats, so it stays; no cut). Exact, and right whether or not a
; cut was there - the old "double it back" (UndoBurnParStats) lost the odd point and doubled a
; stat that had no cut. On a side with no BRN or PAR it changes nothing, bar one case it puts
; right: a stat a lowering left above 999. (A TRANSFORMed #MON no longer carries the target's
; cut: D6, UserStatsWithOwnCut below.)
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

; v1.0 (D6, 2026-09-28; Forte: "sobre o transform: corrige esses 2 bugs encontrados, sim"):
; TRANSFORM (transform.asm), once the target's unmodified stats and stages are copied. Vanilla
; copied the target's five battle stats, the TARGET's burn / paralysis cut with them, and the
; user lost its own (TRANSFORM never copies the status). Now the user's five stats = the copied
; unmodified x the copied stages, then the user's OWN cut: the order of every send-out, and
; what a level-up of a TRANSFORMed #MON already did (experience.asm .recalcStatChanges). Both
; sides. With no burn or paralysis on either side it equals the copy (bar a stat the target
; held above 999 after a lowering from a high stage: capped here).
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
