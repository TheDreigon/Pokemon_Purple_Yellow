; The battle HUD's three status tiles: the persistent status, TOX, CNF, and
; the 2-second CNF/status alternation. Moved out of Battle Core on 2026-09-24
; (that bank sat at its floor). Bank-agnostic: hlcoord is a WRAM address and
; the only calls out are to home (and, since 2026-11-12, one farcall on the GBC).
;
; Confusion cannot go through PrintStatusAilment: that routine reads a mon's
; STATUS BYTE, confusion is volatile and lives in wXBattleStatus1, and the
; routine is shared with the party menu and the stats screen, where the row
; being drawn is usually not the battler. TOX is read here from the LIVE bit
; (BADLY_POISONED, wXBattleStatus3 bit 0). Since 2026-11-11 the #MON's own mark
; is TOX in its status byte, with PSN ($88; it stays when the #MON is called back
; and it outlives the battle), and the live bit is kept equal to it at every
; send-out and at every write-back to the party (toxic_carry.asm).
;
; A persistent status OUTRANKS confusion: three tiles and no more.
;
; v1.0 (2026-11-12): on the GBC the three letters are COLOURED, an ink per status.
; They are not the font's tiles there but copies of them in other colour indices
; (STATUS_TILE_x in index 2, CNF_TILE_x in index 1; constants/gfx_constants.asm),
; written straight into the tile map from StatusLetterTileIDs, on cells whose BG
; palettes (5 the enemy's, 6 the player's) hold both inks at once; the palettes
; and the tiles are loaded in bank $2F (engine/gfx/bg_map_attributes.asm, which
; has the whole design). So each printer here has a GBC path next to the old
; one, which the DMG and the SGB still take, unchanged (hGBC = 0). Rules of the
; GBC path:
;   - never a font letter in these cells, not even for one poll: AlternateHUDStatus
;     runs with the BG auto-transfer on, and a font letter would show black;
;   - the printers only draw tiles. Which label a battler's status bytes ask for
;     is decided in ONE routine, BattlerStatusInkID, whose answer (an ink id) the
;     printer turns into three tiles and the HUD's tail into an ink;
;   - the ink follows the LABEL, not the status bytes: SyncStatusLetterInk, called
;     at the tail of each HUD draw (DrawPlayerHUDAndHPBar, DrawEnemyHUDAndHPBar),
;     records the label's ink id in the INK REGISTER (hStatusLetterInk) and, when
;     it changed, has the palette written in the V-blank that brings the tiles
;     (WriteStatusLetterPaletteSynced, this file's one farcall). The alternation
;     never writes a palette: CNF's ink is always in it.

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
	ldh a, [hGBC]
	and a
	jr nz, PrintBattlerStatusGBC
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
	and a ; NZ: "O" is not zero. Belt and braces, like the CNF tail below.
	ret

; THE SELECTOR (v1.0, 2026-11-12): which persistent-status label a battler's status bytes ask for,
; as an ink id (STATUS_INK_*, constants/gfx_constants.asm). The bytes and the order of precedence
; are those of the font's printer above: TOX (a PSN whose BattleStatus3 says BADLY_POISONED), then
; PrintStatusAilment's PSN, BRN, FRZ, PAR, SLP. The GBC printer draws the tiles of the id it
; returns and the HUD's tail records the same id as the label's ink (SyncStatusLetterInk), so the
; precedence lives here and nowhere else on the GBC. (An id, not a set of tiles: two labels can
; share their letters and differ in ink.)
; IN  bc = BattleStatus3 address, de = status byte
; OUT a = the ink id; STATUS_INK_NONE (0) = no persistent status. bc, de and hl are kept.
BattlerStatusInkID:
	ld a, [de]
	bit PSN, a
	jr z, .notPoisoned
	ld a, [bc]
	bit BADLY_POISONED, a
	ld a, STATUS_INK_PSN
	ret z
	ASSERT STATUS_INK_TOX == STATUS_INK_PSN + 1
	inc a ; STATUS_INK_TOX
	ret
.notPoisoned
	bit BRN, a
	jr nz, .brn
	bit FRZ, a
	jr nz, .frz
	bit PAR, a
	jr nz, .par
	and SLP_MASK
	ASSERT STATUS_INK_NONE == 0
	ret z
	ld a, STATUS_INK_SLP
	ret
.brn
	ld a, STATUS_INK_BRN
	ret
.frz
	ld a, STATUS_INK_FRZ
	ret
.par
	ld a, STATUS_INK_PAR
	ret

; PrintBattlerStatus on the GBC (v1.0, 2026-11-12): the label the selector asks for, in the
; coloured tiles.
; IN  bc = BattleStatus3 address, de = status byte, hl = the three tiles
; OUT NZ and the three tiles written, or Z and hl untouched (PrintStatusOrConfusion then
;     writes CNF there)
PrintBattlerStatusGBC:
	call BattlerStatusInkID
	and a
	ret z
; de = the id's row of StatusLetterTileIDs: StatusLetterTileIDs + (id - 1) * 3
	ld e, a
	add a
	add e
	add LOW(StatusLetterTileIDs - 3)
	ld e, a
	adc HIGH(StatusLetterTileIDs - 3)
	sub e
	ld d, a
; fall through

; IN  de = three tile ids, hl = the three tiles
; OUT NZ
WriteStatusLetterTiles:
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	and a ; NZ: no tile id is zero
	ret

StatusLetterTileIDs:
; The GBC's three tiles of each label, in the order of the ink ids: ink id n is row n - 1
; (PrintBattlerStatusGBC). CNF's row, the last, is not an id. STATUS_INK_BLEED, the last id,
; has no row: it has no tiles yet and the selector never returns it.
.psn:    db STATUS_TILE_P, STATUS_TILE_S, STATUS_TILE_N
.tox:    db STATUS_TILE_T, STATUS_TILE_O, STATUS_TILE_X
.brn:    db STATUS_TILE_B, STATUS_TILE_R, STATUS_TILE_N
.brnOut: db STATUS_TILE_B, STATUS_TILE_R, STATUS_TILE_N ; not used yet: BRN's letters, another ink
.par:    db STATUS_TILE_P, STATUS_TILE_A, STATUS_TILE_R
.slp:    db STATUS_TILE_S, STATUS_TILE_L, STATUS_TILE_P
.frz:    db STATUS_TILE_F, STATUS_TILE_R, STATUS_TILE_Z
.cnf:    db CNF_TILE_C, CNF_TILE_N, CNF_TILE_F
	ASSERT StatusLetterTileIDs.psn    - StatusLetterTileIDs == (STATUS_INK_PSN     - 1) * 3
	ASSERT StatusLetterTileIDs.tox    - StatusLetterTileIDs == (STATUS_INK_TOX     - 1) * 3
	ASSERT StatusLetterTileIDs.brn    - StatusLetterTileIDs == (STATUS_INK_BRN     - 1) * 3
	ASSERT StatusLetterTileIDs.brnOut - StatusLetterTileIDs == (STATUS_INK_BRN_OUT - 1) * 3
	ASSERT StatusLetterTileIDs.par    - StatusLetterTileIDs == (STATUS_INK_PAR     - 1) * 3
	ASSERT StatusLetterTileIDs.slp    - StatusLetterTileIDs == (STATUS_INK_SLP     - 1) * 3
	ASSERT StatusLetterTileIDs.frz    - StatusLetterTileIDs == (STATUS_INK_FRZ     - 1) * 3
	ASSERT StatusLetterTileIDs.cnf    - StatusLetterTileIDs == (STATUS_INK_BLEED   - 1) * 3
	ASSERT STATUS_INK_BLEED == NUM_STATUS_INKS

; The HUD's three status tiles: the persistent status (TOX included), else CNF
; when the battler is confused, else nothing.
; IN  c = side (see LoadBattlerStatusRegs)
; OUT NZ when something was written. The HUD no longer drops the level on it
;     (the level has its own cells now); emu_test_status_hud still asserts it.
PrintStatusOrConfusion::
	ldh a, [hGBC]
	and a
	jr nz, .gbc
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
.gbc
; v1.0 (2026-11-12): tiles only. The label's ink is SyncStatusLetterInk's, at the tail of the
; HUD draw this is called from.
	call LoadBattlerStatusRegs
	push af
	call PrintBattlerStatusGBC
	pop bc ; b = BattleStatus1; a pop leaves the flags alone
	ret nz ; a persistent status was drawn, and it wins the slot
	bit CONFUSED, b
	ret z
	ld de, StatusLetterTileIDs.cnf
	jr WriteStatusLetterTiles

; The ink of a HUD's persistent-status label, at the tail of the HUD draw (v1.0, 2026-11-12; the
; design is in engine/gfx/bg_map_attributes.asm). Called by DrawPlayerHUDAndHPBar and
; DrawEnemyHUDAndHPBar (engine/battle/core.asm) right in front of the instruction that switches
; the BG transfer back on, with the new label in the tile map and the old one still on screen.
; The INK REGISTER (hStatusLetterInk) names the ink of the label a side's cells last got; when the
; label just drawn has another ink, the register takes it and the palette is written in the
; V-blank that copies the tiles (WriteStatusLetterPaletteSynced). Nearly every HUD draw ends at
; the compare: the label did not change.
; The id comes from the selector, on the bytes the printer read in this same HUD draw: nothing
; writes a status byte in between.
; IN  c = 0 the player's HUD, 1 the enemy's
; de is KEPT: e is the length of the HP bar just drawn, which GetBattleHealthBarColor reads right
; after both tails. On the DMG / SGB (hGBC = 0) this is a far call that returns.
SyncStatusLetterInk::
	ldh a, [hGBC]
	and a
	ret z
	push de
	push bc ; c = the side
	call LoadBattlerStatusRegs
	call BattlerStatusInkID
	pop bc
	and a
	ASSERT STATUS_INK_NONE == 0
	jr z, .done ; no persistent label on this HUD: no cell shows the status slot
	ld hl, hStatusLetterInk
	ld b, 0
	add hl, bc
	cp [hl]
	jr z, .done
; the register follows the label ALWAYS, whatever screen's palettes are loaded; the far routine
; writes the palette only on a battle screen. c, the side, survives rst _Bankswitch on the way in.
	ld [hl], a
	farcall WriteStatusLetterPaletteSynced
.done
	pop de
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
	ldh a, [hGBC]
	and a
	jr nz, .gbc
	ld a, "C"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld [hl], "F"
	ret
.gbc
; v1.0 (2026-11-12): CNF's coloured tiles, written at once (this runs with the BG auto-transfer
; on). No palette write: CNF's ink is in the palette next to the status's.
	ld de, StatusLetterTileIDs.cnf
	jp WriteStatusLetterTiles
