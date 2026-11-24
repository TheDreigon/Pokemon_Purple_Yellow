; The two battle failures that Gen 1 reported as an ordinary miss.
;
; Its own section (pinned to ROMX $12 in layout.link): "Text 2", where
; _AttackMissedText and its
; neighbours live, is pinned in layout.link and has no room -- the SAFARI sign
; had to move out of it in the same session. text_far reaches here from
; anywhere.
;
; <TARGET> is the defender, which is who both of these lines are about: one
; dodged, and the other shrugged the hit off.

_MoveEvadedText::
	text "<TARGET>"
	line "slipped aside!"
	prompt

_NoScratchText::
	text "It didn't leave a"
	line "scratch on"
	cont "<TARGET>!"
	prompt

; v1.0 (2026-11-17): a status move on a target that already has a status names the
; status it has (PrintStatusMoveFailure, engine/battle/status_failure.asm; "already
; asleep!" is _AlreadyAsleepText in Text 5). "already paralyzed" has no "!": 17 tiles.
_AlreadyPoisonedText::
	text "<TARGET>'s"
	line "already poisoned!"
	prompt

_AlreadyBurnedText::
	text "<TARGET>'s"
	line "already burned!"
	prompt

_AlreadyFrozenText::
	text "<TARGET>'s"
	line "already frozen!"
	prompt

_AlreadyParalyzedText::
	text "<TARGET>'s"
	line "already paralyzed"
	prompt

_AlreadyConfusedText::
	text "<TARGET>'s"
	line "already confused!"
	prompt

; v1.0 (2026-11-24): FEAR (engine/battle/soft_status.asm). DEATH GLARE on a target already scared
; (PrintStatusMoveFailure); the fear landing (FearEffect_); its turn (FearTurnCheck): over, or lost.
_AlreadyScaredText::
	text "<TARGET>'s"
	line "already scared!"
	prompt

_BecameScaredText::
	text "<TARGET>"
	line "became scared!"
	prompt

_ScaredNoMoreText::
	text "<USER>'s"
	line "scared no more!"
	prompt

_TooScaredText::
	text "<USER>"
	line "is too scared!"
	prompt

; v1.0 (2026-11-24): SPIRAL hit and neither of its legs landed, by the rolls or by the gates (SpiralEffect_,
; engine/battle/soft_status.asm).
_LookedAwayText::
	text "<TARGET>"
	line "looked away!"
	prompt

; x4 and x1/4 (2026-09-24). Same section as the lines above: the pinned text
; banks had no room then (Text 10 had 317 bytes in the debug build).
_ExtremelyEffectiveText::
	text "It's extremely"
	line "effective!"
	prompt

_BarelyEffectiveText::
	text "It's barely"
	line "effective..."
	prompt

; v1.0 (2026-11-17): the last bite of a burn (BurnBiteTaken, engine/battle/soft_status.asm), printed only
; if the #MON still stands; after it the burn takes nothing more until it is cured.
_BurnedOutText::
	text "<USER>'s"
	line "fire burned out!"
	prompt

; v1.0 (2026-11-18): the bleed (engine/battle/soft_status.asm). A hit makes the target bleed, or bleed one
; layer more (BleedInflicted); each run of the bleeding side's residual is a bite (BleedBiteStart); the last
; bite ends it, and the line is printed only if the #MON still stands (BleedBiteTaken). The <TARGET> form of
; "bleeding stopped!" is for a move that ends the target's bleed.
_BleedingText::
	text "<TARGET>"
	line "is bleeding!"
	prompt

_BleedingWorseText::
	text "<TARGET>'s"
	line "bleeding worse!"
	prompt

_HurtByBleedingText::
	text "<USER>'s"
	line "hurt by bleeding!"
	prompt

_BleedingStoppedText::
	text "<USER>'s"
	line "bleeding stopped!"
	prompt

_TargetBleedingStoppedText::
	text "<TARGET>'s"
	line "bleeding stopped!"
	prompt
