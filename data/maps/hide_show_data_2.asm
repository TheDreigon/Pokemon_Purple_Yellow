; v1.0 (T23, 2026-09-24): the second hide/show table. Same three bytes per row as
; MissableObjects (map id, object id, HIDE/SHOW) but NO MapHSPointers:
; LoadMissableObjects2 scans the whole table for the current map on every map
; load, so rows need not be grouped by map and are simply appended. Index =
; position = HS2_* constant (constants/hide_show_constants_2.asm). An object
; lives in exactly ONE of the two tables (hs_align_audit / mapdata_audit).
MissableObjects2:
	table_width 3, MissableObjects2
	db MR_FUJIS_HOUSE, MRFUJISHOUSE_CUBONE, SHOW ; HS2_MR_FUJIS_HOUSE_CUBONE
	db $FF, $01, SHOW ; end
	assert_table_length NUM_HS2_OBJECTS + 1
