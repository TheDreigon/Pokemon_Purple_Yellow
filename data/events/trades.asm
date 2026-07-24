TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH, TradeMons
	; give mon, get mon, dialog id, nickname
	; from the Japanese Blue trades, which used species that evolve.
	; Japanese Red and Green used TRADE_DIALOGSET_CASUAL, and had
	; the same species as English Red and Blue.
	db LICKITUNG,  DUGTRIO,  TRADE_DIALOGSET_TREMOR,    "TREMOR@@@@@"
	db CLEFAIRY,   MR_MIME,  TRADE_DIALOGSET_MILES,    "MILES@@@@@@"
	db BUTTERFREE, BEEDRILL, TRADE_DIALOGSET_HAPPY,     "STINGER@@@@" ; unused
	db SCYTHER,    AERODACTYL, TRADE_DIALOGSET_PTERA,  "PTERA@@@@@@"
	db MEW,        MEW,      TRADE_DIALOGSET_HAPPY,     "BART@@@@@@@" ; unused — DO NOT ACTIVATE: Mew is the dex-150-gated postgame static (Mansion B1F); a tradeable BART would wreck that design
	db TANGELA,    PARASECT, TRADE_DIALOGSET_SPORE,    "SPORE@@@@@@"
	db POLIWHIRL,  JYNX,     TRADE_DIALOGSET_LOLA, "LOLA@@@@@@@"
	db GOLDUCK,    RHYDON,   TRADE_DIALOGSET_BASALT, "BASALT@@@@@"
	db PINSIR,     GYARADOS, TRADE_DIALOGSET_MOBY,     "MOBY@@@@@@@"
	db PIDGEOTTO,  FARFETCHD, TRADE_DIALOGSET_DUX,    "DUX@@@@@@@@"
	assert_table_length NUM_NPC_TRADES
