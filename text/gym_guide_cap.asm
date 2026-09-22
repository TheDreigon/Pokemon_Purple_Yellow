; v1.0 (2026-09-22, Forte): the gym guides' shared cap line lives here (Text 9)
; because the gym scripts' text banks are full. Lines under the arrow: 17.

; The gym guide, on HARD, before the badge fight: the leader's party size is
; the cap (HardModeGymPartyGate). Same 4th-wall rule as the gate's refusal:
; no mode name-drop, the guide speaks of the road the player chose. wd11e
; carries the number.
_HardModeGymCapHintText::
	text "One more thing:"
	line "on the road you"
	cont "chose, the LEADER"
	cont "only takes fair"
	cont "badge matches."
	cont "Bring a party of"
	cont "up to @"
	text_decimal wd11e, 1, 1
	text " #MON."
	done
