Route20WildMons:
; The sandbar between the two Seafoam cave mouths (blocks 26-29, rows 1-3).
; A haul-out and a tide line: seals resting out of the water, crabs at the
; wrack, slowpoke with their tails in the channel. Staryu and shellder are the
; tide-pool finds; the one grown kingler is the prize.
	def_grass_wildmons 20 ; encounter rate
	db 30, SEEL
	db 30, KRABBY
	db 31, SLOWPOKE
	db 32, SEEL
	db 32, KRABBY
	db 33, SLOWPOKE
	db 31, STARYU
	db 31, SHELLDER
	db 34, SEEL
	db 35, KINGLER
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db 30, TENTACOOL
	db 32, TENTACRUEL
	db 28, TENTACOOL
	db 31, STARYU
	db 34, TENTACRUEL
	db 33, STARYU
	db 35, TENTACOOL
	db 36, TENTACRUEL
	db 35, STARYU
	db 38, GYARADOS
	end_water_wildmons
