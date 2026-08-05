; Cerulean City -- Cities2 with the sea put into it.
;
; Cerulean and Fuchsia shared MUSIC_CITIES2. Forte wanted Cerulean to keep its
; own familiar tune and be pushed towards "a coastal, maritime town", so this is
; the Pewter treatment: same piece, different voice. Fuchsia keeps Cities2
; untouched. THE MELODY IS NOT TOUCHED -- Ch1 and Ch2 are Cities2's note data
; verbatim, and `python .claude/derive_cerulean.py --check` proves it.
;
; What Cities2 already is, which is worth knowing before changing it: the
; harmony rocks between one bar of E and one bar of F#m for fourteen of its
; sixteen bars, with a single C#m -> B excursion at bars 10-11. It is already a
; two-chord swaying piece. Nothing here fights that; the changes lean on it.
;
; The five decisions, stated so they can be argued with:
;
; 1. THE SEA IS Ch3, and it is the heart of this. Cities2's wave channel
;    alternates two notes flatly -- E G# E G# for a whole bar, F# A F# A for the
;    next -- which TICKS. Here each of those bars is one arc instead: up from
;    the root an octave lower, through the chord, and back down. Same pitch
;    classes, same rhythm, same sixteen bars; only the shape changes. The
;    octave-3 root also gives the track a floor it never had -- no Gen 1 city
;    theme has a real bass, this channel sits in octave 4 in all of them -- and
;    that low note arriving under each bar is what reads as swell.
;    Bars 9-11 are left exactly as Cities2 wrote them. That is the stretch where
;    the melody is nearly all rests and the original already opens out, which is
;    the one coastal thing it did unaided; putting a floor under it would weigh
;    down the part that is supposed to lift.
;
; 2. Ch4 ADDED, sparse. Cities2 has no percussion at all, so any is the single
;    most audible way this stops being Fuchsia. It is a lilt, not a march:
;    6+6+2+2, which is Cities1's own .sub5 figure and exactly one bar -- two
;    long hits and two quick ones that tip it forward. Four-on-the-floor exists
;    nowhere in Gen 1. It is SILENT in bars 4, 10 and 11, which is where the
;    melody rests: a drum that plays through the gaps fills in the air this is
;    supposed to be opening up.
;
; 3. Ch1 VIBRATO 8,3,2 -> 14,3,5. Later to arrive, so the quick runs stay clean,
;    and deeper once it does, so the long notes -- bar 14 is a whole bar on one
;    E -- sway instead of sitting still. Sound carrying over water.
;
; 4. Ch2 VOLUME 12 -> 10 throughout, fades untouched. Cities2's counter-melody is
;    busy (106 notes, 65 of them ornaments) and sits in the same octaves as the
;    lead, which is most of why the original reads as a busy town square. Two
;    steps down puts it behind the melody instead of beside it, and the distance
;    is the air.
;
; 5. TEMPO 148 -> 152. Bigger is slower (the delay is note_length * note_speed *
;    tempo, Audio1_note_length). A 2.7% easing -- an unhurried seaside gait, not
;    a becalmed one. 152 is also the most common tempo in Kanto.
;
; ENGINE NOTES:
;   - No finite `sound_loop N` anywhere. Its counter is compared before it is
;     incremented and resets to 1 rather than 0, so a block plays N+1 times on
;     the first pass and N afterwards, leaving that channel permanently offset.
;     Cities1 and Vermilion both ship that way. Repeats here are `sound_call`.
;   - `sound_call` does not nest: one return address per channel.
;   - All four channels are 384 ticks of intro and 3072 of loop -- 2 bars and
;     16. Nothing in the engine lines channels up and no build error would
;     appear if these stopped matching.
;     `python .claude/music_analyze.py ceruleancity` is the check.

Music_CeruleanCity_Ch1::
	tempo 152
	volume 7, 7
	duty_cycle 3
	vibrato 14, 3, 5
	toggle_perfect_pitch
	note_type 12, 11, 6
	rest 8
	octave 3
	note E_, 2
	note D#, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
	rest 14
.mainloop:
	octave 3
	note B_, 4
	octave 4
	note C#, 2
	note D#, 1
	note D_, 1
	note C#, 4
	octave 3
	note B_, 4
	note G#, 8
	note E_, 8
	note A_, 4
	note G#, 2
	note F#, 2
	note G#, 2
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	rest 16
	note C#, 4
	octave 3
	note B_, 2
	octave 4
	note C#, 1
	note D#, 1
	note C#, 4
	octave 3
	note B_, 4
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	rest 3
	note G#, 8
	note B_, 4
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note A_, 2
	note B_, 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	octave 4
	note E_, 4
	octave 3
	note B_, 4
	note F#, 2
	note G#, 2
	note A_, 2
	rest 2
	octave 4
	note F#, 4
	note D#, 4
	octave 3
	note E_, 2
	rest 4
	note F#, 2
	rest 4
	note A_, 2
	rest 2
	note B_, 2
	rest 16
	rest 16
	rest 14
	note E_, 16
	note F#, 8
	note G#, 4
	note F#, 4
	note E_, 2
	rest 14
	sound_loop 0, .mainloop

