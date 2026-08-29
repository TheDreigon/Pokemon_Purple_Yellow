BillsGarden_Script:
; Remembers that the player has actually BEEN here, which is what BILL's
; follow-up line keys off. Opening the wall and walking through it are two
; different things, and he should not ask "how did you like it?" of someone
; who never went in.
	SetEvent EVENT_ENTERED_BILLS_GARDEN
; v0.7 fix (decision-tree audit 2026-08-29): the "inside BILL's house" bit
; (wd492 bit 7 -- it pauses overworld poison, among other things) was only
; ever cleared by Route 25 / Pewter / Vermilion, the vanilla exits. v0.7
; added exits that skip all three: FLY or TELEPORT from this garden. The
; garden is outdoors -- clear it here (idempotent, every tick, like the
; SetEvent above). The blackout family is cleared in HandleBlackOut.
	ld hl, wd492
	res 7, [hl]
	jp EnableAutoTextBoxDrawing

BillsGarden_TextPointers:
	def_text_pointers
