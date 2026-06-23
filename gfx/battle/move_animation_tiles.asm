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

SlotMachineTiles2::
	INCBIN "gfx/slots/slots_2.2bpp"
SlotMachineTiles2End::
