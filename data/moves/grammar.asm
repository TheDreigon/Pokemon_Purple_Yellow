ExclamationPointMoveSets:
; set 0
	db SWORDS_DANCE
	db GROWTH
	db 0 ; end set

; set 1
	db RECOVER
	db EXPLOSION ; replaces removed SELFDESTRUCT
	db AMNESIA
	db 0 ; end set

; set 2
	db CALM_MIND ; replaces removed MEDITATE
	db AGILITY
	db TELEPORT
	db MIMIC
	db DOUBLE_TEAM
	db BIDE ; corrected JP grammar: moved from set 1 in pokered
	db FURY_ATTACK ; replaces removed BARRAGE
	db 0 ; end set

; set 3
	db TACKLE ; replaces removed POUND
	db SCRATCH
	db VICEGRIP
	db WING_ATTACK
	db FLY
	db BIND
	db HEAVY_SLAM ; replaces removed SLAM
	db HORN_ATTACK
	db BODY_SLAM
	db WRAP
	db THRASH
	db TAIL_WHIP
	db LEER
	db BITE
	db GROWL
	db SCARY_FACE ; replaces removed ROAR
	db SING
	db PECK
	db STRENGTH
	db ABSORB
	db STRING_SHOT
	db EARTHQUAKE
	db FISSURE
	db DIG
	db TOXIC
	db SCREECH
	db HARDEN
	db WITHDRAW
	db METRONOME
	db LICK
	db CLAMP
	db CONSTRICT
	db POISON_GAS
	db LEECH_LIFE
	db WATER_GUN ; replaces removed BUBBLE
	db FLASH
	db DEFENSE_CURL
	db FURY_ATTACK ; replaces removed FURY_SWIPES
	db REST
	db COIL ; replaces removed SHARPEN
	db SLASH
	db SUBSTITUTE
	db 0 ; end set

	db -1 ; end
