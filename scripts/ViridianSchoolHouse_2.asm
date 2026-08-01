ViridianSchoolHousePrintLittleGirlText::
	ld hl, .text
	call PrintText
	ret

.text
	text_far _ViridianSchoolHouseLittleGirlText
	text_end

ViridianSchoolHousePrintCooltrainerFText::
; The teacher hands a TOWN MAP to any trainer who does not already have one.
;
; Deliberately NOT gated on the POKEDEX, unlike Daisy's copy in Blue's house.
; The DEX is Oak's own recent invention and almost no trainer in the world
; carries one, so a school that only equipped DEX holders would be a strange
; school. It also means the map is available on the FIRST pass through Viridian
; -- the OAK'S PARCEL errand -- which is exactly the walk where a map earns its
; keep, and it catches the many players who never enter Blue's house at all.
;
; Only one TOWN MAP can exist: both givers test EVENT_GOT_TOWN_MAP first, so
; whichever hands it over, the other stands down (Daisy falls through to her
; "use the TOWN MAP to find out where you are" line).
	CheckEvent EVENT_GOT_TOWN_MAP
	jr nz, .blackboard
	ld hl, .OfferMapText
	call PrintText
	lb bc, TOWN_MAP, 1
	call GiveItem
	jr nc, .bag_full            ; carry = success; never set the flag on failure
	ld a, HS_TOWN_MAP
	ld [wMissableObjectIndex], a
	predef HideObject           ; the spare map on Daisy's table
	SetEvent EVENT_GOT_TOWN_MAP
	ld hl, .GotMapText
	jr .print
.bag_full
	ld hl, .BagFullText
	jr .print
.blackboard
	ld hl, .text
.print
	call PrintText
	ret

.OfferMapText
	text_far _ViridianSchoolHouseOfferMapText
	text_end

.GotMapText
	text_far _GotMapText
	sound_get_key_item
	text_end

.BagFullText
	text_far _ViridianSchoolHouseMapBagFullText
	text_end

.text
	text_far _ViridianSchoolHouseCooltrainerFText
	text_end
