BluesHouse2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, BluesHouse2F_ScriptPointers
	ld a, 0
	call CallFunctionInTable
	ret

BluesHouse2F_ScriptPointers:
	def_script_pointers
; ONE entry, not five. The index above is a hardcoded 0 and no wBluesHouse2FCurScript
; is ever read, so the four extra rows RedsHouse2F carries are dead weight there
; and would be dead weight here. Nothing runs on entry to this room.
	dw_const BluesHouse2FDefaultScript, SCRIPT_BLUESHOUSE2F_DEFAULT

BluesHouse2FDefaultScript:
	ret

BluesHouse2F_TextPointers:
	def_text_pointers

	text_end ; unused - the room's two interactions are hidden objects
