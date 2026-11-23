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
; THE BLEED (v1.0, 2026-11-18): bits 3-5 of the byte are the bleed's bites left (0 = not bleeding), bits
; 6-7 its layers minus 1. A hit of a move of BleedMoves (data/battle/bleed_moves.asm) may make its target
; bleed (BleedSourceStep): the first bleed is one layer of 2 to 4 bites, a further one adds a layer (up to
; BLEED_LAYERS_MAX) and draws a fresh count. Each run of the bleeding side's residual is one bite of
; layers x max(1, max HP / 16) (HandlePoisonBurnLeechSeed: BleedBiteStart, the damage, BleedBiteTaken);
; after the last bite the bleed is over. It also ends when a freeze lands on the #MON (FreezeEndsTargetBleed), by
; its own REST, RECOVER or SOFTBOILED (CureUserBleed), and by a FULL HEAL or a FULL RESTORE, the player's on the
; active #MON or a benched one (ItemEndsBleed) and the trainer's (AICureEnemyBleed). It never touches the status
; byte: it coexists with every hard
; status, with confusion and with a burn, which shares this byte - every write here keeps the burn's bits,
; and every write of the burn keeps the bleed's. It needs no code to end with the battle or at a faint:
; the byte is zeroed there (above).
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

; Far. Does the side's active #MON lose health at every run of its residual: poisoned (PSN or TOX), bleeding
; (v1.0 2026-11-18), or burned with the fire still burning? (The AI's PROTECT stall asks; a burn whose fire is out
; costs nothing. Of the player's bleed it learns only that it bleeds, which the HUD shows: never its layers or
; bites.)
; IN  c = the side
; OUT NZ = yes. de is kept.
BattlerHurtsEachTurn::
	call BattlerStatusAddr
	ld a, [hl]
	and 1 << PSN
	ret nz
	call IsBattlerBleeding ; (keeps bc)
	ret nz
; fall through

; Far. Is the side's active #MON burning: BRN set and bites left?
; IN  c = the side
; OUT NZ = burning; Z = no burn, or a burn whose fire is out. a = the bites left (0 for Z). bc and de are kept.
IsBattlerBurning::
	call BattlerStatusAddr
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

; Far. Is the side's active #MON bleeding?
; IN  c = the side
; OUT NZ = bleeding, a = its bites left (1-4); Z = not bleeding, a = 0. hl = its conditions byte. bc and de
;     are kept.
IsBattlerBleeding::
	call BattlerCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret z
	rrca ; (rrca clears Z)
	rrca
	rrca
	ret

; Far. The bleed's sources: once per use of a damaging move, after its side effect (ExecutePlayerMove
; .executeOtherEffects, ExecuteEnemyMove .notMultiHitMove). Those are reached only when the move hit (a miss
; and a type immunity leave the move before them) and the target still stands (a knock-out leaves first), and
; once per use: after the last hit of a multi-hit move. The key is the move actually executed, wPlayerMoveNum /
; wEnemyMoveNum (after METRONOME or MIRROR MOVE the selected move still names the caller). A move of
; BleedMoves makes the target bleed when the roll lands, unless its hit struck a SUBSTITUTE, held or broken
; (wMoveHitSubstitute: it means "this move struck a doll" and stays set for the rest of the move, which is
; what a step run once per use wants), or the target is FROZEN, a GHOST by any of its three types, or
; BLOODLESS by the species it looks like now (IsSpeciesBloodless). Those refusals come before the roll and
; say nothing; a roll that fails says nothing either. A bleed that lands: BleedInflicted.
; Clobbers everything.
BleedSourceStep::
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .gotMove
	ld a, [wEnemyMoveNum]
