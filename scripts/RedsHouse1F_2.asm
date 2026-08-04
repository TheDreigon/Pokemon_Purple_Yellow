RedsHouse1FPrintMomText::
	CheckEvent EVENT_MOM_CONGRATULATE_CHAMPION
	jr nz, .continue
	ld a, [wGameStage]
	and a
	jr z, .continue ; skip if not beat the game
	ld hl, RedsHouse1FMomChampionText
	call PrintText
	SetEvent EVENT_MOM_CONGRATULATE_CHAMPION
	jr .done
.continue
	ld a, [wd72e]
	bit 3, a ; received a Pokémon from Oak?
	jr z, .notLeftYet
; v0.7: the TRAINER MANUAL. A player who goes home to say goodbye before
; leaving gets it here rather than being chased down at the edge of town --
; same book, same event, her own words for it. Whichever happens first, the
; event closes the other off.
	CheckEvent EVENT_GOT_TRAINER_MANUAL
	jr nz, RedsHouse1FMomHealScript
	CheckEvent EVENT_GOT_POKEDEX
	jr z, RedsHouse1FMomHealScript
	jp RedsHouse1FMomGiveManualScript
.notLeftYet
	ld hl, .WakeUpText
	call PrintText
.done
	ret

.WakeUpText:
	text_far _RedsHouse1FMomWakeUpText
	text_end
RedsHouse1FMomChampionText:
	text_far _RedsHouse1FMomChampionText
	text_end

; The give is guarded by the event and the event is only set on success: a full
; bag must not swallow the book.
RedsHouse1FMomGiveManualScript:
	ld hl, .GoodbyeText
	call PrintText
	lb bc, TRAINER_MANUAL, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_TRAINER_MANUAL
; Two PrintText calls rather than one chained pair of text_fars -- chaining runs
; the second into the box the first just closed. See scripts/PalletTown.asm.
	ld hl, .GotItText
	call PrintText
	ld hl, .ExplainText
	jr .print
.bagFull
	ld hl, .BagFullText
.print
	call PrintText
	ret

.GoodbyeText
	text_far _RedsHouse1FMomGoodbyeManualText
	text_end

; The receive line, what the book is for, and the full-bag line are the same
; words she uses outdoors: one voice, and one copy in the ROM.
.GotItText
	text_far _PalletTownMomGotManualText
	sound_get_key_item
	text_promptbutton
	text_end

.ExplainText
	text_far _PalletTownMomExplainText
	text_end

.BagFullText
	text_far _PalletTownMomBagFullText
	text_end

RedsHouse1FMomHealScript:
	ld hl, RedsHouse1FMomYouShouldRestText
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	predef HealParty
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	ld a, [wMapMusicSoundID]
	ld [wNewSoundID], a
	call PlaySound
	call GBFadeInFromWhite
	ld hl, RedsHouse1FMomLookingGreatText
	call PrintText
	ret

RedsHouse1FMomYouShouldRestText:
	text_far _RedsHouse1FMomYouShouldRestText
	text_end
RedsHouse1FMomLookingGreatText:
	text_far _RedsHouse1FMomLookingGreatText
	text_end

RedsHouse1FPrintTVText::
	ld hl, .WrongSideText
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, .got_text
	ld hl, .StandByMeMovieText
.got_text
	call PrintText
	ret

.StandByMeMovieText:
	text_far _RedsHouse1FTVStandByMeMovieText
	text_end

.WrongSideText:
	text_far _RedsHouse1FTVWrongSideText
	text_end
