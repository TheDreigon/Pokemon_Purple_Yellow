; Saffron City, after Silph Co is taken back.
;
; Built on Routes 2 -- the Route 24 / Route 25 theme, which Forte singled out
; as the most adventurous music in the game -- and then weighted down. His read
; on the first attempt (Celadon, lifted) was that he liked the music but it did
; not fit the city, so this goes the other way: the same forward-moving tune,
; carrying more.
;
; Against the Routes 2 original, which is untouched:
;   - tempo 152 -> 192, i.e. slower. The note delay is
;     note_length * note_speed * TEMPO (Audio1_note_length), so bigger holds
;     each note longer. Same 1.26x step that landed on Cinnabar and Pewter.
;   - lead vibrato slower to arrive and deeper, so the long notes settle
;     instead of shimmering.
;   - Ch2 down one octave (3/4/5 -> 2/3/4). That channel is the descant and
;     the brightest thing in the piece. Ch1 already reaches down to octave 2
;     and is left alone -- taking it lower is mud, the same call as Pewter.
;   - duty_cycle is NOT touched: Routes 2 is already on the thin 25% pulse,
;     which is where Cinnabar had to be steered to. It arrives serious.
;
; Judged on a recording off the real APU, because none of this can be judged
; by reading it.

Music_SaffronLiberated_Ch1::
	tempo 192
	volume 7, 7
	vibrato 15, 2, 6
	duty_cycle 1
.mainloop:
	note_type 12, 11, 2
	octave 2
	note B_, 4
	octave 3
	note G#, 6
	note F#, 2
	note E_, 2
	note D#, 1
	note F#, 1
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note A_, 2
	note G#, 4
	note F#, 4
	octave 2
	note B_, 4
	octave 3
	note G#, 6
	note F#, 2
	note E_, 2
	note D#, 1
	note F#, 1
	note B_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note A_, 2
	note G#, 4
	note B_, 4
	note_type 8, 11, 2
	octave 4
	note E_, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	note E_, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	note D#, 2
	octave 3
	note G#, 2
	octave 4
	note D#, 2
	note D#, 2
	octave 3
	note G#, 2
	octave 4
	note D#, 2
	note C#, 2
	octave 3
	note F#, 2
	octave 4
	note C#, 2
	note C#, 2
	octave 3
	note F#, 2
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	note E_, 2
	note B_, 2
	note B_, 2
	note E_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note A_, 2
	note A_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	note G#, 2
	note A_, 2
	note A_, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note B_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note F#, 2
	note E_, 2
	note D#, 2
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	sound_loop 0, .mainloop

	sound_ret ; unused

Music_SaffronLiberated_Ch2::
	vibrato 8, 2, 6
	duty_cycle 3
.mainloop:
	note_type 12, 13, 4
	octave 3
	note E_, 6
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 6
	note A_, 2
	note G#, 3
	note E_, 1
	note F#, 8
	octave 2
	note D#, 4
	octave 3
	note E_, 6
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 6
	note A_, 2
	note G#, 3
	note E_, 1
	note B_, 8
	octave 2
	note G#, 4
	octave 4
	note C#, 6
	octave 3
	note B_, 1
	note A_, 1
	note B_, 6
	note A_, 1
	note G#, 1
	note A_, 6
	note G#, 1
	note F#, 1
	note G#, 4
	note F#, 2
	note E_, 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 8
	note A_, 4
	note G#, 3
	note F#, 1
	note E_, 8
	note F#, 2
	note E_, 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 4
	octave 4
	note C#, 4
	octave 3
	note B_, 3
	note A_, 1
	note G#, 8
	rest 4
	sound_loop 0, .mainloop

	sound_ret ; unused

Music_SaffronLiberated_Ch3::
	vibrato 9, 2, 8
.mainloop:
	note_type 12, 1, 1
	octave 3
	note E_, 2
	rest 2
	octave 2
	note B_, 6
	octave 3
	note D_, 1
	note C#, 1
	note D_, 2
	note D#, 2
	note E_, 2
	rest 2
	octave 2
	note B_, 6
	octave 3
	note D_, 1
	note C#, 1
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	note E_, 2
	rest 2
	octave 2
	note B_, 6
	octave 3
	note D_, 1
	note C#, 1
	note D_, 2
	note D#, 2
	note E_, 2
	rest 2
	octave 2
	note B_, 4
	octave 3
	note C#, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note F#, 2
	note E_, 2
	rest 2
	octave 2
	note A_, 2
	rest 2
	octave 3
	note D#, 2
	rest 2
	octave 2
	note G#, 2
	rest 2
	octave 3
	note C#, 2
	rest 2
	octave 2
	note F#, 2
	rest 2
	note B_, 2
	rest 2
	note E_, 2
	note G#, 2
	note F#, 2
	rest 2
	note A_, 2
	rest 2
	note F#, 2
	rest 2
	note A_, 2
	rest 2
	note G#, 2
	rest 2
	note B_, 2
	rest 2
	note G#, 2
	rest 2
	note B_, 2
	rest 2
	note F#, 2
	rest 2
	note A_, 2
	rest 2
	octave 3
	note C#, 2
	rest 2
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note B_, 2
	rest 2
	octave 3
	note E_, 2
	rest 2
	note G#, 2
	rest 2
	note E_, 2
	rest 2
	sound_loop 0, .mainloop

	sound_ret ; unused

Music_SaffronLiberated_Ch4::
.mainloop:
	drum_speed 12
	drum_note 3, 2
	rest 2
	drum_note 3, 1
	rest 5
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	rest 2
	drum_speed 8
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 3
	drum_note 3, 3
	drum_speed 12
	drum_note 3, 1
	rest 3
	drum_note 3, 2
	rest 2
	drum_note 3, 2
	rest 4
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 2
	rest 2
	drum_note 3, 2
	rest 2
	drum_speed 8
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 3
	drum_note 3, 3
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 3
	rest 3
	drum_speed 12
	drum_note 3, 1
	rest 5
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	rest 2
	drum_speed 8
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 3
	rest 3
	drum_speed 12
	drum_note 3, 1
	rest 3
	drum_note 3, 2
	rest 2
	drum_note 3, 2
	rest 4
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	rest 2
	drum_speed 8
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 3
	rest 3
	drum_note 3, 3
	drum_note 3, 3
	drum_note 3, 3
	rest 3
	drum_speed 12
	drum_note 3, 1
	rest 5
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	rest 2
	drum_speed 8
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 3
	rest 3
	drum_note 3, 3
	rest 3
	sound_loop 0, .mainloop

	sound_ret ; unused