.gotMove
	ld hl, BleedMoves
	ld de, 2
	call IsInArray
	ret nc ; not a source
	inc hl
	ld d, [hl] ; the chance
	ld a, [wMoveHitSubstitute]
	and a
	ret nz ; the hit struck a doll
	ldh a, [hWhoseTurn]
	xor 1
	ld c, a ; the target's side
	call BattlerStatusAddr
	bit FRZ, [hl]
	ret nz
	ASSERT wBattleMonType1 == wBattleMonStatus + 1 && wEnemyMonType1 == wEnemyMonStatus + 1
	ASSERT wBattleMonType2 == wBattleMonStatus + 2 && wEnemyMonType2 == wEnemyMonStatus + 2
	ASSERT wBattleMonSpecies == wBattleMonStatus - 4 && wEnemyMonSpecies == wEnemyMonStatus - 4
	inc hl
	ld a, [hli] ; its type 1
	cp GHOST
	ret z
	ld a, [hld] ; its type 2
	cp GHOST
	ret z
	dec hl
	dec hl
	dec hl
	dec hl
	dec hl
	ld a, [hl] ; the species it looks like now (TRANSFORM copies it)
	ld b, a
	call GetThirdType ; (keeps bc, de, hl)
	cp GHOST
	ret z
	ld c, b
	call IsSpeciesBloodless
	ret c
	call BattleRandom
	cp d
	ret nc ; the roll failed
; fall through
; The user's move has made the TARGET bleed. Not bleeding: one layer, "<TARGET> / is bleeding!". Already
; bleeding: one layer more (at most BLEED_LAYERS_MAX), "<TARGET>'s / bleeding worse!". Either way a fresh
; count of 2 to 4 bites (DrawBleedBites). The burn's bits are kept. Clobbers everything.
BleedInflicted:
	call TargetCondsAddr
	ld de, BleedingText
	ld a, [hl]
	and BLEED_BITES_MASK
	ld a, [hl] ; (ld keeps the flags)
	jr z, .firstLayer ; layers minus 1 = 0
	ld de, BleedingWorseText
	and BLEED_LAYERS_MASK
	cp BLEED_LAYERS_MASK
	jr z, .gotLayers ; at the cap: the layers stay, the count is fresh
	add 1 << 6 ; one layer more
	jr .gotLayers
.firstLayer
	xor a
.gotLayers
	ld b, a
	ld a, [hl]
	and BURN_BITES_MASK
	or b
	ld b, a ; the burn's bits and the bleed's layers
	call DrawBleedBites
	push de
	farcall DrawHUDsAndHPBars
	pop hl
	jp PrintText

; IN  b = the byte's other bits (the burn's and the layers), hl = the byte. The bleed's bites, 2 to 4, drawn
; uniformly (a draw of 3 in `and 3` is thrown away and drawn again), go into bits 3-5 beside b.
; Clobbers a. bc, de and hl are kept.
DrawBleedBites:
	call BattleRandom
	and %11
	cp BLEED_BITES_MAX - BLEED_BITES_MIN + 1
	jr nc, DrawBleedBites
	add BLEED_BITES_MIN
	add a
	add a
	add a ; << 3: bits 3-5
	or b
	ld [hl], a
	ret

; Far. Is the species BLOODLESS (data/pokemon/bloodless.asm)? The one routine that reads the list: the bleed's gate
; (BleedSourceStep) and the STATS page's "BLOODLESS" (PrintMonAirborne, print_type.asm: Battle Engine 3 is pinned in
; this bank, so it calls near) ask the same list.
; IN  c = the species (internal index). OUT carry = BLOODLESS. bc, de and hl are kept.
IsSpeciesBloodless::
	push hl
	ld hl, BloodlessMons
.loop
	ld a, [hli]
	cp -1
	jr z, .done ; (cp -1 left no carry)
	cp c
	jr nz, .loop
	scf
.done
	pop hl
	ret

; Far. The start of a bleed's bite: HandlePoisonBurnLeechSeed asks it after the poison or burn step and its
; HP test, before LEECH SEED. When the user bleeds: "<USER>'s / hurt by bleeding!", then the animation.
; OUT Z = it does not bleed (nothing done); NZ = it bleeds: d = 2 and e = its layers (1-4), the input of
;     HandlePoisonBurnLeechSeed_DecreaseOwnHP.enter for e x max(1, max HP / 16). Clobbers a, bc, hl.
BleedBiteStart::
	call UserCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret z
	ld a, [hl]
	rlca
	rlca
	and %11 ; the layers minus 1
	inc a
	ld e, a
	push de
	ld hl, HurtByBleedingText
	call PrintText
	call PlayBleedAnimation
	pop de
	ld d, 2
	ld a, e
	and a ; NZ
	ret

