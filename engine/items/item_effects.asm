UseItem_::
	ld a, 1
	ld [wActionResultOrTookBattleTurn], a ; initialise to success value
	ld a, [wcf91] ;contains item_ID
	cp HM01
	jp nc, ItemUseTMHM
	ld hl, ItemUsePtrTable
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

ItemUsePtrTable:
; entries correspond to item ids
	dw ItemUseBall       ; MASTER_BALL
	dw ItemUseBall       ; ULTRA_BALL
	dw ItemUseBall       ; GREAT_BALL
	dw ItemUseBall       ; POKE_BALL
	dw ItemUseTownMap    ; TOWN_MAP
	dw ItemUseBicycle    ; BICYCLE
	dw ItemUseSurfboard  ; out-of-battle Surf effect
	dw ItemUseBall       ; SAFARI_BALL
	dw ItemUsePokedex    ; POKEDEX
	dw ItemUseEvoStone   ; MOON_STONE
	dw ItemUseMedicine   ; POISON_HEAL
	dw ItemUseMedicine   ; BURN_HEAL
	dw ItemUseMedicine   ; ICE_HEAL
	dw ItemUseMedicine   ; SLEEP_HEAL
	dw ItemUseMedicine   ; PARALYSIS_HEAL
	dw ItemUseMedicine   ; FULL_RESTORE
	dw ItemUseMedicine   ; MAX_POTION
	dw ItemUseMedicine   ; HYPER_POTION
	dw ItemUseMedicine   ; SUPER_POTION
	dw ItemUseMedicine   ; POTION
	dw ItemUseBait       ; BOULDERBADGE
	dw ItemUseRock       ; CASCADEBADGE
	dw UnusableItem      ; THUNDERBADGE
	dw UnusableItem      ; RAINBOWBADGE
	dw UnusableItem      ; SOULBADGE
	dw UnusableItem      ; MARSHBADGE
	dw UnusableItem      ; VOLCANOBADGE
	dw UnusableItem      ; EARTHBADGE
	dw ItemUseEscapeRope ; ESCAPE_ROPE
	dw ItemUseRepel      ; REPEL
	dw UnusableItem      ; OLD_AMBER
	dw ItemUseEvoStone   ; FIRE_STONE
	dw ItemUseEvoStone   ; THUNDER_STONE
	dw ItemUseEvoStone   ; WATER_STONE
	dw ItemUseVitamin    ; HP_UP
	dw ItemUseVitamin    ; PROTEIN
	dw ItemUseVitamin    ; IRON
	dw ItemUseVitamin    ; CARBOS
	dw ItemUseVitamin    ; CALCIUM
	dw ItemUseVitamin    ; RARE_CANDY
	dw UnusableItem      ; DOME_FOSSIL
	dw UnusableItem      ; HELIX_FOSSIL
	dw UnusableItem      ; SECRET_KEY
	dw ItemUseTrainerManual ; TRAINER_MANUAL (v0.7; item $2C, the phantom slot)
	dw UnusableItem      ; BIKE_VOUCHER
	dw ItemUseXAccuracy  ; X_ACCURACY
	dw ItemUseEvoStone   ; LEAF_STONE
	dw UnusableItem      ; CARD_KEY
	dw UnusableItem      ; NUGGET
	dw ItemUsePPUp       ; PP_MAX (formerly the ITEM_32 ghost slot; v0.5)
	dw ItemUsePokedoll   ; POKE_DOLL
	dw ItemUseMedicine   ; FULL_HEAL
	dw ItemUseMedicine   ; REVIVE
	dw ItemUseMedicine   ; MAX_REVIVE
	dw ItemUseGuardSpec  ; GUARD_SPEC
	dw ItemUseSuperRepel ; SUPER_REPEL
	dw ItemUseMaxRepel   ; MAX_REPEL
	dw ItemUseDireHit    ; DIRE_HIT
	dw UnusableItem      ; COIN
	dw ItemUseMedicine   ; FRESH_WATER
	dw ItemUseMedicine   ; SODA_POP
	dw ItemUseMedicine   ; LEMONADE
	dw UnusableItem      ; S_S_TICKET
	dw UnusableItem      ; GOLD_TEETH
	dw ItemUseXStat      ; X_ATTACK
	dw ItemUseXStat      ; X_DEFEND
	dw ItemUseXStat      ; X_SPEED
	dw ItemUseXStat      ; X_SPECIAL
	dw ItemUseCoinCase   ; COIN_CASE
	dw ItemUseOaksParcel ; OAKS_PARCEL
	dw ItemUseItemfinder ; ITEMFINDER
	dw UnusableItem      ; SILPH_SCOPE
	dw ItemUsePokeflute  ; POKE_FLUTE
	dw UnusableItem      ; LIFT_KEY
	dw ItemUseExpShare   ; EXP_SHARE (the EXP.SHARE)
	dw ItemUseOldRod     ; OLD_ROD
	dw ItemUseGoodRod    ; GOOD_ROD
	dw ItemUseSuperRod   ; SUPER_ROD
	dw ItemUsePPUp       ; PP_UP (real one)
	dw ItemUsePPRestore  ; ETHER
	dw ItemUsePPRestore  ; MAX_ETHER
	dw ItemUsePPRestore  ; ELIXIR
	dw ItemUsePPRestore  ; MAX_ELIXIR
	dw ItemUseBillsChip  ; BILLS_CHIP

ItemUseBall:

; Balls can't be used out of battle.
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime

; Balls can't catch trainers' Pokémon.
	dec a
	jp nz, ThrowBallAtTrainerMon

; If this is for the old man battle, skip checking if the party & box are full.
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN
	jr z, .canUseBall
	cp BATTLE_TYPE_PIKACHU
	jr z, .canUseBall

	ld a, [wPartyCount] ; is party full?
	cp PARTY_LENGTH
	jr nz, .canUseBall
	ld a, [wBoxCount] ; is box full?
	cp MONS_PER_BOX
	jp z, BoxFullCannotThrowBall

.canUseBall
	xor a
	ld [wCapturedMonSpecies], a

	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr nz, .skipSafariZoneCode

.safariZone
	ld hl, wNumSafariBalls
	dec [hl] ; remove a Safari Ball

.skipSafariZoneCode
	call RunDefaultPaletteCommand

	ld a, $43 ; successful capture value
	ld [wPokeBallAnimData], a

	call LoadScreenTilesFromBuffer1
	ld hl, ItemUseText00
	call PrintText

; If the player is fighting an unidentified ghost, set the value that indicates
; the Pokémon can't be caught and skip the capture calculations.
	callfar IsGhostBattle
	ld b, $10 ; can't be caught value
	jp z, .setAnimData

	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN
	jr z, .oldManBattle
	cp BATTLE_TYPE_PIKACHU
	jr z, .oldManBattle ; pikachu battle technically old man battle
	jr .notOldManBattle

.oldManBattle
	ld hl, wGrassRate
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData ; save the player's name in the Wild Monster data (part of the Cinnabar Island Missingno. glitch)
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN
	jp nz, .captured
	ld a, $1
	ld [wCapturedMonSpecies], a
	CheckEvent EVENT_INITIAL_CATCH_TRAINING
	ld b, $63
	jp nz, .setAnimData
	jp .captured
.notOldManBattle
; If the player is fighting the ghost Marowak, set the value that indicates the
; Pokémon can't be caught and skip the capture calculations.
	ld a, [wCurMap]
	cp POKEMON_TOWER_6F
	jr nz, .calculate
	ld a, [wEnemyMonSpecies2]
	cp RESTLESS_SOUL
	ld b, $10 ; can't be caught value
	jp z, .setAnimData

.calculate
; v0.7 CATCH REWORK. Spec: "Catch rework - design and plan (2026-08-20)".
;
;   T = rate * H * S * B / 24000     every multiplier a whole number of 20ths
;   caught if Random(0..255) < T     a T too big for a byte is a certain catch
;
; One chain, no hidden floors. The routine this replaces decided a throw in
; four separate places -- a rejection loop over Rand1, a status SUBTRACTION
; that silently guaranteed captures, a comparison against the catch rate, and a
; second draw against an HP term -- and then computed the wobble count a fifth
; time from different numbers, so the animation could, and did, disagree with
; the odds it was animating.
;
; The ball is folded into the DIVISOR instead of multiplied in. The identity is
; 24000 = D1 * 5 * B, with B the ball's own twentieths: 240*5*20, 120*5*40,
; 80*5*60, 48*5*100 and 40*5*120 all come to 24000, so the ball never has to be
; multiplied in at all. That saves a whole Multiply, holds the intermediate at 612,000 rather
; than 36.7 million, and -- the reason that matters here -- makes every divisor
; a CONSTANT out of a table, never a value derived from battle state. The
; divide-by-zero hang the crit rework produced cannot be repeated on this path.
; Proven over all 61,440 (rate, band, status, ball) states:
;   floor(rate*H*S*B/24000) == floor(floor(rate*H*S/D1)/5), no divergences.
;
;   rate*H*S <= 255*60*40 = 612,000  20 bits, and hMultiplicand holds three
;   T        <= 3,060                12 bits, which is why the ceiling below is
;                                    a BRANCH: clamping T to 255 would lose one
;                                    "guaranteed" throw in 256, and reading the
;                                    low byte alone would turn a T of 256 into
;                                    a flat zero.

; The Master Ball never fails. This test used to live inside the Rand1 loop.
	ld a, [wcf91]
	cp MASTER_BALL
	jp z, .captured

; Worked out FIRST and parked on the stack: IsItemInBag goes through a predef,
; and a bankswitch part-way through the h-register chain is a hazard worth not
; having. Nothing between this push and its pop can leave the routine.
	call GetCatchCharmDivisor
	push af

	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wEnemyMonActualCatchRate]
	ldh [hMultiplicand + 2], a

	call GetCatchHPMultiplier
	ldh [hMultiplier], a
	call Multiply

	call GetCatchStatusMultiplier
	ldh [hMultiplier], a
	call Multiply

; x6 here, and the second divisor below carries BILL's CHIP: 30 without it,
; which is bit-for-bit the plain /5, and 24 with it, which is the exact x1.25.
; Folding the bonus into a divisor rather than into a fourth multiplier costs
; no extra divide and keeps every divisor a constant -- and it puts the item's
; strength in ONE byte, so retuning it later touches nothing else.
	ld a, 6
	ldh [hMultiplier], a
	call Multiply

	call GetCatchBallDivisor
	ldh [hDivisor], a
	ld b, 4
	call Divide

	pop af ; the charm divisor, worked out before any of this started
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 2]
	and a
	jr nz, .captured ; T ran past 255, so no roll can lose

	ldh a, [hQuotient + 3]
	ld c, a          ; c = T, and it stays there for the wobble count
	call Random      ; preserves bc
	cp c
	jr nc, .failedToCapture ; caught when Random < T

.captured
	jr .skipShakeCalculations

.failedToCapture
; The wobble count comes out of the same T the throw was decided on, so the
; animation cannot disagree with the odds any more. 26, 77 and 179 are 10%,
; 30% and 70% of 256 -- the vanilla bands, on the new scale.
	ld a, c
	cp 26
	ld b, $20 ; the ball misses
	jr c, .setAnimData
	cp 77
	ld b, $61 ; one shake
	jr c, .setAnimData
	cp 179
	ld b, $62 ; two shakes
	jr c, .setAnimData
	ld b, $63 ; three shakes

.setAnimData
	ld a, b
	ld [wPokeBallAnimData], a

.skipShakeCalculations
	ld c, 20
	call DelayFrames

; Do the animation.
	ld a, TOSS_ANIM ; v0.7 anim split: a SPECIAL - marker + parked index
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [wAnimationID], a
	xor a
	ldh [hWhoseTurn], a
	ld [wAnimationType], a
	ld [wDamageMultipliers], a
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
	predef MoveAnimation
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a

; Determine the message to display from the animation.
	ld a, [wPokeBallAnimData]
	cp $10
	ld hl, ItemUseBallText00
	jp z, .printMessage
	cp $20
	ld hl, ItemUseBallText01
	jp z, .printMessage
	cp $61
	ld hl, ItemUseBallText02
	jp z, .printMessage
	cp $62
	ld hl, ItemUseBallText03
	jp z, .printMessage
	cp $63
	ld hl, ItemUseBallText04
	jp z, .printMessage

; Save current HP.
	ld hl, wEnemyMonHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af

; Save status ailment.
	inc hl
	ld a, [hl]
	push af

	push hl

	ld hl, wEnemyBattleStatus3
	bit TRANSFORMED, [hl]
	jr z, .notTransformed
	jr .skip6

.notTransformed
; If the Pokémon is not transformed, set the transformed bit and copy the
; DVs to wTransformedEnemyMonOriginalDVs so that LoadEnemyMonData won't generate
; new DVs.
	set TRANSFORMED, [hl]
	ld hl, wTransformedEnemyMonOriginalDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a

.skip6
	ld a, [wcf91]
	push af
	ld a, [wEnemyMonSpecies2]
	ld [wcf91], a
	ld a, [wEnemyMonLevel]
	ld [wCurEnemyLVL], a
	callfar LoadEnemyMonData
	pop af
	ld [wcf91], a
	pop hl
	pop af
	ld [hld], a
	dec hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ld a, [wEnemyMonSpecies]
	ld [wCapturedMonSpecies], a
	ld [wcf91], a
	ld [wd11e], a
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN ; is this the old man battle?
	jp z, .oldManCaughtMon ; if so, don't give the player the caught Pokémon
	cp BATTLE_TYPE_PIKACHU
	jp z, .oldManCaughtMon ; same with Pikachu battle
	ld hl, ItemUseBallText05
	call PrintText

