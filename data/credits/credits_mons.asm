CreditsMons:
; one entry per CRED_TEXT_MON or CRED_TEXT_FADE_MON in CreditsOrder
	db PIKACHU

	; Pokemon Purple Yellow's screens: the final boss DREIGON's party, in its order
	; (data/trainers/parties.asm, ForteData)
	db BEEDRILL
	db HITMONLEE
	db MAGMAR
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

REPT 9
	db GENGAR
ENDR
