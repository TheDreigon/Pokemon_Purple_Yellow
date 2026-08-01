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
	db LICKITUNG,  DUGTRIO,  TRADE_DIALOGSET_TREMOR,   "TREMOR@@@@@"
	db CLEFAIRY,   MR_MIME,  TRADE_DIALOGSET_MILES,    "MILES@@@@@@"
	db SCYTHER,    AERODACTYL, TRADE_DIALOGSET_PTERA,  "PTERA@@@@@@"
	db TANGELA,    PARASECT, TRADE_DIALOGSET_SPORE,    "SPORE@@@@@@"
	db POLIWHIRL,  JYNX,     TRADE_DIALOGSET_LOLA,     "LOLA@@@@@@@"
	db GOLDUCK,    RHYDON,   TRADE_DIALOGSET_BASALT,   "BASALT@@@@@"
	db PINSIR,     GYARADOS, TRADE_DIALOGSET_MOBY,     "MOBY@@@@@@@"
	db PIDGEOTTO,  FARFETCHD, TRADE_DIALOGSET_DUX,     "DUX@@@@@@@@"
	assert_table_length NUM_NPC_TRADES