; Add the caught Pokémon to the Pokédex.
	predef IndexToPokedex
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	ld hl, wPokedexOwned
	predef FlagActionPredef
	ld a, c
	push af
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
	pop af

	and a ; was the Pokémon already in the Pokédex?
	jr nz, .skipShowingPokedexData ; if so, don't show the Pokédex data

	ld hl, ItemUseBallText06
	call PrintText
	call ClearSprites
	ld a, [wEnemyMonSpecies]
	ld [wd11e], a
	ld a, 0
	ld [wMoveListCounter], a
	predef ShowPokedexData

.skipShowingPokedexData
	ld a, $1
	ld [wd49c], a
	ld a, $85
	ld [wPikachuMood], a
	ld a, [wPartyCount]
	cp PARTY_LENGTH ; is party full?
	jr z, .sendToBox
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call ClearSprites
	ld hl, .emptyString
	call PrintText
	call AddPartyMon
	jr .caughtGainExpWithoutTheNewcomer

.sendToBox
	call ClearSprites
	call SendNewMonToBox
	ld hl, ItemUseBallText07
	CheckEvent EVENT_MET_BILL
	jr nz, .printTransferredToPCText
	ld hl, ItemUseBallText08
.printTransferredToPCText
	call PrintText
	call .boxCheck
	jr .caughtGainExp

.oldManCaughtMon
	ld hl, ItemUseBallText05

.printMessage
	call PrintText
	call ClearSprites
	jr .done ; a failed throw, and the old man's demo catch, earn nothing

.caughtGainExp
; v0.7: catching a Pokemon now pays experience, at HALF what defeating the
; same Pokemon would have paid. Reached only from the two success paths (added
; to the party, or sent to the PC) - a broken-free ball and the Viridian old
; man's tutorial catch skip it via the jr above.
;
; The halving loop in .payCaughtExp is the engine's own idiom - the same one
; HalveExpData uses over in engine/battle/experience.asm: it walks the enemy's
; base stats, catch rate and base exp and shifts each right once. It stays
; written out here rather than becoming a farcall because ten bytes inline beat
; six bytes of farcall plus the bank switch. Halving the SOURCE rather than the
; result means the split downstream is exactly the arithmetic a knockout uses.
;
; WHO gains is deliberately not decided here, and now really is not: handing
; off to DistributeExperience is what makes a ball and a knockout reward the
; same Pokemon under the same rules. That sentence used to be here while the
; code called GainExperience directly, which skipped the EXP.SHARE entirely -
; the comment was true of vanilla and had quietly stopped being true.
;
; The two entry points differ in one thing only: whether a Pokemon has just been
; added to the party, and therefore has to be hidden from the payout.
; The Pokemon went to the PC, so the party is exactly what it was in the battle.
	call .payCaughtExp
	jr .done

.caughtGainExpWithoutTheNewcomer
; ...whereas a Pokemon that JOINED THE PARTY is already in it by the time the
; experience is paid, and it is in the LAST slot - the slot the EXP.SHARE's ONE
; mode pays. Without this, every capture handed the share to the Pokemon that
; had just arrived and was never in the battle, while the one the player had
; deliberately parked there to be raised got nothing and the fighters were
; still docked their half. TEAM had the milder version: the newcomer ate a
; share of a battle it never saw.
;
; Hiding it for the length of the payout is enough, because wPartyCount is what
; bounds both the share's choice of slot and GainExperience's own party walk
; (.nextMon). Nothing else runs in between.
	ld a, [wPartyCount]
	dec a
	ld [wPartyCount], a
	call .payCaughtExp
	ld a, [wPartyCount]
	inc a
	ld [wPartyCount], a
	jr .done

.payCaughtExp
	ld hl, wEnemyMonBaseStats
	ld b, NUM_STATS + 2
.halveCaughtExpLoop
	srl [hl]
	inc hl
	dec b
	jr nz, .halveCaughtExpLoop
; v0.7 FIX: GainExperience walks the party with wWhichPokemon and leaves it at
; the LAST party index -- and wWhichPokemon is ALSO the bag index this flow
; uses at .done to remove the thrown ball (RemoveItemFromInventory_ reads it as
; "index within the inventory"). So every successful catch removed one of
; whatever bag slot number equalled the party size minus one, instead of a
; ball: with the TRAINER MANUAL sitting in that slot it vanished outright, and
; the ball count looked like it GREW because it was never spent. Found in
; Forte's first fresh playthrough. Preserve the bag index across the exp pay.
	ld a, [wWhichPokemon]
	push af
	callfar DistributeExperience
	pop af
	ld [wWhichPokemon], a
	ret

.done
	ld a, [wBattleType]
	and a ; is this the old man battle?
	ret nz ; if so, don't remove a ball from the bag

; Remove a ball from the bag.
	ld hl, wNumBagItems
	inc a
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

.emptyString
	db "@"

.boxCheck
	ld a, [wBoxCount] ; is box full?
	cp MONS_PER_BOX
	ret nz
	ld hl, BoxFullReminderTXT
	call PrintText
	ret

BoxFullReminderTXT:
	text_far _BoxIsFullReminderText
	text_end
ItemUseBallText00:
;"It dodged the thrown ball!"
;"This pokemon can't be caught"
	text_far _ItemUseBallText00
	text_end
ItemUseBallText01:
;"You missed the pokemon!"
	text_far _ItemUseBallText01
	text_end
ItemUseBallText02:
;"Darn! The pokemon broke free!"
	text_far _ItemUseBallText02
	text_end
ItemUseBallText03:
;"Aww! It appeared to be caught!"
	text_far _ItemUseBallText03
	text_end
ItemUseBallText04:
;"Shoot! It was so close too!"
	text_far _ItemUseBallText04
	text_end
ItemUseBallText05:
;"All right! {MonName} was caught!"
;play sound
	text_far _ItemUseBallText05
	sound_caught_mon
	text_promptbutton
	text_end
ItemUseBallText07:
;"X was transferred to Bill's PC"
	text_far _ItemUseBallText07
	text_end
ItemUseBallText08:
;"X was transferred to someone's PC"
	text_far _ItemUseBallText08
	text_end

ItemUseBallText06:
;"New DEX data will be added..."
;play sound
	text_far _ItemUseBallText06
	sound_dex_page_added
	text_promptbutton
	text_end

; --- the three multipliers of the v0.7 catch rule --------------------------
; Each returns its multiplier in a, as a whole number of twentieths, so that
; the console never has to touch a fraction. See ItemUseBall for the chain.

; HP: 20 22 26 32 44 60 for full / 75-99% / 50-74% / 25-49% / 10-24% / under
; 10%. The bands are the SUPER FANG ladder -- halving from full health lands on
; 50, 25, 12.5 and 6.25 percent, one boundary per use.
;
; Exact, and with no division: the engine's Divide takes a ONE BYTE divisor and
; max HP runs to 999, so dividing by it is not available here. Every test is a
; comparison of small multiples instead.
;   cur >= 75% of max  <=>  4*cur >= 3*max
;   cur >= 50% of max  <=>  2*cur >=   max
;   cur >= 25% of max  <=>  4*cur >=   max
;   cur >= 10% of max  <=> 10*cur >=   max
; With HP capped at 999, 10*cur (9,990) and 3*max (2,997) both stay in 16 bits.
GetCatchHPMultiplier:
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a ; bc = current HP, big endian
	ld hl, wEnemyMonMaxHP ; not adjacent to HP: 14 bytes further into the struct
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a ; de = max HP

	ld a, b
	cp d
	jr nz, .notFull
	ld a, c
	cp e
	jr nz, .notFull
	ld a, 20 ; untouched
	ret

.notFull
	ld h, b
	ld l, c
	add hl, hl ; 2*cur
	ld b, h
	ld c, l
	add hl, hl ; 4*cur
	push hl
	add hl, hl ; 8*cur
	add hl, bc ; 10*cur
	call .below
	pop bc     ; bc = 4*cur; pop leaves the flags alone
	jr c, .under10

	ld h, b
	ld l, c    ; 4*cur
	call .below
	jr c, .tier10

	srl h
	rr l       ; 2*cur, exact: 4*cur is even
	call .below
	jr c, .tier25

	add hl, hl ; 4*cur again
	push hl
	ld h, d
	ld l, e
	add hl, hl ; 2*max
	add hl, de ; 3*max
	ld d, h
	ld e, l
	pop hl
	call .below
	jr c, .tier50
	ld a, 22   ; 75-99%
	ret
.tier50
	ld a, 26
	ret
.tier25
	ld a, 32
	ret
.tier10
	ld a, 44
	ret
.under10
	ld a, 60
	ret

.below
; carry set if hl < de
	ld a, h
	cp d
	ret c
	ret nz
	ld a, l
	cp e
	ret

; Status: only the BEST one the target has counts. They do not stack, and the
; trainer manual says so.
;   none 20 | confusion 22 | poison 24 | burn 26 | toxic 28
;   paralysis 32 | sleep 36 | freeze 40
;
; Three different bytes hold these. Sleep, poison, burn, freeze and paralysis
; live in the status byte; BADLY_POISONED sits in battle status 3 on top of the
; poison bit; and CONFUSED is in battle status 1 and is the only one of the
; eight the status screen never shows the player -- which is why the manual has
; to say out loud that it counts.
;
; Freeze is one step above sleep and no more, because what it really buys is
; one extra turn: 3-6 against 2-5 (both retuned in v0.5). The turns already pay
; for themselves in throws; paying twice for them would be double counting.
GetCatchStatusMultiplier:
	ld a, [wEnemyMonStatus]
	ld b, a
	and a
	jr z, .noStatusByte

	bit FRZ, b
	ld a, 40
	ret nz

	ld a, b
	and SLP_MASK
	ld a, 36
	ret nz

	bit PAR, b
	ld a, 32
	ret nz

	bit BRN, b
	ld a, 26
	ret nz

; whatever is left in the status byte is poison; toxic is a bit on top of it
	ld a, [wEnemyBattleStatus3]
	bit BADLY_POISONED, a
	ld a, 28
	ret nz
	ld a, 24
	ret

.noStatusByte
	ld a, [wEnemyBattleStatus1]
	bit CONFUSED, a
	ld a, 22
	ret nz
	ld a, 20
	ret

; Returns the second divisor: 24 while BILL's CHIP is in the bag, 30 otherwise.
; 30 is exactly the plain /5 once the x6 above is accounted for, so a player
; without the chip gets the same numbers as before it existed.
;
; The chip works by being CARRIED -- there is no flag to read, no charge to
; spend and nothing to switch on. It cannot be thrown away (TossItem_ refuses
; key items), so the only way to put the bonus down is to leave the chip in the
; PC, which is deliberate: the bonus should be losable on purpose and not by
; accident.
;
; It is unconditional, which means it applies inside the SAFARI ZONE too, on top
; of the x5 that zone is tuned around. That is on purpose: the bag description
; says every BALL, and a post-League player walking back into the Safari with
; the chip should not find the one place it quietly does nothing.
GetCatchCharmDivisor:
	ld b, BILLS_CHIP
	call IsItemInBag
	ld a, 30
	ret z
	ld a, 24
	ret

; Ball: the multiplier folded into the denominator -- 24000 = D1 * 5 * B, with B
; the ball's own twentieths -- so a better ball is a SMALLER constant.
;   POKE x1 -> 240   GREAT x2 -> 120   ULTRA x3 -> 80
;   SAFARI x5 -> 48, and x6 -> 40 once a rock is in play
;
; The SAFARI BALL is deliberately out of step with the 1:2:3 ladder. Inside the
; SAFARI ZONE the menu is BAIT / ROCK / BALL / RUN: there is no way to weaken a
; target and no way to give it a status, so the HP and status multipliers are
; pinned at x1.0 in there by construction and the ball has to do their work by
; itself. x5 is what holds the zone where it stands today.
;
; "A rock is in play" is wSafariEscapeFactor being non-zero. That is the
; counter the rock already sets and that already ticks itself back to zero, and
; BAIT already clears it -- so the bonus expires, and cancels, for free, with
; no new state anywhere.
;
; Each `cp` is re-loaded and consumed by its own `ret` on purpose. The ladder
; this replaces chained four `cp`s separated by `ld a, n` and was therefore
; dead code from Yellow Legacy onwards: `ld` does not touch the flags, so every
; comparison but the last was thrown away unread.
GetCatchBallDivisor:
	ld a, [wcf91]
	cp GREAT_BALL
	ld a, 120
	ret z
	ld a, [wcf91]
	cp ULTRA_BALL
	ld a, 80
	ret z
	ld a, [wcf91]
	cp SAFARI_BALL
	jr z, .safari
	ld a, 240 ; POKE BALL, and anything else that reaches here
	ret
.safari
	ld a, [wSafariEscapeFactor]
	and a
	ld a, 40
	ret nz
	ld a, 48
	ret

ItemUseTownMap:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	farjp DisplayTownMap

; BILL's CHIP does its work by being carried -- GetCatchCharmDivisor looks for
; it in the bag on every throw. Pressing USE says so rather than failing with
; "not the time", which would be true of every moment there is.
;
; Note it is NOT refused in battle: a key item that does nothing on USE is
; indistinguishable from a broken one, and the one moment a player is most
; likely to press USE on it is mid-throw.
ItemUseBillsChip:
	ld hl, BillsChipText
	jp ItemUseFailed

