; Since Generation IV, the move priority ranges from -7 to 5.
; To avoid working with negative numbers, we shift the priority
; range to be from 0 to 12.
PriorityMovesList:
    ; BIRD
    db TRANSFORM,      8
    ; ELECTRIC
    db VOLT_TACKLE,    8
    ; FIGHTING
    db MACH_PUNCH,     8
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
    db 7 ; v1.0 (2026-09-27): the "priority" a $ff pick reads here (since N3-2 a held side picks a real move;
         ; only HazeEffect_, which no move uses - HAZE is a GAS attack here - and the dead link branch still
         ; write a $ff) - HandleMovePriority
         ; compares before it tests for the end, so $ff matches the -1 above and takes the next byte. 7 = none:
         ; speed decides, as in vanilla (it read the next ROM byte, $21 = 33, and always went first). Keep it
         ; right after the end marker.
