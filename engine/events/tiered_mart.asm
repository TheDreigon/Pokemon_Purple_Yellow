; Top-level entry point for `script_tiered_mart` clerks. Reached via
; farcall from the dict2 dispatch in home (DisplayTextID). On entry,
; wItemList holds the script-side extras (count + items + $ff) that
; the home dispatcher loaded via LoadItemList while the map's ROM bank
; was still selected. We print the greeting (PrintText is in home, so
; reachable from any bank), snapshot extras to wMartExtras, rebuild
; wItemList from the global tiered inventory filtered by badges +
; post-E4 flag, append the extras, and chain into DisplayPokemartDialogue_
; exactly like the regular `script_mart` path would.
TieredMartHandler::
	; 0) Print the standard pokemart greeting first (matches the look
	;    and feel of the regular DisplayPokemartDialogue path).
	ld hl, PokemartGreetingText
	call PrintText
	; 1) Snapshot extras (currently in wItemList) to wMartExtras.
	ld hl, wItemList
	ld de, wMartExtras
	ld a, [hli]
	ld [de], a                   ; extras count
	inc de
	and a
	jr z, .build
	ld b, a
.copy_in
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_in
.build
	; 2) Build the tiered inventory at wItemList from scratch.
	call BuildTieredMartList
	; 3) Mimic DisplayPokemartDialogue's setup: point wItemListPointer
	;    at wItemList and pick the priced item list menu.
	ld hl, wItemList
	ld a, h
	ld [wItemListPointer], a
	ld a, l
	ld [wItemListPointer + 1], a
	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	; 4) Hand off to the shared mart UI. DisplayPokemartDialogue_ lives
	;    in the same bank, so a plain jp tail-calls it cleanly: the
	;    home-side `homecall` returns once its menu loop ends.
	jp DisplayPokemartDialogue_

; Builds the regular-pokemart inventory at runtime by filtering the global
; RegularMartTieredInventory table against the player's current badge count.
; If wMartType == TIERED_MART_TYPE_ELITE, the EliteMartAddons table is
; also walked and any items unlocked by the player's post-E4 / post-rematch
; progress are appended. Finally any per-mart fixed extras snapshotted into
; wMartExtras (typically TMs) are appended. Output goes to wItemList in the
; same `db count, item, item, ..., -1` format that LoadItemList would
; produce, so DisplayPokemartDialogue_ can consume it unchanged.
;
; Tier semantics:
;   regular table entries -> tier byte = required badge count (0..8)
;   elite table entries   -> tier byte 9 (post-E4 unlock, gated by wGameStage)
;                            tier byte 10 (post-E4-rematch unlock, gated by
;                                          EVENT_BEAT_E4_REMATCH)

BuildTieredMartList::
	call CountObtainedBadges     ; b = badge count (0..8)
	ld hl, RegularMartTieredInventory
	ld de, wItemList + 1         ; reserve byte 0 for the count
	ld c, 0                      ; running item count
.regular_loop
	ld a, [hli]                  ; tier byte
	cp -1
	jr z, .check_elite
	; tiers 0-8: include if tier <= badge count
	cp b
	jr z, .reg_include           ; tier == badges -> ok
	jr c, .reg_include           ; tier <  badges -> ok
	; tier > badges: skip the item byte
	inc hl
	jr .regular_loop
.reg_include
	ld a, [hli]                  ; item id
	ld [de], a
	inc de
	inc c
	jr .regular_loop
.check_elite
	ld a, [wMartType]
	cp TIERED_MART_TYPE_ELITE
	jr nz, .append_extras        ; regular mart -> skip elite addons
	ld hl, EliteMartAddons
.elite_loop
	ld a, [hli]                  ; tier byte (9 or 10)
	cp -1
	jr z, .append_extras
	cp 10
	jr z, .elite_t10
	; tier 9: gated by wGameStage != 0
	ld a, [wGameStage]
	and a
	jr z, .elite_skip
	jr .elite_include
