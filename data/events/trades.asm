TradeMons:
; entries correspond to TRADE_FOR_* constants
; NOTE: MEW is intentionally NOT tradeable — it is the dex-150-gated postgame
; static (Mansion B1F); a Mew trade would wreck that design. (The dormant
; BART/STINGER placeholder rows were removed 2026-07-24.)
	table_width 3 + NAME_LENGTH, TradeMons
	; give mon, get mon, dialog id, nickname
	; from the Japanese Blue trades, which used species that evolve.
	; Japanese Red and Green used TRADE_DIALOGSET_CASUAL, and had
	; the same species as English Red and Blue.
	db LICKITUNG,  PONYTA,   TRADE_DIALOGSET_COLT,     "COLT@@@@@@@" ; v1.0 (2026-09-22, Forte): was DUGTRIO "TREMOR" - DIGLETT is most of the cave on this same route. A foal below the LICKITUNG given; RAPIDASH only at its own 30
	db CLEFAIRY,   MR_MIME,  TRADE_DIALOGSET_MILES,    "MILES@@@@@@"
	db SCYTHER,    AERODACTYL, TRADE_DIALOGSET_PTERA,  "PTERA@@@@@@"
	db ARCANINE,   DEWGONG,  TRADE_DIALOGSET_FLOE,     "FLOE@@@@@@@" ; v1.0 (2026-09-22, Forte): was TANGELA -> PARASECT "SPORE" - PARASECT is 19.9% in the Safari next door. The cook's kitchen is too hot for a sea animal
	db POLIWHIRL,  JYNX,     TRADE_DIALOGSET_LOLA,     "LOLA@@@@@@@"
	db GOLDUCK,    RHYDON,   TRADE_DIALOGSET_BASALT,   "BASALT@@@@@"
	db PINSIR,     GYARADOS, TRADE_DIALOGSET_MOBY,     "MOBY@@@@@@@"
	db MACHOP,     FARFETCHD, TRADE_DIALOGSET_DUX,     "DUX@@@@@@@@" ; v0.7 (2026-09-05, Forte): asks for a MACHOP, was PIDGEOTTO
	assert_table_length NUM_NPC_TRADES
