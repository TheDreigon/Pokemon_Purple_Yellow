SaffronPokecenter_Script:
	call SaffronPokecenterAidesAmbush
	jp EnableAutoTextBoxDrawing

; v0.7 (2026-08-30, Forte's design): PROF.OAK's two aides wait here with
; the ITEMFINDER and the EXP.SHARE - no dex quota, no gate trek. They
; flank the nurse spot, and the first time the player steps onto (3,3)
; they force the delivery before the nurse can even say hello. The
; one-shot event is set inside the shared delivery routine, so a player
; with a full bag is never text-locked at the counter - the retries come
; from talking to either aide directly.
SaffronPokecenterAidesAmbush:
	CheckEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ret nz
	ld a, [wYCoord]
	cp 3
	ret nz
	ld a, [wXCoord]
	cp 3
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

SaffronPokecenter_TextPointers:
	def_text_pointers
	dw_const SaffronPokecenterNurseText,            TEXT_SAFFRONPOKECENTER_NURSE
	dw_const SaffronPokecenterBeautyText,           TEXT_SAFFRONPOKECENTER_BEAUTY
	dw_const SaffronPokecenterGentlemanText,        TEXT_SAFFRONPOKECENTER_GENTLEMAN
	dw_const SaffronPokecenterChanseyText,          TEXT_SAFFRONPOKECENTER_CHANSEY
	dw_const SaffronPokecenterAide1Text,            TEXT_SAFFRONPOKECENTER_AIDE1
	dw_const SaffronPokecenterAide2Text,            TEXT_SAFFRONPOKECENTER_AIDE2

SaffronPokecenterNurseText:
	script_pokecenter_nurse

SaffronPokecenterBeautyText:
	text_far _SaffronPokecenterBeautyText
	text_end

SaffronPokecenterGentlemanText:
	text_far _SaffronPokecenterGentlemanText
	text_end

SaffronPokecenterChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; Each aide runs the shared delivery, then signs off in his own voice:
; afraid of TEAM ROCKET while they hold the town, packing for the lab once
; they are gone. (Forte wanted them to physically leave at liberation, but
; the missable array is at its hard 256-slot cap - byte-indexed, so it
; cannot grow like the event array did. Until an HS-slot audit frees two
; slots, the farewell line stands in for the exit.)
SaffronPokecenterAide1Text:
	text_asm
	call SaffronAidesDeliverParcels
	jr nc, .done ; something was still owed: the delivery said it all
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, SaffronAidesSafeText
	jr nz, .print
	ld hl, .FearText
.print
	call PrintText
.done
	jp TextScriptEnd

.FearText:
	text_far _SaffronAide1FearText
	text_end

SaffronPokecenterAide2Text:
	text_asm
	call SaffronAidesDeliverParcels
	jr nc, .done
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, SaffronAidesSafeText
	jr nz, .print
	ld hl, .FearText
.print
	call PrintText
.done
	jp TextScriptEnd

.FearText:
	text_far _SaffronAide2FearText
	text_end

SaffronAidesSafeText:
	text_far _SaffronAidesSafeText
	text_end

; Shared by both aides and the ambush. Hands over whatever parcel is still
; owed; each flag is set only when its GiveItem lands, so a full bag defers
; that parcel to the next talk. Returns CARRY when there was nothing left
; to deliver (the caller then prints his sign-off line).
SaffronAidesDeliverParcels:
	SetEvent EVENT_SAFFRON_AIDES_AMBUSHED
	CheckEvent EVENT_GOT_ITEMFINDER
	jr nz, .expShare
	CheckEvent EVENT_GOT_EXP_ALL ; different flag byte - no ReuseA here
	jr nz, .shortGreet
	ld hl, .GreetingText
	call PrintText
	jr .parcelA
.shortGreet
	ld hl, .StillYoursText
	call PrintText
.parcelA
	lb bc, ITEMFINDER, 1
	call GiveItem
	jr nc, .bagFullA
	ld hl, .ItemfinderReceivedText
	call PrintText
	SetEvent EVENT_GOT_ITEMFINDER
	ld hl, .ItemfinderDescText
	call PrintText
; the description ends in `done`, which does not wait - without this the
; second aide's line would replace its last page unread (house rule)
	farcall NewPageButtonPressCheck
	jr .expShare
.bagFullA
	ld hl, .NoRoomText
	call PrintText
.expShare
	CheckEvent EVENT_GOT_EXP_ALL
	jr nz, .nothingOwed
	ld hl, .ExpShareIntroText
	call PrintText
	lb bc, EXP_ALL, 1
	call GiveItem
	jr nc, .bagFullB
	ld hl, .ExpShareReceivedText
	call PrintText
	SetEvent EVENT_GOT_EXP_ALL
	ld hl, .ExpShareDescText
	call PrintText
.deliveredSomething
	and a ; nc: this talk already said plenty
	ret
.bagFullB
	ld hl, .NoRoomText
	call PrintText
	jr .deliveredSomething
.nothingOwed
	scf
	ret

.GreetingText:
	text_far _SaffronAidesGreetingText
	text_end

.StillYoursText:
	text_far _SaffronAidesStillYoursText
	text_end

.ItemfinderReceivedText:
	text_far _SaffronAideItemfinderReceivedText
	sound_get_key_item
	text_promptbutton
	text_end

.ItemfinderDescText:
	text_far _Route11Gate2FOaksAideItemfinderDescriptionText
	text_end

.ExpShareIntroText:
	text_far _SaffronAideExpShareIntroText
	text_end

.ExpShareReceivedText:
	text_far _SaffronAideExpShareReceivedText
	sound_get_key_item
	text_promptbutton
	text_end

.ExpShareDescText:
	text_far _Route15Gate2FOaksAideExpAllText
	text_end

.NoRoomText:
	text_far _SaffronAidesNoRoomText
	text_end
