; Saffron City -- an original piece, not derived from anything.
;
; Two derivations failed the same way: Forte liked the music and said it did not
; fit. Celadon and Route 24/25 are fundamentally CHEERFUL and ADVENTUROUS, and
; slowing a tune down does not change what the tune is about. Saffron is
; neither. It is the biggest city in Kanto, it is Silph's company town, and
; Forte's own note is that visually there is barely any room to move because it
; is just a mass of buildings. So this is written for that on purpose.
;
; The decisions, stated so they can be argued with:
;
; MODE. A minor, on a i - v - VI - VII vamp (Am - Em - F - G). Every other town
; theme in the game is major and reads as friendly. This progression is the
; single biggest reason this should not sound cheerful: it never resolves
; brightly, it just keeps circling -- which is what a city does.
;
; INTERVALS. The melody leans on fourths and on the minor third instead of
; stepwise singable steps, and enters off the beat in most bars. Wide intervals
; read architectural; stepwise reads folk song. Syncopation gives it a walk
; rather than a march.
;
; VOICE. Lead on duty_cycle 2, the 50% square. This matters: 75% is the warm
; round pulse that Celadon, Vermilion and Cities1 all share, and 25% is the
; thin reedy one now used by Cinnabar and Route 24/25. 50% is clean and glassy
; and NOTHING else in the game is on it, so Saffron has a timbre of its own
; before a single note is played. Vibrato fast and shallow (8/1/3): modern is
; tight, not wobbly.
;
; THE MACHINE. Ch2 is a four-note arpeggio in eighths whose rhythm never varies
; across all eight bars -- only the chord under it moves. That is the traffic:
; something mechanical running underneath, indifferent to the tune on top. Kept
; at volume 8 so it stays texture and does not become a counter-melody.
;
; BASS AND DRUMS. Root eighths and four-on-the-floor, both completely plain. No
; fills anywhere, because a fill is the fastest way to make this read as an
; adventure again.
;
; TEMPO 160. Purposeful, and deliberately not slow: Cinnabar (200) and Pewter
; (184) own the heavy end now. Direction reminder -- the note delay is
; note_length * note_speed * TEMPO, so a bigger number is SLOWER.

Music_SaffronLiberated_Ch1::
	tempo 160
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
	note C_, 4
	octave 4
	note A_, 4
	rest 2
; bar 2 (Em)
	note B_, 2
	rest 2
	note G_, 4
	note B_, 4
	octave 5
	note E_, 4
; bar 3 (F)
	note D_, 2
	note C_, 2
	octave 4
	note A_, 4
	note F_, 4
	note A_, 4
; bar 4 (G) -- the rising fourth that keeps the vamp turning over
	note G_, 4
	note B_, 4
	octave 5
	note D_, 6
	rest 2
; -- phrase B: the answer, same harmony, higher and more open ----------------
; bar 5 (Am)
	rest 4
	note E_, 4
	note C_, 4
	octave 4
	note A_, 4
; bar 6 (Em)
	note B_, 4
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note B_, 4
	note G_, 4
; bar 7 (F) -- the highest point in the piece, then straight back down
	note A_, 4
	octave 5
	note C_, 4
	note F_, 4
	note E_, 4
; bar 8 (G) -- lands on G and holds, so the loop point is a step, not a stop
	note D_, 4
	octave 4
	note B_, 4
	note G_, 8
	sound_loop 0, .mainloop

Music_SaffronLiberated_Ch2::
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
	note C_, 2
	note E_, 2
	note C_, 2
	octave 4
	note A_, 2
	octave 5
	note C_, 2
	note E_, 2
	note C_, 2
	sound_ret

.emBar:
	octave 4
	note E_, 2
	note G_, 2
	note B_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note B_, 2
	note G_, 2
	sound_ret

.fBar:
	octave 4
	note F_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 2
	note F_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 2
	sound_ret

.gBar:
	octave 4
	note G_, 2
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	note G_, 2
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	sound_ret

Music_SaffronLiberated_Ch3::
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
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	sound_ret

.eightG:
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	sound_ret

Music_SaffronLiberated_Ch4::
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
