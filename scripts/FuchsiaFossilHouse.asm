FuchsiaFossilHouse_Script:
	jp EnableAutoTextBoxDrawing

FuchsiaFossilHouse_TextPointers:
	def_text_pointers
	dw_const FuchsiaFossilHouseFishingGuruText, TEXT_FUCHSIAFOSSILHOUSE_FISHING_GURU
	dw_const FuchsiaFossilHouseOldWomanText,    TEXT_FUCHSIAFOSSILHOUSE_OLD_WOMAN

FuchsiaFossilHouseFishingGuruText:
	text_asm
	CheckEvent EVENT_GOT_FUCHSIA_FOSSIL_GIFT
	jr nz, .got_gift
	ld hl, .Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
; his speech comes BEFORE the gift, the same way Bill's and the roof
; Porygon's do: GivePokemon runs its own fanfare and its own box-full line,
; so anything printed after it has to fight them for the screen.
	ld hl, .ReceivedGiftText
	call PrintText
	CheckEvent EVENT_GOT_DOME_FOSSIL
	jr nz, .giveOmanyte
	lb bc, KABUTO, 25
	jr .giveGiftMon
.giveOmanyte
	lb bc, OMANYTE, 25
.giveGiftMon
	call GivePokemon
	jr nc, .no_room
	SetEvent EVENT_GOT_FUCHSIA_FOSSIL_GIFT
	jr .done
.no_room
; let the engine's box-full line be read before his own (Bill's pattern)
	call WaitForTextScrollButtonPress
	ld hl, .NoRoomText
	call PrintText
	jr .done
.refused
	ld hl, .ThatsSoDisappointingText
	call PrintText
	jr .done
.got_gift
	ld hl, .HowAreTheFishText
	call PrintText
.done
	jp TextScriptEnd

.Text:
	text_far _FuchsiaFossilHouseFishingGuruText
	text_end

.ReceivedGiftText:
	text_far _FuchsiaFossilHouseFishingGuruReceivedGiftText
	text_end

.ThatsSoDisappointingText:
	text_far _FuchsiaFossilHouseFishingGuruThatsSoDisappointingText
	text_end

.HowAreTheFishText:
	text_far _FuchsiaFossilHouseFishingGuruHowAreTheFishText
	text_end

.NoRoomText:
	text_far _FuchsiaFossilHouseFishingGuruNoRoomText
	text_end

FuchsiaFossilHouseOldWomanText:
	text_far _FuchsiaFossilHouseOldWomanText
	text_end
