; PURPLE the PROGRAMMER (Celadon Mansion roof house).
; The roof-house dev quizzes the player on THIS hack's canon (10
; questions, 3-way menus). v1.0 (2026-09-22, Forte): a perfect score earns
; PURPLE'S PATCH - he brings out one party #MON's full potential: every DV
; to 15 ($FF $FF; the Special DV feeds SP.ATK and SP.DEF, and the HP DV is
; derived from the other four, so all six stats), its stats recalculated
; from its own stat exp. Two credits, each its own flag: the quiz prize, and
; a bonus once the player is CHAMPION. A player can hold both at once (the
; prize never used, or PURPLE first met as CHAMPION): then both are offered
; in the same talk. No rush: B or NO ends the talk and every credit stays.
; The PORYGON his desk used to hold is SILPH's now (their 5F worker).

RoofHouseProgrammerScript::
; the screen the patch's party menu returns to, saved before the quiz can draw
; its answer box (a save taken after a 10/10 would bring question 10 back)
	call SaveScreenTilesToBuffer2
	CheckEvent EVENT_BEAT_PURPLES_QUIZ
	jr nz, .quizDone
	ld hl, .IntroText
	call PrintText
	call RoofQuizRun
	and a
	jr z, .perfect
	cp 4
	jr c, .close
	ld hl, .FailText
	jp PrintText
.close
	ld hl, .CloseText
	jp PrintText
.perfect
	SetEvent EVENT_BEAT_PURPLES_QUIZ
	ld hl, .PerfectText
	call PrintText
	call RoofHouseCredits
	cp 2
	ld hl, .PrizeOneText
	jr c, .offer
	ld hl, .AlsoChampionText ; first met as CHAMPION: the prize and the bonus
	call PrintText
	ld hl, .PrizeTwoText
	jr .offer
.quizDone
	call RoofHouseCredits
	and a
	jr z, .noCredits
	cp 2
	jr z, .championTwo
	CheckEvent EVENT_USED_PURPLES_PATCH
	ld hl, .OfferText ; the prize still waiting, before the League
	jr z, .offer
	ld hl, .ChampionGreetText ; the prize spent: the bonus
	call PrintText
	ld hl, .BonusText
	jr .offer
.championTwo
	ld hl, .ChampionGreetText ; CHAMPION with the prize never used: both
	call PrintText
	ld hl, .PrizeTwoText
.offer
	call PrintText
	ld hl, .NoRushText
	call PrintText
.patchLoop
	call RoofHousePatch
	ret nc ; backed out, or picked one already at 15s: the credits stay
	CheckEvent EVENT_USED_PURPLES_PATCH ; the prize is spent first
	jr nz, .spendBonus
	SetEvent EVENT_USED_PURPLES_PATCH
	jr .spent
.spendBonus
	SetEvent EVENT_USED_PURPLES_CHAMPION_PATCH
.spent
	call RoofHouseCredits
	and a
	ret z
	ld hl, .NextText
	call PrintText
	jr .patchLoop
.noCredits
	ld a, [wGameStage] ; the beat-the-League flag (scripts/HallOfFame.asm)
	and a
	ld hl, .AfterPatchText
	jp z, PrintText
	ld hl, .AfterChampionText
	jp PrintText

.IntroText:
	text_far _RoofHouseProgrammerIntroText
	text_end

.PerfectText:
	text_far _RoofQuizPerfectText
	text_end

.CloseText:
	text_far _RoofQuizCloseText
	text_end

.FailText:
	text_far _RoofQuizFailText
	text_end

.PrizeOneText:
	text_far _RoofHousePrizeOneText
	text_end

.AlsoChampionText:
	text_far _RoofHouseAlsoChampionText
	text_end

.PrizeTwoText:
	text_far _RoofHousePrizeTwoText
	text_end

.OfferText:
	text_far _RoofHousePatchOfferText
	text_end

.ChampionGreetText:
	text_far _RoofHouseChampionGreetText
	text_end

.BonusText:
	text_far _RoofHouseBonusText
	text_end

.NoRushText:
	text_far _RoofHouseNoRushText
	text_end

.NextText:
	text_far _RoofHouseNextText
	text_end

.AfterPatchText:
	text_far _RoofHouseAfterPatchText
	text_end

.AfterChampionText:
	text_far _RoofHouseAfterChampionText
	text_end

RoofHouseCredits:
; a = the patches the player can still take, 0-2 (meaningful once the quiz is
; beaten). The prize: EVENT_USED_PURPLES_PATCH clear. The bonus: the League
; beaten (wGameStage) and EVENT_USED_PURPLES_CHAMPION_PATCH clear.
	ld c, 0
	CheckEvent EVENT_USED_PURPLES_PATCH
	jr nz, .bonus
	inc c
.bonus
	ld a, [wGameStage]
	and a
	jr z, .done
	CheckEvent EVENT_USED_PURPLES_CHAMPION_PATCH
	jr nz, .done
	inc c
.done
	ld a, c
	ret

