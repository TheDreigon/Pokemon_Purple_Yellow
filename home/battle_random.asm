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
; Link battles used a shared PRNG: a list of nine seeds exchanged over the cable,
; read here while wLinkState was LINK_STATE_BATTLING. The Cable Club is gone from
; this hack and nothing ever stores that state, so the branch was unreachable;
; v1.0 (2026-09-08) removed it and gave its ten-byte list to the stack. Every
; battle random number is the home PRNG.
	jp Random
