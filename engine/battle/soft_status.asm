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
	ld e, REALISM_BLEED
	call AdjustStatusChance ; v1.0 (2026-11-26): d = the chance with the target's realism factors
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
	predef MoveAnimation ; its BleedDropsInRed (animations.asm) paints the drops red on the GBC
	callfar Func_78e98
	ret

; A status's own animation in its colours (v1.0, 2026-11-25; the design is at StatusAnimInInk,
; engine/battle/animations.asm, whose hook calls this, far, for the animations IsStatusTurnAnim names, right after the
; OBJ palettes are converted for the subanimation). DrawFrameBlock (animations.asm) gives a battle animation's sprites
; OBJ palette 2 on the left half of the screen (the player's picture) and 3 on the right (the enemy's), and these
; animations are drawn on the side whose turn it is, each inside its half (a probe of 2026-11-25: the player's sprites at
; x 24-72, the enemy's at 88-112): so the side's palette is 2 + hWhoseTurn, and the other one is left alone. Its colours
; 1 to 3 (colour 0 is a sprite's transparent one) take the animation's three (StatusAnimPalettes, below), each in an
; H-blank, the way TransferCurOBPData writes one with the screen on (engine/gfx/palettes.asm): that routine is in bank
; $1C, which is at its floor. Written right after the OBJ palettes are converted for the subanimation (rOBP0 =
; wAnimPalette) - written before that conversion, the drops' were painted over (the first build of 2026-11-25, caught by
; emu_test_bleed_anim's leg R). The animation's sprites are the only ones on screen while it plays; PlayAnimation's
; conversion back after the subanimation (rOBP0 restored: on the GBC wAnimPalette is always another value, so that
; conversion always runs) gives the palette its #MON colours again. DMG and SGB: nothing (the OAM's palette bits and
; the colour RAM are the GBC's alone). An id the table does not hold: nothing. Clobbers a, bc, de, hl.
LoadStatusAnimPalette::
	ldh a, [hGBC]
	and a
	ret z
	ldh a, [hSpecialAnimIndex]
	ld hl, StatusAnimPalettes
	ld de, 3
	call IsInArray
	ret nc
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl = the animation's colours 1 to 3
	ldh a, [hWhoseTurn]
	add 2 ; OBJ palette 2 (the player's half) or 3 (the enemy's)
	add a
	add a
	add a
	add 1 * PAL_COLOR_SIZE ; from colour 1
	or $80 ; rOBPI's auto-increment
	ldh [rOBPI], a
	lb bc, %10, NUM_PAL_COLORS - 1 ; b: STAT modes 2 and 3, the ones where the colour RAM is drawn from
.color
	ldh a, [rSTAT] ; already in a blanking period: wait for it to end, so the write does not run past it
	and b
	jr z, .color
.waitBlank
	ldh a, [rSTAT]
	and b
	jr nz, .waitBlank
	ld a, [hli]
	ldh [rOBPD], a
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .color
	ret

; Each status animation's colours 1 to 3 (v1.0, 2026-11-25): its id (a special animation's, constants/move_constants.asm)
; and the address of its three colours. IsStatusTurnAnim (engine/battle/animations.asm) names the same ids. The inks
; are the HUD labels' (StatusInkTable, engine/gfx/bg_map_attributes.asm: emu_test_status_anim_ink.py checks that each
; is there); each animation's chosen from sheets on 2026-11-25 (the drops the same day, S5).
StatusAnimPalettes:
	db BLEED_ANIM
	dw BleedDropColors + PAL_COLOR_SIZE
	db BURN_PSN_ANIM
	dw .psn
	db TOX_ANIM
	dw .tox
	db BRN_ANIM
	dw .brn
	db SLP_PLAYER_ANIM
	dw .slp
	db SLP_ANIM
	dw .slp
	db CONF_PLAYER_ANIM
	dw .cnf
	db CONF_ANIM
	dw .cnf
	db PAR_ANIM
	dw .par
	db FRZ_ANIM
	dw .frz
	db FEAR_ANIM
	dw .scr
	db -1 ; end
; the skull, the Zs and the "?" use colour 3 alone: the three take the label's ink, so that no pixel of theirs can show
; in the #MON's colours
.psn
	RGB 22, 10, 28
	RGB 22, 10, 28
	RGB 22, 10, 28 ; the PSN label's ink
.tox
	RGB 24, 14, 28 ; the bubbles' light pixels
	RGB 18, 06, 24 ; the bubbles' body
	RGB 13, 02, 18 ; the skull and the bubbles' rims: the TOX label's ink
