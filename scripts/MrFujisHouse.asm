MrFujisHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

MrFujisHouse_TextPointers:
	def_text_pointers
	dw_const MrFujisHouseSuperNerdText,     TEXT_MRFUJISHOUSE_SUPER_NERD
	dw_const MrFujisHouseLittleGirlText,    TEXT_MRFUJISHOUSE_LITTLE_GIRL
	dw_const MrFujisHousePsyduckText,       TEXT_MRFUJISHOUSE_PSYDUCK
	dw_const MrFujisHouseNidorinoText,      TEXT_MRFUJISHOUSE_NIDORINO
	dw_const MrFujisHouseMrFujiText,        TEXT_MRFUJISHOUSE_MR_FUJI
	dw_const MrFujisHouseMrFujiPokedexText, TEXT_MRFUJISHOUSE_POKEDEX
	dw_const MrFujisHouseCuboneText,        TEXT_MRFUJISHOUSE_CUBONE ; v1.0 (2026-09-23)

MrFujisHouseSuperNerdText:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, .MrFujiIsntHereText
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, .MrFujiHadBeenPrayingText
	call PrintText
.done
	jp TextScriptEnd

.MrFujiIsntHereText:
	text_far _MrFujisHouseSuperNerdMrFujiIsntHereText
	text_end

.MrFujiHadBeenPrayingText:
	text_far _MrFujisHouseSuperNerdMrFujiHadBeenPrayingText
	text_end

MrFujisHouseLittleGirlText:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, .ThisIsMrFujisHouseText
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, .PokemonAreNiceToHugText
	call PrintText
.done
	jp TextScriptEnd

.ThisIsMrFujisHouseText:
	text_far _MrFujisHouseLittleGirlThisIsMrFujisHouseText
	text_end

.PokemonAreNiceToHugText:
	text_far _MrFujisHouseLittleGirlPokemonAreNiceToHugText
	text_end

MrFujisHousePsyduckText:
	text_far _MrFujisHousePsyduckText
	text_asm
	ld a, PSYDUCK
	call PlayCry
	jp TextScriptEnd

MrFujisHouseNidorinoText:
	text_far _MrFujisHouseNidorinoText
	text_asm
	ld a, NIDORINO
	call PlayCry
	jp TextScriptEnd

MrFujisHouseMrFujiText:
	text_asm
	CheckEvent EVENT_GOT_POKE_FLUTE
	jr nz, .got_item
	ld hl, .IThinkThisMayHelpYourQuestText
	call PrintText
	lb bc, POKE_FLUTE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedPokeFluteText
	call PrintText
	SetEvent EVENT_GOT_POKE_FLUTE
; v1.0 (Forte, 2026-09-23): the flute scene ends in `done`, which does not
; wait - hold its last page, then make the offer
	call WaitForTextScrollButtonPress
	ld hl, MrFujisHouseCuboneOfferText
	call MrFujisHouseOfferCubone
	jr .done
.bag_full
	ld hl, .PokeFluteNoRoomText
	call PrintText
	jr .done
.got_item
; v1.0 (Forte, 2026-09-23): until the orphan leaves with the player, every
; later talk asks again (a refusal and a full party set nothing)
	CheckEvent EVENT_GOT_FUJI_CUBONE
	jr nz, .has_cubone
	ld hl, MrFujisHouseCuboneAgainText
	call MrFujisHouseOfferCubone
	jr .done
.has_cubone
	ld hl, .HowIsSheText
	call PrintText
.done
	jp TextScriptEnd

.IThinkThisMayHelpYourQuestText:
	text_far _MrFujisHouseMrFujiIThinkThisMayHelpYourQuestText
	text_end

.ReceivedPokeFluteText:
	text_far _MrFujisHouseMrFujiReceivedPokeFluteText
	sound_get_key_item
	text_far _MrFujisHouseMrFujiPokeFluteExplanationText
	text_end

.PokeFluteNoRoomText:
	text_far _MrFujisHouseMrFujiPokeFluteNoRoomText
	text_end

.HowIsSheText:
	text_far _MrFujisHouseMrFujiHowIsSheText
	text_end

; v1.0 (Forte, 2026-09-23): the orphan CUBONE of the TOWER, who lives here in
; his Volunteer House (object (1,5)). Her mother is the MAROWAK the player laid
; to rest, which is why it is her he offers, and to this player. hl = the
; offer to print (first time or a later re-ask). YES -> she joins the PARTY
; only (his own words: a life in a PC box is no better than his house), the
; flag and the hide happen only when GivePokemon succeeded; NO or a full
; party set nothing, so he asks again next time. Speech before the gift:
; GivePokemon prints its own "got CUBONE!" with the jingle.
MrFujisHouseOfferCubone:
	call PrintText
	xor a
	ld [wMenuJoypadPollCount], a ; a stale poll count would phantom-accept
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .party_full
	ld hl, .TakeHerText
	call PrintText
	lb bc, CUBONE, 25
	call GivePokemon
	jr nc, .party_full ; cannot happen after the count check; keeps the contract
	SetEvent EVENT_GOT_FUJI_CUBONE
	ld a, HS2_MR_FUJIS_HOUSE_CUBONE
	ld [wMissableObjectIndex], a
	farcall HideObject_HS2 ; she is on this map: gone from the room at once (second hide/show table, T23)
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a ; the party path leaves it set
	ld hl, .FarewellText
	jp PrintText
.party_full
	ld hl, .BetterWithMeText
	jp PrintText
.refused
	ld hl, .SheStaysText
	jp PrintText

.TakeHerText:
	text_far _MrFujisHouseMrFujiTakeHerText
	text_end

.FarewellText:
	text_far _MrFujisHouseMrFujiCuboneFarewellText
	text_end

.BetterWithMeText:
	text_far _MrFujisHouseMrFujiBetterWithMeText
	text_end

.SheStaysText:
	text_far _MrFujisHouseMrFujiSheStaysText
	text_end

MrFujisHouseCuboneOfferText:
	text_far _MrFujisHouseMrFujiCuboneOfferText
	text_end

MrFujisHouseCuboneAgainText:
	text_far _MrFujisHouseMrFujiCuboneAgainText
	text_end

MrFujisHouseMrFujiPokedexText:
	text_far _MrFujisHouseMrFujiPokedexText
	text_end

; v1.0 (2026-09-23): the orphan's own line, kept from her old house
MrFujisHouseCuboneText:
	text_far _LavenderCuboneHouseCuboneText
	text_asm
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd
