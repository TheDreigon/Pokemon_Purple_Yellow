; Three things changed here on 2026-09-24 (Forte):
;  * A multi-hit move says how effective it was ONCE, when it is over, not once
;    per hit. DisplayEffectiveness stays quiet while the hits are landing;
;    MultiHitDone says it (and "Hit N times!") when the last planned hit has
;    landed or the target has fainted -- vanilla printed no hit count at all
;    when the target fainted mid-way.
;  * x4 and x1/4 get their own lines. wDamageMultipliers is chained per matching
;    row (engine/battle/type_effectiveness.asm): 40, 20, 10, 5, 2 or 0. The
;    "super effective against one type, not very against the other" case is a
;    10 and prints nothing, which the chaining already fixed; vanilla kept the
;    LAST matching row and said whichever came later in the table.
;  * "Hit 1 times!" is never printed: a multi-hit move whose first hit KO'd
;    says only how effective it was.

DisplayEffectiveness:
	call IsMultiHitMove
	ret z ; MultiHitDone says it when the hits are over
DisplayEffectiveness_:
	ld a, [wDamageMultipliers]
	and $7F
	ret z ; immune: cannot get here (a 0 is reported as not connecting) -- belt and braces
	cp EFFECTIVE
	ret z
	ld hl, SuperEffectiveText
	jr c, .resisted
	cp SUPER_EFFECTIVE * 2 ; 40: super effective against BOTH of the target's types
	jr nz, .done
	ld hl, ExtremelyEffectiveText
	jr .done
.resisted
	ld hl, NotVeryEffectiveText
	cp NOT_VERY_EFFECTIVE ; 5: one resistance; anything below (2) is both types resisting
	jr nc, .done
	ld hl, BarelyEffectiveText
.done
	jp PrintText

; Z when the move being executed hits more than once. Two signals, and both
; are needed: on hit 1 the effect byte says so and ATTACKING_MULTIPLE_TIMES is
; not up yet (TwoToFiveAttacksEffect, which raises it, runs from the
; AlwaysHappenSideEffects dispatch AFTER the effectiveness line); from hit 2 on
; the bit is up, and TWINEEDLE's effect byte has been rewritten to
; POISON_SIDE_EFFECT2 by then. (ExtremeYellow checks the effect byte alone and
; prints TWINEEDLE's effectiveness twice.)
; IN: hWhoseTurn
IsMultiHitMove:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotSide
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyMoveEffect
.gotSide
	bit ATTACKING_MULTIPLE_TIMES, [hl]
	jr nz, .yes
	ld a, [de]
	cp TWO_TO_FIVE_ATTACKS_EFFECT
	ret z
	cp ATTACK_TWICE_EFFECT
	ret z
	cp TWINEEDLE_EFFECT
	ret
.yes
	xor a
	ret

; The two lines a multi-hit move owes once it is over: how effective it was,
; then how many times it hit (the Gen 2+ order). Called from the two
; ExecuteXMove tails -- when the last planned hit has landed (NumAttacksLeft is
; already 0) and when the target fainted (NumAttacksLeft still counts the hit
; that did it and the ones after it that will never be thrown). Returns at once
; when no multi-hit move is in progress, so the fainted path calls it blind.
; Clears ATTACKING_MULTIPLE_TIMES and zeroes wXNumHits, as the tails used to.
; IN: hWhoseTurn
MultiHitDone::
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ld bc, wPlayerNumHits
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotSide
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
	ld bc, wEnemyNumHits
.gotSide
	bit ATTACKING_MULTIPLE_TIMES, [hl]
	ret z
	res ATTACKING_MULTIPLE_TIMES, [hl]
; hits landed = hits planned (wXNumHits, written by TwoToFiveAttacksEffect)
; minus hits still owed. A KO leaves the hit that did it among the owed, since
; the tails only decrement after the HP check: take it out.
	ld hl, wEnemyMonHP
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotTarget
	ld hl, wBattleMonHP
.gotTarget
	ld a, [hli]
	or [hl]
	ld a, [de] ; ld does not touch the flags
	jr nz, .owed
	dec a
.owed
	ld l, a
	ld a, [bc]
	sub l
	ld [bc], a ; wXNumHits = hits landed, which is the number the text prints
	push bc
	call DisplayEffectiveness_
	pop bc
	ld a, [bc]
	dec a
	jr z, .cleanUp ; one hit: it never became a multi-hit, and "Hit 1 times!" is not English
	ld hl, MultiHitText
	ldh a, [hWhoseTurn]
	and a
	jr z, .say
	ld hl, HitXTimesText
.say
	push bc
	call PrintText
	pop bc
.cleanUp
	xor a
	ld [bc], a
	ret

SuperEffectiveText:
	text_far _SuperEffectiveText
	text_end

NotVeryEffectiveText:
	text_far _NotVeryEffectiveText
	text_end

ExtremelyEffectiveText:
	text_far _ExtremelyEffectiveText
	text_end

BarelyEffectiveText:
	text_far _BarelyEffectiveText
	text_end

; Moved here from engine/battle/core.asm: PrintText reads the wrapper from the
; bank that is loaded, and MultiHitDone runs in this one.
MultiHitText:
	text_far _MultiHitText
	text_end

HitXTimesText:
	text_far _HitXTimesText
	text_end