.brn
	RGB 31, 26, 04 ; the flame's heart: yellow (a red flame with a yellow heart)
	RGB 30, 03, 02 ; the flame: the BRN label's ink
	RGB 30, 03, 02 ; (no pixel of EMBER's flame uses colour 3)
.slp
	RGB 04, 08, 20
	RGB 04, 08, 20
	RGB 04, 08, 20 ; the SLP label's ink
.cnf
	RGB 00, 17, 15
	RGB 00, 17, 15
	RGB 00, 17, 15 ; the CNF label's ink
.par
	RGB 31, 28, 06
	RGB 27, 22, 00 ; the PAR label's ink
	RGB 24, 22, 00 ; the jolts (colour 3 alone): a yellow a touch darker than the label's, to be seen on the white
	               ; (one of three tried, 2026-11-25: 20, 13, 0 read too orange)
.frz
	RGB 24, 30, 31 ; the crystals' light faces
	RGB 08, 22, 31 ; the FRZ label's ink
	RGB 02, 10, 24 ; the crystals' rims
.scr
	RGB 12, 12, 12
	RGB 12, 12, 12
	RGB 12, 12, 12 ; FEAR's skull: a grey a touch darker than the SCR label's 15, 15, 15 (as for PAR's jolts)

; The drop's colours: its body and rim in the BLD label's ink (20, 2, 4: STATUS_INK_BLEED's, bg_map_attributes.asm),
; and the two-pixel gleam of the drop's tile (shades 1 and 2 of SUBANIM_1_BLOOD_DROPS' tile) in lighter reds. Colour 0
; is not written (a sprite's transparent one): StatusAnimPalettes points at colour 1.
BleedDropColors:
	RGB 31, 31, 31 ; shade 0: transparent on a sprite
	RGB 31, 22, 22 ; shade 1: the gleam's light pixels
	RGB 27, 08, 08 ; shade 2: the gleam's darker pixels
	RGB 20, 02, 04 ; shade 3: the drop
	ASSERT @ - BleedDropColors == PALETTE_SIZE

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

; Far. FULL HEAL and FULL RESTORE in a battle (item_effects.asm CheckCanCureConfusion): is the party slot's #MON
; the active one and scared (v1.0 2026-11-24), or does it bleed, the active one or a benched one? Either is then
; something to cure, as a status is (the fear goes in CureConfusionIfFullHealOrRestore, the bleed in ItemEndsBleed).
; IN  d = the party slot. OUT NZ = yes. de is kept.
PartySlotCurableInBattle::
	ld a, [wPlayerMonNumber]
	cp d
	jr nz, PartySlotBleeding
	ld a, [wPlayerFearCounter]
	and a
	ret nz
; fall through
; Far. Does the party slot's #MON bleed? IN d = the party slot. OUT NZ = it bleeds. de is kept.
PartySlotBleeding::
	ld a, d
	call PlayerSlotCondsAddr
	ld a, [hl]
	and BLEED_BITES_MASK
	ret

; Far. The capture's status multiplier for a wild #MON with nothing in its status byte (GetCatchStatusMultiplier,
; engine/items/item_effects.asm .noStatusByte), in twentieths and best-of: confused or (v1.0 2026-11-24) scared 24,
; else bleeding 22, else 20. A bleed or a fear counts only there: with a status or a confusion the best of them is
; already worth as much or more.
; OUT e = the twentieths. Clobbers a, c, hl. d is kept.
CatchSoftStatusTwentieths::
	ld e, 24
	ld a, [wEnemyBattleStatus1]
	bit CONFUSED, a
	ret nz
	ld a, [wEnemyFearCounter]
	and a
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

; v1.0 (2026-11-25, the status chapter's S6). Near, for MenuLabelInk (engine/battle/hud_status.asm, pinned in this
; bank): the burn's bites left of the #MON the party menu or the STATS page is drawing, by MenuMonBleeding's rule
; (in a battle, a #MON of the player's party: wWhichPokemon's byte; anything else none, so outside a battle every
; burn's fire is out). A menu's BRN takes the HUD's red while the fire burns and its orange once it is out.
; OUT a = the bites, Z when none. Clobbers hl. bc and de are kept.
MenuMonBurnBites:
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
	and BURN_BITES_MASK
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

; Far. The trainer's FULL HEAL or FULL RESTORE (trainer_ai.asm AICureStatus) ends the fear (v1.0 2026-11-24) and the
; bleed of the #MON it treats, silently. Clobbers a, c, hl. de is kept.
AICureEnemySoftStatus::
	xor a
	ld [wEnemyFearCounter], a
; fall through
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

; v1.0 (2026-11-24): VINE DRAIN (TRAPPING_DRAIN_EFFECT), far, from TrappingDrainEffect (bank $1D), the effect's row.
; Its hold is WRAP's and every hit drains. The dispatch comes twice on the first turn and once on each held turn,
; and the attacker's USING_TRAPPING_MOVE bit tells which call this is:
;   clear: SpecialEffectsCont, before the damage of a fresh use (a #MON in a hold never picks a move, and the bit is
;          cleared when a hold ends or its first hit misses). The drain line is owed to the first hit that drains
;          (wPlayerTrapDrainLine / wEnemyTrapDrainLine), then TrappingEffect sets the hold up, unchanged.
;   set:   AlwaysHappenSideEffects, after a hit: the first or a held one (held turns skip the damage calculation and
;          repeat wDamage), a KO included. Half the damage (at least 1) goes to the user through DrainHPEffect_, with
;          the line if it is owed (once a hold), else through DrainHPEffectNoLine_. Both leave half of wDamage in it,
;          and the held turns repeat wDamage: it is put back as it was. A hit on a doll drains nothing
;          (wMoveHitSubstitute), the hit that breaks it included, and leaves the line owed (the owner, 2026-11-24:
;          the line comes with the first real drain). A doll that breaks leaves this effect byte in place
;          (AttackSubstitute), so the held hits after it, which strike the #MON, drain, the first of them with the
;          line. A doll that holds every hit leaves the line owed at the end of the hold: harmless, every fresh use
;          writes it again, and send-out, faint and the end of the battle zero it.
; Clobbers every register (the dispatchers read none after it).
TrappingDrainEffect_:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerTrapDrainLine
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotSide
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyTrapDrainLine
.gotSide
	bit USING_TRAPPING_MOVE, [hl]
	jr nz, .drain
	ld a, 1
	ld [de], a ; the line is owed to the first hit
	farjp TrappingEffect
.drain
	ld hl, wDamage
	ld a, [hli]
	ld c, [hl]
	ld b, a
	push bc ; the damage, put back below
	ld a, [wMoveHitSubstitute]
	and a
	jr nz, .putDamageBack ; a hit on a doll: no drain, and the line stays owed (DrainHPEffect_ would drain nothing)
	ld a, [de]
	and a
	jr z, .noLine
	xor a
	ld [de], a ; said now, once
	farcall DrainHPEffect_
	jr .putDamageBack
.noLine
	farcall DrainHPEffectNoLine_
.putDamageBack
	pop bc
	ld hl, wDamage
	ld a, b
	ld [hli], a
	ld [hl], c
	ret

; v1.0 (2026-11-24): FEAR, a volatile status like confusion. Its one store is the count wPlayerFearCounter /
; wEnemyFearCounter (0 = not scared; ram/wram.asm): no bit anywhere else, so nothing can be left behind. The count
; is drawn 3-5 when the fear lands (FearInflicted). On each turn the #MON reaches the check (FearTurnCheck, after
; the DISABLE countdown and before the confusion check of both sides' status routines in Battle Core) it goes down
; first: at 0 the fear is over ("scared no more!") and the #MON acts; otherwise its turn is lost one time in two
; ("is too scared!"). So 2 to 4 scared turns. While scared it moves after a #MON that is not, whatever the speeds;
; two scared #MON compare their speeds (TurnOrderSpeedCmp; the owner, 2026-11-25: x2/3 of the SPEED until then).
; Priority comes before it. The stored SPEED is never changed.
; It coexists with every hard status, confusion, BLEED and a burn (it lands on a sleeping or frozen #MON and waits
; there). A SUBSTITUTE blocks it, and a GHOST (FearImmuneTypes) never has it. It ends at 0, by a FULL HEAL or a
; FULL RESTORE on the active #MON (item_effects.asm CureConfusionIfFullHealOrRestore, the AI's AICureStatus), and
; at every send-out, faint and the end of the battle: the five-byte status clears in Battle Core and EndOfBattle's
; span zero the count.

DEF FEAR_SIDE_EFFECT_CHANCE EQU 30 percent + 1 ; SHADOW BALL's 30 %: a roll below it lands
DEF FEAR_LOSES_TURN_CHANCE  EQU 50 percent + 1 ; a scared turn: a roll below it is lost

; Far. FEAR_EFFECT (DEATH GLARE) and FEAR_SIDE_EFFECT (SHADOW BALL), from FearEffect (bank $1D), the two effects' row.
; DEATH GLARE refuses in the order of the status moves (status_failure.asm), each cause with its line: the target's
; SUBSTITUTE, a fear already there (STATUS_FAIL_SCARED), a GHOST (STATUS_FAIL_IMMUNE), then the accuracy. It lands
; on a target asleep, frozen, confused, bleeding or burned. SHADOW BALL's side effect, after a hit that did not
; faint the target (the move's other effects never run then), says nothing when it cannot land: a doll that held (a
; doll that broke took the effect away), a GHOST, a target already scared (its count is not drawn again); else
; FEAR_SIDE_EFFECT_CHANCE.
; Clobbers every register (the dispatchers read none after it).
FearEffect_::
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	ld hl, wEnemyFearCounter
	ld de, wEnemyBattleStatus2
	jr z, .gotSide
	ld a, [wEnemyMoveEffect]
	ld hl, wPlayerFearCounter
	ld de, wPlayerBattleStatus2
.gotSide
	cp SPIRAL_EFFECT ; v1.0 (2026-11-24): SPIRAL shares the row (bank $1D has no room for its own far jump)
	jp z, SpiralEffect_
	cp FEAR_SIDE_EFFECT
	jr z, .sideEffect
	ld c, STATUS_FAIL_SUBSTITUTE
	ld a, [de]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .failed
	ld c, STATUS_FAIL_SCARED
	ld a, [hl]
	and a
	jr nz, .failed
	ld c, STATUS_FAIL_IMMUNE
	call FearImmuneTarget
	jr c, .failed
	push hl
	callfar MoveHitTest
	pop hl
	ld c, STATUS_FAIL_MISS
	ld a, [wMoveMissed]
	and a
	jr nz, .failed
	call FearInflicted
	callfar PlayCurrentMoveAnimation2
	jr .becameScared
.failed
	jp PrintStatusMoveFailure
.sideEffect
	ld a, [de]
	bit HAS_SUBSTITUTE_UP, a
	ret nz
	ld a, [hl]
	and a
	ret nz
	call FearImmuneTarget
	ret c
	ld de, FEAR_SIDE_EFFECT_CHANCE << 8 | REALISM_FEAR
	call AdjustStatusChance ; v1.0 (2026-11-26): d = the chance with the target's realism factors (keeps hl)
	call BattleRandom
	cp d
	ret nc
	call FearInflicted
.becameScared
	farcall DrawTargetHUDAndHPBar
	ld hl, BecameScaredText
	jp PrintText

; IN  hl = the target's fear count: it lands, a count of FEAR_COUNT_MIN-FEAR_COUNT_MAX (3-5, one draw: 0-85 3,
; 86-170 4, 171-255 5). Clobbers a, b. hl is kept.
FearInflicted:
	call BattleRandom
	ld b, FEAR_COUNT_MIN
	cp 86
	jr c, .gotCount
	inc b
	cp 171
	jr c, .gotCount
	inc b
.gotCount
	ASSERT FEAR_COUNT_MAX == FEAR_COUNT_MIN + 2
	ld [hl], b
	ret

; Is the target (the side hWhoseTurn is not) immune to FEAR: a type of FearImmuneTypes as its type 1, its type 2 or
; its third type (GetThirdType, by the species it looks like now: TRANSFORM copies types and species)?
; OUT carry = immune. bc, de and hl are kept.
FearImmuneTarget:
	push bc
	ldh a, [hWhoseTurn]
	xor 1
	ld c, a
	call FearImmuneSide
	pop bc
	ret

; The same for the side in c. OUT carry = immune. bc, de and hl are kept.
FearImmuneSide:
	push hl
	push bc
	call BattlerStatusAddr
	ASSERT wBattleMonType1 == wBattleMonStatus + 1 && wEnemyMonType1 == wEnemyMonStatus + 1
	ASSERT wBattleMonType2 == wBattleMonStatus + 2 && wEnemyMonType2 == wEnemyMonStatus + 2
	ASSERT wBattleMonSpecies == wBattleMonStatus - 4 && wEnemyMonSpecies == wEnemyMonStatus - 4
	inc hl
	ld a, [hli]
	call FearImmuneType
	jr c, .done
	ld a, [hld]
	call FearImmuneType
	jr c, .done
	dec hl
	dec hl
	dec hl
	dec hl
	dec hl
	ld a, [hl] ; the species
	call GetThirdType ; (keeps bc, de, hl)
	call FearImmuneType
.done
	pop bc
	pop hl
	ret

; IN  a = a type. OUT carry = it is in FearImmuneTypes. Clobbers a, b. de and hl are kept.
FearImmuneType:
	push hl
	ld b, a
	ld hl, FearImmuneTypes
.loop
	ld a, [hli]
	cp -1
	jr z, .no ; (cp -1 left the carry clear)
	cp b
	jr nz, .loop
	scf
.no
	pop hl
	ret

; Far. The fear's turn, both sides: the status routines of Battle Core (CheckPlayerStatusConditions .FearCheck,
; CheckEnemyStatusConditions .checkIfScared) call it after the DISABLE countdown and before the confusion check, so
; it counts only the turns the #MON reaches that point (not asleep, frozen, flinched, recharging or held, and not a
; turn its side spent on an item or a switch). The count goes down first: at 0 "<USER>'s / scared no more!" with
; fresh HUDs, and the #MON acts. Otherwise the fear's animation (PlayFearAnimation) and a roll: one time in two
; "<USER> / is too scared!" and the turn is lost, else it acts. A lost turn counts as a turn of a confusion too: a
; confusion count above 1 goes down by one (the confusion check ends a confusion, on a turn the #MON reaches it).
; IN  hWhoseTurn = the side. OUT carry = the turn is lost (the caller leaves through the exit of a full paralysis);
; no carry = it goes on to the confusion check. Clobbers every register.
FearTurnCheck::
	ldh a, [hWhoseTurn]
	and a
	ld hl, wPlayerFearCounter
	ld de, wPlayerConfusedCounter
	ld bc, wPlayerBattleStatus1
	jr z, .gotSide
	ld hl, wEnemyFearCounter
	ld de, wEnemyConfusedCounter
	ld bc, wEnemyBattleStatus1
.gotSide
	ld a, [hl]
	and a
	ret z ; not scared (and a clears the carry)
	dec [hl]
	jr nz, .scared
	farcall DrawHUDsAndHPBars
	ld hl, ScaredNoMoreText
	call PrintText
	and a
	ret
.scared
	push bc
	push de
	call PlayFearAnimation
	call BattleRandom
	cp FEAR_LOSES_TURN_CHANCE
	pop de
	pop bc
	ret nc ; it acts
	ld a, [bc]
	bit CONFUSED, a
	jr z, .confusionTicked
	ld a, [de]
	cp 2
	jr c, .confusionTicked ; a count of 1 is left for the confusion check to end, on a turn the #MON reaches it
	dec a
	ld [de], a
.confusionTicked
	ld hl, TooScaredText
	call PrintText
	scf
	ret

; The fear's animation on the scared #MON (hWhoseTurn), every scared turn before its roll: FEAR_ANIM (FearAnim,
; data/moves/animations.asm): since 2026-11-25 a skull blinking slowly above its head (until then two quick twitches
; of its picture). Skipped entirely - no pause - with the BATTLE ANIMATION option off, when the #MON is INVULNERABLE
; (FLY / DIG: off the screen) and while its SUBSTITUTE is up (the picture is the doll; the twitches redrew the picture
; slot). The same steps as PlayBleedAnimation's, with no sound.
; Clobbers every register (FearTurnCheck keeps bc and de around it).
PlayFearAnimation:
	ld a, FEAR_ANIM
	jr PlayStatusSideAnimation

