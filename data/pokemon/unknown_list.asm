; Special-case species list for the debug "can-learn-this-move" checker
; (Func_3b0a2 in engine/pokemon/evos_moves.asm). Wrapped in IF DEF(_DEBUG)
; on the include side — this file is dead code in release builds.
;
; The vanilla disassembly comment said "unreferenced function", which was
; true in vanilla Yellow but no longer accurate here: pureRGB / our hack
; wired Func_3b079 (which calls Func_3b0a2) into engine/debug/debug_menu
; .asm:1224 to mark "×" on unlearnable moves in some debug menu. Names
; kept verbatim (Pointer_3b0ee) to preserve git blame; semantics aren't
; fully reverse-engineered.
;
; Best guess at what membership in this list means: these 32 species skip
; the "already-known move" guard inside Func_3b0a2. So if the move is
; already in their 4-slot moveset, the function still proceeds to the
; learnset walk instead of bailing. Why those specific 32 — unclear.

Pointer_3b0ee:
	db NIDOKING
	db IVYSAUR
	db EXEGGUTOR
	db GENGAR
	db NIDOQUEEN
	db ARCANINE
	db GYARADOS
	db BLASTOISE
	db GOLEM
	db DRAGONITE
	db NINETALES
	db DRAGONAIR
	db KABUTOPS
	db OMASTAR
	db JIGGLYPUFF
	db FLAREON
	db JOLTEON
	db VAPOREON
	db BEEDRILL
	db BUTTERFREE
	db MACHAMP
	db CLOYSTER
	db CLEFABLE
	db ALAKAZAM
	db STARMIE
	db VENUSAUR
	db TENTACRUEL
	db CHARMELEON
	db WARTORTLE
	db CHARIZARD
	db VILEPLUME
	db VICTREEBEL
	db -1 ; end
