; The battle PRNG, kept in the home bank.
;
; It used to sit in Battle Core, which is at its 16 KB ceiling. It is called
; from both sides of the battle code -- 24 times from core.asm and 23 times
; from effects.asm -- and effects.asm is moving to a bank of its own. Putting
; it in the home bank, which is mapped at all times, means neither side needs a
; farcall: `farcall` here is `ld b / ld hl / rst _Bankswitch`, which clobbers a,
; b, c and hl, and BattleRandom is called in the middle of expressions where
; those are live. Forty-seven chances to lose a register, avoided by moving one
; routine.
;
; The `::` matters: main.asm and this file are different object files.

BattleRandom::
; Link battles use a shared PRNG.

	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jp nz, Random

	push hl
	push bc
	ld a, [wLinkBattleRandomNumberListIndex]
	ld c, a
	ld b, 0
	ld hl, wLinkBattleRandomNumberList
	add hl, bc
	inc a
	ld [wLinkBattleRandomNumberListIndex], a
	cp 9
	ld a, [hl]
	pop bc
	pop hl
	vc_hook Unknown_BattleRandom_ret_c
	vc_patch BattleRandom_ret
IF DEF(_YELLOW_VC)
	ret
ELSE
	ret c
ENDC
	vc_patch_end

; if we picked the last seed, we need to recalculate the nine seeds
	push hl
	push bc
	push af

; point to seed 0 so we pick the first number the next time
	xor a
	ld [wLinkBattleRandomNumberListIndex], a

	ld hl, wLinkBattleRandomNumberList
	ld b, 9
.loop
	ld a, [hl]
	ld c, a
; multiply by 5
	add a
	add a
	add c
; add 1
	inc a
	ld [hli], a
	dec b
	jr nz, .loop

	pop af
	pop bc
	pop hl
	ret
