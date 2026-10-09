TrainerInfoTextBoxTileGraphics:  INCBIN "gfx/trainer_card/trainer_info.2bpp"
TrainerInfoTextBoxTileGraphicsEnd:

CircleTile: INCBIN "gfx/trainer_card/circle_tile.2bpp"

BadgeNumbersTileGraphics: INCBIN "gfx/trainer_card/badge_numbers.2bpp"

; v1.0 (R18f): the gym leaders' names (DrawLeaderNames, engine/menus/start_sub_menus.asm),
; one row of tiles in load order. Same bank as TrainerInfoTextBoxTileGraphics:
; TrainerInfo_FarCopyData copies from that bank.
LeaderNamesGraphics: INCBIN "gfx/trainer_card/leader_names.2bpp"
LeaderNamesGraphicsEnd:
	assert BANK(LeaderNamesGraphics) == BANK(TrainerInfoTextBoxTileGraphics)
