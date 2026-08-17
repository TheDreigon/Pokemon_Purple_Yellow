PrintTrashText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump VermilionGymTrashText

VermilionGymTrashText::
	text_far _VermilionGymTrashText
	text_end

GymTrashScript:
	call EnableAutoTextBoxDrawing
	ld a, [wHiddenObjectFunctionArgument]
	ld [wGymTrashCanIndex], a

; Don't do the trash can puzzle if it's already been done.
	CheckEvent EVENT_2ND_LOCK_OPENED
	jr z, .ok

	tx_pre_jump VermilionGymTrashText

.ok
	CheckEventReuseA EVENT_1ST_LOCK_OPENED
	jr nz, .trySecondLock

	ld a, [wFirstLockTrashCanIndex]
	ld b, a
	ld a, [wGymTrashCanIndex]
	cp b
	jr z, .openFirstLock

	tx_pre_id VermilionGymTrashText
	jr .done

.openFirstLock
; Next can is trying for the second switch.
	SetEvent EVENT_1ST_LOCK_OPENED
	callfar Yellow_SampleSecondTrashCan
	tx_pre_id VermilionGymTrashSuccessText1
	jr .done

.trySecondLock
	ld a, [wGymTrashCanIndex]
	ld b, a
	ld a, [wSecondLockTrashCanIndex]
	cp b
	jr z, .openSecondLock
	ld a, [wSecondLockTrashCanIndex + 1]
	cp b
	jr z, .openSecondLock

; Legacy change: a wrong second can no longer resets the first lock (vanilla re-randomized wFirstLockTrashCanIndex here, restarting the puzzle).
	tx_pre_id VermilionGymTrashFailText
	jr .done

.openSecondLock
; Completed the trash can puzzle.
	SetEvent EVENT_2ND_LOCK_OPENED
	ld hl, wCurrentMapScriptFlags
	set 6, [hl]

	tx_pre_id VermilionGymTrashSuccessText3

.done
	jp PrintPredefTextID

; v0.7 space pass (2026-08-17): the vanilla GymTrashCans table (75 B, zero
; references) is gone — GymTrashCans3c in vermilion_gym_trash2.asm is the
; live table, as the old comment here already admitted.

VermilionGymTrashSuccessText1::
	text_far _VermilionGymTrashSuccessText1
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_SWITCH
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd

; unused
VermilionGymTrashSuccessText2::
	text_far _VermilionGymTrashSuccessText2
	text_end

; unused
VermilionGymTrashSuccesPlaySfx:
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_SWITCH
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd

VermilionGymTrashSuccessText3::
	text_far _VermilionGymTrashSuccessText3
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_GO_INSIDE
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd

VermilionGymTrashFailText::
	text_far _VermilionGymTrashFailText
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_DENIED
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd
