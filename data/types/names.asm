TypeNames:
	table_width 2, TypeNames

	dw .Normal
	dw .Fighting
	dw .Flying
	dw .Poison
	dw .Ground
	dw .Rock
	dw .Normal
	dw .Bug
	dw .Ghost
	dw .Dark      ; new type (Purple Yellow)
	dw .Fairy     ; new type (Purple Yellow)
	dw .Steel     ; new type (Purple Yellow)
	dw .Gas       ; new type (Purple Yellow)
	dw .Magma     ; new type (Purple Yellow)
	dw .Fungi     ; new type (Purple Yellow)

REPT UNUSED_TYPES_END - UNUSED_TYPES
	dw .Normal
ENDR

	dw .Fire
	dw .Water
	dw .Grass
	dw .Electric
	dw .Psychic
	dw .Ice
	dw .Dragon

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
.Fungi:    db "FUNGI@"
