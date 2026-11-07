EndOfBattle:
; v1.0 (2026-11-07): the link battle's ending (the VERSUS box and YOU WIN / YOU LOSE /
; DRAW) went with the cable: it ran only behind `cp LINK_STATE_BATTLING`.
	ld a, [wBattleResult]
	and a
	jr z, .won
; v1.0 (2026-11-07): a 2 (drew, ran or caught) runs the evolutions too. A capture
; pays experience (half a knockout, ItemUseBall), and a level it gave set the
; Pokemon's wCanEvolveFlags bit, which only a won battle used to act on: the
; evolution was dropped. The PAY DAY money and the PIKACHU mood stay the win's. A
; run or a POKE DOLL escape has gained no level, so nothing evolves there.
	cp $2
	jr nz, .resetVariables ; lost
	xor a
	ld [wForceEvolution], a
	predef EvolutionAfterBattle
	jr .resetVariables
.won
	ld hl, wTotalPayDayMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr z, .evolution ; if pay day money is 0, jump
	ld de, wPlayerMoney + 2
	ld c, $3
	predef AddBCDPredef
	ld hl, PickUpPayDayMoneyText
	call PrintText
.evolution
	xor a
	ld [wForceEvolution], a
	predef EvolutionAfterBattle
	ld d, $82
	callfar UpdatePikachuMoodAfterBattle
.resetVariables
	xor a
	ld [wLowHealthAlarm], a ;disable low health alarm
	ld [wChannelSoundIDs + CHAN5], a
	ld [wIsInBattle], a
	ld [wBattleType], a
	ld [wMoveMissed], a
	ld [wCurOpponent], a
	ld [wForcePlayerToChooseMon], a
	ld [wNumRunAttempts], a
	ld [wEscapedFromBattle], a
	ld hl, wPartyAndBillsPCSavedMenuItem
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wListScrollOffset], a
	ld hl, wPlayerStatsToDouble
	ld b, wEscapedFromBattle + 1 - wPlayerStatsToDouble ; was a literal $18 (v1.0, 2026-09-08: a pad inside the span went to the stack)
.loop
	ld [hli], a
	dec b
	jr nz, .loop
; v1.0 (2026-09-27): a bad POISON lasts the battle; every party #MON leaves it as
; ordinary POISON (Gen 3-4), so nothing says TOX outside a battle. Every battle
; ends here (init_battle.asm: callfar StartBattle, then callfar EndOfBattle).
	farcall RevertPartyToxic ; toxic_carry.asm
	ld hl, wd72c
	set 0, [hl]
	call WaitForSoundToFinish
	call GBPalWhiteOut
	ld a, $ff
	ld [wDestinationWarpID], a
	ret

PickUpPayDayMoneyText:
	text_far _PickUpPayDayMoneyText
	text_end
