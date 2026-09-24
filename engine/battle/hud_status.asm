; The battle HUD's three status tiles: the persistent status, TOX, CNF, and
; the 2-second CNF/status alternation. Moved out of Battle Core on 2026-09-24
; (that bank sat at its floor). Bank-agnostic: hlcoord is a WRAM address and
; the only calls out are to home.
;
; Confusion cannot go through PrintStatusAilment: that routine reads a mon's
; STATUS BYTE, confusion is volatile and lives in wXBattleStatus1, and the
; routine is shared with the party menu and the stats screen, where the row
; being drawn is usually not the battler. Same reason TOX lives here and not
; there: BADLY_POISONED is wXBattleStatus3 bit 0, gone once the #MON is
; switched out, so the party list keeps saying PSN, which is what it will be.
;
; A persistent status OUTRANKS confusion: three tiles and no more.

; IN  c = 0 for the player's HUD, 1 for the enemy's. Registers a, b and hl do
;     not survive rst _Bankswitch, so callers hand over one byte and everything
;     is derived here.
; OUT a  = that battler's BattleStatus1
;     bc = its BattleStatus3 address (BADLY_POISONED lives there)
;     de = its status byte
;     hl = its three status tiles: (15,8) for the player, (7,1) for the enemy
LoadBattlerStatusRegs:
	ld a, c
	and a
	jr nz, .enemy
	ld bc, wPlayerBattleStatus3
	ld de, wBattleMonStatus
	hlcoord 15, 8
	ld a, [wPlayerBattleStatus1]
	ret
.enemy
	ld bc, wEnemyBattleStatus3
	ld de, wEnemyMonStatus
	hlcoord 7, 1
	ld a, [wEnemyBattleStatus1]
	ret

; PrintStatusConditionNotFainted for a BATTLER: a PSN whose BattleStatus3 says
; BADLY_POISONED reads TOX.
; IN  bc = BattleStatus3 address, de = status byte, hl = the three tiles
; OUT NZ when something was written -- the contract every status printer has
PrintBattlerStatus::
	ld a, [de]
	bit PSN, a
	jp z, PrintStatusConditionNotFainted
	ld a, [bc]
	bit BADLY_POISONED, a
	jp z, PrintStatusConditionNotFainted
	ld a, "T"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld [hl], "X"
	and a ; NZ: "X" is not zero. Belt and braces, like the CNF tail below.
	ret

; The HUD's three status tiles: the persistent status (TOX included), else CNF
; when the battler is confused, else nothing.
; IN  c = side (see LoadBattlerStatusRegs)
; OUT NZ when something was written. The HUD no longer drops the level on it
;     (the level has its own cells now); emu_test_status_hud still asserts it.
PrintStatusOrConfusion::
	call LoadBattlerStatusRegs
	push af
	call PrintBattlerStatus
; homejp_sf pushes and pops its own bank byte, so the top of the stack here is
; still our BattleStatus1 -- and `pop bc` leaves the flags the call returned
; with, which is the whole reason that macro exists in the _sf form.
	pop bc
	ret nz ; a real status was drawn, and it wins the slot
	bit CONFUSED, b
	ret z
	ld a, "C"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld a, "F"
	ld [hl], a
; The `bit` above already left NZ and none of the loads touch the flags; this is
; here so the NZ survives someone inserting a flag-touching instruction later.
	and a
	ret

; Alternates the HUD's three status tiles between the persistent status and CNF
; for a battler that has BOTH, about every two seconds.
;
; Called once per POLL of HandleMenuInput_'s inner loop (home/window.asm,
; farcall) -- ~50-100 times a frame, NOT once a frame; that loop has no frame
; wait, which is why the phase reads the wall clock. Every menu in the game
; shares the loop -- hence two gates, and both are load-bearing:
;   hHUDStatusFlip           0 unless the battle menu deliberately set it
;                            (BattleMenuInput, core.asm); HandleMenuInput
;                            clears it for everyone else.
;   wPartyMenuAnimMonEnabled the party menu is the ONE caller that enters at
;                            HandleMenuInput_ and so never clears the byte
;                            above. Without this check, switching #MON mid
;                            battle would stamp CNF into the party list.
AlternateHUDStatus::
	ldh a, [hHUDStatusFlip]
	and a
	ret z
	ld a, [wPartyMenuAnimMonEnabled]
	and a
	ret nz
	ld c, 0
	call .side
	ld c, 1
	; falls through, and the ret at the end of .side is this routine's own
.side
	call LoadBattlerStatusRegs
	bit CONFUSED, a
	ret z ; not confused, so the HUD is already showing the right thing
	ld a, [de]
	and a
	ret z ; confused and nothing else -- the HUD already says CNF
; The phase is the WALL CLOCK: TrackPlayTime advances wPlayTimeSeconds
; (binary, 0-59) once a second in VBlank, so bit 1 alternates every two
; seconds no matter how often this poll loop lands here. Known edge: a play
; clock frozen at its 255:59 cap pins the seconds at 59, whose bit 1 is SET,
; so nz must be the phase that shows the PERSISTENT status (the honest,
; always-true label), never a CNF stuck on screen for the rest of a maxed save.
	ld a, [wPlayTimeSeconds]
	and $02 ; bit 1 of the seconds: flips every two seconds
	jp nz, PrintBattlerStatus ; put the real status back (TOX included)
	ld a, "C"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld [hl], "F"
	ret
