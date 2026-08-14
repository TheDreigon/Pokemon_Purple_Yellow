DistributeExperience::
; #10. Decides who gets this battle's experience, then hands off to
; GainExperience. Called from engine/battle/core.asm the moment the enemy
; faints; it used to be written inline there.
;
;   OFF   exactly what the game does with no item at all: the mons that fought
;         split it between them.
;   ONE   half to the mons that fought, half to the LAST Pokemon in the party.
;   TEAM  no halving at all - the whole amount, divided evenly over the team.
;
; The total is CONSERVED in every mode. Nothing here creates experience, so no
; trainer level, level cap or growth curve has to be looked at again.
;
; Whether a fainted Pokemon may be paid is NOT a rule this invents. It is the
; one already written into .partyMonLoop below: Normal pays them, Hard does
; not. Both modes ask that same question rather than adding a second law.
; NOBODY TOOK PART, NOTHING TO SHARE. The flags are zero when no Pokemon of the
; player's was ever sent out, which is exactly what a SAFARI ZONE battle looks
; like - and a Safari ball reaches this same code. Without this test, TEAM built
; its own flag set from the party and paid everyone for a capture that cost no
; turn, no HP and no Pokemon on the field: thirty balls an entry, repeatable, an
; experience faucet out of nothing. ONE did the same to one Pokemon.
;
; It also covers the plain case of an empty flag byte, where ONE would otherwise
; halve the block and hand the fighters' half to nobody.
	ld a, [wPartyGainExpFlags]
	and a
	jr z, .noSharing
	call GetExpShareMode
	jr z, .noSharing
	cp EXPSHARE_TEAM
	jr z, .shareWithWholeTeam

; EXPSHARE_ONE.
;
; THE ORDER OF THE TWO PASSES IS LOAD-BEARING, and it is the opposite of what
; the old EXP.ALL did. DivideExpDataByNumMonsGainingExp writes its results BACK
; into wEnemyMonBaseStats, so two passes compound: measured, with the block at
; [60,50,40,30,20,0,100] and two Pokemon having fought, the fighters' pass left
; it at [30,25,20,15,10,0,50] and whatever ran next was handed THAT.
;
; So the single Pokemon goes first. Its pass has exactly one flag set, and the
; divider returns early without writing when fewer than two are gaining - so it
; receives the full half, and the fighters then divide the same half among
; themselves. Two fighters now get a quarter each and the shared one gets a
; half; before this order, the shared one got a quarter and a quarter of the
; battle's experience simply vanished.
;
; The old code got away with the other order because vanilla never promised any
; particular amount. This does.
	call GetExpShareTarget
	jr nc, .noSharing ; nobody to share with, so do not take the half away
	ld b, a ; the target's index
	ld a, [wPartyGainExpFlags]
	push af ; who actually fought - about to be overwritten, and needed after
	ld a, b
	call SetSinglePartyGainExpFlag
	call HalveExpData
	ld a, 1
	ld [wBoostExpByExpAll], a ; announces the share, and keeps this pass quiet
	                          ; about the one Pokemon it pays
	call GainExperience
; and now the ones that actually fought, splitting the other half between them
	pop af
	ld [wPartyGainExpFlags], a
	xor a
	ld [wBoostExpByExpAll], a
	jp GainExperience

.shareWithWholeTeam
; No halving: the flags decide the split, and DivideExpDataByNumMonsGainingExp
; divides by however many are set. Setting them only for the mons that will
; actually be paid is what keeps the total conserved on Hard - flagging the
; whole party there would divide by six and then throw away the shares of
; everyone who is down.
	call SetExpShareTeamFlags
	jr z, .noSharing ; nobody eligible at all; let the normal path run
	ld a, 1
	ld [wBoostExpByExpAll], a
	jp GainExperience

.noSharing
	xor a
	ld [wBoostExpByExpAll], a
	jp GainExperience

GetExpShareMode:
; out: a = the mode in force right now, zero flag set if that is OFF.
; The stored mode only counts while the item is really in the bag.
	ld b, EXP_ALL ; the CONSTANT keeps its old name on purpose - only the name
	              ; the player reads becomes EXP.SHARE, the same way ANTIDOTE
	              ; still spells itself ANTIDOTE behind "POISON HEAL"
	call IsItemInBag ; zero flag SET means NOT in the bag
	ld a, EXPSHARE_OFF ; ld does not touch the flags
	ret z
	ld a, [wExpShareMode]
	and a
	ret

