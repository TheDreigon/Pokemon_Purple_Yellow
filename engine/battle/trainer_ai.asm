; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
	ld a, $a
	ld hl, wBuffer ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
; v1.0 (2026-09-26, P1 of the AI switch layer): the shinpokered "score backup"
; (wBuffer+4..7 filled with $ff here and copied to by a
; .loopFindMinimumEntries_backupfirst label nothing jumped to) is gone: 21 bytes
; that no reader ever used.

	ld a, [wEnemyDisabledMove] ; forbid disabled move (if any)
	swap a
	and $f
	jr z, .noMoveDisabled
	ld hl, wBuffer
	dec a
	ld c, a
	ld b, $0
	add hl, bc    ; advance pointer to forbidden move
	ld [hl], $50  ; forbid (highly discourage) disabled move
.noMoveDisabled
	call AIGetMoveChoiceList ; hl = this battle's layer list (the Hard boss / semi-boss override included)
	ld a, [hl]
	and a
	jp z, .useOriginalMoveSet
	push hl
.nextMoveChoiceModification
	pop hl
	ld a, [hli]
	and a
	jr z, .loopFindMinimumEntries
	push hl
	ld hl, AIMoveChoiceModificationFunctionPointers
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc    ; skip to pointer
	ld a, [hli]   ; read pointer into hl
	ld h, [hl]
	ld l, a
	ld de, .nextMoveChoiceModification  ; set return address
	push de
	jp hl         ; execute modification function
.loopFindMinimumEntries ; all entries will be decremented sequentially until one of them is zero
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.loopDecrementEntries
	ld a, [de]
	inc de
	and a
	jr z, .loopFindMinimumEntries
	dec [hl]
	jr z, .minimumEntriesFound
	inc hl
	dec c
	jr z, .loopFindMinimumEntries
	jr .loopDecrementEntries
.minimumEntriesFound
	ld a, c
.loopUndoPartialIteration ; undo last (partial) loop iteration
	inc [hl]
	dec hl
	inc a
	cp NUM_MOVES + 1
	jr nz, .loopUndoPartialIteration
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.filterMinimalEntries ; all minimal entries now have value 1. All other slots will be disabled (move set to 0)
	ld a, [de]
	and a
	jr nz, .moveExisting
	ld [hl], a
.moveExisting
	ld a, [hl]
	dec a
	jr z, .slotWithMinimalValue
	xor a
	ld [hli], a     ; disable move slot
	jr .next
.slotWithMinimalValue
	ld a, [de]
	ld [hli], a     ; enable move slot
.next
	inc de
	dec c
	jr nz, .filterMinimalEntries
	ld hl, wBuffer    ; use created temporary array as move set
	jr .done
.useOriginalMoveSet
	ld hl, wEnemyMonMoves    ; use original move set
.done
;;;;;;;;;; PureRGBnote: clear these values at the end of an AI cycle, they only apply when the player has switched or healed in a turn
	xor a
	ld [wAIMoveSpamAvoider], a
	ld [wAITargetMonStatus], a
;;;;;;;;;;
	ret

AIMoveChoiceModificationFunctionPointers:
	dw AIMoveChoiceModification1
	dw AIMoveChoiceModification2
	dw AIMoveChoiceModification3
	dw AIMoveChoiceModification4
	dw AIMoveChoiceModification5 ; v1.0 (2026-09-26): the tactical layer
	dw AIMoveChoiceModification6 ; v1.0 (2026-09-26): the switch layer (LAST in a list)

; v0.7 hard mode override list — bosses and semi-bosses get every layer (1-6 since v1.0)
; in Hard mode, regardless of their per-class default in
; TrainerClassMoveChoiceModifications. See AIEnemyTrainerChooseMoves
; (.readTrainerClassData) for the redirect.
HardModeBossAIMods:
	db 1, 2, 3, 4, 5, 6, 0 ; v1.0 (2026-09-26): + the tactical layer, + the switch layer

; v1.0 (2026-09-27): hl = the AI layer list this battle uses - the class's row
; of TrainerClassMoveChoiceModifications, or HardModeBossAIMods for a boss or a
; semi-boss in Hard. Shared by AIEnemyTrainerChooseMoves and AIHasSwitchLayer so
; the two can never disagree. Trainer battles only (class 0 would walk 255
; rows). Clobbers a, b; keeps c, de.
AIGetMoveChoiceList:
	ld hl, TrainerClassMoveChoiceModifications
	ld a, [wTrainerClass]
	ld b, a
.loopTrainerClasses
	dec b
	jr z, .readTrainerClassData
.loopTrainerClassData
	ld a, [hli]
	and a
	jr nz, .loopTrainerClassData
	jr .loopTrainerClasses
.readTrainerClassData
	; v0.7 hard mode: boss trainers and semi-bosses get every AI layer
	; (HardModeBossAIMods, 1-6 since v1.0), overriding their per-class
	; list. So Brock (whose normal list is 1,2,3,5) thinks like Lance, and
	; every boss switches out a losing mon, on Hard.
	push hl
	call IsHardModeBossOrSemiBattle ; semi-bosses think as hard as bosses do
	pop hl
	ret z
	ld hl, HardModeBossAIMods
	ret

; PureRGBnote: CHANGED: AKA the "Dont do stupid things no player would ever do" AI subroutine, many new default AI restrictions added
; discourages moves that cause no damage but only a status ailment if player's mon already has one, or if they're immune to it
; discourages moves that after being used once won't do anything when used again (mist, leech seed, etc.)
; discourages moves that will fail due to the current enemy pokemon's state (e.g. recover at full health)
AIMoveChoiceModification1:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp DREAM_EATER_EFFECT
	jp z, .checkAsleep
	ld a, [wEnemyMovePower]
	and a
	jr nz, .nextMove
	ld a, [wEnemyMoveEffect]
	cp DISABLE_EFFECT
	jr z, .checkDisabled
	cp LEECH_SEED_EFFECT
	jp z, .checkSeeded
	cp FOCUS_ENERGY_EFFECT
	jr z, .checkPumpedUp
	cp LIGHT_SCREEN_EFFECT
	jp z, .checkLightScreenUp
	cp REFLECT_EFFECT
	jp z, .checkReflectUp
	cp MIST_EFFECT
	jp z, .checkMistUp
	cp CONFUSION_EFFECT
	jp z, .checkConfused
	cp HEAL_EFFECT
	jp z, .checkFullHealth
	cp MIRROR_MOVE_EFFECT
	jp z, .checkNoMirrorMoveOnFirstTurn
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .nextMove
.checkStatusImmunity
	call CheckStatusImmunity
	jr c, .discourage
.notImmune
	ld a, [wAITargetMonStatus] ; set to the pokemon's current status before it gets healed or before it switches out
	and a
	jr nz, .discourage ; if the AI thinks the player has a status, they should avoid using status moves 
					   ; even if the player heals the status or switches out that turn
	ld a, [wAIMoveSpamAvoider] ; set if we switched or healed this turn
	cp 2 ; set to 2 if we switched
	jr z, .nextMove ; if the AI thinks the player DOESNT have a status before they switch, we should avoid discouraging status moves
	ld a, [wBattleMonStatus]
	and a
	jr z, .nextMove ; no need to discourage status moves if the player doesn't have a status
.discourage
	ld a, [hl]
	add $5 ; heavily discourage move
	ld [hl], a
	jr .nextMove
.checkDisabled
	ld a, [wPlayerDisabledMove] ; non-zero if the player has a disabled move
	and a
	jp z, .nextMove ; if it's zero don't do anything
	jr .discourage ; otherwise discourage using disable while opponent is disabled already
.checkPumpedUp
	ld a, [wEnemyBattleStatus2]
	bit GETTING_PUMPED, a
	jr nz, .discourage ; if the enemy has used focus energy don't use again
	jp .nextMove
.checkAsleep
	ld a, [wAITargetMonStatus]
	and SLP_MASK
	jp nz, .nextMove ; if we just healed sleep or switched out a sleeping pokemon, 
					 ; the AI shouldn't predict this perfectly when deciding whether to use dream eater
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .discourage ; heavily discourage, if the player isn't asleep avoid using dream eater
	jp .nextMove
.checkLightScreenUp
	ld a, [wEnemyBattleStatus3]
	bit HAS_LIGHT_SCREEN_UP, a
	jr nz, .discourage ; if the enemy has a light screen up dont use the move again
	jp .nextMove
.checkReflectUp
	ld a, [wEnemyBattleStatus3]
	bit HAS_REFLECT_UP, a
	jr nz, .discourage ; if the enemy has a reflect up dont use the move again
	jp .nextMove
.checkMistUp
	ld a, [wEnemyBattleStatus2]
	bit PROTECTED_BY_MIST, a
	jr nz, .discourage ; if the enemy has used mist, don't use it again
	jp .nextMove
.checkConfused
	ld a, [wPlayerBattleStatus1]
	bit CONFUSED, a
	jr nz, .discourage ; if the player is confused, don't use confusion-inflicting moves
	jp .nextMove
.checkSeeded
	call CheckSeeded
	jp nc, .nextMove
	jr .discourage
.checkFullHealth ; avoid using moves like recover at full health.
	push hl
	push de
	ld hl, wEnemyMonMaxHP
	ld de, wEnemyMonHP
	ld a, [de]
	cp [hl]
	jr nz, .notFullHealth
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr nz, .notFullHealth
	; PURPLE YELLOW v0.6: Softboiled now also clears status (Full Heal). Allow
	; the AI to use Softboiled at full HP if it has a status to refresh.
	; v1.0 (2026-09-27): a POISON, a BURN or a PARALYSIS - not SLEEP or a FREEZE:
	; the enemy now chooses while asleep or frozen, and that pick runs only on the
	; turn it wakes or thaws, when the status is already gone.
	ld a, [wEnemyMoveNum]
	cp SOFTBOILED
	jr nz, .fullHealthDiscourage
	ld a, [wEnemyMonStatus]
	and (1 << PSN) | (1 << BRN) | (1 << PAR)
	jr z, .fullHealthDiscourage
	pop de
	pop hl
	jp .nextMove ; statused: Softboiled is worth using as Full Heal
