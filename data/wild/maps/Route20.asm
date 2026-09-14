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
; v1.0 (2026-09-14): TENTACOOL evolves at 40 now, and this is the adult crossing - the
; identity is the 34.8% of adults, so the crossing rose instead of losing them. The
; GYARADOS apex went 38 -> 44 with them: a 1.2% prize must still outrank the bulk.
	db 30, TENTACOOL
	db 40, TENTACRUEL
	db 28, TENTACOOL
	db 31, STARYU
	db 40, TENTACRUEL
	db 33, STARYU
	db 35, TENTACOOL
	db 40, TENTACRUEL
	db 35, STARYU
	db 44, GYARADOS
	end_water_wildmons
