; The MOVEDEX's "seen" bitfield: one bit per move in wMovedexSeen.
;
; Only the marking routine lives in the home bank, and only because its caller
; is MonName1Text in the battle core -- the "<MON> used MOVE!" announcement --
; and that bank has under 40 bytes free, which buys a 3-byte `call` and nothing
; more. Everything else the feature needs (the test, the party sweep, the count)
; is only ever called by the MOVEDEX and lives in its bank: see
; engine/menus/movedex_seen.asm.
;
; 🔴 The announcement, not the animation. An earlier version hooked
; PlayMoveAnimation and silently missed every STATUS move, because those animate
; through PlayBattleAnimationGotID in effects.asm instead. The announcement is
; also the more honest trigger: it is the line that names the move to the
; player, it fires for both sides, and it does not fire when a sleeping or
; confused Pokemon never gets its move out.

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