BillsChipText:
	text_far _BillsChipText
	text_end

; v0.7: USE on the TRAINER MANUAL opens it. The item is in neither
; UsableItems_CloseMenu nor UsableItems_PartyMenu, so the bag stays where it is
; and redraws itself from its saved screen when this returns.
;
; Refused in battle, the way the TOWN MAP is. The manual is a full-screen
; takeover and the battle screen is restored from a buffer this would not have
; filled -- the same reason every other reading item in the game says no there.
ItemUseTrainerManual:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	farjp ShowTrainerManual

; #10: USE on the EXP.SHARE asks who this battle's experience should go to.
; Three settings, one list, and OFF is one of them - which is why there is no
; separate on/off switch to find.
;
; Like the TOWN MAP and the manual, it says no in battle: the menu is drawn at
; the top-left corner over whatever is there, and the battle screen is restored
; from a buffer this would not have filled. Outside battle the bag redraws
; itself from its own saved screen when this returns, so nothing is put back
; here (the item is in neither UsableItems_CloseMenu nor UsableItems_PartyMenu).
;
; The menu index IS the mode: OFF/ONE/TEAM are 0/1/2 in both.
ItemUseExpShare:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wd730]
	set 6, a ; no printing delay while the box goes up
	ld [wd730], a
	ld a, EXPSHARE_MENU_TEMPLATE
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, 2 ; OFF, ONE, TEAM
	ld [wMaxMenuItem], a
; The cursor steps TWO rows per entry unless bit 1 of hUILayoutFlags is set,
; and `next` in the menu string moves two rows unless bit 2 is. Neither flag is
; set while the bag is open, so 11 / 13 / 15 line up on their own. Do not set
; them.
	ld a, 11
	ld [wTopMenuItemY], a
	ld a, 14
	ld [wTopMenuItemX], a
; Open on the setting that is already in force, so the menu shows you where you
; are instead of always claiming OFF.
	ld a, [wExpShareMode]
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	xor a
; BOTH of these, and neither is optional. DisplayListMenuID runs immediately
; before this - it is the bag list you came from - and it leaves
; wMenuWatchMovingOutOfBounds set to 1 or 2 (home/list_menu.asm), while a stale
; wMenuJoypadPollCount makes HandleMenuInput pick an entry on its own without
; the player pressing anything (home/window.asm:35-37). The vending machine
; carries the same two lines for the same reason.
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wMenuJoypadPollCount], a
	ld a, [wd730]
	res 6, a
	ld [wd730], a
	call HandleMenuInput
	push af
	call PlaceUnfilledArrowMenuCursor
	pop af
	bit BIT_B_BUTTON, a
	jr nz, .cancelled ; B leaves the setting alone
	ld a, [wCurrentMenuItem]
	ld [wExpShareMode], a
	ld hl, ExpShareSetToOffText
	and a
	jr z, .say
	ld hl, ExpShareSetToOneText
	dec a
	jr z, .say
	ld hl, ExpShareSetToTeamText
.say
	jp PrintText
.cancelled
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item not used
	ret

ItemUseBicycle:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wWalkBikeSurfState]
	ld [wWalkBikeSurfStateCopy], a
	cp 2 ; is the player surfing?
	jp z, ItemUseNotTime
	dec a ; is player already bicycling?
	jr nz, .tryToGetOnBike
.getOffBike
	call ItemUseReloadOverworldData
	xor a
	ld [wWalkBikeSurfState], a ; change player state to walking
	ld a, $00
	ld [wPikachuSpawnState], a
	call PlayDefaultMusic ; play walking music
	ld hl, GotOffBicycleText
	jp PrintText

.tryToGetOnBike
	call IsBikeRidingAllowed
	jp nc, NoCyclingAllowedHere
	call ItemUseReloadOverworldData
	xor a ; no keys pressed
	ldh [hJoyHeld], a ; current joypad state
	ld a, $1
	ld [wWalkBikeSurfState], a ; change player state to bicycling
	call PlayDefaultMusic ; play bike riding music
	xor a
	ld [wWalkBikeSurfState], a
	ld hl, GotOnBicycleText
	call PrintText
	ld a, $1
	ld [wWalkBikeSurfState], a
	ret

; used for Surf out-of-battle effect
ItemUseSurfboard:
	ld a, [wWalkBikeSurfState]
	ld [wWalkBikeSurfStateCopy], a
	cp 2 ; is the player already surfing?
	jr z, .tryToStopSurfing
.tryToSurf
	call IsNextTileShoreOrWater
	jp nc, SurfingAttemptFailed
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions
	jp c, SurfingAttemptFailed
.surf
	call .makePlayerMoveForward
	ld hl, wd730
	set 7, [hl]
	ld a, 2
	ld [wWalkBikeSurfState], a ; change player state to surfing
	call PlayDefaultMusic ; play surfing music
	ld hl, SurfingGotOnText
	jp PrintText

.tryToStopSurfing
	xor a
	ldh [hSpriteIndexOrTextID], a
	ld d, 16 ; talking range in pixels (normal range)
	call IsSpriteInFrontOfPlayer2
	res 7, [hl]
	ldh a, [hSpriteIndexOrTextID]
	and a ; is there a sprite in the way?
	jr nz, .cannotStopSurfing
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions
	jr c, .cannotStopSurfing
	ld a, [wTileInFrontOfPlayer]
	ld c, a
	call IsTilePassable
	jr nc, .stopSurfing
.cannotStopSurfing
	ld hl, SurfingNoPlaceToGetOffText
	jp PrintText

.stopSurfing
	call .makePlayerMoveForward
	ld a, $3
	ld [wPikachuSpawnState], a
	ld hl, wPikachuOverworldStateFlags
	set 5, [hl]
	ld hl, wd730
	set 7, [hl]
	xor a
	ld [wWalkBikeSurfState], a ; change player state to walking
	dec a
	ld [wJoyIgnore], a
	call PlayDefaultMusic ; play walking music
	call GBPalWhiteOutWithDelay3
	jp LoadWalkingPlayerSpriteGraphics

; uses a simulated button press to make the player move forward
.makePlayerMoveForward
	ld a, [wPlayerDirection] ; direction the player is going
	bit PLAYER_DIR_BIT_UP, a
	ld b, D_UP
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_DOWN, a
	ld b, D_DOWN
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_LEFT, a
	ld b, D_LEFT
	jr nz, .storeSimulatedButtonPress
	ld b, D_RIGHT
.storeSimulatedButtonPress
	ld a, b
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wUnusedCD39], a
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	ret

SurfingGotOnText:
	text_far _SurfingGotOnText
	text_end

SurfingNoPlaceToGetOffText:
	text_far _SurfingNoPlaceToGetOffText
	text_end

ItemUsePokedex:
	predef_jump ShowPokedexMenu

ItemUseEvoStone:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	ld [wEvoStoneItemID], a
	push af
	ld a, EVO_STONE_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call DisplayPartyMenu
	ld a, [wcf91]
	ld [wLoadedMon], a
	pop bc
	jr c, .canceledItemUse
	ld a, b
	ld [wcf91], a
	call Func_d85d
	jr nc, .noEffect
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .notPlayerPikachu
	ld e, $1b
	callfar PlayPikachuSoundClip
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, RefusingText
	call PrintText
	ld a, $4
	ld [wd49c], a
	ld a, $82
	ld [wPikachuMood], a
	jr .canceledItemUse

.notPlayerPikachu
	ld a, SFX_HEAL_AILMENT
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld a, $01
	ld [wForceEvolution], a
	callfar TryEvolvingMon ; try to evolve pokemon
	pop af
	ld [wWhichPokemon], a
	ld hl, wNumBagItems
	ld a, 1 ; remove 1 stone
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

.noEffect
	call ItemUseNoEffect
.canceledItemUse
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item not used
	pop af
	ret

Func_d85d:
	ld hl, EvosMovesPointerTable
	ld a, [wLoadedMon]
	dec a
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc
	ld de, wcd6d
	ld a, BANK(TryEvolvingMon)
	ld bc, $2
	call FarCopyData
	ld hl, wcd6d
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wcd6d
	ld a, BANK(TryEvolvingMon)
	ld bc, 13
	call FarCopyData
	ld hl, wcd6d
.loop
	ld a, [hli]
	and a
	jr z, .cannotEvolveWithUsedStone
	inc hl
	inc hl
	cp EVOLVE_ITEM
	jr nz, .loop
	dec hl
	dec hl
	ld b, [hl]
	ld a, [wcf91]
	inc hl
	inc hl
	inc hl
	cp b
	jr nz, .loop
	scf
	ret

.cannotEvolveWithUsedStone
	and a
	ret

RefusingText:
	text_far _RefusingText
	text_end

ItemUseVitamin:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime

; Confusion is not part of a #MON's status byte. It is a bit in
; wPlayerBattleStatus1 with its own counter, which is why the $ff mask a FULL
; HEAL carries has never touched it and why a FULL RESTORE never did either.
; Forte's call is that it should behave like burn or sleep, so these two items
; clear it. Nothing else does -- the single-ailment heals keep their own masks.
;
; Returns carry when there is confusion for them to clear: a battle is running,
; the item is one of those two, and the #MON being treated is the one on the
; field. Confusion only exists in battle, so everything else is a no.
;
; Trashes a and hl. Leaves d alone: that is the party index the caller holds.
CheckCanCureConfusion:
	ld a, [wIsInBattle]
	and a
	jr z, .nothingToCure
	ld a, [wcf91]
	cp FULL_HEAL
	jr z, .rightItem
	cp FULL_RESTORE
	jr nz, .nothingToCure
.rightItem
	ld a, [wPlayerMonNumber]
	cp d ; is the treated #MON the one that is out?
	jr nz, .nothingToCure
	ld hl, wPlayerBattleStatus1
	bit CONFUSED, [hl]
	jr z, .nothingToCure
	scf
	ret
.nothingToCure
	and a ; clear carry
	ret

; Called from the two places that already clear wBattleMonStatus, so it only has
; to decide on the item. The counter is zeroed as well: leaving it set would
; have the mon snap straight back to confused on the next hit.
CureConfusionIfFullHealOrRestore:
	ld a, [wcf91]
	cp FULL_HEAL
	jr z, .clearIt
	cp FULL_RESTORE
	ret nz
.clearIt
	ld hl, wPlayerBattleStatus1
	res CONFUSED, [hl]
	xor a
	ld [wPlayerConfusedCounter], a
	ret

ItemUseMedicine:
	; v0.7 hard-mode trainer/boss policy: Revive/Max Revive blocked.
	; Allowed in wild battles AND in any battle on Normal mode.
	; Reason: revives are the other half of the boss PP-stall loop —
	; without them, the player can't keep a sacrificial Chansey alive
	; forever to drain boss PP into Struggle.
	ld a, [wcf91]
	cp REVIVE
	jr c, .reviveCheckDone        ; below REVIVE: not gated
	cp MAX_REVIVE + 1
	jr nc, .reviveCheckDone       ; above MAX_REVIVE: not gated
	ld a, [wIsInBattle]
	and a
	jr z, .reviveCheckDone        ; not in battle: allow
	dec a
	jr z, .reviveCheckDone        ; wild battle: allow
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .reviveCheckDone       ; trainer battle on Normal mode: allow
	ld hl, BattleItemsCantBeUsedHereText
	jp ItemUseFailed
.reviveCheckDone
	ld a, [wPartyCount]
	and a
	jp z, Func_e4bf
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
	ld a, USE_ITEM_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jr z, .notUsingSoftboiled
; if using softboiled
	call GoBackToPartyMenu
	jr .getPartyMonDataAddress
.notUsingSoftboiled
	call DisplayPartyMenu
.getPartyMonDataAddress
	jp c, .canceledItemUse
	ld hl, wPartyMons
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [wWhichPokemon]
	ld [wUsedItemOnWhichPokemon], a
	ld d, a
	ld a, [wcf91]
	ld e, a
	ld [wd0b5], a
	pop af
	push af
	cp CALCIUM + 1
	jr nc, .noHappinessBoost
	push hl
	push de
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDITEM
	pop de
	pop hl
.noHappinessBoost
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jr z, .checkItemType
; if using softboiled
	ld a, [wWhichPokemon]
	cp d ; is the pokemon trying to use softboiled on itself?
	jp z, ItemUseMedicine ; if so, force another choice (jp not jr: the Revive/Max Revive gate prologue above pushed this past jr range)
.checkItemType
	ld a, [wcf91]
	cp REVIVE
	jr nc, .healHP ; if it's a Revive or Max Revive
	cp FULL_HEAL
	jr z, .cureStatusAilment ; if it's a Full Heal
	cp HP_UP
	jp nc, .useVitamin ; if it's a vitamin or Rare Candy
	cp FULL_RESTORE
	jr nc, .healHP ; if it's a Full Restore or one of the potions
; fall through if it's one of the status-specific healing items
.cureStatusAilment
	ld bc, wPartyMon1Status - wPartyMon1
	add hl, bc ; hl now points to status
	ld a, [wcf91]
	lb bc, POISON_HEAL_MSG, 1 << PSN
	cp POISON_HEAL
	jr z, .checkMonStatus
	lb bc, BURN_HEAL_MSG, 1 << BRN
	cp BURN_HEAL
	jr z, .checkMonStatus
	lb bc, ICE_HEAL_MSG, 1 << FRZ
	cp ICE_HEAL
	jr z, .checkMonStatus
	lb bc, SLEEP_HEAL_MSG, SLP_MASK
	cp SLEEP_HEAL
	jr z, .checkMonStatus
	lb bc, PARALYSIS_HEAL_MSG, 1 << PAR
	cp PARALYSIS_HEAL
	jr z, .checkMonStatus
	lb bc, FULL_HEAL_MSG, $ff ; Full Heal