; Far. A frozen turn's animation (v1.0, 2026-11-25: ICE BEAM's crystals at the #MON's feet), after
; "<USER> is / frozen solid!" (CheckPlayerStatusConditions, CheckEnemyStatusConditions, engine/battle/core.asm).
PlayFrozenAnimation::
	ld a, FRZ_ANIM
	jr PlayStatusSideAnimation

; Far. A fully paralyzed turn's animation (v1.0, 2026-11-25: vanilla's ParalyzeAnim, two jolting lines
; at the #MON's sides, which the game never played), after "<USER>'s / fully paralyzed!" (the same two routines). A
; paralyzed #MON that moves plays nothing: no new pause on its turns.
PlayParalyzedAnimation::
	ld a, PAR_ANIM
	; fall through

; A special animation on the #MON whose turn it is (hWhoseTurn), the way PlaySpecialAnimation (engine/battle/core.asm)
; plays one, from this bank: the fear's, a frozen turn's and a fully paralyzed turn's (v1.0, 2026-11-25: the fear's
; steps, made the three's). Skipped entirely - no pause - with the BATTLE ANIMATION option off (MoveAnimation would
; wait 30 frames: the new animations add no pause to a battle played without them), when the #MON is INVULNERABLE
; (FLY / DIG: off the screen; a paralysis can stop it in the air) and while its SUBSTITUTE is up (the picture is the
; doll, as for the bleed's drops). IN a = the special animation's id. Clobbers every register.
PlayStatusSideAnimation:
	ld e, a
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
	ld a, e
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [wAnimationID], a
	call Delay3
	predef MoveAnimation
	callfar Func_78e98
	ret

; Far. Is the side's #MON scared (the battle HUD's SCR label asks this)?
; IN  c = the side. OUT NZ = scared, a = its count (never shown: the count is the engine's alone). bc, de, hl kept.
IsBattlerScared::
	ld a, c
	and a
	ld a, [wPlayerFearCounter]
	jr z, .gotCount
	ld a, [wEnemyFearCounter]
.gotCount
	and a
	ret

; Far. The turn order (MainInBattleLoop .compareSpeed, reached only when both moves have the same priority:
; HandleMovePriority comes first, so a scared #MON's PROTECT or QUICK ATTACK still goes before a plain move).
; v1.0 (2026-11-25, the owner): a scared #MON (its fear count, the SCR label) moves after one that is not, whatever
; the speeds; when both or neither are scared, the stored SPEEDs decide (paralysis has already halved its own).
; (2026-11-24 to 11-25: a scared side's SPEED counted x2/3, at least 1.) Nothing is stored.
; OUT the flags of StringCmp on (the player's, the enemy's): Z equal, carry = the enemy first, else the player.
; Clobbers every register.
TurnOrderSpeedCmp::
	ld a, [wEnemyFearCounter]
	and a
	ld a, [wPlayerFearCounter] ; (ld keeps the flags)
	jr z, .enemyNotScared
	and a
	jr nz, .speeds ; both scared: the speeds
	inc a ; the enemy scared alone: the player first (a = 1: NZ, no carry)
	ret
.enemyNotScared
	and a
	jr z, .speeds ; neither scared: the speeds
	scf ; the player scared alone: the enemy first (NZ from its count, carry)
	ret
.speeds
	ld hl, wBattleMonSpeed
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wEnemyMonSpeed
	ld a, [hli]
	ld d, a
	ld e, [hl]
.compare ; bc = the player's SPEED, de = the enemy's
	ld a, b
	cp d
	ret nz
	ld a, c
	cp e
	ret

; Far. The trainer AI's DEATH GLARE (trainer_ai.asm AIMoveChoiceModification1 .checkScared): does FearEffect_ surely
; refuse it on the player's #MON - a GHOST by any of its three types, or its SUBSTITUTE (useless) - or refuse it
; unless the fear already there (the SCR label) ends first? Read from what the screen shows: never the count. The
; player's fear can end in its own turn, before DEATH GLARE runs ("scared no more!" when it moves first), as a
; confusion can before CONFUSE RAY: by E4 only discouraged, as CONFUSE RAY is (the owner, 2026-11-24).
; v1.0 (2026-11-24): SPIRAL comes to the same branch (wEnemyMoveEffect = SPIRAL_EFFECT): AISpiralMoveUseless.
; OUT carry = useless; else NZ = discouraged (.discourageUnlessRecharging: USELESS while the player must recharge,
; whose turn ends before its fear check), Z = nothing. Clobbers a, c and hl. de is kept.
AIFearMoveUseless::
	ld a, [wEnemyMoveEffect]
	cp SPIRAL_EFFECT
	jp z, AISpiralMoveUseless
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .useless
	ld c, 0 ; the player's #MON
	call FearImmuneSide ; carry: a GHOST
	ret c
	ld a, [wPlayerFearCounter]
	and a ; NZ: already scared (and a clears the carry)
	ret
.useless
	scf
	ret

; v1.0 (2026-11-24): SPIRAL (SPIRAL_EFFECT, power 0, in ResidualEffects2 beside SLEEP_EFFECT), from FearEffect_ (the
; row it shares in bank $1D). The player's and the enemy's use alike; METRONOME and MIRROR MOVE reach it the same way.
; The target's SUBSTITUTE stops the whole move with the doll's line, then ONE accuracy test (MoveHitTest, as for
; HYPNOSIS: PROTECT, FLY / DIG and LOCK-ON included; no type stops a power-0 move) and the usual miss line - none
; against a target that must recharge, which cannot dodge: HYPNOSIS's rule (SleepEffect skips its hit test then; the
; owner, 2026-11-24). On a hit,
; two rolls of their own, the sleep's first, then the confusion's, each SPIRAL_LEG_CHANCE with the target's realism
; factors for its status (v1.0, 2026-11-26: SLP, CONFUSION, as a side effect's chance; the move's accuracy takes
; none), each a silent leg when it does not land (SpiralSleepLeg, SpiralConfusionLeg). The move's animation plays
; once: with the sleep's landing, or, when the sleep did not land, before the confusion's leg. When it hits and
; neither leg lands, by the rolls or by the gates, "<TARGET> / looked away!". When both land, "fell asleep!", then
; "became confused!".
; A confusion that lands on a sleeping #MON waits behind the sleep: a sleeper never reaches the confusion check.
; Clobbers every register (the dispatch reads none after it).
DEF SPIRAL_LEG_CHANCE EQU 60 percent + 1 ; each leg with no factor: a roll of 0-153 lands, 154-255 does not

SpiralEffect_:
	ldh a, [hWhoseTurn]
	and a
	ld hl, wEnemyBattleStatus2
	jr z, .gotTarget
	ld hl, wPlayerBattleStatus2
.gotTarget
	ld c, STATUS_FAIL_SUBSTITUTE
	bit HAS_SUBSTITUTE_UP, [hl]
	jr nz, .failed
	bit NEEDS_TO_RECHARGE, [hl]
	jr nz, .hit ; a target that must recharge: no accuracy test (the sleep leg ends the recharge if it lands)
	callfar MoveHitTest
	ld c, STATUS_FAIL_MISS
	ld a, [wMoveMissed]
	and a
	jr nz, .failed
.hit
	call SpiralSleepLeg ; carry: the sleep landed, the move's animation played with it
	ld b, 0 ; (ld keeps the flags)
	jr nc, .noSleep
	dec b ; $ff
	push bc
	jr .confusionLeg
.noSleep
	push bc
	callfar PlayCurrentMoveAnimation2 ; the move's animation, once
.confusionLeg
	call SpiralConfusionLeg
	pop bc ; b = $ff: the sleep landed (pop keeps the flags)
	ret c ; the confusion landed, its line said
	inc b
	ret z ; the sleep landed, its line said
	ld hl, LookedAwayText
	jp PrintText
.failed
	jp PrintStatusMoveFailure

; SPIRAL's sleep leg: its roll, then SLEEP_EFFECT's gate (SleepEffect): it lands on a target that must recharge,
; whatever its status (the recharge ends), else only in an open hard-status slot (TargetStatusSlot: no status, or a
; burn whose fire is out). It lands by SleepEffect's own landing (the count, TargetStatusGone, the move's animation,
; "fell asleep!" with fresh HUDs). OUT carry = it landed. Clobbers every register.
SpiralSleepLeg:
	ld de, SPIRAL_LEG_CHANCE << 8 | REALISM_SLP
	call AdjustStatusChance ; v1.0 (2026-11-26): d = the chance with the target's realism factors
	call BattleRandom
	cp d
	ret nc
	ldh a, [hWhoseTurn]
	and a
	ld hl, wEnemyBattleStatus2
	ld de, wEnemyMonStatus
	jr z, .gotTarget
	ld hl, wPlayerBattleStatus2
	ld de, wBattleMonStatus
.gotTarget
	bit NEEDS_TO_RECHARGE, [hl]
	res NEEDS_TO_RECHARGE, [hl] ; (res keeps the flags)
	jr nz, .lands
	ld c, TARGET_SLOT_ANY
	call TargetStatusSlot ; Z = open (keeps de)
	jr nz, SpiralLegShut
.lands
	callfar SleepEffect.setSleepCounter ; de = the target's status byte
	scf
	ret

; SPIRAL's confusion leg: its roll, then CONFUSION_EFFECT's gate (a confusion already there), and the landing of
; every confusion move (ConfusionSideEffectSuccess: the count 2-5, "became confused!" with fresh HUDs; it plays no
; animation for SPIRAL_EFFECT). OUT carry = it landed. Clobbers every register.
SpiralConfusionLeg:
	ld de, SPIRAL_LEG_CHANCE << 8 | REALISM_CONFUSION
	call AdjustStatusChance ; v1.0 (2026-11-26): d = the chance with the target's realism factors
	call BattleRandom
	cp d
	ret nc
	ldh a, [hWhoseTurn]
	and a
	ld a, [wEnemyBattleStatus1]
	jr z, .gotTarget
	ld a, [wPlayerBattleStatus1]
.gotTarget
	bit CONFUSED, a
	jr nz, SpiralLegShut
	callfar ConfusionSideEffectSuccess
	scf
	ret

SpiralLegShut:
	and a ; the roll's carry goes: the leg did not land
	ret

; Far, through AIFearMoveUseless (wEnemyMoveEffect = SPIRAL_EFFECT). The trainer AI's SPIRAL (layer 1): useless behind
; the player's SUBSTITUTE (it stops the whole move). With both legs shut by a gate the screen shows - a hard status
; (the sleep's gate; never while it must recharge: the sleep lands then) AND a confusion (the confusion's gate) - only
; discouraged: the confusion, and a sleep or a freeze, can end in the player's own turn before SPIRAL runs (E4, as
; CONFUSE RAY; the owner, 2026-11-24). One leg open is enough. OUT as AIFearMoveUseless: carry = useless, else NZ =
; discouraged, Z = nothing. Clobbers a, c, hl. de is kept.
AISpiralMoveUseless:
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .useless
	bit NEEDS_TO_RECHARGE, a
	jr nz, .open
	ld a, [wPlayerBattleStatus1]
	bit CONFUSED, a
	jr z, .open
	ld c, 0 ; the player's #MON
	call BattlerSlotTaken ; Z = open (keeps bc, de)
	jr z, .open
	or 1 ; both legs shut: NZ, and no carry
	ret
