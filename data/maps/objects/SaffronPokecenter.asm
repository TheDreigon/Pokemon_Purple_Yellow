	object_const_def
	const_export SAFFRONPOKECENTER_NURSE
	const_export SAFFRONPOKECENTER_BEAUTY
	const_export SAFFRONPOKECENTER_GENTLEMAN
	const_export SAFFRONPOKECENTER_CHANSEY
	const_export SAFFRONPOKECENTER_AIDE1
	const_export SAFFRONPOKECENTER_AIDE2

SaffronPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 7
	warp_event  4,  7, LAST_MAP, 7

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, TEXT_SAFFRONPOKECENTER_NURSE
	object_event  7,  1, SPRITE_BEAUTY, STAY, NONE, TEXT_SAFFRONPOKECENTER_BEAUTY
	object_event  8,  5, SPRITE_GENTLEMAN, WALK, LEFT_RIGHT, TEXT_SAFFRONPOKECENTER_GENTLEMAN
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, TEXT_SAFFRONPOKECENTER_CHANSEY
; v0.7 (2026-08-30, Forte's design, v2): Oak's two aides stand side by
; side beside the nurse - an adjacent duo, so the second voice in the
; delivery comes from right next to the first. The script ambushes the
; player on the counter strip (rows 3-4), once per map entry until both
; parcels land.
	object_event  4,  3, SPRITE_SCIENTIST, STAY, DOWN, TEXT_SAFFRONPOKECENTER_AIDE1
	object_event  5,  3, SPRITE_SCIENTIST, STAY, DOWN, TEXT_SAFFRONPOKECENTER_AIDE2

	def_warps_to SAFFRON_POKECENTER
