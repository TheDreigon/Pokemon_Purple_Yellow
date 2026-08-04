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
; * TWO LEVELS, LIKE THE CELADON INFORMATION DESK. Chapters, then the sections
;   inside one, then the page: you pick the thing you came for instead of
;   reading through to it. STATUS has nine sections and paging to the seventh
;   was the whole objection.
; * ONE COLUMN AT EVERY LEVEL. Every navigation bug playtesting has found in
;   this project -- the two on the Celadon desk, the Bill quiz, the Purple quiz
;   -- was a screen with TWO cursors visible at once, which is the desk's
;   category board and not its drill-down. Going deeper one list at a time is
;   the part of that desk that has never broken.
; * A PAGE STILL WALKS TO ITS NEIGHBOURS. RIGHT and LEFT step through the
;   chapter's sections without going back up, so the manual can also be read
;   straight through by anyone who wants to. Picking and reading on cost the
;   same code.
; * DRAWN WITH TextBoxBorder, not in the POKéDEX's style. The manual is opened
;   from the BAG, which already has the text-box tile patterns loaded, so there
;   is no swap to get wrong -- unlike the MOVEDEX, which has to trade tile sets
;   with the card it opens.
;
; Phase 2 is the shell: the chapters, their sections and the order are final,
; and every page holds a stub where its text will go. Phase 3 fills the strings
; behind TrainerManualChapter*Sections and touches nothing here.

DEF MANUAL_NUM_CHAPTERS EQU 7
; Seven rows of contents, centred by the same rule the section lists use.
;
; There is no CLOSE row, and no BACK row on a section list either: B goes up one
; level from all three screens, which is what it does everywhere else in this
; game. A CLOSE row was drawn first and taken out -- Forte wanted a blank line
; between it and the last chapter, which makes one row of the list sit somewhere
; PlaceMenuCursor cannot put the arrow (it steps a fixed number of rows per
; entry), and a special-cased cursor row is the exact shape of every navigation
; bug this project has had. The MOVEDEX lost its QUIT for the same reason.
DEF MANUAL_LIST_TOP_Y EQU 6
; A page's text starts here, leaving the section's name on row 1 and a blank row
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

; ---------------------------------------------------------------- level 1 ----

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
	ld a, MANUAL_NUM_CHAPTERS - 1
	ld [hli], a
	ld [hl], A_BUTTON | B_BUTTON
	call TrainerManual_ReadList

	bit BIT_B_BUTTON, a
	jr nz, .close
	ld a, [wCurrentMenuItem]
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
; The chapter names are read out of the same table a chapter's own heading
; reads, so the contents and the top of a chapter cannot drift into disagreeing
; about what it is called.
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
	jp TrainerManual_ShowScreen

; ---------------------------------------------------------------- level 2 ----

; INPUT: a = chapter index, 0 to MANUAL_NUM_CHAPTERS - 1.
TrainerManual_ShowChapter:
	ld c, a
	ld a, [wCurrentMenuItem]
	push af ; the contents row, to be handed back on the way out
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
.redraw
	push bc
	call TrainerManual_DrawSections ; sets wTopMenuItemY and wMaxMenuItem
	pop bc
.loop
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	push bc
	call TrainerManual_ReadList
	pop bc
	bit BIT_B_BUTTON, a
	jr nz, .done
; Open the section the cursor is on, and come back with the cursor on whichever
; one the player stopped reading at -- RIGHT walks between sections, so that is
; not always the one they picked.
	ld a, [wCurrentMenuItem]
	ld b, a
	push bc
	call TrainerManual_ShowPages
	ld a, b
	pop bc
	ld [wCurrentMenuItem], a
	jr .redraw
.done
	call TrainerManual_WaitRelease
	pop af
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ret

; INPUT: c = chapter.
TrainerManual_DrawSections:
	xor a
	ldh [hAutoBGTransferEnabled], a
	push bc
	call TrainerManual_DrawFrame
	pop bc

	push bc
	ld a, c
	call TrainerManual_GetChapterName
	hlcoord 1, 1
	call TrainerManual_PlaceCentered
	pop bc

	push bc
	ld a, c
	call TrainerManual_GetSectionCount
	ld b, a
	dec a
	ld [wMaxMenuItem], a
	ld a, b
	call TrainerManual_ListTopRow
	ld [wTopMenuItemY], a
	pop bc

; hl = the first row of the list, worked out from the row it starts on
	hlcoord 2, 0
	ld de, SCREEN_WIDTH
	ld a, [wTopMenuItemY]
	and a
	jr z, .atFirstRow
.rowLoop
	add hl, de
	dec a
	jr nz, .rowLoop
