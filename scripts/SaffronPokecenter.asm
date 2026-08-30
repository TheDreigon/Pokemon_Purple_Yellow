SaffronPokecenter_Script:
	call SaffronPokecenterAidesAmbush
	jp EnableAutoTextBoxDrawing

; v0.7 (2026-08-30, Forte's design, v2): PROF.OAK's two aides wait here
; with the ITEMFINDER and the EXP.SHARE - no dex quota, no gate trek.
; They pounce when the player reaches the counter strip (rows 3-4: the
; nurse, the PC, anything up there), and per Forte's rule the delivery is
; BOTH parcels or neither - a packed bag gets a direct "two free slots"
; demand instead. The ambush event is set inside the delivery and
; RE-ARMED on every map entry while a parcel is still owed, so the scene
; repeats each visit until it lands, yet can never text-lock a player
; standing at the counter. Talking to either aide retries any time.
SaffronPokecenterAidesAmbush:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	jr z, .armed
	CheckEvent EVENT_GOT_ITEMFINDER
	jr z, .rearm
	CheckEvent EVENT_GOT_EXP_ALL
	jr nz, .armed
.rearm
	ResetEvent EVENT_SAFFRON_AIDES_AMBUSHED
.armed
	CheckEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ret nz
	ld a, [wYCoord]
	cp 5
	ret nc ; the ambush zone is the counter strip, rows 3-4
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

; Shared by both aides and the ambush. Forte's v2 rule: BOTH parcels at
; once or neither - a bag without two free slots gets the direct
; make-room line and nothing else. Returns CARRY when there was nothing
; left to deliver (the caller then prints his sign-off line).
SaffronAidesDeliverParcels:
	SetEvent EVENT_SAFFRON_AIDES_AMBUSHED
	CheckEvent EVENT_GOT_ITEMFINDER
	jr nz, .expShare
	CheckEvent EVENT_GOT_EXP_ALL ; different flag byte - no ReuseA here
	jr nz, .parcelA ; degenerate half-state: hand the missing one quietly
; the normal case: both owed. Two NEW key items = two bag slots, so the
; capacity check up front GUARANTEES both GiveItems below land.
	ld a, [wNumBagItems]
	cp BAG_ITEM_CAPACITY - 1
	jr nc, .makeRoom
	ld hl, .GreetingText
	call PrintText
.parcelA
	lb bc, ITEMFINDER, 1
	call GiveItem
	jr nc, .expShare ; unreachable after the capacity check; defensive
	ld hl, .ItemfinderReceivedText
	call PrintText
	SetEvent EVENT_GOT_ITEMFINDER
	ld hl, .ItemfinderDescText
	call PrintText
; the description ends in `done`, which does not wait - without this the
; second aide's line would replace its last page unread (house rule)
	farcall NewPageButtonPressCheck
.expShare
	CheckEvent EVENT_GOT_EXP_ALL
	jr nz, .nothingOwed
	ld hl, .ExpShareIntroText
	call PrintText
	lb bc, EXP_ALL, 1
	call GiveItem
	jr nc, .deliveredSomething ; defensive, as above
	ld hl, .ExpShareReceivedText
	call PrintText
	SetEvent EVENT_GOT_EXP_ALL
	ld hl, .ExpShareDescText
	call PrintText
.deliveredSomething
	and a ; nc: this talk already said plenty
	ret
.makeRoom
	ld hl, .MakeRoomText
	call PrintText
	jr .deliveredSomething
.nothingOwed
	scf
	ret

.GreetingText:
	text_far _SaffronAidesGreetingText
	text_end

.MakeRoomText:
	text_far _SaffronAidesMakeRoomText
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
