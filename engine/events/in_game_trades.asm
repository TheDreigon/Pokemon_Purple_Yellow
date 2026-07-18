DoInGameTradeDialogue:
; trigger the trade offer/action specified by wWhichTrade
	call SaveScreenTilesToBuffer2
	ld hl, TradeMons
	ld a, [wWhichTrade]
	ld bc, $e
	call AddNTimes
	ld a, [hli]
	ld [wInGameTradeGiveMonSpecies], a
	ld a, [hli]
	ld [wInGameTradeReceiveMonSpecies], a
	ld a, [hli]
	push af
	ld de, wInGameTradeMonNick
	ld bc, NAME_LENGTH
	call CopyData
	pop af
	ld l, a
	ld h, 0
	ld de, InGameTradeTextPointers
	add hl, hl
	add hl, de
	ld a, [hli]
	ld [wInGameTradeTextPointerTablePointer], a
	ld a, [hl]
	ld [wInGameTradeTextPointerTablePointer + 1], a
	ld a, [wInGameTradeGiveMonSpecies]
	ld de, wInGameTradeGiveMonName
	call InGameTrade_GetMonName
	ld a, [wInGameTradeReceiveMonSpecies]
	ld de, wInGameTradeReceiveMonName
	call InGameTrade_GetMonName
	ld a, $4
	ld [wInGameTradeTextPointerTableIndex], a
	ld b, FLAG_TEST
	call InGameTrade_FlagActionPredef
	ld a, c
	and a
	jr nz, .printText
; if the trade hasn't been done yet
	ld a, $0
	ld [wInGameTradeTextPointerTableIndex], a
	call .printText
	ld a, $1
	ld [wInGameTradeTextPointerTableIndex], a
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .printText
	call InGameTrade_DoTrade
	jr c, .printText
	ld hl, TradedForText
	call PrintText
.printText
	ld hl, wInGameTradeTextPointerTableIndex
	ld a, [hld] ; wInGameTradeTextPointerTableIndex
	ld e, a
	ld d, 0
	ld a, [hld] ; wInGameTradeTextPointerTablePointer + 1
	ld l, [hl] ; wInGameTradeTextPointerTablePointer
	ld h, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

; copies name of species a to hl
InGameTrade_GetMonName:
	push de
	ld [wd11e], a
	call GetMonName
	ld hl, wcd6d
	pop de
	ld bc, NAME_LENGTH
	jp CopyData

INCLUDE "data/events/trades.asm"

InGameTrade_DoTrade:
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call DisplayPartyMenu
	push af
	call InGameTrade_RestoreScreen
	pop af
	ld a, $1
	jp c, .tradeFailed ; jump if the player didn't select a pokemon
	ld a, [wInGameTradeGiveMonSpecies]
	ld b, a
	ld a, [wcf91]
	cp b
	ld a, $2
	jr nz, .tradeFailed ; jump if the selected mon's species is not the required one
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Level
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hl]
	ld [wCurEnemyLVL], a
	ld b, FLAG_SET
	call InGameTrade_FlagActionPredef
	call InGameTrade_LatchSpecialMove
	ld hl, ConnectCableText
	call PrintText
	ld a, [wWhichPokemon]
	push af
	ld a, [wCurEnemyLVL]
	push af
	call LoadHpBarAndStatusTilePatterns
	call InGameTrade_PrepareTradeData
	predef InternalClockTradeAnim
	pop af
	ld [wCurEnemyLVL], a
	pop af
	ld [wWhichPokemon], a
	ld a, [wInGameTradeReceiveMonSpecies]
	ld [wcf91], a
	xor a
	ld [wMonDataLocation], a ; not used
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	ld a, $80 ; prevent the player from naming the mon
	ld [wMonDataLocation], a
	call AddPartyMon
	call InGameTrade_CopyDataToReceivedMon
	call InGameTrade_GiveSpecialMove
	call InGameTrade_CheckForTradeEvo
	call ClearScreen
	call InGameTrade_RestoreScreen
	farcall RedrawMapView
	and a
	ld a, $3
	jr .tradeSucceeded