.checkMonStatus
	ld a, [hl] ; pokemon's status
	and c ; does the pokemon have a status ailment the item can cure?
	jr nz, .curesSomething
; The status BYTE is clear -- but confusion is not in it. It is a bit in
; wPlayerBattleStatus1, which is why a FULL HEAL's $ff mask never reached it.
; Forte's call is that confusion should behave like burn or sleep, so a FULL
; HEAL used on a mon that is only confused has to count as doing something
; rather than reporting no effect.
	push hl
	push bc
	call CheckCanCureConfusion
	pop bc
	pop hl
	jp nc, .healingItemNoEffect
.curesSomething
; if the pokemon has a status the item can heal
	xor a
	ld [hl], a ; remove the status ailment in the party data
	ld a, b
	ld [wPartyMenuTypeOrMessageID], a ; the message to display for the item used
	ld a, [wPlayerMonNumber]
	cp d ; is pokemon the item was used on active in battle?
	jp nz, .doneHealing
; if it is active in battle
	xor a
	ld [wBattleMonStatus], a ; remove the status ailment in the in-battle pokemon data
	push hl
	ld hl, wPlayerBattleStatus3
	res BADLY_POISONED, [hl] ; heal Toxic status
	call CureConfusionIfFullHealOrRestore
	pop hl
	ld bc, wPartyMon1Stats - wPartyMon1Status
	add hl, bc ; hl now points to party stats
	ld de, wBattleMonStats
	ld bc, NUM_STATS * 2
	call CopyData ; copy party stats to in-battle stat data
	predef DoubleOrHalveSelectedStats
	jp .doneHealing

.healHP
	inc hl ; hl = address of current HP
	ld a, [hli]
	ld b, a
	ld [wHPBarOldHP+1], a
	ld a, [hl]
	ld c, a
	ld [wHPBarOldHP], a ; current HP stored at wHPBarOldHP (2 bytes, big-endian)
	or b
	jr nz, .notFainted
.fainted
	ld a, [wcf91]
	cp REVIVE
	jr z, .updateInBattleFaintedData
	cp MAX_REVIVE
	jr z, .updateInBattleFaintedData
	jp .healingItemNoEffect

.updateInBattleFaintedData
	ld a, [wWhichPokemon]
	push af
	ld a, [wUsedItemOnWhichPokemon]
	ld [wWhichPokemon], a
	push hl
	push de
	push bc
	callfar RespawnOverworldPikachu
	pop bc
	pop de
	pop hl
	pop af
	ld [wWhichPokemon], a

	ld a, [wIsInBattle]
	and a
	jr z, .compareCurrentHPToMaxHP
	push hl
	push de
	push bc
	ld a, [wUsedItemOnWhichPokemon]
	ld c, a
	ld hl, wPartyFoughtCurrentEnemyFlags
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	jr z, .next
	ld a, [wUsedItemOnWhichPokemon]
	ld c, a
	ld hl, wPartyGainExpFlags
	ld b, FLAG_SET
	predef FlagActionPredef
.next
	pop bc
	pop de
	pop hl
	jr .compareCurrentHPToMaxHP

.notFainted
	ld a, [wcf91]
	cp REVIVE
	jp z, .healingItemNoEffect
	cp MAX_REVIVE
	jp z, .healingItemNoEffect
.compareCurrentHPToMaxHP
	push hl
	push bc
	ld bc, wPartyMon1MaxHP - (wPartyMon1HP + 1)
	add hl, bc ; hl now points to max HP
	pop bc
	ld a, [hli]
	cp b
	jr nz, .skipComparingLSB ; no need to compare the LSB's if the MSB's don't match
	ld a, [hl]
	cp c
.skipComparingLSB
	pop hl
	jr nz, .notFullHP
.fullHP ; if the pokemon's current HP equals its max HP
	ld a, [wcf91]
	cp FULL_RESTORE
	jp nz, .healingItemNoEffect
	inc hl
	inc hl
	ld a, [hld] ; status ailment
	and a ; does the pokemon have a status ailment?
	jr nz, .fullRestoreHasWork
	push hl
	call CheckCanCureConfusion
	pop hl
	jp nc, .healingItemNoEffect
.fullRestoreHasWork
	ld a, FULL_HEAL
	ld [wcf91], a
	dec hl
	dec hl
	dec hl
	jp .cureStatusAilment

.notFullHP ; if the pokemon's current HP doesn't equal its max HP
	xor a
	ld [wLowHealthAlarm], a ;disable low health alarm
	ld [wChannelSoundIDs + CHAN5], a
	push hl
	push de
	ld bc, wPartyMon1MaxHP - (wPartyMon1HP + 1)
	add hl, bc ; hl now points to max HP
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a ; max HP stored at wHPBarMaxHP (2 bytes, big-endian)
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jp z, .notUsingSoftboiled2
; if using softboiled
	ld hl, wHPBarMaxHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	ld hl, wPartyMon1MaxHP
	ld a, [wWhichPokemon]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ldh [hDividend], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2 ; number of bytes
	call Divide ; get 1/5 of max HP of pokemon that used Softboiled
	ld bc, (wPartyMon1HP + 1) - (wPartyMon1MaxHP + 1)
	add hl, bc ; hl now points to LSB of current HP of pokemon that used Softboiled
; subtract 1/5 of max HP from current HP of pokemon that used Softboiled
	ldh a, [hQuotient + 3]
	push af
	ld b, a
	ld a, [hl]
	ld [wHPBarOldHP], a
	sub b
	ld [hld], a
	ld [wHPBarNewHP], a
	ldh a, [hQuotient + 2]
	ld b, a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	hlcoord 4, 1
	ld a, [wWhichPokemon]
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes ; calculate coordinates of HP bar of pokemon that used Softboiled
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	ldh a, [hUILayoutFlags]
	set 0, a
	ldh [hUILayoutFlags], a
	ld a, $02
	ld [wHPBarType], a
	predef UpdateHPBar2 ; animate HP bar decrease of pokemon that used Softboiled
	ldh a, [hUILayoutFlags]
	res 0, a
	ldh [hUILayoutFlags], a
	pop af
	ld b, a ; store heal amount (1/5 of max HP)
	ld hl, wHPBarOldHP + 1
	pop af
	ld [hld], a
	pop af
	ld [hld], a
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	jr .addHealAmount

.notUsingSoftboiled2
	ld a, [wcf91]
	cp SODA_POP
	ld b, 60 ; Soda Pop heal amount
	jr z, .addHealAmount
	ld b, 80 ; Lemonade heal amount
	jr nc, .addHealAmount
	cp FRESH_WATER
	ld b, 50 ; Fresh Water heal amount
	jr z, .addHealAmount
	cp SUPER_POTION
	ld b, 200 ; Hyper Potion heal amount
	jr c, .addHealAmount
	ld b, 50 ; Super Potion heal amount
	jr z, .addHealAmount
	ld b, 20 ; Potion heal amount
.addHealAmount
	pop de
	pop hl
	ld a, [hl]
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarNewHP+1], a
	jr nc, .noCarry
	inc [hl]
	ld a, [hl]
	ld [wHPBarNewHP + 1], a
.noCarry
	push de
	inc hl
	ld d, h
	ld e, l ; de now points to current HP
	ld hl, (wPartyMon1MaxHP + 1) - (wPartyMon1HP + 1)
	add hl, de ; hl now points to max HP
	ld a, [wcf91]
	cp REVIVE
	jr z, .setCurrentHPToHalfMaxHP
	ld a, [hld]
	ld b, a
	ld a, [de]
	sub b
	dec de
	ld b, [hl]
	ld a, [de]
	sbc b
	jr nc, .setCurrentHPToMaxHp ; if current HP exceeds max HP after healing
	ld a, [wcf91]
	cp HYPER_POTION
	jr c, .setCurrentHPToMaxHp ; if using a Full Restore or Max Potion
	cp MAX_REVIVE
	jr z, .setCurrentHPToMaxHp ; if using a Max Revive
	jr .updateInBattleData

.setCurrentHPToHalfMaxHP
	dec hl
	dec de
	ld a, [hli]
	srl a
	ld [de], a
	ld [wHPBarNewHP+1], a
	ld a, [hl]
	rr a
	inc de
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	jr .doneHealingPartyHP

.setCurrentHPToMaxHp
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
.doneHealingPartyHP ; done updating the pokemon's current HP in the party data structure
	ld a, [wcf91]
	cp FULL_RESTORE
	jr nz, .updateInBattleData
	ld bc, wPartyMon1Status - (wPartyMon1MaxHP + 1)
	add hl, bc
	xor a
	ld [hl], a ; remove the status ailment in the party data
.updateInBattleData
	ld h, d
	ld l, e
	pop de
	ld a, [wPlayerMonNumber]
	cp d ; is pokemon the item was used on active in battle?
	jr nz, .calculateHPBarCoords
; copy party HP to in-battle HP
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
	ld a, [wcf91]
	cp FULL_RESTORE
	jr nz, .calculateHPBarCoords
	xor a
	ld [wBattleMonStatus], a ; remove the status ailment in the in-battle pokemon data
	push hl
	call CureConfusionIfFullHealOrRestore
	pop hl
.calculateHPBarCoords
	hlcoord 4, -1
	ld bc, 2 * SCREEN_WIDTH
	inc d
.calculateHPBarCoordsLoop
	add hl, bc
	dec d
	jr nz, .calculateHPBarCoordsLoop
	jr .doneHealing

.healingItemNoEffect
	call ItemUseNoEffect
	jp .done

.doneHealing
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jr nz, .skipRemovingItem ; no item to remove if using Softboiled
	push hl
	call RemoveUsedItem
	pop hl
.skipRemovingItem
	ld a, [wcf91]
	cp FULL_RESTORE
	jr c, .playStatusAilmentCuringSound
	cp FULL_HEAL
	jr z, .playStatusAilmentCuringSound
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	ldh a, [hUILayoutFlags]
	set 0, a
	ldh [hUILayoutFlags], a
	ld a, $02
	ld [wHPBarType], a
	predef UpdateHPBar2 ; animate the HP bar lengthening
	ldh a, [hUILayoutFlags]
	res 0, a
	ldh [hUILayoutFlags], a
	ld a, REVIVE_MSG
	ld [wPartyMenuTypeOrMessageID], a
	ld a, [wcf91]
	cp REVIVE
	jr z, .showHealingItemMessage
	cp MAX_REVIVE
	jr z, .showHealingItemMessage
	ld a, POTION_MSG
	ld [wPartyMenuTypeOrMessageID], a
	jr .showHealingItemMessage

.playStatusAilmentCuringSound
	ld a, SFX_HEAL_AILMENT
	call PlaySoundWaitForCurrent
.showHealingItemMessage
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	dec a
	ld [wUpdateSpritesEnabled], a
	call RedrawPartyMenu ; redraws the party menu and displays the message
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ld c, 50
	call DelayFrames
	call WaitForTextScrollButtonPress
	jr .done

.canceledItemUse
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item use failed
	pop af
	pop af
.done
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	ret nz ; if so, return
	call GBPalWhiteOut
	call z, RunDefaultPaletteCommand
	ld a, [wIsInBattle]
	and a
	ret nz
	jp ReloadMapData

.useVitamin
	push hl
	ld a, [hl]
	ld [wd0b5], a
	ld [wd11e], a
	ld bc, wPartyMon1Level - wPartyMon1
	add hl, bc ; hl now points to level
	ld a, [hl] ; a = level
	ld [wCurEnemyLVL], a ; store level
	call GetMonHeader
	push de
	ld a, d
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop de
	pop hl
	ld a, [wcf91]
	cp RARE_CANDY
	jp z, .useRareCandy
	push hl
	sub HP_UP
	add a
	ld bc, wPartyMon1HPExp - wPartyMon1
	add hl, bc
	add l
	ld l, a
	jr nc, .noCarry2
	inc h
.noCarry2
	ld a, 10
	ld b, a
	ld a, [hl] ; a = MSB of stat experience of the appropriate stat
	cp 100 ; is there already at least 25600 (256 * 100) stat experience?
	jr nc, .vitaminNoEffect ; if so, vitamins can't add any more
	add b ; add 2560 (256 * 10) stat experience
	jr nc, .noCarry3 ; a carry should be impossible here, so this will always jump
	ld a, 255
.noCarry3
	ld [hl], a
	pop hl
	call .recalculateStats
	ld hl, VitaminStats
	ld a, [wcf91]
	sub HP_UP - 1
	ld c, a
.statNameLoop ; loop to get the address of the name of the stat the vitamin increases
	dec c
	jr z, .gotStatName
.statNameInnerLoop
	ld a, [hli]
	ld b, a
	ld a, $50
	cp b
	jr nz, .statNameInnerLoop
	jr .statNameLoop

.gotStatName
	ld de, wStringBuffer
	ld bc, 10
	call CopyData ; copy the stat's name to wStringBuffer
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, VitaminStatRoseText
	call PrintText
	jp RemoveUsedItem

.vitaminNoEffect
	pop hl
	ld hl, VitaminNoEffectText
	call PrintText
	jp GBPalWhiteOut

