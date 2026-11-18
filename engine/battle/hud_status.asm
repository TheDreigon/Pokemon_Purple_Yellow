; The battle HUD's three status tiles: the persistent status, TOX, CNF, and
; the 2-second alternation of a side's labels. Moved out of Battle Core on 2026-09-24
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
; Three tiles and no more: a side shows one label at a time.
;
; v1.0 (2026-11-17): THE LABEL SYSTEM. A side has a LIST of labels (BattlerStatusLabels,
; a bit each in precedence order: the persistent status, then CNF; bits for BLD and SCR
; are reserved), and every label has an INK ID (STATUS_INK_*, constants/gfx_constants.asm),
; one id space for all of them. The id of label number i of the list is HUDLabelInkID's;
; the PRIMARY label is number 0. Each id has a row of three tiles in StatusLetterTileIDs
; (the GBC's coloured tiles) and in StatusLetterFontIDs (the font's letters, which the
; DMG and the SGB keep), so every printer here is the same code on every machine: the
; list, an id, a row (PrintLabelTiles).
;   - every HUD draw prints the PRIMARY label (PrintStatusOrConfusion);
;   - with two labels or more, the alternation shows label number i, from the play clock
;     (AlternateHUDStatus, HUDLabelIndex), while a battle menu waits for a key;
;   - when the battle menu returns with a key that leaves its screen (the main menu's A;
;     the FIGHT list's A, B and START; and its SELECT in the debug build's TestBattle, where
;     it opens the animation viewer), both sides are PARKED on their primary label
;     (ParkHUDStatus, from BattleMenuInput, engine/battle/core.asm), before anything can
;     save, restore or redraw the screen. A key that returns and stays on the screen (the
;     D-pad, the main menu's B, the list's SELECT outside TestBattle) is not a park: the
;     label on screen stays up through the caller's redraw, which touches neither these
;     cells nor a palette.
;
; v1.0 (2026-11-12): on the GBC the three letters are COLOURED, an ink per label.
; They are not the font's tiles there but copies of them in colour index 2
; (STATUS_TILE_x; constants/gfx_constants.asm), written straight into the tile map,
; on cells whose BG palettes (5 the enemy's, 6 the player's) take their slot 2 from
; the INK REGISTER (hStatusLetterInk, the id of the label a side's cells show); the
; palettes and the tiles are loaded in bank $2F (engine/gfx/bg_map_attributes.asm,
; which has the whole design). Rules of the GBC path:
;   - never a font letter in these cells, not even for one poll: the alternation
;     runs with the BG auto-transfer on, and a font letter would show black;
;   - the ink follows the LABEL, not the status bytes, and the register changes in
;     three places only: at the tail of a HUD draw (SyncStatusLetterInk, called by
;     DrawPlayerHUDAndHPBar and DrawEnemyHUDAndHPBar), at a flip of the alternation
;     and at a park (ShowHUDLabel). Each of them, when the id changes, writes the new
;     tiles with the BG transfer off, stores the id and has the palette written in
;     the V-blank that brings the tiles (WriteStatusLetterPaletteSynced, reached
;     through SetStatusLetterInk, this file's one farcall): tiles and ink change in
;     the same frame. When the id is the register's, the tiles alone are written.

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

; THE SELECTOR (v1.0, 2026-11-12): which persistent-status label a battler's status bytes ask for,
; as an ink id (STATUS_INK_*, constants/gfx_constants.asm). The bytes and the order of precedence
; are those of the party menu's printer: TOX (a PSN whose BattleStatus3 says BADLY_POISONED), then
; PrintStatusAilment's PSN, BRN, FRZ, PAR, SLP (a BRN whose fire is out answers BRN_OUT: v1.0,
; 2026-11-17; the same capitals in another ink, so the party menu's "BRN" stays). It answers for the first bit of the label list
; (STATUS_LABEL_HARD), and only BattlerStatusLabels and HUDLabelInkID call it, so the precedence
; lives here and in the list and nowhere else. (An id, not a set of tiles: two labels can share
; their letters and differ in ink.)
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
; v1.0 (2026-11-17): BRN while the fire burns, BRN_OUT once it is out: the same capitals, in its own ink on
; the GBC (on the DMG and the SGB the two look the same; the line "fire burned out!" tells them apart there).
; The bites are in the side's battle conditions byte (engine/battle/soft_status.asm, a near call: its
; section is pinned in this bank); the side is the one whose status byte de points at.
	push bc
	push hl
	ld c, 0
	ld a, e
	cp LOW(wBattleMonStatus)
	jr z, .gotSide
	inc c ; wEnemyMonStatus
.gotSide
	call BattlerBurnBitesLeft
	pop hl
	pop bc
	ld a, STATUS_INK_BRN ; (ld keeps the flags)
	ret nz
	ASSERT STATUS_INK_BRN_OUT == STATUS_INK_BRN + 1
	inc a ; STATUS_INK_BRN_OUT: the fire is out
	ret
.frz
	ld a, STATUS_INK_FRZ
	ret
.par
	ld a, STATUS_INK_PAR
	ret

	ASSERT LOW(wBattleMonStatus) != LOW(wEnemyMonStatus), "BattlerStatusInkID tells the sides apart by the low byte"
	ASSERT BANK(BattlerBurnBitesLeft) == BANK(BattlerStatusInkID), "BattlerStatusInkID calls soft_status.asm near"

; THE LABEL LIST (v1.0, 2026-11-17): which labels a battler has, a bit each (STATUS_LABEL_*,
; constants/gfx_constants.asm) in the order of precedence, the PRIMARY label first: the persistent
; status (the selector above), then CNF. BLD and SCR have their bits and are never set yet. The
; printer, SyncStatusLetterInk, the alternation and the parking all ask here. It never reads the
; clock: a HUD draw asks twice (its printer, then its tail) and must get the same answer.
; IN  a = BattleStatus1, bc = BattleStatus3 address, de = status byte (LoadBattlerStatusRegs's)
; OUT a = the list. bc, de and hl are kept.
BattlerStatusLabels:
	push hl
	ld l, a ; BattleStatus1
	call BattlerStatusInkID
	and a
	ASSERT STATUS_INK_NONE == 0
	jr z, .gotHard
	ld a, 1 << STATUS_LABEL_HARD
.gotHard
	bit CONFUSED, l
	jr z, .done
	or 1 << STATUS_LABEL_CNF
.done
	pop hl
	ret

; IN  c = side
; OUT a = the number of labels in the side's list. bc is kept; de and hl are not.
HUDLabelCount:
	push bc
	call LoadBattlerStatusRegs
	call BattlerStatusLabels
	ld b, 0
.count
	and a
	jr z, .done
	inc b
	ld c, a
	dec a
	and c ; the list without its first label
	jr .count
.done
	ld a, b
	pop bc
	ret

; The ink id of label number i of a side's list (v1.0, 2026-11-17). i = 0 is the PRIMARY label.
; IN  c = side, a = i
; OUT a = the ink id; STATUS_INK_NONE when the list has no label number i
;     hl = the side's three tiles. bc is kept; de is not.
HUDLabelInkID:
	push bc
	push af
	call LoadBattlerStatusRegs
	call BattlerStatusLabels ; a = the list
	pop de ; d = i
	inc d
.drop
	ld e, a
	dec a
	and e ; the list without its first label
	dec d
	jr nz, .drop
	xor e ; the label dropped last: label number i, alone (0 when the list is shorter)
	pop bc
	push bc
	push af
	call LoadBattlerStatusRegs ; for the selector, and hl
	pop af
	cp 1 << STATUS_LABEL_HARD
	jr nz, .notHard
	call BattlerStatusInkID
	jr .done
.notHard
	cp 1 << STATUS_LABEL_CNF
	ld a, STATUS_INK_CNF
	jr z, .done
; From here a holds STATUS_INK_CNF, not the label's bit, so a bit added later (BLD's, SCR's) cannot
; be tested here: its test goes right after .notHard, while a still holds the bit, and must leave a
; alone when it does not match (cp the bit / jr nz, .next / ld a, its id / jr .done / .next).
	xor a
	ASSERT STATUS_INK_NONE == 0
.done
	pop bc
	ret

; The three tiles of an ink id's label, on the machine the game runs on: the coloured ones on the
; GBC, the font's letters on the DMG and the SGB.
; IN  a = the ink id (not STATUS_INK_NONE), hl = the three tiles
; OUT NZ. a, de and hl are not kept; bc is.
PrintLabelTiles:
	ld e, a
	add a
	add e ; the id's row: (id - 1) * 3 bytes after the table
	ld e, a
	ld d, 0
	push hl
	ld hl, StatusLetterTileIDs - 3
	ldh a, [hGBC]
	and a
	jr nz, .gotTable
	ld hl, StatusLetterFontIDs - 3
.gotTable
	add hl, de
	ld d, h
	ld e, l
	pop hl
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
; (PrintLabelTiles). Every label has its row, also the ones nothing returns yet.
.psn:    db STATUS_TILE_P, STATUS_TILE_S, STATUS_TILE_N
.tox:    db STATUS_TILE_T, STATUS_TILE_O, STATUS_TILE_X
.brn:    db STATUS_TILE_B, STATUS_TILE_R, STATUS_TILE_N
.brnOut: db STATUS_TILE_B, STATUS_TILE_R, STATUS_TILE_N ; BRN's letters: the ink tells them apart
.par:    db STATUS_TILE_P, STATUS_TILE_A, STATUS_TILE_R
.slp:    db STATUS_TILE_S, STATUS_TILE_L, STATUS_TILE_P
.frz:    db STATUS_TILE_F, STATUS_TILE_R, STATUS_TILE_Z
.bleed:  db STATUS_TILE_B, STATUS_TILE_L, STATUS_TILE_D
.cnf:    db STATUS_TILE_C, STATUS_TILE_N, STATUS_TILE_F
.end:
	ASSERT StatusLetterTileIDs.psn    - StatusLetterTileIDs == (STATUS_INK_PSN     - 1) * 3
	ASSERT StatusLetterTileIDs.tox    - StatusLetterTileIDs == (STATUS_INK_TOX     - 1) * 3
	ASSERT StatusLetterTileIDs.brn    - StatusLetterTileIDs == (STATUS_INK_BRN     - 1) * 3
	ASSERT StatusLetterTileIDs.brnOut - StatusLetterTileIDs == (STATUS_INK_BRN_OUT - 1) * 3
	ASSERT StatusLetterTileIDs.par    - StatusLetterTileIDs == (STATUS_INK_PAR     - 1) * 3
	ASSERT StatusLetterTileIDs.slp    - StatusLetterTileIDs == (STATUS_INK_SLP     - 1) * 3
	ASSERT StatusLetterTileIDs.frz    - StatusLetterTileIDs == (STATUS_INK_FRZ     - 1) * 3
	ASSERT StatusLetterTileIDs.bleed  - StatusLetterTileIDs == (STATUS_INK_BLEED   - 1) * 3
	ASSERT StatusLetterTileIDs.cnf    - StatusLetterTileIDs == (STATUS_INK_CNF     - 1) * 3
	ASSERT StatusLetterTileIDs.end    - StatusLetterTileIDs == NUM_STATUS_INKS * 3

StatusLetterFontIDs:
; The same labels in the font's letters, for the DMG and the SGB (hGBC = 0), in the same order.
.psn:    db "PSN"
.tox:    db "TOX"
.brn:    db "BRN"
.brnOut: db "BRN" ; BRN's letters: without colour the two look the same
.par:    db "PAR"
.slp:    db "SLP"
.frz:    db "FRZ"
.bleed:  db "BLD"
.cnf:    db "CNF"
.end:
	ASSERT StatusLetterFontIDs.psn    - StatusLetterFontIDs == (STATUS_INK_PSN     - 1) * 3
	ASSERT StatusLetterFontIDs.tox    - StatusLetterFontIDs == (STATUS_INK_TOX     - 1) * 3
	ASSERT StatusLetterFontIDs.brn    - StatusLetterFontIDs == (STATUS_INK_BRN     - 1) * 3
	ASSERT StatusLetterFontIDs.brnOut - StatusLetterFontIDs == (STATUS_INK_BRN_OUT - 1) * 3
	ASSERT StatusLetterFontIDs.par    - StatusLetterFontIDs == (STATUS_INK_PAR     - 1) * 3
	ASSERT StatusLetterFontIDs.slp    - StatusLetterFontIDs == (STATUS_INK_SLP     - 1) * 3
	ASSERT StatusLetterFontIDs.frz    - StatusLetterFontIDs == (STATUS_INK_FRZ     - 1) * 3
	ASSERT StatusLetterFontIDs.bleed  - StatusLetterFontIDs == (STATUS_INK_BLEED   - 1) * 3
	ASSERT StatusLetterFontIDs.cnf    - StatusLetterFontIDs == (STATUS_INK_CNF     - 1) * 3
	ASSERT StatusLetterFontIDs.end    - StatusLetterFontIDs == NUM_STATUS_INKS * 3

; The HUD's three status tiles: the side's PRIMARY label (the persistent status, TOX
; included, else CNF when the battler is confused), else nothing.
; IN  c = side (see LoadBattlerStatusRegs)
; OUT NZ when something was written, Z and the tiles untouched when the list is empty.
;     The HUD no longer drops the level on it (the level has its own cells now);
;     emu_test_status_hud still asserts it.
; On the GBC this draws tiles only. The label's ink is SyncStatusLetterInk's, at the tail of the
; HUD draw this is called from.
PrintStatusOrConfusion::
	xor a ; label number 0: the primary
	call HUDLabelInkID
	and a
	ASSERT STATUS_INK_NONE == 0
	ret z
	jr PrintLabelTiles

; The ink of a HUD's label, at the tail of the HUD draw (v1.0, 2026-11-12; the design is in
; engine/gfx/bg_map_attributes.asm). Called by DrawPlayerHUDAndHPBar and DrawEnemyHUDAndHPBar
; (engine/battle/core.asm) right in front of the instruction that switches the BG transfer back on,
; with the new label in the tile map and the old one still on screen. The INK REGISTER
; (hStatusLetterInk) names the ink of the label a side's cells last got; when the label just drawn
; (the PRIMARY one: since 2026-11-17 also CNF on a side that is only confused) has another ink, the
; register takes it and the palette is written in the V-blank that copies the tiles
; (SetStatusLetterInk). Nearly every HUD draw ends at the compare: the label did not change.
; The id comes from the label list, on the bytes the printer read in this same HUD draw: nothing
; writes a status byte in between.
; IN  c = 0 the player's HUD, 1 the enemy's
; de is KEPT: e is the length of the HP bar just drawn, which GetBattleHealthBarColor reads right
; after both tails. On the DMG / SGB (hGBC = 0) this is a far call that returns.
SyncStatusLetterInk::
	ldh a, [hGBC]
	and a
	ret z
	push de
	xor a ; the primary label
	call HUDLabelInkID ; bc kept: c = the side
	and a
	ASSERT STATUS_INK_NONE == 0
	jr z, .done ; no label on this HUD: no cell shows the status slot
	ld hl, hStatusLetterInk
	ld b, 0
	add hl, bc
	cp [hl]
	call nz, SetStatusLetterInk
.done
	pop de
	ret

; THE ONE WAY TO THE SYNCED PALETTE WRITE (v1.0, 2026-11-17), for the three places that change a
; side's label: SyncStatusLetterInk (a HUD draw) and ShowHUDLabel (a flip, a park). The new label's
; tiles are in the tile map and the BG transfer is off.
; The register follows the label ALWAYS, whatever screen's palettes are loaded; the far routine
; writes the palette only on a battle screen, at the start of the next V-blank, and switches the
; transfer back on with the label's third forced. c, the side, survives rst _Bankswitch on the way in.
; IN  a = the ink id, c = the side
; OUT de and hl are what the far call returns; a, bc are not kept.
SetStatusLetterInk:
	ld hl, hStatusLetterInk
	ld b, 0
	add hl, bc
	ld [hl], a
	farcall WriteStatusLetterPaletteSynced
	ret

; Shows label number i of a side's list (v1.0, 2026-11-17): a flip of the alternation, or a park
; (i = 0). On the GBC, when the label's ink is not the register's, the label changes by the step a
; HUD draw takes: BG transfer off, the three tiles, the register, the synced palette write (which
; switches the transfer back on), so the new tiles and the new ink reach the screen in the same
; frame. Otherwise the three tiles alone are written, as on every poll since 2026-09-01. The
; synced write blocks until the next V-blank: when both sides change in one call, the second waits a
; frame more and the two HUDs change one frame apart. The clock and the audio run in the V-blank
; handler and lose nothing; the joypad is only SAMPLED there (hJoyInput), and a press is found by the
; poll (Joypad, against hJoyLast), so a V-blank whose sample no poll reads loses a press that lasted
; one frame: AlternateHUDStatus goes back to the poll whenever a key is newly down (see there).
; IN  c = side, a = i (less than the number of labels)
; OUT nothing; a, bc, de and hl are not kept.
ShowHUDLabel:
	call HUDLabelInkID ; a = the id, hl = the tiles, c kept
	ld e, a
	ldh a, [hGBC]
	and a
	ld a, e
	jp z, PrintLabelTiles ; the DMG / SGB: the font's letters, and no palette
	push hl
	ld hl, hStatusLetterInk
	ld b, 0
	add hl, bc
	cp [hl]
	pop hl
	jp z, PrintLabelTiles ; the label's ink is already the register's: the tiles alone
	ld b, a
	xor a
	ldh [hAutoBGTransferEnabled], a
	ld a, b
	push bc
	call PrintLabelTiles ; bc kept
	pop bc
	ld a, b
	call SetStatusLetterInk
; and on whatever the synced write did (it returns at once under another screen's palette command)
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ret

; Which label of a list of n the alternation shows now (v1.0, 2026-11-17):
;     i = ((wPlayTimeSeconds >> 1) + 1 + (n == 4 ? 2 * (wPlayTimeMinutes & 1) : 0)) mod n
; Two seconds per label. TrackPlayTime advances the seconds (binary, 0-59) once a second in
; V-blank, so this does not depend on how often the poll loop lands here. A minute has 30
; two-second phases: for n = 2 and 3 the order runs on across the minute; for n = 4 the minute's
; parity adds 2, so it runs on there too (and across the hour: 60 minutes are even). A play clock
; frozen at its 255:59 cap pins the seconds and the minutes at 59: (29 + 1 + 2) mod 4 = 30 mod 3 =
; 30 mod 2 = 0, the PRIMARY label (the honest, always-true one) for every n, never a soft label
; stuck on screen for the rest of a maxed save. For n = 2 this is today's phase: bit 1 of the
; seconds set shows the persistent status, clear shows CNF.
; The caller reads the clock (AlternateHUDStatus reads it once for both sides, as a pair that does
; not straddle a minute) and hands it over.
; IN  a = n (2-4), d = wPlayTimeSeconds, e = wPlayTimeMinutes
; OUT a = i. c and hl are kept; b, d and e are not.
HUDLabelIndex:
	ld b, a
	ld a, d
	srl a
	inc a
	ld d, a
	ld a, b
	cp 4
	jr nz, .mod
	ld a, e
	and 1
	add a
	add d
	ld d, a
.mod
	ld a, d
.sub
	sub b
	jr nc, .sub
	add b
	ret

; Alternates the HUD's three status tiles between a side's labels, about every
; two seconds, for a side with two labels or more (today: a persistent status and CNF).
;
; Called once per POLL of HandleMenuInput_'s inner loop (home/window.asm,
; farcall) -- ~50-100 times a frame, NOT once a frame; that loop has no frame
; wait, which is why the phase reads the wall clock (HUDLabelIndex). Every menu in the game
; shares the loop -- hence two gates, and both are load-bearing:
;   hHUDStatusFlip           0 unless the battle menu deliberately set it
;                            (BattleMenuInput, core.asm: the battle's main menu
;                            and the FIGHT move list); HandleMenuInput
;                            clears it for everyone else.
;   wPartyMenuAnimMonEnabled the party menu is the ONE caller that enters at
;                            HandleMenuInput_ and so never clears the byte
;                            above. Without this check, switching #MON mid
;                            battle would stamp CNF into the party list.
;
; v1.0 (2026-11-17): a flip that changes the ink waits for a V-blank (ShowHUDLabel), so two rules:
;   - ONE reading of the clock for both sides (d and e, kept on the stack across the first side):
;     a second that ticks in the first side's wait does not put the other side a phase behind, and
;     the two HUDs change one frame apart (unless a key comes in that wait: next rule). v1.0
;     (2026-11-17): the reading runs with interrupts on, so it reads the minutes, the seconds and
;     the minutes again, and starts over when the minutes changed: a V-blank between the loads at a
;     minute boundary would otherwise pair second 59 with the next minute (for n = 4 a wrong label
;     for one call: a blink and two needless waits);
;   - before each side, back to the poll at once when the pad's sample (hJoyInput, written by the
;     V-blank handler) has a key down that hJoyLast does not hold: a wait whose V-blank
;     brought a new press is never followed by a second wait before a poll has read it, so a press
;     of one frame is not lost. v1.0 (2026-11-17): a key newly DOWN only, not any change: putting
;     the other side off for a release left the two HUDs 4-9 frames apart after a one-frame tap.
;     v1.0 (2026-11-17): and before that test a release in the sample is recorded as read, as
;     Joypad would record it: hJoyLast keeps only the keys the sample still shows down (hJoyLast &
;     hJoyInput; a key newly down is not in hJoyLast, so the poll still finds it). Without that, a
;     key held and read, up for the one sample of the first side's wait and down again in the
;     second's, was never a press (the poll found hJoyInput = hJoyLast). Now it is, as any key
;     pressed again is. hJoyReleased misses that release: nothing in the game reads hJoyReleased
;     (it is only written). A key held across the flip stays in hJoyLast. With no wait (the DMG /
;     SGB, a flip with the ink already right) the next poll reads the sample the rule read, unless
;     a V-blank comes between them, and finds the same presses: hJoyLast only lost keys that were
;     up. When the rule sends a side back, the other side flips at the next poll, or, when the poll finds a key, at
;     the menu's return (HUDStatusAfterMenu: parked with the first side on a key that leaves, or flipped
;     after it on a key that returns and stays: the main menu's left, right and B, the move list's up,
;     down and SELECT, the last outside the debug build's TestBattle). The main
;     menu's up and down are handled inside HandleMenuInput_ and do not return: there the other side
;     follows after that menu's cursor redraw and Delay3, a few frames later. Left: a V-blank that
;     lands between the pad's test and the synced write's di, with a press that lasts that one frame.
AlternateHUDStatus::
	ldh a, [hHUDStatusFlip]
	and a
	ret z
	ld a, [wPartyMenuAnimMonEnabled]
	and a
	ret nz
