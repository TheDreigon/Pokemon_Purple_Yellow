ReadTrainer:

; don't change any moves in a link battle
	ld a, [wLinkState]
	and a
	ret nz

; v0.7 Phase B: the rival's team is GENERATED from per-battle pools
; (data/trainers/rival_pools.asm) instead of read from fixed party data.
; The old Rival1/2/3Data parties and their SpecialTrainerMoves entries are
; bypassed entirely. Scripts still pass their historical wTrainerNo values
; (including the legacy 3-eeveelution variants); GetRivalBattleID maps any
; of them to the right battle pool, and the per-save eeveelution decides
; which eeveelution can be drawn.
	ld a, [wTrainerClass]
	cp RIVAL1
	jp z, GenerateRivalParty
	cp RIVAL2
	jp z, GenerateRivalParty
	cp RIVAL3
	jp z, GenerateRivalParty

; set [wEnemyPartyCount] to 0, [wEnemyPartySpecies] to FF
	ld hl, wEnemyPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

; get the pointer to trainer data for this class
	ld a, [wTrainerClass] ; get trainer class
	dec a
	add a
	ld hl, TrainerDataPointers
	ld c, a
	ld b, 0
	add hl, bc ; hl points to trainer class
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTrainerNo]
	ld b, a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z, .IterateTrainer
.inner
	ld a, [hli]
	and a
	jr nz, .inner
	jr .outer

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [wLoneAttackNo] != 0, one pokemon on the team has a special move
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	ld a, [hli]
	cp $FF ; is the trainer special?
	jr z, .SpecialTrainer ; if so, check for special moves
	call HardModeBossLevelBump ; v0.7 hard mode: bosses get +2 (cap MAX_LEVEL)
	ld [wCurEnemyLVL], a
.LoopTrainerData
	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jp z, .AddAdditionalMoveData
	ld [wcf91], a ; ld [wcf91], a ; species input for AddPartyMon
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData
.SpecialTrainer
; if this code is being run:
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [wLoneAttackNo] != 0, one pokemon on the team has a special move
	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jr z, .AddAdditionalMoveData
	call HardModeBossLevelBump ; v0.7 hard mode: bosses get +2 (cap MAX_LEVEL)
	ld [wCurEnemyLVL], a
	ld a, [hli]
	ld [wcf91], a
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .SpecialTrainer
.AddAdditionalMoveData
; does the trainer have additional move data?
	ld a, [wTrainerClass]
	ld b, a
	ld a, [wTrainerNo]
	ld c, a
	ld hl, SpecialTrainerMoves
.loopAdditionalMoveData
	ld a, [hli]
	cp $ff
	jr z, ReadTrainerFinishUp
	cp b
	jr nz, .asm_39c46
	ld a, [hli]
	cp c
	jr nz, .asm_39c46
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop
	ld a, [de]
	inc de
	and a
	jp z, ReadTrainerFinishUp
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [de]
	inc de
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	jr .writeAdditionalMoveDataLoop
.asm_39c46
	ld a, [hli]
	and a
	jr nz, .asm_39c46
	jr .loopAdditionalMoveData
; shared money-calculation tail; also entered by GenerateRivalParty.
ReadTrainerFinishUp:
; clear wAmountMoneyWon addresses
	xor a
	ld de, wAmountMoneyWon
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ld a, [wCurEnemyLVL]
	ld b, a
.LastLoop
; update wAmountMoneyWon addresses (money to win) based on enemy's level
	ld hl, wTrainerBaseMoney + 1
	ld c, 2 ; wAmountMoneyWon is a 3-byte number
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz, .LastLoop ; repeat wCurEnemyLVL times
	ret

