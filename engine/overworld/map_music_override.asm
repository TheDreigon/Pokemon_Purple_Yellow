; Map music that depends on the state of the world rather than only on which
; map you are standing in.
;
; MapSongBanks (data/maps/songs.asm) is a flat map-id -> song table with no
; room for "it depends". This runs immediately after that lookup, while its
; bank is still switched in, and may overwrite the result. Living in the same
; SECTION as the table is the point: the caller in home/overworld.asm pays
; three bytes for a `call` instead of the ~23 the whole check would cost, and
; the home bank has under a hundred bytes left.
;
; Anything added here must be cheap and must fall through to the table by
; default, so a map with no special case behaves exactly as before.

; ⚠ TEMPORARY, 2026-07-29. Set back to 1 to arm the occupation music.
;
; Forte asked to audition the LIBERATED Saffron theme without having to beat
; Giovanni first, so while this is 0 the override is skipped and Saffron plays
; its table entry (Music_SaffronLiberated) from the moment you walk in. Once he
; signs the track off, flip this to 1 and the occupation music is live again --
; nothing else has to change.
DEF SAFFRON_OCCUPATION_MUSIC_ARMED EQU 0

; Trashes: a, hl
LoadMapMusicOverrides::

IF SAFFRON_OCCUPATION_MUSIC_ARMED
; SAFFRON CITY, while Silph Co is still occupied, plays Silph Co's own theme.
; The company town sounds like the company. Beating Giovanni on the top floor
; lifts it and the city falls back to whatever the table says.
;
; Only the outdoor map is affected, which is what Forte asked for: the houses,
; the gyms, the Dojo and the Silph floors are all separate map ids and never
; match this compare, so stepping indoors still changes the music.
	ld a, [wCurMap]
	cp SAFFRON_CITY
	ret nz
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret nz
	ld a, MUSIC_SILPH_CO
	ld [wMapMusicSoundID], a
	ld a, BANK(Music_SilphCo)
	ld [wMapMusicROMBank], a
ENDC
	ret