ExpShareWillBePaid:
; in:  a = party index
; out: carry set if GainExperience would actually pay that Pokemon
;
; Both modes ask this and neither invents anything: these are the two questions
; the party loop below already asks, and asking a THIRD question here would put
; the two out of step the first time either changed.
;
;   fainted?          Normal pays it, Hard does not (.partyMonLoop)
;   past the level cap? nobody pays it (the guard after .statExpDone)
;
; The level cap half is the one that bit. Without it, a Pokemon over the cap in
; the last slot still counted as "payable", the fighters were still charged
; half the battle for it, and then the guard threw that half away - so on Hard,
; leaving the item on ONE was strictly worse than switching it off. Exactly the
; thing the routine's own contract said could not happen.
	push de
	ld d, a
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes ; a is the index; AddNTimes leaves it at 0
	ld a, [hli]
	or [hl]
	jr nz, .conscious
	ld a, [wDifficulty]
	cp NORMAL_MODE
	jr nz, .no ; fainted, and Hard does not pay the fainted
.conscious
	ld hl, wPartyMon1Level
	ld bc, wPartyMon2 - wPartyMon1
	ld a, d
	call AddNTimes
	ld b, [hl] ; this Pokemon's level
	call GetLevelCap ; a = the cap; preserves bc, de and hl
	cp b
	jr c, .no ; cap below its level: the party loop refuses it outright
	jr z, .no ; and AT the cap it gains nothing either, which is the case that
	          ; matters, because it is the state a cap exists to produce. Such a
	          ; Pokemon holds exactly CalcExperience(cap), so the exp is added
	          ; and then clamped straight back off. Testing only "over the cap"
	          ; mirrored the party loop's SKIP guard and missed the clamp below
	          ; it. Note this is not a Hard-mode-only case: GetLevelCap returns
	          ; MAX_LEVEL on Normal, so a level 100 Pokemon in the last slot
	          ; hits the identical arithmetic.
	pop de
	scf
	ret
.no
	pop de
	and a
	ret

GetExpShareTarget:
; out: carry set and a = the party index ONE mode pays, or carry clear if there
; is nobody to pay.
;
; Asking this BEFORE halving is the whole point: if the last Pokemon will not be
; paid, the half must not be taken off the ones that fought. Carrying the item
; is never allowed to cost the player experience.
	ld a, [wPartyCount]
	and a
	ret z ; no party at all; `and a` already cleared the carry
	dec a
	ld d, a ; the last slot; ExpShareWillBePaid gives de back untouched
	call ExpShareWillBePaid
	ret nc
	ld a, d
	scf
	ret

SetExpShareTeamFlags:
; Flags every party member that will actually be paid. Returns with the zero
; flag set if that is nobody.
;
; Only the ones that will be paid, because the divisor is the number of flags:
; counting a Pokemon that the party loop then refuses would divide the battle
; by a share it never hands out. That is true of the fainted on Hard and just
; as true of anything sitting over the level cap.
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a ; how many are left to look at
	ld d, 0 ; the flags being built
	ld e, 0 ; the party index
.loop
	push bc
	ld a, e
	call ExpShareWillBePaid
	pop bc ; pop does not touch the carry
	jr nc, .next
	push bc
	ld a, e
	call ExpShareBitMask
	or d
	ld d, a
	pop bc
.next
	inc e
	dec c
	jr nz, .loop
	ld a, d
	and a
	ret z ; nobody: leave wPartyGainExpFlags ALONE. The caller's fallback is
	      ; "let the normal path run", and the normal path's input is that very
	      ; byte - writing a 0 here first destroyed it, so the fallback paid
	      ; nobody at all, including the Pokemon that had actually fought.
	ld [wPartyGainExpFlags], a
	and a
	ret

SetSinglePartyGainExpFlag:
; in: a = party index. Nobody else gains anything.
	call ExpShareBitMask
	ld [wPartyGainExpFlags], a
	ret

ExpShareBitMask:
; in: a = party index; out: a = that slot's bit.
; Bit 0 is party slot 0 - the same order .partyMonLoop reads them in, and the
; same order the old `scf / rl b` loop built.
	ld b, a
	inc b
	ld a, 1
.loop
	dec b
	ret z
	add a
	jr .loop

