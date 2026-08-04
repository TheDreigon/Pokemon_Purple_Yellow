; v0.7: the TRAINER MANUAL's pages -- still stubs, except TYPE MATCHUPS, which
; is generated and real (see data/text/trainer_manual_types.asm).
;
; One entry per section. Each holds only where its words will come from -- a
; section number in `Notes/Trainer Manual - draft 1.md`, or "new" for the
; sections the content ponderation added -- so the shell can be walked and
; checked against the documents. The section's name is drawn from the chapter
; table as the page's heading.
;
; The budget a page has: 13 lines of 18 tiles, with `#` rendering as its four
; characters. Two of the draft's blocks are over it (2.1 at 14 lines and 7.2 at
; 19). Forte's call was to split rather than cut -- "tentemos nao perder
; informacao" -- which is why 7.2 is already two sections here.

MACRO manual_stub
	text \1
	next ""
	next "(text goes here)"
	done
ENDM

_ManualPage_1_1::
	manual_stub "draft 1.1"
_ManualPage_1_2::
	manual_stub "draft 1.2"
_ManualPage_1_3::
	manual_stub "draft 1.3"
_ManualPage_1_4::
	manual_stub "new: START on"
_ManualPage_1_5::
	manual_stub "new: the MOVEDEX"

_ManualPage_2_1::
	manual_stub "draft 2.1"
_ManualPage_2_2::
	manual_stub "draft 2.2"
_ManualPage_2_3::
	manual_stub "draft 2.4"
_ManualPage_2_4::
	manual_stub "new: relearner"

_ManualPage_3_1::
	manual_stub "draft 3.1"
_ManualPage_3_2::
	manual_stub "draft 3.2"
_ManualPage_3_3::
	manual_stub "draft 3.3"
_ManualPage_3_4::
	manual_stub "new: badges"

_ManualPage_4_1::
	manual_stub "draft 4.1"
_ManualPage_4_2::
	manual_stub "draft 4.2"

_ManualPage_5_1::
	manual_stub "draft 5.1"
_ManualPage_5_2::
	manual_stub "draft 5.2"
_ManualPage_5_3::
	manual_stub "draft 5.3"
_ManualPage_5_4::
	manual_stub "draft 5.4"
_ManualPage_5_5::
	manual_stub "draft 5.5"
_ManualPage_5_6::
	manual_stub "draft 5.6"
_ManualPage_5_7::
	manual_stub "draft 5.7"
_ManualPage_5_8::
	manual_stub "draft 5.8"
_ManualPage_5_9::
	manual_stub "draft 5.9"

_ManualPage_6_1::
	manual_stub "draft 6.1"
_ManualPage_6_2::
	manual_stub "draft 6.2"

_ManualPage_7_1::
	manual_stub "draft 7.1"
_ManualPage_7_2::
	manual_stub "draft 7.2, part 1"
_ManualPage_7_3::
	manual_stub "draft 7.2, part 2"

_ManualPage_9_1::
	manual_stub "new: which mode"
_ManualPage_9_2::
	manual_stub "new: hard rules"
_ManualPage_9_3::
	manual_stub "new: boss knobs"
