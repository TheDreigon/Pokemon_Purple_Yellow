; ARCHIVED -- Saffron City after Giovanni is beaten -- the first Saffron theme's twin. NOT BUILT.
;
; This is the first version, kept because Forte asked for the originals to be
; preserved before Saffron was rewritten (2026-08-05). The note data below is
; byte-for-byte what shipped; only the labels are renamed, so that this file can
; sit in the repo beside the live one without clashing. It is not referenced
; from audio.asm and costs no ROM.
;
; git also has it, in every commit up to that date -- this copy exists so it is
; findable without knowing which commit to look in.
;
; TO BRING IT BACK: rename Music_UnusedSaffronFree -> Music_SaffronFree throughout,
; delete the live file, and nothing else changes -- the header, the constant,
; the audio.asm INCLUDE and the songs.asm line all already name Music_SaffronFree.
; Then check: python .claude/song_id_audit.py and .claude/music_analyze.py
;
; The same piece in A major and about ten percent faster, reached through
; LoadMapMusicOverrides rather than the song table. Its twin is
; unused_saffron_occupied.asm.

; Saffron City, after Silph Co is taken back.
;
; Forte's design: the city keeps its own theme either way, so the place still
; sounds like itself -- but once Giovanni is off the top floor the same tune
; plays in MAJOR and faster. Nothing new to learn, and it lands as the city
; exhaling rather than as a different track starting.
;
; THE KEY CHANGE. A natural minor -> A major is raising degrees 3, 6 and 7, so
; every C -> C#, F -> F#, G -> G#. Bars 1-8 are Music_SaffronCity transposed
; that way and nothing else: same shape, same rhythm, same range, three pitch
; classes moved. The vamp becomes A - E - F#m - G#dim; the diminished chord on
; the seventh degree is simply what the major scale gives you there, and it is
; an asset, because it is the leading-tone chord and pulls hard back to the
; tonic. In the bass it also turns the walk into A - E - F# - G# - A, rising
; into the tonic by step, which the minor version never did.
;
; Tempo 152 -> 138, about 10% faster.
;
; -- THE SECOND HALF (Forte scored the 8-bar version 8/10) --------------------
; His note was that Celadon and Fuchsia have "more life, more voice" and that
; this melody was short, and on a second pass that it sounded more amateur than
; the other Kanto themes. Measured, he is right on every count:
;
;     Celadon                     16 bars |  78 notes | lengths 1,2,4,6,8
;     Cities2 (Cerulean/Fuchsia)  16 bars |  53 notes | lengths 1,2,4,8,16
;     Cities1 (Viridian/Pewter)   21 bars | 126 notes | lengths 2,4,6
;     this track, before          -8 bars-| -31 notes-| lengths 2,4,6,8
;
; Half the length and half the notes of anything it sits next to. And one
; concrete thing was missing rather than merely scarce: LENGTH-1 NOTES. Celadon
; and Cities2 both use them, this had none, and those quick ornamental notes
; are a lot of what reads as "voice" rather than as a sequence of held tones.
;
; So bars 9-16 are new -- a real second half rather than a repeat -- bringing
; it to 16 bars and 77 notes, which is Celadon's territory. They carry the
; ornaments (ten length-1 notes, in pairs, always inside one octave so no
; octave command lands mid-ornament), they open onto D major, a chord the first
; half never touches, and they sit a little higher. Bars 1-8 are untouched, so
; the tune is still recognisably the minor theme when the city changes key.
;
; Only Ch1 gains material by design. Ch2's rigid arpeggio is the traffic and
; keeps its shape; it and the bass simply follow the new chords. Widening
; everything at once would have muddled the one thing he asked for.
;
; Second-half harmony: D - A - F#m - E - D - A - E - E. The D is the lift.
;
; -- NO DRUM CHANNEL, from 2026-07-30 ----------------------------------------
; Forte heard "a constant tum, tum, tum, tum in the background, always the
; same" and asked for it gone. Two things in here fit that description and I
; could not tell them apart by ear, so I described both and he picked: it was
; Ch4. Four evenly spaced hits a bar, byte-identical across all sixteen bars,
; never varying once. Over the old 8-bar loop it passed; stretched to 16 it is
; a metronome.
;
; So this track has three channels, which is not a compromise: Celadon and
; Cities2 (Cerulean and Fuchsia) are both three-channel with no noise channel
; at all, and those are the two themes he keeps naming as the ones with life in
; them.
;
; Removed from THIS track only, at his instruction. Music_SaffronCity, the
; minor version, keeps its drums. Worth flagging that the two are meant to
; differ only in key and tempo, so if the drums ever come out of one they
; probably should come out of both -- but that is his call to make, not
; something to do quietly on the way past.

Music_UnusedSaffronFree_Ch1::
	tempo 138
	volume 7, 7
	duty_cycle 2
	vibrato 8, 1, 3
.mainloop:
	note_type 12, 11, 4
; == FIRST HALF: the theme, transposed. Unchanged from the minor version. ====
; bar 1 (A)
	rest 2
	octave 4
	note A_, 2
	note B_, 2
	octave 5
	note C#, 4
	octave 4
	note A_, 4
	rest 2
; bar 2 (E)
	note B_, 2
	rest 2
	note G#, 4
	note B_, 4
	octave 5
	note E_, 4
; bar 3 (F#m)
	note D_, 2
	note C#, 2
	octave 4
	note A_, 4
	note F#, 4
	note A_, 4
; bar 4 (G#dim)
	note G#, 4
	note B_, 4
	octave 5
	note D_, 6
	rest 2
; bar 5 (A)
	rest 4
	note E_, 4
	note C#, 4
	octave 4
	note A_, 4
; bar 6 (E)
	note B_, 4
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note B_, 4
	note G#, 4
; bar 7 (F#m)
	note A_, 4
	octave 5
	note C#, 4
	note F#, 4
	note E_, 4
; bar 8 (G#dim)
	note D_, 4
	octave 4
	note B_, 4
	note G#, 8
; == SECOND HALF: new. Opens onto D, sits higher, and carries the ornaments. ==
	note_type 12, 12, 5
; bar 9 (D) -- the lift, and the first pair of length-1 notes
	note A_, 4
	octave 5
	note D_, 2
	note C#, 1
	note D_, 1
	note E_, 4
	note D_, 4
; bar 10 (A)
	note C#, 4
	note E_, 2
	note D_, 1
	note C#, 1
	octave 4
	note B_, 4
	note A_, 4
; bar 11 (F#m)
	note A_, 4
	octave 5
	note C#, 2
	note D_, 1
	note C#, 1
	octave 4
	note B_, 4
	note A_, 4
; bar 12 (E)
	note B_, 4
	octave 5
	note E_, 2
	note D_, 1
	note C#, 1
	octave 4
	note B_, 4
	note G#, 4
; bar 13 (D) -- the highest bar in the piece
	octave 5
	note D_, 4
	note C#, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note E_, 4
; bar 14 (A)
	note E_, 4
	note D_, 1
	note C#, 1
	note D_, 2
	note C#, 4
	octave 4
	note A_, 4
; bar 15 (E)
	note B_, 4
	octave 5
	note C#, 2
	note D_, 2
	note E_, 4
	note D_, 4
; bar 16 (E) -- ends on the dominant, so the loop pulls round instead of stopping
	note C#, 4
	octave 4
	note B_, 2
	note A_, 2
	note B_, 4
	octave 5
	note E_, 4
	sound_loop 0, .mainloop

Music_UnusedSaffronFree_Ch2::
	duty_cycle 1
.mainloop:
	note_type 12, 8, 2
; The traffic. Same rigid cell throughout, only the chord moves -- that is the
; idea and it is kept. Sub names say which chord they actually play now; the
; ones inherited from the minor version said Am, Em, F and G and all four had
; become something else in the transposition.
	sound_call .aBar
	sound_call .eBar
	sound_call .fsBar
	sound_call .gsBar
	sound_call .aBar
	sound_call .eBar
	sound_call .fsBar
	sound_call .gsBar
	sound_call .dBar
	sound_call .aBar
	sound_call .fsBar
	sound_call .eBar
	sound_call .dBar
	sound_call .aBar
	sound_call .eBar
	sound_call .eBarExhale
	sound_loop 0, .mainloop

.aBar:
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

.fsBar:
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

.gsBar:
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

.dBar:
	octave 4
	note D_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	sound_ret

.eBarExhale:
; The machine breathes on the last bar of the loop, so sixteen bars of an
; identical cell do not end up sounding like a stuck record.
	octave 4
	note E_, 2
	note G#, 2
	note B_, 2
	note G#, 2
	note E_, 4
	rest 4
	sound_ret

Music_UnusedSaffronFree_Ch3::
.mainloop:
	note_type 12, 1, 1
; Root eighths, no ornament. A pump.
	octave 2
	sound_call .eightA
	sound_call .eightE
	sound_call .eightFs
	sound_call .eightGs
	sound_call .eightA
	sound_call .eightE
	sound_call .eightFs
	sound_call .eightGs
	sound_call .eightD
	sound_call .eightA
	sound_call .eightFs
	sound_call .eightE
	sound_call .eightD
	sound_call .eightA
	sound_call .eightE
	sound_call .eightE
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

.eightFs:
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	sound_ret

.eightGs:
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	sound_ret

.eightD:
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	sound_ret
