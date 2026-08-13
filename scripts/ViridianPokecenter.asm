ViridianPokecenter_Script:
	jp EnableAutoTextBoxDrawing

ViridianPokecenter_TextPointers:
	def_text_pointers
	dw_const ViridianPokecenterNurseText,            TEXT_VIRIDIANPOKECENTER_NURSE
	dw_const ViridianPokecenterGentlemanText,        TEXT_VIRIDIANPOKECENTER_GENTLEMAN
	dw_const ViridianPokecenterCooltrainerMText,     TEXT_VIRIDIANPOKECENTER_COOLTRAINER_M
	dw_const ViridianPokeCenterChanseyText,          TEXT_VIRIDIANPOKECENTER_CHANSEY

ViridianPokecenterNurseText:
	script_pokecenter_nurse

ViridianPokecenterGentlemanText:
	text_far _ViridianPokecenterGentlemanText
	text_end

ViridianPokecenterCooltrainerMText:
	text_far _ViridianPokecenterCooltrainerMText
	text_end

ViridianPokeCenterChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd
