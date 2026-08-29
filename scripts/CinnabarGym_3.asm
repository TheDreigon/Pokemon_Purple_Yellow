CinnabarGymPrintGymGuideText::
; v0.7 (his 2026-08-29 request): the first ELIGIBLE pre-badge visit earns a
; FRESH WATER. Eligible = previous badge in hand; once per gym,
; and a full bag defers the gift to the next talk (flag set only on success).
	CheckEvent EVENT_GOT_GYM_GUIDE_WATER_CINNABAR
	jr nz, .noFreshWater
	ld a, [wObtainedBadges]
	bit BIT_MARSHBADGE, a
	jr z, .noFreshWater ; not yet eligible for this gym
	ld a, [wObtainedBadges]
	bit BIT_VOLCANOBADGE, a
	jr nz, .noFreshWater ; already holds THIS gym's badge
	lb bc, FRESH_WATER, 1
	call GiveItem
	jr nc, .noFreshWater ; bag full: defer
	ld hl, CinnabarGymGuideFreshWaterText
	call PrintText
	SetEvent EVENT_GOT_GYM_GUIDE_WATER_CINNABAR
.noFreshWater
	CheckEvent EVENT_BEAT_BLAINE
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
	jr .done
.afterBeat
	ld hl, .BeatBlaineText
.done
	call PrintText
	ret

.ChampInMakingText:
	text_far _CinnabarGymGymGuideChampInMakingText
	text_end

.BeatBlaineText:
	text_far _CinnabarGymGymGuideBeatBlaineText
	text_end

Func_f2150::
	ld hl, TextPointers_f215d
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

TextPointers_f215d:
	dw CinnabarGymText_f2169
	dw CinnabarGymText_f216e
	dw CinnabarGymText_f2173
	dw CinnabarGymText_f2178
	dw CinnabarGymText_f217d
	dw CinnabarGymText_f2182

CinnabarGymText_f2169:
	text_far _CinnabarGymText_1
	text_end

CinnabarGymText_f216e:
	text_far _CinnabarGymText_2
	text_end

CinnabarGymText_f2173:
	text_far _CinnabarGymText_3
	text_end

CinnabarGymText_f2178:
	text_far _CinnabarGymText_4
	text_end

CinnabarGymText_f217d:
	text_far _CinnabarGymText_5
	text_end

CinnabarGymText_f2182:
	text_far _CinnabarGymText_6
	text_end

CinnabarGymText_f2187:
	text_far _CinnabarGymText_7 ; unused
	text_end


CinnabarGymGuideFreshWaterText:
	text_far _GymGuideFreshWaterText
	sound_get_item_1
	text_promptbutton
	text_end
