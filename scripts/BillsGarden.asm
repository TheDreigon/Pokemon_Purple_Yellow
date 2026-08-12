BillsGarden_Script:
; Remembers that the player has actually BEEN here, which is what BILL's
; follow-up line keys off. Opening the wall and walking through it are two
; different things, and he should not ask "how did you like it?" of someone
; who never went in.
	SetEvent EVENT_ENTERED_BILLS_GARDEN
	jp EnableAutoTextBoxDrawing

BillsGarden_TextPointers:
	def_text_pointers
