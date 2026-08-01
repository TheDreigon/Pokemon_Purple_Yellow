; Cinnabar Island (and the Lab).
;
; Forte's brief: keep Vermilion's tune but make the island sound serious.
; Same notes, different voice -- which is the point, because the two themes
; were never far apart: vanilla Cinnabar and vanilla Vermilion carry the
; IDENTICAL lead patch (duty_cycle 3, vibrato 12/3/4, perfect pitch), which is
; why the island always read as a second port town.
;
; Changes against the Vermilion original, which is untouched:
;   - tempo 156 -> 200, i.e. SLOWER. Read the direction off the engine, not
;     off intuition: Audio1_note_length computes the note delay as
;     note_length * note_speed * TEMPO, so a bigger number holds each note
;     for more frames. Low tempo is FAST. For scale, Cities1 is 232 and
;     Indigo Plateau -- which sounds grave for other reasons -- is 132, well
;     on the quick side of Vermilion.
;   - lead duty_cycle 3 -> 1. The 25% pulse is thin and reedy instead of
;     round and bright; the same lever that makes Lavender Town sound haunted
;     using perfectly ordinary notes.
;   - vibrato slower to arrive and deeper when it does, on both pulse
;     channels, so held notes sag rather than shimmer.
;   - both pulse channels transposed DOWN one octave (3/4 -> 2/3). The single
;     strongest "graver" lever available; bass and drums stay put so the
;     bottom does not double up.
;
; Every one of these was judged by ear on a recording off the real APU
; (.claude/emu_record_music.py), because none of it can be judged by reading.

Music_CinnabarIsland_Ch1::
	tempo 200
	volume 7, 7
	duty_cycle 1
	vibrato 16, 2, 6
	toggle_perfect_pitch
.mainloop:
	note_type 12, 11, 5
	octave 2
	note E_, 4
	note C#, 1
	note D_, 1
	note E_, 2
	note A_, 4
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note A_, 4
	note F#, 1
	note G#, 1
	note A_, 2
	note E_, 4
	note C#, 2
	note E_, 2
	note A_, 2
	note G#, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	note C#, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note E_, 4
	note C#, 1
	note D_, 1
	note E_, 2
	note A_, 4
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note A_, 4
	note F#, 1
	note G#, 1
	note A_, 2
	note E_, 4
	note C#, 1
	note D_, 1
	note E_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	note F#, 4
	note E_, 4
	note F#, 2
	note G#, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note B_, 2
	note A_, 2
	octave 3
	note C#, 2
	note D_, 2
	note C#, 2
	octave 2
	note B_, 2
	note A_, 2
	note G#, 1
	note A_, 1
	note B_, 2
	octave 3
	note C#, 2
	note E_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note G#, 2
	octave 3
	note C#, 2
	octave 2
	note F#, 2
	note B_, 2
	note G#, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	note B_, 2
	sound_loop 0, .mainloop

Music_CinnabarIsland_Ch2::
	duty_cycle 2
	vibrato 14, 2, 5
.mainloop:
	note_type 12, 12, 7
	octave 2
	note A_, 8
	octave 3
	note D_, 4
	note C#, 4
	octave 2
	note B_, 6
	note A_, 1
	note B_, 1
	octave 3
	note C#, 8
	octave 2
	note A_, 8
	octave 3
	note D_, 4
	note C#, 4
	octave 2
	note B_, 6
	octave 3
	note C#, 1
	octave 2
	note B_, 1
	note A_, 8
	note A_, 8
	octave 3
	note D_, 4
	note C#, 4
	octave 2
	note B_, 6
	note A_, 1
	note B_, 1
	octave 3
	note C#, 8
	octave 2
	note A_, 8
	octave 3
	note D_, 4
	note C#, 4
	octave 2
	note B_, 6
	octave 3
	note C#, 1
	octave 2
	note B_, 1
	note A_, 8
	note B_, 4
	octave 3
	note C#, 4
	note D_, 4
	note E_, 4
	note F#, 8
	note B_, 8
	note A_, 4
	note G#, 4
	note F#, 4
	note E_, 4
	note F#, 8
	note E_, 8
	sound_loop 0, .mainloop

Music_CinnabarIsland_Ch3::
	note_type 12, 1, 0
.mainloop:
	octave 4
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	sound_loop 0, .mainloop

Music_CinnabarIsland_Ch4::
	drum_speed 12
.mainloop:
.loop1:
	sound_call .sub1
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 1
	sound_loop 4, .loop1
	sound_call .sub1
	sound_call .sub1
	sound_call .sub1
	sound_call .sub1
	sound_loop 0, .mainloop

.sub1:
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 6, 1
	drum_note 6, 1
	sound_ret
