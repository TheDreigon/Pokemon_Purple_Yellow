; v1.0 (2026-11-18): no move has HAZE_EFFECT today (the move HAZE is a GAS attack). It does not
; know the states kept in the per-slot battle conditions bytes (engine/battle/soft_status.asm): a
; move that used it would also
; have to end the bleed of both active #MON there (bits 3-7, ClearBleedBits, keeping the burn's bits 0-2)
; and any later state stored there.
HazeEffect_:
	ld a, $7
; store 7 on every stat mod
	ld hl, wPlayerMonAttackMod
	call ResetStatMods
	ld hl, wEnemyMonAttackMod
	call ResetStatMods
; copy unmodified stats to battle stats
	ld hl, wPlayerMonUnmodifiedAttack
	ld de, wBattleMonAttack
	call ResetStats
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wEnemyMonAttack
	call ResetStats
; cure non-volatile status, but only for the target
	ld hl, wEnemyMonStatus
	ld de, wEnemySelectedMove
	ldh a, [hWhoseTurn]
	and a
	jr z, .cureStatuses
	ld hl, wBattleMonStatus
	dec de ; wPlayerSelectedMove

.cureStatuses
	ld a, [hl]
	ld [hl], $0
	and (1 << FRZ) | SLP_MASK
	jr z, .cureVolatileStatuses
; prevent the Pokemon from executing a move if it was asleep or frozen
	ld a, $ff
	ld [de], a

.cureVolatileStatuses
	xor a
	ld [wPlayerDisabledMove], a
	ld [wEnemyDisabledMove], a
	ld hl, wPlayerDisabledMoveNumber
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerBattleStatus1
	call CureVolatileStatuses
	ld hl, wEnemyBattleStatus1
	call CureVolatileStatuses
; v0.7: was `ld hl / call CallBankF`. That wrapper computed its bank from
; BANK(PrintButItFailedText_), so when the effects moved banks it kept
; working -- but only because wrapper key and target moved TOGETHER. farcall
; says what it means and cannot rot that way.
	farcall PlayCurrentMoveAnimation
	ld hl, StatusChangesEliminatedText
	jp PrintText

CureVolatileStatuses:
	res CONFUSED, [hl]
	inc hl ; BATTSTATUS2
	ld a, [hl]
	; clear LOCKED_ON (was X Accuracy's), PROTECTED_BY_MIST, GETTING_PUMPED, and SEEDED statuses
	and ~((1 << LOCKED_ON) | (1 << PROTECTED_BY_MIST) | (1 << GETTING_PUMPED) | (1 << SEEDED))
	ld [hli], a ; BATTSTATUS3
	ld a, [hl]
; (v1.0 2026-11-11) A trap for whoever gives a move HAZE_EFFECT again (none has it:
; HAZE is a GAS attack). This clears BADLY_POISONED on BOTH sides, but HazeEffect_
; zeroes only the TARGET's status byte: the USER's stays PSN and TOX ($88), and
; SyncToxicFlags (toxic_carry.asm) sets its BADLY_POISONED again at the next
; write-back, so its bad POISON would survive the HAZE. Decide then: clear TOX in the
; user's status byte too (vanilla: its bad POISON becomes ordinary), or leave the
; user's side alone.
	and %11110000 | (1 << TRANSFORMED) ; clear Bad Poison, Reflect and Light Screen statuses
	ld [hl], a
	ret

ResetStatMods:
	ld b, NUM_STAT_MODS
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

ResetStats:
	ld b, NUM_BATTLE_STATS * 2 ; Attack..last stat, two bytes each
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

StatusChangesEliminatedText:
	text_far _StatusChangesEliminatedText
	text_end

; CallBankF deleted: its name promised bank $0F but its body computed
; BANK(PrintButItFailedText_), which now resolves elsewhere. Its one caller
; uses farcall now. A wrapper whose bank is keyed to an unrelated symbol is
; exactly the trap cross_bank_call_audit cannot see through.