.recalculateStats
	ld bc, wPartyMon1Stats - wPartyMon1
	add hl, bc
	ld d, h
	ld e, l ; de now points to stats
	ld bc, (wPartyMon1Exp + 2) - wPartyMon1Stats
	add hl, bc ; hl now points to LSB of experience
	ld b, 1
	jp CalcStats ; recalculate stats
.useRareCandy
	push hl
	ld bc, wPartyMon1Level - wPartyMon1
	add hl, bc ; hl now points to level
	push hl
	ld b, MAX_LEVEL

	ld a, [wDifficulty] ; Check if player is on hard mode
	and a
	jr z, .next1 ; no level caps if not on hard mode

	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr nz, .next1
	farcall GetBadgesObtained
	ld a, [wNumSetBits]
	cp 8
	ld b, 65 ; champion team (highest level in the game)
	jr nc, .next1
	cp 7
	ld b, 55 ; Giovanni's ace, 8th gym (heading to the league)
	jr nc, .next1
	cp 6
	ld b, 55 ; Blaine's ace, 7th gym
	jr nc, .next1
	cp 5
	ld b, 49 ; Sabrina's ace, 6th gym
	jr nc, .next1
    cp 4
	ld b, 45 ; Koga's ace, 5th gym
	jr nc, .next1
	cp 3
	ld b, 38 ; Erika's ace, 4th gym
	jr nc, .next1
	cp 2
    ld b, 34 ; Surge's ace, 3rd gym
	jr nc, .next1
	cp 1
	ld b, 21 ; Misty's ace, 2nd gym
	jr nc, .next1
	ld b, 14 ; Brock's ace, 1st gym
.next1

	pop hl
	ld a, [hl] ; a = level
	cp b ; MAX_LEVEL on normal mode, level cap on hard mode
	jr z, .vitaminNoEffect ; already at the cap (MAX_LEVEL, or badge-tiered cap on hard mode)
	inc a
	ld [hl], a ; store incremented level
	ld [wCurEnemyLVL], a
	push hl
	push de
	ld d, a
	callfar CalcExperience ; calculate experience for next level and store it at hExperience
	pop de
	pop hl
	ld bc, wPartyMon1Exp - wPartyMon1Level
	add hl, bc ; hl now points to MSB of experience
; update experience to minimum for new level
	ldh a, [hExperience]
	ld [hli], a
	ldh a, [hExperience + 1]
	ld [hli], a
	ldh a, [hExperience + 2]
	ld [hl], a
	pop hl
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
	push de
	push hl
	ld bc, wPartyMon1MaxHP - wPartyMon1
	add hl, bc ; hl now points to MSB of max HP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	push bc
	push hl
	call .recalculateStats
	pop hl
	ld bc, (wPartyMon1MaxHP + 1) - wPartyMon1
	add hl, bc ; hl now points to LSB of max HP
	pop bc
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a ; bc = the amount of max HP gained from leveling up
; add the amount gained to the current HP
	ld de, (wPartyMon1HP + 1) - wPartyMon1MaxHP
	add hl, de ; hl now points to LSB of current HP
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	ld a, RARE_CANDY_MSG
	ld [wPartyMenuTypeOrMessageID], a
	call RedrawPartyMenu
	pop de
	ld a, d
	ld [wWhichPokemon], a
	ld a, e
	ld [wd11e], a
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	ld d, $01
	callfar PrintStatsBox ; display new stats text box
	call WaitForTextScrollButtonPress ; wait for button press
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	predef LearnMoveFromLevelUp ; learn level up move, if any

	xor a
	ld [wForceEvolution], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_LEVELUP
	ld a, [wWhichPokemon]
	push af
	ld a, [wUsedItemOnWhichPokemon]
	ld [wWhichPokemon], a
	callfar RespawnOverworldPikachu
	pop af
	ld [wWhichPokemon], a

	callfar TryEvolvingMon ; evolve pokemon, if appropriate
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a
	jp RemoveUsedItem

VitaminStatRoseText:
	text_far _VitaminStatRoseText
	text_end

VitaminNoEffectText:
	text_far _VitaminNoEffectText
	text_end

INCLUDE "data/battle/stat_names.asm"

ItemUseBait:
	ld hl, ThrewBaitText
	call PrintText
; v0.7: BAIT no longer halves the catch rate.
;
; That halving was not a cost, it was a cancellation: it applied during exactly
; the turns the eating protects you for, so the 8x fewer escapes and the half
; odds nullified each other and the item did nothing but spend a turn.
; Simulated over 40,000 encounters it was the worst of the three options --
; worse than throwing nothing -- at three times the balls per catch. Without it
; BAIT becomes the tool for a Pokemon you must not lose (it stays put), while
; ROCK trades a 1.5x flee roll for the SAFARI BALL's x5 becoming x6.
;
; v0.7 catch rework: the "far fewer balls per catch" figure was measured when
; the ROCK DOUBLED the catch rate. It is a flat x1.2 on T now (divisor 48 -> 40),
; so the two jobs are much closer together than that simulation said. The
; CHANGELIST table written from this paragraph is v0.6 arithmetic.
	ld a, BAIT_ANIM
	ld hl, wSafariBaitFactor ; bait factor
	ld de, wSafariEscapeFactor ; escape factor
	jr BaitRockCommon

ItemUseRock:
	ld hl, ThrewRockText
	call PrintText
; v0.7 catch rework: the ROCK no longer doubles the catch rate. It is now the
; SAFARI BALL's own upgrade -- x5 becomes x6 -- read straight off
; wSafariEscapeFactor in GetCatchBallDivisor. One rule instead of two, and the
; bonus expires and cancels on the counter that was already there.
	ld a, ROCK_ANIM
	ld hl, wSafariEscapeFactor ; escape factor
	ld de, wSafariBaitFactor ; bait factor

BaitRockCommon:
; v0.7 anim split: a arrives with BAIT_ANIM or ROCK_ANIM - both specials.
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [wAnimationID], a
	xor a
	ld [wAnimationType], a
	ldh [hWhoseTurn], a
	ld [de], a ; zero escape factor (for bait), zero bait factor (for rock)
.randomLoop ; loop until a random number less than 5 is generated
	call Random
	and 7
	cp 5
	jr nc, .randomLoop
	inc a ; increment the random number, giving a range from 1 to 5 inclusive
	ld b, a
	ld a, [hl]
	add b ; increase bait factor (for bait), increase escape factor (for rock)
	jr nc, .noCarry
	ld a, $ff
.noCarry
	ld [hl], a
	predef MoveAnimation ; do animation
	ld c, 70
	jp DelayFrames

ExpShareSetToOffText:
	text_far _ExpShareSetToOffText
	text_end

ExpShareSetToOneText:
	text_far _ExpShareSetToOneText
	text_end

ExpShareSetToTeamText:
	text_far _ExpShareSetToTeamText
	text_end

ThrewBaitText:
	text_far _ThrewBaitText
	text_end

ThrewRockText:
	text_far _ThrewRockText
	text_end

; also used for Dig out-of-battle effect
ItemUseEscapeRope:
	ld a, [wIsInBattle]
	and a
	jr nz, .notUsable
; v0.7 (2026-08-13, his call): the rope and DIG are for the six caves and
; nothing else, and EscapeRopeTilesets is now CAVERN alone, which IS those six.
; The three maps that used to be excluded by name here -- AGATHAS_ROOM,
; BILLS_HOUSE and POKEMON_FAN_CLUB -- were holes in the CEMETERY and INTERIOR
; entries that no longer exist, so the checks went with them.
	ld a, [wCurMapTileset]
	ld b, a
	ld hl, EscapeRopeTilesets
.loop
	ld a, [hli]
	cp $ff
	jr z, .notUsable
	cp b
	jr nz, .loop
