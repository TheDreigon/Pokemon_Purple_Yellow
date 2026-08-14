; Value macros

DEF percent EQUS "* $ff / 100"

MACRO bcd2
	dn ((\1) / 1000) % 10, ((\1) / 100) % 10
	dn ((\1) / 10) % 10, (\1) % 10
ENDM

MACRO bcd3
	dn ((\1) / 100000) % 10, ((\1) / 10000) % 10
	dn ((\1) / 1000) % 10, ((\1) / 100) % 10
	dn ((\1) / 10) % 10, (\1) % 10
ENDM

; used in data/pokemon/base_stats/*.asm
; PURPLE YELLOW v0.5: lets us write stat rows in the display order used by the
; status screen (hp/atk/def/SPECIAL/SPEED) while still emitting the bytes in the
; engine's struct order (hp/atk/def/SPEED/SPECIAL). Swap-on-emit keeps the
; battle engine untouched.
; Usage:  base_stat_row HP, ATK, DEF, SPC, SPD
MACRO base_stat_row
; v0.7: the POKeDEX DATA screen prints the sum of these five in a THREE digit
; field, so a species whose total reached 1000 would print garbage with a green
; build and no other warning. The highest today is MEWTWO at 600. This is the
; cheapest possible place to keep that true, because every species passes
; through here.
	ASSERT (\1) + (\2) + (\3) + (\4) + (\5) < 1000, \
	    "base stat total must stay under 1000: the POKeDEX prints it in 3 digits"
	db \1, \2, \3, \5, \4
ENDM

; used in data/pokemon/base_stats/*.asm
MACRO tmhm
; initialize bytes to 0
	FOR n, (NUM_TM_HM + 7) / 8
		DEF _tm{d:n} = 0
	ENDR
	; set bits of bytes
	REPT _NARG
		IF DEF(\1_TMNUM)
			DEF n = (\1_TMNUM - 1) / 8
			DEF i = (\1_TMNUM - 1) % 8
			DEF _tm{d:n} |= 1 << i
		ELSE
			FAIL "\1 is not a TM or HM move"
		ENDC
		SHIFT
	ENDR
	; output bytes
	FOR n, (NUM_TM_HM + 7) / 8
		db _tm{d:n}
	ENDR
ENDM


; Constant data (db, dw, dl) macros

MACRO dbw
	db \1
	dw \2
ENDM

MACRO dwb
	dw \1
	db \2
ENDM

MACRO dn ; nybbles
	REPT _NARG / 2
		db ((\1) << 4) | (\2)
		SHIFT 2
	ENDR
ENDM

MACRO dc ; "crumbs"
	REPT _NARG / 4
		db ((\1) << 6) | ((\2) << 4) | ((\3) << 2) | (\4)
		SHIFT 4
	ENDR
ENDM

MACRO bigdw ; big-endian word
	db HIGH(\1), LOW(\1)
ENDM

MACRO dba ; dbw bank, address
	REPT _NARG
		dbw BANK(\1), \1
		SHIFT
	ENDR
ENDM

MACRO dab ; dwb address, bank
	REPT _NARG
		dwb \1, BANK(\1)
		SHIFT
	ENDR
ENDM

MACRO sine_table
; \1 samples of sin(x) from x=0 to x<0.5 turns (pi radians)
	for x, \1
		dw sin(x * 0.5 / (\1))
	endr
ENDM
