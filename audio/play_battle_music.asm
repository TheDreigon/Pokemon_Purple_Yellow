PlayBattleMusic::
	xor a
	ld [wAudioFadeOutControl], a
	ld [wLowHealthAlarm], a
	call StopAllMusic
	call DelayFrame
	ld c, BANK(Music_GymLeaderBattle) ; every fallback theme lives in this bank
	ld a, [wCurOpponent]
	cp OPP_ID_OFFSET
	jr c, .wildBattle
; v0.7: battle music is picked per trainer from the table below rather than
; from wGymLeaderNo, so a class always sounds the same — that also covers the
; gym-leader REMATCHES (which never set wGymLeaderNo) and Giovanni's three
; appearances (only the Viridian one sets it).
	ld b, a
	ld hl, BattleMusicByOpponent
.lookup
	ld a, [hli]
	cp -1
	jr z, .noOverride
	cp b
	jr z, .found
	inc hl ; skip music id
	inc hl ; skip bank
	jr .lookup
.found
	ld a, [hli] ; music id
	ld c, [hl]  ; the bank it lives in (not all themes share one)
	jr .playSong
.noOverride
; Everything unlisted gets the normal trainer theme. Vanilla consulted
; wGymLeaderNo here, but every class that writes it is now a table entry, so
; the only thing that branch could still do was leak a STALE leader number
; onto an ordinary trainer: beat the leader, then fight a gym trainer you
; skipped without leaving the map (Saffron's teleport maze allows it) and the
; grunt inherited the leader theme. wGymLeaderNo is only cleared on map entry.
.normalTrainerBattle
	ld a, MUSIC_TRAINER_BATTLE
	jr .playSong
.wildBattle
	ld a, MUSIC_WILD_BATTLE
.playSong
	jp PlayMusic

; Per-trainer battle themes (Forte's tier/music review). Anything not listed
; keeps the normal trainer theme. Order doesn't matter (linear scan);
; 3 bytes per entry: opponent id, music id, music bank; -1 terminates.
;
; ⚠️ BATTLE MUSIC MUST LIVE IN THE AUDIO-2 BANK. PlayMusic latches the bank
; into wAudioROMBank, nothing in engine/battle/ ever re-points it, and the SFX
; dispatcher routes by that same variable — so a track from another bank sends
; every in-battle move/damage/faint sound into that bank's SFX_Headers_N,
; which does NOT contain the battle SFX (only SFX_Headers_2 does; see
; engine/debug/animation_test.asm). The result is garbage sounds and a torn
; down theme. The macro below turns that mistake into a build failure.
MACRO battle_music
	ASSERT BANK(\3) == BANK(Music_GymLeaderBattle), \
		"battle music must live in the Audio-2 bank or in-battle SFX break"
	db \1, \2, BANK(\3)
ENDM

BattleMusicByOpponent:
; the final-battle tier — the Champion, Oak, the Rocket boss, and DREIGON
	battle_music OPP_RIVAL3,   MUSIC_FINAL_BATTLE,      Music_FinalBattle
	battle_music OPP_PROF_OAK, MUSIC_FINAL_BATTLE,      Music_FinalBattle
	battle_music OPP_GIOVANNI, MUSIC_FINAL_BATTLE,      Music_FinalBattle
	battle_music OPP_FORTE,    MUSIC_FINAL_BATTLE,      Music_FinalBattle
; the gym-leader tier — the 7 badge leaders (Giovanni is a tier above), the
; Elite Four, and the three self-insert semi-bosses
	battle_music OPP_BROCK,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_MISTY,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_LT_SURGE, MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_ERIKA,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_KOGA,     MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_SABRINA,  MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_BLAINE,   MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_LORELEI,  MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_BRUNO,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_AGATHA,   MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_LANCE,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_KIYO,     MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_SMITH,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_CRAIG,    MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
	battle_music OPP_WEEBRA,   MUSIC_GYM_LEADER_BATTLE, Music_GymLeaderBattle
; DELIBERATELY NOT LISTED (they keep the normal trainer theme):
;  - JANINE — the gym-leader theme stays reserved for badge holders
;  - JOY / JENNY / BILL — they still earn the grand victory fanfare (see
;    GrandVictoryClasses); the asymmetry with Smith/Craig/Weebra is intended
;  - RIVAL1 / RIVAL2 — the rival's sound escalates; only RIVAL3 is special
;  - JESSIE_AND_JAMES — they SHOULD fight to their own looping Yellow theme,
;    but it CANNOT be done. Two walls, both verified: (1) Music_MeetJessieJames
;    lives in the Audio-4 bank, and battle music must be in Audio-2 (see the
;    warning above); (2) porting a copy into Audio-2 is impossible because that
;    bank's SONG-ID SPACE IS EXACTLY FULL — song ids are (header-SFX_Headers_1)/3,
;    the seven battle songs occupy ids 234-254 with no gap, and the next slot is
;    255 = SFX_STOP_ALL_MUSIC, which PlaySound treats as "stop the music"
;    (home/audio.asm). An 8th Audio-2 song would play as silence and corrupt
;    wLastMusicSoundID. Freeing a slot means deleting a battle theme or a
;    victory fanfare — all seven are load-bearing. Their pre-battle jingle
;    (which IS their own theme) still plays; that is where their identity lives.
	db -1 ; end
	ASSERT OPP_ID_OFFSET + NUM_TRAINERS < $ff, \
		"an OPP id would collide with this table's -1 terminator"