.fullHealthDiscourage
	pop de
	pop hl
	jp .discourage
.notFullHealth
	pop de
	pop hl
	jp .nextMove
.checkNoMirrorMoveOnFirstTurn
; v1.0 (2026-09-08): this read wPlayerLastSelectedMove, a pureRGB byte nothing in
; this hack ever wrote, so the check always discouraged MIRROR MOVE. The byte went
; to the stack; the check now reads what MIRROR MOVE itself copies (core.asm
; MirrorMoveCopyMove): wPlayerUsedMove, zeroed whenever a Pokemon is sent out and
; whenever the player sleeps or is frozen through a turn. Zero = the copy would
; fail, so discourage; otherwise let the move compete like any other.
	ld a, [wPlayerUsedMove]
	and a
	jp z, .discourage ; the player has not used a move since the last switch-in
	jp .nextMove


StatusAilmentMoveEffects:
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db BURN_EFFECT ; Will-O-Wisp & Ignite (pure-status burn moves; damaging burn
	               ; moves are power-gated out before this lookup, so they are
	               ; intentionally absent — discouraging a damage move here is wrong)
	db -1 ; end

;;;;;;;;;; PureRGBnote: ADDED: function for checking if the player can have leech seed applied and whether they already have it applied

CheckSeeded:
	push hl
	ld a, [wPlayerBattleStatus2]
	bit SEEDED, a
	jr nz, .discourage ; if the enemy has used leech seed don't use again
	ld a, [wAIMoveSpamAvoider]
	cp 2 ; set to 2 if we switched out this turn
	ld hl, wBattleMonType1
	jr nz, .noSwitchOut
	ld hl, wAITargetMonType1 ; stores what the AI thinks the player's type is when a switchout happens
.noSwitchOut	
	ld a, [hl]
	cp GRASS
	jr z, .discourage ; leech seed does not affect grass types
	inc hl
	ld a, [hl]
	cp GRASS
	jr z, .discourage ; leech seed does not affect grass types
	pop hl
	and a
	ret
.discourage
	pop hl
	scf
	ret	

;;;;;;;;;;

;;;;;;;;;; PureRGBnote: ADDED: function for checking if the player's pokemon is unaffected by specific status moves.

CheckStatusImmunity:
; v0.7: statuses can have TWO immune defender types — checked via the b/c
; pair (when only one applies, b == c). Mirrors the engine-side immunities
; in effects.asm (burn: FIRE/MAGMA; poison: POISON/STEEL; paralyze:
; ELECTRIC always, plus GROUND vs Electric-sourced paralysis).
	push bc
	push hl
	ld a, [wEnemyMoveEffect]
	cp POISON_EFFECT
	ld b, POISON
	ld c, STEEL ; v0.7: Steel-types can't be poisoned either
	jr z, .getMonTypes
	cp PARALYZE_EFFECT
	jr z, .checkParalyze
	ld b, FIRE
	ld c, MAGMA ; burn immunity: Fire/Magma types
	cp BURN_EFFECT ; only Will-O-Wisp/Ignite reach here — damaging burn moves
	               ; (Fire Blast/Lava Plume) are power-gated out before this
	jr z, .getMonTypes
	jr .done
.checkParalyze
	ld b, ELECTRIC ; v0.7: Electric-types can't be paralyzed at all
	ld c, ELECTRIC
	ld a, [wEnemyMoveType]
	cp ELECTRIC
	jr nz, .getMonTypes
	ld c, GROUND ; Ground is immune to the whole Electric move (incl. paralysis)
.getMonTypes
	ld a, [wAIMoveSpamAvoider] ; set if we healed status or switched out this turn
	cp 2 ; it's 2 if we switched out
	jr nz, .noSwitchOut
	ld hl, wAITargetMonType1
	jr .checkTypes
.noSwitchOut
	ld hl, wBattleMonType1
.checkTypes
	ld a, [hl]
	cp b
	jr z, .discourage
	cp c ; v0.7: second immune type
	jr z, .discourage
	inc hl
	ld a, [hl]
	cp b
	jr z, .discourage
	cp c ; v0.7
	jr z, .discourage
.done
	pop hl
	pop bc
	and a
	ret
.discourage
	pop hl
	pop bc
	scf
	ret
;;;;;;;;;;

; PureRGBnote: CHANGED: AKA the "Boost stats on the first turn" subroutine
; slightly encourage moves with specific effects on the first turn. (PureRGBnote: FIXED: used to be the second turn, made it first turn)
; this mostly means trainers will buff their pokemon a bit on the first turn
AIMoveChoiceModification2:
	ld a, [wAILayer2Encouragement]
	and a
	ret nz ; choose this modifier only on the first turn
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, Modifier2PreferredMoves
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .nextMove
.preferMove
	dec [hl] ; slightly encourage this move
	jr .nextMove

Modifier2PreferredMoves:
	db LEECH_SEED_EFFECT
	db FOCUS_ENERGY_EFFECT
	db REFLECT_EFFECT
	db LIGHT_SCREEN_EFFECT
	db ATTACK_UP1_EFFECT
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT
	db SPATK_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPATK_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPATK_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPATK_DOWN2_EFFECT
	db ACCURACY_DOWN2_EFFECT
	db EVASION_DOWN2_EFFECT
	db SUBSTITUTE_EFFECT
	; PURPLE YELLOW v0.5/v0.6: dual-stat + mixed-direction effects added so the
	; AI treats them as setup-worthy on turn 1 (otherwise they fall through to
	; nextMove unscored, since the engine added them after vanilla AI was written).
	db ATTACK_DEFENSE_UP1_EFFECT     ; Bulk Up, Coil
	db ATTACK_ACCURACY_UP1_EFFECT    ; Hone Claws
	db SPEED_EVASION_UP1_EFFECT      ; Agility (revised)
	db ATTACK_UP1_DOWN1_EFFECT       ; Fierce Roar (user up + target down)
	db ATTACK_SPATK_UP1_HEAL_EFFECT       ; Growth (ATK + SP.ATK up + heal 1/4)
	db ACCURACY_EVASION_DOWN1_EFFECT ; Flash (target dual-down)
	db SPDEF_SPEED_DOWN1_EFFECT    ; Eerie Impulse (target dual-down)
	db SPATK_SPDEF_ACCURACY_UP1_EFFECT   ; Calm Mind (SP.ATK + SP.DEF + ACC up)
	db SPATK_SPEED_UP1_EFFECT      ; Quiver Dance (user dual-up)
	db SPEED_EVASION_DOWN1_EFFECT    ; Psychic Bind (target dual-down)
	db SPDEF_DOWN2_FLINCH_EFFECT   ; Metal Sound (target down + flinch)
	db SPDEF_DOWN1_FLINCH_EFFECT   ; Screech (target down + flinch)
	db ATTACK_DOWN2_FLINCH_EFFECT    ; Intimidate (target down + flinch)
	db SPEED_DOWN2_FLINCH_EFFECT     ; Scary Face (target down + flinch)
	db SPEED_DOWN1_FLINCH_EFFECT     ; Hinder (target down + flinch)
	db DEFENSE_DOWN1_FLINCH_EFFECT   ; Tickle (target down + flinch)
	db SPDEF_UP2_EFFECT              ; Amnesia (the split, 2026-09-06)
	db SPDEF_DOWN2_EFFECT            ; Fake Tears (the split)
	db -1 ; end

; PureRGBnote: CHANGED: AKA the "Use Effective damaging moves offensively" subroutine
; encourages moves that are effective against the player's mon if they do damage. 
; discourage damaging moves that are ineffective or not very effective against the player's mon,
; unless there's no damaging move that deals at least neutral damage
; encourage effective or super effective draining moves to be used at low health
; PureRGBnote: FIXED: this subroutine won't cause the AI to prefer status moves 
;                     just because their type is super effective against the opponent. Like spamming agility on a poison pokemon.
AIMoveChoiceModification3:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	jp z, .clearPreviousTypes ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	jp z, .clearPreviousTypes ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr z, .nextMove ; ignores moves that do no damage (status moves), as we're only concerned with damaging moves for this modifier
	ld a, [wAIMoveSpamAvoider] ; if we switched this turn or healed status, this is set
	cp 2 ; it's 2 if we switched pokemon this turn
	call nz, StoreBattleMonTypes ; in the case where we didnt switch
								 ; we need to populate wAITargetMonType1 and wAITargetMonType2 with the current pokemon's type data
	push hl
	push bc
	push de
	callfar AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wTypeEffectiveness]
	cp EFFECTIVE
	jr z, .checkSpecificEffects
	jr c, .notEffectiveMove
	dec [hl] ; slightly encourage this super effective move
.checkSpecificEffects ; we'll further encourage certain moves
	call EncourageDrainingMoveIfLowHealth
	jr .nextMove
.notEffectiveMove ; discourages non-effective moves if better moves are available
	push hl
	push de
	push bc
	ld a, [wEnemyMoveType]
	ld d, a
	ld hl, wEnemyMonMoves  ; enemy moves
	; v0.7 FIX: this was `ld bc, NUM_MOVES + 1`, which loads the 16-bit value
	; 5 — so b got the HIGH byte (0) and c the low byte, and the `ld c, $0`
	; below then made both zero. The `dec b` at .loopMoves therefore wrapped
	; b to $ff and the scan ran up to 255 entries instead of 4, reading clean
	; past the 4-byte wEnemyMonMoves into the mon's DV and level bytes and
	; calling ReadMove on whatever it found. Load b alone.
	ld b, NUM_MOVES + 1
	ld c, $0
.loopMoves
	dec b
	jr z, .done
	ld a, [hli]
	and a
	jr z, .done
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp SUPER_FANG_EFFECT
	jr z, .betterMoveFound ; Super Fang is considered to be a better move
	cp TARGET_LEVEL_DAMAGE_EFFECT
	jr z, .betterMoveFound ; the fixed-damage family is considered better
	cp USER_LEVEL_DAMAGE_EFFECT
	jr z, .betterMoveFound
	cp SET_DAMAGE_EFFECT
	jr z, .betterMoveFound
	cp FLY_EFFECT
	jr z, .betterMoveFound ; Fly is considered to be a better move
	ld a, [wEnemyMoveType]
	cp d
	jr z, .loopMoves
	ld a, [wEnemyMovePower]
	and a
	jr nz, .betterMoveFound ; damaging moves of a different type are considered to be better moves
	jr .loopMoves
.betterMoveFound
	ld c, a
.done
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jp z, .nextMove
	inc [hl] ; slightly discourage this move
	jp .nextMove
.clearPreviousTypes
	xor a
	ld [wAITargetMonType1], a
	ld [wAITargetMonType2], a
	ret

; PureRGBnote: ADDED: if the opponent has less than 1/2 health they will prefer healing moves if they use AI subroutine 3
EncourageDrainingMoveIfLowHealth:
	ld a, [wEnemyMoveEffect]
	cp DRAIN_HP_EFFECT
	ret nz
	ld a, 2 ; 1/2 maximum hp gone
	call AICheckIfHPBelowFractionWrapped
	ret nc
	dec [hl] ; encourage the draining move if enemy has more than half health gone
	ret

; PureRGBnote: ADDED: AKA the "Apply Status and Heal when needed" subroutine
; slightly encourage moves with specific effects. 
; This one will make the opponent want to use status applying moves when you don't have one.
; It also makes them want to use dream eater if you're asleep, and want to use a recovery move at low health.
AIMoveChoiceModification4:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp DREAM_EATER_EFFECT
	jr z, .checkOpponentAsleep
	ld a, [wEnemyMovePower]
	and a
	jr nz, .nextMove
	ld a, [wEnemyMoveEffect]
	cp HEAL_EFFECT
	jr z, .checkWorthHealing
	push hl
	push de
	push bc
	ld hl, Modifier4PreferredMoves
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .nextMove
	ld a, [wAITargetMonStatus] ; set to nonzero if player healed battle mon's status or switched one with a status out this turn
	and a
	jr z, .preferMove
	ld a, [hl]
	add $5 
	ld [hl], a ; heavily discourage using a status move right after the player switched or healed
	jr .nextMove
.preferMove
	dec [hl] ; slightly encourage this move
	jr .nextMove
.checkWorthHealing
	ld a, 2 ; 1/2 maximum HP
	call AICheckIfHPBelowFractionWrapped
	jr c, .preferMove ; if HP is below 50% encourage using a healing move
	; PURPLE YELLOW v0.6: Softboiled also acts as Full Heal — encourage it when
	; the AI has a status condition, regardless of HP.
	; v1.0 (2026-09-27): POISON, BURN, PARALYSIS only (see layer 1: a pick made
	; asleep or frozen runs once the status is gone).
	ld a, [wEnemyMoveNum]
	cp SOFTBOILED
	jr nz, .nextMove
	ld a, [wEnemyMonStatus]
	and (1 << PSN) | (1 << BRN) | (1 << PAR)
	jr nz, .preferMove
	jr .nextMove
.checkOpponentAsleep
	ld a, [wAITargetMonStatus] ; set to nonzero if player healed battle mon's status or switched one with a status out this turn
	and SLP_MASK
	jr nz, .preferMoveEvenMore
	ld a, [wAIMoveSpamAvoider] ; set if we switched or healed this turn
	cp 2 ; set to 2 if we switched
	jr z, .nextMove ; if the AI thinks the player IS NOT asleep before they switch, we shouldn't encourage based on the new mon's status
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .nextMove
.preferMoveEvenMore
	dec [hl]
	jr .preferMove
.done
	ret

Modifier4PreferredMoves:
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db BURN_EFFECT       ; Will-O-Wisp & Ignite (always-burn status moves; damaging
	                     ; burn moves are power-gated out before this lookup)
	db CONFUSION_EFFECT
	db -1 ; end

; v1.0 (2026-09-26, the AI switch layer, P4): the TACTICAL layer - 5 in a
; class's list (data/trainers/move_choices.asm), so it is opt-in per class.
; Adapted from ExtremeYellow's Mod3 parts 3/4/8/2 (trainer_ai.asm:1173, :1209,
; :1858, :1122). For every move of the set:
;  - the move the enemy keeps repeating (wEnemyUsedMove, wAIRepeatCount from
;    MonName1Text): +1 on the fourth use in a row, +2, +3, +4 saturated;
; and for the damaging ones only:
;  - STAB (the move's type is one of the mon's): -1;
;  - EXPLOSION below 1/2, 1/4, 1/8 of the mon's HP: -1, -2, -3;
;  - the player under FLY/DIG: a priority move (PriorityMovesList, 8 and up)
;    +5 - it would go first and hit nothing (nothing lands on a mon up in the
;    air or underground here, never-miss moves included);
;  - a priority move when the enemy is slower, the player is not asleep or
;    frozen (the status a trainer sees; 2026-09-27: not the hidden turns left)
;    and the move at least neutral: -1 (it goes first).
AIMoveChoiceModification5:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
; the move the enemy keeps using
	ld a, [wEnemyMoveNum]
	ld c, a
	ld a, [wEnemyUsedMove]
	cp c
	jr nz, .notARepeat
	ld a, [wAIRepeatCount] ; executions in a row already: 2 = this would be the fourth
	cp 2
	jr c, .notARepeat
	dec a ; 2 -> +1, 3 -> +2, 4 -> +3, 5 -> +4
	cp 5
	jr c, .addRepeat
	ld a, 4 ; saturates
.addRepeat
	add [hl]
	ld [hl], a
.notARepeat
	ld a, [wEnemyMovePower]
	and a
	jp z, .nextMove ; the rest is for damaging moves only
; STAB
	ld a, [wEnemyMoveType]
	ld c, a
	ld a, [wEnemyMonType1]
	cp c
	jr z, .stab
	ld a, [wEnemyMonType2]
	cp c
	jr nz, .noStab
.stab
	dec [hl]
.noStab
; EXPLOSION by HP
	ld a, [wEnemyMoveEffect]
	cp EXPLODE_EFFECT
	jr nz, .notExplosion
	ld a, 2
	call AICheckIfHPBelowFractionWrapped
	jr nc, .notExplosion
	dec [hl]
	ld a, 4
	call AICheckIfHPBelowFractionWrapped
	jr nc, .notExplosion
	dec [hl]
	ld a, 8
	call AICheckIfHPBelowFractionWrapped
	jr nc, .notExplosion
	dec [hl]
.notExplosion
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a ; the player is up in the air / underground
	jr z, .playerVisible
	call AIGetMovePriorityWrapped
	cp 8
	jp c, .nextMove
	ld a, [hl] ; a priority move now goes first and hits nothing
	add 5
	ld [hl], a
	jp .nextMove
.playerVisible
	call AIGetMovePriorityWrapped
	cp 8
	jp c, .nextMove
	call AIEnemyIsSlower
	jp nc, .nextMove ; faster (or as fast) anyway: no need for priority
; does the player act this turn? v1.0 (2026-09-27, Forte: "certo, corrige"):
; a trainer sees the status, not the turns left - asleep or frozen is taken as
; "stays down" (true on most such turns), and no first strike is bought
; against it. (It used to read the player's exact sleep count and
; wPlayerFreezeCounter; pokecrystal's AI_Smart_PriorityHit reads neither.)
	ld a, [wBattleMonStatus]
	and (1 << FRZ) | SLP_MASK
	jp nz, .nextMove
	push hl
	push bc
	push de
	callfar AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wTypeEffectiveness]
	cp EFFECTIVE
	jp c, .nextMove ; not very effective: the first strike is not worth it
	dec [hl]
	jp .nextMove

AIEnemyIsSlower:
; carry = the enemy's speed (modified, the word the turn order compares) is
; below the player's; equal is "not slower". Registers kept.
	push hl
	push de
	push bc
	ld hl, wEnemyMonSpeed
	ld de, wBattleMonSpeed
	ld a, [de]
	ld b, a ; player's high byte
	ld a, [hli]
	cp b
	jr nz, .decided
	inc de
	ld a, [de]
	ld b, a ; player's low byte
	ld a, [hl]
	cp b
.decided
	pop bc
	pop de
	pop hl
	ret

AIGetMovePriorityWrapped:
; a = the priority of wEnemyMoveNum (7 = none). PriorityMovesList lives in
; Battle Core with HandleMovePriority; AIGetPriority reads it there, so no
; copy of the list is kept in this bank. Registers kept (a farcall kills
; b, c and hl; e carries the answer out).
	push hl
	push de
	push bc
	farcall AIGetPriority
	ld a, e
	pop bc
	pop de
	pop hl
	ret

