; The player's red-HP alarm; VBlank runs it every frame (home/vblank.asm,
; home/cgb_palettes.asm Func_3082). v1.0 (2026-09-24, Forte): three cycles,
; then quiet, and it re-arms once the bar has left the red.
;
; wLowHealthAlarm:
;   bit 7    = sounding. DrawPlayerHUDAndHPBar sets it while the bar is red.
;   bits 6-5 = cycles begun in this stay in the red, 0-3.
;   bits 4-0 = frame timer, 0-30 (high tone at 0, low tone at 20).
;   $ff      = stop now (RemoveFaintedPlayerMon).
; The fourth cycle is refused: the byte parks at $60 (count 3, not sounding),
; channel 1 goes back to the music, and DrawPlayerHUDAndHPBar leaves $60 alone
; until the bar is no longer red - it writes 0 then, which re-arms the alarm.
Music_DoLowHealthAlarm::
	ld a, [wLowHealthAlarm]
	cp $ff
	jr z, .disableAlarm

	bit 7, a  ;alarm enabled?
	ret z     ;nope

	ld b, a   ; keep the enable bit and the cycle count
	and $1f   ;low 5 bits are the timer.
	jr nz, .notToneHi ;if timer > 0, play low tone.

; timer ran out: a cycle begins. Count it in bits 6-5; the fourth add carries
; out of bit 6 ($e0 + $20) - three have sounded, go quiet instead.
	ld a, b
	add $20
	jr c, .goQuiet
	ld b, a
	call .playToneHi
	ld a, 30 ;keep this tone for 30 frames.
	jr .resetTimer

.notToneHi
	cp 20
	jr nz, .noTone   ;if timer == 20,
	call .playToneLo ;actually set the sound registers.

.noTone
	ld a, $86
	ld [wChannelSoundIDs + CHAN5], a ;disable sound channel?
	ld a, b
	and $1f ;decrement alarm timer.
	dec a

.resetTimer
	; the new timer under the enable bit and the cycle count
	ld c, a
	ld a, b
	and $e0
	or c
	ld [wLowHealthAlarm], a
	ret

.goQuiet
	ld a, $60 ; count 3, not sounding: parked until the bar leaves the red
	jr .silence

.disableAlarm
	xor a
.silence
	ld [wLowHealthAlarm], a  ;disable alarm
	xor a
	ld [wChannelSoundIDs + CHAN5], a  ;re-enable sound channel?
	ld de, .toneDataSilence
	jr .playTone

;update the sound registers to change the frequency.
;the tone set here stays until we change it.
.playToneHi
	ld de, .toneDataHi
	jr .playTone

.playToneLo
	ld de, .toneDataLo

;update sound channel 1 to play the alarm, overriding all other sounds.
.playTone
	ld hl, rNR10 ;channel 1 sound register
	ld c, $5
	xor a

.copyLoop
	ld [hli], a
	ld a, [de]
	inc de
	dec c
	jr nz, .copyLoop
	ret

MACRO alarm_tone
	db \1 ; length
	db \2 ; envelope
	dw \3 ; frequency
ENDM

;bytes to write to sound channel 1 registers for health alarm.
;starting at FF11 (FF10 is always zeroed).
.toneDataHi
	alarm_tone $A0, $E2, $8750

.toneDataLo
	alarm_tone $B0, $E2, $86EE

;written to stop the alarm
.toneDataSilence
	alarm_tone $00, $00, $8000