RoofHousePatch:
; PURPLE'S PATCH on the party #MON the player picks. Carry set if it was
; done; clear if the player backed out (B, or NO) or picked one that is
; already at 15s - in every one of those cases the offer stays open.
; The caller saved the screen to buffer 2 (RoofHouseProgrammerScript).
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	jr c, .thinkItOver
	call .monStruct
	ld bc, wPartyMon1DVs - wPartyMon1
	add hl, bc
	ld a, [hli]
	and [hl]
	inc a
	jr nz, .notYetPerfect
; already at its full potential. The partner PIKACHU came that way: it is the
; one carrying LIGHT_BALL_GSC in its catch-rate byte (the engine's own partner
; marker, see IsThisPartymonStarterPikachu) - a caught PIKACHU at 15s gets the
; plain line
	call .monStruct
	ld a, [hl]
	cp STARTER_PIKACHU
	jr nz, .notPartner
	ld bc, wPartyMon1CatchRate - wPartyMon1
	add hl, bc
	ld a, [hl]
	cp LIGHT_BALL_GSC
	ld hl, .PikachuText
	jr z, .refuse
.notPartner
	ld hl, .AlreadyText
.refuse
	push hl
	call .restoreScreen
	pop hl
	call PrintText
	and a
	ret
.notYetPerfect
	call GetPartyMonName2 ; wcd6d = its nickname
	ld hl, .ConfirmText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .thinkItOver
	call .apply
; the gains, then the new totals - the RARE CANDY screens, over the party,
; redrawn first so every row shows the new HP (it runs LoadMonData per slot,
; hence the LoadMonData after it)
	call RedrawPartyMenu
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	ld hl, .CameOutText
	call PrintText
	ld hl, wd730
	set 6, [hl] ; the two stat boxes appear at once, as on the STATS page (a text
	            ; script types letter by letter otherwise)
	ld d, $2
	callfar PrintStatsBox
	call WaitForTextScrollButtonPress
	ld d, $1
	callfar PrintStatsBox
	ld hl, wd730
	res 6, [hl]
	call WaitForTextScrollButtonPress
	call .restoreScreen
	ld hl, .DoneText
	call PrintText
	scf
	ret

.thinkItOver
	call .restoreScreen
	ld hl, .ThinkItOverText
	call PrintText
	and a
	ret

.restoreScreen
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	ret

.monStruct
; hl = the struct of party #MON [wWhichPokemon]
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1
	ld bc, wPartyMon2 - wPartyMon1
	jp AddNTimes

.apply
	call .monStruct
	push hl
; keep the stats it had, for the gains window (PrintStatGainsBox reads them)
	ld bc, wPartyMon1Stats - wPartyMon1
	add hl, bc
	ld de, wLevelUpStatGains
	ld bc, wPartyMon1StatsEnd - wPartyMon1Stats
	call CopyData
	pop hl
	push hl
; every DV to 15
	ld bc, wPartyMon1DVs - wPartyMon1
	add hl, bc
	ld a, $ff
	ld [hli], a
	ld [hl], a
	pop hl
	push hl
; CalcStats reads the species' base stats (the header) and wCurEnemyLVL
	ld a, [hl] ; species
	ld [wd0b5], a
	call GetMonHeader
	pop hl
	push hl
	ld bc, wPartyMon1Level - wPartyMon1
	add hl, bc
	ld a, [hl]
	ld [wCurEnemyLVL], a
	pop hl
	push hl
	ld bc, wPartyMon1Stats - wPartyMon1
	add hl, bc
	ld d, h
	ld e, l ; de = its stats block
	pop hl
	push hl
	ld bc, (wPartyMon1Exp + 2) - wPartyMon1
	add hl, bc ; the byte before its stat exp, where CalcStats expects hl
	ld b, 1 ; with its stat exp
	call CalcStats
	pop hl
; current HP rises by what max HP gained - unless it has fainted
	push hl
	ld bc, wPartyMon1HP - wPartyMon1
	add hl, bc
	ld a, [hli]
	or [hl]
	pop hl
	ret z
	ld bc, (wPartyMon1MaxHP + 1) - wPartyMon1
	add hl, bc ; LSB of the new max HP
	ld a, [wLevelUpStatGains + 1] ; LSB of the old one
	ld c, a
	ld a, [hld]
	sub c
	ld c, a
	ld a, [wLevelUpStatGains] ; MSB of the old one
	ld b, a
	ld a, [hl]
	sbc b
	ld b, a ; bc = max HP gained
	ld de, (wPartyMon1HP + 1) - wPartyMon1MaxHP
	add hl, de ; LSB of the current HP
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	ret

.PikachuText:
	text_far _RoofHousePatchPikachuText
	text_end

.AlreadyText:
	text_far _RoofHousePatchAlreadyText
	text_end

.ConfirmText:
	text_far _RoofHousePatchConfirmText
	text_end

.CameOutText:
	text_far _RoofHousePatchCameOutText
	text_end

.DoneText:
	text_far _RoofHousePatchDoneText
	text_end