.open
	xor a ; Z, no carry
	ret
.useless
	scf
	ret

LookedAwayText:
	text_far _LookedAwayText
	text_end

BecameScaredText:
	text_far _BecameScaredText
	text_end

ScaredNoMoreText:
	text_far _ScaredNoMoreText
	text_end

TooScaredText:
	text_far _TooScaredText
	text_end

; Far, from ProtectEffect (bank $1D: its section has no room for this), after its sure refusal (the user moving last).
; v1.0 (2026-11-25, the owner): the PROTECT chain. After n PROTECTs of its own that worked in a row (PROTECT_CHAIN,
; status 3, 0-3: CommitTurnBattleBits counts them, a PROTECT that failed or any other move breaks the chain), a
; PROTECT works 1 time in 2^n: a roll below $100 >> n - 50 %, 25 %, then 12.5 %, the floor. With no chain it surely
; works and draws nothing. When it works, the user's PROTECTING is set here.
; OUT carry = it fails. Clobbers a, bc, hl (BattleRandom keeps them).
ProtectChainRoll::
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotUser
	ld hl, wEnemyBattleStatus2
.gotUser
	inc hl ; status 3
	ld a, [hld]
	and PROTECT_CHAIN_MASK
	jr z, .works
	swap a ; the chain's bits 5-6 to bits 1-2
	rrca ; the chain, 1-3
	ld b, a
	ld c, $80 ; 1 in 2 for a chain of 1
