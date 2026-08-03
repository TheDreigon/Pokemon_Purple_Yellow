SummerBeachHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

SummerBeachHouse_TextPointers:
	def_text_pointers
	dw_const SummerBeachHouseSurfinDudeText, TEXT_SUMMERBEACHHOUSE_SURFINDUDE
	dw_const SummerBeachHousePikachuText,    TEXT_SUMMERBEACHHOUSE_PIKACHU
	dw_const SummerBeachHousePoster1Text,    TEXT_SUMMERBEACHHOUSE_POSTER1
	dw_const SummerBeachHousePoster2Text,    TEXT_SUMMERBEACHHOUSE_POSTER2
	dw_const SummerBeachHousePoster3Text,    TEXT_SUMMERBEACHHOUSE_POSTER3
	dw_const SummerBeachHouseScoreBoardText, TEXT_SUMMERBEACHHOUSE_SCOREBOARD

SummerBeachHouseSurfinDudeText:
	text_asm
	ld a, [wd472]
	vc_patch Bypass_need_Pikachu_with_Surf_for_minigame
IF DEF (_YELLOW_VC)
	bit 7, a
ELSE
	bit 6, a
ENDC
	vc_patch_end
	jr nz, .next
	ld hl, .SurfinDudeText4
	call PrintText
	jr .done
.next
	ld hl, wd492
	bit 0, [hl]
	set 0, [hl]
	jr nz, .next2
	ld hl, .SurfinDudeText1
	jr .next3
.next2
	ld hl, .SurfinDudeText3
.next3
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_f226b
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	farcall SurfingPikachuMinigame
	ld hl, wd492
	set 1, [hl]
	jr .done
.asm_f226b
	ld hl, .SurfinDudeText2
	call PrintText
.done
	jp TextScriptEnd

.SurfinDudeText1
	text_far _SummerBeachHouseSurfinDudeText1
	text_end
.SurfinDudeText2
	text_far _SummerBeachHouseSurfinDudeText2
	text_end
.SurfinDudeText3
	text_far _SummerBeachHouseSurfinDudeText3
	text_end
.SurfinDudeText4
	text_far _SummerBeachHouseSurfinDudeText4
	text_end

SummerBeachHousePikachuText:
	text_asm
	ld hl, .SummerBeachHousePikachuText
	call PrintText
	ld a, PIKACHU
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.SummerBeachHousePikachuText
	text_far _SummerBeachHousePikachuText
	text_end

SummerBeachHousePoster1Text:
	text_asm
	ld hl, .SummerBeachHousePoster1Text2
	ld a, [wd472]
	bit 6, a
	jr z, .next
	ld hl, .SummerBeachHousePoster1Text1
.next
	call PrintText
	jp TextScriptEnd

.SummerBeachHousePoster1Text1
	text_far _SummerBeachHousePoster1Text1
	text_end
.SummerBeachHousePoster1Text2
	text_far _SummerBeachHousePoster1Text2
	text_end

SummerBeachHousePoster2Text:
	text_asm
	ld hl, .SummerBeachHousePoster2Text2
	ld a, [wd472]
	bit 6, a
	jr z, .next
	ld hl, .SummerBeachHousePoster2Text1
.next
	call PrintText
	jp TextScriptEnd

.SummerBeachHousePoster2Text1
	text_far _SummerBeachHousePoster2Text1
	text_end
.SummerBeachHousePoster2Text2
	text_far _SummerBeachHousePoster2Text2
	text_end

SummerBeachHousePoster3Text:
	text_asm
	ld hl, .SummerBeachHousePoster3Text2
	ld a, [wd472]
	bit 6, a
	jr z, .next
	ld hl, .SummerBeachHousePoster3Text1
.next
	call PrintText
	jp TextScriptEnd

.SummerBeachHousePoster3Text1
	text_far _SummerBeachHousePoster3Text1
	text_end
.SummerBeachHousePoster3Text2
	text_far _SummerBeachHousePoster3Text2
	text_end

; The board on the wall that carries PIKACHU'S BEACH's hi-score.
;
; v0.7: this was a Game Boy Printer, and the board was its consolation prize -
; answering "no" to "PRINT it out?" drew the hi-score screen and waited for a
; button. With the printer gone the prompt goes too and the board is simply
; read, so the object is a SCOREBOARD now rather than a printer.
SummerBeachHouseScoreBoardText:
	text_asm
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, [wd472]
	vc_patch Bypass_need_Pikachu_with_Surf_for_high_score
IF DEF(_YELLOW_VC)
	bit 7, a
ELSE
	bit 6, a
ENDC
	vc_patch_end
	jr z, .cannot_surf

	ld hl, wd492
	bit 1, [hl]
	jr z, .no_score_yet
	ld a, 0
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
.no_score_yet
	ld hl, .ScoreBoardText2
	call PrintText
	ld a, [wd492]
	bit 1, a
	jr z, .done

	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .ScoreBoardText3
	call PrintText
	call SaveScreenTilesToBuffer2
	ld hl, wd730
	set 6, [hl]
	xor a
	ld [wUpdateSpritesEnabled], a
	callfar DisplaySurfingMinigameHighScore
	call WaitForTextScrollButtonPress
	ld hl, wd730
	res 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ReloadTilesetTilePatterns
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call GBPalNormal
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	jr .done
.cannot_surf
	ld hl, .ScoreBoardText1
	call PrintText
.done
	jp TextScriptEnd

.ScoreBoardText1
	text_far _SummerBeachHouseScoreBoardText1
	text_waitbutton
	text_end

.ScoreBoardText2
	text_far _SummerBeachHouseScoreBoardText2
	text_waitbutton
	text_end

.ScoreBoardText3
	text_far _SummerBeachHouseScoreBoardText3
	text_end