; v0.7 (#41): ESCAPE ROPE and DIG come back out at the mouth the player walked
; in by, not at the last POKeMON CENTER.
;
; Bit 6 of wd732 stays set whichever way this goes: it is not about the
; destination here, it is what makes _LeaveMapAnim spin the player in place and
; lift them instead of calling a bird (player_animations.asm). Bit 3 likewise
; stays, so CloseTextDisplay and LoadMapData behave exactly as they always did.
;
; What changes is where we come out. With a mouth remembered, this becomes an
; ORDINARY warp to that map's own warp -- scripted with bit 3 of wd72d, the same
; signal POKeMON TOWER 7F uses -- and WarpFound2 puts us on the mouth tile and
; steps us off it, which is the code that runs every time anyone walks out of a
; cave. Bit 7 of wd732 is how WarpFound2 knows to leave the way a warp pad does
; rather than play the door sound over an animation that already faded to white.
;
; Only the warp id is handed over here. The MAP is read at warp time, out of
; wEscapeWarpMap, because hWarpDestinationMap shares its byte with hBaseTileID
; and hOAMTile and would be overwritten by the redraw that closes this menu.
;
; With nothing remembered (0: a save that has never once walked in from the
; outside -- the sentinel is 0, NOT $ff, because recycled ds bytes read 0 on
; an old save) it falls through to the vanilla fly warp, unchanged.
; The bike/surf state and wMapPalOffset are NOT touched here. Both were, and both
; were wrong: nothing warps until the next pass through OverworldLoop, and the
; redraw that closes this menu happens in between. WarpFound2's .escapeWarp does
; them at the right moment now.
	ld hl, wd732
	set 3, [hl]
	set 6, [hl]
	res 5, [hl] ; forced to ride bike, as the fly-warp path does
; Bit 7 is cleared FIRST and only set again below when there is somewhere to go.
; It is only ever consumed by WarpFound2, which the no-mouth path never reaches
; -- it goes out through PrepareForSpecialWarp instead -- so a bit left set here
; would survive the whole warp and hijack the next door the player walked into.
	res 7, [hl]
	ld a, [wEscapeWarpMap]
	and a ; 0 = no mouth remembered, which is also what a pre-#41 save holds
	jr z, .noRememberedMouth
	ld a, [wEscapeWarpID]
	ld [wDestinationWarpID], a
	set 7, [hl] ; tell WarpFound2 that this is the escape-rope way out
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
.noRememberedMouth
	call Func_1510
	ld hl, wd72e
	res 4, [hl]
	ResetEvent EVENT_IN_SAFARI_ZONE
	xor a
	ld [wNumSafariBalls], a
	ld [wSafariZoneGateCurScript], a ; SCRIPT_SAFARIZONEGATE_DEFAULT
	inc a
	ld [wEscapedFromBattle], a
	ld [wActionResultOrTookBattleTurn], a ; item used
	ld a, [wPseudoItemID]
	and a ; using Dig?
	ret nz ; if so, return
	call ItemUseReloadOverworldData
	ld c, 30
	call DelayFrames
	jp RemoveUsedItem

.notUsable
	jp ItemUseNotTime

INCLUDE "data/tilesets/escape_rope_tilesets.asm"

ItemUseRepel:
	ld b, 100
	ld a, REPEL
	ld [wRepelType], a

ItemUseRepelCommon:
	ld a, b
	ld [wRepelTypeSteps], a
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, b
	ld [wRepelRemainingSteps], a
	jp PrintItemUseTextAndRemoveItem

; handles X Accuracy item
ItemUseXAccuracy:
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime
	ld hl, wPlayerBattleStatus2
	set USING_X_ACCURACY, [hl] ; X Accuracy bit
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	jp PrintItemUseTextAndRemoveItem

ItemUsePokedoll:
	ld a, [wIsInBattle]
	dec a
	jp nz, ItemUseNotTime
	ld a, $01
	ld [wEscapedFromBattle], a
; v0.7 fix (decision-tree audit 2026-08-29): fleeing by POKE DOLL left
; wBattleResult at 0 = "won", which is how the vanilla ghost-Marowak skip
; worked -- doll the ghost, and the tower opens without the SILPH SCOPE,
; sequence-breaking Fuji, the FLUTE and Silph. Record the escape the same
; way TryRunningFromBattle does, and every script that asks "did the
; player WIN?" gets the true answer. Fixes the class, not just the ghost.
	ld a, $2
	ld [wBattleResult], a
	jp PrintItemUseTextAndRemoveItem

ItemUseGuardSpec:
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime

	ld a, [wWhichPokemon]
	push af
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	pop af
	ld [wWhichPokemon], a

	ld hl, wPlayerBattleStatus2
	set PROTECTED_BY_MIST, [hl] ; Mist bit
	jp PrintItemUseTextAndRemoveItem

ItemUseSuperRepel:
	ld b, 200
	ld a, SUPER_REPEL
	ld [wRepelType], a
	jp ItemUseRepelCommon

ItemUseMaxRepel:
	ld b, 250
	ld a, MAX_REPEL
	ld [wRepelType], a
	jp ItemUseRepelCommon

ItemUseDireHit:
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime

	ld a, [wWhichPokemon]
	push af
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	pop af
	ld [wWhichPokemon], a

	ld hl, wPlayerBattleStatus2
	set GETTING_PUMPED, [hl] ; Focus Energy bit
	jp PrintItemUseTextAndRemoveItem

ItemUseXStat:
	ld a, [wIsInBattle]
	and a
	jr nz, .inBattle
	call ItemUseNotTime
	ld a, 2
	ld [wActionResultOrTookBattleTurn], a ; item not used
	ret

.inBattle
	ld hl, wPlayerMoveNum
	ld a, [hli]
	push af ; save [wPlayerMoveNum]
	ld a, [hl]
	push af ; save [wPlayerMoveEffect]
	push hl
	ld a, [wcf91]
	sub X_ATTACK - ATTACK_UP1_EFFECT
	ld [hl], a ; store player move effect
	call PrintItemUseTextAndRemoveItem
; v0.7 anim split: the X item borrows the move-anim channel - the marker
; goes into wPlayerMoveNum so PlayCurrentMoveAnimation routes to the
; special table, with the real index parked alongside.
	ld a, XSTATITEM_ANIM
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [wPlayerMoveNum], a
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	call Delay3
	xor a
	ldh [hWhoseTurn], a ; set turn to player's turn
	ld [wMoveDidntMiss], a ; v0.7: clear the stale flag -- the anim guard in
	                       ; StatModifierUpEffect read the PREVIOUS action's
	                       ; hit flag and ate XSTATITEM_ANIM whenever it hit
	farcall StatModifierUpEffect ; do stat increase move

	ld a, [wWhichPokemon]
	push af
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	pop af
	ld [wWhichPokemon], a

	pop hl
	pop af
	ld [hld], a ; restore [wPlayerMoveEffect]
	pop af
	ld [hl], a ; restore [wPlayerMoveNum]
	ret

ItemUsePokeflute:
; The flute is the SNORLAX key and nothing else now. In battle it used to wake
; every #MON on both sides for free and forever, which made a SLEEP HEAL and a
; FULL HEAL pointless against sleep the moment you owned one. Forte's call: it
; only works outside battle. The whole in-battle branch, and WakeUpEntireParty
; which only that branch called, are gone rather than left unreachable.
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
; if not in battle
	call ItemUseReloadOverworldData
	ld a, [wCurMap]
	cp ROUTE_12
	jr nz, .notRoute12
	CheckEvent EVENT_BEAT_ROUTE12_SNORLAX
	jr nz, .noSnorlaxOrPikachuToWakeUp
; if the player hasn't beaten Route 12 Snorlax
	ld hl, Route12SnorlaxFluteCoords
	call ArePlayerCoordsInArray
	jr nc, .noSnorlaxOrPikachuToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	SetEvent EVENT_FIGHT_ROUTE12_SNORLAX
	ret

.notRoute12
	cp ROUTE_16
	jr nz, .notRoute16
	CheckEvent EVENT_BEAT_ROUTE16_SNORLAX
	jr nz, .noSnorlaxOrPikachuToWakeUp
; if the player hasn't beaten Route 16 Snorlax
	ld hl, Route16SnorlaxFluteCoords
	call ArePlayerCoordsInArray
	jr nc, .noSnorlaxOrPikachuToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	SetEvent EVENT_FIGHT_ROUTE16_SNORLAX
	ret

.notRoute16
	cp PEWTER_POKECENTER
	jr nz, .noSnorlaxOrPikachuToWakeUp
	call CheckPikachuFollowingPlayer
	jr z, .noSnorlaxOrPikachuToWakeUp
	callfar IsPikachuRightNextToPlayer
	jr nc, .noSnorlaxOrPikachuToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	call ItemUseReloadOverworldData
	ldpikaemotion e, PikachuEmotion26
	callfar PlaySpecificPikachuEmotion
	ret

.noSnorlaxOrPikachuToWakeUp
	ld hl, PlayedFluteNoEffectText
	jp PrintText


Route12SnorlaxFluteCoords:
	dbmapcoord  9, 62 ; one space West of Snorlax
	dbmapcoord 10, 61 ; one space North of Snorlax
	dbmapcoord 10, 63 ; one space South of Snorlax
	dbmapcoord 11, 62 ; one space East of Snorlax
	db -1 ; end

Route16SnorlaxFluteCoords:
	dbmapcoord 27, 10 ; one space East of Snorlax
	dbmapcoord 25, 10 ; one space West of Snorlax
	db -1 ; end

PlayedFluteNoEffectText:
	text_far _PlayedFluteNoEffectText
	text_end

FluteWokeUpText:
	text_far _FluteWokeUpText
	text_end

PlayedFluteHadEffectText:
	text_far _PlayedFluteHadEffectText
	text_promptbutton
	text_asm
	ld a, [wIsInBattle]
	and a
	jr nz, .done
; play out-of-battle pokeflute music
	call StopAllMusic
	ld a, SFX_POKEFLUTE
	ld c, BANK(SFX_Pokeflute)
	call PlayMusic
.musicWaitLoop ; wait for music to finish playing
	ld a, [wChannelSoundIDs + CHAN3]
	cp SFX_POKEFLUTE
	jr z, .musicWaitLoop
	call PlayDefaultMusic ; start playing normal music again
.done
	jp TextScriptEnd ; end text

ItemUseCoinCase:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld hl, CoinCaseNumCoinsText
	jp PrintText

CoinCaseNumCoinsText:
	text_far _CoinCaseNumCoinsText
	text_end

ItemUseOldRod:
	call FishingInit
	jp c, ItemUseNotTime
.RandomLoop
	call Random
	srl a
	jr c, .SetBite
	and %11
	cp 2
	jr nc, .RandomLoop
	; choose which monster appears
	ld hl, OldRodMons
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.SetBite
	ld a, 0
	rla
	xor 1
	jr RodResponse

INCLUDE "data/wild/old_rod.asm"

ItemUseGoodRod:
	call FishingInit
	jp c, ItemUseNotTime
.RandomLoop
	call Random
	srl a
	jr c, .SetBite
	and %11
	cp 2
	jr nc, .RandomLoop
	; choose which monster appears
	ld hl, GoodRodMons
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.SetBite
	ld a, 0
	rla
	xor 1
	jr RodResponse

INCLUDE "data/wild/good_rod.asm"

ItemUseSuperRod:
	call FishingInit
	jp c, ItemUseNotTime
	callfar ReadSuperRodData
	ld c, e
	ld b, d
	ld a, $2
	ld [wRodResponse], a
	ld a, c
	and a ; are there fish in the map?
	jr z, DoNotGenerateFishingEncounter ; if not, do not generate an encounter
	ld a, $1
	ld [wRodResponse], a
	call Random
	and $1
	jr nz, RodResponse
	xor a
	ld [wRodResponse], a
	jr DoNotGenerateFishingEncounter

RodResponse:
	ld [wRodResponse], a

	dec a ; is there a bite?
	jr nz, DoNotGenerateFishingEncounter
	; if yes, store level and species data
	ld a, 1
	ld [wMoveMissed], a
	ld a, b ; level
	ld [wCurEnemyLVL], a
	ld a, c ; species
	ld [wCurOpponent], a

DoNotGenerateFishingEncounter:
	ld hl, wWalkBikeSurfState
	ld a, [hl] ; store the value in a
	push af
	push hl
	ld [hl], 0
	farcall FishingAnim
	pop hl
	pop af
	ld [hl], a
	ret

; checks if fishing is possible and if so, runs initialization code common to all rods
; unsets carry if fishing is possible, sets carry if not
FishingInit:
	ld a, [wIsInBattle]
	and a
	jr z, .notInBattle
	scf ; can't fish during battle
	ret

.notInBattle
	call IsNextTileShoreOrWater
	jr nc, .cannotFish
	ld a, [wWalkBikeSurfState]
	cp 2 ; Surfing?
	jr z, .cannotFish
	call ItemUseReloadOverworldData
	ld hl, ItemUseText00
	call PrintText
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld a, $2
	ld [wd49c], a
	ld a, $81
	ld [wPikachuMood], a
	ld c, 80
	call DelayFrames
	and a
	ret

.cannotFish
	scf ; can't fish when surfing
	ret

ItemUseOaksParcel:
	jp ItemUseNotYoursToUse

ItemUseItemfinder:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	call ItemUseReloadOverworldData
	farcall HiddenItemNear ; check for hidden items
	ld hl, ItemfinderFoundNothingText
	jr nc, .printText ; if no hidden items
	ld c, 4
.loop
	ld a, SFX_HEALING_MACHINE
	call PlaySoundWaitForCurrent
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	dec c
	jr nz, .loop
	ld hl, ItemfinderFoundItemText
.printText
	jp PrintText

ItemfinderFoundItemText:
	text_far _ItemfinderFoundItemText
	text_end

ItemfinderFoundNothingText:
	text_far _ItemfinderFoundNothingText
	text_end

ItemUsePPUp:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime

ItemUsePPRestore:
	; v0.7 hard-mode trainer/boss policy: PP refills (Ether/Max Ether/
	; Elixir/Max Elixir) blocked. Allowed in wild battles AND in any
	; battle on Normal mode. Reason: blocks the "Revive + Elixir"
	; PP-stall loop against bosses while staying symmetric with the
	; boss item bag (knob #10).
	;
	; PP_UP/PP_MAX dispatch to ItemUsePPUp (which blocks all in-battle
	; use, then falls through here for out-of-battle handling). The
	; ETHER..MAX_ELIXIR range check below scopes the gate to refills
	; only — defensive against future dispatch changes.
	ld a, [wIsInBattle]
	and a
	jr z, .allowItem        ; not in battle: allow
	dec a
	jr z, .allowItem        ; wild battle (wIsInBattle=1): allow
	ld a, [wDifficulty]
	cp HARD_MODE
	jr nz, .allowItem       ; trainer battle on Normal mode: allow
	ld a, [wcf91]
	cp ETHER
	jr c, .allowItem        ; below ETHER (PP_UP, PP_MAX): allow
	cp MAX_ELIXIR + 1
	jr nc, .allowItem       ; above MAX_ELIXIR: allow (defensive; nothing above dispatches here)
	ld hl, BattleItemsCantBeUsedHereText
	jp ItemUseFailed
.allowItem
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	ld [wPPRestoreItem], a
.chooseMon
	xor a
	ld [wUpdateSpritesEnabled], a
	ld a, USE_ITEM_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
	jr nc, .chooseMove
	jp .itemNotUsed

.chooseMove
	ld a, [wIsInBattle]
	and a
	jr z, .usePPItem
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b
	jr nz, .usePPItem
	ld a, [wPlayerBattleStatus3]
	bit TRANSFORMED, a
	jr z, .usePPItem
	call ItemUseNotTime
	jp .itemNotUsed

.usePPItem
	ld a, [wPPRestoreItem]
; v0.7 FIX: the PP_MAX check used to sit HERE, before the move-selection menu
; below — but .usePPMax needs hl to point at the CHOSEN move, and hl only
; becomes valid after GetSelectedMoveOffset. Intercepted this early it inherited
; whatever DisplayPartyMenu had left in hl, so it wrote PP-Up bits into party
; mon 1's experience/stat-exp and then hard-locked on the second use. The check
; now lives just after `pop hl` further down. PP_MAX ($32) is below ELIXIR
; ($52), so it correctly falls through to the move-selection path from here.
	cp ELIXIR
	jp nc, .useElixir ; if Elixir or Max Elixir
	ld a, $02
	ld [wMoveMenuType], a
	ld hl, RaisePPWhichTechniqueText
	ld a, [wPPRestoreItem]
	cp ETHER ; is it a PP Up?
	jr c, .printWhichTechniqueMessage ; if so, print the raise PP message
	ld hl, RestorePPWhichTechniqueText ; otherwise, print the restore PP message
.printWhichTechniqueMessage
	call PrintText
	xor a
	ld [wPlayerMoveListIndex], a
	callfar MoveSelectionMenu ; move selection menu
	ld a, 0
	ld [wPlayerMoveListIndex], a
	jr nz, .chooseMon
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call GetSelectedMoveOffset
	push hl
	ld a, [hl]
	ld [wd11e], a
	call GetMoveName
	call CopyToStringBuffer
	pop hl
	ld a, [wPPRestoreItem]
	cp PP_MAX
	jp z, .usePPMax ; hl now points at the chosen move, which .usePPMax requires
	cp ETHER
	jp nc, .useEther ; if Ether or Max Ether (jp not jr: PP_MAX expansion pushed .useEther out of jr range)
.usePPUp
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	ld a, [hl] ; move PP
	cp 3 << 6 ; have 3 PP Ups already been used?
	jr c, .PPNotMaxedOut
	ld hl, PPMaxedOutText
	call PrintText
	jr .chooseMove

.PPNotMaxedOut
	ld a, [hl]
	add 1 << 6 ; increase PP Up count by 1
	ld [hl], a
	ld a, 1 ; 1 PP Up used
	ld [wd11e], a
	call RestoreBonusPP ; add the bonus PP to current PP
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, PPIncreasedText
	call PrintText
	jp .done

; PP Max bumps the chosen move straight to the maximum 3 PP Ups in one use,
; applying each missing bonus to the current PP. Functionally equivalent to
; calling PP Up enough times to hit the cap, but in a single inventory action.
.usePPMax
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc                 ; hl -> chosen move's PP byte
	ld a, [hl]
	cp 3 << 6                  ; already at 3 PP Ups?
	jr c, .ppMaxLoop
	ld hl, PPMaxedOutText
	call PrintText
	jp .chooseMove
.ppMaxLoop
	ld a, [hl]
	cp 3 << 6
	jr nc, .ppMaxFinish        ; reached the cap
	add 1 << 6                 ; +1 PP Up
	ld [hl], a
	push hl
	ld a, 1                    ; signal "1 PP Up used" so RestoreBonusPP
	ld [wd11e], a              ; only adds one bonus per call
	call RestoreBonusPP
	pop hl
	jr .ppMaxLoop
.ppMaxFinish
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, PPIncreasedText
	call PrintText
.done
	pop af
	ld [wWhichPokemon], a
	call GBPalWhiteOut
	call RunDefaultPaletteCommand
	jp RemoveUsedItem

.afterRestoringPP ; after using a (Max) Ether/Elixir
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b ; is the pokemon whose PP was restored active in battle?
	jr nz, .skipUpdatingInBattleData
	ld hl, wPartyMon1PP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld de, wBattleMonPP
	ld bc, 4
	call CopyData ; copy party data to in-battle data
.skipUpdatingInBattleData
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, PPRestoredText
	call PrintText
	jr .done

.useEther
	call .restorePP
	jr nz, .afterRestoringPP
	jp .noEffect

; unsets zero flag if PP was restored, sets zero flag if not
.restorePP
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call GetMaxPP
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call GetSelectedMoveOffset
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc ; hl now points to move's PP
	ld a, [wMaxPP]
	ld b, a
	ld a, [wPPRestoreItem]
	cp MAX_ETHER
	jr z, .fullyRestorePP
	ld a, [hl] ; move PP
	and %00111111 ; lower 6 bit bits store current PP
	cp b ; does current PP equal max PP?
	ret z ; if so, return
	add 10 ; increase current PP by 10
; b holds the max PP amount and b will hold the new PP amount.
; So, if the new amount meets or exceeds the max amount,
; cap the amount to the max amount by leaving b unchanged.
; Otherwise, store the new amount in b.
	cp b ; does the new amount meet or exceed the maximum?
	jr nc, .storeNewAmount
	ld b, a
.storeNewAmount
	ld a, [hl] ; move PP
	and %11000000 ; PP Up counter bits
	add b
	ld [hl], a
	ret

.fullyRestorePP
	ld a, [hl] ; move PP
	and %00111111 ; lower 6 bits store current PP
	cp b ; does current PP equal max PP?
	ret z
	jr .storeNewAmount

.useElixir
; decrement the item ID so that ELIXIR becomes ETHER and MAX_ELIXIR becomes MAX_ETHER
	ld hl, wPPRestoreItem
	dec [hl]
	dec [hl]
	xor a
	ld hl, wCurrentMenuItem
	ld [hli], a
	ld [hl], a ; zero the counter for number of moves that had their PP restored
	ld b, 4
; loop through each move and restore PP
.elixirLoop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call GetSelectedMoveOffset
	ld a, [hl]
	and a ; does the current slot have a move?
	jr z, .nextMove
	call .restorePP
	jr z, .nextMove
; if some PP was restored
	ld hl, wTileBehindCursor ; counter for number of moves that had their PP restored
	inc [hl]
.nextMove
	ld hl, wCurrentMenuItem
	inc [hl]
	pop bc
	dec b
	jr nz, .elixirLoop
	ld a, [wTileBehindCursor]
	and a ; did any moves have their PP restored?
	jp nz, .afterRestoringPP
.noEffect
	call ItemUseNoEffect
.itemNotUsed
	call GBPalWhiteOut
	call RunDefaultPaletteCommand
	pop af
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item use failed
	ret

RaisePPWhichTechniqueText:
	text_far _RaisePPWhichTechniqueText
	text_end

RestorePPWhichTechniqueText:
	text_far _RestorePPWhichTechniqueText
	text_end

PPMaxedOutText:
	text_far _PPMaxedOutText
	text_end

PPIncreasedText:
	text_far _PPIncreasedText
	text_end

PPRestoredText:
	text_far _PPRestoredText
	text_end

; for items that can't be used from the Item menu
UnusableItem:
	jp ItemUseNotTime

ItemUseTMHM:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wcf91]
	sub TM01 ; underflows below 0 for HM items (before TM items)
	push af
	jr nc, .skipAdding
	add NUM_TMS + NUM_HMS ; adjust HM IDs to come after TM IDs
.skipAdding
	inc a
	ld [wd11e], a
	predef TMToMove ; get move ID from TM/HM ID
	ld a, [wd11e]
	ld [wMoveNum], a
	call GetMoveName
	call CopyToStringBuffer
	pop af
	ld hl, BootedUpTMText
	jr nc, .printBootedUpMachineText
	ld hl, BootedUpHMText
.printBootedUpMachineText
	call PrintText
	ld hl, TeachMachineMoveText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jr z, .useMachine
	ld a, 2
	ld [wActionResultOrTookBattleTurn], a ; item not used
	ret

.useMachine
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
.chooseMon
	ld hl, wStringBuffer
	ld de, wTempMoveNameBuffer
	ld bc, 14
	call CopyData ; save the move name because DisplayPartyMenu will overwrite it
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, TMHM_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
	push af
	ld hl, wTempMoveNameBuffer
	ld de, wStringBuffer
	ld bc, 14
	call CopyData
	pop af
	jr nc, .checkIfAbleToLearnMove
; if the player canceled teaching the move
	pop af
	pop af
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RunDefaultPaletteCommand
	jp LoadScreenTilesFromBuffer1 ; restore saved screen
.checkIfAbleToLearnMove
	predef CanLearnTM ; check if the pokemon can learn the move
	push bc
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop bc
	ld a, c
	and a ; can the pokemon learn the move?
	jr nz, .checkIfAlreadyLearnedMove
; if the pokemon can't learn the move
	ld a, SFX_DENIED
	call PlaySoundWaitForCurrent
	ld hl, MonCannotLearnMachineMoveText
	call PrintText
	jr .chooseMon

.checkIfAlreadyLearnedMove
	callfar CheckIfMoveIsKnown ; check if the pokemon already knows the move
	jr c, .chooseMon
	predef LearnMove ; teach move
	ld a, [wWhichPokemon]
	ld d, a
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a
	ld a, b
	and a
	ret z

	ld a, [wWhichPokemon]
	push af
	ld a, d
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDTMHM
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .notTeachingThunderboltOrThunderToPikachu
	ld a, [wcf91]
	cp TM_THUNDERBOLT ; teaching Thunderbolt to the player's Pikachu?
	jr nz, .notTeachingThunderboltOrThunderToPikachu ; (Thunder is no longer a TM)
.teachingThunderboltOrThunderToPlayerPikachu
	ld a, $5
	ld [wd49c], a
	ld a, $85
	ld [wPikachuMood], a
.notTeachingThunderboltOrThunderToPikachu
	pop af
	ld [wWhichPokemon], a

	ld a, [wcf91]
	call IsItemHM
	ret c
	jp RemoveUsedItem

BootedUpTMText:
	text_far _BootedUpTMText
	text_end

BootedUpHMText:
	text_far _BootedUpHMText
	text_end

TeachMachineMoveText:
	text_far _TeachMachineMoveText
	text_end

MonCannotLearnMachineMoveText:
	text_far _MonCannotLearnMachineMoveText
	text_end

PrintItemUseTextAndRemoveItem:
	ld hl, ItemUseText00
	call PrintText
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	call WaitForTextScrollButtonPress ; wait for button press

RemoveUsedItem:
	ld hl, wNumBagItems
	ld a, 1 ; one item
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

ItemUseNoEffect:
	ld hl, ItemUseNoEffectText
	jr ItemUseFailed

ItemUseNotTime:
	ld hl, ItemUseNotTimeText
	jr ItemUseFailed

ItemUseNotYoursToUse:
	ld hl, ItemUseNotYoursToUseText
	jr ItemUseFailed

Func_e4bf:
	ld a, $2
	ld [wActionResultOrTookBattleTurn], a
	ld hl, DontHavePokemonText
	jp PrintText

ThrowBallAtTrainerMon:
	call RunDefaultPaletteCommand
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	call Delay3
	ld a, TOSS_ANIM ; v0.7 anim split: a SPECIAL - marker + parked index
	ldh [hSpecialAnimIndex], a
	ld a, SPECIAL_ANIM_MARKER
	ld [wAnimationID], a
	predef MoveAnimation ; do animation
	ld hl, ThrowBallAtTrainerMonText1
	call PrintText
	ld hl, ThrowBallAtTrainerMonText2
	call PrintText
	jr RemoveUsedItem

NoCyclingAllowedHere:
	ld hl, NoCyclingAllowedHereText
	jr ItemUseFailed

BoxFullCannotThrowBall:
	ld hl, BoxFullCannotThrowBallText
	jr ItemUseFailed

SurfingAttemptFailed:
	ld hl, NoSurfingHereText

ItemUseFailed:
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item use failed
	jp PrintText

ItemUseNotTimeText:
	text_far _ItemUseNotTimeText
	text_end

; Local wrapper for item handlers in this bank to use with PrintText. We
; can't share core.asm's `ItemsCantBeUsedHereText` wrapper directly (single-
; colon labels in RGBDS are still globally exported, so reusing the name
; would be a link conflict — see commit history). Both wrappers point at
; the same exported `_ItemsCantBeUsedHereText::` in data/text/text_2.asm.
BattleItemsCantBeUsedHereText:
	text_far _ItemsCantBeUsedHereText
	text_end

ItemUseNotYoursToUseText:
	text_far _ItemUseNotYoursToUseText
	text_end

ItemUseNoEffectText:
	text_far _ItemUseNoEffectText
	text_end

ThrowBallAtTrainerMonText1:
	text_far _ThrowBallAtTrainerMonText1
	text_end

ThrowBallAtTrainerMonText2:
	text_far _ThrowBallAtTrainerMonText2
	text_end

NoCyclingAllowedHereText:
	text_far _NoCyclingAllowedHereText
	text_end

NoSurfingHereText:
	text_far _NoSurfingHereText
	text_end

BoxFullCannotThrowBallText:
	text_far _BoxFullCannotThrowBallText
	text_end

DontHavePokemonText:
	text_far _DontHavePokemonText
	text_end

ItemUseText00:
	text_far _ItemUseText001
	text_low
	text_far _ItemUseText002
	text_end

GotOnBicycleText:
	text_far _GotOnBicycleText1
	text_low
	text_far _GotOnBicycleText2
	text_end

GotOffBicycleText:
	text_far _GotOffBicycleText1
	text_low
	text_far _GotOffBicycleText2
	text_end

; restores bonus PP (from PP Ups) when healing at a pokemon center
; also, when a PP Up is used, it increases the current PP by one PP Up bonus
; INPUT:
; [wWhichPokemon] = index of pokemon in party
; [wCurrentMenuItem] = index of move (when using a PP Up)
RestoreBonusPP:
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	push hl
	ld de, wNormalMaxPPList - 1
	predef LoadMovePPs ; loads the normal max PP of each of the pokemon's moves to wNormalMaxPPList
	pop hl
	ld c, wPartyMon1PP - wPartyMon1Moves
	ld b, 0
	add hl, bc ; hl now points to move 1 PP
	ld de, wNormalMaxPPList
	ld b, 0 ; initialize move counter to zero
; loop through the pokemon's moves
.loop
	inc b
	ld a, b
	cp 5 ; reached the end of the pokemon's moves?
	ret z ; if so, return
	ld a, [wUsingPPUp]
	dec a ; using a PP Up?
	jr nz, .skipMenuItemIDCheck
; if using a PP Up, check if this is the move it's being used on
	ld a, [wCurrentMenuItem]
	inc a
	cp b
	jr nz, .nextMove
.skipMenuItemIDCheck
	ld a, [hl]
	and %11000000 ; have any PP Ups been used?
	call nz, AddBonusPP ; if so, add bonus PP
.nextMove
	inc hl
	inc de
	jr .loop

; adds bonus PP from PP Ups to current PP
; 1/5 of normal max PP (capped at 7) is added for each PP Up
; INPUT:
; [de] = normal max PP
; [hl] = move PP
AddBonusPP:
	push bc
	ld a, [de] ; normal max PP of move
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ld a, [hl] ; move PP
	ld b, a
	swap a
	and %00001111
	srl a
	srl a
	ld c, a ; c = number of PP Ups used
.loop
	ldh a, [hQuotient + 3]
	cp 8 ; is the amount greater than or equal to 8?
	jr c, .addAmount
	ld a, 7 ; cap the amount at 7
.addAmount
	add b
	ld b, a
	ld a, [wUsingPPUp]
	dec a ; is the player using a PP Up right now?
	jr z, .done ; if so, only add the bonus once
	dec c
	jr nz, .loop
.done
	ld [hl], b
	pop bc
	ret

; gets max PP of a pokemon's move (including PP from PP Ups)
; INPUT:
; [wWhichPokemon] = index of pokemon within party/box
; [wMonDataLocation] = pokemon source
; 00: player's party
; 01: enemy's party
; 02: current box
; 03: daycare
; 04: player's in-battle pokemon
; [wCurrentMenuItem] = move index
; OUTPUT:
; [wMaxPP] = max PP
GetMaxPP:
	ld a, [wMonDataLocation]
	and a
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	jr z, .sourceWithMultipleMon
	ld hl, wEnemyMon1Moves
	dec a
	jr z, .sourceWithMultipleMon
	ld hl, wBoxMon1Moves
	ld bc, wBoxMon2 - wBoxMon1
	dec a
	jr z, .sourceWithMultipleMon
	ld hl, wDayCareMonMoves
	dec a
	jr z, .sourceWithOneMon
	ld hl, wBattleMonMoves ; player's in-battle pokemon
.sourceWithOneMon
	call GetSelectedMoveOffset2
	jr .next

.sourceWithMultipleMon
	call GetSelectedMoveOffset
.next
	ld a, [hl]
	dec a
	push hl
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wcd6d
	ld a, BANK(Moves)
	call FarCopyData
	ld de, wcd6d + 5 ; PP is byte 5 of move data
	ld a, [de]
	ld b, a ; b = normal max PP
	pop hl
	push bc
	ld bc, wPartyMon1PP - wPartyMon1Moves ; PP offset if not player's in-battle pokemon data
	ld a, [wMonDataLocation]
	cp 4 ; player's in-battle pokemon?
	jr nz, .addPPOffset
	ld bc, wBattleMonPP - wBattleMonMoves ; PP offset if player's in-battle pokemon data
.addPPOffset
	add hl, bc
	ld a, [hl] ; a = current PP
	and %11000000 ; get PP Up count
	pop bc
	or b ; place normal max PP in 6 lower bits of a
	ld h, d
	ld l, e
	inc hl ; hl = wcd73
	ld [hl], a
	xor a ; add the bonus for the existing PP Up count
	ld [wUsingPPUp], a
	call AddBonusPP ; add bonus PP from PP Ups
	ld a, [hl]
	and %00111111 ; mask out the PP Up count
	ld [wMaxPP], a ; store max PP
	ret

GetSelectedMoveOffset:
	ld a, [wWhichPokemon]
	call AddNTimes

GetSelectedMoveOffset2:
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	add hl, bc
	ret

; confirms the item toss and then tosses the item
; INPUT:
; hl = address of inventory (either wNumBagItems or wNumBoxItems)
; [wcf91] = item ID
; [wWhichPokemon] = index of item within inventory
; [wItemQuantity] = quantity to toss
; OUTPUT:
; clears carry flag if the item is tossed, sets carry flag if not
TossItem_::
	push hl
	ld a, [wcf91]
	call IsItemHM
	pop hl
	jr c, .tooImportantToToss
	push hl
	call IsKeyItem_
	ld a, [wIsKeyItem]
	pop hl
	and a
	jr nz, .tooImportantToToss
	push hl
	ld a, [wcf91]
	ld [wd11e], a
	call GetItemName
	call CopyToStringBuffer
	ld hl, IsItOKToTossItemText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wMenuExitMethod]
	cp CHOSE_SECOND_ITEM
	pop hl
	scf
	ret z ; return if the player chose No
