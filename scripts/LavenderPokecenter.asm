LavenderPokecenter_Script:
	jp EnableAutoTextBoxDrawing

LavenderPokecenter_TextPointers:
	def_text_pointers
	dw_const LavenderPokecenterNurseText,            TEXT_LAVENDERPOKECENTER_NURSE
	dw_const LavenderPokecenterGentlemanText,        TEXT_LAVENDERPOKECENTER_GENTLEMAN
	dw_const LavenderPokecenterLittleGirlText,       TEXT_LAVENDERPOKECENTER_LITTLE_GIRL
	dw_const LavenderPokecenterChanseyText,          TEXT_LAVENDERPOKECENTER_CHANSEY

LavenderPokecenterNurseText:
	script_pokecenter_nurse

LavenderPokecenterGentlemanText:
	text_far _LavenderPokecenterGentlemanText
	text_end

LavenderPokecenterLittleGirlText:
	text_far _LavenderPokecenterLittleGirlText
	text_end

LavenderPokecenterChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd
