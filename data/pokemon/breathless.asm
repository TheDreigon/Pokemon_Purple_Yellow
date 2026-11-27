; v1.0 (2026-11-27): the BREATHLESS #MON. Machines that neither breathe nor have a living body, so spores and powders
; do nothing to them. Read through one routine, SporeMoveBlocked (engine/battle/effects_dispatch.asm), for the moves
; (JumpMoveEffect) and for the trainer AI (CheckStatusImmunity). Judged by the species that was sent out: TRANSFORM
; neither gives it nor takes it away. DITTO is BLOODLESS (bloodless.asm) but alive, a cell: it breathes.
; All five are ELECTRIC, which already keeps STUN POWDER's paralysis off them; emu_test_breathless checks that
; this stays true, since nothing else would make STUN POWDER fail on a BREATHLESS #MON of another type.
BreathlessMons:
	db MAGNEMITE ; ELECTRIC/STEEL: a magnet
	db MAGNETON  ; ELECTRIC/STEEL
	db VOLTORB   ; ELECTRIC/STEEL: a ball that came alive
	db ELECTRODE ; ELECTRIC/STEEL
	db PORYGON   ; NORMAL/ELECTRIC: a program
	db -1 ; end

; The moves made of spores or powder. The four status moves fail on a BREATHLESS target ("It doesn't affect");
; SPORE DAZE has power: it hits, and only its confusion is lost.
SporeMoves:
	db SPORE
	db SLEEP_POWDER
	db STUN_POWDER
	db POISONPOWDER
	db SPORE_DAZE
	db -1 ; end