Music_CeruleanCity_Ch2::
	duty_cycle 3
	vibrato 8, 2, 3
	note_type 12, 10, 2
	octave 4
	note E_, 2
	note D#, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
	note E_, 6
	note_type 12, 10, 2
	duty_cycle 2
	octave 4
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
.mainloop:
	note_type 12, 10, 6
	note G#, 6
	note_type 12, 10, 2
	note A_, 1
	note G#, 1
	note_type 12, 10, 4
	note F#, 14
	note_type 12, 10, 2
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	note_type 12, 10, 4
	note G#, 6
	note_type 12, 10, 2
	note E_, 1
	note G#, 1
	note_type 12, 10, 5
	note B_, 14
	note_type 12, 10, 2
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	note_type 12, 10, 6
	note G#, 6
	note_type 12, 10, 2
	note A_, 1
	note G#, 1
	note_type 12, 10, 4
	note F#, 8
	note_type 12, 10, 1
	duty_cycle 1
	octave 3
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	rest 1
	note_type 12, 10, 2
	duty_cycle 2
	octave 4
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	note_type 12, 10, 4
	note G#, 6
	note E_, 1
	note G#, 1
	note_type 12, 10, 6
	note B_, 8
	note_type 12, 10, 2
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	note D#, 1
	note E_, 4
	note_type 12, 10, 7
	note G#, 4
	note E_, 4
	note_type 12, 10, 2
	note D#, 1
	note C#, 1
	note D#, 1
	note E_, 1
	note F#, 4
	note_type 12, 10, 7
	note B_, 4
	note F#, 4
	note_type 12, 10, 2
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	note D#, 1
	note E_, 2
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 1
	note G#, 2
	note G#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note B_, 1
	note F#, 1
	note D#, 1
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	note D#, 1
	note F#, 1
	note_type 12, 10, 2
	note B_, 8
	note_type 12, 11, 7
	octave 3
	note E_, 8
	octave 2
	note B_, 4
	octave 3
	note F#, 4
	note G#, 4
	note A_, 4
	note B_, 8
	note B_, 8
	note G#, 4
	octave 4
	note D#, 4
	note C#, 4
	note D#, 4
	note E_, 2
	note D#, 2
	note C#, 2
	note D#, 2
	note_type 12, 10, 2
	note E_, 6
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	sound_loop 0, .mainloop

Music_CeruleanCity_Ch3::
	note_type 12, 1, 1
; Intro: one bar of nothing, then the water starts a bar before the melody.
	rest 16
	sound_call .eArc
.mainloop:
	sound_call .fArc
	sound_call .eArc
	sound_call .fArc
	sound_call .eArc
	sound_call .fArc
	sound_call .eArc
	sound_call .fArc

; Bar 8. Same rhythm and same rests as Cities2; only the root drops.
	octave 3
	note E_, 2
	note B_, 2
	octave 4
	note E_, 2
	rest 2
	note E_, 4
	note G#, 4

; Bars 9-11 are Cities2 untouched, on purpose. This is the stretch where the
; melody is nearly all rests and the original already opens out -- it is the one
; coastal thing it did by itself. Dropping roots in here would only put weight
; back into the part that is meant to lift.
	note F#, 2
	note A_, 2
	note F#, 2
	rest 2
	note F#, 4
	note A_, 4

	note C#, 2
	rest 4
	note E_, 2
	rest 4
	note G#, 2
	note A_, 2

	note B_, 2
	rest 8
	note A_, 2
	note G#, 2
	note F#, 2

	sound_call .eArc
	sound_call .fArc
	sound_call .eArc
	sound_call .fArc
	sound_call .eArc
	sound_loop 0, .mainloop

; E major: up from the low root through fifth-root-third-fifth and back down,
; landing low again so the next bar starts a step away. Cities2 played a flat
; E4 G#4 eight times here.
;
; Both arcs deliberately END low. An arc that ends on its peak leaves a
; fourteen-semitone drop into the next bar, eight times a loop -- Cities2's wave
; channel never leaps more than 8 and Celadon's never more than 10, so that
; would not belong to this game. As written the biggest step between bars in the
; rocking stretch is 5.
.eArc:
	octave 3
	note E_, 2
	note B_, 2
	octave 4
	note E_, 2
	note G#, 2
	note B_, 2
	note G#, 2
	note E_, 2
	octave 3
	note B_, 2
	sound_ret

; The F#m bar. Cities2's own top-half contour (B A G# F#) is kept -- it is the
; one place its wave channel already moved -- with the opening pair taken down
; an octave to start the arc from underneath, and the landing on A3.
.fArc:
	octave 3
	note F#, 2
	note A_, 2
	octave 4
	note F#, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	octave 3
	note A_, 2
	sound_ret

Music_CeruleanCity_Ch4::
	drum_speed 12
; Two bars of intro, silent: the kit arrives with the tune.
	rest 16
	rest 16
.mainloop:
	sound_call .quiet
	sound_call .quiet
	sound_call .quiet
	rest 16

	sound_call .plain
	sound_call .lilt
	sound_call .plain
	sound_call .lilt
	sound_call .plain

; Bars 10 and 11 are where Cities2 opens out and the melody is nearly all
; rests. Playing through them would close it again.
	rest 16
	rest 16

	sound_call .quiet
	sound_call .plain
	sound_call .lilt
	sound_call .plain
	sound_call .quiet
	sound_loop 0, .mainloop

.plain:
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	sound_ret

; Cities1's .sub5 figure, which is one bar exactly: two long hits and two short
; ones that tip the bar forward instead of squaring it off.
.lilt:
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 2
	drum_note 7, 2
	sound_ret

.quiet:
	drum_note 8, 6
	drum_note 8, 6
	drum_note 8, 4
	sound_ret
