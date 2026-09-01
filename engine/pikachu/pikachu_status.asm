IsStarterPikachuInOurParty::
	ld hl, wPartySpecies
	ld de, wPartyMon1OTID
	ld bc, wPartyMonOT
	push hl
.loop
	pop hl
	ld a, [hli]
	push hl
	inc a
	jr z, .noPlayerPikachu
	cp STARTER_PIKACHU + 1
	jr nz, .curMonNotPlayerPikachu
; v0.7 (2026-08-31, Forte's playtest): the same marker test the per-mon
; IsThisPartymonStarterPikachu already does - species, OTID and OT name
; ALL pass for a Pikachu the player catches in the wild (the player is
; its OT), so depositing the starter left a caught Route 1 Pikachu
; walking behind the player. Only the starter carries LIGHT_BALL_GSC in
; its catch-rate byte (OaksLab writes it right after AddPartyMon), and
; Gen 1 gives the player no way to change that byte.
	ld h, d
	ld l, e
	push bc
	ld bc, wPartyMon1CatchRate - wPartyMon1OTID
	add hl, bc
	pop bc
	ld a, [hl]
	cp LIGHT_BALL_GSC
	jr nz, .curMonNotPlayerPikachu
	ld h, d
	ld l, e
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .curMonNotPlayerPikachu
	inc hl
	ld a, [wPlayerID+1]
	cp [hl]
	jr nz, .curMonNotPlayerPikachu
	push de
	push bc
	ld hl, wPlayerName
	ld d, $6 ; possible player length - 1
.nameCompareLoop
	dec d
	jr z, .sameOT
	ld a, [bc]
	inc bc
	cp [hl]
	inc hl
	jr z, .nameCompareLoop
	pop bc
	pop de
.curMonNotPlayerPikachu
	ld hl, wPartyMon2 - wPartyMon1
	add hl, de
	ld d, h
	ld e, l
	ld hl, NAME_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	jr .loop

.sameOT
	pop bc
	pop de
	ld h, d
	ld l, e
	ld bc, -NAME_LENGTH
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .noPlayerPikachu ; jr z, .noPlayerPikachu ; OTID - NAME_LENGTH points at current HP; a fainted Pikachu doesn't count
	pop hl
	scf
	ret

.noPlayerPikachu
	pop hl
	and a
	ret

IsThisPartymonStarterPikachu_Box::
	ld hl, wBoxMon1
	ld bc, wBoxMon2 - wBoxMon1
	ld de, wBoxMonOT
	jr asm_fce21

IsThisPartymonStarterPikachu_Party::
IsThisPartymonStarterPikachu::
	ld hl, wPartyMon1
	ld bc, wPartyMon2 - wPartyMon1
	ld de, wPartyMonOT
asm_fce21:
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [hl]
	cp STARTER_PIKACHU
	jr nz, .notPlayerPikachu
	; v0.7: STARTER_PIKACHU is only an alias for PIKACHU, and the OT id and
	; OT name below match ANY Pokemon the player caught themselves -- so once
	; wild PIKACHU exist (Route 1 / Power Plant), a caught one passed all
	; three tests and the game treated it as the partner: it would refuse the
	; Thunder Stone and pick up the follow/emotion behaviour. Vanilla Yellow
	; never had to care, because the starter was the only Pikachu in the game.
	; The starter already carries a unique marker for the GSC Time Capsule --
	; OaksLab writes LIGHT_BALL_GSC into its catch-rate byte right after
	; AddPartyMon -- so test that too. A wild Pikachu keeps its species catch
	; rate, and Gen 1 has no way for the player to change the byte.
	; The offset is the same in the box struct, which shares this code path
	; (both structs are identical up to and including the PP bytes), exactly
	; like the OTID offset used just below.
	push hl
	ld bc, wPartyMon1CatchRate - wPartyMon1
	add hl, bc
	ld a, [hl]
	pop hl
	cp LIGHT_BALL_GSC
	jr nz, .notPlayerPikachu
	ld bc, wPartyMon1OTID - wPartyMon1
	add hl, bc
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .notPlayerPikachu
	inc hl
	ld a, [wPlayerID+1]
	cp [hl]
	jr nz, .notPlayerPikachu
	ld h, d
	ld l, e
	ld a, [wWhichPokemon]
	ld bc, NAME_LENGTH
	call AddNTimes
	ld de, wPlayerName
	ld b, $6
.loop
	dec b
	jr z, .isPlayerPikachu
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr z, .loop
.notPlayerPikachu
	and a
	ret

.isPlayerPikachu
	scf
	ret

UseFakePikachuFrontPic::
; v0.7 (2026-08-31, Forte's request): the second Pikachu. The partner
; keeps the Yellow front pic; every OTHER Pikachu - the wild ones and
; anything caught from them, the ones that CAN evolve - shows the G/S
; Silver import instead. Call after GetMonHeader (or LoadMonData) and
; before the front pic load: if the loaded header is Pikachu's, repoint
; wMonHeader's front pointer and pic bank at PikachuFakePicFront. Both
; pics are 5x5, so the dim byte needs no touch. The header is a scratch
; copy - the next GetMonHeader rebuilds it from base stats.
;
; This entry is UNCONDITIONAL on purpose: it serves the battle-enemy
; loads and the evolution scene, where a Pikachu can never be the
; partner (the partner refuses to evolve and never fights for the
; other side).
;
; wMonHIndex holds the INTERNAL species id, not the dex id: GetMonHeader
; copies the base-stats row (whose byte 0 is the dex id) and then
; overwrites wMonHIndex with [wd0b5] as its last act.
	ld a, [wMonHIndex]
	cp STARTER_PIKACHU
	ret nz
.repoint
; wMonHPicBank is ONE byte shared by the front AND back pointers - a
; consumer that draws the back pic after this repoint without a fresh
; GetMonHeader (the Hall of Fame does exactly that) reads PikachuPicBack
; through THIS bank. Works because the fake pic lives in Pikachu's own
; section; the ASSERT beside its INCBIN in gfx/pics.asm pins that.
	ld a, LOW(PikachuFakePicFront)
	ld [wMonHFrontSprite], a
	ld a, HIGH(PikachuFakePicFront)
	ld [wMonHFrontSprite + 1], a
	ld a, BANK(PikachuFakePicFront)
	ld [wMonHPicBank], a
	ret

UseFakePikachuFrontPicEnemy::
; the battle-enemy variant, with ONE exception (Forte, 2026-09-01): the
; scripted catch on the way out of Pallet - the wild PIKACHU that OAK
; catches IS the future partner, so that battle alone keeps the Yellow
; pic. Every other enemy Pikachu (wild or trainer-owned) is a fake.
	ld a, [wBattleType]
	cp BATTLE_TYPE_PIKACHU
	ret z
; The individual is wEnemyMonCatchRate. A wild or trainer-owned Pikachu
; carries the species' base rate there; a TRANSFORMED enemy carries the
; COPIED battler's byte (TransformEffect_ copies "type 1, type 2, catch
; rate, and moves", and the player's send-out copies the party mon's
; byte into wBattleMon first) - so a Ditto wearing the partner's shape
; keeps the Yellow art and one wearing a caught Pikachu's shape wears
; Silver, correct by IDENTITY even after the player switches out
; (Forte, 2026-09-01: "ditto tem que se transformar no pikachu correto").
	ld a, [wEnemyMonCatchRate]
	cp LIGHT_BALL_GSC
	ret z
	jr UseFakePikachuFrontPic

UseFakePikachuFrontPicChangeMonPic::
; ChangeMonPic's enemy-turn branch serves TWO callers with different
; individuals on the brush: the transform ANIMATION draws the PLAYER's
; battler on the enemy side BEFORE TransformEffect_ has copied any data
; (the enemy's own bytes still belong to the un-transformed Ditto), and
; the flash/redraw family draws the enemy's OWN current shape. Species
; tells them apart: equal to wEnemyMonSpecies = own shape, judge by the
; enemy's catch byte; different = the player's battler mid-transform,
; judge by wBattleMon's. (An enemy PIKACHU using TRANSFORM would blur
; the two, but no Pikachu learns it.)
	ld a, [wBattleType]
	cp BATTLE_TYPE_PIKACHU
	ret z
	ld a, [wChangeMonPicEnemyTurnSpecies]
	ld b, a
	ld a, [wEnemyMonSpecies]
	cp b
	ld a, [wEnemyMonCatchRate]
	jr z, .judge
	ld a, [wBattleMonCatchRate]
.judge
	cp LIGHT_BALL_GSC
	ret z
	jp UseFakePikachuFrontPic

UseFakePikachuFrontPicHoF::
; Hall of Fame INDUCTION: show the individual being inducted (Forte,
; 2026-09-01: "depende - o pikachu que foi usado"). wHoFPartyMonIndex is
; the party slot; the full partner test (marker + OTID + OT name) lives
; two routines up in this same bank. The REPLAY from the League PC never
; comes here - its records store species only, so it keeps the canonical
; Yellow pic (there is nothing individual left to ask).
; Clobbers wWhichPokemon; the HoF flow rewrites it with this same value
; right after (HoFDisplayAndRecordMonInfo).
	ld a, [wMonHIndex]
	cp STARTER_PIKACHU
	ret nz
	ld a, [wHoFPartyMonIndex]
	ld [wWhichPokemon], a
	call IsThisPartymonStarterPikachu_Party
	ret c ; the partner: Yellow stays
	jr UseFakePikachuFrontPic.repoint

UseFakePikachuFrontPicUnlessStarter::
; the individual-aware variant, used from home's flipped front-pic entry
; (status screen and friends). The individual is whatever wLoadedMon
; holds - so FIRST make sure wLoadedMon actually holds THIS Pikachu:
; the flipped entry also serves screens that never ran LoadMonData (the
; Oak intro, the Pokedex), where wLoadedMon is stale or zeroed, and
; 2026-09-01's playtest caught the intro wearing the fake pic off the
; back of exactly that garbage. Species mismatch = stale = keep Yellow;
; the screens that WANT the fake regardless arm it themselves before
; getting here (and this routine never undoes an armed swap).
	ld a, [wMonHIndex]
	cp STARTER_PIKACHU ; internal id - see above
	ret nz
	ld a, [wLoadedMonSpecies]
	cp STARTER_PIKACHU
	ret nz ; wLoadedMon is NOT this Pikachu - stale data, keep Yellow
	ld a, [wLoadedMonCatchRate]
	cp LIGHT_BALL_GSC
	ret z ; the partner: Yellow pic stays
	jr UseFakePikachuFrontPic.repoint

UpdatePikachuMoodAfterBattle::
; because d is always $82 at this function, it serves to
; ensure Pikachu's mood is at least 130 after battle
	push de
	call IsStarterPikachuInOurParty
	pop de
	ret nc
	ld a, d
	cp 128
	ld a, [wPikachuMood]
	jr c, .d_less_than_128 ; we never jump
	cp d
	jr c, .load_d_into_mood
	ret

.d_less_than_128
	cp d
	ret c
.load_d_into_mood
	ld a, d
	ld [wPikachuMood], a
	ret

CheckPikachuFaintedOrStatused::
; sets carry if the starter Pikachu is in the party with a nonzero status condition; the HP read into d is never actually checked, so fainting alone does not set carry
	xor a
	ld [wWhichPokemon], a
	ld hl, wPartyCount
.loop
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .dead_or_not_in_party
	push hl
	call IsThisPartymonStarterPikachu_Party
	pop hl
	jr nc, .next
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hli]
	or [hl]
	ld d, a
	inc hl
	inc hl
	ld a, [hl] ; status
	and a
	jr nz, .alive
	jr .dead_or_not_in_party

