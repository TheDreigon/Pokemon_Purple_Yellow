; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
	ld a, $a
	ld hl, wBuffer ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
	
;;;;;;;;;; shinpokerednote: ADDED: make a backup buffer
	push hl
	ld a, $ff
	inc hl
	ld [hli], a	;backup 1
	ld [hli], a	;backup 2
	ld [hli], a	;backup 3
	ld [hl], a	;backup 4
	pop hl
;;;;;;;;;;

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
	; v0.7 hard mode: boss trainers get all 4 AI modification layers,
	; overriding their per-class list. So Brock (whose normal list is
	; just [1]) becomes as smart as Lance ([1,2,3,4]) on Hard.
	push hl
	call IsHardModeBossOrSemiBattle ; semi-bosses think as hard as bosses do
	pop hl
	jr z, .skipBossAIOverride
	ld hl, HardModeBossAIMods
.skipBossAIOverride
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
.loopFindMinimumEntries_backupfirst	;shinpokerednote: ADDED: make a backup of the scores
	ld hl, wBuffer  ; temp move selection array
	ld de, wBuffer + NUM_MOVES  ;backup buffer
	ld bc, NUM_MOVES
	call CopyData
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

; v0.7 hard mode override list — bosses get all 4 modification layers
; in Hard mode, regardless of their per-class default in
; TrainerClassMoveChoiceModifications. See AIEnemyTrainerChooseMoves
; (.readTrainerClassData) for the redirect.
HardModeBossAIMods:
	db 1, 2, 3, 4, 0

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
	ld a, [wEnemyMoveNum]
	cp SOFTBOILED
	jr nz, .fullHealthDiscourage
	ld a, [wEnemyMonStatus]
	and a
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
	ld a, [wPlayerLastSelectedMove]
	and a
	jp z, .discourage ; don't use mirror move if the player has never selected a move yet
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
	db SPECIAL_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPECIAL_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPECIAL_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPECIAL_DOWN2_EFFECT
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
	db SPECIAL_UP1_HEAL_EFFECT       ; Growth (revised: SPC up + heal 1/4)
	db ACCURACY_EVASION_DOWN1_EFFECT ; Flash (target dual-down)
	db SPECIAL_SPEED_DOWN1_EFFECT    ; Eerie Impulse (target dual-down)
	db SPECIAL_ACCURACY_UP1_EFFECT   ; Calm Mind (revised: SPC + ACC up)
	db SPECIAL_SPEED_UP1_EFFECT      ; Quiver Dance (user dual-up)
	db SPEED_EVASION_DOWN1_EFFECT    ; Psychic Bind (target dual-down)
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
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .betterMoveFound ; any special damage moves are considered to be better moves
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
	ld a, [wEnemyMoveNum]
	cp SOFTBOILED
	jr nz, .nextMove
	ld a, [wEnemyMonStatus]
	and a
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
	and a ; clear carry flag in case we return due to the next two checks, we dont want carry returned in those cases as it marks an action as being taken by the opponent.
	ld a, [wEnemyBattleStatus2]
	bit NEEDS_TO_RECHARGE, a
	ret nz
	ld a, [wEnemyBattleStatus1]
	and %01110010 
	ret nz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

JugglerAI:
	cp 25 percent + 1
	ret nc
	jp AISwitchIfEnoughMons

; v0.7 space pass (2026-08-17): BlackbeltAI deleted — the blackbelt row of
; the AI dispatch was repointed to GenericAI long ago, orphaning it.

