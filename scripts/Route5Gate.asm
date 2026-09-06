Route5Gate_Script:
	call EnableAutoTextBoxDrawing
	ld a, [wRoute5GateCurScript]
	ld hl, Route5Gate_ScriptPointers
	jp CallFunctionInTable

Route5Gate_ScriptPointers:
	def_script_pointers
	dw_const Route5GateDefaultScript,      SCRIPT_ROUTE5GATE_DEFAULT
	dw_const Route5GatePlayerMovingScript, SCRIPT_ROUTE5GATE_PLAYER_MOVING

Route5GateMovePlayerUpScript:
	ld a, D_UP | B_BUTTON
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	jp StartSimulatingJoypadStates

Route5GateDefaultScript:
	ld a, [wd728]
	bit 6, a
	ret nz
; stage three (2026-09-06, Forte): TEAM ROCKET beaten at SILPH CO. - the road is
; open to everyone, badges or not (the same event flips Saffron's music)
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret nz
	ld hl, .PlayerInCoordsArray
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	xor a
	ldh [hJoyHeld], a
; v0.7 (2026-09-06, Forte): the guards ask for four BADGES, not a drink - TEAM
; ROCKET has the city on edge. wd728 bit 6 (once "served") now means "let through".
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr nz, .fourBadges
	ld a, TEXT_ROUTE5GATE_GUARD_ROAD_SHUT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route5GateMovePlayerUpScript
	ld a, SCRIPT_ROUTE5GATE_PLAYER_MOVING
	ld [wRoute5GateCurScript], a
	ret
.fourBadges
	ld a, TEXT_ROUTE5GATE_GUARD_FOUR_BADGES
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd728
	set 6, [hl]
	ret

.PlayerInCoordsArray:
	dbmapcoord  3,  3
	dbmapcoord  4,  3
	db -1 ; end

Route5GatePlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute5GateCurScript], a
	ret

Route5Gate_TextPointers:
	def_text_pointers
	dw_const SaffronGateGuardText,             TEXT_ROUTE5GATE_GUARD
	dw_const SaffronGateGuardRoadShutText,     TEXT_ROUTE5GATE_GUARD_ROAD_SHUT
	dw_const SaffronGateGuardFourBadgesText,   TEXT_ROUTE5GATE_GUARD_FOUR_BADGES

SaffronGateGuardText:
	text_asm
; three stages: SILPH CO. freed -> the city is safe; the four-badge latch ->
; you may pass; four badges just shown -> set the latch; else the road is shut
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	jr nz, .citySafe
	ld a, [wd728]
	bit 6, a
	jr nz, .letThrough
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr nz, .fourBadges
	ld hl, SaffronGateGuardRoadShutText
	call PrintText
	call Route5GateMovePlayerUpScript
	ld a, SCRIPT_ROUTE5GATE_PLAYER_MOVING
	ld [wRoute5GateCurScript], a
	jp TextScriptEnd

.fourBadges
	ld hl, SaffronGateGuardFourBadgesText
	call PrintText
	ld hl, wd728
	set 6, [hl]
	jp TextScriptEnd

.letThrough
	ld hl, SaffronGateGuardGoOnThroughText
	call PrintText
	jp TextScriptEnd

.citySafe
	ld hl, SaffronGateGuardCitySafeText
	call PrintText
	jp TextScriptEnd

SaffronGateGuardRoadShutText:
	text_far _SaffronGateGuardRoadShutText
	text_end

SaffronGateGuardFourBadgesText:
	text_far _SaffronGateGuardFourBadgesText
	text_end

SaffronGateGuardGoOnThroughText:
	text_far _SaffronGateGuardGoOnThroughText
	text_end

SaffronGateGuardCitySafeText:
	text_far _SaffronGateGuardCitySafeText
	text_end