; v0.7 hard mode helper. Called from .IterateTrainer (uniform-level
; trainer), .SpecialTrainer (per-mon level), and AddRivalMon (rival pool
; engine), just BEFORE writing to wCurEnemyLVL. Adds 2 to A if Hard
; mode + boss class, capped at MAX_LEVEL. No-op otherwise.
;
; Note: this also subtly bumps the prize money (wAmountMoneyWon is
; computed from the bumped wCurEnemyLVL down at ReadTrainerFinishUp). That's
; intentional — boss reward scales with the harder fight.
;
; Lives in bank $0E (Battle Engine 6) alongside ReadTrainer; uses
; farcall to reach IsBossTrainerClassW in bank $0F (Battle Core).
;
; Input:  a = unbumped level
; Output: a = bumped level (or unchanged if not hard-mode boss)
; Trashes: bc (the farcall's Bankswitch return path pops flags into c);
;          hl is preserved — see push/pop hl below
HardModeBossLevelBump:
	; v0.7 FIX: the farcall to IsBossTrainerClass clobbers hl (the farcall
	; macro does `ld hl, target`), but ReadTrainer's callers keep the live
	; trainer-party data pointer in hl across this call. Preserve it, or
	; every Hard-mode trainer battle would load a garbage enemy party.
	push hl
	push af
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .noBump
	; The very first rival fight (RIVAL1 at Oak's Lab = trainer 1, the L5
	; Eevee) is intentionally exempt: it stays at base level even in Hard
	; mode. Every other rival fight and every other boss still gets +2.
	ld a, [wTrainerClass]
	cp RIVAL1
	jr nz, .doBump
	ld a, [wTrainerNo]
	cp 1
	jr z, .noBump
.doBump
	; v0.7 BUGFIX: was `farcall IsBossTrainerClass` with the class in a,
	; but the farcall bank-switch (rst _Bankswitch) overwrites a with the
	; destination bank id before the call lands, so the check always saw
	; "$0F" and never matched — NO boss ever got the +2. IsBossTrainer
	; ClassW reloads wTrainerClass inside bank $0F, dodging the clobber.
	farcall IsBossTrainerClassW
	jr z, .noBump
	pop af
	add 2
	cp MAX_LEVEL + 1
	jr c, .done
	ld a, MAX_LEVEL
.done
	pop hl
	ret
.noBump
	pop af
	pop hl
	ret


; ===== v0.7 PHASE B — RIVAL POOL ENGINE =====
;
; The rival (RIVAL1/2/3) draws a random team from a per-battle pool
; (data/trainers/rival_pools.asm, generated from Notes/Rival Movesets.md).
; Mechanics: the eeveelution is rolled once per save (wRivalEeveelution,
; lazy-init); Eevee is guaranteed in the first three fights; from SS Anne
; onward the save's eeveelution is a rotating pool candidate (all three in
; the Champion rematch); every drawn mon gets its hand-picked 4-move set
; (move1 = 0 means natural level-up moves). Team is assembled in table
; order, so the ace/eeveelution (last entries) is sent out last.
;
; Scratch: wBuffer+0 team size, +1 guaranteed, +2 entry count, +3 flags,
; +4..+6 chosen-bitmask (up to 24 entries; tables cap at 22), +7 chosen
; counter. wBuffer is free during battle setup (the AI only uses it once
; the battle is running).
; ⚠ AddPartyMon zeroes wBuffer+0 on every call (wLearningMovesFromDayCare
; is a UNION alias of it) — so team size is only valid during the select
; phase, which is fine: the add phase reads only +2 and the +4..+6 bitmask.
; Never read +0 (or trust +7) during/after the add phase.

