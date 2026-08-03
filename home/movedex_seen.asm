; The MOVEDEX's "seen" bitfield: one bit per move in wMovedexSeen.
;
; Only the two marking routines live in the home bank, and only because the hook
; has to sit inside PlayMoveAnimation -- that way every path which animates a
; move is covered by one edit, and "Battle Core" ($0F) has under 40 bytes free,
; which buys a 3-byte `call` and nothing more. Everything else the feature needs
; (the test, the party sweep, the count) is only ever called by the MOVEDEX and
; lives in its bank: see engine/menus/movedex_seen.asm.

; Mark whatever PlayMoveAnimation just loaded into wAnimationID, if it is a move.
;
; Moves do double duty as animation ids, and the pseudo-animations (SHOWPIC_ANIM
; and everything after it) are numbered from NUM_ATTACKS + 1, so the range test
; in MarkMoveSeenByID is exact rather than a guess: status flashes, trade-ball
; animations and the special effects all fall outside it.
;
; The animation is the right trigger, not the "used a move" text: it fires for
; the opponent's moves as well as the player's, and for the moves METRONOME and
; MIRROR MOVE turn into -- all of them moves the player genuinely watched
; happen. Switching battle animations off does not skip it, and should not: the
; move still named itself on screen.
MarkMoveSeen::
	push af
	ld a, [wAnimationID]
	call MarkMoveSeenByID
	pop af
	ret

; Mark move id a as seen. 0 and anything past NUM_ATTACKS are ignored.
; Preserves bc, de and hl.
MarkMoveSeenByID::
	and a
	ret z
	cp NUM_ATTACKS + 1
	ret nc
	push bc
	push de
	push hl
	dec a ; move ids are 1-based, bits are 0-based
	ld c, a
	ld b, FLAG_SET
	ld hl, wMovedexSeen
	predef FlagActionPredef
	pop hl
	pop de
	pop bc
	ret
