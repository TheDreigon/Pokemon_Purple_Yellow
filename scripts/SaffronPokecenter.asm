SaffronPokecenter_Script:
	call SaffronPokecenterAidesScene
	jp EnableAutoTextBoxDrawing

; v0.7 (2026-08-30, Forte's design, v3): PROF.OAK's two aides wait here
; with the ITEMFINDER and the EXP.SHARE - no dex quota, no gate trek.
; The moment the player walks in (spawn is (3,7), the city warp targets
; warp 1), the scene freezes the pad and walks each aide three steps
; down - the J&J idiom, one MoveSprite at a time - to (2,6) and (4,6),
; the player's two diagonals. Delivery is BOTH parcels or neither (a
; packed bag gets the direct "two free slots" demand), then they walk
; back up. The scene re-arms on every map entry while a parcel is owed,
; so it repeats each visit until it lands; talking to either aide also
; retries. The stage rides wSavedCoordIndex, the dojo's own in-map
; carrier - no new WRAM. Once both parcels are delivered AND
; EVENT_BEAT_SILPH_CO_GIOVANNI is set, the on-entry branch hides both
; aides for good: they went home to the lab (the two HS slots came from
; the CERULEAN CAVE ULTRA BALL conversions).
; Known cosmetic edge: if the wandering GENTLEMAN happens to stand in a
; walk column, the blocked steps are consumed and the aide stops short -
; the scene still completes (proven class, see the Bill walk notes).
SaffronPokecenterAidesScene:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	jp z, .runScene ; jp, not jr: the entry block below is ~130 bytes deep
	xor a
	ld [wSavedCoordIndex], a ; scene stage: idle
	CheckEvent EVENT_GOT_ITEMFINDER
	jr z, .rearm
	CheckEvent EVENT_GOT_EXP_ALL
	jr z, .rearm
; both delivered: once TEAM ROCKET is gone, so are they
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret z
	ld a, HS_SAFFRON_POKECENTER_AIDE_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_SAFFRON_POKECENTER_AIDE_2
	ld [wMissableObjectIndex], a
	predef HideObject
	ret
.rearm
	ResetEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ret
.runScene
; jp, not jr: the later stage bodies sit past a jr's reach from here
	ld a, [wSavedCoordIndex]
	and a
	jr z, .maybeStart
	dec a
	jp z, .waitAide1Down
	dec a
	jp z, .waitAide2Down
	dec a
	jp z, .waitAide1Up
	dec a
	jp z, .waitAide2Up
	ret ; stage 5+: scene done this visit
.maybeStart
	CheckEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ret nz
	SetEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ld a, $ff
	ld [wJoyIgnore], a
	xor a
	ldh [hJoyHeld], a
	ld a, SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SAFFRONPOKECENTER_AIDE2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, SaffronAidesWalkDown
	ld a, SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 1
	ld [wSavedCoordIndex], a
	ret
.waitAide1Down
	ld a, [wd730]
	bit 0, a
	ret nz
	ld de, SaffronAidesWalkDown
	ld a, SAFFRONPOKECENTER_AIDE2
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 2
	ld [wSavedCoordIndex], a
	ret
.waitAide2Down
	ld a, [wd730]
	bit 0, a
	ret nz
; both in place at the player's diagonals: the talk, then the walk home
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, TEXT_SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ld de, SaffronAidesWalkUp
	ld a, SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 3
	ld [wSavedCoordIndex], a
	ret
.waitAide1Up
	ld a, [wd730]
	bit 0, a
	ret nz
	ld de, SaffronAidesWalkUp
	ld a, SAFFRONPOKECENTER_AIDE2
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 4
	ld [wSavedCoordIndex], a
	ret
.waitAide2Up
	ld a, [wd730]
	bit 0, a
	ret nz
; back at their posts (facing UP at the counter until the next map load
; resets them to DOWN - reads as chatting with the nurse, left alone)
	xor a
	ld [wJoyIgnore], a
	ld a, 5
	ld [wSavedCoordIndex], a
	ret

SaffronAidesWalkDown:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SaffronAidesWalkUp:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

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
; they are gone - and once they are gone AND both parcels are delivered,
; the on-entry branch above really does hide them (the two HS slots were
; funded by the CERULEAN CAVE ULTRA BALL conversions and live as the
; contiguous SaffronPokecenterHS block at the array's end).
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
