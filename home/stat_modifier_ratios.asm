; The stat-stage multiplier table, kept in the home bank.
;
; It is read by address from two different banks: CalculateModifiedStat in
; Battle Core ($0F) and StatModifierUp/DownEffect in Battle Effects ($06).
; When the effects moved to their own bank this table went with them, and the
; core-side reader silently started reading whatever sat at this address in
; $0F -- garbage multipliers on every stat stage change. Data shared across
; banks lives in home, the same reasoning that moved BattleRandom here.
;
; 26 bytes. The `::` is because home.asm is its own object file.
StatModifierRatios::
; first byte is numerator, second byte is denominator
	db 25, 100  ; 0.25
	db 28, 100  ; 0.28
	db 33, 100  ; 0.33
	db 40, 100  ; 0.40
	db 50, 100  ; 0.50
	db 66, 100  ; 0.66
	db  1,   1  ; 1.00
	db 15,  10  ; 1.50
	db  2,   1  ; 2.00
	db 25,  10  ; 2.50
	db  3,   1  ; 3.00
	db 35,  10  ; 3.50
	db  4,   1  ; 4.00