.halve
	dec b
	jr z, .roll
	srl c
	jr .halve
.roll
	call BattleRandom
	cp c
	ccf
	ret c ; a roll of $100 >> n or more: it fails
.works
	set PROTECTING, [hl]
	and a
	ret

; v1.0 (2026-11-26): THE REALISM FACTORS. A side effect's chance to give a status, changed by the target's types
; (data/battle/realism_factors.asm, INCLUDEd after this file: 10 points a row, every row of each of its types, its
; third included; the sum never takes the chance below REALISM_FLOOR, 5 %, nor above 100 %). The target is the side
; whose turn it is not; the types read are the ones it has now (TRANSFORM and CONVERSION change them), the third its
; species' (what it looks like now). The immunities are the callers' and stay ahead of this: a factor never lets a
; status through one. No random draw here: the rolls stay where they were. Callers: SHADOW BALL's fear, SPIRAL's two
; legs and the bleed here; the side effects of engine/battle/effects.asm (bank $1D) through AdjustStatusChanceB, far;
; the status moves' hit chance (engine/battle/realism_accuracy.asm, Battle Core Overflow), far.
; IN  d = the roll's threshold (a roll below d lands: P percent + 1; for a hit chance, the chance), e = the status
;     (REALISM_*).
; OUT d = that threshold with the target's factors. Keeps bc, e, hl.
AdjustStatusChance::
	push bc
	push hl
	ldh a, [hWhoseTurn]
	and a
	ld hl, wEnemyMonType1
	ld a, [wEnemyMonSpecies] ; (ld keeps the flags of the and)
	jr z, .gotTarget
	ld hl, wBattleMonType1
	ld a, [wBattleMonSpecies]
