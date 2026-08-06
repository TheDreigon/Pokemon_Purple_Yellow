; The BAIT / ROCK sign in SAFARI ZONE west.
;
; Vanilla advertised a "Zone Exploration Campaign" and told you nothing. This
; one states what the two items actually do, in the numbers the engine uses.
;
; Its own floating section: writing the numbers out is longer than the advert
; was, and "Text 2" is pinned in layout.link, so it went 12 bytes over the
; moment this landed in text/SafariZoneWest.asm. Fourth time the pinned Text
; banks have forced this (tmhmNames, Cerulean's second tip, DAMIAN, this).

; The numbers here are the ones the engine actually uses, so they move with it:
; ItemUseRock doubles wEnemyMonActualCatchRate, ItemUseBait halves it, and in
; core.asm a live escape factor multiplies the flee roll by 1.5 (vanilla's x2,
; changed in cdcd316) while a live bait factor divides it by 8. Both factors are
; seeded 1-5 and tick down one per turn, and throwing either zeroes the other.
_SafariZoneWestTrainerTipsText::
	text "TRAINER TIPS"

	para "A ROCK doubles"
	line "your chance to"
	cont "catch, and makes"
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
