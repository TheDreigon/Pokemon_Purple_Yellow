; v0.7: the TRAINER MANUAL -- phase 2, the shell.
;
; The key item the player's mother hands over on the way out of Pallet opens
; this. USE on the manual comes straight here (ItemUseTrainerManual, in
; engine/items/item_effects.asm) and the bag redraws itself underneath on the
; way back out, so nothing has to be saved or restored except the three
; variables the bag keeps its own place in.
;
; THE SHAPE, and why it is this one:
;
; * ONE COLUMN. Every navigation bug playtesting has found in this project --
;   the two on the Celadon information desk, the Bill quiz, the Purple quiz --
;   was a list with a second cursor beside it. The Trainer School blackboard is
;   two columns; this deliberately is not.
; * NO SUB-MENU INSIDE A CHAPTER. Chapter 5 has nine sections, and a list of
;   them would be that same second cursor one screen deeper. They are pages
;   instead: one button forward, one back, one out.
; * DRAWN WITH TextBoxBorder, not in the POKéDEX's style. The manual is opened
;   from the BAG, which already has the text-box tile patterns loaded, so there
;   is no swap to get wrong -- unlike the MOVEDEX, which has to trade tile sets
;   with the card it opens.
;
; Phase 2 is the shell: the chapter and page structure is final and every page
; holds a stub where its text will go. Phase 3 replaces the strings behind
; TrainerManualChapter*Pages and touches nothing here.

DEF MANUAL_NUM_CHAPTERS EQU 7
; The contents list starts far enough down that its eight rows sit centred in
; the box: two blank rows above, three below.
DEF MANUAL_LIST_TOP_Y EQU 6
; A page's text starts here, leaving the chapter name on row 1 and a blank row
; under it. Rows 3 to 15 are the text, row 16 carries the page count.
DEF MANUAL_TEXT_TOP_Y EQU 3
DEF MANUAL_PAGE_ROWS EQU 13

ShowTrainerManual::
; The bag keeps its scroll position in wListScrollOffset and its cursor in
; wCurrentMenuItem, and DisplayListMenuID resets neither. Borrow them and give
; them back -- the same courtesy the MOVEDEX does the POKéDEX.
	ld a, [wListScrollOffset]
	push af
	ld a, [wCurrentMenuItem]
	push af
	ld a, [wLastMenuItem]
	push af

	call TrainerManual_Contents

	pop af
	ld [wLastMenuItem], a
	pop af
	ld [wCurrentMenuItem], a
	pop af
	ld [wListScrollOffset], a
	ret

TrainerManual_Contents:
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
.redraw
	call TrainerManual_DrawContents
.loop
	ld hl, wTopMenuItemY
	ld a, MANUAL_LIST_TOP_Y
	ld [hli], a
	ld a, 1
	ld [hli], a ; top menu item X: one column in, just inside the border
	inc hl      ; wCurrentMenuItem, left where the player put it
	inc hl      ; wTileBehindCursor
	ld a, MANUAL_NUM_CHAPTERS ; seven chapters and CLOSE, ids 0 to 7
	ld [hli], a
	ld [hl], A_BUTTON | B_BUTTON
; A fixed list that never scrolls, so let HandleMenuInput wrap top to bottom
; itself. This is also why UP and DOWN are not watched: a watched direction is
; handed back to the caller as well as moving the cursor, which is what made the
; MOVEDEX step two entries at a time.
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
; hUILayoutFlags bit 1 walks the cursor down consecutive rows instead of every
; other one (home/window.asm:144-148). That is what lets eight entries fit with
; room left for a title; the battle FIGHT menu uses the same flag for its four
; move names.
	ld hl, hUILayoutFlags
	set 1, [hl]
	call HandleMenuInput
	ld b, a ; the answer is in a and the two lines below clobber it
	ld hl, hUILayoutFlags
	res 1, [hl]
	ld a, b

	bit BIT_B_BUTTON, a
	jr nz, .close
	ld a, [wCurrentMenuItem]
	cp MANUAL_NUM_CHAPTERS ; the eighth row is CLOSE
	jr z, .close
	call TrainerManual_ShowChapter
	jr .redraw
.close
	jp TrainerManual_WaitRelease

TrainerManual_DrawContents:
	xor a
	ldh [hAutoBGTransferEnabled], a
	call TrainerManual_DrawFrame
	hlcoord 1, 1
	ld de, TrainerManualTitleText
	call TrainerManual_PlaceCentered
; The chapter names are read out of the same table the page header reads, so the
; contents and the top of a chapter cannot drift into disagreeing about what a
; chapter is called.
	hlcoord 2, MANUAL_LIST_TOP_Y
	ld c, 0
.chapterLoop
	push hl
	ld a, c
	call TrainerManual_GetChapterName
	pop hl
	push bc ; PlaceString reports its end position in bc and eats the counter
	call PlaceString ; hl comes back where it started
	pop bc
	ld de, SCREEN_WIDTH
	add hl, de
	inc c
	ld a, c
	cp MANUAL_NUM_CHAPTERS
	jr c, .chapterLoop
	ld de, TrainerManualCloseText
	call PlaceString
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

