Route15Gate2F_Script:
	jp DisableAutoTextBoxDrawing

Route15Gate2F_TextPointers:
	def_text_pointers
	dw_const Route15Gate2FWatcherText,    TEXT_ROUTE15GATE2F_WATCHER
	dw_const Route15Gate2FBinocularsText, TEXT_ROUTE15GATE2F_BINOCULARS

; v0.7 (2026-08-30, his aide redesign): the EXP.SHARE aide moved to the
; SAFFRON Pokecenter (both parcels, no dex quota - see SaffronPokecenter).
; His slot became a bird-counting YOUNGSTER so the floor keeps its people;
; reusing the object slot dodges any sprite-index renumbering. (The
; EXP.SHARE description far text stays in this map's text file, borrowed
; from Saffron's script; the old hi/receipt/no-room lines went with him.)
Route15Gate2FWatcherText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _Route15Gate2FWatcherText
	text_end

Route15Gate2FBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text_far _Route15Gate2FBinocularsText
	text_end
