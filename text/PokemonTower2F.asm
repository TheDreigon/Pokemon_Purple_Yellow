_PokemonTower2FRivalWhatBringsYouHereText::
	text "<RIVAL>: Hey,"
	line "<PLAYER>! What"
	cont "brings you here?"
	cont "Your #MON"
	cont "don't look dead!"

	para "I can at least"
	line "make them faint!"
	cont "Let's go, pal!"
	done

_PokemonTower2FRivalDefeatedText::
	text "What?"
	line "You stinker!"

	para "I took it easy on"
	line "you too!"
	prompt

; v1.0 (R9x, 2026-10-01): Yellow Legacy's last lines
; said GHOST moves "may not hit normal-types" - false in this chart, where GHOST hits
; NORMAL neutrally. What holds is the other way round: NORMAL and FIGHTING attacks
; cannot touch a GHOST (SEISMIC TOSS and SUPER FANG too, since R9c). "attacks", not
; "moves": SUPERSONIC, a NORMAL status move,
; still lands on one. "Most": the FIGHT menu shows the typeless BIRD type as NORMAL
; (data/types/names.asm), and TRI ATTACK, BIDE and STRUGGLE, BIRD here, hit a GHOST.
; Lines under the arrow: 17.
_PokemonTower2FRivalVictoryText::
	text "<RIVAL>: Well,"
	line "look at all your"
	cont "wimpy #MON!"

	para "Toughen them up a"
	line "bit more!"

	para "Also watch out"
	line "for GHOST types!"

	para "Most NORMAL and"
	line "FIGHTING attacks"
	cont "can't touch them!"
	prompt

_PokemonTower2FRivalHowsYourDexText::
	text "How's your #DEX"
	line "coming, pal?"
	cont "I just caught a"
	cont "CUBONE!"

	para "I can't find the"
	line "grown-up MAROWAK"
	cont "yet!"

	para "I doubt there are"
	line "any left! Well, I"
	cont "better get going!"
	cont "I've got a lot to"
	cont "accomplish, pal!"

	para "Smell ya later!"
	done

_PokemonTower2FChannelerText::
	text "Even we could not"
	line "identify the"
	cont "wayward GHOSTs!"

	para "A SILPH SCOPE"
	line "might be able to"
	cont "unmask them."
	done
