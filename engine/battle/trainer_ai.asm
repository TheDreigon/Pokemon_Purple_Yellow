; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
; v1.0 (2026-09-26, P1 of the AI switch layer): the shinpokered "score backup"
; (wBuffer+4..7 filled with $ff here and copied to by a
; .loopFindMinimumEntries_backupfirst label nothing jumped to) is gone: 21 bytes
; that no reader ever used.
	call AISeedMoveScores ; $a, or $50 for a move it cannot use this turn (N3-6)
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
; v1.0 (E4, 2026-09-29): the pureRGB "spam avoider" zeroed wAIMoveSpamAvoider and
; wAITargetMonStatus here. Nothing ever stored anything else in them (and WRAM is cleared at
; boot), so every test of them (layers 1, 3 and 4, CheckSeeded, CheckStatusImmunity) was dead, and so were wAITargetMonType1/2,
; read only behind one of those tests. The code went; the four WRAM bytes stay where they are.
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
; v1.0 (D15, 2026-09-29): and a stat-up move that would raise nothing - every stat it raises
; already at +6 or at 999 (.checkRaise). Every class list starts with this layer
; (data/trainers/move_choices.asm; Hard's HardModeBossAIMods too): every trainer gets it.
; v1.0 (E4, 2026-09-29; Forte: "sigo a tua melhor recomendacao"): two tiers. A move the engine
; would refuse against what the trainer sees, and that only a deliberate act of the player (a
; switch, a cure, its own REST) could turn around before it runs, is USELESS (.useless, the tier
; of a refused raise): DREAM EATER on a Pokemon that is not asleep (MoveHitTest); LEECH SEED on
; one already seeded or GRASS (LeechSeedEffect_); FOCUS ENERGY while pumped with its ACCURACY at +6
; (FocusEnergyEffect_, F2: pumped, it still raises ACCURACY);
; MIST, REFLECT or LIGHT SCREEN already up (MistEffect_, ReflectLightScreenEffect_ - no move
; carries HAZE_EFFECT, so only the enemy's own switch takes them down); a status move on a type
; immune to it (CheckStatusImmunity) or on a Pokemon with a POISON, a BURN or a PARALYSIS (every
; status handler refuses a statused target, and those three never wear off by themselves). A
; move the ordinary course of the turn may still let act is only DISCOURAGED (+5, .discourage):
; DISABLE while a move of the player's is disabled and a confusion move on a confused Pokemon
; (both counts are hidden and run down in its own turn, CheckPlayerStatusConditions); a status
; move on one asleep or frozen (it may wake or thaw in its turn, before this move runs) or on a
; statused one that must recharge (SleepEffect puts it to sleep whatever its status); RECOVER,
; SOFTBOILED or REST at full HP (a hit taken first makes them heal); MIRROR MOVE with nothing to
; copy (the player's move, if it goes first, gives it one).
; v1.0 (E2, 2026-09-29; Forte: "sigo a tua melhor recomendacao"): and the mirror of D15 for the
; moves that lower the player's stats - useless behind the player's SUBSTITUTE or MIST, or when
; every stat it lowers is already at -6 (not a move whose flinch still rolls there: INTIMIDATE,
; SCARY FACE, METAL SOUND, SCREECH, HINDER, TICKLE; FIERCE ROAR only when its own ATTACK raise is
; refused too) (.checkRaise, AIPlayerLowerRefused).
; v1.0 (F5, 2026-09-30; Forte: "okay, sendo assim, a AI tem que passar a saber. corrige."): and the
; player's SUBSTITUTE (on screen): behind it DREAM EATER and the DRAIN moves miss (MoveHitTest), and
; POISON, BURN and CONFUSION fail (PoisonEffect, BurnEffect, ConfusionEffect test it first) - all
; useless (.checkSubstitute, .checkConfused, CheckStatusImmunity), as E2's lowering moves already
; were. SLEEP, PARALYZE, LEECH SEED, DISABLE, MIMIC and TRANSFORM do not test it and still land.
; v1.0 (R8, 2026-09-30; Forte: "concordo contigo, isto é algo a ser corrigido."): and the
; trainer's own SUBSTITUTE, which SubstituteEffect_ refuses with its doll already up, and with its
; HP at or below a quarter of its max HP (the cost; at exactly the cost too, since 2026-09-24)
; (.checkOwnSubstitute): USELESS at or below the cost, which nothing the player does can raise -
; only DISCOURAGED there with the player SEEDED (its drain, when the player moves first, heals the
; enemy before this move); DISCOURAGED with its doll already up (a hit taken first may break it,
; as RECOVER at full HP).
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
	cp DRAIN_HP_EFFECT ; v1.0 (F5): damaging, so it is caught before the power gate
	jp z, .checkSubstitute
	ld a, [wEnemyMovePower]
	and a
	jr nz, .nextMove
	ld a, [wEnemyMoveEffect]
	cp DISABLE_EFFECT
	jr z, .checkDisabled
	cp LEECH_SEED_EFFECT
	jp z, .checkSeeded
	cp FOCUS_ENERGY_EFFECT
	jr z, .checkFocusEnergy ; v1.0 (F2)
	cp LIGHT_SCREEN_EFFECT
	ld c, 1 << HAS_LIGHT_SCREEN_UP ; v1.0 (E4): c = the enemy's own flag its handler tests (ld keeps the flags; c is free here)
	jr z, .checkOwnStatus3
	cp REFLECT_EFFECT
	ld c, 1 << HAS_REFLECT_UP
	jr z, .checkOwnStatus3
	cp MIST_EFFECT ; no move carries it today (the handler is kept): for a restored MIST
	ld c, 1 << PROTECTED_BY_MIST
	jr z, .checkOwnStatus2
	cp SUBSTITUTE_EFFECT ; v1.0 (R8): its own doll up, or its HP too low to pay for one
	jr z, .checkOwnSubstitute
	cp CONFUSION_EFFECT
	jp z, .checkConfused
	cp HEAL_EFFECT
	jp z, .checkFullHealth
	cp MIRROR_MOVE_EFFECT
	jp z, .checkNoMirrorMoveOnFirstTurn
	push hl ; (a still holds the effect: cp keeps it)
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jp nc, .checkRaise ; v1.0 (D15): not a status move - one that would do nothing? (E4: a jr would reach now; the jp stays, emu_test_ai_stat_limits S2 reads these 3 bytes)
.checkStatusImmunity
	call CheckStatusImmunity
	jr c, .useless ; refused before its status test: a type immune to it (E4) or, POISON / BURN, a SUBSTITUTE (F5)
	ld a, [wBattleMonStatus]
	and a
	jr z, .nextMove ; no status: nothing refuses it
	and (1 << PSN) | (1 << BRN) | (1 << PAR)
	jr z, .discourage ; asleep or frozen: it may wake or thaw in its own turn, before this move runs
	ld a, [wPlayerBattleStatus2]
	bit NEEDS_TO_RECHARGE, a
	jr z, .useless ; a POISON, a BURN or a PARALYSIS stays, and every status handler refuses it (E4)
	; it must recharge: SleepEffect puts it to sleep whatever its status - for that one turn every
	; status move stays at +5 (the other three would still fail: a turn on the safe side)
.discourage
	ld a, [hl]
	add $5 ; heavily discourage move
	ld [hl], a
	jr .toNextMove ; v1.0 (R8): forward, through .useless's jp - since .checkOwnSubstitute's dispatch a jr
	; back to .nextMove would reach exactly -128, the limit (0 B, the same scores)
; v1.0 (D15, 2026-09-29; Forte: "o AI tem que ter inteligencia para saber que +6 e 999 sao os
; limites"): a stat-up move that would raise nothing - every stat it raises already at +6, or
; at 999 (AIEnemyRaiseRefused) - is useless; v1.0 (E4): so is every move the rules above and
; below find the engine would surely refuse. .useless scores it AI_SCORE_USELESS: above every
; move the enemy can use to some effect, below every move it cannot use at all
; (AISeedMoveScores' $50: the disabled one, one with no PP left). The chooser then never keeps
; it while another move can act, never keeps an unusable move over it (that would STRUGGLE with
; a move it may use), and with only such moves left it uses one, as the player would have to.
; Layer 6 counts it as discouraged (11 or more). Whatever the other layers add or take (-10..+20;
; DREAM EATER, a damaging move, meets layers 3 and 5 too), the three tiers never meet.
DEF AI_SCORE_USELESS EQU $30
ASSERT AI_SCORE_USELESS - 10 > $a + 20 && AI_SCORE_USELESS + 20 < $50 - 10, \
	"a useless move must rank between every usable move ($a, -10..+20) and every unusable one ($50)"
.checkFocusEnergy ; v1.0 (F2): pumped, FOCUS ENERGY still raises ACCURACY (FocusEnergyEffect_), so it is
; wasted only when ACCURACY is at +6 too: AIRaiseEffectStats' FOCUS ENERGY row, asked below. Not pumped,
; the pump itself is never wasted.
	ld a, [wEnemyBattleStatus2]
	bit GETTING_PUMPED, a
	jp z, .nextMove
	; fall through: pumped
.checkRaise
	call AIEnemyRaiseRefused ; carry: every stat it raises is at its limit
	call nc, AIPlayerLowerRefused ; v1.0 (E2): carry: nothing it lowers would fall
	jp nc, .nextMove
.useless
	ld a, [hl]
	add AI_SCORE_USELESS - $a
	ld [hl], a
.toNextMove ; v1.0 (R8): .discourage's way back too
	jp .nextMove
.checkDisabled
	ld a, [wPlayerDisabledMove] ; non-zero if the player has a disabled move
	and a
	jp z, .nextMove ; if it's zero don't do anything
	jr .discourage ; otherwise discourage using disable while opponent is disabled already
.checkOwnStatus3 ; v1.0 (E4): LIGHT SCREEN, REFLECT - c = the bit its handler tests
	ld a, [wEnemyBattleStatus3]
	jr .checkOwnBit
.checkOwnStatus2 ; MIST (FOCUS ENERGY left for .checkFocusEnergy, F2)
	ld a, [wEnemyBattleStatus2]
.checkOwnBit
	and c
	jr nz, .useless ; already up: its handler fails, and only the enemy's own switch clears it
	jp .nextMove
.checkOwnSubstitute ; v1.0 (R8): SubstituteEffect_'s two refusals, on the trainer's own Pokemon
	ld a, 4
	call AICheckIfHPBelowFractionWrapped ; carry: HP below max HP / 4, Z: equal to it (keeps bc, de, hl)
	jr c, .ownSubstituteTooWeak
	jr z, .ownSubstituteTooWeak ; exactly the cost is "Too weak" too (2026-09-24: no 0-HP user)
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .discourage ; its doll is up: it fails unless a hit taken first breaks the doll (E4: as RECOVER at full HP)
	jp .nextMove
.ownSubstituteTooWeak ; the HP decides over the doll: a broken doll would leave the HP as low
	ld a, [wPlayerBattleStatus2]
	bit SEEDED, a
	jr nz, .discourage ; the player's LEECH SEED drain, when the player moves first, heals the enemy before this move
	jr .useless ; "Too weak to make a SUBSTITUTE!", whatever else the player does
.checkAsleep
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .useless ; not asleep: DREAM EATER misses (MoveHitTest) - only the player's own REST, first, would change that
	; asleep: it still misses behind a SUBSTITUTE
.checkSubstitute ; v1.0 (F5): DREAM EATER and the DRAIN moves miss behind the player's SUBSTITUTE (MoveHitTest)
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .useless
	jp .nextMove
.checkConfused
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .useless ; v1.0 (F5): ConfusionEffect refuses a SUBSTITUTE before anything else
	ld a, [wPlayerBattleStatus1]
	bit CONFUSED, a
	jr nz, .discourage ; if the player is confused, don't use confusion-inflicting moves
	jp .nextMove
.checkSeeded ; v1.0 (E4): LeechSeedEffect_'s two refusals, here (CheckSeeded went)
	ld a, [wPlayerBattleStatus2]
	bit SEEDED, a
	jr nz, .useless ; already seeded
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .useless ; LEECH SEED does not affect a GRASS type
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .useless
	jp .nextMove
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
	; v1.0 (E4, 2026-09-29): RECOVER too. It has cured the user's status since 2026-09-08
	; (HealEffect_ .fullHPCureOnly: RECOVER and SOFTBOILED cure at full HP, REST fails there);
	; this test had kept SOFTBOILED alone. HEAL_EFFECT's moves are RECOVER, REST and SOFTBOILED.
	ld a, [wEnemyMoveNum]
	cp REST
	jr z, .fullHealthDiscourage
	ld a, [wEnemyMonStatus]
	and (1 << PSN) | (1 << BRN) | (1 << PAR)
	jr z, .fullHealthDiscourage
	pop de
	pop hl
	jp .nextMove ; statused: RECOVER or SOFTBOILED is worth using as a FULL HEAL
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

;;;;;;;;;; PureRGBnote: ADDED: function for checking if the player's pokemon is unaffected by specific status moves.

CheckStatusImmunity:
; v0.7: statuses can have TWO immune defender types — checked via the b/c
; pair (when only one applies, b == c). Mirrors the engine-side immunities
; in effects.asm (burn: FIRE/MAGMA; poison: POISON/STEEL; paralyze:
; ELECTRIC always, plus GROUND vs Electric-sourced paralysis).
; v1.0 (F5, 2026-09-30; Forte: "okay, sendo assim, a AI tem que passar a saber. corrige."): carry
; also when POISON or BURN meets the player's SUBSTITUTE - PoisonEffect and BurnEffect test it
; before anything else (the target's status, its types). SLEEP (SleepEffect) and PARALYZE
; (ParalyzeEffect_) do not test it: they land through a SUBSTITUTE, as in Gen 1. Carry = the
; handler refuses the move before it looks at the target's status.
	push bc
	push hl
	ld a, [wEnemyMoveEffect]
	cp POISON_EFFECT
	ld b, POISON
	ld c, STEEL ; v0.7: Steel-types can't be poisoned either
	jr z, .substituteFirst ; v1.0 (F5)
	cp PARALYZE_EFFECT
	jr z, .checkParalyze
	ld b, FIRE
	ld c, MAGMA ; burn immunity: Fire/Magma types
	cp BURN_EFFECT ; only Will-O-Wisp/Ignite reach here — damaging burn moves
	               ; (Fire Blast/Lava Plume) are power-gated out before this
	jr nz, .done
.substituteFirst ; v1.0 (F5): POISON (from above) and BURN
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .discourage ; carry: the SUBSTITUTE refuses it
	jr .getMonTypes
.checkParalyze
	ld b, ELECTRIC ; v0.7: Electric-types can't be paralyzed at all
	ld c, ELECTRIC
	ld a, [wEnemyMoveType]
	cp ELECTRIC
	jr nz, .getMonTypes
	ld c, GROUND ; Ground is immune to the whole Electric move (incl. paralysis)
.getMonTypes
	ld hl, wBattleMonType1 ; v1.0 (E4): the player's types as they are (the pureRGB switch-out path read a byte nothing sets)
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

; v1.0 (D15, 2026-09-29; Forte: "o AI tem que ter inteligencia para saber que +6 e 999 sao os
; limites"): carry when the enemy's stat-up move (wEnemyMoveEffect) would raise nothing:
; StatModifierUpEffect would refuse every stat it raises (AIEnemyStatMaxed), and GROWTH, which
; also heals, only at full HP (AttackSpAtkUp1HealEffect heals below it). Only the effects of
; AIRaiseEffectStats count; layer 1 asks for power-0 moves only, so STRENGTH and FLAME CHARGE
; (damaging, with a stat-up effect) never get here. FIERCE ROAR is not listed (its second leg
; lowers the target: AIPlayerLowerRefused weighs both legs, E2). FOCUS ENERGY's row is its
; ACCURACY leg alone (F2): layer 1 asks only when the enemy is already pumped - unpumped, the
; pump is never wasted. It reads the trainer's own Pokemon: its stages (every change is
; announced) and its stats. Keeps bc, de, hl.
AIEnemyRaiseRefused:
	push hl
	push de
	push bc
	ld a, [wEnemyMoveEffect]
	ld hl, AIRaiseEffectStats
	ld de, 2
	call IsInArray ; carry: listed, hl -> its row
	jr nc, .done ; not a stat-up effect (carry clear)
	inc hl
	ld b, [hl] ; bit n: it raises stat MOD_ n; bit 7: it heals too
	bit 7, b
	jr z, .walk
	ld hl, wEnemyMonHP
	ld a, [wEnemyMonMaxHP]
	xor [hl]
	ld c, a
	inc hl
	ld a, [wEnemyMonMaxHP + 1]
	xor [hl]
	or c ; (or clears carry)
	jr nz, .done ; below full HP: GROWTH heals, the turn is not wasted
	res 7, b
.walk
	ld c, MOD_ATTACK
.nextStat
	srl b
	jr nc, .notRaised
	call AIEnemyStatMaxed ; carry: that raise is refused (keeps bc)
	jr nc, .done ; this stat would rise: not wasted
.notRaised
	inc c
	ld a, b
	and a
	jr nz, .nextStat
	scf ; every stat it raises is at its limit
.done
	pop bc
	pop de
	pop hl
	ret

; v1.0 (D15): the power-0 stat-up effects and the stats each one raises (bit n = MOD_ n; bit 7 =
; it heals too) - the ladder ids as StatModifierUpEffect maps them (SP.DEF has no ladder id), the
; dual / triple handlers and AMNESIA's SPDEF_UP2 as effects.asm spoofs them. emu_test_ai_stat_limits
; S1 derives this table from effects_pointers.asm and effects.asm and must match it.
DEF AI_RAISE_HEALS_TOO EQU 1 << 7
ASSERT MOD_EVASION < 7, "AIRaiseEffectStats keeps bit 7 for GROWTH's heal"
AIRaiseEffectStats:
	db ATTACK_UP1_EFFECT,               1 << MOD_ATTACK
	db DEFENSE_UP1_EFFECT,              1 << MOD_DEFENSE
	db SPEED_UP1_EFFECT,                1 << MOD_SPEED
	db SPATK_UP1_EFFECT,                1 << MOD_SPATK
	db ACCURACY_UP1_EFFECT,             1 << MOD_ACCURACY
	db EVASION_UP1_EFFECT,              1 << MOD_EVASION
	db ATTACK_UP2_EFFECT,               1 << MOD_ATTACK
	db DEFENSE_UP2_EFFECT,              1 << MOD_DEFENSE
	db SPEED_UP2_EFFECT,                1 << MOD_SPEED
	db SPATK_UP2_EFFECT,                1 << MOD_SPATK
	db ACCURACY_UP2_EFFECT,             1 << MOD_ACCURACY
	db EVASION_UP2_EFFECT,              1 << MOD_EVASION
	db SPDEF_UP2_EFFECT,                1 << MOD_SPDEF                                      ; AMNESIA
	db ATTACK_DEFENSE_UP1_EFFECT,       1 << MOD_ATTACK | 1 << MOD_DEFENSE                  ; BULK UP, COIL
	db ATTACK_ACCURACY_UP1_EFFECT,      1 << MOD_ATTACK | 1 << MOD_ACCURACY                 ; HONE CLAWS
	db SPEED_EVASION_UP1_EFFECT,        1 << MOD_SPEED | 1 << MOD_EVASION                   ; AGILITY
	db SPATK_SPEED_UP1_EFFECT,          1 << MOD_SPATK | 1 << MOD_SPEED                     ; QUIVER DANCE
	db SPATK_SPDEF_ACCURACY_UP1_EFFECT, 1 << MOD_SPATK | 1 << MOD_SPDEF | 1 << MOD_ACCURACY ; CALM MIND
	db ATTACK_SPATK_UP1_HEAL_EFFECT,    1 << MOD_ATTACK | 1 << MOD_SPATK | AI_RAISE_HEALS_TOO ; GROWTH
	db FOCUS_ENERGY_EFFECT,             1 << MOD_ACCURACY ; its ACCURACY leg (F2: it runs pumped too; layer 1 asks only then)
	db -1 ; end

; v1.0 (D15): carry when StatModifierUpEffect would refuse to raise the enemy's stat c
; (MOD_ATTACK..MOD_EVASION) - its two refusals, exactly: the stage byte plus one past +6 (13),
; "won't go any higher!"; or, ATTACK..SP.DEF only, the battle word exactly 999, as the engine
; reads it - the burn / paralysis cut included, never "improved". Both refusals print "won't
; go any higher!" (D14). A +2 at +5 still raises one stage: not refused. Keeps bc; clobbers
; a, de, hl.
; v1.0 (F1, 2026-09-30): the body is SideStatMaxed, shared with the player's X items
; (PlayerStatMaxed, below) - one rule for both sides.
AIEnemyStatMaxed:
	ld hl, wEnemyMonStatMods
	ld de, wEnemyMonAttack
	; fall through
; F1: hl = the side's stage bytes (MOD_ order), de = its battle ATTACK word (the five words
; follow in MOD_ order), c = the stat. Keeps bc; clobbers a, de, hl.
SideStatMaxed:
	push de
	ld e, c
	ld d, 0
	add hl, de
	ld a, [hl]
	inc a
	cp MAX_STAT_LEVEL + 1
	ccf
	pop hl ; the side's ATTACK word (a pop leaves the flags)
	ret c ; the stage is +6
	ld a, c
	cp MOD_ACCURACY
	ret nc ; ACCURACY and EVASION have no stat word (carry clear)
	add hl, de
	add hl, de ; its battle word, big-endian
	ld a, [hli]
	xor HIGH(MAX_STAT_VALUE)
	ld d, a
	ld a, [hl]
	xor LOW(MAX_STAT_VALUE)
	or d
	cp 1 ; carry: the word is exactly 999
	ret

; v1.0 (F1, 2026-09-30; Forte: "se for um move, gasta-se PP porque faz parte da estrategia do
; player ter nocao dos stages, mas um item pode ser generoso e nao se gastar ao nao ser usado"):
; the player's side of AIEnemyStatMaxed - carry when StatModifierUpEffect would refuse to raise
; the player's stat c, the same two refusals read the same way (the battle word the engine
; compares, the burn / paralysis cut included). Farcalled by item_effects.asm ItemUseXStat
; before it writes anything: c in, the carry out (Bankswitch's `pop bc` leaves the flags; c
; does not survive it). Clobbers a, de, hl.
PlayerStatMaxed::
	ld hl, wPlayerMonStatMods
	ld de, wBattleMonAttack
	jr SideStatMaxed

; v1.0 (E2, 2026-09-29; Forte: "sigo a tua melhor recomendacao"): the mirror of D15 for the
; moves that LOWER the player's stats. Carry when the enemy's power-0 lowering move
; (wEnemyMoveEffect, a row of AILowerEffectStats) would do nothing: behind the player's
; SUBSTITUTE (StatModifierDownEffect's first test; FlinchSideEffect's too) or its MIST / GUARD
; SPEC. (MoveHitTest: the first leg's id, spoofed or not, is in its MIST ranges - and since F3 a
; later leg follows that leg's miss, StatModifierDownEffectLaterLeg - and a whiffed leg rolls no
; flinch) every leg fails; else every stat it lowers already at -6 - the
; stage byte 1, StatModifierDownEffect's `dec b / jp z, CantLowerAnymore`. The stat VALUE the
; engine also refuses at 1 is hidden from a trainer and not read. A move whose flinch still
; rolls at -6 (INTIMIDATE, SCARY FACE, METAL SOUND, SCREECH, HINDER, TICKLE: AI_LOWER_FLINCHES
; in its row) is wasted only behind a SUBSTITUTE or MIST; FIERCE ROAR, which first raises the
; enemy's ATTACK, only when that raise is refused too (AIEnemyStatMaxed). It reads what a
; trainer sees: the player's stages (every drop and the -6 refusal are announced), its
; SUBSTITUTE and its MIST (both announced). Keeps bc, de, hl.
AIPlayerLowerRefused:
	push hl
	push de
	push bc
	ld a, [wEnemyMoveEffect]
	ld hl, AILowerEffectStats
	ld de, 2
	call IsInArray ; carry: listed, hl -> its row, c = the effect
	jr nc, .done ; not a lowering effect (carry clear)
	inc hl
	ld b, [hl] ; bit n: it lowers the player's stat MOD_ n; AI_LOWER_FLINCH_BIT: a flinch rolls too
	ld a, [wPlayerBattleStatus2]
	and (1 << HAS_SUBSTITUTE_UP) | (1 << PROTECTED_BY_MIST) ; (and clears carry)
	jr nz, .lowerRefused ; every leg fails, the flinch too
	bit 7, b ; AI_LOWER_FLINCH_BIT (defined with the table below)
	jr nz, .done ; at -6 its flinch still rolls: not wasted (carry clear)
	ld hl, wPlayerMonStatMods
.nextStat
	srl b
	jr nc, .notLowered
	ld a, [hl]
	dec a ; the stage byte is 1 at -6
	and a ; (Z kept, carry cleared)
	jr nz, .done ; this stat would fall: not wasted
.notLowered
	inc hl
	ld a, b
	and a
	jr nz, .nextStat
.lowerRefused
	ld a, c
	cp ATTACK_UP1_DOWN1_EFFECT ; FIERCE ROAR raises the enemy's ATTACK first
	scf
	jr nz, .done
	ld c, MOD_ATTACK
	call AIEnemyStatMaxed ; carry: that raise is refused too (keeps bc)
.done
	pop bc
	pop de
	pop hl
	ret

; v1.0 (E2): the lowering effects a power-0 move can carry and the player's stats each one
; lowers (bit n = MOD_ n) - the ladder ids as StatModifierDownEffect maps them (SP.DEF has no
; ladder id), FAKE TEARS' SPDEF_DOWN2, the dual and flinch handlers as effects.asm spoofs them,
; and FIERCE ROAR's lowering leg. The side-effect ids ride on damaging moves only, which layer
; 1 never scores. emu_test_ai_useless_moves S1 derives this table from effects_pointers.asm and
; effects.asm and must match it.
DEF AI_LOWER_FLINCH_BIT EQU 7
DEF AI_LOWER_FLINCHES EQU 1 << AI_LOWER_FLINCH_BIT
ASSERT MOD_EVASION < AI_LOWER_FLINCH_BIT, "AILowerEffectStats keeps bit 7 for the flinch"
AILowerEffectStats:
	db ATTACK_DOWN1_EFFECT,           1 << MOD_ATTACK
	db DEFENSE_DOWN1_EFFECT,          1 << MOD_DEFENSE
	db SPEED_DOWN1_EFFECT,            1 << MOD_SPEED
	db SPATK_DOWN1_EFFECT,            1 << MOD_SPATK
	db ACCURACY_DOWN1_EFFECT,         1 << MOD_ACCURACY
	db EVASION_DOWN1_EFFECT,          1 << MOD_EVASION
	db ATTACK_DOWN2_EFFECT,           1 << MOD_ATTACK
	db DEFENSE_DOWN2_EFFECT,          1 << MOD_DEFENSE
	db SPEED_DOWN2_EFFECT,            1 << MOD_SPEED
	db SPATK_DOWN2_EFFECT,            1 << MOD_SPATK
	db ACCURACY_DOWN2_EFFECT,         1 << MOD_ACCURACY
	db EVASION_DOWN2_EFFECT,          1 << MOD_EVASION
	db SPDEF_DOWN2_EFFECT,            1 << MOD_SPDEF                          ; FAKE TEARS
	db ACCURACY_EVASION_DOWN1_EFFECT, 1 << MOD_ACCURACY | 1 << MOD_EVASION    ; FLASH
	db SPDEF_SPEED_DOWN1_EFFECT,      1 << MOD_SPDEF | 1 << MOD_SPEED         ; EERIE IMPULSE
	db SPEED_EVASION_DOWN1_EFFECT,    1 << MOD_SPEED | 1 << MOD_EVASION       ; PSYCHIC BIND
	db ATTACK_UP1_DOWN1_EFFECT,       1 << MOD_ATTACK                         ; FIERCE ROAR (and its raise)
	db ATTACK_DOWN2_FLINCH_EFFECT,    1 << MOD_ATTACK | AI_LOWER_FLINCHES     ; INTIMIDATE
	db SPEED_DOWN2_FLINCH_EFFECT,     1 << MOD_SPEED | AI_LOWER_FLINCHES      ; SCARY FACE
	db SPEED_DOWN1_FLINCH_EFFECT,     1 << MOD_SPEED | AI_LOWER_FLINCHES      ; HINDER
	db DEFENSE_DOWN1_FLINCH_EFFECT,   1 << MOD_DEFENSE | AI_LOWER_FLINCHES    ; TICKLE
	db SPDEF_DOWN2_FLINCH_EFFECT,     1 << MOD_SPDEF | AI_LOWER_FLINCHES      ; METAL SOUND
	db SPDEF_DOWN1_FLINCH_EFFECT,     1 << MOD_SPDEF | AI_LOWER_FLINCHES      ; SCREECH
	db -1 ; end

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
	; v1.0 (E4, 2026-09-29): RECOVER too - it cures a status since 2026-09-08 (layer 1).
	ld a, [wEnemyMoveNum]
	cp REST
	jr z, .nextMove
	ld a, [wEnemyMonStatus]
	and (1 << PSN) | (1 << BRN) | (1 << PAR)
	jr nz, .preferMove
	jr .nextMove
.checkOpponentAsleep
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
; one the player switched in that turn (no exception since N3, 2026-09-27: a
; WRAP no longer stops the choice at the top, and a gated turn is not chosen
; again after the player's action). It never
; asks for a mon the player's WRAP or CLAMP holds (N3, 2026-09-27: held,
; neither side can switch; asleep or frozen, both can - see its top), and
; only when the hook will honour it - a second live mon in the party - because a pending
; request is the enemy's action this turn: TrainerAI runs before either move
; (2026-09-27), so a switch runs before the player's move, as the player's
; own switch does.
; Adapted from ExtremeYellow's Mod4 (trainer_ai.asm:1913-2072). The knobs
; are its weights (13/6, 7/18/25/32, 29), plus three reasons to STAY that
; are ours (a boosted mon, a mon behind screens and - v1.0 R8, 2026-09-30 -
; a mon behind its own SUBSTITUTE doll) and a cooldown for the mon
; that just came in. The stages are the seven MOD_ bytes (7 each when
; untouched, 49 in all); the score floor of 0 means the reasons to stay
; are taken off last, so they are never lost.
AISwitchKnobs:
.confused: db 13 ; the mon is CONFUSED
.toxic:    db 3  ; per tick the badly poisoned mon has taken (2026-09-27: 6 at two, the old flat weight)
.stages:   db 7, 18, 25, 32 ; net stat stages -1, -2, -3, -4 or worse
.boosted:  db 10 ; off at net +2 or better: it is winning, it stays
.allBad:   db 29 ; every move it has is discouraged (score 11 or more)
.screen:   db 10 ; off for each screen up (REFLECT, LIGHT SCREEN)
.cooldown: db 2  ; turns the mon that just came in is left alone
.doll:     db 10 ; off with its own SUBSTITUTE doll up (v1.0 R8: a switch would throw it away)

AIMoveChoiceModification6:
	ld a, [wAISwitchCooldown]
	and a
	jr z, .noCooldown
	dec a
	ld [wAISwitchCooldown], a
	ret
.noCooldown
; v1.0 (N3, 2026-09-27, Forte: "queremos que seja igual para ambos, para ser
; justo"): held by the player's WRAP / CLAMP it cannot be withdrawn, as the
; player's cannot (.switchMon; Gen 2+). Asleep, frozen or confused it can, as
; the player's can: the old rule that kept an asleep or frozen mon in (D14)
; went. After the cooldown tick: the cooldown counts the turns the layers run
; (held ones too; not a recharge, a charge or THRASH, which choose nothing).
; The TrainerAI hook keeps the same test as a second guard.
	ld a, [wPlayerBattleStatus1]
	bit USING_TRAPPING_MOVE, a
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
; v1.0 (2026-09-27): TOXIC stays on a switch now (Gen 3); only its count
; restarts. Leaving is worth something once the count has climbed: .toxic per
; tick taken (wEnemyToxicCounter - the ticks the trainer has watched). Gated on
; PSN: a BADLY_POISONED left over without it means nothing.
	ld a, [wEnemyMonStatus]
	bit PSN, a
	jr z, .checkStages
	ld a, [wEnemyBattleStatus3]
	bit BADLY_POISONED, a
	jr z, .checkStages
	ld a, [wEnemyToxicCounter]
	and a
	jr z, .checkStages
	ld c, a ; c is free here; AddToBCapped keeps it
.toxicTick
	ld a, [AISwitchKnobs.toxic]
	call AddToBCapped
	dec c
	jr nz, .toxicTick
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
	jr z, .checkDoll
	ld a, [AISwitchKnobs.screen]
	call SubFromBCapped
.checkDoll
; v1.0 (R8, 2026-09-30): its own SUBSTITUTE doll up. A send-out clears it (EnemySendOutFirstMon), so a
; switch would throw it away; and layer 1 scores a SUBSTITUTE with its doll up 11 or more (R8), so with
; every other move discouraged .allBad alone would ask for that switch.
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr z, .roll
	ld a, [AISwitchKnobs.doll]
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
; is decided - when the enemy chooses, at the start of the turn
; (MainInBattleLoop) - so it sees the player's Pokemon as
; the trainer can, not one the player switches in that turn. The scores
; (AIScoreSwitchCandidate):
;   0  asleep or frozen: it would come in and do nothing (N3, 2026-09-27: it
;      may now be withdrawn, so it may be on the bench); below every teammate
;      that can act, low ones included. The same for one with no PP left on any
;      move, which could only STRUGGLE (D10, 2026-09-28)
;   1  weak to one of the player's types, or below 1/4 of its HP
;   2  takes the player's types neutrally
;   3  resists (or is immune to) every one of them
;  +2  not weak, and one of its TYPE-SCALED damaging moves is super effective
;      on the player (not the fixed-damage family - SEISMIC TOSS, NIGHT SHADE,
;      DRAGON RAGE, SONICBOOM, SUPER FANG, PARASITE - whose damage ignores the
;      type chart)
; The best comes in; a tie keeps party order. The LAST mon of the party - the
; ace of a boss team - is kept for last: it comes in only when no other
; teammate is alive. In Hard, for a boss or a semi-boss (Forte, 2026-09-27:
; "pode ser, sim. à experiencia") the co-aces wait with it: a teammate at the team's top level
; (the highest MON_LEVEL in the whole roster, fainted mons included, so the set
; never changes during the fight) comes in only when no teammate below that
; level is alive - then the best of them, the last slot still last of all. A
; team all at one level has no one below the top and plays as in Normal.
; Four teams have neither (AITeamHasNoAce): DREIGON's (FORTE; Forte,
; 2026-09-27: "considera que essa equipa não tem ás. estão todos ao mesmo
; nivel de respeito, por assim dizer") and those of the three bird-chamber
; self-inserts SMITH, CRAIG and WEEBRA (2026-09-28: "smith, craig, weebra
; tambem nao têm às. kiyo tem o machamp"): every live teammate but the one out
; competes on its score alone, the last slot included, and no level is held
; back; a tie still keeps party order. They only get here in Hard: their Normal
; lists (1-5) have no switch layer, so in Normal they never switch and replace
; in party order. KIYO keeps his ace in both fights.
; It also picks the replacement of a fainted mon (AIPickFaintReplacement).
; Out: a = 1 + the party index (the wAISwitchRequest encoding). Clobbers bc, de, hl.
AIPickSwitchTarget:
; b = the level held back with the ace: for a boss or a semi-boss in Hard the
; team's top level; otherwise $ff, a level no Pokemon has - and $ff for a team
; with no ace to hold anyone with (AITeamHasNoAce)
	call AITeamHasNoAce ; Z: no ace (a trashed; bc, de, hl kept)
	jr z, .noAce ; Z rides through the ld below
	call IsHardModeBossOrSemiBattle ; trashes a, b, hl
.noAce
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
	dec a ; the last index
	cp c
	jr c, .done ; past the last slot (only a no-ace team's pass scores it)
	jr nz, .candidate
	call AITeamHasNoAce ; the last slot is the ace, kept for last (.theAce) -
	jr nz, .done        ; but a team with none: it competes too (b, c, de kept)
.candidate
	ld a, [wEnemyMonPartyPos]
	cp c
	jr z, .next ; the mon that is out
	call AIScoreSwitchCandidate ; a = 0 fainted, else 1 + its score (1-6); hl = its roster entry; keeps bc, de
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
	add 8 ; not held back: above every co-ace (1 + a score is 6 at most)
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
; (a no-ace team: only with no live teammate, which neither caller allows)
	ld a, [wEnemyPartyCount] ; 1 + the last index
	ret

; v1.0 (2026-09-27/28): Z when this battle's team has no ace (see
; AIPickSwitchTarget): DREIGON (FORTE) and the three bird-chamber self-inserts
; SMITH, CRAIG and WEEBRA. The class alone decides: KIYO keeps his ace in both
; fights. Clobbers a and the flags; keeps bc, de, hl - the picker's loop holds
; the level held back in b, the party index in c, the best so far in de.
AITeamHasNoAce:
	ld a, [wTrainerClass]
	cp FORTE
	ret z
	cp SMITH
	ret z
	cp CRAIG
	ret z
	cp WEEBRA
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
; v1.0 (N3, 2026-09-27): an asleep or frozen teammate would come in and do
; nothing: it ranks below every teammate that can act, low ones included
; (tested before the HP). Its status is on its bench entry: the trainer sees it.
	pop hl
	push hl
	ld bc, MON_STATUS
	add hl, bc
	ld a, [hl]
	and (1 << FRZ) | SLP_MASK
	ld a, 1 ; 1 + a score of 0
	jp nz, .return
; v1.0 (D10, 2026-09-28): nor can a teammate with no PP left on any move (the PP Up
; bits masked): it would come in and only STRUGGLE. Normal only in effect - an
; enemy's PP never drains in Hard - and, since D3, its PP stays spent on the bench.
	pop hl
	push hl
	ld bc, MON_PP
	add hl, bc
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	and $3f
	ld a, 1 ; 1 + a score of 0 (ld keeps the flags)
	jp z, .return
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
	inc a ; 1 + a score of c + 1
	jr .return
.weak
	ld a, 2 ; 1 + a score of 1
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

; v1.0 (N3, 2026-09-27/28): the switch decision alone, on a turn with no move to
; choose - the player may switch out of each:
; - AILockedSwitchDecision, a turn locked into the enemy's own BIDE or WRAP
;   (Forte: "talvez ambos poderem trocar o seu pokemon a meio do seu bide"),
;   tail-called by SelectEnemyMove. The move layers must not run: ReadMove would
;   overwrite the wEnemyMove* block the locked move reads (BIDE's release reads
;   wEnemyMoveEffect).
; - AIStruggleSwitchDecision, a turn forced into STRUGGLE - no move but the
;   disabled one has PP left, the player's rule (HasMoveToSelect in core.asm,
;   asked for both sides) - called by callfar. SelectEnemyMove used to run no AI
;   at all there, so the mon could not be withdrawn.
; The scores layer 6 reads are the chooser's seeds (AISeedMoveScores, N3-6): $a
; for a move it could use this turn, $50 for one it could not. On a STRUGGLE turn
; every move is unusable, so "every move discouraged" counts, as a trainer would
; see it; on a locked turn a spent move no longer counts as fine. Only trainers
; whose list has layer 6; its own top still applies (held by the player's WRAP
; too: no request). Clobbers all.
AILockedSwitchDecision:
AIStruggleSwitchDecision:
	ld a, [wIsInBattle]
	dec a
	ret z ; wild
	call AIHasSwitchLayer
	ret nc
	call AISeedMoveScores
	jp AIMoveChoiceModification6

; v1.0 (N3-6, 2026-09-28; Forte: "queremos que seja igual para ambos"): the move
; scores in wBuffer (the chooser keeps only the moves with the lowest) start at $a,
; and a move the enemy cannot use this turn at $50 - the two the player's move
; menu refuses: the disabled one (vanilla) and one with no PP left (the PP Up bits
; masked). Summed over every rule, the layers take at most 10 off a move and add
; at most 20, so a $50 never comes down to a usable move and the minimum filter
; never keeps it; SelectEnemyMove sends a turn with no usable move to STRUGGLE
; before the chooser runs. Layer 6 reads 11 or more as "discouraged": an unusable
; move is. (A move with no PP used to start at $a: scored best, it was the one
; kept, and the enemy STRUGGLEd with a usable move left.) Trashes a, bc, de, hl.
; v1.0 (D15, 2026-09-29): a third tier sits between the two. Layer 1 lifts a move that
; would surely do nothing - a stat-up move that would raise nothing (D15), and since E4 every
; move its rules find the engine would refuse - to AI_SCORE_USELESS ($30, clear of the
; -10..+20 above): never kept while a move can act, never ranked below an unusable one
; (AIMoveChoiceModification1.useless).
AISeedMoveScores:
	ld a, [wEnemyDisabledMove]
	swap a
	and $f
	ld b, a ; b = the disabled slot, 1-4 (0: none)
	ld hl, wBuffer
	ld de, wEnemyMonPP
	ld c, NUM_MOVES
.seedScore
	ld a, [de]
	inc de
	dec b ; zero on the disabled slot only
	jr z, .unusable
	and $3f ; PP left?
	ld a, $a ; usable: the neutral score (ld keeps the flags)
	jr nz, .seeded
.unusable
	ld a, $50 ; forbid (highly discourage): disabled, or no PP left
.seeded
	ld [hli], a
	dec c
	jr nz, .seedScore
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
; it, as the player's does (UseBagItem; DecrementAICount here), its last turn
; too: the player, held, chose a move as well (N3), and uses it when the item
; ends the WRAP first - as the enemy does when the player's item ends the
; player's own. (shinpokered's mask was %01110010: the enemy's own WRAP blocked
; it, stricter than the player.) A SWITCH by the player's rule
; (N3, 2026-09-27): held by the other side's WRAP or CLAMP, neither side can
; switch (layer 6's top, .switchMon); asleep or frozen, both can; in its own
; BIDE or WRAP, both can (AILockedSwitchDecision); on a STRUGGLE turn, both can
; (AIStruggleSwitchDecision).
	and a ; clear carry flag in case we return due to the next checks, we dont want carry returned in those cases as it marks an action as being taken by the opponent (bit / ld / and keep it clear)
	ld a, [wEnemyBattleStatus2]
	bit NEEDS_TO_RECHARGE, a
	ret nz
	ld a, [wEnemyBattleStatus1]
	and (1 << THRASHING_ABOUT) | (1 << CHARGING_UP)
	ret nz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; v1.0 (2026-09-26, the AI switch layer): the switch layer (6) asked to
; switch this turn; TrainerAI runs before either move (MainInBattleLoop,
; 2026-09-27), so the switch goes first. The request names the teammate (1 + its party index); EnemySendOut
; consumes it when the switch happens, and this hook drops it when it does
; not; a faint replacement never sees it (AIPickFaintReplacement rewrites
; the byte, 0 or its own pick, just before that send-out). A mon the player's
; WRAP or CLAMP holds is not pulled (N3, 2026-09-27: neither side switches
; while held); with one mon left there is nothing to switch to,
; and the class AI below runs as usual - its item count is set up there, so
; this path falls through, it never returns. Both cases are belt and braces:
; the layer asks only for a mon that is not held, with a second live mon.
	ld a, [wAISwitchRequest]
	and a
	jr z, .noSwitchRequest
	ld a, [wPlayerBattleStatus1]
	bit USING_TRAPPING_MOVE, a
	jr nz, .dropSwitchRequest ; held: it stays
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
; only used when in the bag AND count > 0 (an X item also only while its stat
; can still rise, v1.0 D15; a DIRE HIT only on a Pokemon not yet pumped, a GUARD
; SPEC only without MIST, E3: AIXItemRefused); once exhausted or refused the AI
; silently falls through.
;
; Pattern (every boss now also carries Full Heal):
;   1. If statused below half its HP: a FULL RESTORE (HP, status and confusion
;      in one action) if the bag has one (AIStatusCureItem; 2026-09-27, Forte:
;      "menos hp faz sentido mais prioridade ao full restore"); with none, a
;      FULL HEAL for sleep, freeze or TOXIC (2026-09-28).
;   2. Else if HP below threshold (1/3; 1/2 for Giovanni/Oak/Joy/Bill), heal item
;      (a FULL RESTORE cures confusion too, 2026-09-27). It comes before any FULL
;      HEAL: a bag with potions only heals a poisoned, burnt or paralysed mon below
;      its line first, and the status stays (2026-09-28, the same principle); an
;      asleep, frozen or badly poisoned one gets its FULL HEAL first (step 1).
;   3. Else (no HP item used; AILateCureItem): a status -> a FULL HEAL; with none
;      left, a FULL RESTORE only for sleep or a freeze (2026-09-28). Only
;      confused, with an item action to spare -> below half a FULL RESTORE, else
;      a FULL HEAL (2026-09-27: the player may FULL HEAL a mon that is only
;      confused; the enemy plays by the same rule).
;   4. Else, one ~25% roll per buff item (independent rolls).
; Per-battle item caps come from the bag data; per-mon caps still come from
; wAICount/ai_pointers.asm (each AIUse* tail-calls DecrementAICount).

BrockAI:
	call IsHardModeBossOrSemiBattle
	ret z
	; Priority 1: a status below half its HP -> FULL RESTORE; then the HP branch; then a status's FULL HEAL, or confusion alone
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, HYPER_POTION ; sheet correction 2026-08-17: his bag upgraded from Super
	call CheckAndConsumeBossItem
	jp c, AIUseHyperPotion
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
	; no buff roll: the same correction took his X Attacks away, and an AI
	; branch with no item behind it is the mirror image of dead weight
	ret

KiyoAI:
; The dojo master. Full Restore is his rematch tier, Hyper Potion the dojo's;
; the two independent 25% rolls mirror Koga's shape, but his fists buff
; ATTACK and his Dire Hit lives in the rematch bag.
	call IsHardModeBossOrSemiBattle
	ret z
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
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
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 2
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
	call AIStatusCureItem ; a status below half its HP: FULL RESTORE (used there); else the HP branch first
	ret c
	ld a, 3
	call AICheckIfHPBelowFraction
	jr nc, .skipHeal
	ld a, SUPER_POTION
	call CheckAndConsumeBossItem
	jp c, AIUseSuperPotion
.skipHeal
	call AILateCureItem ; no HP item used: a status (FULL HEAL; asleep or frozen, a FULL RESTORE), or confusion alone
	ret c
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
; On the WRAP's last turn the reset frees the player that same turn, and it
; uses the move it chose (N3: a held #MON chooses too), as UseBagItem frees
; the enemy.
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
	jr AIUseFullHPItem

; Max Potion: fully restores HP but (unlike Full Restore) does NOT cure status.
AIUseMaxPotion:
	ld a, MAX_POTION
	; fall through
; v1.0 (R8, 2026-09-30): FULL RESTORE's and MAX POTION's one body - they were two byte-identical
; copies (36 B back in this bank). a = the item: wAIItem, the HP to its max, the HP bar's
; old / new / max, then the message and the bar (AIPrintItemUseAndUpdateHPBar).
AIUseFullHPItem:
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
; position, which nothing reads there) keeps the freeze count and, in bit 7, a
; bad POISON (TOXIC by the Gen 3 rule: it stays when called back) -
; wEnemyFreezeCounter and BADLY_POISONED are the side's, not the mon's
; (LoadEnemyMonData / RestoreEnemyMonToxic read them back). Bit 7 only with PSN:
; a leftover BADLY_POISONED is not carried.
	dec de
	dec de ; de -> byte 3 of its roster entry
	ld a, [wEnemyMonStatus]
	and 1 << PSN
	jr z, .gotToxicBit ; a = 0
	ld a, [wEnemyBattleStatus3]
	rrca ; BADLY_POISONED (bit 0) -> bit 7
	and 1 << BOX_LEVEL_TOXIC_F
.gotToxicBit
	ld hl, wEnemyFreezeCounter
	or [hl]
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
; layer 6's top, N3 - and EnemySendOutFirstMon drops the trapping bit.)
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
; v1.0 (N5, 2026-09-27): TOXIC off, and the burn/para cut goes: the enemy's stats
; recalculated (status_stat_cut.asm; UndoBurnParStats doubled the stat back, which
; lost the odd point and doubled a stat that had no cut)
	inc a ; 1 = the enemy
	jp SideStatusGone

AIUseGuardSpec:
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set PROTECTED_BY_MIST, [hl] ; the bit AIXItemRefused tests (E3)
	ld a, GUARD_SPEC
	jp AIPrintItemUse

AIUseDireHit:
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set GETTING_PUMPED, [hl] ; the bit AIXItemRefused tests (E3)
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
; (floor(max HP / a)); Z: the HP equals it exactly; neither: above it.
; v1.0 (R8, 2026-09-30): layer 1's .checkOwnSubstitute relies on the Z (a
; SUBSTITUTE at exactly its cost fails) - keep both flags if this tail changes.
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

; (UndoBurnParStats went in v1.0, N5: AICureStatus recalculates, status_stat_cut.asm.)


; ===== HARD MODE BOSS ITEM BAG HELPERS (knob #10) =====
;
; Per-battle item inventory for boss trainers. The bag (wEnemyTrainerItemBag,
; BOSS_BAG_SIZE bytes in wMiscBattleData) holds (item_id, count) pairs
; padded with -1. Populated once per battle by InitEnemyTrainerItemBag from
; data/trainers/boss_item_bags.asm. Boss AI routines call
; CheckAndConsumeBossItem before each AIUse*; if the bag is empty for that
; item, or it is an X item the engine would refuse (v1.0 D15), or a DIRE HIT /
; GUARD SPEC already in effect (E3), the AI silently no-ops and the item stays
; in the bag.

; v1.0 (2026-09-27, 2026-09-28): the boss / semi-boss cure, in two halves around
; the routine's HP branch; each uses the item itself and returns carry when one
; was used (DecrementAICount's scf), so a routine reads `call X / ret c`. Less
; HP, more weight to what gives HP back (Forte: "menos hp faz sentido mais
; prioridade ao full restore que tambem restora vida"; 2026-09-28: the early
; bosses' potions too).
; AIStatusCureItem (first in every routine): a status below half its HP
; (HP < floor(MaxHP/2), the line Giovanni, Oak, Joy and Bill already heal at): a
; FULL RESTORE if the bag has one - HP, status and confusion in one action. Gen
; 2's AI_Items also tries the FULL RESTORE first. With none, a sleep, a freeze or
; a TOXIC gets its FULL HEAL here, before any potion: a potion buys nothing
; against those (an item turn counts neither a sleep nor a freeze down, and every
; TOXIC tick is bigger), and on a boss with one item action per mon the FULL HEAL
; would never come (the 2026-09-28 review). A poison, a burn or a paralysis leaves
; it acting: nothing here, the HP branch comes next, so a bag with no FULL
; RESTORE heals below its line with its potion before any FULL HEAL.
; AILateCureItem (at .skipHeal: no HP item was used this turn):
; - a status: a FULL HEAL; with none left, a FULL RESTORE only for sleep or a
;   freeze, which stop it acting. A poison, a burn or a paralysis leaves it
;   acting, and the FULL RESTORE is kept for its HP - AIStatusCureItem's half
;   line spends it (a TOXIC gets there in a few turns). Gen 2's context AI spends
;   a status cure only on sleep or a freeze (and on a TOXIC past its 4th tick,
;   half of the time): pokecrystal engine/battle/ai/items.asm .StatusCheckContext.
; - else confusion alone, as the player may (CheckCanCureConfusion), but never
;   with this mon's LAST item action (wAICount 1): confusion wears off by
;   itself, and that action is kept for its HP. Below half a FULL RESTORE, else
;   a FULL HEAL.
; Both read what a trainer sees - the status, the CNF on its HUD, its own HP bar -
; never the hidden confusion count. The switch layer decided first (TrainerAI
; honours its request before the class routine), so a switch never costs an item.
; Every bag item taken here is used at once (a jp to its AIUse*).
; Out: carry = an item was used. Trashes a, bc, de, hl and the Divide scratch.
AIStatusCureItem:
	ld a, [wEnemyMonStatus]
	and a
	ret z
	ld a, 2
	call AICheckIfHPBelowFraction ; carry: below half
	ret nc
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
; no FULL RESTORE: a status the potion cannot outrun is cured first - a sleep or a
; freeze (it cannot act, and an item turn counts neither down) or a TOXIC (every
; tick bigger); a poison, a burn or a paralysis leaves it acting: the HP branch's
; potion comes first
	ld a, [wEnemyMonStatus]
	and (1 << FRZ) | SLP_MASK
	jr nz, AILateCureItem.fullHeal
	ld a, [wEnemyMonStatus]
	and 1 << PSN ; (and clears carry: no item)
	ret z
	ld a, [wEnemyBattleStatus3]
	bit BADLY_POISONED, a ; (bit keeps the carry clear)
	ret z
	jr AILateCureItem.fullHeal
AILateCureItem:
	ld a, [wEnemyMonStatus]
	and a
	jr nz, .fullHeal ; a status the HP branch left
	ld a, [wEnemyBattleStatus1]
	and 1 << CONFUSED ; carry clear from here to the rets
	ret z
	ld a, [wAICount] ; 1-3 here (TrainerAI returned at 0)
	dec a
	ret z
	ld a, 2
	call AICheckIfHPBelowFraction ; carry: below half
	jr nc, .fullHeal
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	jp c, AIUseFullRestore
.fullHeal
	ld a, FULL_HEAL
	call CheckAndConsumeBossItem
	jp c, AIUseFullHeal
	ld a, [wEnemyMonStatus] ; 0 on the confusion path, whose FULL RESTORE came first
	and (1 << FRZ) | SLP_MASK
	ret z ; poison, burn, paralysis: the FULL RESTORE stays for its HP
AIFullRestoreFromBag:
	ld a, FULL_RESTORE
	call CheckAndConsumeBossItem
	ret nc
	jp AIUseFullRestore

; Walk the bag looking for item_id in `a`. If found AND count > 0 (and, v1.0
; D15, not an X item whose stat the enemy cannot raise, nor, E3, a DIRE HIT
; or a GUARD SPEC already in effect: AIXItemRefused), decrement count and
; return carry. Otherwise clear carry.
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
;          carry = 0 → item not in bag, or in bag with 0 count, or (v1.0, D15) an X item
;                      whose stat the enemy cannot raise, or (E3) a DIRE HIT / GUARD SPEC
;                      already in effect (AIXItemRefused): it stays in the bag
; Trashes: a, b, c, hl (and de for an X item)
CheckAndConsumeBossItem:
	ld b, a
	call AIXItemRefused ; v1.0 (D15, E3): carry = an X item the engine would refuse, or a DIRE HIT / GUARD SPEC already in effect (b kept)
	jr c, .notFound
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

; v1.0 (D15, 2026-09-29): carry when b is an X item (X ATTACK, X DEFEND, X SPEED, X SP.ATK,
; X SP.DEF) whose stat the engine would refuse to raise for the enemy (AIEnemyStatMaxed, the
; move layer's test): the boss keeps it in the bag and its routine goes on as with none - its
; next roll, or a move. Asked by CheckAndConsumeBossItem, after the routine's roll, so the rolls
; are spent as before.
; v1.0 (E3, 2026-09-29; Forte: "no caso do dire hit e guard spec faz sentido duplicar?"): the
; same for a DIRE HIT on a Pokemon already pumped (its own FOCUS ENERGY, or a DIRE HIT) and a
; GUARD SPEC while its side is under MIST. Each item sets one bit of wEnemyBattleStatus2 and
; nothing else - the crit rate is x3 once (core.asm tests the bit), MIST is one bit - so a second
; one does nothing but spend the item, the turn and an item action. Both states were announced on
; screen. The player's are refused the same way (item_effects.asm ItemUseBattleFlagItem).
; Keeps b; clobbers a, c, de, hl.
AIXItemRefused:
	ld a, b
	ld c, 1 << GETTING_PUMPED
	cp DIRE_HIT
	jr z, .flagItem
	ld c, 1 << PROTECTED_BY_MIST
	cp GUARD_SPEC
	jr z, .flagItem
	ld c, MOD_SPDEF
	cp X_SPDEF
	jr z, .gotStat
	sub X_ATTACK
	cp X_SPATK + 1 - X_ATTACK
	ret nc ; not an X item (X ACCURACY has no AI use)
	ld c, a ; X_ATTACK..X_SPATK sit in the MOD_ATTACK..MOD_SPATK order (the ASSERT below)
.gotStat
	jp AIEnemyStatMaxed
.flagItem ; c = the item's bit (E3): carry when it is already set
	ld a, [wEnemyBattleStatus2]
	and c
	ret z ; not yet: the item acts (`and` cleared the carry)
	scf
	ret
ASSERT MOD_ATTACK == 0 && X_DEFEND - X_ATTACK == MOD_DEFENSE && X_SPEED - X_ATTACK == MOD_SPEED && X_SPATK - X_ATTACK == MOD_SPATK, \
	"AIXItemRefused maps X ATTACK..X SP.ATK onto MOD_ATTACK..MOD_SPATK by subtraction"

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
