TryFieldMove:: ; predef
	call GetPredefRegisters
	call TrySurf
	ret z
	call TryCut
	ret

TrySurf:
	ld a, [wWalkBikeSurfState]
	cp 2 ; is the player already surfing?
	jr z, .no
	farcall IsNextTileShoreOrWater
	jr nc, .no
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions2
	jr c, .no
	ld d, SURF
	call HasPartyMove
	jr nz, .no
	ld a, [wObtainedBadges]
	bit 4, a ; SOUL BADGE
	jr z, .no
	farcall IsSurfingAllowed
	ld hl, wd728
	bit 1, [hl]
	res 1, [hl]
	jr z, .no2
	call InitializeFieldMoveTextBox
	ld hl, PromptToSurfText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .no2
	call GetPartyMonName2
	ld a, SURFBOARD
	ld [wcf91], a
	ld [wPseudoItemID], a
	call UseItem
.yes2
	call CloseFieldMoveTextBox
.yes
	xor a
	ret
.no2
	call CloseFieldMoveTextBox
.no
	ld a, 1
	and a
	ret

TryCut:
	call IsCutTile
	jr nc, TrySurf.no
	call InitializeFieldMoveTextBox
	ld hl, ExplainCutText
	call PrintText
	call ManualTextScroll
	ld d, CUT
	call HasPartyMove
	jr nz, TrySurf.no2
	ld a, [wObtainedBadges]
	bit 1, a ; CASCADE BADGE
	jr z, TrySurf.no2
	ld hl, PromptToCutText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, TrySurf.no2
	call GetPartyMonName2
	farcall Cut2
	call CloseFieldMoveTextBox
	jr TrySurf.yes2

IsCutTile:
; partial copy from UsedCut
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .overworld
	cp GYM
	jr nz, .no
	ld a, [wTileInFrontOfPlayer]
	cp $50 ; gym cut tree
	jr nz, .no
	jr .yes
.overworld
	ld a, [wTileInFrontOfPlayer]
	cp $3d ; cut tree
	jr nz, .no
.yes
	scf
	ret
.no
	and a
	ret

HasPartyMove::
; Return z (optional: in wWhichTrade) if a PartyMon has move d.
; Updates wWhichPokemon.
	push bc
	push de
	push hl

	ld a, [wPartyCount]
	and a
	jr z, .no
	ld b, a
	ld c, 0
	ld hl, wPartyMons + (wPartyMon1Moves - wPartyMon1)
.loop
	ld e, NUM_MOVES
.check_move
	ld a, [hli]
	cp d
	jr z, .yes
	dec e
	jr nz, .check_move

	ld a, wPartyMon2 - wPartyMon1 - NUM_MOVES
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a

	inc c
	ld a, c
	cp b
	jr c, .loop
	jr .no

.yes
	ld a, c
	ld [wWhichPokemon], a
	xor a ; xor a ; NOT redundant: zeroes wWhichTrade, which BoulderText (home/overworld_text.asm) reads after calling HasPartyMove
	ld [wWhichTrade], a
	jr .done
.no
	ld a, 1
	and a
	ld [wWhichTrade], a
.done
	pop hl
	pop de
	pop bc
	ret

InitializeFieldMoveTextBox:
	call EnableAutoTextBoxDrawing
	ld a, 1 ; not 0
	ld [hSpriteIndexOrTextID], a
	farcall DisplayTextIDInit
	ret

CloseFieldMoveTextBox:
	ld a,[hLoadedROMBank]
	push af
	jp CloseTextDisplay

PromptToSurfText:
	text "The water is calm."
	line "Would you like to"
	cont "SURF?@@"

ExplainCutText:
	text "This tree can be"
	line "CUT!@@"

PromptToCutText:
	text "Would you like to"
	line "use CUT?@@"

; --- v0.7 "registered item" (his 2026-08-28 request) ------------------------
; SELECT in the overworld uses the key item bound via the bag's
; USE/INFO/TOSS box (RegisterKeyItem below). The overworld hook is in
; home/overworld.asm (predef TryUseRegisteredItem); registration rides the
; submenu in engine/menus/start_sub_menus.asm.

TryUseRegisteredItem::
	ld a, [wd730]
	bit 7, a ; simulated joypad input running?
	ret nz
	ld a, [wRegisteredItem]
	and a
	ret z ; nothing registered: SELECT stays silent
	ld b, a
	call IsItemInBag
	jr nz, .haveIt
; it was deposited (key items can live in the PC) -- unbind quietly
	xor a
	ld [wRegisteredItem], a
	ret
.haveIt
	ld a, [wRegisteredItem]
	cp BICYCLE
	jr nz, .use
; The "can't get off here" rule lives in the bag UI
; (start_sub_menus.asm), NOT in ItemUseBicycle -- without this copy,
; SELECT would dismount the player on Cycling Road. Same check, both
; sites commented (the family-of-the-value-left-behind pattern).
	ld a, [wd732]
	bit 5, a
	ret nz
	ld a, BICYCLE
.use
	ld [wcf91], a
	xor a
	ld [wPseudoItemID], a ; a real bag item, not a pseudo item
	call InitializeFieldMoveTextBox
	call UseItem
	jp CloseFieldMoveTextBox

RegisterKeyItem::
; In: wcf91 = the item the USE/INFO/TOSS box is open on.
	ld a, [wcf91]
	ld hl, RegistrableItems
	ld de, 1
	call IsInArray
	jr nc, .notRegistrable
	ld a, [wcf91]
	ld [wRegisteredItem], a
	ld [wd11e], a
	call GetItemName ; -> wcd6d, read by the text below
	ld hl, RegisteredItemText
	jp PrintText
.notRegistrable
	ld hl, CantRegisterItemText
	jp PrintText

RegistrableItems:
; field-usable key items whose UseItem handlers self-guard from a bare
; overworld frame (the bike gets the extra Cycling-Road copy above)
	db BICYCLE
	db OLD_ROD
	db GOOD_ROD
	db SUPER_ROD
	db ITEMFINDER
	db -1 ; end

RegisteredItemText:
	text "Registered the"
	line "@"
	text_ram wcd6d
	text "!"

	para "Press SELECT to"
	line "use it.@@"

CantRegisterItemText:
	text "Can't register"
	line "that.@@"