; The bleed's own animation, after its line and before its bite (BleedBiteStart): BLEED_ANIM (BleedAnim,
; data/moves/animations.asm), drops falling from the bleeding #MON, the user (hWhoseTurn) at its residual. It is
; played the way PlaySpecialAnimation (engine/battle/core.asm, Battle Core) plays one, from this bank. Skipped
; entirely - no 30-frame pause - when the BATTLE ANIMATION option is off (MoveAnimation would wait 30 frames),
; when the #MON is INVULNERABLE (the turn of FLY or DIG that takes it off the screen: nothing to drip from), and
; while its SUBSTITUTE is up: the picture on screen is the doll, and the doll does not bleed (the line and the
; bite still come: the #MON behind it is the one bleeding). The drops are sprites: they leave the background and
; the HUD's letters alone. Since 2026-11-22 they have a sound, started here with them. Clobbers everything.
PlayBleedAnimation:
	ld a, [wOptions]
	bit BIT_BATTLE_ANIMATION, a
	ret nz ; animations off
	ld hl, wPlayerBattleStatus1
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotStatus1
	ld hl, wEnemyBattleStatus1
.gotStatus1
	bit INVULNERABLE, [hl]
	ret nz
	ASSERT wPlayerBattleStatus2 == wPlayerBattleStatus1 + 1 && wEnemyBattleStatus2 == wEnemyBattleStatus1 + 1
	inc hl
	bit HAS_SUBSTITUTE_UP, [hl]
	ret nz ; the doll is in the picture
	xor a
	ld [wAnimationType], a ; no shake or blink after it (PlayApplyingAttackAnimation)
	ld a, BLEED_ANIM
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [wAnimationID], a
	call Delay3
; v1.0 (2026-11-22): the drop's sound, chosen by ear from recordings of the battle sound engine: WATER GUN's and
; ABSORB's SFX_BATTLE_24 a little higher ($30 on the tone, which sends its hiss down; the tempo byte $80 = as
; written). Played here, the way GetMoveSound + PlaySound play an animation's sound, because no move's row of
; MoveSoundTable holds these bytes (BleedAnim names NO_MOVE: its script stays silent). It starts with the drops;
; with the animations off nothing plays (the early `ret nz` above), as for a move's own sound. It WAITS for the
; sound already playing: "hurt by bleeding!" ends on a prompt, the A press plays SFX_PRESS_AB, and the engine
; refuses an SFX of a higher id while that one holds channel 5 (Audio2_PlaySound's .notNoiseChannel): played at
; once, the drop would be dropped (about a quarter of a second of waiting).
	ld a, $30
	ld [wFrequencyModifier], a
	ld a, $80
	ld [wTempoModifier], a
	ld a, SFX_BATTLE_24
	call PlaySoundWaitForCurrent
	predef MoveAnimation
	callfar Func_78e98
	ret

; Far. The user's bleed has just bitten (HandlePoisonBurnLeechSeed, after the damage): one bite less. The last
; one ends the bleed (its layers go too): if the #MON still stands, through EndBleedWithLine ("<USER>'s /
; bleeding stopped!"); a bite that knocked it out says nothing, its faint follows.
; OUT Z = the user has no HP left (the callers' faint path); NZ = it stands. Clobbers everything.
BleedBiteTaken::
	call UserCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	cp 1 << 3
	jr z, .lastBite
	ld a, [hl]
	sub 1 << 3 ; one bite less (bits 3-5, and more than one was left: no borrow into the layers)
	ld [hl], a
	jr UserHPLeft
.lastBite
	push hl
	call UserHPLeft
	pop hl
	jr nz, .stands
	ld a, [hl]
	and BURN_BITES_MASK ; knocked out: the bleed goes with no line, the burn's bits stay
	ld [hl], a
	xor a ; Z
	ret
.stands
	ldh a, [hWhoseTurn]
	ld c, a
; fall through
; Far. A bleed ends by a move or by its last bite: the side's bits 3-7 are cleared (the burn's bits stay) and, if
; it was bleeding, both HUDs are drawn and "<USER>'s / bleeding stopped!" is printed when the side is the user
; (hWhoseTurn), "<TARGET>'s / bleeding stopped!" when it is the target. For the cures that a move brings (a freeze
; that lands on the target; the user's REST, RECOVER, SOFTBOILED); an item prints only its own text.
; IN  c = the side. OUT NZ = it was bleeding (the line is printed), Z = it was not (nothing done).
; Clobbers everything.
EndBleedWithLine::
	call BattlerCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret z
	ld a, [hl]
	and BURN_BITES_MASK
	ld [hl], a
	push bc
	farcall DrawHUDsAndHPBars
	pop bc
	ldh a, [hWhoseTurn]
	cp c
	ld hl, BleedingStoppedText
	jr z, .gotLine
	ld hl, TargetBleedingStoppedText
.gotLine
	call PrintText
	or 1 ; NZ
	ret

; OUT Z = the user (hWhoseTurn) has no HP left. Clobbers a, hl.
UserHPLeft:
	ld hl, wBattleMonHP
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotHP
	ld hl, wEnemyMonHP
.gotHP
	ld a, [hli]
	or [hl]
	ret

; Far. A freeze has just landed on the TARGET (PrintFrozenTextAndLowerSpeed, engine/battle/effects.asm, the one tail
; of the four freeze sites, after the freeze's own lines): its bleed ends, "<TARGET>'s / bleeding stopped!".
; Clobbers everything.
FreezeEndsTargetBleed::
	ldh a, [hWhoseTurn]
	xor 1
	ld c, a
	jr EndBleedWithLine

; Far. The user's own REST, RECOVER or SOFTBOILED ends its bleed, "<USER>'s / bleeding stopped!" after the move's
; own lines (HealEffect_, heal.asm, from every exit that heals or cures; a sleep given by the foe or the nap of a
; #MON that disobeys never comes here).
; IN  c != 0: the move has done its work (a heal, a cure, an easing of TOX): the bleed ends when the move executed is
;     REST, RECOVER or SOFTBOILED - not GROWTH's quarter nor SILVER WIND's eighth, which share heal.asm's tail.
; IN  c = 0: RECOVER or SOFTBOILED at full HP with no status: the bleed alone is something to cure. Bleeding: the
;     pause and the move's animation, then the line; not bleeding: "But, it failed!" as before (heal.asm .failed).
; Clobbers everything.
CureUserBleed::
	ld a, c
	and a
	jr nz, .afterWork
	ldh a, [hWhoseTurn]
	ld c, a
	call IsBattlerBleeding ; (keeps bc)
	push af
	ld c, 50
	call DelayFrames
	pop af
	jr nz, .bleedIsTheWork
	farjp PrintButItFailedText_
.bleedIsTheWork
	farcall PlayCurrentMoveAnimation
	jr .endIt
.afterWork
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .gotMove
	ld a, [wEnemyMoveNum]
.gotMove
	cp REST
	jr z, .endIt
	cp RECOVER
	jr z, .endIt
	cp SOFTBOILED
	ret nz
.endIt
	ldh a, [hWhoseTurn]
	ld c, a
	jr EndBleedWithLine

; Far. FULL HEAL and FULL RESTORE in a battle (item_effects.asm CheckCanCureConfusion): does the party slot's
; #MON bleed, the active one or a benched one? Its bleed is then something to cure, as a status is.
; IN  d = the party slot. OUT NZ = it bleeds. de is kept.
PartySlotBleeding::
	ld a, d
	call PlayerSlotCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret

; Far. The capture's status multiplier for a wild #MON with nothing in its status byte (GetCatchStatusMultiplier,
; engine/items/item_effects.asm .noStatusByte), in twentieths and best-of: confused 24, else bleeding 22, else 20.
; A bleed counts only there: with a status or a confusion the best of them is already worth more.
; OUT e = the twentieths. Clobbers a, c, hl. d is kept.
CatchSoftStatusTwentieths::
	ld e, 24
	ld a, [wEnemyBattleStatus1]
	bit CONFUSED, a
	ret nz
	ld c, 1
	call IsBattlerBleeding ; (keeps de)
	ld e, 22
	ret nz
	ld e, 20
	ret

; Far. The menus' "BLD" (PrintStatusAilment, engine/pokemon/status_ailments.asm, for a #MON with no hard status): is
; the #MON the party menu or the STATS page is drawing one of the player's party that bleeds, in a battle? The menus
; load the #MON they draw with LoadMonData, so it is wWhichPokemon of wMonDataLocation: the party menu's rows in every
; variant (PartyMenuInit sets PLAYER_PARTY_DATA, each row sets wWhichPokemon), and the STATS page of the battle's
; party menu (PLAYER_PARTY_DATA, the chosen slot). Outside a battle (wIsInBattle 0, or the $ff a black-out leaves
; behind) the bytes are stale and nothing bleeds; another struct (the enemy's, a box's, the day care's) never bleeds.
; OUT NZ = it bleeds. Clobbers a, hl. bc and de are kept.
MenuMonBleeding::
	ld a, [wIsInBattle]
	dec a
	cp 2 ; a wild (1) or a trainer (2) battle?
	jr nc, .no
	ld a, [wMonDataLocation]
	and a
	ASSERT PLAYER_PARTY_DATA == 0
	jr nz, .no
	ld a, [wWhichPokemon]
	call PlayerSlotCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret
.no
	xor a ; Z
	ret

; Far. An item used on a #MON of the player's party (item_effects.asm .doneHealing, as the item is used up): in a
; battle a FULL HEAL or a FULL RESTORE ends the bleed of the #MON it treats (wUsedItemOnWhichPokemon), active or
; benched, with no line of its own (the item prints only its text). Every other item, and any item outside a battle
; (the bytes are not live there), leaves the byte alone. The burn's bits are kept.
; Clobbers a, hl. bc and de are kept.
ItemEndsBleed::
	ld a, [wIsInBattle]
	and a
	ret z
	ld a, [wcf91]
	cp FULL_HEAL
	jr z, .cures
	cp FULL_RESTORE
	ret nz
.cures
	ld a, [wUsedItemOnWhichPokemon]
	call PlayerSlotCondsAddr
	jr ClearBleedBits

; Far. The trainer's FULL HEAL or FULL RESTORE (trainer_ai.asm AICureStatus) ends the bleed of the #MON it treats,
; silently. Clobbers a, c, hl. de is kept.
AICureEnemyBleed::
	ld c, 1
	call BattlerCondsAddr
; fall through
; IN  hl = a conditions byte: its bleed goes (bits 3-7), the burn's bits stay.
ClearBleedBits:
	ld a, [hl]
	and BURN_BITES_MASK
	ld [hl], a
	ret

; Far. The trainer AI's cure decisions (trainer_ai.asm): does its own #MON have a status, or a bleed worth an
; item? A bleed of two layers or more counts as a status there (AIStatusCureItem, AILateCureItem: FULL HEAL and
; FULL RESTORE cure it). A bleed of one layer does not: it bites for a sixteenth and ends by itself in two to
; four turns, and the bag's cure is kept for something worse.
; OUT NZ = yes. de is kept.
AIEnemyStatusOrBleeding::
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	ld c, 1
	call BattlerCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret z ; it does not bleed (the layers' bits mean nothing then)
	ld a, [hl]
	and BLEED_LAYERS_MASK ; the layers minus 1: NZ from two layers
	ret

; Far. Layer 1's RECOVER / SOFTBOILED at full HP (trainer_ai.asm .checkFullHealth: not useless) and layer 4's
; (.checkWorthHealing: worth using): is there something for them to cure on the trainer's own #MON - a POISON, a
; BURN, a PARALYSIS, or a bleed?
; OUT NZ = yes. de is kept.
AIEnemyCurableAtFullHP::
	ld a, [wEnemyMonStatus]
	and (1 << PSN) | (1 << BRN) | (1 << PAR)
	ret nz
; fall through
AIEnemyBleeding:
	ld c, 1
	jp IsBattlerBleeding

BleedingText:
	text_far _BleedingText
	text_end

BleedingWorseText:
	text_far _BleedingWorseText
	text_end

HurtByBleedingText:
	text_far _HurtByBleedingText
	text_end

BleedingStoppedText:
	text_far _BleedingStoppedText
	text_end

TargetBleedingStoppedText: ; for a move that ends the TARGET's bleed (EndBleedWithLine)
	text_far _TargetBleedingStoppedText
	text_end

INCLUDE "data/battle/bleed_moves.asm"
INCLUDE "data/pokemon/bloodless.asm"