; if the player chose Yes
	push hl
	ld a, [wWhichPokemon]
	call RemoveItemFromInventory
	ld a, [wcf91]
	ld [wd11e], a
	call GetItemName
	call CopyToStringBuffer
	ld hl, ThrewAwayItemText
	call PrintText
	pop hl
	and a
	ret

.tooImportantToToss
	push hl
	ld hl, TooImportantToTossText
	call PrintText
	pop hl
	scf
	ret

ThrewAwayItemText:
	text_far _ThrewAwayItemText
	text_end

IsItOKToTossItemText:
	text_far _IsItOKToTossItemText
	text_end

TooImportantToTossText:
	text_far _TooImportantToTossText
	text_end

; checks if an item is a key item
; INPUT:
; [wcf91] = item ID
; OUTPUT:
; [wIsKeyItem] = result
; 00: item is not key item
; 01: item is key item
IsKeyItem_::
	ld a, $01
	ld [wIsKeyItem], a
	ld a, [wcf91]
	cp HM01 ; is the item an HM or TM?
	jr nc, .checkIfItemIsHM
; if the item is not an HM or TM
	push af
	ld hl, KeyItemFlags
	ld de, wBuffer
	ld bc, 15 ; only 11 bytes are actually used
	ASSERT 15 >= (NUM_ITEMS + 7) / 8
	call CopyData
	pop af
	dec a
	ld c, a
	ld hl, wBuffer
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret nz
.checkIfItemIsHM
	ld a, [wcf91]
	call IsItemHM
	ret c
	xor a
	ld [wIsKeyItem], a
	ret

