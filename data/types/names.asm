TypeNames:
	table_width 2, TypeNames

	dw .Normal     ; $00
	dw .Fighting   ; $01
	dw .Flying     ; $02
	dw .Poison     ; $03
	dw .Ground     ; $04
	dw .Rock       ; $05
	dw .Normal     ; $06  BIRD (typeless placeholder; shows as "NORMAL")
	dw .Bug        ; $07
	dw .Dragon     ; $08  moved from $1A (Purple Yellow)
	dw .Dark       ; $09  new type (Purple Yellow)
	dw .Steel      ; $0A  new type (Purple Yellow)
	dw .Magma      ; $0B  new type (Purple Yellow)
	dw .Fungus     ; $0C  new type (Purple Yellow)
	dw .Ghost      ; $0D  moved from $08 (Purple Yellow)

REPT UNUSED_TYPES_END - UNUSED_TYPES
	dw .Normal
ENDR

	dw .Fire       ; $14
	dw .Water      ; $15
	dw .Grass      ; $16
	dw .Electric   ; $17
	dw .Psychic    ; $18
	dw .Ice        ; $19
	dw .Fairy      ; $1A  new type (Purple Yellow)
	dw .Gas        ; $1B  new type (Purple Yellow)

	assert_table_length NUM_TYPES

.Normal:   db "NORMAL@"
.Fighting: db "FIGHTING@"
.Flying:   db "FLYING@"
.Poison:   db "POISON@"
.Fire:     db "FIRE@"
.Water:    db "WATER@"
.Grass:    db "GRASS@"
.Electric: db "ELECTRIC@"
.Psychic:  db "PSYCHIC@"
.Ice:      db "ICE@"
.Ground:   db "GROUND@"
.Rock:     db "ROCK@"
.Bird:     db "BIRD@"
.Bug:      db "BUG@"
.Ghost:    db "GHOST@"
.Dragon:   db "DRAGON@"
.Dark:     db "DARK@"
.Fairy:    db "FAIRY@"
.Steel:    db "STEEL@"
.Gas:      db "GAS@"
.Magma:    db "MAGMA@"
.Fungus:   db "FUNGUS@"
