; v1.0 (2026-11-18): the moves that can make their target BLEED, with the chance of each, keyed by the move
; id: no effect id, and the five NO_ADDITIONAL_EFFECT moves keep that effect (their hit animation reads it).
; BleedSourceStep (engine/battle/soft_status.asm) reads it once per use of the move, after its side effect,
; when it hit and the target survived; GORE ATTACK's own effect (PARALYZE_SIDE_EFFECT1) rolls first, on its
; own. The chance is in the side effects' form: the bleed lands when BattleRandom is below it.

MACRO bleed_move
	db \1, \2 percent + 1
ENDM

BleedMoves:
	bleed_move GORE_ATTACK, 45
	bleed_move CUT,         30
	bleed_move SLASH,       15
	bleed_move NIGHT_SLASH, 15
	bleed_move RAZOR_LEAF,  15
	bleed_move DRAGON_CLAW, 15
	db -1 ; end
