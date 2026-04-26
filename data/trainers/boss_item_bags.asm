; Boss item bags (v0.7 hard mode knob #10).
;
; Each boss class has a fixed PER-BATTLE bag of items. Once exhausted the
; boss can't refill — same constraint the player has on Revives/PP refills
; in Hard mode trainer battles, kept symmetric.
;
; Data is loaded into wEnemyTrainerItemBag at battle start by
; InitEnemyTrainerItemBag, but only when IsHardModeBossBattle returns true.
; In Normal mode, in wild battles, or against a non-boss class the bag
; stays empty and the boss AI routines no-op out.
;
; Format: pairs of (item_id, count). Padded with `-1, -1` to BOSS_BAG_SIZE
; bytes. CheckAndConsumeBossItem walks the pairs and stops at the first -1
; in the item_id slot. Max 4 distinct item types per boss.
;
; Per-boss philosophy:
;   * Heal tier scales with gym progression: Super Potion (early) →
;     Hyper Potion (mid) → Full Restore (E4 / Champion).
;   * Buff items are thematic per boss (X Defend for tanks, X Attack for
;     attackers, X Special for Sabrina, etc.).
;   * Quantities tuned for typical mon count: 2-3 heals + 1-2 buffs.
;     Joy is the heaviest healer (NURSE class: 2 FR + 2 HP + 1 FH).

; ---- Gym leaders (Pewter → Cinnabar) ----
BrockBossBag::    db SUPER_POTION, 2, X_DEFEND,  1,             -1, -1, -1, -1
MistyBossBag::    db SUPER_POTION, 2, X_DEFEND,  1,             -1, -1, -1, -1
LtSurgeBossBag::  db SUPER_POTION, 2, X_SPEED,   1,             -1, -1, -1, -1
ErikaBossBag::    db SUPER_POTION, 2, X_DEFEND,  2,             -1, -1, -1, -1
KogaBossBag::     db HYPER_POTION, 2, X_ATTACK,  2,             -1, -1, -1, -1
SabrinaBossBag::  db HYPER_POTION, 2, X_SPECIAL, 2,             -1, -1, -1, -1
BlaineBossBag::   db HYPER_POTION, 3, X_ATTACK,  2,             -1, -1, -1, -1

; ---- Giovanni (Rocket Hideout / Silph / Viridian Gym, same class) ----
GiovanniBossBag:: db FULL_RESTORE, 2, X_ATTACK,  2, GUARD_SPEC, 1, -1, -1

; ---- Elite Four + Champion ----
LoreleiBossBag::  db FULL_RESTORE, 2, X_DEFEND,  2,             -1, -1, -1, -1
BrunoBossBag::    db HYPER_POTION, 2, X_ATTACK,  2,             -1, -1, -1, -1
AgathaBossBag::   db FULL_RESTORE, 2, DIRE_HIT,  2,             -1, -1, -1, -1
LanceBossBag::    db FULL_RESTORE, 3, X_ATTACK,  2,             -1, -1, -1, -1

; ---- Rivals (Rival1 has no bag — too early-game) ----
Rival2BossBag::   db SUPER_POTION, 2, X_ATTACK,  2,             -1, -1, -1, -1
Rival3BossBag::   db FULL_RESTORE, 2, X_ATTACK,  2,             -1, -1, -1, -1

; ---- Prof Oak (post-game) ----
ProfOakBossBag::  db FULL_RESTORE, 2, X_ATTACK,  2,             -1, -1, -1, -1

; ---- Misc bosses promoted in v0.6/v0.7 ----
JoyBossBag::      db FULL_RESTORE, 2, HYPER_POTION, 2, FULL_HEAL, 1, -1, -1
JennyBossBag::    db HYPER_POTION, 1, X_ATTACK,  1,             -1, -1, -1, -1
JanineBossBag::   db SUPER_POTION, 1, X_ATTACK,  1,             -1, -1, -1, -1
JessieAndJamesBossBag:: \
                  db SUPER_POTION, 1, X_ATTACK,  1,             -1, -1, -1, -1


; Dispatch table: (trainer_class, bag_pointer) triplets, terminated by -1
; in the class slot. InitEnemyTrainerItemBag does a linear scan.
; Order doesn't matter for correctness. Listed roughly in story order.
BossItemBagPointers::
	db BROCK
	dw BrockBossBag
	db MISTY
	dw MistyBossBag
	db LT_SURGE
	dw LtSurgeBossBag
	db ERIKA
	dw ErikaBossBag
	db KOGA
	dw KogaBossBag
	db SABRINA
	dw SabrinaBossBag
	db BLAINE
	dw BlaineBossBag
	db GIOVANNI
	dw GiovanniBossBag
	db LORELEI
	dw LoreleiBossBag
	db BRUNO
	dw BrunoBossBag
	db AGATHA
	dw AgathaBossBag
	db LANCE
	dw LanceBossBag
	db RIVAL2
	dw Rival2BossBag
	db RIVAL3
	dw Rival3BossBag
	db PROF_OAK
	dw ProfOakBossBag
	db JOY
	dw JoyBossBag
	db JENNY
	dw JennyBossBag
	db JANINE
	dw JanineBossBag
	db JESSIE_AND_JAMES
	dw JessieAndJamesBossBag
	db -1                       ; terminator