; One box, the whole screen. Interior rows 1 to 16, columns 1 to 18.
TrainerManual_DrawFrame:
	call ClearScreen
	hlcoord 0, 0
	lb bc, 16, 18
	jp TextBoxBorder

; INPUT: a = chapter index, 0 to MANUAL_NUM_CHAPTERS - 1.
TrainerManual_ShowChapter:
	ld c, a
	ld b, 0 ; the page being read, counted from zero
.draw
	push bc
	call TrainerManual_DrawPage
	pop bc
.input
	push bc
	call TrainerManual_WaitInput
	pop bc
	bit BIT_B_BUTTON, a
	jr nz, .done
	bit BIT_D_LEFT, a
	jr nz, .back
	bit BIT_A_BUTTON, a
	jr nz, .readOn
	bit BIT_D_RIGHT, a
	jr z, .input
; RIGHT walks the pages and stops at the last one; A reads on and out of the
; chapter when there is nothing left. Two buttons that agree everywhere except
; the one place where the difference is useful.
	push bc
	call TrainerManual_IsLastPage
	pop bc
	jr z, .input
	inc b
	jr .draw
.readOn
	push bc
	call TrainerManual_IsLastPage
	pop bc
	jr z, .done
	inc b
	jr .draw
.back
	ld a, b
	and a
	jr z, .input ; already at the front of the chapter
	dec b
	jr .draw
.done
	jp TrainerManual_WaitRelease

; INPUT: b = page, c = chapter. OUTPUT: z if b is that chapter's last page.
TrainerManual_IsLastPage:
	ld a, c
	call TrainerManual_GetChapterPages
	ld a, [hl]
	dec a
	cp b
	ret

; INPUT: b = page, c = chapter.
TrainerManual_DrawPage:
	xor a
	ldh [hAutoBGTransferEnabled], a
	push bc
	call TrainerManual_DrawFrame
	pop bc

; the chapter's name, on the row the contents page puts its own title
	push bc
	ld a, c
	call TrainerManual_GetChapterName
	hlcoord 1, 1
	call TrainerManual_PlaceCentered
	pop bc

	push bc
	ld a, c
	call TrainerManual_GetChapterPages
	inc hl ; past the page count
	ld e, b
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Printed at once and single-spaced. hUILayoutFlags bit 2 makes <NEXT> drop one
; row instead of two (home/text.asm:64-68), which is the difference between six
; lines on a page and thirteen.
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	ldh a, [hUILayoutFlags]
	set 2, a
	ldh [hUILayoutFlags], a
	bccoord 1, MANUAL_TEXT_TOP_Y
	call TextCommandProcessor
	ldh a, [hUILayoutFlags]
	res 2, a
	ldh [hUILayoutFlags], a
	xor a
	ldh [hClearLetterPrintingDelayFlags], a
	pop bc

; "n/m" in the bottom right corner. Written as two digit glyphs rather than
; through PrintNumber, which reads its number out of RAM and would want a byte
; of WRAM -- and WRAM is full at 8192/8192. No chapter has ten pages; if one
; ever does, this is the line that has to grow.
	push bc
	ld a, c
	call TrainerManual_GetChapterPages
	ld a, [hl]
	ld d, a
	pop bc
	ld a, b
	add "1" ; the digit glyphs run consecutively up from "0"
	hlcoord 16, 16
	ld [hli], a
	ld a, "/"
	ld [hli], a
	ld a, d
	add "0"
	ld [hl], a

	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

; INPUT: a = chapter index. OUTPUT: de = its name. Preserves bc.
TrainerManual_GetChapterName:
	add a
	ld e, a
	ld d, 0
	ld hl, TrainerManualChapterNames
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, h
	ld e, l
	ret

; INPUT: a = chapter index. OUTPUT: hl = its page block, which is a count
; followed by that many text pointers. Preserves bc.
TrainerManual_GetChapterPages:
	add a
	ld e, a
	ld d, 0
	ld hl, TrainerManualChapterPages
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; INPUT: de = string, hl = the left-hand end of an 18-wide row interior.
TrainerManual_PlaceCentered:
	push hl
	push de
	ld h, d
	ld l, e
	ld c, 0
.measure
	ld a, [hli]
	cp "@"
	jr z, .measured
	cp "#"
	jr nz, .oneTile
	inc c ; "#" is one byte and four tiles of "POKé"
	inc c
	inc c
.oneTile
	inc c
	jr .measure
.measured
	ld a, 18
	sub c
	srl a
	ld c, a
	ld b, 0
	pop de
	pop hl
	add hl, bc
	jp PlaceString

; Wait for a fresh press of one of this screen's buttons; return it in a.
;
; Reading hJoyPressed -- the rising edge -- after first waiting for A and B to
; come back up is the MOVE INFO card's guard, and it is here for the same
; reason: the press that opened a page is still down when this is first called,
; and read a second time it would turn the page the player was only opening.
; That phantom selection has been a bug in this project four times.
TrainerManual_WaitInput:
	call TrainerManual_WaitRelease