.gotTarget
	call GetThirdType ; a = its third type, $FF for none (keeps bc, de, hl)
	ld b, a
	ld a, [hli]
	ld c, a ; type 1
	ld h, [hl] ; type 2
	ld l, b ; its third
	ld b, 0 ; the sum of the factors (signed)
	call .factors ; type 1
	ld a, h
	cp c
	call nz, .factors ; type 2, when it is not type 1
	ld a, l
	inc a
	jr z, .sum ; no third type
	dec a
	cp c
	jr z, .sum
	cp h
	call nz, .factors ; the third, when it is neither
.sum
	ld a, b
	and a
	jr z, .done ; no factor
	bit 7, b
	ld a, d
	jr nz, .lower
	add b
	jr nc, .gotChance
	ld a, $ff ; 100 %
	jr .gotChance
.lower
	add b ; b negative: carry when the result did not go below 0
	jr nc, .floor
	cp REALISM_FLOOR
	jr nc, .gotChance
.floor
	ld a, REALISM_FLOOR
.gotChance
	ld d, a
.done
	pop hl
	pop bc
	ret

; IN  a = a type, e = the status, b = the sum so far. OUT b += every row of (e, a). Keeps c, de, hl.
.factors
	push de
	push hl
	ld d, a
	ld hl, RealismFactors
.row
	ld a, [hli] ; the status
	cp -1
	jr z, .rowsDone
	cp e
	ld a, [hli] ; the type (ld keeps the flags of the cp)
	jr nz, .nextRow
	cp d
	jr nz, .nextRow
	ld a, [hl] ; the step, + or -
	add b
	ld b, a
.nextRow
	inc hl
	jr .row
.rowsDone
	pop hl
	pop de
	ret

INCLUDE "data/battle/fear_immune_types.asm"
INCLUDE "data/battle/bleed_moves.asm"
INCLUDE "data/pokemon/bloodless.asm"
