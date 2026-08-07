	object_const_def
	const_export DAYCARE2F_NURSE
	const_export DAYCARE2F_CHANSEY
	const_export DAYCARE2F_MR_MIME
	const_export DAYCARE2F_NIDORAN_F
	const_export DAYCARE2F_CUBONE

Daycare2F_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  1, DAYCARE, 3

	def_bg_events

	def_object_events
; The gentleman's daughter and her own two POKeMON (CHANSEY and MR.MIME);
; the other two up here are boarders. Five sprite images incl. hers -- an
; indoor map loads its own list, nine walking slots, no sprite-set limits.
	object_event  2,  3, SPRITE_NURSE, STAY, NONE, TEXT_DAYCARE2F_NURSE
	object_event  5,  4, SPRITE_CHANSEY, WALK, ANY_DIR, TEXT_DAYCARE2F_CHANSEY
	object_event  2,  6, SPRITE_MRMIME, WALK, ANY_DIR, TEXT_DAYCARE2F_MR_MIME
	object_event  6,  6, SPRITE_NIDORANF, WALK, ANY_DIR, TEXT_DAYCARE2F_NIDORAN_F
	object_event  1,  4, SPRITE_CUBONE, WALK, ANY_DIR, TEXT_DAYCARE2F_CUBONE

	def_warps_to DAYCARE_2F
