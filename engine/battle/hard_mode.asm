; Hard mode boss-buff helpers. v0.7+.
;
; In v0.7 a series of "boss trainer" buffs are gated on (wDifficulty ==
; HARD_MODE) AND (current trainer is a boss). Each individual knob is
; implemented next to its existing logic (CriticalHitTest, trainer party
; load, AI move choice, accuracy roll, etc.) — this file
; only provides the shared definition of "boss" and the two helpers
; everyone calls.
;
; Two tiers, defined at the bottom of this file (Forte, 2026-07-26):
;   BOSS (17)  = all 8 gym leaders + all 4 Elite Four + all 3 rival classes
;                (RIVAL3 = Champion) + Prof Oak + FORTE.
;   SEMI (7)   = Nurse Joy, Officer Jenny, Janine, Jessie & James, and the
;                three bird-chamber self-inserts SMITH / CRAIG / WEEBRA.
; The semis get the AI override, maxed DVs (Hard only) and an item bag, but
; never the crit bonus, the +1 level or the accuracy edge. Same split drives
; prize money and battle music, so the three lists can no longer disagree.
;
; Class identity automatically covers gym leader rematches (same class), E4
; rematches (same class), Giovanni's three appearances (same class), and all
; rival fights regardless of starter (same RIVALn class).
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
	; v0.7 FIX: never treat a LINK battle as a boss battle. cable_club.asm
	; starts link fights with `ld a, OPP_RIVAL1 / ld [wCurOpponent], a`, so
	; wTrainerClass becomes RIVAL1 — a boss class — and wIsInBattle is 2.
	; Without this guard, a hard-mode player's link battles silently got the
	; boss crit and accuracy edges, which both sides compute independently:
	; guaranteed desync against the other Game Boy.
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .notHardModeBossBattle
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

; Same shape as IsBossTrainerClassW, for the semi-boss tier.
IsSemiBossTrainerClassW::
	ld a, [wTrainerClass]
	ld b, a
	ld hl, SemiBossTrainerClasses
.loop
	ld a, [hli]
	cp -1
	ret z                       ; terminator → Z=1, not a semi-boss
	cp b
	jr nz, .loop
	or a                        ; matched: a is a non-zero class id → Z=0
	ret

; Returns Z=0 when the enemy Pokemon should be given maxed DVs - and with them
; the full-HP top-up, which is not a separate knob but a required part of the
; same change (the DV override raises max HP after current HP was computed from
; the un-boosted DVs, so without it the Pokemon shows up a sliver below full).
;
; Bosses get this in BOTH modes: perfect DVs are the least rule-bending knob
; there is - no extra crits, no accuracy edge, just a Pokemon that was raised
; properly - so a gym leader feels like a gym leader even on Normal. Semi-bosses
; get it in Hard mode only.
;
; Trashes: a, b, hl
ShouldMaxEnemyDVs::
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .noMaxDVs             ; never touch a link battle: guaranteed desync
	ld a, [wIsInBattle]
	cp 2                        ; 2 = trainer battle
	jr nz, .noMaxDVs
	call IsBossTrainerClassW
	ret nz                      ; a boss, in either difficulty
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .noMaxDVs
	jp IsSemiBossTrainerClassW  ; tail-call; semi-bosses, Hard mode only
.noMaxDVs
	xor a                       ; Z=1
	ret

; Returns Z=0 when the trainer may carry a Hard-mode item bag: bosses and
; semi-bosses alike. The bag is the third thing a semi-boss inherits, after the
; AI its class already carries and the maxed DVs above.
;
; Trashes: a, b, hl
IsHardModeBossOrSemiBattle::
	call IsHardModeBossBattle
	ret nz                      ; already a hard-mode boss battle
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .noBag
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .noBag
	ld a, [wIsInBattle]
	cp 2
	jr nz, .noBag
	jp IsSemiBossTrainerClassW
.noBag
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
	db KIYO                     ; the 8th gym's post-League leader — full
	                            ; badge-holder tier, and his dojo fight in
	                            ; Saffron is a boss fight for the same reason
	                            ; Brock's first fight is one
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

; The semi-boss tier (Forte, 2026-07-26). These get the AI their class already
; carries, maxed DVs in Hard mode, and an item bag - but NOT the crit bonus,
; the +1 level or the accuracy edge. Those three change the rules of the fight
; against the player, and staying on the boss side of that line is what keeps a
; real boss feeling categorically different.
;
; Janine, Officer Jenny, Nurse Joy and Jessie & James were full bosses until
; now; this is a deliberate demotion, and it also aligns the buff list with the
; prize-money and battle-music tiers, which already treated them as semis. Two
; lists disagreeing about what a "boss" was is exactly the kind of drift that
; makes a later change land in only half the places it should.
;
; Smith, Craig and Weebra were in neither list before - the note said they were
; "already calibrated by hand", which was true of their teams but left their
; documented item bags doing nothing at all.
SemiBossTrainerClasses::
	db BILL                     ; approved as a semi with Oak's bag (2026-08-09)
	                            ; but never listed — BillBossBag and his Hard
	                            ; DVs were dead until 2026-08-16
	db CRAIG
	db JANINE
	db JENNY
	db JESSIE_AND_JAMES         ; Team Rocket duo (4 fights, mid-game)
	db JOY
	db SMITH
	db WEEBRA
	db -1                       ; terminator

