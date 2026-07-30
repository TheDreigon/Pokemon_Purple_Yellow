Music_SurfingPikachu::
	channel_count 3
	channel 1, Music_SurfingPikachu_Ch1
	channel 2, Music_SurfingPikachu_Ch2
	channel 3, Music_SurfingPikachu_Ch3

Music_MeetJessieJames::
	channel_count 3
	channel 1, Music_MeetJessieJames_Ch1
	channel 2, Music_MeetJessieJames_Ch2
	channel 3, Music_MeetJessieJames_Ch3

Music_YellowUnusedSong::
	channel_count 4
	channel 1, Music_YellowUnusedSong_Ch1
	channel 2, Music_YellowUnusedSong_Ch2
	channel 3, Music_YellowUnusedSong_Ch3
	channel 4, Music_YellowUnusedSong_Ch4

Music_GBPrinter::
	channel_count 1
	channel 3, Music_GBPrinter_Ch3

; Cinnabar Island, Cinnabar Lab.
;
; It lives in AUDIO_4 and not beside the other town themes for a hard reason:
; song ids are (header - $4000) / 3 within the bank, AUDIO_1's table already
; ends at id 251, and a 4-channel header needs four consecutive ids. 252-254
; is three. Placed there it landed on 255 -- which is SFX_STOP_ALL_MUSIC, so
; the island silenced itself instead of playing. The build cannot see that:
; it was caught by recording the track and getting 22 seconds of nothing.
Music_CinnabarIsland::
	channel_count 4
	channel 1, Music_CinnabarIsland_Ch1
	channel 2, Music_CinnabarIsland_Ch2
	channel 3, Music_CinnabarIsland_Ch3
	channel 4, Music_CinnabarIsland_Ch4

; Pewter City. AUDIO_4 for the same reason as Cinnabar Island above: AUDIO_1's
; id space ends at 251 and a header needs one id per channel.
Music_PewterCity::
	channel_count 4
	channel 1, Music_PewterCity_Ch1
	channel 2, Music_PewterCity_Ch2
	channel 3, Music_PewterCity_Ch3
	channel 4, Music_PewterCity_Ch4

; Saffron City while Silph Co is still occupied -- the plain table entry.
Music_SaffronCity::
	channel_count 4
	channel 1, Music_SaffronCity_Ch1
	channel 2, Music_SaffronCity_Ch2
	channel 3, Music_SaffronCity_Ch3
	channel 4, Music_SaffronCity_Ch4

; The same tune in major and faster, once Giovanni is beaten. Reached through
; LoadMapMusicOverrides, never from the song table.
Music_SaffronFree::
	channel_count 4
	channel 1, Music_SaffronFree_Ch1
	channel 2, Music_SaffronFree_Ch2
	channel 3, Music_SaffronFree_Ch3
	channel 4, Music_SaffronFree_Ch4


