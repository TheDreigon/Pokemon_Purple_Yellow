MtMoonPokecenter_Script:
	jp EnableAutoTextBoxDrawing

MtMoonPokecenter_TextPointers:
	def_text_pointers
	dw_const MtMoonPokecenterNurseText,            TEXT_MTMOONPOKECENTER_NURSE
	dw_const MtMoonPokecenterYoungsterText,        TEXT_MTMOONPOKECENTER_YOUNGSTER
	dw_const MtMoonPokecenterGentlemanText,        TEXT_MTMOONPOKECENTER_GENTLEMAN
	dw_const MtMoonPokecenterMagikarpSalesmanText, TEXT_MTMOONPOKECENTER_MAGIKARP_SALESMAN
	dw_const MtMoonPokecenterClipboardText,        TEXT_MTMOONPOKECENTER_CLIPBOARD
	dw_const MtMoonPokecenterChanseyText,          TEXT_MTMOONPOKECENTER_CHANSEY

MtMoonPokecenterNurseText:
	script_pokecenter_nurse

MtMoonPokecenterYoungsterText:
	text_far _MtMoonPokecenterYoungsterText
	text_end

MtMoonPokecenterGentlemanText:
	text_far _MtMoonPokecenterGentlemanText
	text_end

MtMoonPokecenterMagikarpSalesmanText:
	text_asm
	callfar MagikarpSalesman
	jp TextScriptEnd

MtMoonPokecenterClipboardText:
	text_far _MtMoonPokecenterClipboardText
	text_end

MtMoonPokecenterChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd
