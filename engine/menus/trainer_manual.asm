; v0.7: the TRAINER MANUAL.
;
; The key item the player's mother hands over on the way out of Pallet opens
; this. USE on the manual comes straight here (ItemUseTrainerManual, in
; engine/items/item_effects.asm) and the bag redraws itself underneath on the
; way back out, so nothing has to be saved or restored except the three
; variables the bag keeps its own place in.
;
; THE SHAPE, and why it is this one:
;
; * THREE LEVELS, LIKE THE CELADON INFORMATION DESK -- chapters, the sections
;   inside one, then the page. Forte's call: topics you pick from, not a book
;   you read through. STATUS has nine sections and TYPE MATCHUPS has
;   twenty-one; reaching either by paging would be the whole objection.
; * ONE CURSOR PER SCREEN AT EVERY LEVEL. Every navigation bug playtesting has
;   found in this project -- the two on the Celadon desk, the Bill quiz, the
;   Purple quiz -- was a screen with TWO cursors visible at once, which is that
;   desk's category board and not its drill-down.
; * A PAGE STILL WALKS TO ITS NEIGHBOURS. RIGHT and LEFT step through a
;   chapter's pages without going back up, so the manual can also be read
;   straight through. Picking and reading on cost the same code.
; * NO CLOSE ROW AND NO BACK ROW. B goes up one level from all three screens,
;   as it does everywhere else in this game. A CLOSE row was built and taken
;   out: Forte wanted a blank line above it, and PlaceMenuCursor steps a fixed
;   number of rows per entry, so that row would have sat where the arrow cannot
;   go. The MOVEDEX lost its QUIT on the same argument.
;
; A SECTION MAY OWN MORE THAN ONE PAGE. A chapter holds a flat list of pages
; and a list of sections, each of which names the page it starts at. Selecting a
; section jumps to its first page; B from a page comes back to whichever section
; owns the page being read. Every chapter but TYPE MATCHUPS is one page per
; section today, and that one needs two -- a type as an attacker and the same
; type as a defender do not fit on one screen together (measured: 23 lines of a
; 13-line page; see .claude/type_page_fit.py).

DEF MANUAL_NUM_CHAPTERS EQU 7
; Every list routine below takes the chapter it is listing in c, and this
; sentinel means "the contents". It exists because WRAM is full at 8192/8192 --
; there is not one byte to remember which list is on screen, so it is carried in
; a register and handed along with the rest.
DEF MANUAL_CONTENTS EQU $FF
; The most rows a list will draw at once. Longer lists scroll; shorter ones are
; centred in the space under the heading.
DEF MANUAL_LIST_ROWS EQU 12
; A page's text starts here, leaving the section's name on row 1 and a blank row
; under it. Rows 3 to 15 are the text, row 16 carries the counter.
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
	ld [wListScrollOffset], a
.redraw
	call TrainerManual_DrawContents
.loop
	ld c, MANUAL_CONTENTS
	call TrainerManual_ReadList
	bit BIT_B_BUTTON, a
	jr nz, .close
	bit BIT_D_UP, a
	jr nz, .redraw
	bit BIT_D_DOWN, a
	jr nz, .redraw
	call TrainerManual_SelectedRow
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
; Front matter. Forte's framing: a boy leaves on his first journey and his
; mother buys him the official manual. One line of provenance is what makes it
; that object instead of an anonymous list of true statements -- and it is what
; explains how a book in Pallet Town knows the rules of a gym battle.
; Rows 2 and 3, not 3 and 4: nine chapters centre onto row 5, and the front
; matter sitting directly above them read as a tenth entry.
	hlcoord 1, 2
	ld de, TrainerManualIssuedText
	call TrainerManual_PlaceCentered
	hlcoord 1, 3
	ld de, TrainerManualLeagueText
	call TrainerManual_PlaceCentered

	ld c, MANUAL_CONTENTS
	call TrainerManual_DrawList
	jp TrainerManual_ShowScreen

; ---------------------------------------------------------------- level 2 ----

; INPUT: a = chapter index.
TrainerManual_ShowChapter:
	ld c, a
	ld a, [wCurrentMenuItem]
	push af ; the contents row, to be handed back on the way out
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld [wListScrollOffset], a
.redraw
	push bc
	call TrainerManual_DrawSections
	pop bc
.loop
	push bc
	call TrainerManual_ReadList
	pop bc
	bit BIT_B_BUTTON, a
	jr nz, .done
	bit BIT_D_UP, a
	jr nz, .redraw
	bit BIT_D_DOWN, a
	jr nz, .redraw
; Open the section the cursor is on, and come back on whichever section owns the
; page the player stopped at -- RIGHT walks pages across section boundaries, so
; that is not always the one they picked.
; Every routine on this chain preserves c, so the chapter is never in danger and
; b carries the answer forward. (It was written with push/pop around each call
; at first, and the pop put the OLD b back over the section that had just been
; chosen -- every type opened the page of whatever section the cursor had been
; on before.)
	call TrainerManual_SelectedRow
	ld b, a
	call TrainerManual_GetSectionFirstPage
	ld b, a
	call TrainerManual_ShowPages ; b = the page it was left on
	call TrainerManual_SectionOfPage
	call TrainerManual_PutCursorOn
	jr .redraw
.done
	call TrainerManual_WaitRelease
	pop af
	ld [wListScrollOffset], a
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

	call TrainerManual_DrawList
	jp TrainerManual_ShowScreen

; ---------------------------------------------------------------- level 3 ----

; INPUT: b = page to open, c = chapter.
; OUTPUT: b = the page the player stopped on.
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
	push bc
	call TrainerManual_WaitRelease
	pop bc
	ret

; INPUT: b = page, c = chapter. OUTPUT: z if b is that chapter's last page.
TrainerManual_IsLastPage:
	ld a, c
	call TrainerManual_GetPageCount
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

; The page is headed by the name of the SECTION that owns it, not the chapter's:
; it names what is being read, and RIGHT can walk you several sections away from
; the one you picked. The chapter is one B press up. Both pages of a two-page
; section carry the same heading and say which half they are in their first
; line.
	push bc
	call TrainerManual_SectionOfPage
	ld b, a
	call TrainerManual_GetSectionName
	hlcoord 1, 1
	call TrainerManual_PlaceCentered
	pop bc

	push bc
	call TrainerManual_GetPageText
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

; "n/m" in the bottom right corner, counting SECTIONS rather than pages: a
; two-page section is one topic, and "14/21" is the useful number in a chapter
; of twenty-one types.
	push bc
	call TrainerManual_SectionOfPage
	push af ; the section index -- every lookup below goes through d and e
	ld a, c
	call TrainerManual_GetSectionCount
	hlcoord 18, 16
	call TrainerManual_PlaceNumberBack ; the total, right-aligned
	ld a, "/"
	ld [hld], a
	pop af
	inc a ; sections are counted from one on the page
	call TrainerManual_PlaceNumberBack
	pop bc
	jp TrainerManual_ShowScreen

; ------------------------------------------------------------------ lists ---

; Draw the list for chapter c (or the contents, if c is MANUAL_CONTENTS),
; scrolled to wListScrollOffset and centred under the heading.
TrainerManual_DrawList:
	push bc
	call TrainerManual_WindowRows
	call TrainerManual_ListTopRow
	ld [wTopMenuItemY], a
	pop bc

; hl = the first row of the list, stepped down from the top of the screen
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
.nameLoop
	push hl
	push bc
	ld a, [wListScrollOffset]
	add b
	ld b, a
	call TrainerManual_NameForRow ; b = the row, c = the list
	pop bc
	pop hl
	push bc
	call PlaceString
	pop bc
	ld de, SCREEN_WIDTH
	add hl, de
	inc b
; WindowRows reaches the section tables through de and hl, so the screen
; pointer and the counter both have to be put down before asking. Neither pop
; touches a, which is where the answer comes back.
	push hl
	push bc
	call TrainerManual_WindowRows
	pop bc
	pop hl
	cp b
	jr nz, .nameLoop

; A list longer than its window gets the game's own "there is more below" mark.
; HandleMenuInput blinks whatever sits at (18,11) if it is a down arrow
; (home/window.asm:32), so putting one there is the whole feature.
;
; Column 18 is the last cell a 17-tile section name would reach, so a scrolling
; list must not carry a name that long on row 11. The only one that scrolls is
; TYPE MATCHUPS, whose longest name is ELECTRIC.
	push bc
	call TrainerManual_WindowRows
	ld b, a
	call TrainerManual_ListCount
	cp b
	pop bc
	ret z
	ld a, "▼"
	ldcoord_a 18, 11
	ret

; INPUT: b = row, c = the list. OUTPUT: de = that row's name. Preserves bc.
TrainerManual_NameForRow:
	ld a, c
	inc a ; MANUAL_CONTENTS is $FF
	jp nz, TrainerManual_GetSectionName
	ld a, b
	jp TrainerManual_GetChapterName

; INPUT: c = the list. OUTPUT: a = how many rows it holds. Preserves b.
TrainerManual_ListCount:
	ld a, c
	inc a
	jr z, .contents
	ld a, c
	jp TrainerManual_GetSectionCount
.contents
	ld a, MANUAL_NUM_CHAPTERS
	ret

; INPUT: c = the list. OUTPUT: a = how many rows it shows at once. Preserves b.
TrainerManual_WindowRows:
	call TrainerManual_ListCount
	cp MANUAL_LIST_ROWS + 1
	ret c
	ld a, MANUAL_LIST_ROWS
	ret

; A list of any length sits centred in the rows under the heading, which are 3
; to 16.
; INPUT: a = rows shown. OUTPUT: a = the row it starts on.
TrainerManual_ListTopRow:
	ld b, a
	ld a, MANUAL_PAGE_ROWS + 1
	sub b
	srl a
	add MANUAL_TEXT_TOP_Y
	ret

; The row the cursor is on, counting from the top of the whole list.
; OUTPUT: a = wListScrollOffset + wCurrentMenuItem. Preserves bc.
TrainerManual_SelectedRow:
	ld a, [wListScrollOffset]
	ld e, a
	ld a, [wCurrentMenuItem]
	add e
	ret

; Put the cursor on row a of list c, scrolling the window if it is not inside
; it. Preserves bc.
TrainerManual_PutCursorOn:
	push bc
	ld b, a ; the row wanted; WindowRows comes back through d and e
	call TrainerManual_WindowRows
	ld e, a ; window height
	ld a, b
	cp e
	jr c, .visibleFromTheTop
; the row is below the first windowful: park it on the last row of the window
	sub e
	inc a
	ld [wListScrollOffset], a
	ld a, e
	dec a
	jr .store
.visibleFromTheTop
	push af
	xor a
	ld [wListScrollOffset], a
	pop af
.store
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	pop bc
	ret

; Hand the list to HandleMenuInput and give the answer back in a.
;
; A list that fits on screen wraps top to bottom; one that scrolls hands the
; ends back to the caller instead, which is what wMenuWatchMovingOutOfBounds
; buys. UP and DOWN are never WATCHED either way: a watched direction is handed
; back as well as moving the cursor, which is what made the MOVEDEX step two
; entries at a time. Unwatched, HandleMenuInput moves the cursor itself and only
; returns at the ends -- which is exactly when this needs to scroll.
;
; hUILayoutFlags bit 1 walks the cursor down consecutive rows instead of every
; other one (home/window.asm:144-148). The battle FIGHT menu uses the same flag
; for its four move names.
;
; OUTPUT: a = the keys HandleMenuInput answered with. Preserves bc.
TrainerManual_ReadList:
	push bc
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	call TrainerManual_WindowRows
	ld b, a ; bc is pushed, so b is free; d and e are not
	dec a
	ld [wMaxMenuItem], a
	call TrainerManual_ListCount
	cp b
	ld a, 0
	jr z, .fits
	inc a ; the list is longer than the window: the ends come back here
.fits
	ld [wMenuWatchMovingOutOfBounds], a
	ld hl, hUILayoutFlags
	set 1, [hl]
	call HandleMenuInput
	ld b, a ; the answer is in a and the two lines below clobber it
	ld hl, hUILayoutFlags
	res 1, [hl]
	ld a, b
	pop bc
	push af
	bit BIT_D_UP, a
	jr nz, .scrollUp
	bit BIT_D_DOWN, a
	jr nz, .scrollDown
	pop af
	ret
; A list that fits wraps inside HandleMenuInput; one that scrolls has to wrap
; here, or the two kinds of list in the same book would behave differently at
; their ends.
.scrollUp
	ld a, [wListScrollOffset]
	and a
	jr nz, .scrollUpOne
	push bc
	call TrainerManual_LastOffset
	ld [wListScrollOffset], a
	call TrainerManual_WindowRows
	dec a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	pop bc
	jr .doneScrolling
.scrollUpOne
	dec a
	ld [wListScrollOffset], a
	jr .doneScrolling
.scrollDown
	push bc
	call TrainerManual_LastOffset
	ld c, a
	ld a, [wListScrollOffset]
	cp c
	jr nz, .scrollDownOne
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	jr .doneScrollingPop
.scrollDownOne
	inc a
	ld [wListScrollOffset], a
.doneScrollingPop
	pop bc
.doneScrolling
	pop af
	ret

; INPUT: c = the list. OUTPUT: a = the largest scroll offset that still fills
; the window. Clobbers b; c survives, because both lookups below need it.
TrainerManual_LastOffset:
	call TrainerManual_ListCount
	push af
	call TrainerManual_WindowRows
	ld b, a
	pop af
	sub b
	ret

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

; INPUT: a = 1..99, hl = the rightmost cell to write into. Writes the number
; right-aligned and leaves hl on the cell to the left of it.
;
; PrintNumber would want its number in RAM and a byte to put it in, and WRAM is
; full at 8192/8192.
TrainerManual_PlaceNumberBack:
	ld c, 0
.tens
	cp 10
	jr c, .gotTens
	sub 10
	inc c
	jr .tens
.gotTens
	add "0" ; the digit glyphs run consecutively up from "0"
	ld [hld], a
	ld a, c
	and a
	ret z
	add "0"
	ld [hld], a
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

; INPUT: a = chapter index. OUTPUT: hl = its section block -- a count, then
; three bytes per section: a name pointer and the page it starts at.
; Preserves bc.
TrainerManual_GetSectionBlock:
	add a
	ld e, a
	ld d, 0
	ld hl, TrainerManualChapterSections
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; INPUT: a = chapter index. OUTPUT: hl = its page block -- a count, then one
; pointer per page. Preserves bc.
TrainerManual_GetPageBlock:
	add a
	ld e, a
	ld d, 0
	ld hl, TrainerManualChapterPages
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; INPUT: a = chapter index. OUTPUT: a = how many sections. Preserves bc.
TrainerManual_GetSectionCount:
	call TrainerManual_GetSectionBlock
	ld a, [hl]
	ret

; INPUT: a = chapter index. OUTPUT: a = how many pages. Preserves bc.
TrainerManual_GetPageCount:
	call TrainerManual_GetPageBlock
	ld a, [hl]
	ret

; INPUT: b = section, c = chapter. OUTPUT: hl = that section's three-byte entry.
TrainerManual_SectionEntry:
	ld a, c
	call TrainerManual_GetSectionBlock
	inc hl ; past the count
	ld a, b
	add a
	add b ; three bytes an entry; twenty-one sections cannot carry
	ld e, a
	ld d, 0
	add hl, de
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

; INPUT: b = section, c = chapter. OUTPUT: a = the page it starts at.
TrainerManual_GetSectionFirstPage:
	call TrainerManual_SectionEntry
	inc hl ; past the name pointer
	inc hl
	ld a, [hl]
	ret

