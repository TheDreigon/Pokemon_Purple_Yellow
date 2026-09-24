; v1.0 (T23, 2026-09-24): indexes into MissableObjects2 (data/maps/hide_show_data_2.asm)
; and bits of wMissableObjectFlags2. Same positional contract as HS_*: row i
; of the table <-> constant i; hs_align_audit.py checks both tables.
; KEEP THIS IN ITS OWN FILE: hs_align_audit.hs_constants() and
; emu_test_callbacks.const_index() restart their count at every const_def, so
; a second list inside hide_show_constants.asm would corrupt the table-1 check.
; Script idiom: `ld a, HS2_X / ld [wMissableObjectIndex], a / farcall HideObject_HS2`
; (or ShowObject_HS2); a, b, c and hl come back clobbered, as after a predef.
DEF HS2_CAPACITY EQU 128 ; bits in wMissableObjectFlags2 (16 bytes of saved WRAM)

	const_def
	const HS2_MR_FUJIS_HOUSE_CUBONE ; 00  (seed: moved from HS_ index 255 on the day T23 landed)
DEF NUM_HS2_OBJECTS EQU const_value
ASSERT NUM_HS2_OBJECTS <= HS2_CAPACITY, "MissableObjects2 has more rows than wMissableObjectFlags2 has bits"