.elite_t10
	; tier 10: gated by EVENT_BEAT_E4_REMATCH
	CheckEvent EVENT_BEAT_E4_REMATCH
	jr z, .elite_skip
.elite_include
	ld a, [hli]                  ; item id
	ld [de], a
	inc de
	inc c
	jr .elite_loop
.elite_skip
	inc hl                       ; skip item byte
	jr .elite_loop
.append_extras
	; Append the script-provided extras (typically TMs) that were copied
	; into wMartExtras by the home dispatcher before the bank switch.
	ld a, [wMartExtras]
	and a
	jr z, .done                  ; no extras
	ld b, a                      ; extras count
	ld hl, wMartExtras + 1
.copy_extra
	ld a, [hli]
	ld [de], a
	inc de
	inc c
	dec b
	jr nz, .copy_extra
.done
	ld a, $ff
	ld [de], a                   ; terminator
	ld a, c
	ld [wItemList], a            ; count at byte 0
	ret

; Counts the bits set in wObtainedBadges. Returns the count in B.
CountObtainedBadges::
	ld a, [wObtainedBadges]
	ld c, 8
	ld b, 0
.loop
	rrca
	jr nc, .skip
	inc b
.skip
	dec c
	jr nz, .loop
	ret

; Global tiered inventory used by every regular pokemart clerk.
; Format: pairs of `db tier, item`, terminated by `db -1`.
; Tiers map to required badge counts (0..8).
;
; Edits here change the inventory of EVERY regular pokemart at once
; (Viridian, Pewter, Cerulean, Lavender, Vermilion, Celadon Mart 2F,
; Saffron, Fuchsia, Cinnabar, Indigo Plateau).
; Celadon Mart 4F (Poké Doll + stones) and 5F (vitamins + X-items)
; are unrelated and keep their fixed `script_mart` lists.
RegularMartTieredInventory::
	; T0 - 0 badges
	db 0, POKE_BALL
	db 0, POTION
	db 0, ANTIDOTE
	db 0, REPEL
	db 0, ESCAPE_ROPE
	; T1 - 1 badge (Boulder)
	db 1, AWAKENING
	db 1, PARLYZ_HEAL
	; T2 - 2 badges (Cascade)
	db 2, GREAT_BALL
	db 2, SUPER_POTION
	db 2, BURN_HEAL
	; T3 - 3 badges (Thunder)
	db 3, REVIVE
	db 3, ICE_HEAL
	; T4 - 4 badges (Rainbow)
	db 4, SUPER_REPEL
	db 4, FULL_HEAL
	; T5 - 5 badges (Soul)
	db 5, ULTRA_BALL
	db 5, HYPER_POTION
	; T6 - 6 badges (Marsh)
	db 6, MAX_REPEL
	; T7 - 7 badges (Volcano)
	db 7, MAX_POTION
	; T8 - 8 badges (Earth)
	db 8, FULL_RESTORE
	db -1

; Elite addons appended by `script_tiered_mart_elite` clerks (Indigo
; Plateau pre-E4 clerk + Celadon Mart 2F regular clerk). Format same as
; RegularMartTieredInventory but the tier byte gates differently:
;   tier  9 -> player has beaten the Elite Four at least once
;             (wGameStage != 0; set in scripts/HallOfFame.asm)
;   tier 10 -> player has beaten the Elite Four AGAIN as Champion
;             (EVENT_BEAT_E4_REMATCH; set in scripts/ChampionsRoom.asm)
EliteMartAddons::
	; T9 - Post E4
	db 9, ETHER
	db 9, ELIXER
	db 9, PP_UP
	db 9, MAX_REVIVE
	; T10 - Post E4 Rematch
	db 10, MAX_ETHER
	db 10, MAX_ELIXER
	db 10, PP_MAX
	db 10, RARE_CANDY
	db -1