; INPUT: b = page, c = chapter. OUTPUT: hl = that page's text.
TrainerManual_GetPageText:
	ld a, c
	call TrainerManual_GetPageBlock
	inc hl ; past the count
	ld e, b
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
; fall through

; INPUT: hl = a page. OUTPUT: hl, replaced by its hard-mode twin if it has one
; and the game is being played on hard. Clobbers bc and de; every caller has
; already put bc down.
TrainerManual_SwapForDifficulty:
	ld a, [wDifficulty]
	and a
	ret z
	ld d, h
	ld e, l
	ld hl, TrainerManualHardPages
.loop
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	or c
	ret z ; the list ended without a match
	ld a, c
	cp e
	jr nz, .next
	ld a, b
	cp d
	jr z, .found
.next
	inc hl ; past the twin
	inc hl
	jr .loop
.found
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; INPUT: b = page, c = chapter. OUTPUT: a = the section that owns it, which is
; the last one whose first page is not past it. Preserves bc.
TrainerManual_SectionOfPage:
	ld a, c
	call TrainerManual_GetSectionBlock
	ld a, [hli]
	ld d, a ; sections left to test
	ld e, 0 ; the section being tested
	push bc
	ld c, 0 ; the best answer so far
.loop
	inc hl ; past the name pointer
	inc hl
	ld a, [hli]
	cp b
	jr z, .take
	jr nc, .done ; this section starts past the page: the previous one owns it
.take
	ld a, e
	ld c, a
	inc e
	dec d
	jr nz, .loop
.done
	ld a, c
	pop bc
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
TrainerManualIssuedText:
	db "issued by the@"
TrainerManualLeagueText:
	db "#MON LEAGUE@"

; A section is a name and the page it opens at. Every section below is one page,
; except the per-type ones in chapter 6, which are two -- a type as an attacker
; and the same type as a defender do not fit on one screen together.
;
; A section name is at most 17 tiles: the cursor takes column 1 and the
; interior of the box ends at column 18.
MACRO manual_section
	dw \1
	db \2
ENDM

; The text lives in its own bank; these are the near stubs that reach it, the
; same arrangement the move flavour uses.
MACRO manual_page
\1:
	text_far _\1
	text_end
ENDM

; The per-type sections of THE TYPES: the rows, the names and the near stubs,
; all generated from data/types/type_matchups.asm by
; .claude/manual_types_build.py. Never hand-edit -- the point of generating it
; is that the manual cannot disagree with the table the battle engine reads.
;
; Included HERE, above the tables, because it defines the macros those tables
; expand and rgbasm needs a macro defined before it is used.
INCLUDE "data/manual/type_pages.asm"

; The chapter order is the one settled in the Notes. Two changes came out of
; playtesting the written manual: POWER POINTS folded into LANDING HITS (chapter
; 3 is what the STATS page shows you, and this one is what happens when you
; press a move -- PP is the first thing that decides that), and the twenty-one
; type matchup sections moved inside THE TYPES rather than standing as a
; chapter of their own.
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
	db "STATUS@"
TrainerManualChapter5Name:
	db "LANDING HITS@"
TrainerManualChapter6Name:
	db "THE TYPES@"
TrainerManualChapter7Name:
	db "THE TWO MODES@"

TrainerManualChapterSections:
	dw TrainerManualChapter1Sections
	dw TrainerManualChapter2Sections
	dw TrainerManualChapter3Sections
	dw TrainerManualChapter4Sections
	dw TrainerManualChapter5Sections
	dw TrainerManualChapter6Sections
	dw TrainerManualChapter7Sections

TrainerManualChapterPages:
	dw TrainerManualChapter1Pages
	dw TrainerManualChapter2Pages
	dw TrainerManualChapter3Pages
	dw TrainerManualChapter4Pages
	dw TrainerManualChapter5Pages
	dw TrainerManualChapter6Pages
	dw TrainerManualChapter7Pages

