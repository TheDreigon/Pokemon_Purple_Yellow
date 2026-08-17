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
	dbw 2, KiyoAI ; KIYO (was ENGINEER) — his own routine since the bags went
	              ; per-fight: X Attack roll plus a Dire Hit roll for the
	              ; rematch bag, and both of his heal tiers tried in order.
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
	dbw 2, SelfInsertBossAI ; Smith (semi-boss: 3x Full Restore bag)
	dbw 2, SelfInsertBossAI ; Craig (semi-boss: 3x Full Restore bag)
	dbw 3, GenericAI
	dbw 2, GiovanniAI ; giovanni — 2 AI item-uses/mon for its 4-item bag (FR/XAtk/XDef/FullHeal)
	dbw 3, GenericAI
	dbw 2, CooltrainerMAI ; cooltrainerm (non-boss; vanilla AI kept)
	dbw 1, CooltrainerFAI ; cooltrainerf (non-boss; vanilla AI kept)
	dbw 2, BrunoAI ; bruno
	dbw 1, BrockAI ; brock
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
	dbw 2, SelfInsertBossAI ; Weebra (semi-boss: 3x Full Restore bag)
	dbw 1, JanineAI ; janine (v0.7 hard mode boss item bag)
	dbw 2, JoyAI ; joy (v0.7 hard mode boss item bag — nurse-tier heal)
	dbw 1, JennyAI ; jenny (v0.7 hard mode boss item bag)
	dbw 1, JessieAndJamesAI ; Jessie & James (boss-tier; v0.7 hard mode item bag)
	dbw 3, ProfOakAI ; Forte (superboss). Was GenericAI, which never touches the
	                 ; item bag — so ForteBossBag was populated every hard-mode
	                 ; fight and never consumed, making the game's hardest boss
	                 ; the only one that could not heal. The boss AI routines are
	                 ; class-agnostic (they consume whichever bag was populated),
	                 ; and Oak is the other L75+ superboss, so his profile fits.
	dbw 1, BillAI ; bill — heals but never buffs; see the routine for why
	assert_table_length NUM_TRAINERS
