FemaleTrainerList::
	db OPP_LASS
	db OPP_JR_TRAINER_F
	db OPP_BEAUTY
	db OPP_COOLTRAINER_F
	db OPP_JOY
	db OPP_JENNY
; v0.7: vanilla (and Red/Blue) only ever listed the four generic female
; classes here, so every female BOSS got the male jingle. Fixed:
	db OPP_MISTY
	db OPP_ERIKA
	db OPP_SABRINA
	db OPP_LORELEI
	db OPP_AGATHA
	db OPP_JANINE
; ...and the last generic female class vanilla missed. Every other generic
; class is male, so this closes the category.
	db OPP_CHANNELER
	db -1 ; end
; NOTE: Joy/Jenny (added by Legacy) never reach PlayTrainerMusic — they start
; their battles by writing wCurOpponent, so their entries above are inert; the
; jingle is played explicitly in their scripts instead.

EvilTrainerList::
	db OPP_GAMBLER
	db OPP_ROCKER
	db OPP_JUGGLER
	db OPP_SCIENTIST
	db OPP_GIOVANNI
	db OPP_ROCKET
	db -1 ; end