TrainerManualChapter1Sections:
	db 5
	manual_section TrainerManualSection1_1, 0
	manual_section TrainerManualSection1_2, 1
	manual_section TrainerManualSection1_3, 2
	manual_section TrainerManualSection1_4, 3
	manual_section TrainerManualSection1_5, 4
TrainerManualChapter1Pages:
	db 5
	dw ManualPage_1_1, ManualPage_1_2, ManualPage_1_3
	dw ManualPage_1_4, ManualPage_1_5

TrainerManualChapter2Sections:
	db 4
	manual_section TrainerManualSection2_1, 0
	manual_section TrainerManualSection2_2, 1
	manual_section TrainerManualSection2_3, 2
	manual_section TrainerManualSection2_4, 3
TrainerManualChapter2Pages:
	db 4
	dw ManualPage_2_1, ManualPage_2_2, ManualPage_2_3, ManualPage_2_4

TrainerManualChapter3Sections:
	db 4
	manual_section TrainerManualSection3_1, 0
	manual_section TrainerManualSection3_2, 1
	manual_section TrainerManualSection3_3, 2
	manual_section TrainerManualSection3_4, 3
TrainerManualChapter3Pages:
	db 4
	dw ManualPage_3_1, ManualPage_3_2, ManualPage_3_3, ManualPage_3_4

TrainerManualChapter4Sections:
	db 9
	manual_section TrainerManualSection4_1, 0
	manual_section TrainerManualSection4_2, 1
	manual_section TrainerManualSection4_3, 2
	manual_section TrainerManualSection4_4, 3
	manual_section TrainerManualSection4_5, 4
	manual_section TrainerManualSection4_6, 5
	manual_section TrainerManualSection4_7, 6
	manual_section TrainerManualSection4_8, 7
	manual_section TrainerManualSection4_9, 8
TrainerManualChapter4Pages:
	db 9
	dw ManualPage_4_1, ManualPage_4_2, ManualPage_4_3
	dw ManualPage_4_4, ManualPage_4_5, ManualPage_4_6
	dw ManualPage_4_7, ManualPage_4_8, ManualPage_4_9

TrainerManualChapter5Sections:
	db 5
	manual_section TrainerManualSection5_1, 0
	manual_section TrainerManualSection5_2, 1
	manual_section TrainerManualSection5_3, 2
	manual_section TrainerManualSection5_4, 3
	manual_section TrainerManualSection5_5, 4
TrainerManualChapter5Pages:
	db 5
	dw ManualPage_5_1, ManualPage_5_2, ManualPage_5_3
	dw ManualPage_5_4, ManualPage_5_5

; THE TYPES: four written sections, then one per type. MANUAL_TYPE_FIRST_PAGE is
; where the written pages end, and is what the generated rows count from.
DEF MANUAL_TYPE_FIRST_PAGE EQU 4
TrainerManualChapter6Sections:
	db 4 + MANUAL_NUM_TYPE_SECTIONS
	manual_section TrainerManualSection6_1, 0
	manual_section TrainerManualSection6_2, 1
	manual_section TrainerManualSection6_3, 2
	manual_section TrainerManualSection6_4, 3
	manual_type_sections
TrainerManualChapter6Pages:
	db MANUAL_TYPE_FIRST_PAGE + MANUAL_NUM_TYPE_PAGES
	dw ManualPage_6_1, ManualPage_6_2, ManualPage_6_3, ManualPage_6_4
	manual_type_pages

TrainerManualChapter7Sections:
	db 4
	manual_section TrainerManualSection7_1, 0
	manual_section TrainerManualSection7_2, 1
	manual_section TrainerManualSection7_3, 2
	manual_section TrainerManualSection7_4, 3
TrainerManualChapter7Pages:
	db 4
	dw ManualPage_7_1, ManualPage_7_2, ManualPage_7_3, ManualPage_7_4

TrainerManualSection1_1:
	db "ORDERING ITEMS@"
TrainerManualSection1_2:
	db "WHAT AN ITEM DOES@"
