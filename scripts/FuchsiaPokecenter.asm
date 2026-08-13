FuchsiaPokecenter_Script:
; v0.7 (#38): NURSE JOY moved to the DAYCARE and became the gentleman's
; daughter, so this is an ordinary POKeMON CENTER again -- no script table, no
; post-battle state, and the nurse behind the counter is the plain one every
; other CENTER has. The script pointer table, wFuchsiaPokecenterCurScript and
; the extra TEXT_FUCHSIAPOKECENTER_POST_BATTLE entry all went with her; the
; battle, its texts and both of its events live in scripts/Daycare2F.asm now.
	jp EnableAutoTextBoxDrawing

FuchsiaPokecenter_TextPointers:
	def_text_pointers
	dw_const FuchsiaPokecenterNurseText,            TEXT_FUCHSIAPOKECENTER_NURSE
	dw_const FuchsiaPokecenterRockerText,           TEXT_FUCHSIAPOKECENTER_ROCKER
	dw_const FuchsiaPokecenterCooltrainerFText,     TEXT_FUCHSIAPOKECENTER_COOLTRAINER_F
	dw_const FuchsiaPokecenterChanseyText,          TEXT_FUCHSIAPOKECENTER_CHANSEY

FuchsiaPokecenterNurseText:
	script_pokecenter_nurse

FuchsiaPokecenterRockerText:
	text_far _FuchsiaPokecenterRockerText
	text_end

FuchsiaPokecenterCooltrainerFText:
	text_far _FuchsiaPokecenterCooltrainerFText
	text_end

FuchsiaPokecenterChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd
