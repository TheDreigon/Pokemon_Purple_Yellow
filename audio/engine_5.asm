; The fifth of the partially duplicated sound engines: the PlaySound shim for
; AUDIO_5, cloned from engine_4.asm. Only this dispatcher is per-bank -- the
; music interpreter is Audio1_UpdateMusic for every bank, reading data through
; GetNextMusicByte, which switches to wAudioROMBank byte by byte.
;
; The sfx/music window differs from engine_4 on purpose. Bank $20 keeps sfx
; headers ABOVE its music ids (the get-item jingles), so engine_4 re-routes
; ids above $a3 back to .playSfx. This bank is laid out like bank 1 -- all sfx
; below, all music above -- so the window is engine_1's: everything between
; MAX_SFX_ID_5 and $fe is music. Send a music id down the sfx path and it
; still plays but skips InitMusicVariables, inheriting the previous track's
; tempo -- measured on 2026-08-06, that is exactly how a wrong rendition of
; SaffronFree got recorded as a "reference".

Audio5_PlaySound::
	ld [wSoundID], a
	ld a, [wSoundID]
	cp $ff
	jp z, .stopAllAudio
	cp MAX_SFX_ID_5
	jp z, .playSfx
	jp c, .playSfx
	cp $fe
	jr z, .playMusic
	jp nc, .playSfx

.playMusic
	call InitMusicVariables
	jp .playSoundCommon

.playSfx
	ld l, a
	ld e, a
	ld h, 0
	ld d, h
	add hl, hl
	add hl, de
	ld de, SFX_Headers_5
	add hl, de
	ld a, h
	ld [wSfxHeaderPointer], a
	ld a, l
	ld [wSfxHeaderPointer + 1], a
	ld a, [hl]
	and $c0
	rlca
	rlca
	ld c, a
.sfxChannelLoop
	ld d, c
	ld a, c
	add a
	add c
	ld c, a
	ld b, 0
	ld a, [wSfxHeaderPointer]
	ld h, a
	ld a, [wSfxHeaderPointer + 1]
	ld l, a
	add hl, bc
	ld c, d
	ld a, [hl]
	and $f
	ld e, a ; software channel ID
	ld d, 0
	ld hl, wChannelSoundIDs
	add hl, de
	ld a, [hl]
	and a
	jr z, .playChannel
	ld a, e
	cp CHAN8
	jr nz, .notNoiseChannel
	ld a, [wSoundID]
	cp NOISE_INSTRUMENTS_END
	jr nc, .notNoiseInstrument
	ret
.notNoiseInstrument
	ld a, [hl]
	cp NOISE_INSTRUMENTS_END
	jr z, .playChannel
	jr c, .playChannel
.notNoiseChannel
	ld a, [wSoundID]
	cp [hl]
	jr z, .playChannel
	jr c, .playChannel
	ret
.playChannel
	call InitSFXVariables
	ld a, c
	and a
	jp z, .playSoundCommon
	dec c
	jp .sfxChannelLoop

.stopAllAudio
	call StopAllAudio
	ret

.playSoundCommon
	ld a, [wSoundID]
	ld l, a
	ld e, a
	ld h, 0
	ld d, h
	add hl, hl
	add hl, de
	ld de, SFX_Headers_5
	add hl, de
	ld e, l
	ld d, h
	ld hl, wChannelCommandPointers
	ld a, [de] ; get channel number
	ld b, a
	rlca
	rlca
	and $3
	ld c, a
	ld a, b
	and $f
	ld b, c
	inc b
	inc de
	ld c, 0
.commandPointerLoop
	cp c
	jr z, .next
	inc c
	inc hl
	inc hl
	jr .commandPointerLoop
.next
	push af
	push hl
	push bc
	ld b, 0
	ld c, a
	cp CHAN4
	jr c, .skipSettingFlag
	ld hl, wChannelFlags1
	add hl, bc
	set BIT_NOISE_OR_SFX, [hl]
.skipSettingFlag
	pop bc
	pop hl
	ld a, [de] ; get channel pointer
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	pop af
	push hl
	push bc
	ld b, 0
	ld c, a
	ld hl, wChannelSoundIDs
	add hl, bc
	ld a, [wSoundID]
	ld [hl], a
	pop bc
	pop hl
	inc c
	dec b
	ld a, b
	and a
	ld a, [de]
	inc de
	jr nz, .commandPointerLoop
	ld a, [wSoundID]
	cp CRY_SFX_START
	jr nc, .maybeCry
	jr .done
.maybeCry
	ld a, [wSoundID]
	cp CRY_SFX_END
	jr z, .done
	jr c, .cry
	jr .done
.cry
	ld hl, wChannelSoundIDs + CHAN5
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wChannelCommandPointers + CHAN7 * 2 ; sfx wave channel pointer
	ld de, Audio5_CryRet
	ld [hl], e
	inc hl
	ld [hl], d ; overwrite pointer to point to sound_ret
	ld a, [wSavedVolume]
	and a
	jr nz, .done
	ldh a, [rNR50]
	ld [wSavedVolume], a
	ld a, $77
	ldh [rNR50], a ; full volume
.done
	ret

Audio5_CryRet:
	sound_ret
