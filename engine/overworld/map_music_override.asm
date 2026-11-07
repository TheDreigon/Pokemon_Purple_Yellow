; Map music that depends on the state of the world rather than only on which
; map you are standing in.
;
; MapSongBanks (data/maps/songs.asm) is a flat map-id -> song table with no
; room for "it depends". This runs immediately after that lookup, while its
; bank is still switched in, and may overwrite the result. Living in the same
; SECTION as the table is the point: the caller in home/overworld.asm pays
; three bytes for a `call` instead of the 62 the whole check costs now, and
; the home bank had under a hundred bytes left when this was written.
;
; Anything added here must be cheap and must fall through to the table by
; default, so a map with no special case behaves exactly as before.

; Trashes: a, hl
LoadMapMusicOverrides::

; SAFFRON CITY changes key when the city is freed.
;
; The table entry is Music_SaffronCity, which is the theme in A minor. That is
; what plays while Silph Co is occupied. Beat Giovanni on the top floor and
; this swaps in Music_SaffronFree: the SAME tune, transposed to A major and
; about ten percent faster. By design, and the reason it works is that there
; is nothing new to learn -- the city still sounds like itself, it just stops
; sounding grim.
;
; Note the direction. An earlier version of this had the override fire while
; the city was OCCUPIED (playing Silph Co's own theme) and fall back to the
; table afterwards. It now fires the other way round, so the table holds the
; state you spend most of the game in and the override is the reward.
;
; The outdoor map, and since v1.0 (2026-11-04) the SILPH CO floors and their
; elevator: once freed, the building plays the city's free theme too (and takes
; SAFFRON's colours back, GetPal_InheritedNoMore). While it is occupied it keeps
; MUSIC_SILPH_CO, its own theme. The houses, the gyms and the Dojo are separate
; map ids and never match these compares, so stepping into them still changes
; the music. The Dojo in particular keeps MUSIC_FIGHTING_DOJO permanently.
; SilphCo11FGiovanniAfterBattleScript calls this routine itself, in the dark
; after GIOVANNI's last words, so the free theme starts on 11F.
	ld a, [wCurMap]
	cp SAFFRON_CITY
	jr z, .saffron
	cp VIRIDIAN_GYM
	jr z, .viridianGym
	cp SILPH_CO_1F
	jr z, .saffron
	cp SILPH_CO_2F
	jr c, .notSilphCo2Fto8F
	cp SILPH_CO_8F + 1
	jr c, .saffron
.notSilphCo2Fto8F
	cp SILPH_CO_9F
	ret c
	cp SILPH_CO_ELEVATOR + 1
	ret nc
.saffron
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret z
	ld a, MUSIC_SAFFRON_FREE
	ld [wMapMusicSoundID], a
	ld a, BANK(Music_SaffronFree)
	ld [wMapMusicROMBank], a
	ret

; THE VIRIDIAN GYM changes hands after the League: KIYO holds the floor and
; brings the dojo's theme down from Saffron with him (2026-08-17).
; Same shape as Saffron's case — the table keeps the pre-League gym music,
; the override is the post-game state, and it covers every visit including
; just walking around talking to the gym trainers.
.viridianGym
	ld a, [wGameStage]
	and a
	ret z
	ld a, MUSIC_FIGHTING_DOJO
	ld [wMapMusicSoundID], a
	ld a, BANK(Music_FightingDojo)
	ld [wMapMusicROMBank], a
	ret
