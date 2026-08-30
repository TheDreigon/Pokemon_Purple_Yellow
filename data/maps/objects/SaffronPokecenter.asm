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
	object_event  9,  5, SPRITE_GENTLEMAN, WALK, LEFT_RIGHT, TEXT_SAFFRONPOKECENTER_GENTLEMAN
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, TEXT_SAFFRONPOKECENTER_CHANSEY
; v0.7 (2026-08-30, Forte's design, v3): Oak's two aides wait beside the
; counter. On every entry while a parcel is owed, the scene script walks
; each of them three steps down - to (2,6) and (4,6), the two diagonals
; of the door spawn tile (3,7) - for the delivery, then walks them back.
; Once both parcels are delivered AND TEAM ROCKET leaves SAFFRON, the
; on-entry script hides them for good (they went home to the lab).
	object_event  2,  3, SPRITE_SCIENTIST, STAY, DOWN, TEXT_SAFFRONPOKECENTER_AIDE1
	object_event  4,  3, SPRITE_SCIENTIST, STAY, DOWN, TEXT_SAFFRONPOKECENTER_AIDE2

	def_warps_to SAFFRON_POKECENTER
