Route7Gate_Script:
	call EnableAutoTextBoxDrawing
	ld a, [wRoute7GateCurScript]
	ld hl, Route7Gate_ScriptPointers
	call CallFunctionInTable
	ret

Route7Gate_ScriptPointers:
	def_script_pointers
	dw_const Route7DefaultScript,      SCRIPT_ROUTE7GATE_DEFAULT
	dw_const Route7PlayerMovingScript, SCRIPT_ROUTE7GATE_PLAYER_MOVING

Route7GateMovePlayerLeftScript:
	ld hl, wd730
	set 7, [hl]
	ld a, D_LEFT | B_BUTTON
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route7DefaultScript:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, .PlayerInCoordsArray
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	xor a
	ldh [hJoyHeld], a
; v0.7 (2026-09-06, Forte): the guards ask for four BADGES, not a drink - TEAM
; ROCKET has the city on edge. wd728 bit 6 (once "served") now means "let through".
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr nz, .fourBadges
	ld a, TEXT_ROUTE7GATE_GUARD_ROAD_SHUT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route7GateMovePlayerLeftScript
	ld a, SCRIPT_ROUTE7GATE_PLAYER_MOVING
	ld [wRoute7GateCurScript], a
	ret
.fourBadges
	ld a, TEXT_ROUTE7GATE_GUARD_FOUR_BADGES
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd728
	set 6, [hl]
	ret

.PlayerInCoordsArray:
	dbmapcoord  3,  3
	dbmapcoord  3,  4
	db -1 ; end

Route7PlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute7GateCurScript], a
	ld [wCurMapScript], a
	ret

Route7Gate_TextPointers:
	def_text_pointers
	dw_const SaffronGateGuardText,             TEXT_ROUTE7GATE_GUARD
	dw_const SaffronGateGuardRoadShutText,     TEXT_ROUTE7GATE_GUARD_ROAD_SHUT
	dw_const SaffronGateGuardFourBadgesText,   TEXT_ROUTE7GATE_GUARD_FOUR_BADGES
