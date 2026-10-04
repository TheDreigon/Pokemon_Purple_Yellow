; v1.0 (R9t, 2026-09-30): in "Battle Core Overflow" (bank $10), out of "Battle Engine 6" (bank $0E),
; which round 9's AI rules needed. Every caller reaches both routines with callfar (core.asm,
; learn_move.asm, status_screen.asm; pokemart.asm, scripts/CeladonMart1F.asm), so the bank is free.

; formats a string at wMovesString that lists the moves at wMoves
FormatMovesString:
	ld hl, wMoves
	ld de, wMovesString
	ld b, $0
.printMoveNameLoop
	ld a, [hli]
	and a ; end of move list?
	jr z, .printDashLoop ; print dashes when no moves are left
	push hl
	ld [wd0b5], a
	ld a, BANK(MoveNames)
	ld [wPredefBank], a
	ld a, MOVE_NAME
	ld [wNameListType], a
	call GetName
	ld hl, wcd6d
.copyNameLoop
	ld a, [hli]
	cp $50
	jr z, .doneCopyingName
	ld [de], a
	inc de
	jr .copyNameLoop
.doneCopyingName
	ld a, b
	ld [wNumMovesMinusOne], a
	inc b
	ld a, $4e ; line break
	ld [de], a
	inc de
	pop hl
	ld a, b
	cp NUM_MOVES
	jr z, .done
	jr .printMoveNameLoop
.printDashLoop
	ld a, "-"
	ld [de], a
	inc de
	inc b
	ld a, b
	cp NUM_MOVES
	jr z, .done
	ld a, $4e ; line break
	ld [de], a
	inc de
	jr .printDashLoop
.done
	ld a, "@"
	ld [de], a
	ret

; XXX this is called in a few places, but it doesn't appear to do anything useful
; exported: the Celadon information desk builds its own item list from maps.asm,
; a different object file from the battle/menu engine that used to be its only caller
InitList::
	ld a, [wInitListType]
	cp INIT_ENEMYOT_LIST
	jr nz, .notEnemy
	ld hl, wEnemyPartyCount
	ld de, wEnemyMonOT
	ld a, ENEMYOT_NAME
	jr .done
.notEnemy
	cp INIT_PLAYEROT_LIST
	jr nz, .notPlayer
	ld hl, wPartyCount
	ld de, wPartyMonOT
	ld a, PLAYEROT_NAME
	jr .done
.notPlayer
	cp INIT_MON_LIST
	jr nz, .notMonster
	ld hl, wItemList
	ld de, MonsterNames
	ld a, MONSTER_NAME
	jr .done
.notMonster
	cp INIT_BAG_ITEM_LIST
	jr nz, .notBag
	ld hl, wNumBagItems
	ld de, ItemNames
	ld a, ITEM_NAME
	jr .done
.notBag
	ld hl, wItemList
	ld de, ItemNames
	ld a, ITEM_NAME
.done
	ld [wNameListType], a
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	ld bc, ItemPrices
	ld a, c
	ld [wItemPrices], a
	ld a, b
	ld [wItemPrices + 1], a
	ret

; v1.0 (R11, 2026-10-02): the speeds as the screen shows them, for the turn order the trainer AI has seen
; (wAITurnOrder, MainInBattleLoop): it forgets "the player first" when the screen shows a change that could undo it -
; the player's SPEED stage down or its PAR on, the enemy's SPEED stage up or its PAR gone - and never reads a speed.
; v1.0 (R12, 2026-10-02): each side's stage and PAR are one rank (AISpeedContext), so a stage change and a PAR change
; shown in the same span weigh as the engine's multipliers do (R11's fold, stage - 2 for PAR, matched them only at
; stages 0 and +2: a PAR on at +1 with two AGILITYs to +3 read as no change, x1.5 -> x1.25).
AISpeedsDecideTheTurn::
; MainInBattleLoop's .compareSpeed: the speeds decide this turn's order. Unless the player's item, switch or failed
; run took its turn, or a side stores BIDE energy (it prints nothing that turn), the screen will show that order: it
; is pending, and the speeds as the screen shows them are kept with it (rewritten at every pending turn).
	ld a, [wActionResultOrTookBattleTurn]
	and a
	ret nz
	ld a, [wPlayerBattleStatus1]
	ld b, a
	ld a, [wEnemyBattleStatus1]
	or b
	and 1 << STORING_ENERGY ; a side storing BIDE energy prints nothing that turn: no order on screen either
	ret nz
	call AISpeedContext
	ld hl, wAISpeedContext
	ld a, d
	ld [hli], a ; the player's rank
	ld [hl], e ; the enemy's
	ld hl, wAITurnOrder
	set AI_ORDER_PENDING, [hl]
	ret

AIForgetStaleTurnOrder::
; the top of every turn, before the enemy chooses: no order is pending yet. The order seen is forgotten when the
; player's rank now is below, or the enemy's above, the one kept with it; a change the other way (the player's
; AGILITY, a SPEED drop or a PAR on the enemy) or none keeps it. This routine never rewrites the context: only
; AISpeedsDecideTheTurn does, at every pending turn - an item turn's too, where the order stays unseen; that context
; passed this check, so it is at least as good for "the player first", and a forget can only come sooner.
	ld hl, wAITurnOrder
	res AI_ORDER_PENDING, [hl]
	call AISpeedContext
	ld hl, wAISpeedContext
	ld a, d
	cp [hl] ; carry: the player's rank now is below the one seen
	jr c, .forget
	inc hl
	ld a, [hl]
	cp e ; carry: the enemy's rank seen is below the one now
	ret nc
.forget
	xor a
	ld [wAITurnOrder], a
	ret

AISpeedContext:
; d = the player's speed rank, e = the enemy's: round(8 x log2(the multiplier the engine applies)) + 24 -
; StatModifierRatios' row for the stage (AISpeedRanks), then PAR halving it (HalveSpeedDueToParalysis): 8 down.
; Equal multipliers rank equal (PAR at +2 = no stage, PAR at -2 = -6 ...), a higher one higher: 0 (-6 with PAR) to
; 40 (+6). Clobbers a, b, c, hl.
	ld a, [wPlayerMonSpeedMod]
	ld c, a
	ld a, [wBattleMonStatus]
	call .rank
	ld d, a
	ld a, [wEnemyMonSpeedMod]
	ld c, a
	ld a, [wEnemyMonStatus]
	call .rank
	ld e, a
	ret
.rank
; c = the SPEED stage (1-13), a = the status
	ld b, 0
	ld hl, AISpeedRanks - 1
	add hl, bc
	and 1 << PAR
	ld a, [hl]
	ret z
	sub 8 ; PAR halves the speed: one doubling down
	ret

AISpeedRanks:
; SPEED stage 1-13 (-6 .. +6) without PAR: round(8 x log2(num / den)) + 24, StatModifierRatios' rows
	db 8, 9, 11, 13, 16, 19, 24, 29, 32, 35, 37, 38, 40
	ASSERT @ - AISpeedRanks == MAX_STAT_LEVEL, "one rank per SPEED stage"