.atFirstRow

	ld b, 0
.sectionLoop
	push hl
	push bc
	call TrainerManual_GetSectionName
	pop bc
	pop hl
	push bc
	call PlaceString
	pop bc
	ld de, SCREEN_WIDTH
	add hl, de
	inc b
	ld a, [wMaxMenuItem]
	cp b
	jr nc, .sectionLoop
	jp TrainerManual_ShowScreen

; ---------------------------------------------------------------- level 3 ----

; INPUT: b = section to open, c = chapter.
; OUTPUT: b = the section the player stopped on.
TrainerManual_ShowPages:
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
; RIGHT walks the sections and stops at the last one; A reads on and out of the
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
	push bc
	call TrainerManual_WaitRelease
	pop bc
	ret

; INPUT: b = section, c = chapter. OUTPUT: z if b is that chapter's last one.
TrainerManual_IsLastPage:
	ld a, c
	call TrainerManual_GetSectionCount
	dec a
	cp b
	ret

; INPUT: b = section, c = chapter.
TrainerManual_DrawPage:
	xor a
	ldh [hAutoBGTransferEnabled], a
	push bc
	call TrainerManual_DrawFrame
	pop bc

; The SECTION's name heads the page, not the chapter's: it names what is being
; read, and RIGHT can walk you three sections away from the one you picked. The
; chapter is one B press up.
	push bc
	call TrainerManual_GetSectionName
	hlcoord 1, 1
	call TrainerManual_PlaceCentered
	pop bc

	push bc
	call TrainerManual_GetSectionText
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
; of WRAM -- and WRAM is full at 8192/8192. No chapter has ten sections; if one
; ever does, this is the line that has to grow.
	push bc
	ld a, c
	call TrainerManual_GetSectionCount
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
	jp TrainerManual_ShowScreen

; ------------------------------------------------------------------ shared ---

; One box, the whole screen. Interior rows 1 to 16, columns 1 to 18.
TrainerManual_DrawFrame:
	call ClearScreen
	hlcoord 0, 0
	lb bc, 16, 18
	jp TextBoxBorder

TrainerManual_ShowScreen:
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

; A list of any length sits centred in the rows under the heading, which are 3
; to 16. Eight rows of contents come out at 6, which is where they already were.
; INPUT: a = rows in the list. OUTPUT: a = the row it starts on.
TrainerManual_ListTopRow:
	ld b, a
	ld a, MANUAL_PAGE_ROWS + 1
	sub b
	srl a
	add MANUAL_TEXT_TOP_Y
	ret

; Every list in here is fixed and none of them scrolls, so HandleMenuInput can
; wrap top to bottom itself. That is also why UP and DOWN are not watched: a
; watched direction is handed back to the caller as well as moving the cursor,
; which is what made the MOVEDEX step two entries at a time.
;
; hUILayoutFlags bit 1 walks the cursor down consecutive rows instead of every
; other one (home/window.asm:144-148). That is what lets eight entries fit with
; room left for a heading; the battle FIGHT menu uses the same flag for its four
; move names.
;
; OUTPUT: a = the keys HandleMenuInput answered with.
TrainerManual_ReadList:
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld hl, hUILayoutFlags
	set 1, [hl]
	call HandleMenuInput
	ld b, a ; the answer is in a and the two lines below clobber it
	ld hl, hUILayoutFlags
	res 1, [hl]
	ld a, b
	ret

; INPUT: a = chapter index. OUTPUT: de = its name. Preserves bc.
TrainerManual_GetChapterName:
	add a
	ld e, a
	ld d, 0
	ld hl, TrainerManualChapters
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, h
	ld e, l
	ret

; INPUT: a = chapter index. OUTPUT: hl = its section block, which is a count
; followed by that many name/text pointer pairs. Preserves bc.
TrainerManual_GetChapterSections:
	add a
	ld e, a
	ld d, 0
	ld hl, TrainerManualChapterSections
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; INPUT: a = chapter index. OUTPUT: a = how many sections it has. Preserves bc.
TrainerManual_GetSectionCount:
	call TrainerManual_GetChapterSections
	ld a, [hl]
	ret

; INPUT: b = section, c = chapter. OUTPUT: de = the section's name.
TrainerManual_GetSectionName:
	call TrainerManual_SectionEntry
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, h
	ld e, l
	ret

; INPUT: b = section, c = chapter. OUTPUT: hl = the section's text.
TrainerManual_GetSectionText:
	call TrainerManual_SectionEntry
	inc hl ; past the name pointer
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; INPUT: b = section, c = chapter. OUTPUT: hl = that section's four-byte entry.
TrainerManual_SectionEntry:
	ld a, c
	call TrainerManual_GetChapterSections
	inc hl ; past the count
	ld a, b
	add a
	add a ; four bytes an entry, and eight sections cannot carry
	ld e, a
	ld d, 0
	add hl, de
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

