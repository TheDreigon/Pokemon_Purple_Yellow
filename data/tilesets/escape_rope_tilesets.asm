; v0.7 (2026-08-13, his call): the ESCAPE ROPE and DIG are for the caves and for
; nothing else -- MT.MOON, DIGLETT'S CAVE, ROCK TUNNEL, the SEAFOAM ISLANDS,
; VICTORY ROAD and CERULEAN CAVE, every floor. CAVERN is exactly those nineteen
; maps and no others, so the list is one entry long.
;
; What this turned off, all of it inherited from vanilla and none of it wanted:
;   CEMETERY  POKeMON TOWER 1F-7F (and AGATHA's room, which vanilla had to
;             exclude by name in ItemUseEscapeRope for this very reason)
;   FACILITY  SILPH CO 1F-10F, ROCKET HIDEOUT B1F-B4F, POKeMON MANSION 1F-B1F,
;             the POWER PLANT, and -- oddly -- the CINNABAR and SAFFRON GYMs
;   FOREST    VIRIDIAN FOREST and the four SAFARI ZONE areas. The rope used to
;             double as the "give up on the SAFARI" button; running out of steps
;             is now the only way out early.
;   INTERIOR  SILPH CO 11F (plus BILL's house and the POKeMON FAN CLUB, the
;             other two vanilla had to exclude by name)
EscapeRopeTilesets:
	db CAVERN
	db -1 ; end