; v1.0 (2026-09-26, the AI switch layer, P6): the SWITCH layer - 6 in a
; class's list (data/trainers/move_choices.asm), and it must come LAST in
; the list: it reads the scores the layers before it left in wBuffer and
; never touches them. It adds up, out of 32, how much the mon that is out
; wants to leave; 32 or more asks for sure, 0 never asks (no Random spent),
; anything between asks with that chance out of 32. A hit sets
; wAISwitchRequest to 1 + the party index of the teammate AIPickSwitchTarget
; chose; TrainerAI's hook acts on it this same turn and EnemySendOut brings
; that teammate in; SelectEnemyMove clears the request every turn before any
; of its gates, so a request never outlives the turn that made it. Since the
; enemy chooses at the START of the turn (MainInBattleLoop), both the
; decision and the pick see the player's Pokemon as the trainer could, not
; one the player switched in that turn - bar the WRAP exceptions: when a
; WRAP (the enemy's or the player's) stopped the choice at the top and the
; player's action ended it (a switch ends both WRAPs; an item can end the
; player's own on its last turn), the enemy chooses after that action and
; sees it, as it always did - it had nothing to choose at the top. It never
; asks for a mon that is asleep or frozen (2026-09-27: the status only, see
; its top - the layers now run for sleepers), and only when the hook will
; honour it - a second live mon in the party - because a pending
; request is the enemy's action this turn: TrainerAI runs before either move
; (2026-09-27), so a switch runs before the player's move, as the player's
; own switch does.
; Adapted from ExtremeYellow's Mod4 (trainer_ai.asm:1913-2072). The knobs
; are its weights (13/6, 7/18/25/32, 29), plus two reasons to STAY that are
; ours (a boosted mon, a mon behind screens) and a cooldown for the mon
; that just came in. The stages are the seven MOD_ bytes (7 each when
; untouched, 49 in all); the score floor of 0 means the reasons to stay
; are taken off last, so they are never lost.
AISwitchKnobs:
.confused: db 13 ; the mon is CONFUSED
.toxic:    db 6  ; the mon is badly poisoned
.stages:   db 7, 18, 25, 32 ; net stat stages -1, -2, -3, -4 or worse
.boosted:  db 10 ; off at net +2 or better: it is winning, it stays
.allBad:   db 29 ; every move it has is discouraged (score 11 or more)
.screen:   db 10 ; off for each screen up (REFLECT, LIGHT SCREEN)
.cooldown: db 2  ; turns the mon that just came in is left alone

AIMoveChoiceModification6:
	ld a, [wAISwitchCooldown]
	and a
	jr z, .noCooldown
	dec a
	ld [wAISwitchCooldown], a
	ret
.noCooldown
; v1.0 (2026-09-27, D14 by the status only): an asleep or frozen mon is never
; withdrawn - the trainer sees the status, not the turns left (it used to let
; one go on the turn its hidden count ran out). The enemy now chooses every
; turn, so this runs for sleepers: the rule lives here (the TrainerAI hook
; keeps the same test as a second guard).
	ld a, [wEnemyMonStatus]
	and (1 << FRZ) | SLP_MASK
	ret nz ; no request, no Random spent
	call AICountLiveEnemyMons
	cp 2
	ret c ; nothing to switch to: no request, and no Random spent
	ld b, 0 ; the score, out of 32
	ld a, [wEnemyBattleStatus1]
	bit CONFUSED, a
	jr z, .checkToxic
	ld a, [AISwitchKnobs.confused]
	call AddToBCapped
.checkToxic
	ld a, [wEnemyBattleStatus3]
	bit BADLY_POISONED, a
	jr z, .checkStages
	ld a, [AISwitchKnobs.toxic]
	call AddToBCapped
.checkStages
	call AISumEnemyStatStages ; a = the seven stage bytes added up, 49 = untouched
	cp 7 * (MOD_EVASION + 1)
	jr nc, .checkScores ; untouched or boosted: nothing to add here
	ld c, a
	ld a, 7 * (MOD_EVASION + 1) - 1
	sub c ; 0 at net -1, 1 at -2, 2 at -3, 3 and beyond further down
	cp 4
	jr c, .stageIndex
	ld a, 3
.stageIndex
	ld hl, AISwitchKnobs.stages
	ld c, a
	push bc
	ld b, 0
	add hl, bc
	pop bc
	ld a, [hl]
	call AddToBCapped
.checkScores
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld c, NUM_MOVES + 1
.nextMove
	dec c
	jr z, .allBad ; processed all 4 moves and none was fine
	inc hl
	ld a, [de]
	and a
	jr z, .allBad ; end of the set and none was fine
	inc de
	ld a, [hl]
	cp 11
	jr c, .checkBoosted ; one move is still fine (10 or better): it can fight
	jr .nextMove
.allBad
	ld a, [AISwitchKnobs.allBad]
	call AddToBCapped
; the reasons to stay come off last
.checkBoosted
	call AISumEnemyStatStages
	cp 7 * (MOD_EVASION + 1) + 2
	jr c, .checkReflect
	ld a, [AISwitchKnobs.boosted]
	call SubFromBCapped
.checkReflect
	ld a, [wEnemyBattleStatus3]
	bit HAS_REFLECT_UP, a
	jr z, .checkLightScreen
	ld a, [AISwitchKnobs.screen]
	call SubFromBCapped
.checkLightScreen
	ld a, [wEnemyBattleStatus3]
	bit HAS_LIGHT_SCREEN_UP, a
	jr z, .roll
	ld a, [AISwitchKnobs.screen]
	call SubFromBCapped
.roll
	ld a, b
	cp 32
	jr nc, .request ; 32 or more: for sure
	and a
	ret z ; 0: never, and no Random spent
	rla
	rla
	rla ; b < 32, so this is b * 8 with no bit lost: the chance out of 256
	ld b, a
	call Random
	cp b
	ret nc
.request
; the request names the teammate to bring in (1 + its party index); b is
; kept as it came in (the score on the certain path, score * 8 on the roll
; path) for the tests that read it back
	push bc
	call AIPickSwitchTarget
	pop bc
	ld [wAISwitchRequest], a
	ret

AISumEnemyStatStages:
; a = the enemy's seven stage bytes (MOD_ATTACK..MOD_EVASION; 7 each when
; untouched, so 49) added up. The eighth byte of wEnemyMonStatMods is a pad
; and is not read. Keeps hl, bc.
	push hl
	push bc
	ld hl, wEnemyMonStatMods
	ld c, MOD_EVASION + 1
	xor a
.loop
	add [hl]
	inc hl
	dec c
	jr nz, .loop
	pop bc
	pop hl
	ret

AddToBCapped:
; b = b + a, held at 255
	add b
	jr nc, .noCarry
	ld a, $ff
.noCarry
	ld b, a
	ret

SubFromBCapped:
; b = b - a, held at 0. Clobbers c.
	ld c, a
	ld a, b
	sub c
	jr nc, .noBorrow
	xor a
.noBorrow
	ld b, a
	ret

; v1.0 (2026-09-26, Forte: "dar mais inteligência aos oponentes"): WHO comes
; in when the switch layer withdraws a mon. Until now it was the first live
; teammate in party order (vanilla's EnemySendOut, which ExtremeYellow
; keeps). This ranks the teammates the way Gen 2 ranks a replacement
; (pokecrystal FindMonInOTPartyToSwitchIntoBattle: a super-effective move
; and not weak first, then not weak, ties to party order), without its two
; blind spots (a STATUS move of a super-effective type counted there, and
; HP was never looked at), and with a resist tier. It runs where the switch
; is decided - when the enemy chooses, at the start of the turn (bar the
; WRAP exception in MainInBattleLoop) - so it sees the player's Pokemon as
; the trainer can, not one the player switches in that turn. The scores
; (AIScoreSwitchCandidate):
;   0  weak to one of the player's types, or below 1/4 of its HP
;   1  takes the player's types neutrally
;   2  resists (or is immune to) every one of them
;  +2  not weak, and one of its TYPE-SCALED damaging moves is super effective
;      on the player (not the fixed-damage family - SEISMIC TOSS, NIGHT SHADE,
;      DRAGON RAGE, SONICBOOM, SUPER FANG, PARASITE - whose damage ignores the
;      type chart)
; The best comes in; a tie keeps party order. The LAST mon of the party - the
; ace of every boss team - is kept for last: it comes in only when no other
; teammate is alive. In Hard, for a boss or a semi-boss (Forte, 2026-09-27:
; "pode ser, sim. à experiencia") the co-aces wait with it: a teammate at the team's top level
; (the highest MON_LEVEL in the whole roster, fainted mons included, so the set
; never changes during the fight) comes in only when no teammate below that
; level is alive - then the best of them, the last slot still last of all. A
; team all at one level has no one below the top and plays as in Normal.
; It also picks the replacement of a fainted mon (AIPickFaintReplacement).
; Out: a = 1 + the party index (the wAISwitchRequest encoding). Clobbers bc, de, hl.
AIPickSwitchTarget:
; b = the level held back with the ace: for a boss or a semi-boss in Hard the
; team's top level; otherwise $ff, a level no Pokemon has
	call IsHardModeBossOrSemiBattle ; trashes a, b, hl
	ld b, $ff
	jr z, .gotHeldLevel
	ld a, [wEnemyPartyCount]
	ld c, a
	ld hl, wEnemyMon1Level ; MON_LEVEL - byte 3 (MON_BOX_LEVEL) is the freeze count now
	ld de, wEnemyMon2 - wEnemyMon1
	ld b, [hl]
.topLevel
	ld a, [hl]
	cp b
	jr c, .notHigher
	ld b, a
.notHigher
	add hl, de
	dec c
	jr nz, .topLevel