.tradeFailed
	scf
.tradeSucceeded
	ld [wInGameTradeTextPointerTableIndex], a
	ret

InGameTrade_LatchSpecialMove:
; Resolve this trade's signature move while wWhichTrade is still
; vanilla-guaranteed. wWhichTrade is a heavily-unioned scratch byte
; (wSavedY/wTempSCX/wNumShakes/... — see wram.asm); the trade-movie
; window must not be trusted with it, so the move id is latched into
; wMoveNum, which nothing in that window touches (verified: no writes
; in engine/movie/trade.asm, add_mon.asm, remove_mon.asm).
	ld a, [wWhichTrade]
	ld e, a
	ld d, 0
	ld hl, TradeSpecialMoves
	add hl, de
	ld a, [hl]
	ld [wMoveNum], a
	ret

InGameTrade_GiveSpecialMove:
; Every NPC-traded mon arrives knowing its signature move (event-mon style;
; see data/events/trade_special_moves.asm), latched in wMoveNum by
; InGameTrade_LatchSpecialMove before the trade animation. The received mon
; is the last party member at this point (AddPartyMon just appended it).
; The move goes into the first empty move slot, or over slot 4 if the set
; is full, with its max PP — mirroring the LearnMove write pattern.
	ld a, [wMoveNum]
	and a
	ret z ; dormant rows carry no special move
	ld e, a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
; NOTE: no runtime duplicate guard — the invariant "no TradeSpecialMoves
; entry is naturally learnable by its receiver" is enforced statically by
; .claude/check_trade_special_moves.py (bank1C is byte-tight).
	ld b, NUM_MOVES
.findEmptySlot
	ld a, [hl]
	and a
	jr z, .write
	inc hl
	dec b
	jr nz, .findEmptySlot
	dec hl ; four natural moves: the newest one gives way
.write
	ld a, e
	ld [hl], a
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	push hl
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wBuffer
	ld a, BANK(Moves)
	call FarCopyData
	ld a, [wBuffer + 5] ; the move's max PP
	pop hl
	ld [hl], a
	ret

INCLUDE "data/events/trade_special_moves.asm"

InGameTrade_RestoreScreen:
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadTilesetTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call LoadGBPal
	ld c, 10
	call DelayFrames
	farjp LoadWildData

InGameTrade_PrepareTradeData:
	ld hl, wTradedPlayerMonSpecies
	ld a, [wInGameTradeGiveMonSpecies]
	ld [hli], a ; wTradedPlayerMonSpecies
	ld a, [wInGameTradeReceiveMonSpecies]
	ld [hl], a ; wTradedEnemyMonSpecies
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wTradedPlayerMonOT
	ld bc, NAME_LENGTH
	call InGameTrade_CopyData
	ld hl, InGameTrade_TrainerString
	ld de, wTradedEnemyMonOT
	call InGameTrade_CopyData
	ld de, wLinkEnemyTrainerName
	call InGameTrade_CopyData
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wTradedPlayerMonOTID
	ld bc, $2
	call InGameTrade_CopyData
	call Random
	ld hl, hRandomAdd
	ld de, wTradedEnemyMonOTID
	jp CopyData

InGameTrade_CopyData:
	push hl
	push bc
	call CopyData
	pop bc
	pop hl
	ret

InGameTrade_CopyDataToReceivedMon:
	ld hl, wPartyMonNicks
	ld bc, NAME_LENGTH
	call InGameTrade_GetReceivedMonPointer
	ld hl, wInGameTradeMonNick
	ld bc, NAME_LENGTH
	call CopyData
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call InGameTrade_GetReceivedMonPointer
	ld hl, InGameTrade_TrainerString
	ld bc, NAME_LENGTH
	call CopyData
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	call InGameTrade_GetReceivedMonPointer
	ld hl, wTradedEnemyMonOTID
	ld bc, $2
	jp CopyData

; the received mon's index is (partyCount - 1),
; so this adds bc to hl (partyCount - 1) times and moves the result to de
InGameTrade_GetReceivedMonPointer:
	ld a, [wPartyCount]
	dec a
	call AddNTimes
	ld e, l
	ld d, h
	ret

