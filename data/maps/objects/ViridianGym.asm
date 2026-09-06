	object_const_def
	const_export VIRIDIANGYM_GIOVANNI
	const_export VIRIDIANGYM_COOLTRAINER_M1
	const_export VIRIDIANGYM_HIKER1
	const_export VIRIDIANGYM_ROCKER1
	const_export VIRIDIANGYM_HIKER2
	const_export VIRIDIANGYM_COOLTRAINER_M2
	const_export VIRIDIANGYM_JESSIE ; the Boss's bodyguards (2026-09-06): took the KARATE KING blackbelt's slot
	const_export VIRIDIANGYM_ROCKER2
	const_export VIRIDIANGYM_COOLTRAINER_M3
	const_export VIRIDIANGYM_GYM_GUIDE
	const_export VIRIDIANGYM_MAX_REVIVE
	const_export VIRIDIANGYM_KIYO
	const_export VIRIDIANGYM_JAMES

ViridianGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event 16, 17, LAST_MAP, 5
	warp_event 17, 17, LAST_MAP, 5

	def_bg_events

	def_object_events
; The seven regulars fight twice (the gym rework, 9/9, 2026-09-06): as the Boss's muscle with
; the party ids below and, once KIYO holds the gym, as his disciples - ViridianGymPostLeagueState
; (scripts) swaps the ids in WRAM every tick: objects 2-6, 8, 9 -> 12, 14, 7, 15, 13, 8, 14.
	object_event  2,  1, SPRITE_GIOVANNI, STAY, DOWN, TEXT_VIRIDIANGYM_GIOVANNI, OPP_GIOVANNI, 3
	object_event 12,  7, SPRITE_COOLTRAINER_M, STAY, DOWN, TEXT_VIRIDIANGYM_COOLTRAINER_M1, OPP_COOLTRAINER_M, 9, 4
	object_event 11, 11, SPRITE_HIKER, STAY, UP, TEXT_VIRIDIANGYM_HIKER1, OPP_BLACKBELT, 6, 4
	object_event 10,  7, SPRITE_ROCKER, STAY, DOWN, TEXT_VIRIDIANGYM_ROCKER1, OPP_TAMER, 3, 4
	object_event  3,  7, SPRITE_HIKER, STAY, LEFT, TEXT_VIRIDIANGYM_HIKER2, OPP_BLACKBELT, 7, 2
	object_event 13,  5, SPRITE_COOLTRAINER_M, STAY, RIGHT, TEXT_VIRIDIANGYM_COOLTRAINER_M2, OPP_COOLTRAINER_M, 10, 3
; v1.0 (2026-09-06, Forte): JESSIE & JAMES guard the door of Giovanni's room -
; the fifth and last fight of the duo, the last fight before the Boss. JESSIE
; carries the trainer header (class JESSIE_AND_JAMES, party 5); she faces the
; room's only entry tile (4,4) at range 1, so nobody reaches Giovanni without
; getting past them. JAMES stands beside her (a plain object, last in the list).
; They stay after the fight: hide_show has no spare row, and beaten bodyguards
; at their post are the joke.
	object_event  4,  3, SPRITE_JESSIE, STAY, DOWN, TEXT_VIRIDIANGYM_JESSIE, OPP_JESSIE_AND_JAMES, 5, 1
	object_event  2, 16, SPRITE_ROCKER, STAY, RIGHT, TEXT_VIRIDIANGYM_ROCKER2, OPP_TAMER, 4, 3
	object_event  6,  5, SPRITE_COOLTRAINER_M, STAY, DOWN, TEXT_VIRIDIANGYM_COOLTRAINER_M3, OPP_COOLTRAINER_M, 1, 4
	object_event 19, 15, SPRITE_GYM_GUIDE, STAY, DOWN, TEXT_VIRIDIANGYM_GYM_GUIDE
	object_event 16,  9, SPRITE_POKE_BALL, STAY, NONE, TEXT_VIRIDIANGYM_MAX_REVIVE, MAX_REVIVE
; KIYO stands where Giovanni stood. Hidden by default (hide_show_data row);
; ViridianGymPostLeagueState swaps the two once wGameStage is set.
	object_event  2,  1, SPRITE_HIKER, STAY, DOWN, TEXT_VIRIDIANGYM_KIYO, OPP_KIYO, 2
	object_event  3,  3, SPRITE_JAMES, STAY, DOWN, TEXT_VIRIDIANGYM_JAMES ; JESSIE's partner, no header: her fight is theirs

	def_warps_to VIRIDIAN_GYM
