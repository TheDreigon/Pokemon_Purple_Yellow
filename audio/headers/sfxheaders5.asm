; AUDIO_5: a full mirror of the bank-1 SFX header table.
;
; Sound ids are (header - $4000) / 3 within whichever bank
; wAudioROMBank points at. The five city themes live in this bank, so
; every sound the overworld can fire there -- ledge hop, collision,
; a Pokedex cry, the item jingles -- must resolve to the SAME id it
; has under bank 1, or it plays garbage and wedges channels 5-8
; (that was bug #7: the Pewter ledge silencing the city forever).
;
; Therefore this file must stay LAYOUT-IDENTICAL to sfxheaders1.asm:
; same entries, same order, same channel counts. The ASSERTs at the
; bottom and .claude/audio_map_bank_audit.py both enforce it.

SFX_Headers_5::
	db $ff, $ff, $ff ; padding

SFX_Noise_Instrument01_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument01_5_Ch8

SFX_Noise_Instrument02_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument02_5_Ch8

SFX_Noise_Instrument03_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument03_5_Ch8

SFX_Noise_Instrument04_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument04_5_Ch8

SFX_Noise_Instrument05_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument05_5_Ch8

SFX_Noise_Instrument06_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument06_5_Ch8

SFX_Noise_Instrument07_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument07_5_Ch8

SFX_Noise_Instrument08_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument08_5_Ch8

SFX_Noise_Instrument09_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument09_5_Ch8

SFX_Noise_Instrument10_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument10_5_Ch8

SFX_Noise_Instrument11_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument11_5_Ch8

SFX_Noise_Instrument12_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument12_5_Ch8

SFX_Noise_Instrument13_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument13_5_Ch8

SFX_Noise_Instrument14_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument14_5_Ch8

SFX_Noise_Instrument15_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument15_5_Ch8

SFX_Noise_Instrument16_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument16_5_Ch8

SFX_Noise_Instrument17_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument17_5_Ch8

SFX_Noise_Instrument18_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument18_5_Ch8

SFX_Noise_Instrument19_5::
	channel_count 1
	channel 8, SFX_Noise_Instrument19_5_Ch8

SFX_Cry00_5::
	channel_count 3
	channel 5, SFX_Cry00_5_Ch5
	channel 6, SFX_Cry00_5_Ch6
	channel 8, SFX_Cry00_5_Ch8

SFX_Cry01_5::
	channel_count 3
	channel 5, SFX_Cry01_5_Ch5
	channel 6, SFX_Cry01_5_Ch6
	channel 8, SFX_Cry01_5_Ch8

SFX_Cry02_5::
	channel_count 3
	channel 5, SFX_Cry02_5_Ch5
	channel 6, SFX_Cry02_5_Ch6
	channel 8, SFX_Cry02_5_Ch8

SFX_Cry03_5::
	channel_count 3
	channel 5, SFX_Cry03_5_Ch5
	channel 6, SFX_Cry03_5_Ch6
	channel 8, SFX_Cry03_5_Ch8

SFX_Cry04_5::
	channel_count 3
	channel 5, SFX_Cry04_5_Ch5
	channel 6, SFX_Cry04_5_Ch6
	channel 8, SFX_Cry04_5_Ch8

SFX_Cry05_5::
	channel_count 3
	channel 5, SFX_Cry05_5_Ch5
	channel 6, SFX_Cry05_5_Ch6
	channel 8, SFX_Cry05_5_Ch8

SFX_Cry06_5::
	channel_count 3
	channel 5, SFX_Cry06_5_Ch5
	channel 6, SFX_Cry06_5_Ch6
	channel 8, SFX_Cry06_5_Ch8

SFX_Cry07_5::
	channel_count 3
	channel 5, SFX_Cry07_5_Ch5
	channel 6, SFX_Cry07_5_Ch6
	channel 8, SFX_Cry07_5_Ch8

SFX_Cry08_5::
	channel_count 3
	channel 5, SFX_Cry08_5_Ch5
	channel 6, SFX_Cry08_5_Ch6
	channel 8, SFX_Cry08_5_Ch8

SFX_Cry09_5::
	channel_count 3
	channel 5, SFX_Cry09_5_Ch5
	channel 6, SFX_Cry09_5_Ch6
	channel 8, SFX_Cry09_5_Ch8

SFX_Cry0A_5::
	channel_count 3
	channel 5, SFX_Cry0A_5_Ch5
	channel 6, SFX_Cry0A_5_Ch6
	channel 8, SFX_Cry0A_5_Ch8

SFX_Cry0B_5::
	channel_count 3
	channel 5, SFX_Cry0B_5_Ch5
	channel 6, SFX_Cry0B_5_Ch6
	channel 8, SFX_Cry0B_5_Ch8

SFX_Cry0C_5::
	channel_count 3
	channel 5, SFX_Cry0C_5_Ch5
	channel 6, SFX_Cry0C_5_Ch6
	channel 8, SFX_Cry0C_5_Ch8

SFX_Cry0D_5::
	channel_count 3
	channel 5, SFX_Cry0D_5_Ch5
	channel 6, SFX_Cry0D_5_Ch6
	channel 8, SFX_Cry0D_5_Ch8

SFX_Cry0E_5::
	channel_count 3
	channel 5, SFX_Cry0E_5_Ch5
	channel 6, SFX_Cry0E_5_Ch6
	channel 8, SFX_Cry0E_5_Ch8

SFX_Cry0F_5::
	channel_count 3
	channel 5, SFX_Cry0F_5_Ch5
	channel 6, SFX_Cry0F_5_Ch6
	channel 8, SFX_Cry0F_5_Ch8

SFX_Cry10_5::
	channel_count 3
	channel 5, SFX_Cry10_5_Ch5
	channel 6, SFX_Cry10_5_Ch6
	channel 8, SFX_Cry10_5_Ch8

SFX_Cry11_5::
	channel_count 3
	channel 5, SFX_Cry11_5_Ch5
	channel 6, SFX_Cry11_5_Ch6
	channel 8, SFX_Cry11_5_Ch8

SFX_Cry12_5::
	channel_count 3
	channel 5, SFX_Cry12_5_Ch5
	channel 6, SFX_Cry12_5_Ch6
	channel 8, SFX_Cry12_5_Ch8

SFX_Cry13_5::
	channel_count 3
	channel 5, SFX_Cry13_5_Ch5
	channel 6, SFX_Cry13_5_Ch6
	channel 8, SFX_Cry13_5_Ch8

SFX_Cry14_5::
	channel_count 3
	channel 5, SFX_Cry14_5_Ch5
	channel 6, SFX_Cry14_5_Ch6
	channel 8, SFX_Cry14_5_Ch8

SFX_Cry15_5::
	channel_count 3
	channel 5, SFX_Cry15_5_Ch5
	channel 6, SFX_Cry15_5_Ch6
	channel 8, SFX_Cry15_5_Ch8

SFX_Cry16_5::
	channel_count 3
	channel 5, SFX_Cry16_5_Ch5
	channel 6, SFX_Cry16_5_Ch6
	channel 8, SFX_Cry16_5_Ch8

SFX_Cry17_5::
	channel_count 3
	channel 5, SFX_Cry17_5_Ch5
	channel 6, SFX_Cry17_5_Ch6
	channel 8, SFX_Cry17_5_Ch8

SFX_Cry18_5::
	channel_count 3
	channel 5, SFX_Cry18_5_Ch5
	channel 6, SFX_Cry18_5_Ch6
	channel 8, SFX_Cry18_5_Ch8

SFX_Cry19_5::
	channel_count 3
	channel 5, SFX_Cry19_5_Ch5
	channel 6, SFX_Cry19_5_Ch6
	channel 8, SFX_Cry19_5_Ch8

SFX_Cry1A_5::
	channel_count 3
	channel 5, SFX_Cry1A_5_Ch5
	channel 6, SFX_Cry1A_5_Ch6
	channel 8, SFX_Cry1A_5_Ch8

SFX_Cry1B_5::
	channel_count 3
	channel 5, SFX_Cry1B_5_Ch5
	channel 6, SFX_Cry1B_5_Ch6
	channel 8, SFX_Cry1B_5_Ch8

SFX_Cry1C_5::
	channel_count 3
	channel 5, SFX_Cry1C_5_Ch5
	channel 6, SFX_Cry1C_5_Ch6
	channel 8, SFX_Cry1C_5_Ch8

SFX_Cry1D_5::
	channel_count 3
	channel 5, SFX_Cry1D_5_Ch5
	channel 6, SFX_Cry1D_5_Ch6
	channel 8, SFX_Cry1D_5_Ch8

SFX_Cry1E_5::
	channel_count 3
	channel 5, SFX_Cry1E_5_Ch5
	channel 6, SFX_Cry1E_5_Ch6
	channel 8, SFX_Cry1E_5_Ch8

SFX_Cry1F_5::
	channel_count 3
	channel 5, SFX_Cry1F_5_Ch5
	channel 6, SFX_Cry1F_5_Ch6
	channel 8, SFX_Cry1F_5_Ch8

SFX_Cry20_5::
	channel_count 3
	channel 5, SFX_Cry20_5_Ch5
	channel 6, SFX_Cry20_5_Ch6
	channel 8, SFX_Cry20_5_Ch8

SFX_Cry21_5::
	channel_count 3
	channel 5, SFX_Cry21_5_Ch5
	channel 6, SFX_Cry21_5_Ch6
	channel 8, SFX_Cry21_5_Ch8

SFX_Cry22_5::
	channel_count 3
	channel 5, SFX_Cry22_5_Ch5
	channel 6, SFX_Cry22_5_Ch6
	channel 8, SFX_Cry22_5_Ch8

SFX_Cry23_5::
	channel_count 3
	channel 5, SFX_Cry23_5_Ch5
	channel 6, SFX_Cry23_5_Ch6
	channel 8, SFX_Cry23_5_Ch8

SFX_Cry24_5::
	channel_count 3
	channel 5, SFX_Cry24_5_Ch5
	channel 6, SFX_Cry24_5_Ch6
	channel 8, SFX_Cry24_5_Ch8

SFX_Cry25_5::
	channel_count 3
	channel 5, SFX_Cry25_5_Ch5
	channel 6, SFX_Cry25_5_Ch6
	channel 8, SFX_Cry25_5_Ch8

SFX_Get_Item1_5::
	channel_count 3
	channel 5, SFX_Get_Item1_5_Ch5
	channel 6, SFX_Get_Item1_5_Ch6
	channel 7, SFX_Get_Item1_5_Ch7

SFX_Get_Item2_5::
	channel_count 3
	channel 5, SFX_Get_Item2_5_Ch5
	channel 6, SFX_Get_Item2_5_Ch6
	channel 7, SFX_Get_Item2_5_Ch7

SFX_Tink_5::
	channel_count 1
	channel 5, SFX_Tink_5_Ch5

SFX_Heal_HP_5::
	channel_count 1
	channel 5, SFX_Heal_HP_5_Ch5

SFX_Heal_Ailment_5::
	channel_count 1
	channel 5, SFX_Heal_Ailment_5_Ch5

SFX_Start_Menu_5::
	channel_count 1
	channel 8, SFX_Start_Menu_5_Ch8

SFX_Press_AB_5::
	channel_count 1
	channel 5, SFX_Press_AB_5_Ch5

SFX_Pokedex_Rating_5::
	channel_count 3
	channel 5, SFX_Pokedex_Rating_5_Ch5
	channel 6, SFX_Pokedex_Rating_5_Ch6
	channel 7, SFX_Pokedex_Rating_5_Ch7

SFX_Get_Key_Item_5::
	channel_count 3
	channel 5, SFX_Get_Key_Item_5_Ch5
	channel 6, SFX_Get_Key_Item_5_Ch6
	channel 7, SFX_Get_Key_Item_5_Ch7

SFX_Poisoned_5::
	channel_count 1
	channel 5, SFX_Poisoned_5_Ch5

SFX_Trade_Machine_5::
	channel_count 1
	channel 5, SFX_Trade_Machine_5_Ch5

SFX_Turn_On_PC_5::
	channel_count 1
	channel 5, SFX_Turn_On_PC_5_Ch5

SFX_Turn_Off_PC_5::
	channel_count 1
	channel 5, SFX_Turn_Off_PC_5_Ch5

SFX_Enter_PC_5::
	channel_count 1
	channel 5, SFX_Enter_PC_5_Ch5

SFX_Shrink_5::
	channel_count 1
	channel 5, SFX_Shrink_5_Ch5

SFX_Switch_5::
	channel_count 1
	channel 5, SFX_Switch_5_Ch5

SFX_Healing_Machine_5::
	channel_count 1
	channel 5, SFX_Healing_Machine_5_Ch5

SFX_Teleport_Exit1_5::
	channel_count 1
	channel 5, SFX_Teleport_Exit1_5_Ch5

SFX_Teleport_Enter1_5::
	channel_count 1
	channel 5, SFX_Teleport_Enter1_5_Ch5

SFX_Teleport_Exit2_5::
	channel_count 1
	channel 5, SFX_Teleport_Exit2_5_Ch5

SFX_Ledge_5::
	channel_count 1
	channel 5, SFX_Ledge_5_Ch5

SFX_Teleport_Enter2_5::
	channel_count 1
	channel 8, SFX_Teleport_Enter2_5_Ch8

SFX_Fly_5::
	channel_count 1
	channel 8, SFX_Fly_5_Ch8

SFX_Denied_5::
	channel_count 2
	channel 5, SFX_Denied_5_Ch5
	channel 6, SFX_Denied_5_Ch6

SFX_Arrow_Tiles_5::
	channel_count 1
	channel 5, SFX_Arrow_Tiles_5_Ch5

SFX_Push_Boulder_5::
	channel_count 1
	channel 8, SFX_Push_Boulder_5_Ch8

SFX_SS_Anne_Horn_5::
	channel_count 2
	channel 5, SFX_SS_Anne_Horn_5_Ch5
	channel 6, SFX_SS_Anne_Horn_5_Ch6

SFX_Withdraw_Deposit_5::
	channel_count 1
	channel 5, SFX_Withdraw_Deposit_5_Ch5

SFX_Cut_5::
	channel_count 1
	channel 8, SFX_Cut_5_Ch8

SFX_Go_Inside_5::
	channel_count 1
	channel 8, SFX_Go_Inside_5_Ch8

SFX_Swap_5::
	channel_count 2
	channel 5, SFX_Swap_5_Ch5
	channel 6, SFX_Swap_5_Ch6

SFX_59_5::
	channel_count 2
	channel 5, SFX_59_5_Ch5
	channel 6, SFX_59_5_Ch6

SFX_Purchase_5::
	channel_count 2
	channel 5, SFX_Purchase_5_Ch5
	channel 6, SFX_Purchase_5_Ch6

SFX_Collision_5::
	channel_count 1
	channel 5, SFX_Collision_5_Ch5

SFX_Go_Outside_5::
	channel_count 1
	channel 8, SFX_Go_Outside_5_Ch8

SFX_Save_5::
	channel_count 2
	channel 5, SFX_Save_5_Ch5
	channel 6, SFX_Save_5_Ch6

; the Pokeflute sound effect directly hijacks channel 3
SFX_Pokeflute_5::
	channel_count 1
	channel 3, SFX_Pokeflute_5_Ch3

SFX_Safari_Zone_PA_5::
	channel_count 1
	channel 5, SFX_Safari_Zone_PA_5_Ch5


; Sentinels: the mirror is only a mirror if the ids agree.
ASSERT SFX_Noise_Instrument01_5 - SFX_Headers_5 == SFX_Noise_Instrument01_1 - SFX_Headers_1
ASSERT SFX_Noise_Instrument19_5 - SFX_Headers_5 == SFX_Noise_Instrument19_1 - SFX_Headers_1
ASSERT SFX_Cry00_5 - SFX_Headers_5 == SFX_Cry00_1 - SFX_Headers_1
ASSERT SFX_Cry25_5 - SFX_Headers_5 == SFX_Cry25_1 - SFX_Headers_1
ASSERT SFX_Get_Item1_5 - SFX_Headers_5 == SFX_Get_Item1_1 - SFX_Headers_1
ASSERT SFX_Get_Item2_5 - SFX_Headers_5 == SFX_Get_Item2_1 - SFX_Headers_1
ASSERT SFX_Tink_5 - SFX_Headers_5 == SFX_Tink_1 - SFX_Headers_1
ASSERT SFX_Press_AB_5 - SFX_Headers_5 == SFX_Press_AB_1 - SFX_Headers_1
ASSERT SFX_Ledge_5 - SFX_Headers_5 == SFX_Ledge_1 - SFX_Headers_1
ASSERT SFX_Collision_5 - SFX_Headers_5 == SFX_Collision_1 - SFX_Headers_1
ASSERT SFX_Save_5 - SFX_Headers_5 == SFX_Save_1 - SFX_Headers_1
ASSERT SFX_Pokeflute_5 - SFX_Headers_5 == SFX_Pokeflute - SFX_Headers_1
ASSERT SFX_Safari_Zone_PA_5 - SFX_Headers_5 == SFX_Safari_Zone_PA - SFX_Headers_1
