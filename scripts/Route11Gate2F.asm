Route11Gate2F_Script:
	jp DisableAutoTextBoxDrawing

Route11Gate2F_TextPointers:
	def_text_pointers
	dw_const Route11Gate2FYoungsterText,       TEXT_ROUTE11GATE2F_YOUNGSTER
	dw_const Route11Gate2FGentlemanText,       TEXT_ROUTE11GATE2F_GENTLEMAN
	dw_const Route11Gate2FLeftBinocularsText,  TEXT_ROUTE11GATE2F_LEFT_BINOCULARS
	dw_const Route11Gate2FRightBinocularsText, TEXT_ROUTE11GATE2F_RIGHT_BINOCULARS

Route11Gate2FYoungsterText:
	text_asm
	ld a, TRADE_FOR_TREMOR
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
Route11Gate2FScriptEnd:
	jp TextScriptEnd

; v0.7 (2026-08-30, his aide redesign): the ITEMFINDER aide moved to the
; SAFFRON Pokecenter (both parcels, no dex quota - see SaffronPokecenter).
; His slot became a tunnel-watching GENTLEMAN so the floor keeps its
; people; reusing the object slot dodges any sprite-index renumbering.
; (The ITEMFINDER description far text stays in this map's text file,
; borrowed from Saffron's script.)
Route11Gate2FGentlemanText:
	text_asm
	ld hl, .Text
	call PrintText
	jr Route11Gate2FScriptEnd

.Text:
	text_far _Route11Gate2FGentlemanText
	text_end

Route11Gate2FLeftBinocularsText:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, GateUpstairsScript_PrintIfFacingUp
	CheckEvent EVENT_BEAT_ROUTE12_SNORLAX
	ld hl, .SnorlaxText
	jr z, .print
	ld hl, .NoSnorlaxText
.print
	call PrintText
	jp TextScriptEnd

.SnorlaxText:
	text_far _Route11Gate2FLeftBinocularsSnorlaxText
	text_end

.NoSnorlaxText:
	text_far _Route11Gate2FLeftBinocularsNoSnorlaxText
	text_end

Route11Gate2FRightBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text_far _Route11Gate2FRightBinocularsText
	text_end
