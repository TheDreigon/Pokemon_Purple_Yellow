; StatModifierRatios moved to home/stat_modifier_ratios.asm: it is read by
; CalculateModifiedStat in Battle Core AND by StatModifierUp/DownEffect in the
; Battle Effects bank -- data read by address must be reachable from both, and
; the home bank is the one place both can see. Found by cross_bank_call_audit.

; v0.7: dedicated ratio table for the ACCURACY/EVASION stages (CalcHitChance
; only). It started on the modern (Gen 5+) 3/(3+n) curve (-1 = x0.75 against
; the shared stat table's x0.66); Forte's run (2026-09-05) still found -1 too
; strong, so the curve is one notch shallower, 4/(4+n): -1 = x0.80, -6 = x0.40,
; +1 = x1.25, +6 = x2.50. Same shape, gentler steps. The four battle stats
; keep StatModifierRatios above.
; NOTE: only the per-stage RATIOS are modern. CalcHitChance keeps Gen 1's
; structure of multiplying the attacker's accuracy ratio and the target's
; (inverted) evasion ratio SEPARATELY — real Gen 5 combines both stages and
; clamps the sum to +/-6 first. Extremes therefore still compound
; (-6 acc vs +6 eva = x0.40*0.40 = x0.16, not a Gen 5 floor).
; Deliberate: per-stage softening was the goal, not full Gen 5 semantics.
AccuracyModifierRatios:
	db  4,  10  ; -6  0.400
	db  4,   9  ; -5  0.444
	db  4,   8  ; -4  0.500
	db  4,   7  ; -3  0.571
	db  4,   6  ; -2  0.667
	db  4,   5  ; -1  0.800
	db  1,   1  ;  0  1.000
	db  5,   4  ; +1  1.250
	db  6,   4  ; +2  1.500
	db  7,   4  ; +3  1.750
	db  8,   4  ; +4  2.000
	db  9,   4  ; +5  2.250
	db 10,   4  ; +6  2.500
