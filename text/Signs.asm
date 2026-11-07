; Signs added after the map facelift, kept together in Text 9.
;
; They live here and not beside their own maps because Text 8 (ROMX $2D, shared
; with NPC Sprites 4) is full -- adding eight lines to text/ViridianCity.asm
; overflowed the bank by 28 bytes. Text 9 was the overflow bank then (Text 10
; took over on 2026-08-30) and the project already put per-feature text there
; (BadgeGates, RematchCooldown).

_ViridianCitySchoolSignText::
	text "TRAINER SCHOOL"

	para "Read the notes on"
	line "the blackboard"
	cont "before your first"
	cont "battle!"
	done