.wait
	call DelayFrame
	call Joypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON | D_LEFT | D_RIGHT
	jr z, .wait
	ret

TrainerManual_WaitRelease:
	call DelayFrame
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr nz, TrainerManual_WaitRelease
	ret

TrainerManualTitleText:
	db "TRAINER MANUAL@"

TrainerManualCloseText:
	db "CLOSE@"

; The chapter order is the one settled in the Notes: bag and menus, out in the
; field, your Pokemon's numbers, power points, status, landing hits, the types.
TrainerManualChapterNames:
	dw TrainerManualChapter1Name
	dw TrainerManualChapter2Name
	dw TrainerManualChapter3Name
	dw TrainerManualChapter4Name
	dw TrainerManualChapter5Name
	dw TrainerManualChapter6Name
	dw TrainerManualChapter7Name

TrainerManualChapter1Name:
	db "BAG AND MENUS@"
TrainerManualChapter2Name:
	db "OUT IN THE FIELD@"
TrainerManualChapter3Name:
	db "#MON NUMBERS@"
TrainerManualChapter4Name:
	db "POWER POINTS@"
TrainerManualChapter5Name:
	db "STATUS@"
TrainerManualChapter6Name:
	db "LANDING HITS@"
TrainerManualChapter7Name:
	db "THE TYPES@"

TrainerManualChapterPages:
	dw TrainerManualChapter1Pages
	dw TrainerManualChapter2Pages
	dw TrainerManualChapter3Pages
	dw TrainerManualChapter4Pages
	dw TrainerManualChapter5Pages
	dw TrainerManualChapter6Pages
	dw TrainerManualChapter7Pages

; One page per section of the content draft. Phase 3 fills the strings these
; point at; the counts and the order are what phase 2 is for.
TrainerManualChapter1Pages:
	db 3
	dw ManualPage_1_1
	dw ManualPage_1_2
	dw ManualPage_1_3

TrainerManualChapter2Pages:
	db 4
	dw ManualPage_2_1
	dw ManualPage_2_2
	dw ManualPage_2_3
	dw ManualPage_2_4

TrainerManualChapter3Pages:
	db 3
	dw ManualPage_3_1
	dw ManualPage_3_2
	dw ManualPage_3_3

TrainerManualChapter4Pages:
	db 2
	dw ManualPage_4_1
	dw ManualPage_4_2

TrainerManualChapter5Pages:
	db 9
	dw ManualPage_5_1
	dw ManualPage_5_2
	dw ManualPage_5_3
	dw ManualPage_5_4
	dw ManualPage_5_5
	dw ManualPage_5_6
	dw ManualPage_5_7
	dw ManualPage_5_8
	dw ManualPage_5_9

TrainerManualChapter6Pages:
	db 2
	dw ManualPage_6_1
	dw ManualPage_6_2

TrainerManualChapter7Pages:
	db 2
	dw ManualPage_7_1
	dw ManualPage_7_2

; The text itself lives in its own bank; these are the near stubs that reach it,
; the same arrangement the move flavour uses.
ManualPage_1_1:
	text_far _ManualPage_1_1
	text_end
ManualPage_1_2:
	text_far _ManualPage_1_2
	text_end
ManualPage_1_3:
	text_far _ManualPage_1_3
	text_end

ManualPage_2_1:
	text_far _ManualPage_2_1
	text_end
ManualPage_2_2:
	text_far _ManualPage_2_2
	text_end
ManualPage_2_3:
	text_far _ManualPage_2_3
	text_end
ManualPage_2_4:
	text_far _ManualPage_2_4
	text_end

ManualPage_3_1:
	text_far _ManualPage_3_1
	text_end
ManualPage_3_2:
	text_far _ManualPage_3_2
	text_end
ManualPage_3_3:
	text_far _ManualPage_3_3
	text_end

ManualPage_4_1:
	text_far _ManualPage_4_1
	text_end
ManualPage_4_2:
	text_far _ManualPage_4_2
	text_end

ManualPage_5_1:
	text_far _ManualPage_5_1
	text_end
ManualPage_5_2:
	text_far _ManualPage_5_2
	text_end
ManualPage_5_3:
	text_far _ManualPage_5_3
	text_end
ManualPage_5_4:
	text_far _ManualPage_5_4
	text_end
ManualPage_5_5:
	text_far _ManualPage_5_5
	text_end
ManualPage_5_6:
	text_far _ManualPage_5_6
	text_end
ManualPage_5_7:
	text_far _ManualPage_5_7
	text_end
ManualPage_5_8:
	text_far _ManualPage_5_8
	text_end
ManualPage_5_9:
	text_far _ManualPage_5_9
	text_end

ManualPage_6_1:
	text_far _ManualPage_6_1
	text_end
ManualPage_6_2:
	text_far _ManualPage_6_2
	text_end

ManualPage_7_1:
	text_far _ManualPage_7_1
	text_end
ManualPage_7_2:
	text_far _ManualPage_7_2
	text_end
