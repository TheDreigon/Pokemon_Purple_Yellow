TradeSpecialMoves:
	table_width 1, TradeSpecialMoves
; One signature "illegal" move per NPC trade (event-mon style), indexed by
; TRADE_FOR_* like TradeMons. Written into the received mon's first empty
; move slot (or slot 4 if full) with correct max PP, right after the trade.
; 0 = no special move (dormant rows). Forte-approved list, 2026-07-18.
	db ROCK_SLIDE   ; TREMOR  (Dugtrio — digs until the cliff collapses)
	db TRANSFORM    ; MILES   (Mr. Mime — the perfect mime)
	db 0            ; STINGER (unused)
	db GORE_ATTACK  ; PTERA   (Aerodactyl — the ancient predator)
	db 0            ; BART    (unused — DO NOT ACTIVATE)
	db NEUROTOXIN   ; SPORE   (Parasect — the fungus deepens its hold)
	db PETAL_DANCE  ; LOLA    (Jynx — the dancer of Saffron)
	db FLAME_CHARGE ; BASALT  (Rhydon — charges wreathed in volcano fire)
	db THUNDER      ; MOBY    (Gyarados — the storm follows the whale)
	db DRILL_PECK   ; DUX     (Farfetch'd — the soldier's secret technique)
	assert_table_length NUM_NPC_TRADES
