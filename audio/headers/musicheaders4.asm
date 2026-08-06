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

; The five city themes used to sit here (they could not fit in AUDIO_1's id
; window), and Music_YellowUnusedSong sat above -- the Fighting Dojo plays it
; permanently. They caused bug #7: this bank's SFX table is the short vanilla
; one, so any overworld sound on a map whose music lives here -- a ledge hop,
; a Pokedex cry, a save, a poison step -- resolved to garbage and wedged
; channels 5-8. Every map-playable track now lives in AUDIO_5, which mirrors
; the full bank-1 SFX table -- see audio/headers/musicheaders5.asm. The two
; that stayed (Surfing Pikachu, Jessie & James) are cutscene/minigame themes,
; exactly what vanilla built this bank for.

