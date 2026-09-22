TradeSpecialMoves:
	table_width 1, TradeSpecialMoves
; One signature "illegal" move per NPC trade (event-mon style), indexed by
; TRADE_FOR_* like TradeMons. Written into the received mon's first empty
; move slot with correct max PP, right after the trade; with four moves, over
; the oldest one that is not a same-type attack (the oldest of all only when
; the four are same-type attacks) - see InGameTrade_GiveSpecialMove.
; 0 = no special move (dormant rows).
	db HEAD_SMASH   ; TREMOR  (Dugtrio — digs until the cliff collapses). v1.0 (2026-09-14): was ROCK_SLIDE, which DUGTRIO itself learns at 60 since the learnset pass; a signature the species can learn would arrive twice, in two slots with two PP pools, because the engine has no runtime duplicate guard
	db TRANSFORM    ; MILES   (Mr. Mime — the perfect mime)
	db GORE_ATTACK  ; PTERA   (Aerodactyl — the ancient predator)
	db NEUROTOXIN   ; SPORE   (Parasect — the fungus deepens its hold)
	db PETAL_DANCE  ; LOLA    (Jynx — the dancer of Saffron)
	db FLAME_CHARGE ; BASALT  (Rhydon — charges wreathed in volcano fire)
	db THUNDER      ; MOBY    (Gyarados — the storm follows the whale)
	db DRILL_PECK   ; DUX     (Farfetch'd — the soldier's secret technique)
	assert_table_length NUM_NPC_TRADES
