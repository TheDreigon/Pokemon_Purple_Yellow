; v1.0 (2026-11-10): DREADROW's cry, "G5": FEAROW's base cry (SFX_CRY_18) one octave lower - both square voices
; and the noise go down together - with SFX_CRY_18's own commands, note lengths, envelopes and duty patterns, so it
; lasts exactly as long as C1 (66 engine frames, 1.11 s) and nothing slides at the end. Written for DREADROW's
; CryData row, SFX_CRY_18, $40, $FF: the engine adds the pitch, $40, to every tone and noise value and stretches the
; tone notes by ($80 + $FF) / 256. One copy per audio engine, through audio/custom_cries.asm.
Audio{d:CUSTOM_CRY_ENGINE}_CryDreadrow_Ch5:
	duty_cycle_pattern 1, 1, 0, 0
	square_note 10, 15, 5, 1344
	square_note 3, 14, 2, 1408
	square_note 3, 15, 2, 1472
	square_note 3, 14, 2, 1536
	square_note 3, 13, 2, 1600
	square_note 3, 12, 2, 1536
	square_note 3, 13, 2, 1472
	square_note 8, 12, 1, 1408
	sound_ret

Audio{d:CUSTOM_CRY_ENGINE}_CryDreadrow_Ch6:
	duty_cycle_pattern 0, 0, 3, 3
	square_note 9, 13, 5, 1186
	square_note 3, 13, 2, 1252
	square_note 3, 14, 2, 1314
	square_note 3, 11, 2, 1378
	square_note 3, 12, 2, 1444
	square_note 3, 11, 2, 1378
	square_note 3, 12, 2, 1314
	square_note 8, 11, 1, 1250
	sound_ret

Audio{d:CUSTOM_CRY_ENGINE}_CryDreadrow_Ch8:
	noise_note 6, 14, 3, 92
	noise_note 4, 12, 3, 76
	noise_note 5, 13, 4, 76
	noise_note 4, 12, 4, 60
	noise_note 6, 11, 4, 76
	noise_note 8, 12, 1, 60
	sound_ret