; (Hard mode boss item bag — knob #10. See ; ===== HARD MODE BOSS AI ===== marker.)

CooltrainerMAI:
	cp 25 percent + 1
	ret nc ; 25% chance to switch
	ld a, 10
	call AICheckIfHPBelowFraction
	jp c, AIUseHyperPotion
	ld a, 1
	call AICheckIfHPBelowFraction
	ret nc
	jp AISwitchIfEnoughMons

CooltrainerFAI:
	cp 25 percent + 1
	ret nc ; 25% chance to switch
	ld a, 10
	call AICheckIfHPBelowFraction
	jp c, AIUseHyperPotion
	ld a, 1
	call AICheckIfHPBelowFraction
	ret nc
	jp AISwitchIfEnoughMons

; ===== HARD MODE BOSS AI =====
;
; v0.7 hard mode knob #10. Each boss AI routine is gated by
; IsHardModeBossBattle (bank $0F farcall). In Normal mode, in wild battles,
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
;   1. If statused, try Full Heal.
;   2. Else if HP below threshold (1/3; 1/2 for Giovanni/Oak/Joy), heal item.
;   3. Else, one ~25% roll per buff item (independent rolls).
; Per-battle item caps come from the bag data; per-mon caps still come from
; wAICount/ai_pointers.asm (each AIUse* tail-calls DecrementAICount).

BrockAI:
	call IsHardModeBossOrSemiBattle
	ret z
	; Priority 1: status -> Full Heal (every boss carries it now)
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	; ~25% chance X Special
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPECIAL
	call CheckAndConsumeBossItem
	jp c, AIUseXSpecial
	ret

LtSurgeAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	; ~25% chance X Special (2026-08-17 sheet correction: Erika buffs
	; SPECIAL now, both bags — the X Defend branch matched her old bag)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPECIAL
	call CheckAndConsumeBossItem
	jp c, AIUseXSpecial
	ret

KogaAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	; ~25% chance X Speed
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
.skipBuff1
	; ~25% chance Dire Hit (independent; the Dire Hit lives in his rematch bag now)
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	; ~25% chance X Special (Psychic special attacker)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPECIAL
	call CheckAndConsumeBossItem
	jp c, AIUseXSpecial
	ret

BlaineAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	; ~25% chance X Special (fire special attacker)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPECIAL
	call CheckAndConsumeBossItem
	jp c, AIUseXSpecial
	ret

; Giovanni: heals at HP < 1/2 (boss tier). Two independent buff rolls
; (X Attack + X Defend), each ~25% of un-healed turns.
GiovanniAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_DEFEND
	call CheckAndConsumeBossItem
	jp c, AIUseXDefend
	ret

BrunoAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	; ~25% X Special roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_SPECIAL
	call CheckAndConsumeBossItem
	jp c, AIUseXSpecial
.skipBuff1
	; ~25% X Speed roll (independent)
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, HYPER_POTION ; sheet correction 2026-08-17: his bag upgraded from Super
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	; no buff roll: the same correction took his X Attacks away, and an AI
	; branch with no item behind it is the mirror image of dead weight
	ret

KiyoAI:
; The dojo master. Full Restore is his rematch tier, Hyper Potion the dojo's;
; the two independent 25% rolls mirror Koga's shape, but his fists buff
; ATTACK and his Dire Hit lives in the rematch bag.
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	; ~25% X Attack roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_ATTACK
	call CheckAndConsumeBossItem
	jp c, AIUseXAttack
.skipBuff1
	; ~25% X Speed roll (independent)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_SPEED
	call CheckAndConsumeBossItem
	jp c, AIUseXSpeed
	ret

; ---- Bosses promoted in v0.6 / v0.7 (no vanilla AI body) ----

; Prof Oak: ultimate post-game boss. Heals at HP < 1/2; two buff rolls
; (Guard Spec + Dire Hit).
ProfOakAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
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

; Joy: nurse-themed. Heals at HP < 1/2 with Full Restore; X Defend buff.
JoyAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call Random
	cp 25 percent + 1
	ret nc
	ld a, X_DEFEND
	call CheckAndConsumeBossItem
	jp c, AIUseXDefend
	ret

; Smith, Craig and Weebra share this one. They are the three post-game
; self-inserts guarding the bird chambers: same tier, same documented bag
; (3x Full Restore), and no reason to behave differently from one another.
; Semi-boss tier, so they heal but carry no stat-boost items - the swing of an
; X Attack is the kind of thing that should stay on the boss side of the line.
SelfInsertBossAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	ret nc
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	; ~25% X Attack roll
	call Random
	cp 25 percent + 1
	jr nc, .skipBuff1
	ld a, X_ATTACK
	call CheckAndConsumeBossItem
	jp c, AIUseXAttack
.skipBuff1
	; ~25% Guard Spec roll (independent; sheet correction 2026-08-17 — her
	; X Speed became a Guard Spec)
	call Random
	cp 25 percent + 1
	ret nc
	ld a, GUARD_SPEC
	call CheckAndConsumeBossItem
	jp c, AIUseGuardSpec
	ret

JanineAI:
	call IsHardModeBossOrSemiBattle
	ret z
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
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
	ld a, [wEnemyMonStatus]
	and a
	jr z, .noStatus
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
.noStatus
	ld a, 3
	call AICheckIfHPBelowFraction
	ret nc
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
	ret

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount:
	ld hl, wAICount
	dec [hl]
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
	ld b, 200
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
	ld a, [wEnemyPartyCount]
	ld c, a
	ld hl, wEnemyMon1HP

	ld d, 0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
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

	ld a, d ; how many available monsters are there?
	cp 2    ; don't bother if only 1
	jp nc, SwitchEnemyMon
	and a
	ret

SwitchEnemyMon:

; prepare to withdraw the active monster: copy hp, number, and status to roster

	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonHP
	ld bc, 4
	call CopyData

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
	ld b, $A
	ld a, X_ATTACK
	jr AIIncreaseStat

AIUseXDefend:
	ld b, $B
	ld a, X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed:
	ld b, $C
	ld a, X_SPEED
	jr AIIncreaseStat

AIUseXSpecial:
	ld b, $D
	ld a, X_SPECIAL
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
	ld a, XSTATITEM_DUPLICATE_ANIM
	ld [hli], a
	ld [hl], b
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
