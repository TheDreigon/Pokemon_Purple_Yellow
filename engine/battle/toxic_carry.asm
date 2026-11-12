; v1.0 (2026-11-11; replaces the byte-3 carrier of 2026-09-27): a bad POISON (TOXIC)
; is marked in the #MON's own STATUS byte: TOX (bit 7) together with PSN = $88.
; PoisonEffect sets it when TOXIC lands, and it goes wherever the status byte is
; copied: the party (ReadPlayerMonCurHPAndStatus), the trainer's roster
; (SwitchEnemyMon), a box, the day care, a caught #MON. It outlives the battle; out
; of battle it is the only poison that costs HP (engine/events/toxic_step.asm).
; BADLY_POISONED (bit 0 of wXBattleStatus3) is what the battle reads: the tick, the
; HUD, the AI, the catch. It is a copy of the mark for the #MON on the field,
; re-derived from its status byte at every send-out of the player's #MON and of a
; trainer's, and at every write-back to the party (the top of each turn, a faint, a
; drain): the two cannot disagree for longer than a turn. Its count starts over at
; those send-outs (Gen 3). A wild #MON has no send-out of its own: it starts from
; the battle status bytes EndOfBattle zeroed and a status of 0.
; Byte 3 of the party / roster data (MON_BOX_LEVEL) is the freeze count alone again.
; TOX is read only together with PSN: a bit 7 alone is never a bad POISON. Every cure
; writes the whole status byte (0, or a sleep count), so the mark cannot be left behind.
; In "Battle Core Overflow" (bank $10), reached by farcall: Battle Core is near
; its floor.

; ReadPlayerMonCurHPAndStatus, before it copies HP / byte 3 / status to the party.
; OUT wBattleMonBoxLevel = wPlayerFreezeCounter (the status byte carries a bad POISON
;     by itself), then both sides' BADLY_POISONED re-derived. Trashes a, hl.
StoreBattleMonByte3::
	ld a, [wPlayerFreezeCounter] ; 0-7
	ld [wBattleMonBoxLevel], a
	; fallthrough

; Both battlers' BADLY_POISONED = "its status byte has PSN and TOX". Touches that bit
; alone, never a toxic count. Trashes a, hl.
SyncToxicFlags:
	ld a, [wBattleMonStatus]
	ld hl, wPlayerBattleStatus3
	call .side
	ld a, [wEnemyMonStatus]
	ld hl, wEnemyBattleStatus3
; IN a = a battler's status byte, hl = its BattleStatus3
.side
	res BADLY_POISONED, [hl]
	and (1 << PSN) | (1 << TOX)
	cp (1 << PSN) | (1 << TOX)
	ret nz
	set BADLY_POISONED, [hl]
	ret

; SendOutMon, right after it cleared wPlayerStatsToDouble..wPlayerBattleStatus3.
; IN  wBattleMonStatus as LoadBattleMonFromParty copied it.
; The count starts over (Gen 3). Trashes a, hl.
RestoreBattleMonToxic::
	xor a
	ld [wPlayerToxicCounter], a
	ld a, [wBattleMonStatus]
	ld hl, wPlayerBattleStatus3
	jr SyncToxicFlags.side

; LoadEnemyMonData (trainer branch), right after it copied the roster's byte 3 (the
; freeze count) into wEnemyFreezeCounter and its status into wEnemyMonStatus.
; EnemySendOutFirstMon cleared the enemy's battle status bytes before that.
; Trashes a, hl.
RestoreEnemyMonToxic::
	xor a
	ld [wEnemyToxicCounter], a
	ld a, [wEnemyMonStatus]
	ld hl, wEnemyBattleStatus3
	jr SyncToxicFlags.side

; LoadEnemyMonData's tail (moved here from Battle Core by v1.0 N5-A, 2026-09-27):
; the unmodified stats (level + stats, the base every recalculation starts
; from), every stage back to neutral, no stale SP.DEF override.
; Then (N5-A) a trainer's #MON sent in burnt or paralysed has its cut, as the
; player's has (LoadBattleMonFromParty): before this, one the switch layer
; called back came in again at its full SPEED or ATTACK. Wild: none - the ball's
; reload of a TRANSFORMed #MON (item_effects .skip6) must stay uncut, as
; AddPartyMon copies these stats. Last (v1.0 D3), in Normal, a trainer's #MON takes the PP
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
