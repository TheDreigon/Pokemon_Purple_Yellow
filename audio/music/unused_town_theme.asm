; PARKED -- an original town theme with no home yet. NOT BUILT.
;
; Written for Cerulean on 2026-08-05 and set aside the same day. Forte liked it
; ("gostei muito") but decided Cerulean should keep its own familiar tune made
; more coastal instead, so this is kept for a town to be chosen later.
;
; This is the version he picked of three: the classic 75% lead. The other two
; differed by one line each and were discarded (12.5% lead; no drum channel).
;
; NOT REFERENCED FROM audio.asm, so it costs no ROM. It lives in the repo
; rather than in the Notes folder so that git protects it -- Notes is
; gitignored.
;
; TO WIRE IT UP somewhere, four touches and one rename:
;   1. rename Music_UnusedTownTheme -> Music_<Town> throughout this file
;   2. audio/headers/musicheaders4.asm -- APPEND the header, never insert: song
;      ids are (header - $4000) / 3 and inserting renumbers everything below
;   3. constants/music_constants.asm -- music_const under AUDIO_4
;   4. audio.asm -- INCLUDE under SECTION "Music 4"
;   5. data/maps/songs.asm -- the map's line
;   then: python .claude/song_id_audit.py  (nothing may land on id 255)
;         python .claude/music_analyze.py  (all channels 192 intro / 3072 loop)
;
; D major, tempo 140, 4 channels, 1 + 16 bars.
;
; The decisions, stated so they can be argued with:
;
; MODE. D major, cadencing rather than circling:
;     D  G  D  A  |  D  G  A  D  |  Bm G  D  A  |  G  A  D  A
; That is I-IV-I-V / I-IV-V-I / vi-IV-I-V / IV-V-I-V. It lands on the tonic at
; bar 8 and again at bar 15, and the last bar is a dominant that pulls back to
; the top. This is the Gen 1 grammar: Saffron's i-v-VI-VII vamp orbits without
; resolving on purpose, and that is exactly what a seaside town should not do.
; The one turn to the relative minor is bar 9, and it is there to lift the
; third phrase into a higher register, not to darken anything -- it is back on
; D two bars later.
;
; VOICE. Lead on duty_cycle 3, the 75% pulse -- the warm one Cities1, Cities2,
; Celadon, Vermilion, Cinnabar, Routes 3/4 and Indigo all share. A 12.5% lead
; was tried, on the argument that no map theme uses one; Forte preferred this,
; and he was right. Ch2 sits underneath on the 50% square for body.
;
; SHAPE. Every phrase is an arc that rises and settles back, and each of the
; four ends with a rest. That breath is the whole coastal idea; a theme with no
; gaps in it sounds like a town square, not a shoreline. The ornament pairs
; (the length-1 notes in bars 2, 6, 11 and 14) sit on the crests. Cities2's lead
; has nine of them and Celadon's sixteen, and they are what stops a melody
; reading as a row of held notes -- see the note in the memory on this. They are
; all written inside a single octave: an `octave` command in the middle of an
; ornament ruins it.
;
; Ch3, the wave channel, is the rocking arpeggio. Root-third-fifth-third,
; eighths,
; continuously -- but the bar that ends each phrase drops its last two eighths
; for a rest, so it swells and recedes instead of ticking. It sits in octave 4,
; where every shipped city theme puts this channel (Cities1, Cities2, Celadon,
; Pallet and Vermilion are all octave 4 here; a note in my memory saying octave
; 3 is simply wrong and was checked against the source).
;
; DRUMS. The Gen 1 figure and nothing else:
; 6+6+4, two long hits on instrument 6 and a short one on 7, which is exactly
; one bar. Four-on-the-floor appears nowhere in Gen 1 and is what makes a track
; sound like a modern chiptune. The first phrase is on the quiet instrument 8
; so the track opens light and the kit arrives with the second phrase.
;
; TEMPO 140. Bigger is slower -- the delay is note_length * note_speed * tempo
; (Audio1_note_length). Cities2 is 148 and Celadon 144, so this is a shade
; quicker than either, which is most of the "happier".
;
; ENGINE NOTES, because two of these are traps:
;   - No finite `sound_loop N` anywhere. Its counter is compared before it is
;     incremented and is reset to 1 and not 0 on exit, so a block plays N+1
;     times on the first pass and N times afterwards, leaving that channel
;     permanently offset from the others. Cities1 and Vermilion both ship that
;     way. Every repeat here is a `sound_call` instead.
;   - `sound_call` does not nest: there is one return address per channel
;     (wChannelReturnAddresses). No sub here calls another sub.
;   - All four channels are 192 ticks of intro and 3072 of loop -- 1 bar and 16.
;     Nothing in the engine lines channels up; if these numbers stop matching,
;     the track walks out of phase with itself and there is no build error.
; The channel lengths are the thing to re-check after any edit.

Music_UnusedTownTheme_Ch1::
	tempo 140
	volume 7, 7
	duty_cycle 3
	vibrato 8, 2, 4
	toggle_perfect_pitch
	note_type 12, 12, 6
; Intro: the melody arrives half a bar late, over water that is already moving.
	rest 8
	octave 4
	note D_, 2
	note E_, 2
	note F#, 2
	note A_, 2
.mainloop:
	octave 4
; Phrase A -- D G D A. States the tune, ends on the dominant, breathes.
	note D_, 4
	note E_, 2
	note F#, 2
	note A_, 4
	note F#, 4

	note G_, 4
	note F#, 1
	note G_, 1
	note F#, 2
	note E_, 2
	note D_, 4
	octave 3
	note B_, 2

	note A_, 2
	note B_, 2
	octave 4
	note D_, 4
	note F#, 4
	note E_, 4

	note C#, 6
	note E_, 2
	octave 3
	note A_, 4
	rest 4

; Phrase B -- D G A D. The answer. Cadences onto D at bar 8.
	octave 4
	note F#, 4
	note A_, 2
	note B_, 1
	note A_, 1
	note F#, 4
	note D_, 4

	note G_, 4
	note B_, 2
	note A_, 1
	note B_, 1
	note A_, 2
	note G_, 2
	note F#, 4

	note E_, 4
	note G_, 2
	note F#, 2
	note E_, 4
	note C#, 4

	note D_, 8
	rest 4
	octave 3
	note A_, 4

; Phrase C -- Bm G D A. The lift: a fifth higher, and the only bar that touches
; octave 5. Back on D two bars later.
	octave 4
	note B_, 4
	note A_, 2
	note F#, 2
	note B_, 4
	octave 5
	note D_, 4

	note D_, 6
	octave 4
	note B_, 2
	note G_, 4
	note B_, 4

	note A_, 4
	note B_, 1
	note A_, 1
	note F#, 2
	note A_, 4
	note D_, 4

	note E_, 6
	note F#, 2
	note E_, 4
	note C#, 4

; Phrase D -- G A D A. Walks home and hands back to the dominant for the loop.
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note G_, 4
	note F#, 4
	note E_, 4

	note E_, 4
	note C#, 1
	note D_, 1
	note E_, 2
	note A_, 4
	note G_, 4

	note F#, 8
	note E_, 2
	note D_, 2
	note F#, 4

	note E_, 4
	note C#, 4
	octave 3
	note A_, 4
	rest 4
	sound_loop 0, .mainloop

Music_UnusedTownTheme_Ch2::
	duty_cycle 2
	vibrato 12, 2, 3
	note_type 12, 9, 3
; Body under the 12.5% lead, and the fill in the bars where the lead rests.
	rest 16
.mainloop:
	octave 3
	note A_, 4
	note F#, 4
	note A_, 4
	octave 4
	note D_, 4

	octave 3
	note B_, 4
	note G_, 4
	note B_, 4
	octave 4
	note D_, 4

	octave 3
	note A_, 4
	note F#, 2
	note G_, 2
	note A_, 4
	note F#, 4

	octave 4
	note C#, 4
	octave 3
	note A_, 4
	note E_, 4
	rest 4

	octave 4
	note D_, 4
	octave 3
	note A_, 4
	note F#, 4
	note A_, 4

	octave 4
	note D_, 4
	octave 3
	note B_, 4
	note G_, 4
	note B_, 4

	octave 4
	note C#, 4
	note E_, 2
	note C#, 2
	octave 3
	note A_, 4
	note G_, 4

	note F#, 8
	rest 4
	note A_, 4

	octave 4
	note F#, 4
	note D_, 4
	octave 3
	note B_, 4
	note F#, 4

	octave 4
	note G_, 4
	note D_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 4
	octave 3
	note G_, 4

	octave 4
	note F#, 4
	note D_, 4
	octave 3
	note A_, 4
	note F#, 4

	octave 4
	note E_, 4
	note C#, 2
	note D_, 2
	note E_, 4
	octave 3
	note A_, 4

	note G_, 4
	note B_, 4
	octave 4
	note D_, 4
	octave 3
	note B_, 4

	note A_, 4
	octave 4
	note C#, 2
	note D_, 2
	note E_, 4
	note C#, 4

	note D_, 8
	octave 3
	note A_, 4
	note F#, 4

	note E_, 4
	note G_, 4
	note A_, 4
	rest 4
	sound_loop 0, .mainloop

Music_UnusedTownTheme_Ch3::
	note_type 12, 1, 1
	octave 4
; The water. One bar per chord, eighths, and the bar that closes each phrase
; gives back its last two so the figure breathes instead of ticking.
	sound_call .dBar
.mainloop:
	sound_call .dBar
	sound_call .gBar
	sound_call .dBar
	sound_call .aBarBreath

	sound_call .dBar
	sound_call .gBar
	sound_call .aBar
	sound_call .dBarBreath

	sound_call .bmBar
	sound_call .gBar
	sound_call .dBar
	sound_call .aBarBreath

	sound_call .gBar
	sound_call .aBar
	sound_call .dBar
	sound_call .aBarBreath
	sound_loop 0, .mainloop

.dBar:
	note D_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	sound_ret

.dBarBreath:
	note D_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	rest 4
	sound_ret

.gBar:
	note D_, 2
	note G_, 2
	note B_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note B_, 2
	note G_, 2
	sound_ret

.aBar:
	note C#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note C#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	sound_ret

.aBarBreath:
	note C#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note C#, 2
	note E_, 2
	rest 4
	sound_ret

.bmBar:
	note D_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	sound_ret

Music_UnusedTownTheme_Ch4::
	drum_speed 12
	rest 16
.mainloop:
; Phrase A on the quiet instrument, so the kit arrives with phrase B.
	sound_call .hat
	sound_call .hat
	sound_call .hat
	sound_call .hat

	sound_call .beat
	sound_call .beat
	sound_call .beat
	sound_call .fill

	sound_call .beat
	sound_call .beat
	sound_call .beat
	sound_call .fill

	sound_call .beat
	sound_call .beat
	sound_call .fill
	sound_call .hat
	sound_loop 0, .mainloop

.hat:
	drum_note 8, 6
	drum_note 8, 6
	drum_note 8, 4
	sound_ret

.beat:
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	sound_ret

.fill:
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 2
	drum_note 6, 2
	sound_ret