TrainerManualSection1_3:
	db "THE INFO DESK@"
TrainerManualSection1_4:
	db "THE MOVE CARD@"
TrainerManualSection1_5:
	db "THE MOVEDEX@"

TrainerManualSection2_1:
	db "WHERE THEY LIVE@"
TrainerManualSection2_2:
	db "CATCHING@"
TrainerManualSection2_3:
	db "#MON MARTS@"
TrainerManualSection2_4:
	db "REMEMBERING MOVES@"

TrainerManualSection3_1:
	db "SPECIAL@"
TrainerManualSection3_2:
	db "HIDDEN NUMBERS@"
TrainerManualSection3_3:
	db "GROWTH@"
TrainerManualSection3_4:
	db "BADGES AND STATS@"

TrainerManualSection4_1:
	db "PARALYSIS@"
TrainerManualSection4_2:
	db "BURN@"
TrainerManualSection4_3:
	db "FREEZE@"
TrainerManualSection4_4:
	db "SLEEP@"
TrainerManualSection4_5:
	db "POISON@"
TrainerManualSection4_6:
	db "CONFUSION@"
TrainerManualSection4_7:
	db "CALLING ONE BACK@"
TrainerManualSection4_8:
	db "WHO IS IMMUNE@"
TrainerManualSection4_9:
	db "GUARD SPEC.@"

TrainerManualSection5_1:
	db "WHAT PP IS@"
TrainerManualSection5_2:
	db "OUTLASTING A FOE@"
TrainerManualSection5_3:
	db "ACCURACY@"
TrainerManualSection5_4:
	db "CRITICAL HITS@"
TrainerManualSection5_5:
	db "FOCUS ENERGY@"

TrainerManualSection6_1:
	db "THE ROSTER@"
TrainerManualSection6_2:
	db "BODY OR MIND@"
TrainerManualSection6_3:
	db "PHYSICAL TYPES@"
TrainerManualSection6_4:
	db "SPECIAL TYPES@"

TrainerManualSection7_1:
	db "WHICH ARE YOU ON@"
TrainerManualSection7_2:
	db "TRAINER FIGHTS@"
TrainerManualSection7_3:
	db "EXPERIENCE@"
TrainerManualSection7_4:
	db "WHAT A BOSS GETS@"

	manual_page ManualPage_1_1
	manual_page ManualPage_1_2
	manual_page ManualPage_1_3
	manual_page ManualPage_1_4
	manual_page ManualPage_1_5

	manual_page ManualPage_2_1
	manual_page ManualPage_2_2
	manual_page ManualPage_2_3
	manual_page ManualPage_2_4

	manual_page ManualPage_3_1
	manual_page ManualPage_3_2
	manual_page ManualPage_3_3
	manual_page ManualPage_3_4

	manual_page ManualPage_4_1
	manual_page ManualPage_4_2
	manual_page ManualPage_4_3
	manual_page ManualPage_4_4
	manual_page ManualPage_4_5
	manual_page ManualPage_4_6
	manual_page ManualPage_4_7
	manual_page ManualPage_4_8
	manual_page ManualPage_4_9

	manual_page ManualPage_5_1
	manual_page ManualPage_5_2
	manual_page ManualPage_5_2_Hard
	manual_page ManualPage_5_3
	manual_page ManualPage_5_4
	manual_page ManualPage_5_5

	manual_page ManualPage_6_1
	manual_page ManualPage_6_2
	manual_page ManualPage_6_3
	manual_page ManualPage_6_4

	manual_page ManualPage_7_1
	manual_page ManualPage_7_2
	manual_page ManualPage_7_3
	manual_page ManualPage_7_4

; A page with a hard-mode twin. The PP page is the second place in the game to
; read the difficulty and tell the truth for each setting -- the Viridian PP
; sign was the first. A table rather than a test on the page index, so nothing
; here has to know which chapter it is.
TrainerManualHardPages:
	dw ManualPage_5_2, ManualPage_5_2_Hard
	dw 0 ; end

