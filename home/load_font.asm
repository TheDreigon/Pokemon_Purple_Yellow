LoadFontTilePatterns::
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	jr nz, .on
.off
	ld hl, FontGraphics
	ld de, vFont
	ld bc, FontGraphicsEnd - FontGraphics
	ld a, BANK(FontGraphics)
	jp FarCopyDataDouble ; if LCD is off, transfer all at once
.on
	ld de, FontGraphics
	ld hl, vFont
	lb bc, BANK(FontGraphics), (FontGraphicsEnd - FontGraphics) / $8
	jp CopyVideoDataDouble ; if LCD is on, transfer during V-blank

LoadTextBoxTilePatterns::
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	jr nz, .on
.off
	ld hl, TextBoxGraphics
	ld de, vChars2 tile $60
	ld bc, TextBoxGraphicsEnd - TextBoxGraphics
	ld a, BANK(TextBoxGraphics)
	jp FarCopyData ; if LCD is off, transfer all at once
.on
	ld de, TextBoxGraphics
	ld hl, vChars2 tile $60
	lb bc, BANK(TextBoxGraphics), (TextBoxGraphicsEnd - TextBoxGraphics) / $10
	jp CopyVideoData ; if LCD is on, transfer during V-blank

LoadHpBarAndStatusTilePatterns::
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	jr nz, .on
.off
	ld hl, HpBarAndStatusGraphics
	ld de, vChars2 tile $62
	ld bc, HpBarAndStatusGraphicsEnd - HpBarAndStatusGraphics
	ld a, BANK(HpBarAndStatusGraphics)
	call FarCopyData ; if LCD is off, transfer all at once
	ld hl, EXPBarGraphics
	ld de, vChars1 tile $40
	ld bc, EXPBarGraphicsEnd - EXPBarGraphics
	ld a, BANK(EXPBarGraphics)
	jp FarCopyData ; if LCD is off, transfer all at once
.on
	ld de, HpBarAndStatusGraphics
	ld hl, vChars2 tile $62
	lb bc, BANK(HpBarAndStatusGraphics), (HpBarAndStatusGraphicsEnd - HpBarAndStatusGraphics) / $10
	call CopyVideoData ; if LCD is on, transfer during V-blank
; v0.7: source and destination, the right way round.
;
; The two copiers take their operands in OPPOSITE orders - FarCopyData copies
; from hl to de (home/copy.asm:1-2), CopyVideoData copies from de to hl
; (home/copy2.asm:41-44) - and this block was written with FarCopyData's order
; while calling CopyVideoData. The block for the HP bar four lines up has it
; right, which is what makes the two readable side by side and still wrong.
;
; What it did: copied 144 bytes OUT of VRAM at $8c00 and INTO $4c00, where
; EXPBarGraphics happens to live. ROM cannot be written, so on this cartridge -
; MBC5, from the -m 0x1b in the Makefile - $4000-$5fff is the SRAM BANK NUMBER
; register, and this performed 144 consecutive writes to it, leaving it holding
; a byte of font graphics. Nothing has been corrupted by that, because every
; SRAM user re-selects its bank before touching it and RAM enable is never on
; here, but the EXP bar tiles were simply never loaded on this path and two
; frames were spent not loading them.
;
; The bar itself has always been fine in battle: _InitBattleCommon goes through
; SlidePlayerAndEnemySilhouettesOnScreen, which calls DisableLCD first and so
; takes the .off branch above, where the same block IS correct.
;
; Inherited, and worth saying where from: pokeyellow has no EXP bar at all, and
; Pokemon_Yellow_Legacy's copy of this file is byte-identical to ours, reversed
; arguments included. kep-hack carries it too.
	ld de, EXPBarGraphics
	ld hl, vChars1 tile $40
	lb bc, BANK(EXPBarGraphics), (EXPBarGraphicsEnd - EXPBarGraphics) / $10
	jp CopyVideoData ; if LCD is on, transfer during V-blank