HalveExpData:
; The enemy's base stats become stat exp and its base exp becomes experience,
; so halving this block halves both at once. NUM_STATS + 2 covers the five
; stats and the two bytes of base exp.
	ld hl, wEnemyMonBaseStats
	ld b, NUM_STATS + 2
.loop
	srl [hl]
	inc hl
	dec b
	jr nz, .loop
	ret

GainExperience:
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z ; return if link battle
	call DivideExpDataByNumMonsGainingExp
	ld a, [wBoostExpByExpAll] ;load in a if the EXP All is being used
	ld hl, WithExpAllText
	and a
	jr z, .skipExpAll ; if wBoostExpByExpAll is zero, we are not using it, so we don't show anything and keep going on
	call PrintText ; if the code reaches this point it means we have the Exp.All, so show the message
.skipExpAll
	ld hl, wPartyMon1
	xor a
	ld [wWhichPokemon], a
.partyMonLoop ; loop over each mon and add gained exp
	inc hl
	ld a, [hli]
	or [hl] ; is mon's HP 0?
	jr nz, .participantIsConscious
; v0.7: vanilla drops a fainted participant's share entirely, which punishes
; exactly the pattern the early game invites - send the weak one in, let it
; faint, finish with the starter - and leaves that Pokemon permanently behind.
; Normal mode now pays it anyway, the way every generation since does. Hard
; mode keeps the Gen 1 rule, so a Pokemon going down really costs you.
; See .keepFaintedMonFainted below: paying a fainted mon means it can level up,
; and the vanilla level-up adds the max-HP gain to CURRENT HP - which would
; quietly revive it.
	ld a, [wDifficulty]
	and a ; NORMAL_MODE?
	jp nz, .nextMon
.participantIsConscious
	push hl
	ld hl, wPartyGainExpFlags
	ld a, [wWhichPokemon]
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a ; is mon's gain exp flag set?
	pop hl
	jp z, .nextMon ; if mon's gain exp flag not set, go to next mon
	ld de, (wPartyMon1HPExp + 1) - (wPartyMon1HP + 1)
	add hl, de
	ld d, h
	ld e, l
	ld hl, wEnemyMonBaseStats
	ld c, NUM_STATS
.gainStatExpLoop
	ld a, [hli]
	ld b, a ; enemy mon base stat
	ld a, [de] ; stat exp
	add b ; add enemy mon base state to stat exp
	ld [de], a
	jr nc, .nextBaseStat
; if there was a carry, increment the upper byte
	dec de
	ld a, [de]
	inc a
	jr z, .maxStatExp ; jump if the value overflowed
	ld [de], a
	inc de
	jr .nextBaseStat
.maxStatExp ; if the upper byte also overflowed, then we have hit the max stat exp
	dec a ; ld a, $ff; a is 0 from previous check
	ld [de], a
	inc de
	ld [de], a
.nextBaseStat
	dec c
	jr z, .statExpDone
	inc de
	inc de
	jr .gainStatExpLoop
.statExpDone
; v0.7 FIX: a Pokemon already at or past the hard-mode level cap gains no exp.
;
; Without this the cap is applied by clamping the mon's exp DOWN to the cap
; level's exp -- which is fine for a mon growing into the cap, and ruinous for
; one that arrives above it. Gift Pokemon do exactly that: the roof-house
; PORYGON is L20 and Silph's is L30, so on Hard with no badges (cap 14) the
; PORYGON's 6400 exp was cut to 2195 and it *dropped* to level 14 off a single
; Rattata. Everything else that went wrong followed from the drop: the
; level-up path ran backwards (see the guard further down), the move-learn
; loop counted 21, 22 ... 255, 0 ... 14 and taught it every move from L22 up,
; and the max-HP delta went negative so current HP underflowed and drew an HP
; bar across the whole screen.
;
; Compared as LEVELS, before any exp arithmetic, so nothing can be lost.
	ld hl, wPartyMon1Level - (wPartyMon1DVs - 1)
	add hl, de ; de is the mon's own wPartyMon1DVs - 1 by now (see below)
	ld b, [hl] ; this mon's level
	call GetLevelCap
	cp b
	jp c, .nextMon ; cap < level: already past it, so nothing to gain
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wEnemyMonBaseExp]
	ldh [hMultiplicand + 2], a
	ld a, [wEnemyMonLevel]
	ldh [hMultiplier], a
	call Multiply
	ld a, 7
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ld hl, wPartyMon1OTID - (wPartyMon1DVs - 1)
	add hl, de
	ld b, [hl] ; party mon OTID
	inc hl
	ld a, [wPlayerID]
	cp b
	jr nz, .tradedMon
	ld b, [hl]
	ld a, [wPlayerID + 1]
	cp b
	ld a, 0
	jr z, .next
