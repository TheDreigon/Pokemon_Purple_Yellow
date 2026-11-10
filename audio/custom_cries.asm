; v1.0 (2026-11-10): custom cries - species whose cry is data of their own, not one of the 38 base cries.
;
; INCLUDEd at the end of every audio engine (audio/engine_1.asm .. engine_5.asm), after DEF CUSTOM_CRY_ENGINE = <n>:
; each of the five audio banks ($02, $08, $1F, $20, $42) holds its own copy of the lookup, the table and the data,
; because the music engine reads every channel's bytes from wAudioROMBank (GetNextMusicByte), whichever bank it is.
;
; GetCryData (home/pokemon.asm) leaves the species in wCrySpecies and returns its CryData row as always: the base
; cry's sound id, the pitch and the length. AudioN_PlaySound finds every sound's header through
; AudioN_GetSfxHeader: when wCrySpecies is a species of this table AND the sound is that species' base cry, the
; header is the species' own instead of the base cry's. Everything else is the engine's usual path: the same
; channels and priority checks, the base cry's sound id on channels 5-8 (so the cry's pitch and length modifiers
; apply, GROWL's included), CHAN7 pointed at CryRet. GetCryData sets both halves of the key from the same row, and
; no caller changes either: GROWL adds to the pitch and length bytes only, and plays the sound id it was given.
;
; A species of this table keeps a real base cry in data/pokemon/cries.asm, the one its row names: its data is
; written for that row's pitch and length, and that base cry is what a path without this lookup would play.
;
; A new custom cry: a custom_cry row below (the species, the SFX_CRY_xx of its CryData row, its data's name), its
; data file (labels Audio{d:CUSTOM_CRY_ENGINE}_<Name>_Ch5 / _Ch6 / _Ch8, each block ending in sound_ret, like
; audio/sfx/cry_dreadrow.asm) and that file's INCLUDE at the bottom. Each costs its data plus 11 bytes in EACH of the
; five banks; bank $02 is the tightest.

; The key's id half is counted in SFX_Headers_1 (GetCryData's arithmetic), so every bank must hold the 38 base cries
; at the same ids - bank $42's own ASSERTs (audio/headers/sfxheaders5.asm) say it for that bank alone.
ASSERT SFX_Cry00_{d:CUSTOM_CRY_ENGINE} - SFX_Headers_{d:CUSTOM_CRY_ENGINE} == SFX_Cry00_1 - SFX_Headers_1
ASSERT SFX_Cry25_{d:CUSTOM_CRY_ENGINE} - SFX_Headers_{d:CUSTOM_CRY_ENGINE} == SFX_Cry25_1 - SFX_Headers_1

Audio{d:CUSTOM_CRY_ENGINE}_GetSfxHeader:
; a = sound id -> hl = its header in this bank: SFX_Headers_<n> + 3 * id, or the species' own header when a is a base
; cry and (wCrySpecies, a) is a row of the table. Clobbers a, bc, de. A music drum note reaches it from VBlank (a
; noise instrument through DetermineAudioFunction), so it keeps no state of its own; anything that is not a base cry
; (drum notes, sound effects, songs) leaves at the range test, so the table's length costs nothing there.
	ld e, a
	sub CRY_SFX_START
	cp CRY_SFX_END - CRY_SFX_START
	jr nc, .standard ; not one of the 38 base cries
	ld a, [wCrySpecies]
	ld d, a
	ld hl, Audio{d:CUSTOM_CRY_ENGINE}_CustomCries
	ld bc, 3 * 3 ; the rest of a row: its 3-channel header
.find
	ld a, [hli] ; the species
	and a
	jr z, .standard ; the end of the table
	cp d
	ld a, [hli] ; its base cry
	jr nz, .next
	cp e
	ret z ; hl = that species' own header
.next
	add hl, bc
	jr .find
.standard
	ld l, e
	ld h, 0
	ld d, h
	add hl, hl
	add hl, de
	ld de, SFX_Headers_{d:CUSTOM_CRY_ENGINE}
	add hl, de
	ret

Audio{d:CUSTOM_CRY_ENGINE}_CustomCries:
	custom_cry DREADROW, SFX_CRY_18, CryDreadrow ; G5
	db 0 ; end

INCLUDE "audio/sfx/cry_dreadrow.asm"
