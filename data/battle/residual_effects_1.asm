; These are move effects (second value from the Moves table in bank $E).
ResidualEffects1:
; most non-side effects
	db HAZE_EFFECT ; handler kept although no current move uses it (future restore)
	db MIST_EFFECT ; handler kept; PROTECTED_BY_MIST infra is live via Guard Spec
	db FOCUS_ENERGY_EFFECT
	db CONFUSION_EFFECT
	db HEAL_EFFECT
	db TRANSFORM_EFFECT
	db LIGHT_SCREEN_EFFECT
	db REFLECT_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db BURN_EFFECT
	db SUBSTITUTE_EFFECT
	db MIMIC_EFFECT
	db LEECH_SEED_EFFECT
	db PROTECT_EFFECT ; v1.0 (2026-11-02): its own handler, which runs its own tests (protect_lock_on.asm)
	db LOCK_ON_EFFECT ; v1.0 (2026-11-02): likewise; it calls MoveHitTest itself, as LEECH SEED does
	db -1 ; end