.readClock
	ld a, [wPlayTimeMinutes]
	ld e, a
	ld a, [wPlayTimeSeconds]
	ld d, a
	ld a, [wPlayTimeMinutes]
	cp e
	jr nz, .readClock ; the minute ticked between the loads: read the pair again
	ld c, 0
	call .side
	ld c, 1
	; falls through, and the ret at the end of .side is this routine's own
.side
	ldh a, [hJoyInput]
	ld b, a
	ldh a, [hJoyLast]
	and b
	ldh [hJoyLast], a ; the keys this sample shows up leave hJoyLast: their release is read
	xor b
	ret nz ; a key is down that the poll has not read: the poll reads it first
	push de
	call HUDLabelCount ; bc kept
	pop de
	cp 2
	ret c ; one label or none: the HUD already shows it
	push de
	call HUDLabelIndex ; c kept
	call ShowHUDLabel
	pop de
	ret

; What BattleMenuInput (engine/battle/core.asm) does with the HUD when the menu returns (v1.0,
; 2026-11-17). IN  Z: the menu returned with a key that stays on its screen (the D-pad, the main
; menu's B, the list's SELECT outside the debug build's TestBattle; it goes on): one more step of
; the alternation, so a side put off by AlternateHUDStatus's pad rule does not wait out the
; caller's redraw of the cursor or the list.
; NZ: a key that leaves the menu's screen (the keys BattleMenuInput's caller names in b): the parking,
; below. The flags are the only input (they survive rst _Bankswitch).
HUDStatusAfterMenu::
	jr z, AlternateHUDStatus
	; falls through

; THE PARKING (v1.0, 2026-11-17): both sides back on their PRIMARY label, by the step of a flip.
; Reached from BattleMenuInput (through HUDStatusAfterMenu) when the menu returns with a key that leaves
; its screen (the main menu's A; the FIGHT list's A, B and START, and its SELECT in the debug build's
; TestBattle), before its caller can save, restore or redraw the screen: outside a menu's wait the
; cells show the primary label and the register names its ink, as a HUD draw leaves them. The keys
; that return and stay (the D-pad, the main menu's B, the list's SELECT outside TestBattle) are not
; parked: their redraws touch neither the cells nor a palette, and the next key that leaves parks.
; A side with fewer than two labels never alternated: it is left alone.
ParkHUDStatus::
	ld c, 0
	call .side
	ld c, 1
	; falls through, and the ret at the end of .side is this routine's own
.side
	call HUDLabelCount
	cp 2
	ret c
	xor a ; label number 0: the primary
	jp ShowHUDLabel
