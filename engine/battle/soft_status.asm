; v1.0 (2026-11-17): the battle conditions that live outside the status byte, one byte per #MON in
; wPlayerMonConds / wEnemyMonConds ("Battle Conditions", ram/wram.asm; the layout of a byte is there and
; its masks are BURN_BITES_MASK, BLEED_BITES_MASK and BLEED_LAYERS_MASK, constants/battle_constants.asm).
; The bytes are indexed by SLOT (the party slot, the trainer's roster slot, slot 0 for a wild #MON), so a
; #MON keeps its conditions through a switch with nothing copied. InitBattleVariables zeroes all twelve at
; the start of every battle, and ClearBattlerConds zeroes one when its #MON faints.
;
; THE BURN THAT BURNS OUT: a burn bites 2 to 4 times (BURN_BITES_MIN..BURN_BITES_MAX), drawn when it is
; inflicted (DrawBurnBites, the one entry every burn site goes through). Each run of the burned side's
; residual is one bite (HandlePoisonBurnLeechSeed, engine/battle/core.asm, asks IsBattlerBurning first and
; calls BurnBiteTaken after the damage). After the last bite the fire is OUT: the BRN bit and the ATTACK
; cut stay until a cure, but there is no more damage and the battle HUD shows the label BRN_OUT (BRN's
; letters in another ink on the GBC; BattlerStatusInkID, engine/battle/hud_status.asm, a near call: this
; section is pinned in its bank).
; A #MON that comes into a battle burned has its fire out: its byte was zeroed at the start.
;
; THE OPEN SLOT (v1.0, 2026-11-17): a burn whose fire is out does not hold the hard-status slot. A new
; status - sleep, poison, TOX, paralysis, freeze, or a burn - lands on such a #MON as on one with no
; status, by its own rules (its chance or accuracy, its type immunities, the doll). Every gate that refuses
; a target that already has a status asks BattlerSlotTaken (through TargetStatusSlot from the move
; effects, through AIPlayerStatusShown from the trainer AI), and every landing goes through
; TargetStatusSlot, which takes the burn's ATTACK cut away with the BRN bit before the new status applies
; its own cut or count. A new burn on such a #MON re-lights it: BurnInflicted then halves the recalculated
; ATTACK once (the same value the old cut left) and draws a fresh count. "already burned!" is said only
; while the fire burns.
;
; The entries marked "far" are reached with farcall from other banks (a far call passes c, d and e in and
; returns de, hl and the flags); the others are near calls from this bank.

; IN  c = the side: 0 the player's active #MON, 1 the enemy's
; OUT hl = the active #MON's conditions byte. bc and de are kept.
; The player's slot is wPlayerMonNumber. The enemy's is wEnemyMonPartyPos in a trainer battle; a wild
; battle has no roster and uses slot 0 (wEnemyMonPartyPos is 0 there too since 2026-09-27, but a
; trainer battle sets it to $ff until its first send-out, so it is asked only in a trainer battle).
BattlerCondsAddr:
	ld a, c
	and a
	jr nz, .enemy
	ld a, [wPlayerMonNumber]
	jr PlayerSlotCondsAddr
.enemy
	ld a, [wIsInBattle]
	cp 2 ; a trainer battle?
	ld a, 0 ; (ld keeps the flags) a wild #MON is slot 0
	jr nz, .gotEnemySlot
	ld a, [wEnemyMonPartyPos]
.gotEnemySlot
	ld hl, wEnemyMonConds
	jr SlotCondsAddr

; IN  a = a party slot of the player
; OUT hl = that #MON's conditions byte. bc and de are kept.
PlayerSlotCondsAddr:
	ld hl, wPlayerMonConds
; fall through
; IN  a = the slot, hl = the side's six bytes
; OUT hl = the slot's byte; a slot outside the party (the $ff before a first send-out) reads slot 0, so
;     nothing outside the twelve bytes is ever written. bc and de are kept.
SlotCondsAddr:
	cp PARTY_LENGTH
	jr c, .inParty
	xor a
.inParty
	add l
	ld l, a
	ret nc
	inc h
	ret

; OUT hl = the conditions byte of the side whose turn it is (the user). bc and de are kept.
UserCondsAddr:
	push bc
	ldh a, [hWhoseTurn]
	ld c, a
	call BattlerCondsAddr
	pop bc
	ret

; OUT hl = the conditions byte of the side whose turn it is NOT (the target). bc and de are kept.
TargetCondsAddr:
	push bc
	ldh a, [hWhoseTurn]
	xor 1
	ld c, a
	call BattlerCondsAddr
	pop bc
	ret

; IN  c = the side
; OUT hl = the active #MON's status byte. a, bc and de are kept.
BattlerStatusAddr:
	ld hl, wBattleMonStatus
	inc c
	dec c
	ret z
	ld hl, wEnemyMonStatus
	ret

; Far. Does the side's active #MON lose health at every run of its residual: poisoned (PSN or TOX), or
; burned with the fire still burning? (The AI's PROTECT stall asks; a burn whose fire is out costs nothing.)
; IN  c = the side
; OUT NZ = yes. de is kept.
BattlerHurtsEachTurn::
	call BattlerStatusAddr
	ld a, [hl]
	and 1 << PSN
	ret nz
	jr IsBattlerBurning.gotStatus

; Far. Is the side's active #MON burning: BRN set and bites left?
; IN  c = the side
; OUT NZ = burning; Z = no burn, or a burn whose fire is out. a = the bites left (0 for Z). bc and de are kept.
IsBattlerBurning::
	call BattlerStatusAddr
.gotStatus
	bit BRN, [hl]
	ld a, 0 ; (ld keeps the flags)
	ret z
; fall through
; IN  c = the side
; OUT a = the burn's bites left of its active #MON, Z when 0. bc and de are kept.
BattlerBurnBitesLeft:
	call BattlerCondsAddr
	ld a, [hl]
	and BURN_BITES_MASK
	ret

; Far. Is the side's hard-status slot taken? It is open with no status, or with a burn alone whose fire
; is out (the open slot, above).
; IN  c = the side
; OUT hl = its active #MON's status byte; Z = open, NZ = taken. bc and de are kept.
BattlerSlotTaken::
	call BattlerStatusAddr
	ld a, [hl]
	and a
	ret z ; no status
	cp 1 << BRN
	ret nz ; another status
	push hl
	call BattlerBurnBitesLeft ; Z: the fire is out
	pop hl
	ret

; Far. The target's hard-status slot (the target is the side that is not hWhoseTurn), for the move
; effects: SleepEffect, PoisonEffect, BurnEffect, TriStatusSideEffect and StatDownBurnLegAnimation (the
; CORRODE animation's mirror of the burn's gate) through TargetSlot (bank $1D),
; FreezeBurnParalyzeStatusGate (status_failure.asm) and ParalyzeEffect_ (bank $3D).
; IN  c = TARGET_SLOT_ANY or TARGET_SLOT_FREEZE: the gate. OUT Z = open, NZ = taken; TARGET_SLOT_FREEZE
;     also opens a slot that holds only sleep (ice over sleep: the whole-byte 1 << FRZ ends the sleep).
; IN  c = a new status byte: it LANDS. It replaces the target's status byte; if that held a burn (one whose
;     fire is out: the gates let no other through), the burn's ATTACK cut goes with it - the target's
;     stats are recalculated as a cure recalculates them (TargetStatusGone, status_stat_cut.asm), before
;     the caller applies the new status's own cut (the paralysis's SPEED, a new burn's ATTACK) or count
;     (the freeze's, TOX's): the cuts are not idempotent.
; OUT hl = the target's status byte. de is kept. A landing over a burn also does what TargetStatusGone does:
;     the target's BADLY_POISONED goes, and hMath, wd11e and wCalculateWhoseStats are written.
TargetStatusSlot::
	ld b, c
	ldh a, [hWhoseTurn]
	xor 1
	ld c, a ; the target's side
	ld a, b
	cp TARGET_SLOT_FREEZE + 1
	jr nc, .land
	and a ; TARGET_SLOT_ANY?
	jr z, BattlerSlotTaken
	call BattlerStatusAddr
	ld a, [hl]
	and ~SLP_MASK
	ret z ; no status, or only sleep: a freeze lands
	jr BattlerSlotTaken
.land
	call BattlerStatusAddr
	ld a, [hl]
	ld [hl], b
	bit BRN, a
	ret z ; no burn went (no status, or a sleep under a freeze): there is no cut to take away
	push de
	push hl
	farcall TargetStatusGone
	pop hl
	pop de
	ret

; Far. The burn the user's move has just inflicted on the TARGET (BRN already set) bites 2 to 4 times,
; drawn uniformly (a draw of 3 in `and 3` is thrown away and drawn again). The other bits of the byte
; (the bleed) are kept. Reached from every site that inflicts a burn through BurnInflicted
; (engine/battle/effects.asm), never from HalveAttackDueToBurn, which the stat recalculations call too.
; Clobbers a, b, hl. c, de are kept.
DrawBurnBites::
	call TargetCondsAddr
.draw
	call BattleRandom
	and %11
	cp BURN_BITES_MAX - BURN_BITES_MIN + 1
	jr nc, .draw
	add BURN_BITES_MIN
	ld b, a
	ld a, [hl]
	and ~BURN_BITES_MASK
	or b
	ld [hl], a
	ret

; Far. The user's burn has just bitten (HandlePoisonBurnLeechSeed, after the damage): one bite less. After
; the last one, if the #MON still stands, both HUDs are drawn (its letters are now the "out" ones) and
; "<USER>'s / fire burned out!" is printed. A bite that knocked it out says nothing: its faint follows.
; Clobbers everything (a, bc, de, hl).
BurnBiteTaken::
	call UserCondsAddr
	ld a, [hl]
	and BURN_BITES_MASK
	ret z ; (no bite was left: the residual bites only a burning #MON)
	dec [hl] ; the bites are the low bits: no borrow into the bleed's
	dec a
	ret nz
	ld hl, wBattleMonHP
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotHP
	ld hl, wEnemyMonHP
.gotHP
	ld a, [hli]
	or [hl]
	ret z
	farcall DrawHUDsAndHPBars
	ld hl, BurnedOutText
	jp PrintText

BurnedOutText:
	text_far _BurnedOutText
	text_end

; Far. The side's active #MON has fainted: its conditions byte goes to 0, so a #MON revived in the same
; battle comes back with none. Called by RemoveFaintedPlayerMon (c = 0) and FaintEnemyPokemon (c = 1).
; IN  c = the side. Clobbers a, hl. bc and de are kept.
ClearBattlerConds::
	call BattlerCondsAddr
	ld [hl], 0
	ret
