; StatModifierRatios moved to home/stat_modifier_ratios.asm: it is read by
; CalculateModifiedStat in Battle Core AND by StatModifierUp/DownEffect in the
; Battle Effects bank -- data read by address must be reachable from both, and
; the home bank is the one place both can see. Found by cross_bank_call_audit.

; v0.7: dedicated ratio table for the ACCURACY/EVASION stages (CalcHitChance
; only). Modern (Gen 5+) 3/(3+n) curve: softens the brutal first step of the
; shared stat table (-1 was x0.66, now x0.75) while deep stages stay
; meaningful. The four battle stats keep StatModifierRatios above.
; NOTE: only the per-stage RATIOS are modern. CalcHitChance keeps Gen 1's
; structure of multiplying the attacker's accuracy ratio and the target's
; (inverted) evasion ratio SEPARATELY — real Gen 5 combines both stages and
; clamps the sum to +/-6 first. Extremes therefore still compound
; (-6 acc vs +6 eva = x0.33*0.33 = x0.11, not the Gen 5 x0.33 floor).
; Deliberate: per-stage softening was the goal, not full Gen 5 semantics.
AccuracyModifierRatios:
	db  3,   9  ; -6  0.333
	db  3,   8  ; -5  0.375
	db  3,   7  ; -4  0.429
	db  3,   6  ; -3  0.500
	db  3,   5  ; -2  0.600
	db  3,   4  ; -1  0.750
	db  1,   1  ;  0  1.000
	db  4,   3  ; +1  1.333
	db  5,   3  ; +2  1.667
	db  6,   3  ; +3  2.000
	db  7,   3  ; +4  2.333
	db  8,   3  ; +5  2.667
	db  9,   3  ; +6  3.000
