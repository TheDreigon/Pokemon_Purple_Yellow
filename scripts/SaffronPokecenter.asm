SaffronPokecenter_Script:
	call SaffronPokecenterAidesScene
	jp EnableAutoTextBoxDrawing

; v0.7 (2026-08-30, Forte's design, v3): PROF.OAK's two aides wait here
; with the ITEMFINDER and the EXP.SHARE - no dex quota, no gate trek.
; The moment the player walks in (spawn is (3,7), the city warp targets
; warp 1), the scene freezes the pad and walks both aides three steps
; down, side by side, to (2,6) and (4,6), the player's two diagonals.
; Delivery is BOTH parcels or neither (a packed bag gets the direct "two
; free slots" demand), then they walk back up together. The scene re-arms
; on every map entry while a parcel is owed, so it repeats each visit until
; it lands; talking to either aide also retries. The stage rides
; wSavedCoordIndex, the dojo's own in-map carrier - no new WRAM. Once both
; parcels are delivered AND EVENT_BEAT_SILPH_CO_GIOVANNI is set, the
; on-entry branch hides both aides for good: they went home to the lab (the
; two HS slots came from the CERULEAN CAVE ULTRA BALL conversions).
;
; v0.7 (2026-09-05, Forte's playtest): the walks were one aide at a time
; (the J&J idiom) and one aide talked with his back turned. Both had the
; same root: MoveSprite leaves a sprite's movement byte 2 at $FF, and a
; STAY sprite with $FF there turns to face a random way every so often -
; so the aide who had finished walking stood turning at random while the
; other walked, and the text froze him wherever he happened to look. Now
; the two walk in lockstep (SaffronAidesWalkBoth) and their byte 2 holds
; the facing the walk ends in. Scripted steps ignore collision
; (CanWalkOntoTile), so a wandering GENTLEMAN in a column is walked
; through, not around - cosmetic, one step. Two more cosmetic edges the
; review noted, both pre-existing: the scene re-arms on ANY map entry while
; a parcel is owed, so a save-and-reload inside the Center after a "make
; room" refusal plays it with the player wherever they stand (the delivery
; still lands); and about once in a hundred entries one aide happens to be
; mid-refresh (movement status 2) when the walk starts and sets off one
; frame after the other - one pixel, invisible.
SaffronPokecenterAidesScene:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	jr z, .runScene
	xor a
	ld [wSavedCoordIndex], a ; scene stage: idle
	CheckEvent EVENT_GOT_ITEMFINDER
	jr z, .rearm
	CheckEvent EVENT_GOT_EXP_SHARE
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
	ld a, [wSavedCoordIndex]
	and a
	jr z, .maybeStart
	dec a
	jr z, .waitDown
	dec a
	jr z, .waitUp
	ret ; stage 3: scene done this visit
.maybeStart
	CheckEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ret nz
	SetEvent EVENT_SAFFRON_AIDES_AMBUSHED
	ld a, $ff
	ld [wJoyIgnore], a
	xor a
	ldh [hJoyHeld], a
	ld de, SaffronAidesWalkDown
	ld b, DOWN
	call SaffronAidesWalkBoth
	ld a, 1
	ld [wSavedCoordIndex], a
	ret
.waitDown
	call SaffronAidesStillWalking
	ret nz
; both at the player's diagonals, held facing DOWN: the talk, then the walk home
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, TEXT_SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ld de, SaffronAidesWalkUp
	ld b, UP
	call SaffronAidesWalkBoth
	ld a, 2
	ld [wSavedCoordIndex], a
	ret
.waitUp
	call SaffronAidesStillWalking
	ret nz
; back at their posts, held facing UP at the counter (reads as chatting with
; the nurse) until the next map load resets them to DOWN
	xor a
	ld [wJoyIgnore], a
	ld a, 3
	ld [wSavedCoordIndex], a
	ret

; de = the walk, b = the STAY facing (DOWN or UP) the walk ends in.
; MoveSprite copies the steps into wNPCMovementDirections - the engine's one
; buffer - and starts AIDE1 down it; AIDE2 is then pointed at index 0 of the
; same buffer. Each sprite keeps its own index in its movement byte 1 and the
; walk is the same three steps for both, so they move in lockstep. Then each
; aide's movement byte 2 gets the facing: during a scripted walk the engine
; lets a DOWN/UP/LEFT/RIGHT there override the step (here it agrees with every
; step), and once the walk has ended it is what the standing sprite holds -
; written now, before the walk, so there is no frame in which the $FF that
; MoveSprite leaves could let a finished aide turn at random.
; (wNPCNumScriptedSteps gets decremented by BOTH sprites and ends below
; zero; nothing in this map reads it - its only readers are Oak's Lab's own
; scene, after its own MoveSprite - so leave it be.)
SaffronAidesWalkBoth:
	ld a, SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndex], a
	call MoveSprite
	call GetSpriteMovementByte2Pointer
	ld [hl], b
	ld a, SAFFRONPOKECENTER_AIDE2
	ldh [hSpriteIndex], a
	call GetSpriteMovementByte1Pointer
	ld [hl], 0 ; index 0: scripted, from the first step
	call GetSpriteMovementByte2Pointer
	ld [hl], b
	ret

; nz while either aide is still on the walk: movement byte 1 is the step
; index while walking and STAY once the engine has read the terminator.
; (wd730 bit 0 is one flag for the whole engine - whichever sprite finishes
; first clears it - so it cannot stand for "both done".)
SaffronAidesStillWalking:
	ld a, SAFFRONPOKECENTER_AIDE1
	ldh [hSpriteIndex], a
	call GetSpriteMovementByte1Pointer
	ld a, [hl]
	cp STAY
	ret nz
	ld a, SAFFRONPOKECENTER_AIDE2
	ldh [hSpriteIndex], a
	call GetSpriteMovementByte1Pointer
	ld a, [hl]
	cp STAY
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
	CheckEvent EVENT_GOT_EXP_SHARE ; different flag byte - no ReuseA here
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
	CheckEvent EVENT_GOT_EXP_SHARE
	jr nz, .nothingOwed
	ld hl, .ExpShareIntroText
	call PrintText
	lb bc, EXP_SHARE, 1
	call GiveItem
	jr nc, .deliveredSomething ; defensive, as above
	ld hl, .ExpShareReceivedText
	call PrintText
	SetEvent EVENT_GOT_EXP_SHARE
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
	text_far _Route15Gate2FOaksAideExpShareText
	text_end
