	object_const_def
	const_export CERULEANCAVEB1F_MEWTWO
	const_export CERULEANCAVEB1F_ESCAPE_ROPE ; name kept when ULTRA_BALL1 was converted to hidden (FUCHSIAGYM_JANINE convention); the ball now holds ESCAPE_ROPE
	const_export CERULEANCAVEB1F_MAX_REVIVE
	const_export CERULEANCAVEB1F_MAX_ELIXIR
	const_export CERULEANCAVEB1F_FORTE

CeruleanCaveB1F_Object:
	db $7d ; border block

	def_warp_events
	warp_event  3,  6, CERULEAN_CAVE_1F, 9

	def_bg_events

	def_object_events
	object_event 27, 13, SPRITE_MEWTWO, STAY, DOWN, TEXT_CERULEANCAVEB1F_MEWTWO, MEWTWO, 70
	; v0.7 ground-item redesign: the ULTRA_BALL at (26,1) became a HIDDEN item
	; at the same coords — its freed missable slot pays for Seafoam 1F's new
	; visible ESCAPE_ROPE.
	object_event  2, 13, SPRITE_POKE_BALL, STAY, NONE, TEXT_CERULEANCAVEB1F_ESCAPE_ROPE, ESCAPE_ROPE
	object_event  3, 13, SPRITE_POKE_BALL, STAY, NONE, TEXT_CERULEANCAVEB1F_MAX_REVIVE, MAX_REVIVE
	object_event 15,  3, SPRITE_POKE_BALL, STAY, NONE, TEXT_CERULEANCAVEB1F_MAX_ELIXIR, MAX_ELIXIR
	object_event 27, 13, SPRITE_RED, STAY, DOWN, TEXT_CERULEANCAVEB1F_FORTE, OPP_FORTE, 1 ; Forte/DREIGON superboss on MEWTWO's exact tile (27,13); missable HIDE, shown by script post-MEWTWO + post-League; repeatable talk-battle

	def_warps_to CERULEAN_CAVE_B1F