.next
	ld a, [wWhichPokemon]
	inc a
	ld [wWhichPokemon], a
	jr .loop

.alive
	scf
	ret

.dead_or_not_in_party
	and a
	ret

IsSurfingPikachuInThePlayersParty::
	ld hl, wPartySpecies
	ld de, wPartyMon1Moves
	ld bc, wPartyMonOT
	push hl
.loop
	pop hl
	ld a, [hli]
	push hl
	inc a
	jr z, .noSurfingPlayerPikachu
	cp STARTER_PIKACHU + 1
	jr nz, .curMonNotSurfingPlayerPikachu
	ld h, d
	ld l, e
	push hl
	push bc
	ld b, NUM_MOVES
.moveSearchLoop
	ld a, [hli]
	cp SURF
	jr z, .foundSurfingPikachu
	dec b
	jr nz, .moveSearchLoop
	pop bc
	pop hl
	jr .curMonNotSurfingPlayerPikachu

.foundSurfingPikachu
	pop bc
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .curMonNotSurfingPlayerPikachu
	inc hl
	ld a, [wPlayerID+1]
	cp [hl]
	jr nz, .curMonNotSurfingPlayerPikachu
	push de
	push bc
	ld hl, wPlayerName
	ld d, $6
.nameCompareLoop
	dec d
	jr z, .foundSurfingPlayerPikachu
	ld a, [bc]
	inc bc
	cp [hl]
	inc hl
	jr z, .nameCompareLoop
	pop bc
	pop de
.curMonNotSurfingPlayerPikachu
	ld hl, wPartyMon2 - wPartyMon1
	add hl, de
	ld d, h
	ld e, l
	ld hl, NAME_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	jr .loop

.foundSurfingPlayerPikachu
	pop bc
	pop de
	pop hl
	scf
	ret

.noSurfingPlayerPikachu
	pop hl
	and a
	ret
