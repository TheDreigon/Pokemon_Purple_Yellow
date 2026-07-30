; Saffron City, after Silph Co is taken back.
;
; Forte's design, and it is a good one: the city keeps its own theme either
; way, so the place still sounds like itself -- but once Giovanni is off the
; top floor the same tune is played faster and in MAJOR. Nothing new to learn,
; and the change lands as the city exhaling rather than as a different track.
;
; This is Music_SaffronCity transposed, mechanically and nothing else:
;
;   A natural minor -> A major is raising degrees 3, 6 and 7, so every
;   C -> C#, F -> F#, G -> G#. The melody keeps its exact shape, its exact
;   rhythm and its exact range; only three pitch classes move.
;
;   The vamp goes Am - Em - F - G  ->  A - E - F#m - G#dim. That last chord is
;   what the major scale actually gives you on the seventh degree, and it is
;   not a problem: it is the leading-tone chord and it pulls hard back to the
;   tonic. In the bass it also turns the walk into A - E - F# - G# - A, rising
;   into the tonic by step, which the minor version never did.
;
;   Tempo 152 -> 138, the "moderately faster" that was asked for -- about 10%,
;   against the 5% of 160 -> 152. Bigger is slower: the note delay is
;   note_length * note_speed * TEMPO.
;
; Ch4 is untouched because it is the noise channel and has no pitches to move.
;
; Reached through LoadMapMusicOverrides once EVENT_BEAT_SILPH_CO_GIOVANNI is
; set; the minor version is the plain table entry, so it is what plays until
; then.

Music_SaffronFree_Ch1::
	tempo 138
	volume 7, 7
	duty_cycle 2
	vibrato 8, 1, 3
.mainloop:
	note_type 12, 11, 4
; -- phrase A: the statement -------------------------------------------------
; bar 1 (Am) -- enters late, on the second eighth
	rest 2
	octave 4
	note A_, 2
	note B_, 2
	octave 5
	note C#, 4
	octave 4
	note A_, 4
	rest 2
; bar 2 (Em)
	note B_, 2
	rest 2
	note G#, 4
	note B_, 4
	octave 5
	note E_, 4
; bar 3 (F)
	note D_, 2
	note C#, 2
	octave 4
	note A_, 4
	note F#, 4
	note A_, 4
; bar 4 (G) -- the rising fourth that keeps the vamp turning over
	note G#, 4
	note B_, 4
	octave 5
	note D_, 6
	rest 2
; -- phrase B: the answer, same harmony, higher and more open ----------------
; bar 5 (Am)
	rest 4
	note E_, 4
	note C#, 4
	octave 4
	note A_, 4
; bar 6 (Em)
	note B_, 4
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note B_, 4
	note G#, 4
; bar 7 (F) -- the highest point in the piece, then straight back down
	note A_, 4
	octave 5
	note C#, 4
	note F#, 4
	note E_, 4
; bar 8 (G) -- lands on G and holds, so the loop point is a step, not a stop
	note D_, 4
	octave 4
	note B_, 4
	note G#, 8
	sound_loop 0, .mainloop

Music_SaffronFree_Ch2::
	duty_cycle 1
.mainloop:
	note_type 12, 8, 2
; The traffic. Identical rhythm in all eight bars by design; only the chord
; moves. Eighths, four notes to the bar, twice.
	sound_call .amBar
	sound_call .emBar
	sound_call .fBar
	sound_call .gBar
	sound_call .amBar
	sound_call .emBar
	sound_call .fBar
	sound_call .gBar
	sound_loop 0, .mainloop

.amBar:
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	note E_, 2
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	note E_, 2
	note C#, 2
	sound_ret

.emBar:
	octave 4
	note E_, 2
	note G#, 2
	note B_, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note B_, 2
	note G#, 2
	sound_ret

.fBar:
	octave 4
	note F#, 2
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	note F#, 2
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	sound_ret

.gBar:
	octave 4
	note G#, 2
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	note G#, 2
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	sound_ret

Music_SaffronFree_Ch3::
.mainloop:
	note_type 12, 1, 1
; Root eighths, no ornament. A pump.
	octave 2
	sound_call .eightA
	sound_call .eightE
	sound_call .eightF
	sound_call .eightG
	sound_call .eightA
	sound_call .eightE
	sound_call .eightF
	sound_call .eightG
	sound_loop 0, .mainloop

.eightA:
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	sound_ret

.eightE:
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	sound_ret

.eightF:
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	sound_ret

.eightG:
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	sound_ret

Music_SaffronFree_Ch4::
	drum_speed 12
.mainloop:
; Four on the floor, eight bars, no fills. See the header.
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_loop 0, .mainloop

.bar:
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	sound_ret
