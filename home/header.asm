; rst vectors (rst0 = _Bankswitch trampoline used by farcall/callfar; rst8-rst38 unused)

SECTION "rst0", ROM0[$0000]
_Bankswitch::
    jp Bankswitch

	ds $08 - @, 0 ; unused

SECTION "rst8", ROM0[$0008]
	rst $38

	ds $10 - @, 0 ; unused

SECTION "rst10", ROM0[$0010]
	rst $38

	ds $18 - @, 0 ; unused

SECTION "rst18", ROM0[$0018]
	rst $38

	ds $20 - @, 0 ; unused

SECTION "rst20", ROM0[$0020]
	rst $38

	ds $28 - @, 0 ; unused

SECTION "rst28", ROM0[$0028]
	rst $38

	ds $30 - @, 0 ; unused

SECTION "rst30", ROM0[$0030]
	rst $38

	ds $38 - @, 0 ; unused

SECTION "rst38", ROM0[$0038]
	rst $38

	ds $40 - @, 0 ; unused


; Game Boy hardware interrupts

SECTION "vblank", ROM0[$0040]
	jp VBlank

	ds $48 - @, 0 ; unused

SECTION "lcd", ROM0[$0048]
	jp LCDC

	ds $50 - @, 0 ; unused

SECTION "timer", ROM0[$0050]
	jp Timer

	ds $58 - @, 0 ; unused

SECTION "serial", ROM0[$0058]
; v0.7: the link cable is gone. v1.0 (R12, 2026-10-02): nothing starts a
; transfer (rSC is written once, 0, in home/init.asm), so no serial interrupt
; is requested. rIE's SERIAL bit is off except while PlayIntroScene and
; SurfingPikachuMinigame run: both set rIE to $0F (VBLANK, LCD_STAT, TIMER,
; SERIAL) and restore it on exit. The vector still has to be safe if one ever
; arrives.
	reti

	ds $60 - @, 0 ; unused

SECTION "joypad", ROM0[$0060]
	reti


SECTION "Header", ROM0[$0100]

Start::
; Nintendo requires all Game Boy ROMs to begin with a nop ($00) and a jp ($C3)
; to the starting address.
	nop
	jp _Start

; The Game Boy cartridge header data is patched over by rgbfix.
; This makes sure it doesn't get used for anything else.

	ds $0150 - @
