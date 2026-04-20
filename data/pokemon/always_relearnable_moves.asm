; v0.5: cross-species "tutor" moves available to ALL Pokemon via the
; Move Reminder NPC, regardless of species learnset. Designed to give
; biologically-universal moves (e.g. REST) to every mon without
; polluting wild captures or trainer-mon initial movesets.
;
; Format: list of move IDs, terminated by -1 ($ff).
;
; Read by PrepareRelearnableMoveList (engine/pokemon/evos_moves.asm).
AlwaysRelearnableMoves::
	db REST
	db -1 ; end