.gotHeldLevel
	ld de, 0 ; d = the best rank so far (0 = none yet), e = its party index
	ld c, 0
.loop
	ld a, [wEnemyPartyCount]
	dec a ; the last index: the ace
	cp c
	jr z, .done
	jr c, .done
	ld a, [wEnemyMonPartyPos]
	cp c
	jr z, .next ; the mon that is out
	call AIScoreSwitchCandidate ; a = 0 fainted, else 1 + its score (1-5); hl = its roster entry; keeps bc, de
	and a
	jr z, .next
	push bc
	ld bc, MON_LEVEL
	add hl, bc
	pop bc
	ld l, [hl] ; its level
	ld h, a ; 1 + its score
	ld a, l
	cp b
	ld a, h
	jr z, .heldBack ; a co-ace: it ranks only among the co-aces
	add 8 ; not held back: above every co-ace (1 + a score is 5 at most)
.heldBack
	cp d
	jr c, .next
	jr z, .next ; a tie keeps the earlier one
	ld d, a
	ld e, c
.next
	inc c
	jr .loop
.done
	ld a, d
	and a
	jr z, .theAce
	ld a, e
	inc a
	ret
.theAce
	ld a, [wEnemyPartyCount] ; 1 + the last index
	ret

AIScoreSwitchCandidate:
; In: c = a party index (not the mon that is out). Out: a = 0 if it has
; fainted, else 1 + its score (see AIPickSwitchTarget); hl = its roster entry
; (AIPickSwitchTarget reads its level there). Keeps bc, de.
	push bc
	push de
	ld hl, wEnemyMon1
	ld a, c
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	push hl ; its roster entry
	ld bc, MON_HP
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl] ; de = its HP
	or e
	jp z, .fainted ; jp: the effect checks below put it out of jr reach
	sla e
	rl d
	sla e
	rl d ; de = 4 * HP (HP stays below 1000: no bit is lost)
	pop hl
	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .weak ; below a quarter of its HP: no place to take a hit
	jr nz, .enoughHP
	inc hl
	ld a, e
	cp [hl]
	jr c, .weak
.enoughHP
	pop hl
	push hl
	ld bc, MON_TYPE1
	add hl, bc ; hl -> its two types
; defence: the worst the player's two types do to it
	ld a, [wBattleMonType1]
	call AIMatchupAtHL
	ld b, a
	ld a, [wBattleMonType2]
	call AIMatchupAtHL
	cp b
	jr c, .gotWorst
	ld b, a
.gotWorst
	ld a, b
	ld c, 1 ; takes them neutrally
	cp EFFECTIVE + 1
	jr nc, .weak
	cp EFFECTIVE
	jr nc, .attack
	inc c ; resists (or is immune to) every one of them
.attack
; +2 when one of its type-scaled damaging moves is super effective on the player
	ld de, MON_MOVES - MON_TYPE1
	add hl, de ; hl -> its moves
	ld b, NUM_MOVES
.moveLoop
	ld a, [hli]
	and a
	jr z, .scored ; no more moves
	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, [hli] ; its effect
	cp SUPER_FANG_EFFECT
	jr z, .nextMove ; the fixed-damage family: the type chart does not scale it
	cp TARGET_LEVEL_DAMAGE_EFFECT
	jr z, .nextMove
	cp USER_LEVEL_DAMAGE_EFFECT
	jr z, .nextMove
	cp SET_DAMAGE_EFFECT
	jr z, .nextMove
	ld a, [hli] ; its power
	and a
	jr z, .nextMove ; a status move: its type hits nothing
	ld a, [hl] ; its type
	ld hl, wBattleMonType1
	call AIMatchupAtHL
	cp EFFECTIVE + 1
	jr nc, .superEffective
.nextMove
	pop bc
	pop hl
	dec b
	jr nz, .moveLoop
	jr .scored
.superEffective
	pop bc
	pop hl
	inc c
	inc c
.scored
	ld a, c
	inc a
	jr .return
.weak
	ld a, 1 ; 1 + a score of 0
	jr .return
.fainted
	xor a
.return
	pop hl
	pop de
	pop bc
	ret
ASSERT MOVE_POWER == MOVE_EFFECT + 1 && MOVE_TYPE == MOVE_POWER + 1, "AIScoreSwitchCandidate reads a move's effect, then its power, then its type"

; v1.0 (2026-09-27): carry when this battle's AI list has the switch layer (6).
; Clobbers a, b, hl.
AIHasSwitchLayer:
	call AIGetMoveChoiceList
.loop
	ld a, [hli]
	and a
	ret z ; the end of the list (and `and a` cleared carry): no switch layer
	cp 6 ; the switch layer
	jr nz, .loop
	scf
	ret

; v1.0 (2026-09-27, Forte: "concordo com a tua melhor recomendação"): who
; replaces a fainted Pokemon. A trainer whose AI has the switch layer (6 in its
; list: in Normal the six classes of move_choices.asm, in Hard also every boss
; and semi-boss) picks it the way the layer does, against the Pokemon the
; player has out; everyone else keeps party order, as vanilla does. A double
; KO keeps party order too: the player's replacement has already been chosen
; and sent out (ChooseNextMon runs first in both faint handlers), and picking
; against it would read the player's blind choice. wInHandlePlayerMonFainted =
; 1 marks it (see HandleEnemyMonFainted). Called by farcall from
; ReplaceFaintedEnemyMon just before EnemySendOut, which consumes the request;
; a farcall does not return a, so the answer goes to WRAM.
; Out: wAISwitchRequest = 1 + the party index, or 0 (party order). Clobbers all.
AIPickFaintReplacement:
	xor a
	ld [wAISwitchRequest], a ; party order, unless the pick below names the teammate
	ld a, [wInHandlePlayerMonFainted]
	and a
	ret nz ; a double KO: the player's replacement is already out
	call AIHasSwitchLayer
	ret nc ; not a trainer that thinks about switching: party order
	call AIPickSwitchTarget
	ld [wAISwitchRequest], a
	ret

AIMatchupAtHL:
; a = how effective attacking type a is on the two defender types at hl
; (EFFECTIVE = neutral). Keeps bc, hl.
	push bc
	push hl
	ld d, a
	ld a, [hli]
	ld e, a
	ld c, [hl]
	farcall AITypeMatchup
	ld a, e
	pop hl
	pop bc
	ret

ReadMove:
	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveNum
	call CopyData
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/trainers/move_choices.asm"

INCLUDE "data/trainers/pic_pointers_money.asm"

INCLUDE "data/trainers/names.asm"

INCLUDE "engine/battle/misc.asm"

INCLUDE "engine/battle/read_trainer_party.asm"

INCLUDE "data/trainers/special_moves.asm"

INCLUDE "data/trainers/parties.asm"

