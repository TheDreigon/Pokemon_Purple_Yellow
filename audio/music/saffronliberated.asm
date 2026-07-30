; Saffron City -- original, third attempt.
;
; The history is the argument, so it is worth keeping. v1 was written from
; scratch for "modern city" and Forte scored it 9/10: he loved it and said it
; did not sound like Pokemon. v2 rebuilt the ACCOMPANIMENT in Gen 1 idiom --
; 6+6+4 drums, a walking bass, toggle_perfect_pitch, tempo 152 -- and he still
; heard it, then put his finger exactly on the cause: the MELODY. He said it
; sounds like an 8-bit rendition of something from Gen 5, and named Driftveil
; City.
;
; He is right, and it was designed in. Every choice I made in v1 to keep it
; from sounding cheerful is a Gen 5 device: a modal vamp that circles without
; resolving, a melody built on fourths, and phrases entering off the beat.
; That is Driftveil's own vocabulary. No amount of fixing the drums reaches it.
;
; WHAT GEN 1 ACTUALLY DOES. Not guessed -- measured, by walking the note lists
; of Cities1 and Celadon and counting intervals in scale degrees:
;
;     Cities1   range  9 degrees | 55% stepwise or repeated | largest leap 6
;     Celadon   range 11 degrees | 54% stepwise or repeated | largest leap 7
;     Saffron v1 range 8 degrees | 40% stepwise or repeated | largest leap 3
;
; That is the finding, and it is not what "stepwise melodies" would suggest on
; its own: Gen 1 town themes are about HALF stepwise, and the other half
; contains bold leaps of a sixth or a seventh, over a range of nine to eleven
; degrees. Mostly-steps punctuated by a jump is what makes them singable and
; memorable at the same time. v1 failed on the wrong axis -- it was TOO
; conjunct in a narrow band, and its motion was fourths and off-beat entries.
;
; A first pass at this melody came out 89% stepwise, which overshot in the
; other direction and read as an etude. It now has deliberate leaps at the
; phrase joins (a fifth into bar 5, a sixth into bar 7, and a dip under the
; octave in bar 8) and spans a ninth.
;
; Also Gen 1, and kept: CONTINUOUS and ON the beat, no rest-then-enter
; syncopation; REPEATED NOTES across bar lines as a fingerprint (E E, as in
; Cities1); note_type volume shading between phrases (12 -> 10 -> 12); lengths
; of 2 and 4 with the occasional 6.
;
; The harmony is rewritten from a circling vamp to functional minor:
;
;     Am  Dm  E   Am  |  F   G   Am  E
;     i   iv  V   i   |  VI  VII i   V
;
; That cadences. It goes somewhere and comes back, which is what Gen 1 harmony
; does; v1's i-v-VI-VII merely orbited, which is what Gen 5 does. The raised G#
; over the E chord is the pull that makes a minor key feel like a key at all,
; and it is also the leading tone the bass now walks in on.
;
; STILL MINOR, because that is what keeps it from turning cheerful -- and Gen 1
; does minor perfectly well: Lavender Town is in it and is the most memorable
; thing in the game.
;
; DELIBERATELY UNCHANGED FROM v2, so this tests one idea instead of five: the
; 50% square lead (nothing else in the game uses it, and Forte never objected
; to the timbre), tempo 152, the 6+6+4 drums, the walking-bass style, and Ch2's
; rigid arpeggio-as-traffic. Only the notes those play had to follow the new
; chords.
;
; KNOWN RISK worth listening for: the melody has come DOWN from octave 4/5 to
; octave 3/4 to sit where Cities1's does, while the bass stayed at octave 3.
; There is less air between them than there was. If it sounds crowded, raising
; the bass to octave 4 -- which is where Cities1 writes its own -- is one line.
;
; v1 and v2 are archived as .wav under Notes/Music auditions/, and both are in
; git, so going back to either is a copy and not a rewrite.

Music_SaffronLiberated_Ch1::
	tempo 152
	volume 7, 7
	duty_cycle 2
	vibrato 8, 1, 3
	toggle_perfect_pitch
	note_type 12, 11, 4
; Intro, one bar: a stepwise run that lands on the note bar 1 starts from, so
; the loop begins on a repeated note. Gen 1 opens this way (Cities2, Celadon):
; a scalar gesture, not a fanfare.
	octave 3
	note C_, 2
	note D_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note E_, 4
.mainloop:
	note_type 12, 12, 5
; -- bar 1 (Am) --------------------------------------------------------------
	note E_, 4
	note F_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C_, 4
; -- bar 2 (Dm) --------------------------------------------------------------
	note D_, 4
	note E_, 2
	note F_, 2
	note G_, 2
	note F_, 2
	note E_, 4
