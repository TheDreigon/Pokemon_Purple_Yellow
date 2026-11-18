; v1.0 (2026-11-18): the BLOODLESS #MON: they have no blood to lose, so nothing makes them BLEED
; (BleedSourceStep, engine/battle/soft_status.asm), judged by the species the battler looks like now: a
; transformed #MON bleeds as what it became. A trait of the species, as AIRBORNE and GROUNDED are
; (data/pokemon/airborne.asm), read through one routine, IsSpeciesBloodless, and shown on the STATS page as
; "BLOODLESS" (PrintMonAirborne, engine/battle/print_type.asm). (A GHOST's immunity to the bleed is its type's,
; not a trait: no GHOST is listed here, and its page shows nothing.)

BloodlessMons:
	db MAGNEMITE ; ELECTRIC/STEEL: a magnet
	db MAGNETON  ; ELECTRIC/STEEL
	db VOLTORB   ; ELECTRIC/STEEL: a ball that came alive
	db ELECTRODE ; ELECTRIC/STEEL
	db PORYGON   ; NORMAL/ELECTRIC: a program
	db DITTO     ; NORMAL: a cell
	db -1 ; end
