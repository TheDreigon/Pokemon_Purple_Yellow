; Hard mode boss-buff helpers. v0.7+.
;
; In v0.7 a series of "boss trainer" buffs are gated on (wDifficulty ==
; HARD_MODE) AND (current trainer is a boss). Each individual knob is
; implemented next to its existing logic (CriticalHitTest, trainer party
; load, AI move choice, accuracy roll, etc.) — this file
; only provides the shared definition of "boss" and the two helpers
; everyone calls.
;
; Two tiers, defined at the bottom of this file (Forte, 2026-07-26; counts and
; membership re-confirmed by him 2026-08-18):
;   BOSS (17)  = all 8 gym leaders + all 4 Elite Four + all 3 rival classes
;                (RIVAL3 = Champion) + Prof Oak + FORTE. Giovanni's three
;                appearances are all boss fights.
;   SEMI (9)   = Bill, Nurse Joy, Officer Jenny, Janine, Jessie & James, the
;                three bird-chamber self-inserts SMITH / CRAIG / WEEBRA, and
;                KIYO in the Saffron dojo.
; The lists below hold 17 and 9 db entries and those numbers are the truth:
; they read "17" and "7" for weeks after KIYO and BILL were added, so treat a
; count in a comment here as a claim to re-check, not a fact.
;
; KIYO is the one class whose tier is per-FIGHT, not per-class: the dojo master
; is a semi, the post-League Viridian leader is a full boss. He lives in the
; SEMI list and IsBossTrainerClass promotes fight 2 — see .byFight below.
; The semis get the AI override, maxed DVs (Hard only) and an item bag, but
; never the crit bonus, the +1 level or the accuracy edge.
;
; The split drives PRIZE MONEY but NOT battle music or the victory fanfare:
; those are per-OPP lists (play_battle_music.asm, GrandVictoryClasses) keyed to
; the CLASS, and they contain semis on purpose. KIYO is the clearest case - the
; dojo fight is a semi that still gets the gym-leader theme and the grand
; fanfare. This comment claimed all three followed the tiers until 2026-08-18.
;
; Class identity automatically covers gym leader rematches (same class), E4
; rematches (same class), Giovanni's three appearances (same class), and all
; rival fights regardless of starter (same RIVALn class).
;
; Routines live in bank $0E (Battle Engine 6) since the 2026-08-17 move,
; NOT bank $0F as this comment claimed until 2026-08-18. read_trainer_party is
; in that same bank and still farcalls in - harmless, and kept because the W
; entry point has to reload wTrainerClass anyway. core.asm (CriticalHitTest,
; LoadEnemyMon, bank $0F), hit_and_penalties (MoveHitTest, bank $1D) and
; boss_item_bags (bank $16) farcall from other banks. Check pokeyellow.sym,
; not this line.

; Returns Z=0 (boss) / Z=1 (not a boss).
; Input:  a = trainer class ID (1..NUM_TRAINERS)
;         wTrainerNo - read ONLY for KIYO, whose tier is per-fight. Every
;         other class answers from the class alone. See .byFight below.
; Output: Z flag (Z=1 means NOT boss; Z=0 means boss)
; Trashes: a, b, hl
;
; IsBossTrainerClassW: same check, but loads wTrainerClass itself instead
; of taking it in a. MUST be used when reaching this via farcall: the
; rst _Bankswitch path overwrites a with the destination bank id before
; the call lands, so a routine that expects its arg in a would see the
; bank ($0E) and never match. Routines that read inputs from wram
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
	jr z, .byFight              ; end of the list — one class still qualifies
	                            ; by FIGHT rather than by class
	cp b
	jr nz, .loop
	; Match. a == b (the class ID, which is non-zero), so OR'ing a
	; with itself yields Z=0 — "this is a boss" return convention.
	or a
	ret