; The chapter order is the one settled in the Notes: bag and menus, out in the
; field, your Pokemon's numbers, power points, status, landing hits, the types.
TrainerManualChapters:
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

TrainerManualChapterSections:
	dw TrainerManualChapter1Sections
	dw TrainerManualChapter2Sections
	dw TrainerManualChapter3Sections
	dw TrainerManualChapter4Sections
	dw TrainerManualChapter5Sections
	dw TrainerManualChapter6Sections
	dw TrainerManualChapter7Sections

; A count, then one name and one page per section of the content draft. Phase 3
; fills the strings the second pointer of each pair reaches; the names and the
; order are what phase 2 is for.
;
; A name is at most 17 tiles: the cursor takes column 1 and the box's interior
; ends at column 18.
TrainerManualChapter1Sections:
	db 3
	dw TrainerManualSection1_1, ManualPage_1_1
	dw TrainerManualSection1_2, ManualPage_1_2
	dw TrainerManualSection1_3, ManualPage_1_3

TrainerManualChapter2Sections:
	db 4
	dw TrainerManualSection2_1, ManualPage_2_1
	dw TrainerManualSection2_2, ManualPage_2_2
	dw TrainerManualSection2_3, ManualPage_2_3
	dw TrainerManualSection2_4, ManualPage_2_4

TrainerManualChapter3Sections:
	db 3
	dw TrainerManualSection3_1, ManualPage_3_1
	dw TrainerManualSection3_2, ManualPage_3_2
	dw TrainerManualSection3_3, ManualPage_3_3

TrainerManualChapter4Sections:
	db 2
	dw TrainerManualSection4_1, ManualPage_4_1
	dw TrainerManualSection4_2, ManualPage_4_2

TrainerManualChapter5Sections:
	db 9
	dw TrainerManualSection5_1, ManualPage_5_1
	dw TrainerManualSection5_2, ManualPage_5_2
	dw TrainerManualSection5_3, ManualPage_5_3
	dw TrainerManualSection5_4, ManualPage_5_4
	dw TrainerManualSection5_5, ManualPage_5_5
	dw TrainerManualSection5_6, ManualPage_5_6
	dw TrainerManualSection5_7, ManualPage_5_7
	dw TrainerManualSection5_8, ManualPage_5_8
	dw TrainerManualSection5_9, ManualPage_5_9

TrainerManualChapter6Sections:
	db 2
	dw TrainerManualSection6_1, ManualPage_6_1
	dw TrainerManualSection6_2, ManualPage_6_2

TrainerManualChapter7Sections:
	db 2
	dw TrainerManualSection7_1, ManualPage_7_1
	dw TrainerManualSection7_2, ManualPage_7_2

TrainerManualSection1_1:
	db "ORDERING ITEMS@"
TrainerManualSection1_2:
	db "WHAT AN ITEM DOES@"
TrainerManualSection1_3:
	db "THE INFO DESK@"

TrainerManualSection2_1:
	db "WILD #MON@"
TrainerManualSection2_2:
	db "CATCHING@"
TrainerManualSection2_3:
	db "THE PC@"
TrainerManualSection2_4:
	db "#MON MARTS@"

TrainerManualSection3_1:
	db "SPECIAL@"
TrainerManualSection3_2:
	db "HIDDEN NUMBERS@"
TrainerManualSection3_3:
	db "GROWTH@"

TrainerManualSection4_1:
	db "WHAT PP IS@"
TrainerManualSection4_2:
	db "OUTLASTING A FOE@"

TrainerManualSection5_1:
	db "PARALYSIS@"
TrainerManualSection5_2:
	db "BURN@"
TrainerManualSection5_3:
	db "FREEZE@"
TrainerManualSection5_4:
	db "SLEEP@"
TrainerManualSection5_5:
	db "POISON@"
TrainerManualSection5_6:
	db "CONFUSION@"
TrainerManualSection5_7:
	db "CALLING ONE BACK@"
TrainerManualSection5_8:
	db "WHO IS IMMUNE@"
TrainerManualSection5_9:
	db "GUARD SPEC.@"

TrainerManualSection6_1:
	db "ACCURACY@"
TrainerManualSection6_2:
	db "CRITICAL HITS@"

TrainerManualSection7_1:
	db "THE ROSTER@"
TrainerManualSection7_2:
	db "PHYSICAL/SPECIAL@"

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