InGameTrade_FlagActionPredef:
	ld hl, wCompletedInGameTradeFlags
	ld a, [wWhichTrade]
	ld c, a
	predef_jump FlagActionPredef

InGameTrade_CheckForTradeEvo:
	ld a, [wInGameTradeReceiveMonSpecies]
	cp KADABRA
	jr z, .tradeEvo
	cp GRAVELER
	jr z, .tradeEvo
	cp MACHOKE
	jr z, .tradeEvo
	cp HAUNTER
	jr z, .tradeEvo
	ret

.tradeEvo
	ld a, [wPartyCount]
	dec a
	ld [wWhichPokemon], a
	ld a, $1
	ld [wForceEvolution], a
	ld a, LINK_STATE_TRADING
	ld [wLinkState], a
	callfar TryEvolvingMon
	xor a ; LINK_STATE_NONE
	ld [wLinkState], a
	jp PlayDefaultMusic

InGameTrade_TrainerString:
	db "<TRAINER>@@@@@@@@@@"

InGameTradeTextPointers:
; entries correspond to TRADE_DIALOGSET_* constants
	dw TradeTextPointers1
	dw TradeTextPointers2
	dw TradeTextPointers3
	dw TradeTextPointersTremor
	dw TradeTextPointersMiles
	dw TradeTextPointersPtera
	dw TradeTextPointersSpore
	dw TradeTextPointersLola
	dw TradeTextPointersBasalt
	dw TradeTextPointersMoby
	dw TradeTextPointersDux

TradeTextPointers1:
	dw WannaTrade1Text
	dw NoTrade1Text
	dw WrongMon1Text
	dw Thanks1Text
	dw AfterTrade1Text

TradeTextPointers2:
	dw WannaTrade2Text
	dw NoTrade2Text
	dw WrongMon2Text
	dw Thanks2Text
	dw AfterTrade2Text

TradeTextPointers3:
	dw WannaTrade3Text
	dw NoTrade3Text
	dw WrongMon3Text
	dw Thanks3Text
	dw AfterTrade3Text

TradeTextPointersTremor:
	dw WannaTradeTremorText
	dw NoTradeTremorText
	dw WrongMonTremorText
	dw ThanksTremorText
	dw AfterTradeTremorText

TradeTextPointersMiles:
	dw WannaTradeMilesText
	dw NoTradeMilesText
	dw WrongMonMilesText
	dw ThanksMilesText
	dw AfterTradeMilesText

TradeTextPointersPtera:
	dw WannaTradePteraText
	dw NoTradePteraText
	dw WrongMonPteraText
	dw ThanksPteraText
	dw AfterTradePteraText

TradeTextPointersSpore:
	dw WannaTradeSporeText
	dw NoTradeSporeText
	dw WrongMonSporeText
	dw ThanksSporeText
	dw AfterTradeSporeText

TradeTextPointersLola:
	dw WannaTradeLolaText
	dw NoTradeLolaText
	dw WrongMonLolaText
	dw ThanksLolaText
	dw AfterTradeLolaText

TradeTextPointersBasalt:
	dw WannaTradeBasaltText
	dw NoTradeBasaltText
	dw WrongMonBasaltText
	dw ThanksBasaltText
	dw AfterTradeBasaltText

TradeTextPointersMoby:
	dw WannaTradeMobyText
	dw NoTradeMobyText
	dw WrongMonMobyText
	dw ThanksMobyText
	dw AfterTradeMobyText

TradeTextPointersDux:
	dw WannaTradeDuxText
	dw NoTradeDuxText
	dw WrongMonDuxText
	dw ThanksDuxText
	dw AfterTradeDuxText

ConnectCableText:
	text_far _ConnectCableText
	text_end

TradedForText:
	text_far _TradedForText
	sound_get_key_item
	text_pause
	text_end

WannaTrade1Text:
	text_far _WannaTrade1Text
	text_end

NoTrade1Text:
	text_far _NoTrade1Text
	text_end

WrongMon1Text:
	text_far _WrongMon1Text
	text_end

