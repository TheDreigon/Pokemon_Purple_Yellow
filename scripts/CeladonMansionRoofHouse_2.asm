; v0.7 — PURPLE the PROGRAMMER (Celadon Mansion roof house).
; The roof-house dev quizzes the player on THIS hack's canon (8
; questions, 3-way menus); a perfect score unlocks the prototype
; PORYGON L20 stored in the desk BALL (vanilla Eevee-ball plumbing
; reused: HideObject persists the one-shot).

RoofHouseProgrammerScript::
	CheckEvent EVENT_GOT_ROOF_PORYGON
	jr z, .not_done
	ld hl, .AfterGiftText
	jp PrintText
.not_done
	CheckEvent EVENT_BEAT_PURPLES_QUIZ
	jr z, .quiz
	ld hl, .GoTakeBallText
	jp PrintText
.quiz
	ld hl, .IntroText
	call PrintText
	call RoofQuizRun
	and a
	jr z, .perfect
	cp 3
	jr c, .close
	ld hl, .FailText
	jp PrintText
.close
	ld hl, .CloseText
	jp PrintText
.perfect
	SetEvent EVENT_BEAT_PURPLES_QUIZ
	ld hl, .PerfectText
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

.GoTakeBallText:
	text_far _RoofHouseGoTakeBallText
	text_end

.AfterGiftText:
	text_far _RoofHouseAfterGiftText
	text_end

; runs all 8 questions; returns a = number of wrong answers (0-8)
RoofQuizRun::
	lb bc, 8, 0 ; b = questions left, c = errors
.loop
	ld a, 8
	sub b ; question index 0-7
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

; a = question index (0-7); returns carry set if answered wrong
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
; menu shell (same hygiene as the Bill quiz: stale
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
	db 1
	dw .Q2Text, .Q2A, .Q2B, .Q2C
	db 2
	dw .Q3Text, .Q3A, .Q3B, .Q3C
	db 0
	dw .Q4Text, .Q4A, .Q4B, .Q4C
	db 1
	dw .Q5Text, .Q5A, .Q5B, .Q5C
	db 2
	dw .Q6Text, .Q6A, .Q6B, .Q6C
	db 0
	dw .Q7Text, .Q7A, .Q7B, .Q7C
	db 1
	dw .Q8Text, .Q8A, .Q8B, .Q8C
	db 2

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
	db "L42@"
.Q4C:
	db "MUST BE TRADED!@"
.Q5A:
	db "WATER/FLYING@"
.Q5B:
	db "WATER/DARK@"
.Q5C:
	db "WATER/DRAGON@"
.Q6A:
	db "MOON STONE@"
.Q6B:
	db "FIRE STONE@"
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

RoofHousePrototypeBallScript::
	CheckEvent EVENT_BEAT_PURPLES_QUIZ
	jr nz, .unlocked
	ld hl, .LockedText
	jp PrintText
.unlocked
	ld hl, .OpenText
	call PrintText
	lb bc, PORYGON, 20
	call GivePokemon
	ret nc ; no room: engine printed its message, ball stays for retry
	SetEvent EVENT_GOT_ROOF_PORYGON
	ld a, HS_CELADON_MANSION_PORYGON_GIFT
	ld [wMissableObjectIndex], a
	predef HideObject
	ret

.LockedText:
	text_far _RoofHousePrototypeBallLockedText
	text_end

.OpenText:
	text_far _RoofHousePrototypeBallOpenText
	text_end
