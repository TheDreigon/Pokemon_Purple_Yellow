TransformEffect_:
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonSpecies
	ld bc, wEnemyBattleStatus3
	ld a, [wEnemyBattleStatus1]
	ldh a, [hWhoseTurn]
	and a
	jr nz, .hitTest
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonSpecies
	ld bc, wPlayerBattleStatus3
	ld [wPlayerMoveListIndex], a
	ld a, [wPlayerBattleStatus1]
.hitTest
; v1.0 (R12, 2026-10-03): this FLY / DIG test never fails, and that is intended: TRANSFORM copies a target
; that is up in the air (FLY) or underground (DIG), since the user saw it a moment ago and still remembers
; it. On the player's turn a holds the user's own battle status 1, never INVULNERABLE when it acts; on the
; enemy's turn the `ldh a, [hWhoseTurn]` above has replaced the byte just loaded with 1. TRANSFORM, a
; ResidualEffects1 move, never reaches MoveHitTest's INVULNERABLE gate either, so .failed is not reached in
; play. The code is vanilla's.
	bit INVULNERABLE, a ; the user's own byte, or 1 on the enemy's turn: never set here (see above)
	jp nz, .failed
	push hl
	push de
	push bc
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .transformEffect
	ld hl, wEnemyBattleStatus2
.transformEffect
; animation(s) played are different if target has Substitute up
	bit HAS_SUBSTITUTE_UP, [hl]
	push af
	ld hl, HideSubstituteShowMonAnim
	ld b, BANK(HideSubstituteShowMonAnim)
	call nz, Bankswitch
	ld a, [wOptions]
	add a
	ld hl, PlayCurrentMoveAnimation
	ld b, BANK(PlayCurrentMoveAnimation)
	jr nc, .gotAnimToPlay
	ld hl, AnimationTransformMon
	ld b, BANK(AnimationTransformMon)
.gotAnimToPlay
	call Bankswitch
	ld hl, ReshowSubstituteAnim
	ld b, BANK(ReshowSubstituteAnim)
	pop af
	call nz, Bankswitch
	pop bc
	ld a, [bc]
	set TRANSFORMED, a ; mon is now transformed
	ld [bc], a
	pop de
	pop hl
	push hl
; transform user into opposing Pokemon
; species
	ld a, [hl]
	ld [de], a
; type 1, type 2, catch rate, and moves
	ld bc, $5
	add hl, bc
	inc de
	inc de
	inc de
	inc de
	inc de
	inc bc
	inc bc
	call CopyData
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
; save enemy mon DVs at wTransformedEnemyMonOriginalDVs
	ld a, [de]
	ld [wTransformedEnemyMonOriginalDVs], a
	inc de
	ld a, [de]
	ld [wTransformedEnemyMonOriginalDVs + 1], a
	dec de
.next
; DVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
; the battle stats after MaxHP (Attack..last stat)
	inc hl
	inc hl
	inc hl
	inc de
	inc de
	inc de
	ld bc, wBattleMonPP - wBattleMonAttack
	call CopyData
	ld bc, wBattleMonMoves - wBattleMonPP
	add hl, bc ; ld hl, wBattleMonMoves
	ld b, NUM_MOVES
.copyPPLoop
; 5 PP for all moves
	ld a, [hli]
	and a
	jr z, .lessThanFourMoves
	ld a, $5
.lessThanFourMoves
	ld [de], a
	inc de
	dec b
	jr nz, .copyPPLoop
.copyStats
; original (unmodified) stats and stat mods
	pop hl
	ld a, [hl]
	ld [wd11e], a
	call GetMonName
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wPlayerMonUnmodifiedAttack
	ld bc, wPlayerMonStatMods - wPlayerMonUnmodifiedAttack ; NUM_BATTLE_STATS words
	call .copyBasedOnTurn ; original (unmodified) stats
	call EnemyTransformRawStats ; v1.0 (D11): in Normal, your stats without the badge boost
	ld hl, wEnemyMonStatMods
	ld de, wPlayerMonStatMods
	ld bc, NUM_STAT_MODS
	call .copyBasedOnTurn ; stat mods
; v1.0 (D6): the five stats from what was just copied, then the user's OWN burn /
; paralysis cut - the copied battle stats carried the TARGET's (status_stat_cut.asm)
	call UserStatsWithOwnCut
; v1.0 (R12, 2026-10-02): the user's SPEED is now rebuilt from the target's - its unmodified stat (for the enemy's
; copy in Normal, the party stat without the badge boost) and its stage - with the user's own paralysis cut: a
; change no stage message shows, so the turn order the trainer AI learned in this matchup (wAITurnOrder) no longer
; holds - for the enemy's TRANSFORM and the player's alike. The next turn the speeds decide teaches it again
; (AISpeedsDecideTheTurn writes the context then, before any commit can set bit 0, so the context needs no reset
; here). A TRANSFORM that ended at .failed (not reached in play: the FLY / DIG test at the top never fails) would
; copy nothing and keep it.
	xor a
	ld [wAITurnOrder], a
	ld hl, TransformedText
	jp PrintText

.copyBasedOnTurn
; bc = length. The split (F2a): the unmodified block is NUM_BATTLE_STATS words
; and the mods block NUM_STAT_MODS bytes - no longer the same eight.
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotStatsOrModsToCopy
	push hl
	ld h, d
	ld l, e
	pop de
.gotStatsOrModsToCopy
	jp CopyData

.failed
; v0.7: PrintButItFailedText_ moved to the Battle Effects bank, and
; EffectCallBattleCore switches to a HARDCODED BANK(BattleCore) before the
; jump -- it would land on garbage. farjp recomputes the target's real bank.
	farjp PrintButItFailedText_

TransformedText:
	text_far _TransformedText
	text_end

; v1.0 (D11, 2026-09-28; in Hard Mode the copy stands, in Normal Mode the badges are not copied):
; the ENEMY's TRANSFORM, right after it copied your unmodified stats. In
; Normal those carry the badge boost - PIKACHU's x1.25 with it - baked in by ApplyBadgeStatBoosts
; at the send-out (LoadBattleMonFromParty) and at a level-up (experience.asm). The enemy now takes
; the party stats of your #MON in battle instead: the same five, before the boost (a level-up
; rewrites them first, then re-bakes). Not when your #MON is TRANSFORMed: its unmodified stats
; are then a copy of an enemy's (the one it TRANSFORMed into), with no boost in them. Hard bakes
; no boost, so it is left as it was. Your TRANSFORM copies the enemy's stats, which never carry
; one. HP is never copied.
; UserStatsWithOwnCut then makes the enemy's five battle stats from these.
; Trashes a, bc, de, hl, f.
EnemyTransformRawStats:
	ldh a, [hWhoseTurn]
	and a
	ret z ; your TRANSFORM
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	ret nz
	ld a, [wPlayerBattleStatus3]
	bit TRANSFORMED, a
	ret nz
	ld a, [wPlayerMonNumber]
	ld hl, wPartyMon1Attack
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld de, wEnemyMonUnmodifiedAttack
	ld bc, wPlayerMonStatMods - wPlayerMonUnmodifiedAttack ; NUM_BATTLE_STATS words, ATTACK..SP.DEF (the party order too)
	jp CopyData
ASSERT wPartyMon1StatsEnd - wPartyMon1Attack == wPlayerMonStatMods - wPlayerMonUnmodifiedAttack, \
	"EnemyTransformRawStats copies the party ATTACK..SP.DEF over the unmodified block"
