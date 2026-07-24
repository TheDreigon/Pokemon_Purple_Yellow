; Hard mode boss-buff helpers. v0.7+.
;
; In v0.7 a series of "boss trainer" buffs are gated on (wDifficulty ==
; HARD_MODE) AND (current trainer is a boss). Each individual knob is
; implemented next to its existing logic (CriticalHitTest, trainer party
; load, AI move choice, accuracy roll, etc.) — this file
; only provides the shared definition of "boss" and the two helpers
; everyone calls.
;
; Boss list (decided with Forte): all 8 gym leaders + all 4 Elite Four +
; all 3 rival classes (RIVAL3 = Champion) + Prof Oak + Officer Jenny +
; Nurse Joy + Janine + Jessie & James + FORTE. SMITH/CRAIG/WEEBRA (special
; trainer classes) are intentionally NOT bosses — they're already
; calibrated by hand and shouldn't get the auto-buffs. Boss-class
; identity automatically covers gym leader rematches (same class), E4
; rematches (same class), Giovanni's three appearances (same class),
; and all rival fights regardless of starter (same RIVALn class).
; 21 classes total.
;
; Routines live in bank $0F (Battle Core) so the core.asm callers
; (CriticalHitTest, MoveHitTest, LoadEnemyMon) can near-call;
; trainer_ai.asm (bank $0E) and read_trainer_party.asm use farcall.

; Returns Z=0 (boss) / Z=1 (not a boss).
; Input:  a = trainer class ID (1..NUM_TRAINERS)
; Output: Z flag (Z=1 means NOT boss; Z=0 means boss)
; Trashes: a, b, hl
;
; IsBossTrainerClassW: same check, but loads wTrainerClass itself instead
; of taking it in a. MUST be used when reaching this via farcall: the
; rst _Bankswitch path overwrites a with the destination bank id before
; the call lands, so a routine that expects its arg in a would see the
; bank ($0F) and never match. Routines that read inputs from wram
; (IsHardModeBossBattle) are immune; plain IsBossTrainerClass is not.
IsBossTrainerClassW::
	ld a, [wTrainerClass]
	; fall through
IsBossTrainerClass::
	ld b, a
	ld hl, BossTrainerClasses
.loop
	ld a, [hli]
	cp -1
	ret z                       ; reached terminator → Z=1, not a boss
	cp b
	jr nz, .loop
	; Match. a == b (the class ID, which is non-zero), so OR'ing a
	; with itself yields Z=0 — "this is a boss" return convention.
	or a
	ret

; Returns Z=0 if (Hard mode) AND (this is a trainer battle) AND
; (current trainer is a boss). Else Z=1.
;
; Use this from anywhere a boss buff applies during an active battle.
; Reads wDifficulty + wIsInBattle + wTrainerClass; safe to call outside
; battle (will return Z=1 due to the wIsInBattle check).
;
; Trashes: a, b, hl
IsHardModeBossBattle::
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .notHardModeBossBattle
	ld a, [wIsInBattle]
	cp 2                        ; 2 = trainer battle
	jr nz, .notHardModeBossBattle
	ld a, [wTrainerClass]
	jp IsBossTrainerClass       ; tail-call; its Z reflects the answer
.notHardModeBossBattle
	xor a                       ; Z=1
	ret


; Boss trainer classes. Order doesn't matter (linear scan). Terminator
; is -1. Alphabetical for readability.
BossTrainerClasses::
	db AGATHA
	db BLAINE
	db BROCK
	db BRUNO
	db ERIKA
	db FORTE
	db GIOVANNI
	db JANINE
	db JENNY
	db JESSIE_AND_JAMES         ; Team Rocket duo (4 fights, mid-game)
	db JOY
	db KOGA
	db LANCE
	db LORELEI
	db LT_SURGE
	db MISTY
	db PROF_OAK
	db RIVAL1
	db RIVAL2
	db RIVAL3
	db SABRINA
	db -1                       ; terminator


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
; the 8 badge holders (covers their rematches too, same class)
	db BROCK
	db MISTY
	db LT_SURGE
	db ERIKA
	db KOGA
	db SABRINA
	db BLAINE
	db GIOVANNI
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