GenerateRivalParty:
; init enemy party (same as ReadTrainer's head)
	ld hl, wEnemyPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	call EnsureRivalEeveelution
	call GetRivalBattleID
; hl = pool table for this battle
	add a
	ld e, a
	ld d, 0
	ld hl, RivalBattlePointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
; copy header to scratch
	ld de, wBuffer
	ld b, 4
.copyHeader
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyHeader
; hl = first entry. clear the chosen-bitmask
	xor a
	ld [wBuffer + 4], a
	ld [wBuffer + 5], a
	ld [wBuffer + 6], a
; pre-mark the guaranteed entries (bits 0..G-1)
	ld a, [wBuffer + 1]
	ld [wBuffer + 7], a ; chosen = guaranteed
	and a
	jr z, .selectLoop
	ld b, a
	ld c, 0
.markGuaranteed
	ld a, c
	call RivalSetChosenBit
	inc c
	dec b
	jr nz, .markGuaranteed
.selectLoop
	ld a, [wBuffer + 7]
	ld b, a
	ld a, [wBuffer]
	cp b
	jr z, .addPhase ; team complete
.redraw
	push hl
	call Random
	pop hl
	and $1F
	ld b, a
	ld a, [wBuffer + 2]
	cp b
	jr z, .redraw ; index == count: out of range
	jr c, .redraw ; index >  count: out of range
	ld a, b
	call RivalGetChosenBit
	jr nz, .redraw ; already chosen
; eligibility check (eeveelution entries only match the save's roll,
; unless flags bit0 marks the all-three-eligible Champion rematch)
	push hl
	push bc
	ld a, b
	call RivalGetEntryAddr
	ld a, [hl] ; species
	pop bc
	pop hl
	cp VAPOREON
	jr z, .isEeveelution
	cp JOLTEON
	jr z, .isEeveelution
	cp FLAREON
	jr z, .isEeveelution
	jr .accept
.isEeveelution
	ld c, a
	ld a, [wBuffer + 3]
	and 1
	jr nz, .accept ; rematch: all three eligible
	ld a, [wRivalEeveelution]
	cp c
	jr nz, .redraw
.accept
	ld a, b
	call RivalSetChosenBit
	ld a, [wBuffer + 7]
	inc a
	ld [wBuffer + 7], a
	jr .selectLoop
.addPhase
; add chosen mons in TABLE order (aces last)
	ld c, 0
.addLoop
	ld a, [wBuffer + 2]
	cp c
	jr z, .done
	ld a, c
	call RivalGetChosenBit
	jr z, .nextEntry
	push bc
	push hl
	ld a, c
	call RivalGetEntryAddr
	call AddRivalMon
	pop hl
	pop bc
.nextEntry
	inc c
	jr .addLoop
.done
	jp ReadTrainerFinishUp

; in: a = entry index, hl = first-entry base. out: hl = entry address.
RivalGetEntryAddr:
	push bc
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc ; +2*idx
	sla c
	sla c
	add hl, bc ; +4*idx  -> +6*idx total
	pop bc
	ret

; add one pool entry (hl = SPECIES, LEVEL, m1..m4) to the enemy party,
; then force its hand-picked moves (m1 = 0 -> keep natural moves).
AddRivalMon:
	ld a, [hli]
	ld [wcf91], a ; species
	ld a, [hli]
	push hl
	call HardModeBossLevelBump ; +2 in hard (Lab fight exempt inside)
	ld [wCurEnemyLVL], a
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	call AddPartyMon
	pop hl
	ld a, [hl] ; m1
	and a
	ret z ; 0 = natural level-up moves
	push hl
	ld a, [wEnemyPartyCount]
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	pop de ; de = source moves, hl = dest party moves
	ld b, NUM_MOVES
.copyMoves
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .copyMoves
	ret
; (battle PP is derived from these moves at send-out by LoadEnemyMonData's
; LoadMovePPs pass, so no PP write is needed here.)

; out: a = rival battle id (0-8). Maps the scripts' historical wTrainerNo
; values (including the legacy per-eeveelution variants) onto pool ids.
GetRivalBattleID:
	ld a, [wTrainerClass]
	cp RIVAL1
	jr z, .rival1
	cp RIVAL2
	jr z, .rival2
; RIVAL3: 1-3 = Champion (legacy variants), 4 = Champion rematch
	ld a, [wTrainerNo]
	cp 4
	ld a, 7
	ret nz
	ld a, 8
	ret
.rival1
; RIVAL1: 1 = Lab, 2 = Route 22-1, 3 = Cerulean
	ld a, [wTrainerNo]
	dec a
	ret
.rival2
; RIVAL2: 1 = SS Anne, 2-4 = Tower, 5-7 = Silph, 8-10 = Route 22-2
	ld a, [wTrainerNo]
	cp 2
	jr c, .ssAnne
	cp 5
	jr c, .tower
	cp 8
	jr c, .silph
	ld a, 6
	ret
.ssAnne
	ld a, 3
	ret
.tower
	ld a, 4
	ret
.silph
	ld a, 5
	ret

; lazy per-save eeveelution roll. Valid values are the three species ids;
; anything else (0 on a fresh save, or garbage) triggers a fresh roll.
EnsureRivalEeveelution:
	ld a, [wRivalEeveelution]
	cp VAPOREON
	ret z
	cp JOLTEON
	ret z
	cp FLAREON
	ret z
.roll
	call Random
	and 3
	cp 3
	jr z, .roll ; need 0-2
	ld hl, .eeveelutions
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wRivalEeveelution], a
	ret
.eeveelutions
	db VAPOREON, JOLTEON, FLAREON

; in: a = bit index (0-23). out: z = free, nz = chosen. preserves b, hl.
RivalGetChosenBit:
	push hl
	push bc
	call RivalLocateBit
	and [hl]
	pop bc
	pop hl
	ret

; in: a = bit index (0-23). marks it chosen. preserves bc, hl.
RivalSetChosenBit:
	push hl
	push bc
	call RivalLocateBit
	or [hl]
	ld [hl], a
	pop bc
	pop hl
	ret

; in: a = bit index. out: hl = mask byte address, a = bit mask.
RivalLocateBit:
	ld c, a
	srl a
	srl a
	srl a ; a = index / 8
	ld hl, wBuffer + 4
	ld e, a
	ld d, 0
	add hl, de
	ld a, c
	and 7
	ld b, a
	ld a, 1
	inc b
.shift
	dec b
	ret z
	sla a
	jr .shift

INCLUDE "data/trainers/rival_pools.asm"