; -- bar 3 (E) -- the G# is the raised seventh: the whole pull of a minor key -
	note E_, 4
	note D_, 2
	note C_, 2
	note D_, 2
	note E_, 2
	note G#, 4
; -- bar 4 (Am) -- resolves onto the tonic, then walks back down -------------
	note A_, 6
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 4
	note_type 12, 10, 5
; -- bar 5 (F) -- quieter middle, entered by a leap of a fifth. Gen 1 melodies
; are mostly stepwise but jump boldly at phrase joins; measured against Cities1
; and Celadon, a purely scalar line is MORE stepwise than the real thing.
	note A_, 4
	note G_, 2
	note F_, 2
	note G_, 2
	note A_, 2
	note F_, 4
; -- bar 6 (G) ---------------------------------------------------------------
	note G_, 4
	note A_, 2
	note B_, 2
	note A_, 2
	note G_, 2
	note E_, 4
	note_type 12, 12, 5
; -- bar 7 (Am) -- the high point, exactly one step above the octave ---------
	octave 4
	note C_, 4
	octave 3
	note B_, 2
	note A_, 2
	note G_, 2
	note A_, 2
	note E_, 4
; -- bar 8 (E) -- dips under the octave and leaps back to the dominant, so the
; loop pulls round instead of stopping, and the tune spans a ninth like the
; Gen 1 town themes do rather than a flat octave.
	note E_, 4
	note D_, 2
	note C_, 2
	octave 2
	note B_, 4
	octave 3
	note E_, 4
	sound_loop 0, .mainloop

Music_SaffronLiberated_Ch2::
	duty_cycle 1
	note_type 12, 8, 2
	rest 16                     ; matches Ch1's intro bar
.mainloop:
	note_type 12, 8, 2
; The traffic. Rhythm identical in every bar by design, only the chord moves.
; Kept from v2 in character; it just follows the new progression now.
	sound_call .amBar
	sound_call .dmBar
	sound_call .eBar
	sound_call .amBar
	sound_call .fBar
	sound_call .gBar
	sound_call .amBar
	sound_call .eBarExhale
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

.dmBar:
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	sound_ret

.eBar:
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

.eBarExhale:
; The machine breathes on the last bar of the loop. Perfectly metronomic all
; the way through is the other thing that reads as modern chiptune.
	octave 4
	note E_, 2
	note G#, 2
	note B_, 2
	note G#, 2
	note E_, 4
	rest 4
	sound_ret

Music_SaffronLiberated_Ch3::
	note_type 12, 1, 1
	toggle_perfect_pitch
	rest 16                     ; matches Ch1's intro bar
.mainloop:
; Walking bass, Gen 1 style: root and fifth, a rest to breathe, then passing
; notes that lead BY STEP into the next chord. Every bar hands over: C into Dm,
; D into E, G# into Am (the leading tone), G down into F, F# up into G, G# into
; Am again, and G#-F# down into the final E.
	octave 3
	sound_call .barAmToDm
	sound_call .barDmToE
	sound_call .barEToAm
	sound_call .barAmToF
	sound_call .barFToG
	sound_call .barGToAm
	sound_call .barAmToE
	sound_call .barEToAm
	sound_loop 0, .mainloop

.barAmToDm:
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	rest 2
	note C_, 2
	note C_, 2
	sound_ret

.barDmToE:
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	rest 2
	note D_, 2
	note D_, 2
	sound_ret

.barEToAm:
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	rest 2
	note G#, 2
	note G#, 2
	sound_ret

.barAmToF:
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	rest 2
	note G_, 2
	note G_, 2
	sound_ret

.barFToG:
	note F_, 2
	note C_, 2
	note F_, 2
	note C_, 2
	note F_, 2
	rest 2
	note F#, 2
	note F#, 2
	sound_ret

.barGToAm:
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	rest 2
	note G#, 2
	note G#, 2
	sound_ret

.barAmToE:
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	rest 2
	note G#, 2
	note F#, 2
	sound_ret

Music_SaffronLiberated_Ch4::
	drum_speed 12
	rest 16                     ; matches Ch1's intro bar
.mainloop:
; The Gen 1 bar is 6+6+4 on instruments 6 and 7 -- Cities1 builds its entire
; kit from that figure. Four-on-the-floor was v1's biggest tell and appears
; nowhere in this game. Kept from v2 unchanged.
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .barTurn
	sound_call .bar
	sound_call .bar
	sound_call .bar
	sound_call .barTurn
	sound_loop 0, .mainloop

.bar:
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	sound_ret

.barTurn:
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 2
	drum_note 7, 2
	sound_ret
