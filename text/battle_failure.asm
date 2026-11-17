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
