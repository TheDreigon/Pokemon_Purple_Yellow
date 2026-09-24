; v1.0 (2026-09-24, Forte): RUN in a trainer battle = an offer to give the
; match up. Returns carry set when the player took it: the palette is black,
; the forfeit text was printed and wBattleResult is BATTLE_RESULT_LOSE with
; the SURRENDERED bit on; TryRunningFromBattle's caller then ends the battle
; through `ret c` exactly as a wild escape does, and PartyStandsAfterBattle
; below turns it into the blackout. Carry clear = back to the battle menu
; with the turn unspent (wActionResultOrTookBattleTurn untouched).
; Never in OAK's LAB: that battle never blacks out (home/overworld.asm
; .battleOccurred), so a surrender there would end the fight for free.
TrainerBattleSurrenderPrompt::
	ld a, [wCurMap]
	cp OAKS_LAB
	jr z, .noRunning
	ld hl, .PromptText
	call PrintText
	xor a
	ld [wTwoOptionMenuID], a ; YES_NO_MENU
	ld [wMenuJoypadPollCount], a ; menu hygiene: a stale poll count would answer by itself
	hlcoord 0, 7 ; where "Will <PLAYER> change #MON?" puts its YES/NO
	lb bc, 8, 1
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, [wCurrentMenuItem]
	and a ; 0 = YES; B lands on 1 like NO
	jr nz, .stay
; the player gave up: a defeat, flagged for the overworld
	ld a, BATTLE_RESULT_LOSE | (1 << BATTLE_RESULT_SURRENDERED_F)
	ld [wBattleResult], a
; the tail of HandlePlayerBlackOut (core.asm .notRival1Battle), minus the
; "out of useable #MON" line that would be a lie here
	ld b, SET_PAL_BATTLE_BLACK
	call RunPaletteCommand
	ld hl, .ForfeitedText
	call PrintText
	ld hl, wd732
	res 5, [hl] ; no longer forced onto the bike
	call ClearScreen
	scf
	ret
.noRunning
	ld hl, .NoRunningText
	call PrintText
.stay
	and a ; carry clear: DisplayBattleMenu redraws the menu
	ret

.PromptText:
	text_far _SurrenderPromptText
	text_end

.ForfeitedText:
	text_far _SurrenderForfeitedText
	text_end

.NoRunningText: ; moved here from Battle Core with the RUN-against-a-trainer path
	text_far _NoRunningText
	text_end

; The overworld's post-battle check (home/overworld.asm .battleOccurred).
; d = 0 when the player blacks out: the whole party is down, or the trainer
; battle was given up. The bit lives in wBattleResult, which nothing zeroes
; between the prompt and this read (EndOfBattle only reads it); the blackout's
; ResetStatusAndHalveMoneyOnBlackout then zeroes the byte, and
; InitBattleVariables zeroes it again at the next battle.
PartyStandsAfterBattle::
	ld a, [wBattleResult]
	bit BATTLE_RESULT_SURRENDERED_F, a
	ld d, 0
	ret nz
	farjp AnyPartyAlive ; Battle Core; d = 0 when every party mon has 0 HP
