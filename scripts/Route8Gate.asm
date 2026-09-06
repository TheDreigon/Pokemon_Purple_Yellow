Route8Gate_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route8Gate_ScriptPointers
	ld a, [wRoute8GateCurScript]
	jp CallFunctionInTable

Route8Gate_ScriptPointers:
	def_script_pointers
	dw_const Route8GateDefaultScript,      SCRIPT_ROUTE8GATE_DEFAULT
	dw_const Route8GatePlayerMovingScript, SCRIPT_ROUTE8GATE_PLAYER_MOVING

Route8GateMovePlayerRightScript:
	ld hl, wd730
	set 7, [hl]
	ld a, D_RIGHT | B_BUTTON
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route8GateDefaultScript:
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
	ld a, TEXT_ROUTE8GATE_GUARD_ROAD_SHUT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route8GateMovePlayerRightScript
	ld a, SCRIPT_ROUTE8GATE_PLAYER_MOVING
	ld [wRoute8GateCurScript], a
	ret
.fourBadges
	ld hl, wd728
	set 6, [hl]
	ld a, TEXT_ROUTE8GATE_GUARD_FOUR_BADGES
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

.PlayerInCoordsArray:
	dbmapcoord  2,  3
	dbmapcoord  2,  4
	db -1 ; end

Route8GatePlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute8GateCurScript], a
	ret

Route8Gate_TextPointers:
	def_text_pointers
	dw_const SaffronGateGuardText,             TEXT_ROUTE8GATE_GUARD
	dw_const SaffronGateGuardRoadShutText,     TEXT_ROUTE8GATE_GUARD_ROAD_SHUT
	dw_const SaffronGateGuardFourBadgesText,   TEXT_ROUTE8GATE_GUARD_FOUR_BADGES
