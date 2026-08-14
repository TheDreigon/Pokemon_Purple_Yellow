PrintRedSNESText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump RedBedroomSNESText

RedBedroomSNESText::
	text_far _RedBedroomSNESText
	text_end

; The rival's bedroom is the same room, so its SNES and its PC sit at the same
; coordinates. Only what they say differs.
PrintBluesSNESText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump BluesBedroomSNESText

BluesBedroomSNESText::
	text_far _BluesBedroomSNESText
	text_end

; No script_players_pc here, deliberately: it is his machine, so it only talks.
RefuseBluesPC:
	call EnableAutoTextBoxDrawing
	tx_pre_jump BluesBedroomPCText

BluesBedroomPCText::
	text_far _BluesBedroomPCText
	text_end

OpenRedsPC:
	call EnableAutoTextBoxDrawing
	tx_pre_jump RedBedroomPCText

RedBedroomPCText::
	script_players_pc