.tradedMon
	call BoostExp ; traded mon exp boost
	ld a, 1
.next
	ld [wGainBoostedExp], a
	ld a, [wIsInBattle]
	dec a ; is it a trainer battle?
	call nz, BoostExp ; if so, boost exp
	inc hl
	inc hl
	inc hl
; v0.7 hard mode: global EXP *0.9. Applied AFTER all standard boosts
; (traded mon *1.5, trainer battle *1.5) and BEFORE adding to party
; exp totals — so the reduction stacks multiplicatively with the
; existing boosts (not replacing them).
	ld a, [wDifficulty]
	cp HARD_MODE
	call z, HardModeExpReduce
; add the gained exp to the party mon's exp
	ld b, [hl]
	ldh a, [hQuotient + 3]
	ld [wExpAmountGained + 1], a
	add b
	ld [hld], a
	ld b, [hl]
	ldh a, [hQuotient + 2]
	ld [wExpAmountGained], a
	adc b
	ld [hl], a
	jr nc, .noCarry
	dec hl
	inc [hl]
	inc hl
.noCarry
; calculate exp for the mon at max level, and cap the exp at that value
	inc hl
	push hl
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl] ; species
	ld [wd0b5], a
	call GetMonHeader
	call GetLevelCap
	ld d, a
	callfar CalcExperience ; get max exp
; compare max exp with current exp
	ldh a, [hExperience]
	ld b, a
	ldh a, [hExperience + 1]
	ld c, a
	ldh a, [hExperience + 2]
	ld d, a
	pop hl
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .next2
; the mon's exp is greater than the max exp, so overwrite it with the max exp
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a
	dec hl
.next2
	push hl
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld a, [wBoostExpByExpAll] ; get using ExpAll flag
	and a
	jr nz, .skipExpText ; if there's EXP. all, skip showing any text
	ld hl, GainedText ;there's no EXP. all, load the text to show
	call PrintText
.skipExpText
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	call AnimateEXPBar
	pop hl
	ld bc, wPartyMon1Level - wPartyMon1Exp
	add hl, bc
	push hl
	farcall CalcLevelFromExperience
	pop hl
	ld a, [hl] ; current level
;;;;;;;;;; PureRGBnote: FIXED: fixing skip move-learn glitch: need to store the current level in wram
	ld [wTempLevelStore], a
	cp d
; v0.7 FIX: was `jp z` -- it only skipped when the level was UNCHANGED, so a
; level that went DOWN fell straight into the level-up path. Nothing should
; make that happen any more (see .statExpDone above), but the consequences of
; it happening are severe enough to be worth one flag: the move-learn loop
; below counts UP from the old level to the new one, so a new level below the
; old one wraps it through 255 and teaches the mon the entire rest of its
; learnset. `nc` covers unchanged and decreased alike.
	jp nc, .nextMon ; level did not increase, so there is nothing to do
;;;;;;;;;;
	ld a, [wCurEnemyLVL]
	push af
	push hl
	ld a, d
	ld [wCurEnemyLVL], a
	ld [hl], a
	ld bc, wPartyMon1Species - wPartyMon1Level
	add hl, bc
	ld a, [hl] ; species
	ld [wd0b5], a
	ld [wd11e], a
	call GetMonHeader
	ld bc, (wPartyMon1MaxHP + 1) - wPartyMon1Species
	add hl, bc
	push hl
	ld a, [hld]
	ld c, a
	ld b, [hl]
	push bc ; push max HP (from before levelling up)
	ld d, h
	ld e, l
	ld bc, (wPartyMon1HPExp - 1) - wPartyMon1MaxHP
	add hl, bc
	ld b, $1 ; consider stat exp when calculating stats
	call CalcStats
	pop bc ; pop max HP (from before levelling up)
	pop hl
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a ; bc = difference between old max HP and new max HP after levelling
	ld de, (wPartyMon1HP + 1) - wPartyMon1MaxHP
	add hl, de
; v0.7: in Normal mode a FAINTED participant can reach this point (see
; .participantIsConscious above), and the line below adds the max-HP gain to
; CURRENT HP - which on a mon at 0 HP would revive it with a few points, for
; free, every time it levelled. This is why vanilla skipped fainted mons at
; all. A fainted mon still gets the level, the stats and the moves; it just
; stays fainted until you heal it.
	ld a, [hl] ; wPartyMon1HP + 1
	dec hl
	or [hl] ; wPartyMon1HP - both bytes zero means fainted
	inc hl
	jr z, .keepFaintedMonFainted
; add to the current HP the amount of max HP gained when levelling
	ld a, [hl] ; wPartyMon1HP + 1
	add c
	ld [hld], a
	ld a, [hl] ; ld a, [hl] ; wPartyMon1HP
	adc b
	ld [hl], a ; wPartyMon1HP
	jr .hpAfterLevelUpDone
.keepFaintedMonFainted
	dec hl ; land on wPartyMon1HP, where the branch above ends up
.hpAfterLevelUpDone
	ld a, [wPlayerMonNumber]
	ld b, a
	ld a, [wWhichPokemon]
	cp b ; is the current mon in battle?
	jr nz, .printGrewLevelText
; current mon is in battle
	ld de, wBattleMonHP
; copy party mon HP to battle mon HP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
; copy other stats from party mon to battle mon
	ld bc, wPartyMon1Level - (wPartyMon1HP + 1)
	add hl, bc
	push hl
	ld de, wBattleMonLevel
	ld bc, 1 + NUM_STATS * 2 ; size of stats
	call CopyData
	pop hl
	ld a, [wPlayerBattleStatus3]
	bit 3, a ; is the mon transformed?
	jr nz, .recalcStatChanges
; the mon is not transformed, so update the unmodified stats
	ld de, wPlayerMonUnmodifiedLevel
	ld bc, 1 + NUM_STATS * 2
	call CopyData
	; v0.7 Badge Boost Glitch fix (mirror of LoadBattleMonFromParty):
	; bake badges into the battle stats, then refresh the unmodified
	; Atk..Spc block from them so later stat-stage recalcs keep the
	; boost. The vanilla order here left unmod raw and re-applied
	; badges on top of the battle stats — any stat-mod recalc after a
	; mid-battle level-up then silently dropped the badge boost (the
	; effects.asm re-apply calls were removed by the v0.7 fix).
	ld hl, ApplyBadgeStatBoosts
	call CallBattleCore
	ld hl, wBattleMonAttack
	ld de, wPlayerMonUnmodifiedAttack
	ld bc, 8 ; 4 stats (Atk/Def/Spd/Spc) x 2 bytes — badges don't boost MaxHP
	call CopyData
.recalcStatChanges
	xor a ; battle mon
	ld [wCalculateWhoseStats], a
	ld hl, CalculateModifiedStats
	call CallBattleCore
	ld hl, ApplyBurnAndParalysisPenaltiesToPlayer
	call CallBattleCore
	ld hl, DrawPlayerHUDAndHPBar
	call CallBattleCore
	ld hl, PrintEmptyString
	call CallBattleCore
	call SaveScreenTilesToBuffer1
.printGrewLevelText
	callabd_ModifyPikachuHappiness PIKAHAPPY_LEVELUP
	ld hl, GrewLevelText
	call PrintText
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	ld d, $1
	callfar PrintStatsBox
	call WaitForTextScrollButtonPress
	call LoadScreenTilesFromBuffer1
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	ld a, [wd0b5]
	ld [wd11e], a
;;;;;;;;;;;;;;;;;;;;
;shinpokerednote: FIXED: fixing skip move-learn glitch: here is where moves are learned from level-up
	ld a, [wCurEnemyLVL]	; load the level to advance to into a. this starts out as the final level.
	ld c, a	; load the final level to grow to over to c
	ld a, [wTempLevelStore]	; load the current level into a
	ld b, a	; load the current level over to b
.inc_level	; marker for looping back 
	inc b	;increment 	the current level
	ld a, b	;put the current level in a
	ld [wCurEnemyLVL], a	;and reset the level to advance to as merely 1 higher
	push bc	;save b & c on the stack as they hold the current a true final level
	predef LearnMoveFromLevelUp
	pop bc	;get the current and final level values back from the stack
	ld a, b	;load the current level into a
	cp c	;compare it with the final level
	jr nz, .inc_level	;loop back again if final level has not been reached
;;;;;;;;;;;;;;;;;;;;
	ld hl, wCanEvolveFlags
	ld a, [wWhichPokemon]
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
	pop hl
	pop af
	ld [wCurEnemyLVL], a

.nextMon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wWhichPokemon]
	inc a
	cp b
	jr z, .done
	ld [wWhichPokemon], a
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1
	call AddNTimes
	jp .partyMonLoop
.done
	ld hl, wPartyGainExpFlags
	xor a
	ld [hl], a ; clear gain exp flags
	ld a, [wPlayerMonNumber]
	ld c, a
	ld b, FLAG_SET
	push bc
	predef FlagActionPredef ; set the gain exp flag for the mon that is currently out
	ld hl, wPartyFoughtCurrentEnemyFlags
	xor a
	ld [hl], a
	pop bc
	predef_jump FlagActionPredef ; set the fought current enemy flag for the mon that is currently out

; divide enemy base stats, catch rate, and base exp by the number of mons gaining exp
DivideExpDataByNumMonsGainingExp:
	ld a, [wPartyGainExpFlags]
	ld b, a
	xor a
	ld c, $8
	ld d, $0
.countSetBitsLoop ; loop to count set bits in wPartyGainExpFlags
	xor a
	srl b
	adc d
	ld d, a
	dec c
	jr nz, .countSetBitsLoop
	cp $2
	ret c ; return if only one mon is gaining exp
	ld [wd11e], a ; store number of mons gaining exp
	ld hl, wEnemyMonBaseStats
	ld c, wEnemyMonBaseExp + 1 - wEnemyMonBaseStats
.divideLoop
	xor a
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, [wd11e]
	ldh [hDivisor], a
	ld b, $2
	call Divide ; divide value by number of mons gaining exp
	ldh a, [hQuotient + 3]
	ld [hli], a
	dec c
	jr nz, .divideLoop
	ret

; multiplies exp by 1.5
BoostExp:
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	srl b
	rr c
	add c
	ldh [hQuotient + 3], a
	ldh a, [hQuotient + 2]
	adc b
	ldh [hQuotient + 2], a
	ret

; v0.7 hard mode: multiply hQuotient (2-byte XP gain at offset 2..3)
; by 0.9, via Multiply x9 then Divide /10. Preserves hl. Trashes a, b
; and the Multiply/Divide HRAM scratch (hMultiplicand, hMultiplier,
; hDivisor, hQuotient — the last is overwritten with the reduced
; result, which is the desired output).
;
; The high bytes of hQuotient (offsets 0/1) are never set by the XP
; calculation upstream, so we explicitly clear hMultiplicand[0] to
; ensure the multiplication starts from a clean state.
HardModeExpReduce:
	push hl
	xor a
	ldh [hMultiplicand], a
	ldh a, [hQuotient + 2]
	ldh [hMultiplicand + 1], a
	ldh a, [hQuotient + 3]
	ldh [hMultiplicand + 2], a
	ld a, 9
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide
	pop hl
	ret

CallBattleCore:
	ld b, BANK(BattleCore)
	jp Bankswitch

GainedText:
	text_far _GainedText
	text_asm
	ld a, [wBoostExpByExpAll]
	ld hl, WithExpAllText
	and a
	ret nz
	ld hl, ExpPointsText
	ld a, [wGainBoostedExp]
	and a
	ret z
	ld hl, BoostedText
	ret

WithExpAllText:
; #10: this used to chain into ExpPointsText, which prints wExpAmountGained -
; and that byte pair is only written INSIDE the party loop, while this line is
; printed BEFORE it. The old EXP.ALL got away with it because its shared pass
; was always the SECOND one, so a previous pass had filled the number in. Both
; new modes print this on a pass that runs first, so the number would have been
; whatever the last Pokemon paid in the PREVIOUS battle - or 0000 on the first
; battle after a boot. There is no honest number to show here anyway: TEAM pays
; everyone and ONE pays somebody who is not on screen.
	text_far _WithExpAllText
	text_end

BoostedText:
	text_far _BoostedText

ExpPointsText:
	text_far _ExpPointsText
	text_end

GrewLevelText:
	text_far _GrewLevelText
	sound_level_up
	text_end

AnimateEXPBarAgain:
	call IsCurrentMonBattleMon
	ret nz
	xor a
	ld [wEXPBarPixelLength], a
	coord hl, 17, 11
	ld a, $c0
	ld c, $08
.loop
	ld [hld], a
	dec c
	jr nz, .loop
AnimateEXPBar:
	call IsCurrentMonBattleMon
	ret nz
; v0.7 FIX: only animate when the EXP bar is actually on screen. The catch-exp
; flow pays the active mon on the post-catch screen, where the battle HUD is
; gone -- and the grow loop below works by INCREMENTING the tile under the
; cursor, so on a blank $7F tile it writes $80, $81... which are the FONT's
; letters. That is the stray "Q" (and friends) Forte saw in the corner during
; "gained EXP" after a catch. The bar's fill states are tiles $c0-$c8; if the
; tile at the bar's anchor is not one of them, there is no bar to animate.
	coord hl, 17, 11
	ld a, [hl]
	sub $c0
	cp 9
	ret nc
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	ld hl, CalcEXPBarPixelLength
	ld b, BANK(CalcEXPBarPixelLength)
	call Bankswitch
	ld hl, wEXPBarPixelLength
	ld a, [hl]
	ld b, a
	ld a, [hQuotient + 3]
	ld [hl], a
	sub b
	jr z, .done
	ld b, a
	ld c, $08
	coord hl, 17, 11
.loop1
	ld a, [hl]
	cp $c8
	jr nz, .loop2
	dec hl
	dec c
	jr z, .done
	jr .loop1
.loop2
	inc a
	ld [hl], a
	call DelayFrame
	dec b
	jr z, .done
	jr .loop1
.done
	ld bc, $08
	coord hl, 10, 11
	ld de, wTileMapBackup + 10 + 11 * 20
	call CopyData
	ld c, $20
	jp DelayFrames

KeepEXPBarFull:
	call IsCurrentMonBattleMon
	ret nz
	ld a, [wEXPBarKeepFullFlag]
	set 0, a
	ld [wEXPBarKeepFullFlag], a
	ret

IsCurrentMonBattleMon:
	ld a, [wPlayerMonNumber]
	ld b, a
	ld a, [wWhichPokemon]
	cp b
	ret

; The highest level a Pokemon may currently reach, returned in a.
;
; MAX_LEVEL on Normal. On Hard it tracks the strongest Pokemon you could be
; about to face, so the party cannot out-level the next gym; once the League is
; beaten (wGameStage) the cap comes off.
;
; Two callers want this and they want it at different moments, which is why it
; is a routine and not the block of `ld d` it used to be: once up front, to
; refuse exp to a mon that is already past the cap, and once to work out the
; exp ceiling to clamp a mon growing INTO the cap.
;
; Preserves bc, de and hl -- the up-front caller is holding a party pointer in
; de and the mon's level in b.
GetLevelCap::
	push bc
	push de
	push hl
	ld a, [wDifficulty]
	and a
	jr z, .uncapped ; Normal mode is never capped
	ld a, [wGameStage]
	and a
	jr nz, .uncapped ; the League is beaten; the cap has done its job
	call GetBadgesObtained
	ld a, [wNumSetBits]
	cp 8
	ld b, 65 ; champion team (highest level in the game)
	jr nc, .done
	cp 7
	ld b, 55 ; Giovanni's ace, 8th gym (heading to the league)
	jr nc, .done
	cp 6
	ld b, 55 ; Blaine's ace, 7th gym
	jr nc, .done
	cp 5
	ld b, 49 ; Sabrina's ace, 6th gym
	jr nc, .done
	cp 4
	ld b, 45 ; Koga's ace, 5th gym
	jr nc, .done
	cp 3
	ld b, 38 ; Erika's ace, 4th gym
	jr nc, .done
	cp 2
	ld b, 34 ; Surge's ace, 3rd gym
	jr nc, .done
	cp 1
	ld b, 21 ; Misty's ace, 2nd gym
	jr nc, .done
	ld b, 14 ; Brock's ace, 1st gym
	jr .done
.uncapped
	ld b, MAX_LEVEL
.done
	ld a, b
	pop hl
	pop de
	pop bc
	ret

; function to count the set bits in wObtainedBadges
; OUTPUT:
; a = set bits in wObtainedBadges
GetBadgesObtained::
	push hl
	push bc
	push de
	ld hl, wObtainedBadges
	ld b, $1
	call CountSetBits
	pop de
	pop bc
	pop hl
	ld a, [wNumSetBits]
	ret
