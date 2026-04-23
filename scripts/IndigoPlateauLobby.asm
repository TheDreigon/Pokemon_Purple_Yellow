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
	; v0.5 TM rework (rev8 spec): pre-E4 strong damage. 9 TMs (NIGHT_SHADE moved to Celadon 2F).
	; Regular items now come from the global tiered mart inventory; the
	; TMs below are appended as fixed extras.
	script_tiered_mart TM_MEGAHORN, TM_THUNDERBOLT, TM_FLAMETHROWER, TM_HURRICANE, TM_GIGA_DRAIN, TM_EARTHQUAKE, TM_ICE_BEAM, TM_PSYCHIC_M, TM_ROCK_SLIDE

IndigoPlateauLobbyPostGameClerkText::
	; v0.5 TM rework (rev8 spec): post-E4 top tier / endgame. 7 TMs + PP Up.
	script_mart TM_OUTRAGE, TM_THUNDER, TM_FIRE_BLAST, TM_SOLARBEAM, TM_BLIZZARD, TM_DOUBLE_EDGE, TM_HYDRO_PUMP, PP_UP
	