Thanks1Text:
	text_far _Thanks1Text
	text_end

AfterTrade1Text:
	text_far _AfterTrade1Text
	text_end

WannaTrade2Text:
	text_far _WannaTrade2Text
	text_end

NoTrade2Text:
	text_far _NoTrade2Text
	text_end

WrongMon2Text:
	text_far _WrongMon2Text
	text_end

Thanks2Text:
	text_far _Thanks2Text
	text_end

AfterTrade2Text:
	text_far _AfterTrade2Text
	text_end

WannaTrade3Text:
	text_far _WannaTrade3Text
	text_end

NoTrade3Text:
	text_far _NoTrade3Text
	text_end

WrongMon3Text:
	text_far _WrongMon3Text
	text_end

Thanks3Text:
	text_far _Thanks3Text
	text_end

AfterTrade3Text:
	text_far _AfterTrade3Text
	text_end

WannaTradeTremorText:
	text_far _WannaTradeTremorText
	text_end

NoTradeTremorText:
	text_far _NoTradeTremorText
	text_end

WrongMonTremorText:
	text_far _WrongMonTremorText
	text_end

ThanksTremorText:
	text_far _ThanksTremorText
	text_end

AfterTradeTremorText:
	text_far _AfterTradeTremorText
	text_end

WannaTradeMilesText:
	text_far _WannaTradeMilesText
	text_end

NoTradeMilesText:
	text_far _NoTradeMilesText
	text_end

WrongMonMilesText:
	text_far _WrongMonMilesText
	text_end

ThanksMilesText:
	text_far _ThanksMilesText
	text_end

AfterTradeMilesText:
	text_far _AfterTradeMilesText
	text_end

WannaTradePteraText:
	text_far _WannaTradePteraText
	text_end

NoTradePteraText:
	text_far _NoTradePteraText
	text_end

WrongMonPteraText:
	text_far _WrongMonPteraText
	text_end

ThanksPteraText:
	text_far _ThanksPteraText
	text_end

AfterTradePteraText:
	text_far _AfterTradePteraText
	text_end

WannaTradeSporeText:
	text_far _WannaTradeSporeText
	text_end

NoTradeSporeText:
	text_far _NoTradeSporeText
	text_end

WrongMonSporeText:
	text_far _WrongMonSporeText
	text_end

ThanksSporeText:
	text_far _ThanksSporeText
	text_end

AfterTradeSporeText:
	text_far _AfterTradeSporeText
	text_end

WannaTradeLolaText:
	text_far _WannaTradeLolaText
	text_end

NoTradeLolaText:
	text_far _NoTradeLolaText
	text_end

WrongMonLolaText:
	text_far _WrongMonLolaText
	text_end

ThanksLolaText:
	text_far _ThanksLolaText
	text_end

AfterTradeLolaText:
	text_far _AfterTradeLolaText
	text_end

WannaTradeBasaltText:
	text_far _WannaTradeBasaltText
	text_end

NoTradeBasaltText:
	text_far _NoTradeBasaltText
	text_end

WrongMonBasaltText:
	text_far _WrongMonBasaltText
	text_end

ThanksBasaltText:
	text_far _ThanksBasaltText
	text_end

AfterTradeBasaltText:
	text_far _AfterTradeBasaltText
	text_end

WannaTradeMobyText:
	text_far _WannaTradeMobyText
	text_end

NoTradeMobyText:
	text_far _NoTradeMobyText
	text_end

WrongMonMobyText:
	text_far _WrongMonMobyText
	text_end

ThanksMobyText:
	text_far _ThanksMobyText
	text_end

AfterTradeMobyText:
	text_far _AfterTradeMobyText
	text_end

WannaTradeDuxText:
	text_far _WannaTradeDuxText
	text_end

NoTradeDuxText:
	text_far _NoTradeDuxText
	text_end

WrongMonDuxText:
	text_far _WrongMonDuxText
	text_end

ThanksDuxText:
	text_far _ThanksDuxText
	text_end

AfterTradeDuxText:
	text_far _AfterTradeDuxText
	text_end