TrainerAI:
	and a
	ld a, [wIsInBattle]
	dec a
	ret z ; if not a trainer, we're done here
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z ; if in a link battle, we're done as well
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;shinpokerednote: FIXED: AI should not use actions (items / switching) if in a move that prevents such a thing
; v1.0 (2026-09-27, Forte: "a regra para o oponente deverá ser a mesma pelo qual o
; player se rege"): an item exactly when the player would get the
; battle menu (MainInBattleLoop): never while it must recharge, THRASHes or
; charges a two-turn move (FLY/DIG's INVULNERABLE only exists with CHARGING_UP).
; BIDE, confusion, sleep, a freeze and the player's WRAP do not stop it, as they
; do not stop the player. Its own WRAP does not either - the item costs a turn of
; it, as the player's does (UseBagItem; DecrementAICount here) - except the
; WRAP's LAST turn: there the player's item frees the enemy to act that same
; turn, while the player, held, chose its $ff at the menu before this and could
; not get that turn back. (shinpokered's mask was %01110010: the enemy's own
; WRAP blocked it, stricter than the player.) A SWITCH stays stricter than the
; player's: SelectEnemyMove makes no request in its own BIDE or WRAP, or while
; held and awake, and layer 6 never asks for an asleep or frozen mon (D14) -
; parity there is for Forte to decide.
	and a ; clear carry flag in case we return due to the next checks, we dont want carry returned in those cases as it marks an action as being taken by the opponent (bit / ld / dec keep it clear)
	ld a, [wEnemyBattleStatus2]
	bit NEEDS_TO_RECHARGE, a
	ret nz
	ld hl, wEnemyBattleStatus1
	ld a, [hl]
	and (1 << THRASHING_ABOUT) | (1 << CHARGING_UP)
	ret nz
	bit USING_TRAPPING_MOVE, [hl]
	jr z, .notOwnWrapLastTurn
	ld a, [wEnemyNumAttacksLeft] ; 1-4 at the menu while the bit is set
	dec a
	ret z
.notOwnWrapLastTurn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; v1.0 (2026-09-26, the AI switch layer): the switch layer (6) asked to
; switch this turn; TrainerAI runs before either move (MainInBattleLoop,
; 2026-09-27), so the switch goes first. The request names the teammate (1 + its party index); EnemySendOut
; consumes it when the switch happens, and this hook drops it when it does
; not; a faint replacement never sees it (AIPickFaintReplacement rewrites
; the byte, 0 or its own pick, just before that send-out). An asleep or frozen mon is not pulled (D14, by the status
; only since 2026-09-27); with one mon left there is nothing to switch to,
; and the class AI below runs as usual - its item count is set up there, so
; this path falls through, it never returns. Both cases are belt and braces:
; the layer asks only for an awake mon with a second live mon.
	ld a, [wAISwitchRequest]
	and a
	jr z, .noSwitchRequest
	ld a, [wEnemyMonStatus]
	and (1 << FRZ) | SLP_MASK
	jr nz, .dropSwitchRequest ; asleep or frozen: it stays
	call AISwitchIfEnoughMons
	ret c ; switched (EnemySendOut consumed the request): that was the turn's action
.dropSwitchRequest
	xor a
	ld [wAISwitchRequest], a
.noSwitchRequest
	ld a, [wTrainerClass] ; what trainer class is this?
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerAIPointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [wAICount]
	and a
	ret z ; if no AI uses left, we're done here
	inc hl
	inc a
	jr nz, .getpointer
	dec hl
	ld a, [hli]
	ld [wAICount], a
.getpointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	jp hl

INCLUDE "data/trainers/ai_pointers.asm"

; v1.0 (2026-09-26, the AI switch layer): JugglerAI (a blind 25% switch every
; turn) is gone; JUGGLER dispatches to GenericAI and carries layer 6 in its
; move-choice list, which switches for a reason.

; v0.7 space pass (2026-08-17): BlackbeltAI deleted — the blackbelt row of
; the AI dispatch was repointed to GenericAI long ago, orphaning it.

; (Hard mode boss item bag — knob #10. See ; ===== HARD MODE BOSS AI ===== marker.)

; v1.0 (2026-09-26, the AI switch layer): the Cooltrainers keep vanilla's
; HYPER POTION (a 25% roll, then below 1/10 HP) and lose the blind switch
; that followed it (the same roll, then below 1/5 HP - a free turn for the
; player, no strategy; 2026-09-24 had already put it back to 1/5 from
; Yellow Legacy's "below max HP"). Both classes carry layer 6 in their
; move-choice lists now, which switches for a reason. One routine, two names.
CooltrainerMAI:
CooltrainerFAI:
	cp 25 percent + 1
	ret nc ; 25% chance to act
	ld a, 10
	call AICheckIfHPBelowFraction
	jp c, AIUseHyperPotion
	ret

; ===== HARD MODE BOSS AI =====
;
; v0.7 hard mode knob #10. Each boss AI routine is gated by
; IsHardModeBossOrSemiBattle - a plain same-bank `call`, since hard_mode.asm
; shares bank $0E with this file. This comment said "IsHardModeBossBattle
; (bank $0F farcall)" until 2026-08-18 and was wrong on all three counts: the
; predicate is the boss-OR-SEMI one (all 22 routines call it, and semis carry
; bags too), it is not a farcall, and the bank moved on 2026-08-17. The
; distinction matters now that KIYO is a semi in the dojo and a boss in
; Viridian. In Normal mode, in wild battles,
; or against a non-boss class the gate returns Z=1 and we early-out — same
; behaviour as the previous "and a / ret" stubs.
;
; In Hard mode boss battles the routine consults wEnemyTrainerItemBag (a
; per-battle inventory populated by InitEnemyTrainerItemBag from
; data/trainers/boss_item_bags.asm) via CheckAndConsumeBossItem. Items are
; only used when in the bag AND count > 0; once exhausted the AI silently
; falls through.
;
; Pattern (every boss now also carries Full Heal):
;   1. If statused, try Full Heal (AITryFullHeal).
;   2. Else if HP below threshold (1/3; 1/2 for Giovanni/Oak/Joy/Bill), heal item
;      (a FULL RESTORE cures confusion too, 2026-09-27).
;   3. Else, if only confused and an item action is to spare, try Full Heal
;      (AITryConfusionFullHeal, 2026-09-27: the player may FULL HEAL a mon that
;      is only confused; the enemy plays by the same rule).
;   4. Else, one ~25% roll per buff item (independent rolls).
; Per-battle item caps come from the bag data; per-mon caps still come from
; wAICount/ai_pointers.asm (each AIUse* tail-calls DecrementAICount).

BrockAI:
	call IsHardModeBossOrSemiBattle
	ret z
	; Priority 1: status -> Full Heal (every boss carries it now); confusion alone, after the HP branch
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	; Heal at HP < 1/3 — the rematch bag carries Full Restore, the first
	; fight's carries Potion; try the better tier first (same both ways for
	; every leader below)
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, POTION
	call CheckAndConsumeBossItem
	jp c, AIUsePotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X Defend (rocks defensive)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_DEFEND
	call CheckAndConsumeBossItem
	jp c, AIUseXDefend
	ret

MistyAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X SP.ATK
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPATK
	call CheckAndConsumeBossItem
	jp c, AIUseXSpAtk
	ret

LtSurgeAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X Speed (electric speed)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
	ret

ErikaAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, HYPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X SP.DEF (2026-09-06 table: Erika's bags carry X SP.DEF -
	; her flowers take the hit rather than deal it)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPDEF
	call CheckAndConsumeBossItem
	jp c, AIUseXSpDef
	ret

KogaAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, HYPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X Speed
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
.skipBuff1
	; ~25% chance Dire Hit (independent; both of his bags carry one since the 2026-09-06 table)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, DIRE_HIT
	call CheckAndConsumeBossItem
	jp c, AIUseDireHit
	ret

SabrinaAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, HYPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X SP.ATK (Psychic special attacker)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPATK
	call CheckAndConsumeBossItem
	jp c, AIUseXSpAtk
	ret

BlaineAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, MAX_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseMaxPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X SP.ATK (fire special attacker)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPATK
	call CheckAndConsumeBossItem
	jp c, AIUseXSpAtk
	ret

; Giovanni: heals at HP < 1/2 (boss tier). Two independent buff rolls
; (X Attack + X Defend), each ~25% of un-healed turns.
GiovanniAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, HYPER_POTION ; his early bag (Hideout/Silph) heals a tier below the gym's
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X Attack roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_ATTACK
	call CheckAndConsumeBossItem
	jp c, AIUseXAttack
.skipBuff1
	; ~25% X Defend roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_DEFEND
	call CheckAndConsumeBossItem
	jp c, AIUseXDefend
	ret

; ---- Elite Four + Champion ----

LoreleiAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X SP.ATK roll (2026-09-06 table: she buffs her special attacks, not her Defense)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPATK
	call CheckAndConsumeBossItem
	jp c, AIUseXSpAtk
	ret

BrunoAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_ATTACK
	call CheckAndConsumeBossItem
	jp c, AIUseXAttack
	ret

AgathaAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% chance X Speed
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
	ret

LanceAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X Speed roll (2026-09-06 table: his bag is all speed now; the X Special roll went with it)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
	ret

; ---- Rivals 2 & 3 (Rival1 stays GenericAI -- too early-game) ----

Rival2AI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, HYPER_POTION ; sheet correction 2026-08-17: his bag upgraded from Super
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; no buff roll: the same correction took his X Attacks away, and an AI
	; branch with no item behind it is the mirror image of dead weight
	ret

KiyoAI:
; The dojo master. Full Restore is his rematch tier, Hyper Potion the dojo's;
; the two independent 25% rolls mirror Koga's shape, but his fists buff
; ATTACK and his Dire Hit lives in the rematch bag.
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
	ld a, HYPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X Attack roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_ATTACK
	call CheckAndConsumeBossItem
	jp c, AIUseXAttack
.skipBuff1
	; ~25% Dire Hit roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, DIRE_HIT
	call CheckAndConsumeBossItem
	jp c, AIUseDireHit
	ret

Rival3AI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X Speed roll (2026-09-06 table: speed and a Dire Hit; the X Attack is gone)
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
.skipBuff1
	; ~25% Dire Hit roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, DIRE_HIT
	call CheckAndConsumeBossItem
	jp c, AIUseDireHit
	ret

; ---- Bosses promoted in v0.6 / v0.7 (no vanilla AI body) ----

; Prof Oak: ultimate post-game boss. Heals at HP < 1/2; two buff rolls
; (Guard Spec + Dire Hit).
ProfOakAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% Guard Spec roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, GUARD_SPEC
	call CheckAndConsumeBossItem
	jp c, AIUseGuardSpec
.skipBuff1
	; ~25% Dire Hit roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, DIRE_HIT
	call CheckAndConsumeBossItem
	jp c, AIUseDireHit
	ret

; Joy: nurse-themed. Heals at HP < 1/2 with Full Restore; no buffs (2026-09-06 table).
JoyAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; no buff roll (2026-09-06 table): the nurse heals and nothing else
	ret

; Smith, Craig and Weebra share this one. They are the three post-game
; self-inserts guarding the bird chambers: same tier, same documented bag
; (3x Full Restore), and no reason to behave differently from one another.
; Semi-boss tier, so they heal but carry no stat-boost items - the swing of an
; X Attack is the kind of thing that should stay on the boss side of the line.
SelfInsertBossAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	ret

BillAI:
; He is a researcher, not a competitor, and the items say so: he protects
; (Guard Spec) and he takes his shot when he sees one (Dire Hit), but he never
; drills his team with X Attack or X Speed the way a gym leader would.
;
; The rolls mirror ProfOakAI because Bill carries Oak's bag. That pairing is not
; cosmetic: an item in the bag that no AI branch ever reaches for is dead
; weight, which is precisely how ForteBossBag ended up stocked and never spent.
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% Guard Spec roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, GUARD_SPEC
	call CheckAndConsumeBossItem
	jp c, AIUseGuardSpec
.skipBuff1
	; ~25% Dire Hit roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, DIRE_HIT
	call CheckAndConsumeBossItem
	jp c, AIUseDireHit
	ret

JennyAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X Attack roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_ATTACK
	call CheckAndConsumeBossItem
	jp c, AIUseXAttack
.skipBuff1
	; ~25% X SP.ATK roll (independent; 2026-09-06 table: the Guard Spec of
	; 08-17 became an X SP.ATK)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPATK
	call CheckAndConsumeBossItem
	jp c, AIUseXSpAtk
	ret

JanineAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	; ~25% X Speed roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
.skipBuff1
	; ~25% Guard Spec roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, GUARD_SPEC
	call CheckAndConsumeBossItem
	jp c, AIUseGuardSpec
	ret

JessieAndJamesAI:
	call IsHardModeBossOrSemiBattle
	ret z
	call AITryFullHeal ; a status: FULL HEAL (confusion alone waits for the HP branch)
	jp c, AIUseFullHeal
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
	call AITryConfusionFullHeal ; confusion alone, when an item action is to spare
	jp c, AIUseFullHeal
	ret

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount:
	ld hl, wAICount
	dec [hl]
; v1.0 (2026-09-27): an item used while its own WRAP holds the player costs a
; turn of it, as the player's does (UseBagItem). wEnemyNumAttacksLeft is shared
; with BIDE / THRASH / multi-hit: it is read only behind USING_TRAPPING_MOVE.
; (TrainerAI never lets it happen on the WRAP's last turn; the reset mirrors the
; player's code all the same.)
	ld hl, wEnemyBattleStatus1
	bit USING_TRAPPING_MOVE, [hl]
	jr z, .done
	ld a, [wEnemyNumAttacksLeft]
	dec a
	ld [wEnemyNumAttacksLeft], a
	jr nz, .done
	res USING_TRAPPING_MOVE, [hl]
.done
	scf
	ret

AIPlayRestoringSFX:
	ld a, SFX_HEAL_AILMENT
	jp PlaySoundWaitForCurrent

AIUseFullRestore:
	call AICureStatus
	ld a, FULL_RESTORE
	ld [wAIItem], a
	ld de, wHPBarOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wHPBarMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wHPBarMaxHP+1], a
	ld [wEnemyMonHP], a
	jr AIPrintItemUseAndUpdateHPBar

; Max Potion: fully restores HP but (unlike Full Restore) does NOT cure status.
AIUseMaxPotion:
	ld a, MAX_POTION
	ld [wAIItem], a
	ld de, wHPBarOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wHPBarMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wHPBarMaxHP+1], a
	ld [wEnemyMonHP], a
	jp AIPrintItemUseAndUpdateHPBar

AIUsePotion:
; enemy trainer heals his monster with a potion
	ld a, POTION
	ld b, 20
	jr AIRecoverHP

AIUseSuperPotion:
; enemy trainer heals his monster with a super potion
	ld a, SUPER_POTION
	ld b, 50
	jr AIRecoverHP

AIUseHyperPotion:
; enemy trainer heals his monster with a hyper potion
	ld a, HYPER_POTION
	ld b, 150 ; v0.7 (2026-09-06): 200 -> 150, the same amount the player gets
	; fallthrough

AIRecoverHP:
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [wAIItem], a
	ld hl, wEnemyMonHP + 1
	ld a, [hl]
	ld [wHPBarOldHP], a
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	ld [wHPBarNewHP+1], a
	jr nc, .next
	inc a
	ld [hl], a
	ld [wHPBarNewHP+1], a
.next
	inc hl
	ld a, [hld]
	ld b, a
	ld de, wEnemyMonMaxHP + 1
	ld a, [de]
	dec de
	ld [wHPBarMaxHP], a
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	ld [wHPBarMaxHP+1], a
	sbc b
	jr nc, AIPrintItemUseAndUpdateHPBar
	inc de
	ld a, [de]
	dec de
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [de]
	ld [hl], a
	ld [wHPBarNewHP+1], a
	; fallthrough

AIPrintItemUseAndUpdateHPBar:
	call AIPrintItemUse_
	hlcoord 2, 2
	xor a
	ld [wHPBarType], a
	predef UpdateHPBar2
	jp DecrementAICount

AISwitchIfEnoughMons:
; enemy trainer switches if there are 2 or more unfainted mons in party
	call AICountLiveEnemyMons
	cp 2    ; don't bother if only 1
	jp nc, SwitchEnemyMon
	and a
	ret

AICountLiveEnemyMons:
; v1.0 (2026-09-26, the AI switch layer): the count, on its own, so the
; switch layer asks only when there is someone to switch to.
; a = the unfainted mons in the enemy's party, from the roster's HP (the mon
; that is out counts as it was when it came out). Clobbers bc, d, hl.
	ld a, [wEnemyPartyCount]
	ld c, a
	ld hl, wEnemyMon1HP
	ld d, 0 ; keep count of unfainted monsters
.loop
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .Fainted ; has monster fainted?
	inc d
.Fainted
	push bc
	ld bc, wEnemyMon2 - wEnemyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ld a, d
	ret

SwitchEnemyMon:

; prepare to withdraw the active monster: copy hp, freeze count and status to roster

	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonHP
	ld bc, 4
	call CopyData
; v1.0 (2026-09-27): byte 3 of the roster entry (it just got the party
; position, which nothing reads there) keeps the freeze count, so a frozen mon
; that comes back resumes its own count - wEnemyFreezeCounter is one byte for
; the whole side (LoadEnemyMonData reads it back).
	dec de
	dec de
	ld a, [wEnemyFreezeCounter]
	ld [de], a
; v1.0 (2026-09-26): and its battle MaxHP, so the roster's HP and MaxHP are
; on the same scale once it has been out (a boss's battle MaxHP comes from
; maxed DVs, the roster's from the trainer DVs). LoadEnemyMonData tops a boss
; mon up only when the two are equal - a fresh mon, or one back at full -
; and AIScoreSwitchCandidate's quarter-HP test compares them.
	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1MaxHP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [wEnemyMonMaxHP]
	ld [hli], a
	ld a, [wEnemyMonMaxHP + 1]
	ld [hl], a

; v1.0 (2026-09-26, the AI switch layer): the mon that comes in starts
; fresh - its setup layer counts from zero again (as yumepokered does) and
; the switch layer leaves the newcomer alone for a couple of turns. (The
; player's WRAP needs nothing here: a held enemy never asks to switch -
; SelectEnemyMove hands an awake one $ff before the layers run, and the
; layer never asks for an asleep or frozen one - and EnemySendOutFirstMon
; drops the trapping bit.)
	xor a
	ld [wAILayer2Encouragement], a
	ld a, [AISwitchKnobs.cooldown]
	ld [wAISwitchCooldown], a

	ld hl, AIBattleWithdrawText
	call PrintText

	; This wFirstMonsNotOutYet variable is abused to prevent the player from
	; switching in a new mon in response to this switch.
	ld a, 1
	ld [wFirstMonsNotOutYet], a
	callfar EnemySendOut
	xor a
	ld [wFirstMonsNotOutYet], a

	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	scf
	ret

AIBattleWithdrawText:
	text_far _AIBattleWithdrawText
	text_end

AIUseFullHeal:
	call AIPlayRestoringSFX
	call AICureStatus
	ld a, FULL_HEAL
	jp AIPrintItemUse

AICureStatus:	;shinpokerednote: CHANGED: modified to be more robust and also undo stat changes of brn/par
; cures the status of enemy's active pokemon
	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1Status
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl], a ; clear status in enemy team roster
	ldh a, [hWhoseTurn]
	push af
	ld a, $01 	;forcibly set it to the AI's turn
	ldh [hWhoseTurn], a
	call UndoBurnParStats	;undo brn/par stat changes
	pop af
	ldh [hWhoseTurn], a
	xor a
	ld [wEnemyMonStatus], a ; clear status in active enemy data
; v1.0 (2026-09-27, Forte: "full heal e full restore ambos deverão corrigir o
; confusion status"): confusion goes too, the bit and its count, as with the
; player's two items (item_effects.asm CureConfusionIfFullHealOrRestore). Only
; AIUseFullHeal and AIUseFullRestore come here, so there is no item to test.
; a is still 0. (Every writer of CONFUSED writes a fresh 2-5 count with it; the
; zero is belt and braces, as on the player's side.)
	ld [wEnemyConfusedCounter], a
	ld hl, wEnemyBattleStatus1
	res CONFUSED, [hl]
	ld hl, wEnemyBattleStatus3
	res BADLY_POISONED, [hl]	;clear toxic bit
	ret

AIUseGuardSpec:
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set 1, [hl]
	ld a, GUARD_SPEC
	jp AIPrintItemUse

AIUseDireHit:
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set 2, [hl]
	ld a, DIRE_HIT
	jp AIPrintItemUse

; v0.7 space pass (2026-08-17): AICheckIfHPBelowFractionStore deleted — a
; PureRGB import for a "hyper ball" item this hack never adopted; zero
; callers, and Forte confirmed it is not his.

AICheckIfHPBelowFractionWrapped:
	push hl
	push bc
	push de
	call AICheckIfHPBelowFraction
	pop de
	pop bc
	pop hl
	ret

AICheckIfHPBelowFraction:
; return carry if enemy trainer's current HP is below 1 / a of the maximum
	ldh [hDivisor], a
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 3]
	ld c, a
	ldh a, [hQuotient + 2]
	ld b, a
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

AIUseXAttack:
	ld b, ATTACK_UP1_EFFECT
	ld a, X_ATTACK
	jr AIIncreaseStat

AIUseXDefend:
	ld b, DEFENSE_UP1_EFFECT
	ld a, X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed:
	ld b, SPEED_UP1_EFFECT
	ld a, X_SPEED
	jr AIIncreaseStat

AIUseXSpAtk:
	ld b, SPATK_UP1_EFFECT
	ld a, X_SPATK
	jr AIIncreaseStat

AIUseXSpDef:
; The split: SP.DEF has no ladder id. b carries the SP.ATK proxy (NEVER an
; SP.DEF id: AIIncreaseStat writes b raw into wEnemyMoveEffect and the ladder
; arithmetic would run off the mods array) and the override carries the index.
	ld a, MOD_SPDEF + 1
	ld [wStatModIndexOverride], a
	ld b, SPATK_UP1_EFFECT
	ld a, X_SPDEF
	; fallthrough

AIIncreaseStat:
	ld [wAIItem], a
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl, wEnemyMoveEffect
	ld a, [hld]
	push af
	ld a, [hl]
	push af
	push hl
; v0.7 anim split: same borrow as the player's X item - the marker goes
; into wEnemyMoveNum, the real index parks in hSpecialAnimIndex.
	ld a, XSTATITEM_DUPLICATE_ANIM
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [hli], a
	ld [hl], b
	xor a
	ld [wMoveDidntMiss], a ; v0.7: clear the stale flag so the anim guard
	                       ; doesn't eat XSTATITEM_DUPLICATE_ANIM
	callfar StatModifierUpEffect
	pop hl
	pop af
	ld [hli], a
	pop af
	ld [hl], a
	jp DecrementAICount

AIPrintItemUse:
	ld [wAIItem], a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_:
; print "x used [wAIItem] on z!"
	ld a, [wAIItem]
	ld [wd11e], a
	call GetItemName
	ld hl, AIBattleUseItemText
	jp PrintText

AIBattleUseItemText:
	text_far _AIBattleUseItemText
	text_end

;;;;;;;;;; PureRGBnote: ADDED: these wram properties are used to make sure the 
;;;;;;;;;;                     AI doesn't instantly read the player's current pokemon type after a player switches.
;;;;;;;;;;                     makes sure the AI doesn't appear to predict all your switch-outs of pokemon.
StoreBattleMonTypes:
	push hl
	ld hl, wBattleMonType
	ld a, [hl] ; type 1 of player's pokemon -> wAITargetMonType1 (line 1717: type 2 -> wAITargetMonType2)
	ld [wAITargetMonType1], a
	inc hl
	ld a, [hl]                 ; c = type 2 of player's pokemon
	ld [wAITargetMonType2], a
	pop hl
	ret

; Used by the pureRGB AI
;shinpokerednote: ADDED: doubles attack if burned or doubles speed if paralyzed.
;It's meant to be run right before healing paralysis or burn so as to
;undo the stat changes.
;v0.7: paralysis speed penalty changed /4 -> /2 (HalveSpeedDueToParalysis),
;so the undo doubles speed ONCE now. The old double-double restored 4x and
;left a cured enemy at twice its real speed.
UndoBurnParStats:
	ld hl, wBattleMonStatus
	ld de, wPlayerStatsToDouble
	ldh a, [hWhoseTurn]
	and a
	jr z, .checkburn
	ld hl, wEnemyMonStatus
	ld de, wEnemyStatsToDouble
.checkburn
	ld a, [hl]		;load statuses
	and 1 << BRN	;test for burn 
	jr z, .checkpar
	ld a, $01
	ld [de], a	;set attack to be doubled to undo the stat change of BRN
	call DoubleSelectedStats
	jr .return
.checkpar
	ld a, [hl]		;load statuses
	and 1 << PAR	;test for paralyze 
	jr z, .return
	ld a, $04
	ld [de], a	;set speed to be doubled (once) to undo the /2 stat change of PAR
	call DoubleSelectedStats
.return
	xor a
	ld [de], a	;reset the stat change bits
	ret


; ===== HARD MODE BOSS ITEM BAG HELPERS (knob #10) =====
;
; Per-battle item inventory for boss trainers. The bag (wEnemyTrainerItemBag,
; BOSS_BAG_SIZE bytes in wMiscBattleData) holds (item_id, count) pairs
; padded with -1. Populated once per battle by InitEnemyTrainerItemBag from
; data/trainers/boss_item_bags.asm. Boss AI routines call
; CheckAndConsumeBossItem before each AIUse*; if the bag is empty for that
; item, the AI silently no-ops.

; v1.0 (2026-09-27): the boss / semi-boss FULL HEAL, in two halves.
; AITryFullHeal (first in every routine): a status, always, as before.
; AITryConfusionFullHeal (after the HP branch - below its line a FULL RESTORE
; cures the confusion AND the HP in one action): confusion alone, as the player
; may (CheckCanCureConfusion), but never with this mon's LAST item action
; (wAICount 1): confusion wears off by itself, and that action is kept for its
; HP. It reads what a trainer sees - the status, the CNF on its HUD - never the
; hidden confusion count. The switch layer decided first (TrainerAI honours its
; request before the class routine), so a switch never costs a FULL HEAL.
; Out: carry = a FULL HEAL was in the bag and is now spent. Trashes a, b, c, hl;
; keeps de.
AITryConfusionFullHeal:
	ld a, [wEnemyBattleStatus1]
	and 1 << CONFUSED ; carry clear from here to both rets
	ret z
	ld a, [wAICount] ; 1-3 here (TrainerAI returned at 0)
	dec a
	ret z
	jr AISpendFullHeal
AITryFullHeal:
	ld a, [wEnemyMonStatus]
	and a
	ret z
AISpendFullHeal:
	ld a, FULL_HEAL
	jp CheckAndConsumeBossItem

; Walk the bag looking for item_id in `a`. If found AND count > 0,
; decrement count and return carry. Otherwise clear carry.
;
; Loop is bounded by BOSS_BAG_SIZE / 2 pair iterations — defensive against
; an uninitialised bag (e.g. wMiscBattleData zeroed but InitEnemyTrainerItem
; Bag never ran). Today every caller is gated by IsHardModeBossBattle and
; the init runs before any AI tick, but the bound is cheap insurance.
;
; Sentinel value -1 ($FF) for the item_id slot marks the end of the bag.
; This collides numerically with TM55 ($C9 + 54 = $FF) but TMs are not
; AI-usable items (no AIUse* handler exists for them), so adding a TM to
; a boss bag would already be broken upstream. Don't.
;
; Input:   a = item_id to consume
; Output:  carry = 1 → item was available and is now consumed
;          carry = 0 → item not in bag, or in bag with 0 count
; Trashes: a, b, c, hl
CheckAndConsumeBossItem:
	ld b, a
	ld hl, wEnemyTrainerItemBag
	ld c, BOSS_BAG_SIZE / 2     ; max pair iterations
.loop
	ld a, [hl]
	cp -1
	jr z, .notFound             ; sentinel reached → item not in this bag
	cp b
	jr z, .foundItem
	inc hl                      ; skip past item_id
	inc hl                      ; skip past count
	dec c
	jr nz, .loop
	jr .notFound                ; walked entire bag without match
.foundItem
	inc hl                      ; hl → count byte
	ld a, [hl]
	and a
	jr z, .notFound             ; in bag but already exhausted
	dec [hl]                    ; consume one
	scf
	ret
.notFound
	and a                       ; clear carry
	ret

; InitEnemyTrainerItemBag moved to data/trainers/boss_item_bags.asm
; (2026-08-17): the bags went per-FIGHT and the loader lives with the data it
; scans, in its own floating section. CheckAndConsumeBossItem stays here —
; the AI routines call it locally and it only reads the WRAM bag.

; --- v0.7 victory-fanfare list (relocated out of Battle Core) ---
; This lives HERE, in the Trainer AI bank, purely for space: Battle Core ($0F)
; is at its 16 KB limit and this is cold code — it runs once, when a trainer is
; defeated. TrainerBattleVictory reaches it with `farcall`. Safe across the
; bankswitch because it takes no argument in `a` (it reads wTrainerClass
; itself) and the caller only relies on the returned Z flag, the same contract
; IsBossTrainerClassW already uses from read_trainer_party.asm.

; v0.7 music review: trainer classes that earn the "big" victory fanfare
; (MUSIC_DEFEATED_GYM_LEADER) instead of the normal one. Read by
; TrainerBattleVictory, which used to key on wGymLeaderNo alone — that gave
; the grand fanfare only to the 8 leaders' FIRST fights and left the Elite
; Four, Oak and the leader rematches on the plain trainer jingle.
;
; This is a MUSIC list, deliberately independent of BossTrainerClasses: it
; includes the hand-calibrated semi-bosses (Jessie & James, Janine, Joy,
; Jenny, Smith, Craig, Weebra) and excludes RIVAL1/RIVAL2, so the rival
; fanfare escalates — only the Champion fight (RIVAL3) sounds grand.
; Order doesn't matter (linear scan). Terminator is -1.
GrandVictoryClasses::
; the badge holders (covers their rematches too, same class); Kiyo holds
; Viridian post-League, so his wins — dojo included — sound grand too
	db BROCK
	db MISTY
	db LT_SURGE
	db ERIKA
	db KOGA
	db SABRINA
	db BLAINE
	db GIOVANNI
	db KIYO
; the Elite Four and the Champion
	db LORELEI
	db BRUNO
	db AGATHA
	db LANCE
	db RIVAL3
; the post-game superbosses
	db PROF_OAK
	db FORTE
; the semi-bosses
	db JESSIE_AND_JAMES
	db JANINE
	db JOY
	db JENNY
	db BILL
	db SMITH
	db CRAIG
	db WEEBRA
	db -1                       ; terminator

; Returns Z=0 if the current trainer earns the grand victory fanfare, else
; Z=1. Reads wTrainerClass. Trashes: a, b, hl.
IsGrandVictoryClass::
	ld a, [wTrainerClass]
	ld b, a
	ld hl, GrandVictoryClasses
.loop
	ld a, [hli]
	cp -1
	ret z                       ; reached terminator → Z=1, normal fanfare
	cp b
	jr nz, .loop
	or a                        ; match: class ID is non-zero → Z=0
	ret
