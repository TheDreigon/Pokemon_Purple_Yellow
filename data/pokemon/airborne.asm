; v1.0 (2026-11-02): the AIRBORNE #MON, Forte's list. A GROUND move never touches them, as it never touches
; a FLYING type: the chart walks match GROUND's row against FLYING for them too (wDefenderAirborne, set from
; the species with the third type by SetDefenderTraits). Nothing else in battle reads it - not the other
; FLYING rows, not STAB, not the status rules. The status screen shows it under the types (PrintMonAirborne):
; a trait of the species, not an ability. A FLYING or GAS #MON needs no entry: the chart already keeps
; GROUND off it.

AirborneMons:
	db DRAGONITE ; DRAGON: it flies
	db GENGAR    ; GHOST/DARK/POISON
	db MEW       ; PSYCHIC/FAIRY
	db MEWTWO    ; PSYCHIC: it levitates
	db -1 ; end
