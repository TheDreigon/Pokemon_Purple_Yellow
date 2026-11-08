CreditsTextPointers:
; entries correspond to CRED_* constants
	table_width 2, CreditsTextPointers
	dw CreditsText_Version
	dw CreditsText_Tajiri
	dw CreditsText_Oota
	dw CreditsText_Morimoto
	dw CreditsText_Watanabe
	dw CreditsText_Masuda
	dw CreditsText_Nishino
	dw CreditsText_Sugimori
	dw CreditsText_Nishida
	dw CreditsText_Miyamoto
	dw CreditsText_Kawaguchi
	dw CreditsText_Ishihara
	dw CreditsText_Yamauchi
	dw CreditsText_Zinnai
	dw CreditsText_Hishida
	dw CreditsText_Sakai
	dw CreditsText_Yamaguchi
	dw CreditsText_Yamamoto
	dw CreditsText_Taniguchi
	dw CreditsText_Nonomura
	dw CreditsText_Fuziwara
	dw CreditsText_Matsusima
	dw CreditsText_Tomisawa
	dw CreditsText_Kawamoto
	dw CreditsText_Kakei
	dw CreditsText_Tsuchiya
	dw CreditsText_Nakamura
	dw CreditsText_Yuda
	dw CreditsText_Pokemon
	dw CreditsText_Director
	dw CreditsText_Programmers
	dw CreditsText_CharacterDesign
	dw CreditsText_Music
	dw CreditsText_SoundEffects
	dw CreditsText_GameDesign
	dw CreditsText_MonsterDesign
	dw CreditsText_GameScenario
	dw CreditsText_ParametricDesign
	dw CreditsText_MapDesign
	dw CreditsText_Testing
	dw CreditsText_SpecialThanks
	dw CreditsText_Producer
	dw CreditsText_ExecutiveProducer
	dw CreditsText_Tamada
	dw CreditsText_Oota2
	dw CreditsText_Yoshikawa
	dw CreditsText_Oota23
	dw CreditsText_Yoshida
	dw CreditsText_Matsumita
	dw CreditsText_Seya
	dw CreditsText_Sekine
	dw CreditsText_Shimamura
	dw CreditsText_Shimoyamada
	dw CreditsText_SuperMarioClub
	dw CreditsText_Izushi
	dw CreditsText_Nomura
	dw CreditsText_Harada
	dw CreditsText_Yamagami
	dw CreditsText_Nishimura
	dw CreditsText_Saeki
	dw CreditsText_Fuzii
	dw CreditsText_Shogakukan
	dw CreditsText_Ootani
	dw CreditsText_PikachuVoice
	dw CreditsText_USStaff
	dw CreditsText_USCoord
	dw CreditsText_Tilden
	dw CreditsText_Kawakami
	dw CreditsText_Nakamura2
	dw CreditsText_Shoemake
	dw CreditsText_Osborne
	dw CreditsText_Translation
	dw CreditsText_Ogasawara
	dw CreditsText_Iwata
	dw CreditsText_Izushi2
	dw CreditsText_Harada2
	dw CreditsText_Murakawa
	dw CreditsText_Fukui
	dw CreditsText_SuperMarioClub2
	dw CreditsText_Paad
	dw CreditsText_Producers
	dw CreditsText_Hosokawa
	dw CreditsText_Okubo
	dw CreditsText_Nakamichi
	dw CreditsText_Yoshimura
	dw CreditsText_Yamazaki

	dw CreditsText_Creator
	dw CreditsText_SpriteArtists
	dw CreditsText_Pret1
	dw CreditsText_Pret2
	dw CreditsText_Pret3
	dw CreditsText_Pret4
	dw CreditsText_ReaderDragon
	dw CreditsText_GhostMissingNo
	dw CreditsText_ZetaNull
	dw CreditsText_BlueEmerald

	dw CreditsText_TheDreigon
	dw CreditsText_WithHelpFrom
	dw CreditsText_ClaudeCode
	dw CreditsText_PyBattle
	dw CreditsText_PyBattle2
	dw CreditsText_PyBattle3
	dw CreditsText_PyBattle4
	dw CreditsText_PyMoves
	dw CreditsText_PyMoves2
	dw CreditsText_PyMoves3
	dw CreditsText_PyMoves4
	dw CreditsText_PyTypes
	dw CreditsText_PyTypes2
	dw CreditsText_PyTypes3
	dw CreditsText_PyTypes4
	dw CreditsText_PyStats
	dw CreditsText_PyStats2
	dw CreditsText_PyStats3
	dw CreditsText_PyStats4
	dw CreditsText_PySprites
	dw CreditsText_PySprites2
	dw CreditsText_PyMap
	dw CreditsText_PyMap2
	dw CreditsText_PyMap3
	dw CreditsText_PyMap4
	dw CreditsText_PyTrainers
	dw CreditsText_PyTrainers2
	dw CreditsText_PyTrainers3
	dw CreditsText_PyTrainers4
	dw CreditsText_PyMore
	dw CreditsText_PyMore2
	dw CreditsText_PyMore3
	dw CreditsText_PyMore4
	dw CreditsText_Thanks
	dw CreditsText_Thanks2
	dw CreditsText_Thanks3
	dw CreditsText_Thanks4
	dw CreditsText_YellowLegacy
	dw CreditsText_KEP
	dw CreditsText_ExtremeYellow
	dw CreditsText_Shin
	dw CreditsText_PureRGB
	dw CreditsText_Yume
	dw CreditsText_Solus
	dw CreditsText_RedPlusPlus
	dw CreditsText_Gold97
	dw CreditsText_Gold97_2
	dw CreditsText_RedStarBlueStar
	dw CreditsText_Originals
	dw CreditsText_RGB
	dw CreditsText_Yellow
	dw CreditsText_GSC
	dw CreditsText_DevelopedUsing
	dw CreditsText_AsTheBase
	dw CreditsText_YLArtists
	dw CreditsText_YLArtists2
	dw CreditsText_YLArtists3
	dw CreditsText_YLArtists4
	dw CreditsText_YLArtists5
	dw CreditsText_YellowVersion
	assert_table_length NUM_CRED_STRINGS

; the offset byte: a string starts on column 9 + its offset (PlaceCreditsText). Every row of the roll
; is centred (1.0): an odd width w puts its middle tile on column 9, offset (1 - w) / 2; an even
; width starts on column 10 - w / 2, offset 1 - w / 2 ("#" draws four tiles). Widths, offset:
;  3 /  4 = -1
;  5 /  6 = -2
;  7 /  8 = -3
;  9 / 10 = -4
; 11 / 12 = -5
; 13 / 14 = -6
; 15 / 16 = -7
; 17 / 18 = -8
; 19 / 20 = -9
CreditsText_Version:
	db -6, "PURPLE YELLOW@"
CreditsText_Tajiri:
	db -6, "SATOSHI TAJIRI@"
CreditsText_Oota:
	db -6, "TAKENORI OOTA@"
CreditsText_Morimoto:
	db -7, "SHIGEKI MORIMOTO@"
CreditsText_Watanabe:
	db -7, "TETSUYA WATANABE@"
CreditsText_Masuda:
	db -6, "JUNICHI MASUDA@"
CreditsText_Nishino:
	db -6, "KOHJI NISHINO@"
CreditsText_Sugimori:
	db -5, "KEN SUGIMORI@"
CreditsText_Nishida:
	db -6, "ATSUKO NISHIDA@"
CreditsText_Miyamoto:
	db -7, "SHIGERU MIYAMOTO@"
CreditsText_Kawaguchi:
	db -8, "TAKASHI KAWAGUCHI@"
CreditsText_Ishihara:
	db -8, "TSUNEKAZU ISHIHARA@"
CreditsText_Yamauchi:
	db -7, "HIROSHI YAMAUCHI@"
CreditsText_Zinnai:
	db -7, "HIROYUKI ZINNAI@"
CreditsText_Hishida:
	db -7, "TATSUYA HISHIDA@"
CreditsText_Sakai:
	db -6, "YASUHIRO SAKAI@"
CreditsText_Yamaguchi:
	db -7, "WATARU YAMAGUCHI@"
CreditsText_Yamamoto:
	db -8, "KAZUYUKI YAMAMOTO@"
CreditsText_Taniguchi:
	db -8, "RYOHSUKE TANIGUCHI@"
CreditsText_Nonomura:
	db -8, "FUMIHIRO NONOMURA@"
CreditsText_Fuziwara:
	db -7, "MOTOFUMI FUZIWARA@"
CreditsText_Matsusima:
	db -7, "KENJI MATSUSIMA@"
CreditsText_Tomisawa:
	db -7, "AKIHITO TOMISAWA@"
CreditsText_Kawamoto:
	db -7, "HIROSHI KAWAMOTO@"
CreditsText_Kakei:
	db -6, "AKIYOSHI KAKEI@"
CreditsText_Tsuchiya:
	db -7, "KAZUKI TSUCHIYA@"
CreditsText_Nakamura:
	db -6, "TAKEO NAKAMURA@"
CreditsText_Yuda:
	db -6, "MASAMITSU YUDA@"
CreditsText_Pokemon:
	db -3, "#MON@"
CreditsText_Director:
	db -3, "DIRECTOR@"
CreditsText_Programmers:
	db -5, "PROGRAMMERS@"
CreditsText_CharacterDesign:
	db -7, "CHARACTER DESIGN@"
CreditsText_Music:
	db -2, "MUSIC@"
CreditsText_SoundEffects:
	db -6, "SOUND EFFECTS@"
CreditsText_GameDesign:
	db -5, "GAME DESIGN@"
CreditsText_MonsterDesign:
	db -6, "MONSTER DESIGN@"
CreditsText_GameScenario:
	db -6, "GAME SCENARIO@"
CreditsText_ParametricDesign:
	db -8, "PARAMETRIC DESIGN@"
CreditsText_MapDesign:
	db -4, "MAP DESIGN@"
CreditsText_Testing:
	db -7, "PRODUCT TESTING@"
CreditsText_SpecialThanks:
	db -6, "SPECIAL THANKS@"
CreditsText_Producers:
	db -4, "PRODUCERS@"
CreditsText_Producer:
	db -3, "PRODUCER@"
CreditsText_ExecutiveProducer:
	db -8, "EXECUTIVE PRODUCER@"
CreditsText_Tamada:
	db -6, "SOUSUKE TAMADA@"
CreditsText_Oota2:
	db -5, "SATOSHI OOTA@"
CreditsText_Yoshikawa:
	db -6, "RENA YOSHIKAWA@"
CreditsText_Oota23:
	db -6, "TOMOMICHI OOTA@"
CreditsText_Matsumita:
	db -9, "TOSHINOBU MATSUMIYA@"
CreditsText_Seya:
	db -6, "NOBUHIRO SEYA@"
CreditsText_Yoshida:
	db -7, "HIRONOBU YOSHIDA@"
CreditsText_Sekine:
	db -7, "KAZUHITO SEKINE@"
CreditsText_Shimamura:
	db -8, "KAZUSHI SHIMAMURA@"
CreditsText_Shimoyamada:
	db -9, "TERUYUKI SHIMOYAMADA@"
CreditsText_SuperMarioClub:
	db -9, "NCL SUPER MARIO CLUB@"
CreditsText_Izushi:
	db -7, "TAKEHIRO IZUSHI@"
CreditsText_Nomura:
	db -5, "FUZIKO NOMURA@"
CreditsText_Harada:
	db -6, "TAKAHIRO HARADA@"
CreditsText_Yamagami:
	db -7, "HITOSHI YAMAGAMI@"
CreditsText_Nishimura:
	db -8, "KENTAROU NISHIMURA@"
CreditsText_Saeki:
	db -5, "NAOKO SAEKI@"
CreditsText_Fuzii:
	db -5, "TAKAYA FUZII@"
CreditsText_Shogakukan:
	db -4, "SHOGAKUKAN"
	next   "PRODUCTION@"
CreditsText_Ootani:
	db -5, "IKUE OOTANI@"
CreditsText_PikachuVoice:
	db -6, "PIKACHU VOICE@"

	db -3, "××××××××@"
CreditsText_USStaff:
	db -7, "US VERSION STAFF@"
CreditsText_USCoord:
	db -7, "US COORDINATION@"
CreditsText_Tilden:
	db -5, "GAIL TILDEN@"
CreditsText_Kawakami:
	db -6, "NAOKO KAWAKAMI@"
CreditsText_Nakamura2:
	db -6, "HIRO NAKAMURA@"
CreditsText_Shoemake:
	db -6, "RANDY SHOEMAKE@"
CreditsText_Osborne:
	db -5, "SARA OSBORNE@"
CreditsText_Translation:
	db -7, "TEXT TRANSLATION@"
CreditsText_Ogasawara:
	db -6, "NOB OGASAWARA@"
CreditsText_Iwata:
	db -5, "SATORU IWATA@"
CreditsText_Izushi2:
	db -7, "TAKEHIRO IZUSHI@"
CreditsText_Harada2:
	db -7, "TAKAHIRO HARADA@"
CreditsText_Murakawa:
	db -7, "TERUKI MURAKAWA@"
CreditsText_Fukui:
	db -5, "KOHTA FUKUI@"
CreditsText_SuperMarioClub2:
	db -9, "NCL SUPER MARIO CLUB@"
CreditsText_Paad:
	db -5, "PAAD TESTING@"
CreditsText_Hosokawa:
	db -8, "TAKEHIKO HOSOKAWA@"
CreditsText_Okubo:
	db -5, "KENJI OKUBO@"
CreditsText_Nakamichi:
	db -7, "KIMIKO NAKAMICHI@"
CreditsText_Yoshimura:
	db -7, "KAMON YOSHIMURA@"
CreditsText_Yamazaki:
	db -6, "SAKAE YAMAZAKI@"

; Yellow Legacy's strings that the roll shows (its staff screens left the roll in 1.0), centred by the
; rule above. v1.0 (2026-11-08): the 45 Yellow Legacy strings no CreditsOrder row named are gone, with
; their pointers and CRED_* ids: its staff screens' words, and the single artist names, which the roll
; shows in pairs (CreditsText_YLArtists*). CreditsOrder names every string by its CRED_* constant, so the
; ids that moved down change nothing on screen. Vanilla's own unused strings above (MIYAMOTO to IZUSHI2,
; and PRODUCERS) stay: what vanilla has is kept.
CreditsText_Creator:
	db -4, "CREATED BY@"
CreditsText_SpriteArtists:
	db -6, "SPRITE ARTISTS@"
CreditsText_Pret1:
	db -7, "THANK YOU TO THE@"
CreditsText_Pret2:
	db -8, "PRET TEAM FOR THE@"
CreditsText_Pret3:
	db -4, "POKEYELLOW@"
CreditsText_Pret4:
	db -5, "DISASSEMBLY@"
CreditsText_ReaderDragon:
	db -6, "READER DRAGON@"
CreditsText_GhostMissingNo:
	db -7, "GHOST-MISSINGNO@"
CreditsText_ZetaNull:
	db -4, "ZETA NULL@"
CreditsText_BlueEmerald:
	db -5, "BLUE EMERALD@"

; Pokemon Purple Yellow (1.0)
CreditsText_TheDreigon:
	db -4, "TheDreigon@"
CreditsText_WithHelpFrom:
	db -6, "WITH HELP FROM@"
CreditsText_ClaudeCode:
	db -5, "Claude Code@"
CreditsText_PyBattle:
	db -9, "BATTLE ENGINE AND AI@"
CreditsText_PyBattle2:
	db -7, "FIXES AND REWORK@"
CreditsText_PyBattle3:
	db -8, "CRITICAL HITS AND@"
CreditsText_PyBattle4:
	db -7, "CATCHING REBUILT@"
CreditsText_PyMoves:
	db -6, "EVERY MOVE AND@"
CreditsText_PyMoves2:
	db -7, "EVERY ANIMATION@"
CreditsText_PyMoves3:
	db -6, "NEW MOVES AND@"
CreditsText_PyMoves4:
	db -7, "NEW MOVE EFFECTS@"
CreditsText_PyTypes:
	db -7, "NEW TYPE SYSTEM@"
CreditsText_PyTypes2:
	db -8, "REALISTIC MATCHUPS@"
CreditsText_PyTypes3:
	db -8, "SPECIAL SPLIT INTO@"
CreditsText_PyTypes4:
	db -8, "SP.ATK AND SP.DEF@"
CreditsText_PyStats:
	db -7, "ALL BASE STATS,@"
CreditsText_PyStats2:
	db -9, "LEARNSETS, TYPINGS,@"
CreditsText_PyStats3:
	db -6, "EXP CURVES AND@"
CreditsText_PyStats4:
	db -6, "#DEX PAGES@"
CreditsText_PySprites:
	db -9, "#MON SPRITES AND@"
CreditsText_PySprites2:
	db -7, "PALETTES REVISED@"
CreditsText_PyMap:
	db -7, "TOWNS AND ROUTES@"
CreditsText_PyMap2:
	db -7, "REDESIGNED, NEW@"
CreditsText_PyMap3:
	db -9, "MAPS, WILD #MON,@"
CreditsText_PyMap4:
	db -7, "ITEMS AND MARTS@"
CreditsText_PyTrainers:
	db -8, "GYMS AND LEADERS,@"
CreditsText_PyTrainers2:
	db -8, "RIVAL AND BOSSES,@"
CreditsText_PyTrainers3:
	db -8, "EVERY TRAINER AND@"
CreditsText_PyTrainers4:
	db -5, "CANON CHECKS@"
CreditsText_PyMore:
	db -9, "THE HARD DIFFICULTY@"
CreditsText_PyMore2:
	db -6, "REWORKED, THE@"
CreditsText_PyMore3:
	db -7, "PARTNER PIKACHU,@"
CreditsText_PyMore4:
	db -9, "MUSIC AND MUCH MORE@"
CreditsText_Thanks:
	db -6, "WITH RESPECT,@"
CreditsText_Thanks2:
	db -7, "ADMIRATION, AND@"
CreditsText_Thanks3:
	db -8, "THANKS FOR ALL THE@"
CreditsText_Thanks4:
	db -5, "WORK DONE IN@"
CreditsText_YellowLegacy:
	db -6, "YELLOW LEGACY@"
CreditsText_KEP:
	db -9, "KANTO EXPANSION PAK@"
CreditsText_ExtremeYellow:
	db -6, "EXTREME YELLOW@"
CreditsText_Shin:
	db -5, "SHIN #MON@"
CreditsText_PureRGB:
	db -3, "PureRGB@"
CreditsText_Yume:
	db -5, "#MON YUME@"
CreditsText_Solus:
	db -4, "SOLUS RGB@"
CreditsText_RedPlusPlus:
	db -2, "RED++@"
CreditsText_Gold97:
	db -7, "GOLD & SILVER 97@"
CreditsText_Gold97_2:
	db -3, "REFORGED@"
CreditsText_RedStarBlueStar:
	db -6, "RED★ AND BLUE★@"
CreditsText_Originals:
	db -8, "AND THE ORIGINALS@"
CreditsText_RGB:
	db -6, "RED GREEN BLUE@"
CreditsText_Yellow:
	db -2, "YELLOW@"
CreditsText_GSC:
	db -9, "GOLD SILVER CRYSTAL@"
CreditsText_DevelopedUsing:
	db -7, "DEVELOPED USING@"
CreditsText_AsTheBase:
	db -5, "AS THE BASE@"
CreditsText_YLArtists:
	db -7, "ZUPERZACH  ISONA@"
CreditsText_YLArtists2:
	db -8, "KARLOS  ALAKADOOF@"
CreditsText_YLArtists3:
	db -9, "MADAME FROG  CHAMBER@"
CreditsText_YLArtists4:
	db -6, "SOLOO993  LAKE@"
CreditsText_YLArtists5:
	db -7, "NESLUG  TOM WANG@"

; vanilla's opener of Game Freak's credits (pret pokeyellow), in front of them again
CreditsText_YellowVersion:
	db -6, "YELLOW VERSION"
	next   "    STAFF@"
