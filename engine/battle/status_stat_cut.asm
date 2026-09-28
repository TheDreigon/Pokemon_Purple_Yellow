; v1.0 (N5, 2026-09-27; Forte: "esses side-effects dos status (paralyze-speed e burn-attack)
; deverão sempre tambem ser curados quando o status é curado"): whatever ends a burn or a
; paralysis puts the stat back: the side's five battle stats = unmodified x stages (the badge
; boost lives in the unmodified stats, so it stays; no cut). Exact, and right whether or not a
; cut was there - the old "double it back" (UndoBurnParStats) lost the odd point and doubled a
; stat that had no cut. On a side with no BRN or PAR it changes nothing, bar two cases it puts
; right: a TRANSFORMed #MON's copied cut, and a stat a lowering left above 999.
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
