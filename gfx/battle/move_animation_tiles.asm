; Move-animation tile graphics + Slot Machine bonus tile graphics.
;
; v0.7: extracted from engine/battle/animations.asm (bank $1E) into a
; separate bank to give data/moves/animations.asm ample room to grow
; during the v0.7 move-animation polish pass.
;
; All consumers load these via BANK(label) + Far/CopyVideoData, so the
; bank change is transparent — they're just GFX referenced by labels.
;
; Note: MoveAnimationTiles0 and MoveAnimationTiles2 are intentionally
; aliased to the same address (the move_anim_0.2bpp INCBIN) — vanilla
; Yellow design, the second 64-tile tileset reuses the first one.

MoveAnimationTiles0::
MoveAnimationTiles2::
	INCBIN "gfx/battle/move_anim_0.2bpp"

MoveAnimationTiles1::
	INCBIN "gfx/battle/move_anim_1.2bpp"

; v1.0 (2026-11-26): the splash's shooting star (LoadShootingStarGraphics), its own copy of the two tiles it read from
; MoveAnimationTiles1 (tiles 3 and 19, now the 20 px electric ball's). Read by bank and address only.
ShootingStarTiles::
	INCBIN "gfx/splash/shooting_star.2bpp"
ShootingStarTilesEnd::

SlotMachineTiles2::
	INCBIN "gfx/slots/slots_2.2bpp"
SlotMachineTiles2End::
