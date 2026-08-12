	object_const_def
	const_export BILLSHOUSE_BILL_POKEMON
	const_export BILLSHOUSE_BILL1
	const_export BILLSHOUSE_BILL2

BillsHouse_Object:
	db $d ; border block

	def_warp_events
; 🔴 ROUTE_25 explicitly, NOT LAST_MAP. BILLS_GARDEN uses the OVERWORLD tileset,
; so it counts as an "outside" map: warping out of it makes WarpFound2 write
; wLastMap = BILLS_GARDEN (home/overworld.asm:491-492). With LAST_MAP here, the
; front door then led straight back into the garden, and the house had no exit
; at all from the first garden visit onward. kep-hack hits the same thing and
; solves it the same way.
	warp_event  2,  7, ROUTE_25, 1
	warp_event  3,  7, ROUTE_25, 1
; Warp 3: the back door to BILL's garden. Walled off until he opens it -- the
; block at (12,3)-(13,3) is swapped out by BillsHouseShowOrHideGardenWall below,
; so this warp is simply unreachable until then and needs no guard of its own.
	warp_event 11,  0, BILLS_GARDEN, 1

	def_bg_events

	def_object_events
	object_event  6,  5, SPRITE_KABUTO, STAY, NONE, TEXT_BILLSHOUSE_BILL_POKEMON
	object_event  4,  4, SPRITE_BILL, STAY, NONE, TEXT_BILLSHOUSE_BILL_SS_TICKET
	object_event  4,  4, SPRITE_BILL, STAY, NONE, TEXT_BILLSHOUSE_BILL_CHECK_OUT_MY_RARE_POKEMON ; v0.7: was 6,5. This is where the rescue scene leaves him, so a returning player finds him where they left him - and the Eevee walk below only needs one starting point instead of two.

	def_warps_to BILLS_HOUSE
