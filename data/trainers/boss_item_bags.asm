; Boss item bags (v0.7 hard mode knob #10).
;
; Each boss FIGHT has a fixed per-battle bag of items — per fight, not per
; class, since 2026-08-17: the sheet in "Hard Mode - changes.txt" gives every
; gym leader a stronger rematch bag, Giovanni a weaker early-game one, and
; Kiyo one per venue. Once exhausted the boss can't refill — same constraint
; the player has on Revives/PP refills in Hard mode trainer battles.
;
; Data is loaded into wEnemyTrainerItemBag at battle start by
; InitEnemyTrainerItemBag (below — it lives WITH this data, in its own
; floating section, reached by farcall), but only when
; IsHardModeBossOrSemiBattle passes. In Normal mode, in wild battles, or
; against a non-boss class the bag stays empty and the boss AI routines
; no-op out.
;
; Format: pairs of (item_id, count). Padded with `-1, -1` to BOSS_BAG_SIZE
; bytes. CheckAndConsumeBossItem walks the pairs and stops at the first -1
; in the item_id slot. Max 4 distinct item types per boss.
;
; Every item here must have an AI branch that reaches for it, or it is dead
; weight — that is how ForteBossBag once sat stocked and never spent, and
; why the leaders' heal branches try Full Restore AND their first-fight
; potion tier (the rematch bags heal a tier above the originals).

; ---- Gym leaders (Pewter -> Cinnabar): first fight, then rematch ----
BrockBossBag::      db POTION,       2, X_DEFEND,   1, FULL_HEAL,  2, -1, -1
BrockRematchBag::   db FULL_RESTORE, 2, X_DEFEND,   2, FULL_HEAL,  2, -1, -1
MistyBossBag::      db SUPER_POTION, 2, X_SPECIAL,  1, FULL_HEAL,  2, -1, -1
MistyRematchBag::   db FULL_RESTORE, 2, X_SPECIAL,  2, FULL_HEAL,  2, -1, -1
LtSurgeBossBag::    db SUPER_POTION, 2, X_SPEED,    1, FULL_HEAL,  2, -1, -1
LtSurgeRematchBag:: db FULL_RESTORE, 2, X_SPEED,    2, FULL_HEAL,  2, -1, -1
; Erika buffs SPECIAL now (2026-08-17 sheet correction; she was on X Defend)
ErikaBossBag::      db HYPER_POTION, 2, X_SPECIAL,  1, FULL_HEAL,  2, -1, -1
ErikaRematchBag::   db FULL_RESTORE, 2, X_SPECIAL,  2, FULL_HEAL,  2, -1, -1
; Koga's Dire Hit moved to his rematch (sheet correction)
KogaBossBag::       db HYPER_POTION, 2, X_SPEED,    1, FULL_HEAL,  2, -1, -1
KogaRematchBag::    db FULL_RESTORE, 2, X_SPEED,    2, DIRE_HIT,   1, FULL_HEAL, 2
SabrinaBossBag::    db HYPER_POTION, 2, X_SPECIAL,  1, FULL_HEAL,  2, -1, -1
SabrinaRematchBag:: db FULL_RESTORE, 2, X_SPECIAL,  2, FULL_HEAL,  2, -1, -1
BlaineBossBag::     db MAX_POTION,   2, X_SPECIAL,  1, FULL_HEAL,  2, -1, -1
BlaineRematchBag::  db FULL_RESTORE, 2, X_SPECIAL,  2, FULL_HEAL,  2, -1, -1

; ---- Giovanni: Rocket Hideout + Silph (fights 1-2), then the Viridian Gym ----
GiovanniEarlyBag::  db HYPER_POTION, 2, X_ATTACK,   1, X_DEFEND,   1, FULL_HEAL, 2
GiovanniBossBag::   db FULL_RESTORE, 2, X_ATTACK,   2, X_DEFEND,   2, FULL_HEAL, 2

; ---- Kiyo: the Fighting Dojo, then the post-League Viridian Gym ----
KiyoDojoBag::       db HYPER_POTION, 2, X_ATTACK,   1, FULL_HEAL,  2, -1, -1
KiyoRematchBag::    db FULL_RESTORE, 2, X_ATTACK,   2, DIRE_HIT,   1, FULL_HEAL, 2

; ---- Elite Four + Champion ----
LoreleiBossBag::    db FULL_RESTORE, 2, X_DEFEND,   2, FULL_HEAL,  2, -1, -1
BrunoBossBag::      db FULL_RESTORE, 2, X_ATTACK,   2, FULL_HEAL,  2, -1, -1
AgathaBossBag::     db FULL_RESTORE, 2, X_SPEED,    2, FULL_HEAL,  2, -1, -1
LanceBossBag::      db FULL_RESTORE, 2, X_SPECIAL,  2, X_SPEED,    1, FULL_HEAL, 2

; ---- Rivals (Rival1 has no bag -- too early-game) ----
; Rival2 lost his X Attacks and upgraded his potion (sheet correction)
Rival2BossBag::     db HYPER_POTION, 2, FULL_HEAL,  2, -1, -1, -1, -1
Rival3BossBag::     db FULL_RESTORE, 3, X_ATTACK,   2, X_SPEED,    1, FULL_HEAL, 3

; ---- Prof Oak (post-game) ----
ProfOakBossBag::    db FULL_RESTORE, 3, GUARD_SPEC, 1, DIRE_HIT,   1, FULL_HEAL, 3

; ---- Misc bosses promoted in v0.6/v0.7 ----
JoyBossBag::        db FULL_RESTORE, 3, X_DEFEND,   3, FULL_HEAL,  3, -1, -1
; Jenny trades her X Speed for a Guard Spec (sheet correction)
JennyBossBag::      db FULL_RESTORE, 2, X_ATTACK,   1, GUARD_SPEC, 1, FULL_HEAL, 2
JanineBossBag::     db SUPER_POTION, 2, X_SPEED,    1, GUARD_SPEC, 1, FULL_HEAL, 2
JessieAndJamesBossBag:: db SUPER_POTION, 2, FULL_HEAL, 2, -1, -1, -1, -1
BillBossBag::       db FULL_RESTORE, 3, GUARD_SPEC, 1, DIRE_HIT,   1, FULL_HEAL, 3 ; Bill — Oak's bag; BillAI spends all four
ForteBossBag::      db FULL_RESTORE, 6, FULL_HEAL, 6, -1, -1, -1, -1 ; Forte superboss — 6x Full Restore, 6x Full Heal
; Shared by the three bird-chamber self-inserts — one tier below the bosses,
; identical behaviour, so they share a bag as well as an AI routine.
SelfInsertBossBag:: db FULL_RESTORE, 3, FULL_HEAL, 3, -1, -1, -1, -1 ; Smith / Craig / Weebra

; Dispatch table: (trainer_class, trainer_no, bag_pointer) rows, terminated
; by -1 in the class slot. trainer_no 0 is a wildcard that matches any fight.
; InitEnemyTrainerItemBag scans linearly and takes the FIRST match, so a
; class's specific rows must come before its wildcard row. Every leader's
; rematch is party 2 (the ghost badge-order copies were removed 2026-08-17),
; Giovanni's gym fight is party 3, Kiyo's Viridian fight is party 2.
BossItemBagPointers::
	db BROCK, 2
	dw BrockRematchBag
	db BROCK, 0
	dw BrockBossBag
	db MISTY, 2
	dw MistyRematchBag
	db MISTY, 0
	dw MistyBossBag
	db LT_SURGE, 2
	dw LtSurgeRematchBag
	db LT_SURGE, 0
	dw LtSurgeBossBag
	db ERIKA, 2
	dw ErikaRematchBag
	db ERIKA, 0
	dw ErikaBossBag
	db KOGA, 2
	dw KogaRematchBag
	db KOGA, 0
	dw KogaBossBag
	db SABRINA, 2
	dw SabrinaRematchBag
	db SABRINA, 0
	dw SabrinaBossBag
	db BLAINE, 2
	dw BlaineRematchBag
	db BLAINE, 0
	dw BlaineBossBag
	db GIOVANNI, 3
	dw GiovanniBossBag
	db GIOVANNI, 0
	dw GiovanniEarlyBag
	db KIYO, 2
	dw KiyoRematchBag
	db KIYO, 0
	dw KiyoDojoBag
	db LORELEI, 0
	dw LoreleiBossBag
	db BRUNO, 0
	dw BrunoBossBag
	db AGATHA, 0
	dw AgathaBossBag
	db LANCE, 0
	dw LanceBossBag
	db RIVAL2, 0
	dw Rival2BossBag
	db RIVAL3, 0
	dw Rival3BossBag
	db PROF_OAK, 0
	dw ProfOakBossBag
	db JOY, 0
	dw JoyBossBag
	db JENNY, 0
	dw JennyBossBag
	db JANINE, 0
	dw JanineBossBag
	db BILL, 0
	dw BillBossBag
	db JESSIE_AND_JAMES, 0
	dw JessieAndJamesBossBag
	db FORTE, 0
	dw ForteBossBag
	db SMITH, 0
	dw SelfInsertBossBag
	db CRAIG, 0
	dw SelfInsertBossBag
	db WEEBRA, 0
	dw SelfInsertBossBag
	db -1                       ; terminator

; Initialise wEnemyTrainerItemBag for this battle. Called once at battle
; start by init_battle.asm via farcall (after wTrainerClass, wTrainerNo and
; wAICount are set AND after wIsInBattle is set to 2 — the tier predicate
; requires it — but before any AI tick fires). If this is not a Hard-mode
; boss battle the bag stays empty (-1 fill) and every CheckAndConsumeBossItem
; returns no-carry, so boss AI routines no-op out cleanly.
;
; Moved here from trainer_ai.asm (2026-08-17) so the loader shares a bank
; with the data it scans; the tier predicate became a farcall — no argument
; in a, answer in Z, the same bankswitch-safe contract the victory-fanfare
; list already relies on.
;
; Trashes: a, b, c, d, e, hl
InitEnemyTrainerItemBag::
	; Step 1: clear bag to all -1 (sentinel)
	ld hl, wEnemyTrainerItemBag
	ld c, BOSS_BAG_SIZE
	ld a, -1
.clear
	ld [hli], a
	dec c
	jr nz, .clear

	; Step 2: bail unless this is a Hard-mode boss OR semi-boss battle.
	; The farcall must come BEFORE b/c are loaded — Bankswitch pops bc on
	; the way back.
	farcall IsHardModeBossOrSemiBattle
	ret z

	; Step 3: linear scan for (class, fight). First match wins; a row with
	; trainer_no 0 matches any fight, so specific rows precede wildcards.
	ld a, [wTrainerClass]
	ld b, a
	ld a, [wTrainerNo]
	ld c, a
	ld hl, BossItemBagPointers
.findBoss
	ld a, [hl]
	cp -1
	ret z                       ; class missing from table → keep empty bag
	cp b
	jr nz, .next
	inc hl                      ; hl → row's trainer_no
	ld a, [hl]
	and a                       ; 0 → wildcard, matches any fight
	jr z, .found
	cp c
	jr z, .found
	dec hl                      ; wrong fight: back to the class byte
.next
	inc hl                      ; skip class byte
	inc hl                      ; skip trainer_no
	inc hl                      ; skip pointer low
	inc hl                      ; skip pointer high
	jr .findBoss
.found
	inc hl                      ; hl → bag pointer low
	ld a, [hli]
	ld h, [hl]
	ld l, a                     ; hl = bag pointer

	; Step 4: copy BOSS_BAG_SIZE bytes from rom bag → wram bag
	ld de, wEnemyTrainerItemBag
	ld c, BOSS_BAG_SIZE
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy
	ret