INCLUDE "data/items/key_items.asm"

SendNewMonToBox:
	ld de, wBoxCount
	ld a, [de]
	inc a
	ld [de], a
	ld a, [wcf91]
	ld [wd0b5], a
	ld c, a
.loop
	inc de
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	cp $ff
	jr nz, .loop
	call GetMonHeader
	ld hl, wBoxMonOT
	ld bc, NAME_LENGTH
	ld a, [wBoxCount]
	dec a
	jr z, .skip
	dec a
	call AddNTimes
	push hl
	ld bc, NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a
.loop2
	push bc
	push hl
	ld bc, NAME_LENGTH
	call CopyData
	pop hl
	ld d, h
	ld e, l
	ld bc, -NAME_LENGTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2
.skip
	ld hl, wPlayerName
	ld de, wBoxMonOT
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wBoxCount]
	dec a
	jr z, .skip2
	ld hl, wBoxMonNicks
	ld bc, NAME_LENGTH
	dec a
	call AddNTimes
	push hl
	ld bc, NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a
.loop3
	push bc
	push hl
	ld bc, NAME_LENGTH
	call CopyData
	pop hl
	ld d, h
	ld e, l
	ld bc, -NAME_LENGTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop3
.skip2
	ld hl, wBoxMonNicks
	ld a, NAME_MON_SCREEN
	ld [wNamingScreenType], a
	predef AskName
	ld a, [wBoxCount]
	dec a
	jr z, .skip3
	ld hl, wBoxMons
	ld bc, wBoxMon2 - wBoxMon1
	dec a
	call AddNTimes
	push hl
	ld bc, wBoxMon2 - wBoxMon1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a
.loop4
	push bc
	push hl
	ld bc, wBoxMon2 - wBoxMon1
	call CopyData
	pop hl
	ld d, h
	ld e, l
	ld bc, wBoxMon1 - wBoxMon2
	add hl, bc
	pop bc
	dec b
	jr nz, .loop4
.skip3
	ld a, [wEnemyMonLevel]
	ld [wEnemyMonBoxLevel], a
	ld hl, wEnemyMon
	ld de, wBoxMon1
	ld bc, wEnemyMonDVs - wEnemyMon
	call CopyData
	ld hl, wPlayerID
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de
	ld a, [wCurEnemyLVL]
	ld d, a
	callfar CalcExperience
	pop de
	ldh a, [hExperience]
	ld [de], a
	inc de
	ldh a, [hExperience + 1]
	ld [de], a
	inc de
	ldh a, [hExperience + 2]
	ld [de], a
	inc de
	xor a
	ld b, NUM_STATS * 2
.loop5
	ld [de], a
	inc de
	dec b
	jr nz, .loop5
	ld hl, wEnemyMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld hl, wEnemyMonPP
	ld b, NUM_MOVES
.loop6
	ld a, [hli]
	inc de
	ld [de], a
	dec b
	jr nz, .loop6
	ld a, [wcf91]
	cp KADABRA
	jr nz, .notKadabra
	ld a, TWISTEDSPOON_GSC
	ld [wBoxMon1CatchRate], a
.notKadabra
	ret

; checks if the tile in front of the player is a shore or water tile
; used for surfing and fishing
; unsets carry if it is, sets carry if not
IsNextTileShoreOrWater::
	ld a, [wCurMapTileset]
	ld hl, WaterTilesets
	ld de, 1
	call IsInArray ; does the current map allow surfing?
	ret nc ; if not, return
	ld hl, WaterTile
	ld a, [wCurMapTileset]
	cp SHIP_PORT ; Vermilion Dock tileset
	jr z, .skipShoreTiles ; if it's the Vermilion Dock tileset
	cp GYM ; eastern shore tile in Safari Zone
	jr z, .skipShoreTiles
	cp DOJO ; usual eastern shore tile
	jr z, .skipShoreTiles
	ld hl, ShoreTiles
.skipShoreTiles
	ld a, [wTileInFrontOfPlayer]
	ld de, $1
	call IsInArray
	ret

INCLUDE "data/tilesets/water_tilesets.asm"

; reloads map view and processes sprite data
; for items that cause the overworld to be displayed
ItemUseReloadOverworldData:
	call LoadCurrentMapView
	jp UpdateSprites

; creates a list at wBuffer of maps where the mon in [wd11e] can be found.
; this is used by the pokedex to display locations the mon can be found on the map.
FindWildLocationsOfMon:
	ld hl, WildDataPointers
	ld de, wBuffer
	ld c, $0
.loop
	inc hl
	ld a, [hld]
	inc a
	jr z, .done
; v0.7 (his playtest 2026-08-28): BILL's garden is a secret map, absent from
; the town map on purpose -- but its wild table was scanned like any public
; map, and its town-map row (which exists only to terminate the interval
; lookup in LoadTownMapEntry) rendered its habitats as a nest on BILL's LAB
; at the east end of ROUTE 25. Skip it here, at the source, so no consumer
; of the nest list ever sees it. Every garden species is wild or pinned
; somewhere public, so nothing loses its AREA page (checked 2026-08-28);
; a future garden-ONLY species would show AREA UNKNOWN, the Mewtwo path.
	ld a, c
	cp BILLS_GARDEN
	jr z, .next
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	and a
	call nz, CheckMapForMon ; land
	ld a, [hli]
	and a
	call nz, CheckMapForMon ; water
	pop hl
.next
	inc hl
	inc hl
	inc c
	jr .loop
.done
	farcall CheckMapForFishingMon ; fishing
	call AddStaticEncounters
	ld a, $ff ; list terminator
	ld [de], a
	ret

CheckMapForMon:
	inc hl
	ld b, NUM_WILDMONS
.loop
	ld a, [wd11e]
	cp [hl]
	jr nz, .nextEntry
; v0.7 fix: wBuffer is only 30 bytes and FindWildLocationsOfMon appends an $ff
; terminator after us, so the last entry may not pass wBuffer+28. Krabby,
; Poliwag, Horsea and Goldeen are matched on EVERY Super Rod map (see the
; shortcut in data/wild/super_rod.asm), which overran the buffer by up to 13
; bytes and silently clobbered live engine state from wAnimSoundID onward every
; time their Pokedex AREA page was opened. Stop writing once it is full; the
; AREA screen is sprite-limited anyway, so a truncated list looks identical.
	ld a, d
	cp HIGH(wBuffer + 29)
	jr c, .hasRoom
	ld a, e
	cp LOW(wBuffer + 29)
	jr nc, .nextEntry
.hasRoom
	ld a, c
	ld [de], a
	inc de
.nextEntry
	inc hl
	inc hl
	dec b
	jr nz, .loop
	dec hl
	ret

AddStaticEncounters: ; manually add gift mons, static encounters and fossil locations
	ld a, [wd11e]
	cp MAGIKARP
	ld b, ROUTE_4
	jp z, .addEncounter
	cp CHARMANDER
	ld b, ROUTE_24
	jp z, .addEncounter
	cp SQUIRTLE
	ld b, VERMILION_CITY
	jp z, .addEncounter
	cp BULBASAUR
	ld b, CERULEAN_CITY
	jp z, .addEncounter
	cp SNORLAX
	jp z, .addSnorlax
	cp EEVEE
	jp z, .addCeladon
	cp LAPRAS
	jp z, .addSaffron
	cp OMANYTE
	jp z, .addFossils
	cp KABUTO
	jp z, .addFossils
	cp AERODACTYL
	ld b, PEWTER_CITY
	jr z, .addEncounter
	cp HITMONCHAN
	jr z, .addSaffron
	cp HITMONLEE
	jr z, .addSaffron
	cp VOLTORB
	jr z, .addPowerPlant
	cp ELECTRODE
	jr z, .addPowerPlant
	cp ARTICUNO
	ld b, SEAFOAM_ISLANDS_B4F
	jr z, .addEncounter
	cp ZAPDOS
	jr z, .addPowerPlant
	cp MOLTRES
	ld b, VICTORY_ROAD_2F
	jr z, .addEncounter
	cp MEWTWO
	ld b, CERULEAN_CAVE_B1F
	jr z, .addEncounter
	; trade mons
	cp MR_MIME
	ld b, ROUTE_2
	jr z, .addEncounter
	cp DUGTRIO
	ld b, ROUTE_11
	jr z, .addEncounter
	cp PARASECT
	ld b, ROUTE_18
	jr z, .addEncounter
	cp RHYDON
	jr z, .addCinnabarIsland
	cp JYNX
	jr z, .addSaffron
	; game corner mons (current casino roster; starters/Eevee/Jynx pinned above)
	cp MAGMAR
	jr z, .addCeladon
	cp ELECTABUZZ
	jr z, .addCeladon
	cp PORYGON
	jr z, .addCeladon
	ret
.addEncounter
	ld a, b
	ld [de], a
	inc de
	ret
.addSnorlax
	ld a, ROUTE_12
	ld [de], a
	inc de
	ld a, ROUTE_16
	ld [de], a
	inc de
	ret
.addFossils
	ld a, MT_MOON_B2F
	ld [de], a
	inc de
	ld a, FUCHSIA_CITY
	ld [de], a
	inc de
	ret
; These four were `jr z` in vanilla, which only worked because the Z flag from
; the caller's `cp` was still set — making each one silently dependent on its
; position in this chain. `.addCeladon` is the last, so a Z-clear entry there
; would have fallen straight into DrawBadges. Unconditional `jr` is the same
; two bytes and behaves identically today, but can't rot.
.addSaffron
	ld b, SAFFRON_CITY
	jr .addEncounter
.addPowerPlant
	ld b, POWER_PLANT
	jr .addEncounter
.addCinnabarIsland
	ld b, CINNABAR_ISLAND
	jr .addEncounter
.addCeladon
	ld b, CELADON_CITY
	jr .addEncounter
