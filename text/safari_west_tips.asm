; The BAIT / ROCK sign in SAFARI ZONE west.
;
; Vanilla advertised a "Zone Exploration Campaign" and told you nothing. This
; one states what the two items actually do, in the numbers the engine uses.
;
; Its own floating section: writing the numbers out is longer than the advert
; was, and "Text 2" is pinned in layout.link, so it went 12 bytes over the
; moment this landed in text/SafariZoneWest.asm. Fourth time the pinned Text
; banks have forced this (tmhmNames, Cerulean's second tip, DAMIAN, this).

; The numbers here are the ones the engine actually uses, so they move with it.
; v0.7 catch rework: the ROCK no longer doubles wEnemyMonActualCatchRate. It
; raises the SAFARI BALL's own multiplier from x5 to x6 -- a fifth better --
; which GetCatchBallDivisor reads straight off wSafariEscapeFactor. BAIT has
; not changed the catch rate since v0.7. In core.asm a live escape factor
; multiplies the flee roll by 1.5 (vanilla's x2, changed in cdcd316) while a
; live bait factor divides it by 8. Both factors are seeded 1-5 and tick down
; one per turn, and throwing either zeroes the other -- which is also what
; expires and cancels the ROCK's catch bonus, for free.
_SafariZoneWestTrainerTipsText::
	text "TRAINER TIPS"

	para "A ROCK raises"
	line "your odds by a"
	cont "fifth, and makes"
	cont "it 1.5 times"
	cont "likelier to run."

	para "BAIT does not"
	line "change your odds,"
	cont "but makes it 8"
	cont "times less likely"
	cont "to run."

	para "Both wear off"
	line "after a few turns"
	cont "and one cancels"
	cont "the other."
	done
