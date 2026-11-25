UpdateGBCPal_BGP::
	push af
	ldh a, [hGBC]
	and a
	jr z, .notGBC
	push bc
	push de
	push hl
	ldh a, [rBGP]
	ld b, a
	ld a, [wLastBGP]
	cp b
	jr z, .noChangeInBGP
; v1.0 (2026-11-12): on a battle screen (the last palette command is SET_PAL_BATTLE_BLACK or SET_PAL_BATTLE) the
; status letters' palettes, BG 5 and 6, are written FIRST, below both rows of status cells, so they change shade
; in the same frame as palettes 0-3, which the next call writes at the V-blank that follows
; (engine/gfx/bg_map_attributes.asm). The test is made here and not behind the far call: every other screen
; then pays these three instructions per rBGP change and no bank switch (the Yellow intro has no time to
; spare). b only held rBGP for the compare above.
; v1.0 (2026-11-25, the status chapter's S6): and on the party menu and the STATS page, whose coloured status letters
; are in BG 5-7 (the same file); PreloadLetterPalettes tells the screens apart.
	ld a, [wLastPalCommand]
	cp SET_PAL_BATTLE + 1
	ASSERT SET_PAL_BATTLE_BLACK == 0 && SET_PAL_BATTLE == 1
	jr c, .letterScreen
	cp SET_PAL_STATUS_SCREEN
	jr z, .letterScreen
	cp SET_PAL_PARTY_MENU
	jr nz, .notBattleScreen
.letterScreen
	farcall PreloadLetterPalettes
.notBattleScreen
	farcall _UpdateGBCPal_BGP
; _UpdateGBCPal_BGP only rebuilds palettes 0-3 (NUM_ACTIVE_PALS); palette 4
; is the EXP bar's and is rebuilt here so it follows every fade and whiteout
	farcall LoadEXPBarPalette
.noChangeInBGP
	pop hl
	pop de
	pop bc
.notGBC
	pop af
	ret

UpdateGBCPal_OBP0::
	push af
	ldh a, [hGBC]
	and a
	jr z, .notGBC
	push bc
	push de
	push hl
	ldh a, [rOBP0]
	ld b, a
	ld a, [wLastOBP0]
	cp b
	jr z, .noChangeInOBP0
	ld b, BANK(_UpdateGBCPal_OBP)
	ld hl, _UpdateGBCPal_OBP
	ld c, CONVERT_OBP0
	call Bankswitch
.noChangeInOBP0
	pop hl
	pop de
	pop bc
.notGBC
	pop af
	ret

UpdateGBCPal_OBP1::
	push af
	ldh a, [hGBC]
	and a
	jr z, .notGBC
	push bc
	push de
	push hl
	ldh a, [rOBP1]
	ld b, a
	ld a, [wLastOBP1]
	cp b
	jr z, .noChangeInOBP1
	ld b, BANK(_UpdateGBCPal_OBP)
	ld hl, _UpdateGBCPal_OBP
	ld c, CONVERT_OBP1
	call Bankswitch
.noChangeInOBP1
	pop hl
	pop de
	pop bc
.notGBC
	pop af
	ret

Func_3082::
	ldh a, [hLoadedROMBank]
	push af
	call FadeOutAudio
	ld a, BANK(Music_DoLowHealthAlarm)
	call BankswitchCommon
	call Music_DoLowHealthAlarm
	ld a, BANK(Audio1_UpdateMusic)
	call BankswitchCommon
	call Audio1_UpdateMusic
	pop af
	call BankswitchCommon
	ret
