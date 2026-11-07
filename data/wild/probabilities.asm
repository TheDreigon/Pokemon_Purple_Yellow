; There are 10 slots for wild pokemon, and these tables define how common each
; of those 10 slots is. A random number is generated and then the first byte of
; each pair is compared against that random number. If the random number is less
; than or equal to the first byte, then that slot is chosen. The second byte is
; double the slot number.
;
; 🔴 THERE IS NO LENGTH AND NO TERMINATOR. The reader in
; engine/battle/wild_encounters.asm walks forward while [hl] < random, and the
; ONLY thing that stops it is the last entry being 255, which is >= every
; possible random byte. A table that ends on anything else walks off the end and
; picks a slot out of whatever data follows it in the bank -- with a green build,
; and only sometimes. The macro below makes that impossible to get wrong.
MACRO encounter_slot_chances
; one arg per slot: the slot's weight out of 256. Emits the running cutoffs and
; asserts that the weights add up, which is the same thing as the last cutoff
; being 255.
	DEF _slot_total = 0
	DEF _slot_index = 0
	REPT _NARG
		DEF _slot_total += (\1)
		db _slot_total - 1, _slot_index * 2
		DEF _slot_index += 1
		SHIFT
	ENDR
	ASSERT _slot_total == 256, \
		"encounter slot chances must add up to 256, or the reader runs off the end of the table"
	ASSERT _slot_index <= 10, \
		"a wild table has only 10 slots"
ENDM

WildMonEncounterSlotChances:
	encounter_slot_chances 51, 51, 39, 25, 25, 25, 13, 13, 11, 3
;                       19.9 19.9 15.2 9.8 9.8 9.8 5.1 5.1 4.3 1.2 %

; v1.0 (2026-11-07): BILL's garden runs on its own, flat odds - every slot between
; 9.8% and 10.2% instead of 19.9% down to 1.2%. TryDoWildEncounter (engine/battle/
; wild_encounters.asm) loads this table instead of the one above when wCurMap is
; BILLS_GARDEN. The garden's three KANTO starters fill two slots each, so each of
; them comes out at 19.9% (51/256) and the other four at ~10%. The table and the
; check took 30 bytes of bank $4 (the "Battle Engine 1" section); the bank had 9
; free when the garden was built, which is why it ran on the normal odds until now.
BillsGardenEncounterSlotChances:
	encounter_slot_chances 26, 25, 26, 25, 26, 25, 26, 25, 26, 26
;                       10.2 9.8 10.2 9.8 10.2 9.8 10.2 9.8 10.2 10.2 %
