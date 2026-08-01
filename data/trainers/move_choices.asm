MACRO move_choices
	IF _NARG
		db \# ; all args
	ENDC
	db 0 ; end
	DEF list_index += 1
ENDM

; move choice modification methods that are applied for each trainer class
;
; Layers: 1 = don't waste turns (floor)  2 = setup/stat moves on turn one
;         3 = prefer type-effective damage  4 = status when clean, heal low
; These lists are live in BOTH difficulties; Hard mode overrides bosses and
; semi-bosses to all four (HardModeBossAIMods in trainer_ai.asm).
;
; v0.7 policy (Forte, 2026-07-27): a boss's list carries every layer its
; MOVESET was designed around, and omits layers with nothing to act on.
; Five classes were raised over the Yellow Legacy values on that basis
; (Brock, Lt. Surge, Erika, Sabrina, Janine — see the per-line comments).
; The ones left short are deliberate: Koga has zero setup moves for layer 2
; to score; Blaine/Giovanni carry status on only 1-2 sets out of 10+ and
; play as aggressors; Misty's only setup move is one rematch Growth; the
; rival's arc (1 -> 1,3 -> all four) is the brash kid learning discipline,
; told through AI.
TrainerClassMoveChoiceModifications:
	list_start TrainerClassMoveChoiceModifications
	move_choices 1       ; YOUNGSTER
	move_choices 1       ; BUG CATCHER
	move_choices 1       ; LASS
	move_choices 1, 3    ; SAILOR
	move_choices 1       ; JR_TRAINER_M
	move_choices 1       ; JR_TRAINER_F
	move_choices 1, 2, 3 ; POKEMANIAC
	move_choices 1, 2    ; SUPER_NERD
	move_choices 1       ; HIKER
	move_choices 1       ; BIKER
	move_choices 1, 3    ; BURGLAR
	move_choices 1       ; ENGINEER
	move_choices 1, 3    ; FISHER
	move_choices 1, 3    ; SWIMMER
	move_choices 1       ; CUE_BALL
	move_choices 1       ; GAMBLER
	move_choices 1, 3    ; BEAUTY
	move_choices 1, 2    ; PSYCHIC_TR
	move_choices 1       ; ROCKER
	move_choices 1       ; JUGGLER
	move_choices 1       ; TAMER
	move_choices 1       ; BIRD_KEEPER
	move_choices 1       ; BLACKBELT
	move_choices 1       ; RIVAL1
	move_choices 1, 2, 3, 4 ; PROF_OAK
	move_choices 1, 2, 3, 4 ; SMITH
	move_choices 1, 2, 3, 4 ; CRAIG
	move_choices 1, 2    ; SCIENTIST
	move_choices 1, 2, 3 ; GIOVANNI
	move_choices 1       ; ROCKET
	move_choices 1, 3    ; COOLTRAINER_M
	move_choices 1, 3    ; COOLTRAINER_F
	move_choices 1, 2, 3, 4 ; BRUNO
	move_choices 1, 2, 3 ; BROCK — v0.7: was 1. Both main mons carry a setup move (Defense Curl, Coil) and the rematch adds Swords Dance/Intimidate; the fortify-then-hit pattern IS Brock. No status/heal moves at all, so layer 4 stays off.
	move_choices 1, 3, 4 ; MISTY
	move_choices 1, 2, 3, 4 ; LT_SURGE — v0.7: +4. His sets are built on the paraflinch combos (Thunder Wave on Magneton in BOTH teams, Nuzzle); without layer 4 the AI never opens the para game it was designed around.
	move_choices 1, 2, 3, 4 ; ERIKA — v0.7: +2. LEECH_SEED_EFFECT is on layer 2's turn-one list, and turn-one Leech Seed (Tangela, Vileplume; rematch Victreebel Swords Dance) is her signature opening. Layer 1 already stops the re-seed.
	move_choices 1, 3, 4 ; KOGA
	move_choices 1, 2, 3 ; BLAINE
	move_choices 1, 2, 3, 4 ; SABRINA — v0.7: +2. Seven of her ten sets carry a layer-2 move (Calm Mind x3, Quiver Dance x2, Reflect, Substitute). She foresees the fight: setup first, then win. The biggest missing-layer/moveset mismatch in the game.
	move_choices 1, 2    ; GENTLEMAN
	move_choices 1, 3    ; RIVAL2
	move_choices 1, 2, 3, 4 ; RIVAL3
	move_choices 1, 2, 3, 4 ; LORELEI
	move_choices 1       ; CHANNELER
	move_choices 1, 2, 3, 4 ; AGATHA
	move_choices 1, 2, 3, 4 ; LANCE
	move_choices 1, 2, 3, 4 ; WEEBRA
	move_choices 1, 2, 3, 4 ; JANINE — v0.7: +2. Venomoth's Sleep Powder + Quiver Dance is the sleep-then-setup combo by design, and Beedrill opens Swords Dance; also aligns her with every other semi-boss (all at four).
	move_choices 1, 2, 3, 4 ; JOY
	move_choices 1, 2, 3, 4 ; JENNY
	move_choices 1, 2, 3, 4 ; JESSIE_AND_JAMES (boss-tier always, even in Normal mode)
	move_choices 1, 2, 3, 4 ; FORTE
	assert_list_length NUM_TRAINERS
