Route6Gate_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route6Gate_ScriptPointers
	ld a, [wRoute6GateCurScript]
	call CallFunctionInTable
	ret

Route6Gate_ScriptPointers:
	def_script_pointers
	dw_const Route6GateDefaultScript,      SCRIPT_ROUTE6GATE_DEFAULT
	dw_const Route6GatePlayerMovingScript, SCRIPT_ROUTE6GATE_PLAYER_MOVING

Route6GateDefaultScript:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, .PlayerInCoordsArray
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	xor a
	ldh [hJoyHeld], a
; v0.7 (2026-09-06, Forte): the guards ask for four BADGES, not a drink - TEAM
; ROCKET has the city on edge. wd728 bit 6 (once "served") now means "let through".
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr nz, .fourBadges
	ld a, TEXT_ROUTE6GATE_GUARD_ROAD_SHUT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route6GateMovePlayerDownScript
	ld a, SCRIPT_ROUTE6GATE_PLAYER_MOVING
	ld [wRoute6GateCurScript], a
	ret
.fourBadges
	ld hl, wd728
	set 6, [hl]
	ld a, TEXT_ROUTE6GATE_GUARD_FOUR_BADGES
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

.PlayerInCoordsArray:
	dbmapcoord  3,  2
	dbmapcoord  4,  2
	db -1 ; end

Route6GatePlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute6GateCurScript], a
	ret

Route6GateMovePlayerDownScript:
	ld hl, wd730
	set 7, [hl]
	ld a, D_DOWN | B_BUTTON
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route6Gate_TextPointers:
	def_text_pointers
	dw_const SaffronGateGuardText,             TEXT_ROUTE6GATE_GUARD
	dw_const SaffronGateGuardRoadShutText,     TEXT_ROUTE6GATE_GUARD_ROAD_SHUT
	dw_const SaffronGateGuardFourBadgesText,   TEXT_ROUTE6GATE_GUARD_FOUR_BADGES