.ThinkItOverText:
	text_far _RoofHousePatchThinkItOverText
	text_end

; runs all 10 questions; returns a = number of wrong answers (0-10)
RoofQuizRun::
	lb bc, 10, 0 ; b = questions left, c = errors
.loop
	ld a, 10
	sub b ; question index 0-9
	push bc
	call RoofQuizAskQuestion
	pop bc
	jr nc, .right
	inc c
.right
	dec b
	jr nz, .loop
	ld a, c
	ret

; a = question index (0-9); returns carry set if answered wrong
RoofQuizAskQuestion::
	ld l, a
	ld h, 0
	ld e, l
	ld d, h
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de ; index * 9
	ld de, RoofQuizTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl ; -> option pointers
	ld hl, wd730
	set 6, [hl] ; instant text: the menu takes input right after
	ld l, e
	ld h, d
	call PrintText
; menu shell (same hygiene as Bill's stone menu: stale
; wMenuWatchMovingOutOfBounds would let a d-pad press answer)
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wMenuJoypadPollCount], a ; stale 1 (cable club) would auto-answer
	ld a, A_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	hlcoord 0, 0
	ld b, 6
	ld c, 18
	call TextBoxBorder
	call UpdateSprites
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	hlcoord 2, 2
	call PlaceString
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	hlcoord 2, 4
	call PlaceString
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	hlcoord 2, 6
	call PlaceString
	pop hl
	ld c, [hl] ; correct option index
	push bc
	ld hl, wd730
	res 6, [hl]
	call HandleMenuInput
	pop bc
	ld a, [wCurrentMenuItem]
	cp c
	jr z, .right
	scf
	ret
.right
	and a
	ret

; 9 bytes per entry: dw question wrapper, dw option x3, db correct
RoofQuizTable::
	dw .Q1Text, .Q1A, .Q1B, .Q1C
	db 0 ; VILEPLUME went GRASS/FUNGUS -> GRASS/POISON, so the key moved B -> A
	dw .Q2Text, .Q2A, .Q2B, .Q2C
	db 2
	dw .Q3Text, .Q3A, .Q3B, .Q3C
	db 0
	dw .Q4Text, .Q4A, .Q4B, .Q4C
	db 2
	dw .Q5Text, .Q5A, .Q5B, .Q5C
	db 0
	dw .Q6Text, .Q6A, .Q6B, .Q6C
	db 1
	dw .Q7Text, .Q7A, .Q7B, .Q7C
	db 1
	dw .Q8Text, .Q8A, .Q8B, .Q8C
	db 2
	dw .Q9Text, .Q9A, .Q9B, .Q9C
	db 0
	dw .Q10Text, .Q10A, .Q10B, .Q10C
	db 1

.Q1Text:
	text_far _RoofQuizQ1Text
	text_end
.Q2Text:
	text_far _RoofQuizQ2Text
	text_end
.Q3Text:
	text_far _RoofQuizQ3Text
	text_end
.Q4Text:
	text_far _RoofQuizQ4Text
	text_end
.Q5Text:
	text_far _RoofQuizQ5Text
	text_end
.Q6Text:
	text_far _RoofQuizQ6Text
	text_end
.Q7Text:
	text_far _RoofQuizQ7Text
	text_end
.Q8Text:
	text_far _RoofQuizQ8Text
	text_end
.Q9Text:
	text_far _RoofQuizQ9Text
	text_end
.Q10Text:
	text_far _RoofQuizQ10Text
	text_end

.Q1A:
	db "GRASS/POISON@"
.Q1B:
	db "GRASS/FUNGUS@"
.Q1C:
	db "GRASS/DARK@"
.Q2A:
	db "WATER STONE@"
.Q2B:
	db "THUNDER STONE@"
.Q2C:
	db "MOON STONE@"
.Q3A:
	db "8.8m@"
.Q3B:
	db "6.4m@"
.Q3C:
	db "12.2m@"
.Q4A:
	db "L36@"
.Q4B:
	db "MUST BE TRADED!@"
.Q4C:
	db "L42@"
.Q5A:
	db "WATER/DRAGON@"
.Q5B:
	db "WATER/FLYING@"
.Q5C:
	db "WATER/DARK@"
.Q6A:
	db "FIRE STONE@"
.Q6B:
	db "MOON STONE@"
.Q6C:
	db "LEAF STONE@"
.Q7A:
	db "POLIWAG's@"
.Q7B:
	db "MEW's@"
.Q7C:
	db "GRIMER's@"
.Q8A:
	db "CYCLING ROAD@"
.Q8B:
	db "ROUTE 23@"
.Q8C:
	db "THE SAFARI ZONE@"
.Q9A:
	db "DRAGON@"
.Q9B:
	db "STEEL@"
.Q9C:
	db "FIRE@"
.Q10A:
	db "NORMAL/PSYCHIC@"
.Q10B:
	db "NORMAL/DARK@"
.Q10C:
	db "NORMAL/GHOST@"

