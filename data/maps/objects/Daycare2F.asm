	object_const_def
	const_export DAYCARE2F_NURSE
	const_export DAYCARE2F_CHANSEY
	const_export DAYCARE2F_MR_MIME
	const_export DAYCARE2F_NIDORAN_F
	const_export DAYCARE2F_CUBONE
	const_export DAYCARE2F_SEEL
	const_export DAYCARE2F_CLEFAIRY

Daycare2F_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  1, DAYCARE, 3

	def_bg_events

	def_object_events
; The gentleman's daughter and her own two POKeMON (CHANSEY and MR.MIME);
; the other two up here are boarders. Only NIDORAN F has walk frames in its
; sheet; the stills must STAY or they animate with the next sprite in the
; ROM (the flicker Forte saw). STAY sprites still turn when spoken to.
	object_event  2,  2, SPRITE_NURSE, STAY, NONE, TEXT_DAYCARE2F_NURSE
	object_event  3,  2, SPRITE_CHANSEY, STAY, NONE, TEXT_DAYCARE2F_CHANSEY
	object_event  1,  2, SPRITE_MRMIME, STAY, NONE, TEXT_DAYCARE2F_MR_MIME
	object_event  5,  5, SPRITE_NIDORANF, WALK, ANY_DIR, TEXT_DAYCARE2F_NIDORAN_F
	object_event  3,  5, SPRITE_CUBONE, STAY, NONE, TEXT_DAYCARE2F_CUBONE
	object_event  6,  3, SPRITE_SEEL, WALK, ANY_DIR, TEXT_DAYCARE2F_SEEL
	object_event  5,  2, SPRITE_CLEFAIRY, STAY, NONE, TEXT_DAYCARE2F_CLEFAIRY

	def_warps_to DAYCARE_2F
