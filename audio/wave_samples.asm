; This file is INCLUDEd once, as Audio1_WavePointers (audio.asm, SECTION "Music 1"); the shared sound engine uses this single copy for all four audio banks.

	dw .wave0
	dw .wave1
	dw .wave2
	dw .wave3
	dw .wave4
	dw .wave5 ; used in the Lavender Town and Pokemon Tower themes
	dw .wave5 ; unused
	dw .wave5 ; unused

; these are the definitions for the channel 3 instruments
; each instrument definition is made up of 32 points (nibbles) that form
; the graph of the wave
; the current instrument is copied to rWave_0--rWave_f
.wave0
	dn  0,  2,  4,  6,  8, 10, 12, 14, 15, 15, 15, 14, 14, 13, 13, 12, 12, 11, 10,  9,  8,  7,  6,  5,  4,  4,  3,  3,  2,  2,  1,  1

.wave1
	dn  0,  2,  4,  6,  8, 10, 12, 14, 14, 15, 15, 15, 15, 14, 14, 14, 13, 13, 12, 11, 10,  9,  8,  7,  6,  5,  4,  3,  2,  2,  1,  1

.wave2
	dn  1,  3,  6,  9, 11, 13, 14, 14, 14, 14, 15, 15, 15, 15, 14, 13, 13, 14, 15, 15, 15, 15, 14, 14, 14, 14, 13, 11,  9,  6,  3,  1

.wave3
	dn  0,  2,  4,  6,  8, 10, 12, 13, 14, 15, 15, 14, 13, 14, 15, 15, 14, 14, 13, 12, 11, 10,  9,  8,  7,  6,  5,  4,  3,  2,  1,  0

.wave4
	dn  0,  1,  2,  3,  4,  5,  6,  7,  8, 10, 12, 13, 14, 14, 15,  7,  7, 15, 14, 14, 13, 12, 10,  8,  7,  6,  5,  4,  3,  2,  1,  0

; wave5 has no data of its own: the engine copies the 16 bytes that follow this label (currently the start of Music_PkmnHealed_Ch1 via audio.asm's include order). Lavender Town and Pokemon Tower Ch3 use instrument 5, so reordering what follows this file changes how they sound.
.wave5
