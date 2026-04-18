; Since Generation IV, the move priority ranges from -7 to 5.
; To avoid working with negative numbers, we shift the priority
; range to be from 0 to 12.
PriorityMovesList:
    ; BIRD
    db TRANSFORM,      8
    ; ELECTRIC
    db VOLT_TACKLE,    8
    ; GHOST
    db SHADOW_SNEAK,   8
    ; NORMAL
    db QUICK_ATTACK,   8
    db EXTREMESPEED,   9
    ; STEEL
    db BULLET_PUNCH,   8
    ; WATER
    db AQUA_JET,       8
    db -1 ; end
