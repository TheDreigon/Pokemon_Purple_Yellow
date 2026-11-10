CreditsMons:
; one entry per CRED_TEXT_MON or CRED_TEXT_FADE_MON in CreditsOrder
	db PIKACHU

	; Pokemon Purple Yellow's screens: the final boss DREIGON's party, in its order
	; (data/trainers/parties.asm, ForteData)
	db BEEDRILL
	db HITMONLEE
	db MAGMAR
	db DREADROW ; v1.0 (2026-11-10): the species Purple Yellow adds, on "POKeMON SPRITES AND / PALETTES REVISED"
	db GOLEM
	db GYARADOS
	db NIDOKING

	; pret's screen
	db RAICHU

	db VENUSAUR ; original (vanilla's first screen, in front of Game Freak's credits)
	db ARBOK
	db RHYHORN
	db FEAROW
	db ABRA
	db GRAVELER
	db HITMONLEE
	db TANGELA
	db STARMIE
	db GYARADOS
	db DITTO
	db OMASTAR
	db VILEPLUME
	db NIDOKING
	db PARASECT

; v1.0 (2026-11-10): 8 GENGARs, vanilla's 9 less the one DREADROW's entry takes, so nothing after the list moves;
; the copyright screen reads the first, the others are spare
REPT 8
	db GENGAR
ENDR
