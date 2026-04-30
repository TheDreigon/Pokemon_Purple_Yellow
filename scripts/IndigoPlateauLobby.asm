IndigoPlateauLobby_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	call EnableAutoTextBoxDrawing
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ld hl, wBeatLorelei
	bit 1, [hl]
	res 1, [hl]
	ret z
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, EVENT_LANCES_ROOM_LOCK_DOOR
	ret

IndigoPlateauLobby_TextPointers:
	def_text_pointers
	dw_const IndigoPlateauLobbyNurseText,            TEXT_INDIGOPLATEAULOBBY_NURSE
	dw_const IndigoPlateauLobbyGymGuideText,         TEXT_INDIGOPLATEAULOBBY_GYM_GUIDE
	dw_const IndigoPlateauLobbyCooltrainerFText,     TEXT_INDIGOPLATEAULOBBY_COOLTRAINER_F
	dw_const IndigoPlateauLobbyClerkText,            TEXT_INDIGOPLATEAULOBBY_CLERK
	dw_const IndigoPlateauLobbyPostGameClerkText,    TEXT_INDIGOPLATEAULOBBY_POST_GAME_CLERK
	dw_const IndigoPlateauLobbyLinkReceptionistText, TEXT_INDIGOPLATEAULOBBY_LINK_RECEPTIONIST
	dw_const IndigoPlateauLobbyChanseyText,          TEXT_INDIGOPLATEAULOBBY_CHANSEY

IndigoPlateauLobbyNurseText:
	script_pokecenter_nurse

IndigoPlateauLobbyGymGuideText:
	text_far _IndigoPlateauLobbyGymGuideText
	text_end

IndigoPlateauLobbyCooltrainerFText:
	text_far _IndigoPlateauLobbyCooltrainerFText
	text_end

IndigoPlateauLobbyLinkReceptionistText:
	script_cable_club_receptionist

IndigoPlateauLobbyChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

IndigoPlateauLobbyClerkText::
	; v0.5 mart rework: elite tiered mart. T0..T8 from the global inventory,
	; plus post-E4 elite items (ETHER, ELIXER, PP_UP, MAX_REVIVE) once the
	; player has beaten the Elite Four, plus post-rematch elite items
	; (MAX_ETHER, MAX_ELIXER, PP_MAX, RARE_CANDY) after the first E4 rematch.
	; v0.7 TM rework (Forte spec): 12 TMs appended as fixed extras (pre-E4
	; strong damage). Now includes DARK_PULSE/SHADOW_BALL/PETAL_DANCE
	; (added TMs per Forte's swap-in).
	script_tiered_mart_elite TM_MEGAHORN, TM_DARK_PULSE, TM_THUNDERBOLT, TM_SHADOW_BALL, TM_PETAL_DANCE, TM_FLAMETHROWER, TM_HURRICANE, TM_GIGA_DRAIN, TM_EARTHQUAKE, TM_ICE_BEAM, TM_PSYCHIC_M, TM_ROCK_SLIDE

IndigoPlateauLobbyPostGameClerkText::
	; v0.7 TM rework (Forte spec): post-E4 top tier / endgame. 3 TMs + PP Up.
	; (Other apex TMs like ROCK_SLIDE/PETAL_DANCE/DARK_PULSE now sold pre-E4.)
	script_mart TM_OUTRAGE, TM_THRASH, TM_DOUBLE_EDGE, PP_UP
