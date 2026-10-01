; v0.7: the victory-fanfare list, relocated out of Battle Core for space. Cold code: it runs
; once, when a trainer is defeated. TrainerBattleVictory (core.asm) reaches it with `farcall`,
; its only reference. Safe across the bankswitch because it takes no argument in `a` (it reads
; wTrainerClass itself) and the caller only relies on the returned Z flag, the same contract
; IsBossTrainerClassW already uses from read_trainer_party.asm.
; v1.0 (R9s, 2026-09-30): in "Battle Core Overflow" (bank $10), included after toxic_carry.asm
; in main.asm. From v0.7 it sat in "Battle Engine 6" (bank $0E), the Trainer AI's bank, which
; round 9's AI rules needed; a farcall costs the same from any bank.

; v0.7 music review: trainer classes that earn the "big" victory fanfare
; (MUSIC_DEFEATED_GYM_LEADER) instead of the normal one. Read by
; TrainerBattleVictory, which used to key on wGymLeaderNo alone — that gave
; the grand fanfare only to the 8 leaders' FIRST fights and left the Elite
; Four, Oak and the leader rematches on the plain trainer jingle.
;
; This is a MUSIC list, deliberately independent of BossTrainerClasses: it
; includes the hand-calibrated semi-bosses (Jessie & James, Janine, Joy,
; Jenny, Smith, Craig, Weebra) and excludes RIVAL1/RIVAL2, so the rival
; fanfare escalates — only the Champion fight (RIVAL3) sounds grand.
; Order doesn't matter (linear scan). Terminator is -1.
GrandVictoryClasses::
; the badge holders (covers their rematches too, same class); Kiyo holds
; Viridian post-League, so his wins — dojo included — sound grand too
	db BROCK
	db MISTY
	db LT_SURGE
	db ERIKA
	db KOGA
	db SABRINA
	db BLAINE
	db GIOVANNI
	db KIYO
; the Elite Four and the Champion
	db LORELEI
	db BRUNO
	db AGATHA
	db LANCE
	db RIVAL3
; the post-game superbosses
	db PROF_OAK
	db FORTE
; the semi-bosses
	db JESSIE_AND_JAMES
	db JANINE
	db JOY
	db JENNY
	db BILL
	db SMITH
	db CRAIG
	db WEEBRA
	db -1                       ; terminator

; Returns Z=0 if the current trainer earns the grand victory fanfare, else
; Z=1. Reads wTrainerClass. Trashes: a, b, hl.
IsGrandVictoryClass::
	ld a, [wTrainerClass]
	ld b, a
	ld hl, GrandVictoryClasses
.loop
	ld a, [hli]
	cp -1
	ret z                       ; reached terminator → Z=1, normal fanfare
	cp b
	jr nz, .loop
	or a                        ; match: class ID is non-zero → Z=0
	ret
