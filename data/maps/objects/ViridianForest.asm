	object_const_def
	const_export VIRIDIANFOREST_YOUNGSTER1
	const_export VIRIDIANFOREST_YOUNGSTER2
	const_export VIRIDIANFOREST_YOUNGSTER3
	const_export VIRIDIANFOREST_YOUNGSTER4
	const_export VIRIDIANFOREST_COOLTRAINER_F
	const_export VIRIDIANFOREST_YOUNGSTER5
	const_export VIRIDIANFOREST_COOLTRAINER_M
	const_export VIRIDIANFOREST_POTION1
	const_export VIRIDIANFOREST_ANTIDOTE
	const_export VIRIDIANFOREST_POKE_BALL
	const_export VIRIDIANFOREST_YOUNGSTER6

ViridianForest_Object:
	db $3 ; border block

	def_warp_events
	warp_event  1,  0, VIRIDIAN_FOREST_NORTH_GATE, 3
	warp_event  2,  0, VIRIDIAN_FOREST_NORTH_GATE, 3
	warp_event 15, 47, VIRIDIAN_FOREST_SOUTH_GATE, 2
	warp_event 16, 47, VIRIDIAN_FOREST_SOUTH_GATE, 2
	warp_event 17, 47, VIRIDIAN_FOREST_SOUTH_GATE, 2
	warp_event 18, 47, VIRIDIAN_FOREST_SOUTH_GATE, 2

	def_bg_events
	bg_event 26, 17, TEXT_VIRIDIANFOREST_TRAINER_TIPS1
	bg_event 16, 40, TEXT_VIRIDIANFOREST_USE_ANTIDOTE_SIGN
	bg_event 14, 16, TEXT_VIRIDIANFOREST_TRAINER_TIPS2
	bg_event  8,  9, TEXT_VIRIDIANFOREST_TRAINER_TIPS3
	bg_event  4, 22, TEXT_VIRIDIANFOREST_TRAINER_TIPS4

	def_object_events
	object_event 16, 43, SPRITE_YOUNGSTER, STAY, NONE, TEXT_VIRIDIANFOREST_YOUNGSTER1
	object_event 30, 33, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_VIRIDIANFOREST_YOUNGSTER2, OPP_BUG_CATCHER, 1, 4
	object_event 30, 19, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_VIRIDIANFOREST_YOUNGSTER3, OPP_BUG_CATCHER, 2, 4
	object_event 19, 19, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_VIRIDIANFOREST_YOUNGSTER4, OPP_BUG_CATCHER, 3, 1
	object_event  4, 40, SPRITE_COOLTRAINER_F, STAY, NONE, TEXT_VIRIDIANFOREST_COOLTRAINER_F, OPP_LASS, 19, 0
	object_event 10,  7, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_VIRIDIANFOREST_YOUNGSTER5, OPP_BUG_CATCHER, 15, 4
; v0.7 (2026-08-30, Forte): the toll gate on the way to PEWTER - he cleared
; (2,18) himself by moving the bug catcher to (19,19). SCYTHER+PINSIR L10,
; sight 2 down the western corridor.
; 🔴 This object MUST be number 7: trainer-header byte +0 is BOTH the event
; bit AND the object_event index (CheckForEngagingTrainers writes it into
; wSpriteIndex), so the map's headered trainers have to occupy exactly the
; object slots def_trainers starts at. Appended at slot 11 it never
; sight-engaged and the sight scan ran against the POTION ball instead
; (glitch-encounter hazard). trainer_pairing_audit.py now guards this.
	object_event  2, 18, SPRITE_COOLTRAINER_M, STAY, LEFT, TEXT_VIRIDIANFOREST_COOLTRAINER_M, OPP_COOLTRAINER_M, 11, 2
	object_event  8,  3, SPRITE_POKE_BALL, STAY, NONE, TEXT_VIRIDIANFOREST_POTION1, POTION
	object_event 32, 43, SPRITE_POKE_BALL, STAY, NONE, TEXT_VIRIDIANFOREST_ANTIDOTE, ANTIDOTE
	object_event  1, 30, SPRITE_POKE_BALL, STAY, NONE, TEXT_VIRIDIANFOREST_POKE_BALL, POKE_BALL
	object_event 24,  9, SPRITE_YOUNGSTER, STAY, NONE, TEXT_VIRIDIANFOREST_YOUNGSTER6

	def_warps_to VIRIDIAN_FOREST
