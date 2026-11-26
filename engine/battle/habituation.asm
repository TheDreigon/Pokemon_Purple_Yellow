; v1.0 (2026-11-26): the habit. A #MON faced again and again with the same intimidation gets used to it:
; INTIMIDATE, SCARY FACE, LEER and DEATH GLARE lose accuracy on a target that has already met them.
;
; The level. Each side has one, 0-3, in two free bits of its battle status: HABIT_LO (status 2, bit 6) is
; bit 0 and HABIT_HI (status 3, bit 7) is bit 1. It is the TARGET's: how used that #MON is to the four moves
; of the #MON it faces. One level for the four together, so changing from one of them to another does not
; get round it.
;
; The toll. Each move takes its own step off the hit chance per level the target already has, in points
; of percent (HabitMoves): INTIMIDATE and SCARY FACE 15 (90 -> 75 -> 60 -> 45), DEATH GLARE 10
; (85 -> 75 -> 65 -> 55), LEER 5 (100 -> 95 -> 90 -> 85). The step is taken off the chance the roll uses
; (after the ACCURACY and EVASION stages, before the Hard boss edge), never below 1 in 256.
;
; The count. Every use that reaches the accuracy roll raises the target's level one, up to HABIT_MAX,
; whether it then hits or misses: it is the target having seen the move again. A use stopped before the
; roll (PROTECT, a hidden target, MIST, DEATH GLARE's own refusals) does not count. LOCK-ON is the
; exception by design: with the target locked on, the user's moves skip the roll, so they hit and the use
; does not count.
;
; The recovery. Counted where the game says "<MON> used MOVE!" (MonName1Text), with the attacker's last
; move (wPlayerUsedMove / wEnemyUsedMove, the MIRROR MOVE byte, before this turn's is written): the first
; turn the attacker uses none of the four, nothing; from the second such turn in a row, the target loses
; one level per turn. Only the turns with that line count: a turn in which the attacker cannot move does
; not reach it, nor a THRASH or a WRAP going on (their own lines). A sleep or a freeze zeroes the byte, and
; the turn after it then counts as a first turn without. Using one of the four every other turn never
; recovers. MIRROR MOVE and METRONOME announce twice in one turn, themselves and then the move they call;
; the turn is judged once, at the first, by their own id: when the move called is one of the four, it
; still counts at the roll, but that turn may have recovered a level first.
; (A slower recovery, one level every second turn without the four, would need a third bit per side to
; count those turns; none is free.)
;
; The end. Both levels go back to 0 when either side's #MON leaves the field (SendOutMon,
; EnemySendOutFirstMon: the same places as LOCK-ON's lock), and at the end of the battle.
;
; The line. A miss only the habit caused (the roll fell inside the step taken off) says
; "<TARGET> / is used to it!" in place of the move's own miss line, once, in MoveHitTest
; (MOVE_FAILED_HABITUATED). Any other miss says what it always said.
;
; The trainer AI. Layer 1 (AIMoveChoiceModification1) discourages the four moves from level 2 on (+5, as
; a move that may fail) and heavily at level 3 (+10): AIHabitScores, after layer 1's own rules, on the moves they
; did not find useless.
;
; The code is in Battle Core Overflow: MoveHitTest (bank $1D), MonName1Text (Battle Core) and the trainer
; AI (Battle Engine 6) each reach it with one farcall; MoveHitTest's and the AI's go through the realism factors
; first (HitChanceTolls, AIHitChanceScores: engine/battle/realism_accuracy.asm), which then jump here.

ASSERT wPlayerBattleStatus3 == wPlayerBattleStatus2 + 1 && wEnemyBattleStatus3 == wEnemyBattleStatus2 + 1, \
	"the habit's two bits are in status 2 and the byte after it"

; The four moves and their step per level (points of percent of the hit chance).
HabitMoves:
	db INTIMIDATE,  15 percent
	db SCARY_FACE,  15 percent
	db DEATH_GLARE, 10 percent
	db LEER,         5 percent
	db -1

; IN  d = the hit chance CalcHitChance gave (1-$FF), with the realism factors (HitChanceTolls);
;     hWhoseTurn = the attacker
; OUT d = the hit chance less the habit's toll (at least 1), e = what was taken off (0: not one of the four
;     moves, or the target's level at 0). One of the four moves: the target's level goes up one (up to
;     HABIT_MAX), whatever the roll does next. Clobbers a, bc, hl.
HabitAccuracy::
	call HabitTargetStatus2
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .gotMove
	ld a, [wEnemyMoveNum]
.gotMove
	push hl
	call HabitStepOf ; a = the step, Z: not one of the four
	pop hl
	ld e, 0
	ret z
	ld c, a
	call GetHabitLevel ; a = the level before this use
	ld b, a
	cp HABIT_MAX
	jr nc, .counted
	inc a
	call SetHabitLevel
.counted
	xor a ; the toll: the step times the level before this use (3 x 15 percent at most: no carry)
	inc b
.toll
	dec b
	jr z, .gotToll
	add c
	jr .toll
.gotToll
	ld e, a
	ld a, d
	sub e
	jr z, .floor
	jr nc, .gotChance
.floor
	ld a, 1
.gotChance
	ld b, a ; the new chance
	ld a, d
	sub b
	ld e, a ; what was taken off
	ld d, b
	ret

; IN  d = the move the attacker uses this turn, e = the move it used last (0 after a sleep or a freeze, or
;     with nothing used in this matchup yet); hWhoseTurn = the attacker. MonName1Text, before it writes d
;     over e. Clobbers a, bc, hl.
HabitRecover::
	ld a, e
	and a
	ret z ; no last move to go by
	cp MIRROR_MOVE
	ret z ; the second announcement of a MIRROR MOVE or METRONOME turn has their own id as the last move:
	cp METRONOME ; the turn was judged at the first (a turn after a MIRROR MOVE that copied nothing, its id
	ret z        ; left in the byte, is not judged either)
	call HabitStepOf
	ret nz ; last turn was one of the four: this is the first turn without
	ld a, d
	call HabitStepOf
	ret nz ; this turn is one of the four
	call HabitTargetStatus2
	call GetHabitLevel
	and a
	ret z
	dec a
	jp SetHabitLevel

; MoveHitTest's line for a miss the habit made, said once there (as TargetIsProtected says PROTECT's): the
; miss printers stay silent for MOVE_FAILED_HABITUATED.
SayUsedToIt::
	ld c, 30
	call DelayFrames
	ld hl, UsedToItText
	jp PrintText

UsedToItText:
	text_far _UsedToItText
	text_end

; The trainer AI's layer 1 (AIMoveChoiceModification1) calls this after its own rules and the realism factors'
; scores (AIHitChanceScores). The player's level is what the screen has shown: every use of the four on it was
; announced. At level 2 each of the four moves in the trainer's set gets +5 (as a move that may fail), at level 3
; +10; below that nothing, nothing on a slot layer 1 scored useless or that cannot be used (AI_SCORE_USELESS or
; more: a move refused before its roll; the useless tier keeps its own order), and nothing with the trainer's own
; LOCK-ON set (its moves skip the roll). MIRROR MOVE ranks as the move it would copy, the player's last, as in layer
; 1's own rules. Clobbers every register.
AIHabitScores::
	ld a, [wEnemyBattleStatus2]
	bit LOCKED_ON, a
	ret nz
	ld hl, wPlayerBattleStatus2
	call GetHabitLevel
	cp 2
	ret c
	ld c, 5
	jr z, .gotScore ; (ld keeps the flags of the cp)
	ld c, 10
.gotScore
	ld hl, wEnemyMonMoves
	ld de, wBuffer ; the scores, one per slot, as layer 1 walks them
	ld b, NUM_MOVES
.loop
	ld a, [de]
	cp AI_SCORE_USELESS
	ld a, [hli] ; (ld keeps the flags of the cp)
	jr nc, .next ; useless, or not usable: left alone (AIHitChanceScores)
	and a
	ret z ; no more moves
	cp MIRROR_MOVE
	jr nz, .judge
	ld a, [wPlayerUsedMove] ; its copy (0: nothing to copy, not one of the four)
.judge
	push hl
	push bc
	call HabitStepOf
	pop bc
	pop hl
	jr z, .next
	ld a, [de]
	add c
	ld [de], a
.next
	inc de
	dec b
	jr nz, .loop
	ret

; hl = the status 2 of the side hWhoseTurn attacks. Clobbers a.
HabitTargetStatus2:
	ld hl, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	ret z
	ld hl, wPlayerBattleStatus2
	ret

; IN  a = a move. OUT a = its step per level, NZ: one of the four; a = 0, Z: any other. Clobbers b, hl.
HabitStepOf:
	ld b, a
	ld hl, HabitMoves
.loop
	ld a, [hli]
	cp -1
	jr z, .none
	cp b
	ld a, [hli] ; (ld keeps the flags of the cp)
	jr nz, .loop
	and a ; every step is above 0: NZ
	ret
.none
	xor a
	ret

; IN  hl = a side's status 2. OUT a = its level, 0-3 (the flags say nothing). Keeps bc, de, hl.
GetHabitLevel:
	xor a
	bit HABIT_LO, [hl]
	jr z, .gotLow
	inc a
.gotLow
	inc hl
	bit HABIT_HI, [hl]
	dec hl ; (keeps the flags)
	ret z
	add 2
	ret

; IN  hl = a side's status 2, a = its new level, 0-3. Keeps a, bc, de, hl.
SetHabitLevel:
	res HABIT_LO, [hl]
	bit 0, a
	jr z, .gotLow
	set HABIT_LO, [hl]
.gotLow
	inc hl
	res HABIT_HI, [hl]
	bit 1, a
	jr z, .gotHigh
	set HABIT_HI, [hl]
.gotHigh
	dec hl
	ret