; KIYO is the one trainer whose tier is not decided by his class alone (Forte,
; 2026-08-18): the KARATE MASTER of the Saffron dojo is a SEMI-boss, and the
; same man holding the Viridian Gym after the League is a full boss. He is
; listed in SemiBossTrainerClasses and NOT in BossTrainerClasses — the two
; lists may never overlap, emu_test_bosstiers enforces it and boss_bag_coverage
; needs him in exactly one — so the Viridian fight is PROMOTED here instead.
;
; This is the second per-fight exception in the ROM. The other is RIVAL1's
; first fight skipping the +1 level (read_trainer_party.asm). That one is
; knob-local; this one has to live in the tier itself, because a tier moves
; five knobs at once (crit, accuracy, +1 level, DVs, item bag).
;
; Safe because wTrainerNo is written before the battle starts — by the map
; script, or by InitBattleEnemyParameters via home/trainers.asm — and nothing
; writes it again until the fight is over, so it is valid at every caller.
;
;
; EVERY class the boss list missed arrives here - that is what the terminator
; jump means, and an earlier version of this comment claimed the opposite. They
; are thrown out two instructions down by `cp KIYO`, which also rejects the 0
; that init_battle writes to wTrainerClass for a wild battle. A class that IS
; in the list returned above and never gets here. So only KIYO ever reaches
; the wTrainerNo read.
.byFight
	ld a, b
	cp KIYO
	jr nz, .notBoss
	ld a, [wTrainerNo]
	cp 2                        ; 2 = the Viridian Gym; 1 = the Saffron dojo
	jr nz, .notBoss
	or a                        ; a = 2, non-zero → Z=0, "this is a boss"
	ret
.notBoss
	xor a                       ; Z=1
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
	; KIYO is deliberately NOT here — he is in SemiBossTrainerClasses, and his
	; Viridian fight (trainer_no 2) is promoted back to boss by .byFight above.
	; Listing him in both lists is forbidden; see the comment on .byFight.
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
	db KIYO                     ; the KARATE MASTER of the Saffron dojo. His
	                            ; Viridian Gym fight is a FULL boss and is
	                            ; promoted per-fight in .byFight above; only
	                            ; the dojo fight is really a semi
	db SMITH
	db WEEBRA
	db -1                       ; terminator


; -------------------------------------------------------------------------
; v0.7 hard mode (Forte, 2026-08-30): a BADGE match is refused unless the
; challenger brings no more POKeMON than the leader fields (equal is fine).
; Post-League rematches are exempt: their script branches never call this.
;
; Called via callfar from the badge branch of the eight gym scripts. The
; caller seeds wCurOpponent (OPP_*) and wTrainerNo (the object_event's
; party id) first - the engage path re-sets both later on the accepted
; path, so the seeding is harmless. Inputs come from wram because the rst
; _Bankswitch path lands with a = destination bank (see IsBossTrainerClassW
; above).
;
; On refusal: prints the house rule and ZEROES wCurOpponent; the caller
; tests it and ends the text script without the intro speech.
; Trashes: a, b, d, e, hl. TrainerDataPointers is in this same bank.
HardModeGymPartyGate::
	ld a, [wDifficulty]
	cp HARD_MODE
	ret nz
	ld a, [wCurOpponent]
	sub OPP_ID_OFFSET
	dec a
	ld e, a
	ld d, 0
	ld hl, TrainerDataPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl -> the class's first party
	ld a, [wTrainerNo]
	ld d, a
.findParty
	dec d
	jr z, .countParty
.skipParty
	ld a, [hli]
	and a
	jr nz, .skipParty
	jr .findParty
.countParty
; two party formats: "$FF, lvl, mon, lvl, mon, ..., 0" (variable levels)
; and "lvl, mon, mon, ..., 0" (one shared level)
	ld b, 0
	ld a, [hli]
	cp $FF
	jr z, .variableLevels
.sharedLevel
	ld a, [hli]
	and a
	jr z, .haveCount
	inc b
	jr .sharedLevel
.variableLevels
	ld a, [hli] ; level, 0 = end of party
	and a
	jr z, .haveCount
	inc hl      ; the species byte
	inc b
	jr .variableLevels
.haveCount
	ld a, [wPartyCount]
	cp b
	ret z ; equal counts fight
	ret c ; fewer than the leader fights
	ld a, b
	ld [wd11e], a ; the refusal text prints the leader's count from here
	ld hl, HardModeGymPartyGateText
	call PrintText
	xor a
	ld [wCurOpponent], a ; the veto the caller tests
	ret

HardModeGymPartyGateText:
	text_far _HardModeGymPartyGateText
	text_end
