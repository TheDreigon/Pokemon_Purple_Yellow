; v1.0 (2026-09-27, Forte: "Recomendo a regra da Gen 3: continua tóxico depois
; da troca, a contagem recomeça e o menu mostra TOX - pode ser assim"): TOXIC by
; the Gen 3 rule. A badly poisoned #MON stays badly poisoned when it is called
; back, its count starts over when it comes back in, and the battle's end leaves
; it ordinary POISON (Gen 3-4, EndOfBattle).
; The flag is bit 7 (BOX_LEVEL_TOXIC_F) of byte 3 of the party / roster data
; (MON_BOX_LEVEL), above the freeze count (bits 0-6). Bit 7 is free there: FRZ
; and PSN never share the status byte, a box level is at most MAX_LEVEL, every
; other writer puts 0. Bit 7 means "badly poisoned" ONLY together with PSN in
; the same #MON's status byte: never read it alone.
; In "Battle Core Overflow" (bank $10), reached by farcall: Battle Core is near
; its floor.

; ReadPlayerMonCurHPAndStatus, before it copies HP / byte 3 / status to the party.
; OUT wBattleMonBoxLevel = wPlayerFreezeCounter | (1 << BOX_LEVEL_TOXIC_F) when
;     the #MON is badly poisoned (PSN and BADLY_POISONED). Trashes a, hl.
StoreBattleMonByte3::
	ASSERT BADLY_POISONED == 0 && BOX_LEVEL_TOXIC_F == 7, "StoreBattleMonByte3 moves bit 0 to bit 7 with an rrca"
	ld a, [wBattleMonStatus]
	and 1 << PSN
	jr z, .gotToxicBit ; a = 0 (a leftover BADLY_POISONED without PSN is not carried)
	ld a, [wPlayerBattleStatus3]
	rrca
	and 1 << BOX_LEVEL_TOXIC_F
.gotToxicBit
	ld hl, wPlayerFreezeCounter ; 0-6, never bit 7
	or [hl]
	ld [wBattleMonBoxLevel], a
	ret

; SendOutMon, right after it cleared wPlayerStatsToDouble..wPlayerBattleStatus3.
; IN  wBattleMonBoxLevel / wBattleMonStatus as LoadBattleMonFromParty copied them.
; The count starts over (Gen 3). Trashes a, hl.
RestoreBattleMonToxic::
	xor a
	ld [wPlayerToxicCounter], a
	ld a, [wBattleMonStatus]
	and 1 << PSN
	ret z
	ld a, [wBattleMonBoxLevel]
	add a ; bit 7 -> carry
	ret nc
	ld hl, wPlayerBattleStatus3
	set BADLY_POISONED, [hl]
	ret

; LoadEnemyMonData (trainer branch), right after it copied the roster's byte 3
; WHOLE into wEnemyFreezeCounter and its status into wEnemyMonStatus.
; EnemySendOutFirstMon cleared the enemy's battle status bytes before that.
; Takes bit 7 off wEnemyFreezeCounter (a stray bit 7 there would be a 128-turn
; freeze). Trashes a, hl.
RestoreEnemyMonToxic::
	xor a
	ld [wEnemyToxicCounter], a
	ld hl, wEnemyFreezeCounter
	bit BOX_LEVEL_TOXIC_F, [hl]
	ret z
	res BOX_LEVEL_TOXIC_F, [hl] ; what is left is the freeze count
	ld a, [wEnemyMonStatus]
	and 1 << PSN
	ret z
	ld hl, wEnemyBattleStatus3
	set BADLY_POISONED, [hl]
	ret

; EndOfBattle: every party #MON leaves a bad POISON as ordinary POISON (Gen 3-4),
; so nothing says TOX outside a battle. All six slots: an empty slot's byte 3 is
; rewritten when a #MON is added. The freeze count under it stays. Trashes b, de, hl.
RevertPartyToxic::
	ld hl, wPartyMon1BoxLevel
	ld de, wPartyMon2 - wPartyMon1
	ld b, PARTY_LENGTH
.loop
	res BOX_LEVEL_TOXIC_F, [hl]
	add hl, de
	dec b
	jr nz, .loop
	ret

; LoadEnemyMonData's tail (moved here from Battle Core by v1.0 N5-A, 2026-09-27):
; the unmodified stats (level + stats, the base every recalculation starts
; from), every stage back to neutral, no stale SP.DEF override.
; Then (N5-A) a trainer's #MON sent in burnt or paralysed has its cut, as the
; player's has (LoadBattleMonFromParty): before this, one the switch layer
; called back came in again at its full SPEED or ATTACK. Wild: none - the ball's
; reload of a TRANSFORMed #MON (item_effects .skip6) must stay uncut, as
; AddPartyMon copies these stats. (Link battles never get here:
; LoadEnemyMonFromParty.) Last (v1.0 D3), in Normal, a trainer's #MON takes the PP
; its roster holds, over the full PP LoadMovePPs gave it. Keeps hWhoseTurn.
; Trashes a, bc, de, hl.
LoadEnemyMonDataTail::
	ld hl, wEnemyMonLevel
	ld de, wEnemyMonUnmodifiedLevel
	ld bc, 1 + NUM_STATS * 2
	call CopyData
	ld a, $7 ; default stat mod
	ld b, NUM_STAT_MODS ; number of stat mods
	ld hl, wEnemyMonStatMods
.statModLoop
	ld [hli], a
	dec b
	jr nz, .statModLoop
	xor a
	ld [wStatModIndexOverride], a ; the split (F2a): a stale SP.DEF override must not outlive a send-out
	ld a, [wIsInBattle]
	cp 2 ; a trainer battle
	ret nz
	ldh a, [hWhoseTurn]
	push af
	farcall ApplyBurnAndParalysisPenaltiesToEnemy ; sets hWhoseTurn 0
	pop af
	ldh [hWhoseTurn], a
; v1.0 (D3, 2026-09-28): the PP its trainer's roster holds, as the player's #MON
; comes in with its party PP (LoadBattleMonFromParty). DecrementEnemyPP spends the
; roster PP with the battle PP (Normal), so a #MON the switch layer called back
; comes in again with the PP it left with; LoadMovePPs (LoadEnemyMonData) gave it
; full PP from its move ids on every send-out. A fresh #MON's roster PP is its full
; PP (ReadTrainerFinishUp), so a first send-out is unchanged; a TRANSFORMed #MON's
; copied PP never reach the roster (DecrementEnemyPP, and IncrementMovePP's refund
; since D9), so it comes back with its own. Hard: its trainer's PP never drops, and the roster is not read (the gate is
; DecrementEnemyPP's).
	ld a, [wDifficulty]
	and a
	ret nz
	ld a, [wEnemyMonPartyPos] ; its roster slot: LoadEnemyMonData's trainer branch just wrote it
	ld hl, wEnemyMon1PP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld de, wEnemyMonPP
	ld bc, NUM_MOVES
	jp CopyData
