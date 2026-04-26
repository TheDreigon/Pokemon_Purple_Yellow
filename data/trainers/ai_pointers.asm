TrainerAIPointers:
	table_width 3, TrainerAIPointers
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, JugglerAI ; juggler
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 2, GenericAI ; blackbelt
	dbw 3, GenericAI ; rival1 (no item bag — too early-game)
	dbw 2, ProfOakAI ; prof_oak (v0.7 hard mode boss item bag)
	dbw 3, GenericAI ; Smith
	dbw 1, GenericAI ; Craig
	dbw 3, GenericAI
	dbw 2, GiovanniAI ; giovanni — bumped 1→2 for 3-item bag (FR/XAtk/GuardSpec)
	dbw 3, GenericAI
	dbw 2, CooltrainerMAI ; cooltrainerm (non-boss; vanilla AI kept)
	dbw 1, CooltrainerFAI ; cooltrainerf (non-boss; vanilla AI kept)
	dbw 2, BrunoAI ; bruno
	dbw 1, BrockAI ; brock — was 5 (vanilla over-allocation), now 1 per mon
	dbw 1, MistyAI ; misty
	dbw 1, LtSurgeAI ; surge
	dbw 1, ErikaAI ; erika
	dbw 2, KogaAI ; koga
	dbw 2, BlaineAI ; blaine
	dbw 2, SabrinaAI ; sabrina — bumped 1→2 (E4-tier psychic)
	dbw 3, GenericAI
	dbw 1, Rival2AI ; rival2
	dbw 2, Rival3AI ; rival3 — bumped 1→2 (Champion fight)
	dbw 2, LoreleiAI ; lorelei
	dbw 3, GenericAI
	dbw 2, AgathaAI ; agatha
	dbw 2, LanceAI ; lance — bumped 1→2 (Champion-tier dragon master)
	dbw 3, GenericAI ; Weebra
	dbw 1, JanineAI ; janine (v0.7 hard mode boss item bag)
	dbw 2, JoyAI ; joy (v0.7 hard mode boss item bag — nurse-tier heal)
	dbw 1, JennyAI ; jenny (v0.7 hard mode boss item bag)
	dbw 1, JessieAndJamesAI ; Jessie & James (boss-tier; v0.7 hard mode item bag)
	assert_table_length NUM_TRAINERS
