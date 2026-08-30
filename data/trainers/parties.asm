TrainerDataPointers:
	table_width 2, TrainerDataPointers
	dw YoungsterData
	dw BugCatcherData
	dw LassData
	dw SailorData
	dw JrTrainerMData
	dw JrTrainerFData
	dw PokemaniacData
	dw SuperNerdData
	dw HikerData
	dw BikerData
	dw BurglarData
	dw KiyoData ; slot $0C, was EngineerData
	dw FisherData
	dw SwimmerData
	dw CueBallData
	dw GamblerData
	dw BeautyData
	dw PsychicData
	dw RockerData
	dw JugglerData
	dw TamerData
	dw BirdKeeperData
	dw BlackbeltData
	dw Rival1Data
	dw ProfOakData
	dw SmithData
	dw CraigData
	dw ScientistData
	dw GiovanniData
	dw RocketData
	dw CooltrainerMData
	dw CooltrainerFData
	dw BrunoData
	dw BrockData
	dw MistyData
	dw LtSurgeData
	dw ErikaData
	dw KogaData
	dw BlaineData
	dw SabrinaData
	dw GentlemanData
	dw Rival2Data
	dw Rival3Data
	dw LoreleiData
	dw ChannelerData
	dw AgathaData
	dw LanceData
	dw WeebraData
	dw JanineData
	dw JoyData
	dw JennyData
	dw JessieAndJamesData
	dw ForteData
	dw BillData
	assert_table_length NUM_TRAINERS

; if first byte != $FF, then
	; first byte is level (of all pokemon on this team)
	; all the next bytes are pokemon species
	; null-terminated
; if first byte == $FF, then
	; first byte is $FF (obviously)
	; every next two bytes are a level and species
	; null-terminated

Rival1Data:
; v0.7 Phase B: DEAD DATA — rival parties are now GENERATED from
; data/trainers/rival_pools.asm (see GenerateRivalParty). Kept only as a
; placeholder for the pointer table; remove in the Phase C cleanup.
; Oak's Lab
	db 5, EEVEE, 0
; Route 22
	db $FF, 9, SPEAROW, 8, EEVEE, 0
; Cerulean City
	db $FF, 18, SPEAROW, 15, RATTATA, 15, BELLSPROUT, 19, EEVEE, 0

YoungsterData:
; Route 3
	db 11, RATTATA, EKANS, 0
	db 14, SPEAROW, 0
; Mt. Moon 1F
	db 10, RATTATA, SANDSHREW, ZUBAT, 0
; Route 24
	db 14, RATTATA, EKANS, ZUBAT, 0
; Route 25
	db 16, RATTATA, SPEAROW, 0
	db 17, SLOWPOKE, 0
	db 16, EKANS, SANDSHREW, 0
; SS Anne 1F Rooms
	db 21, NIDORINO, 0
; Route 11
	db 21, EKANS, 0
	db 19, SANDSHREW, ZUBAT, 0
	db $FF, 17, RATTATA, 17, RATTATA, 20, RATICATE, 0
	db 18, NIDORAN_M, NIDORINO, 0
; Unused
	db 17, SPEAROW, RATTATA, RATTATA, SPEAROW, 0
; Route 9
	db 28, SANDSHREW, 0

BugCatcherData:
; Viridian Forest
	db 6, CATERPIE, WEEDLE, CATERPIE, 0
	db $FF, 6, ODDISH, 8, KAKUNA, 8, METAPOD, 0
	db $FF, 7, WEEDLE, 9, VENONAT, 0
; Route 3
	db $FF, 8, METAPOD, 8, KAKUNA, 11, BUTTERFREE, 0
	db 9, WEEDLE, KAKUNA, CATERPIE, METAPOD, 0
	db 9, METAPOD, PARAS, METAPOD, 0
; Mt. Moon 1F
	db 11, WEEDLE, BEEDRILL, 0
	db 11, CATERPIE, BUTTERFREE, 0
; Route 24
	db 13, BUTTERFREE, BEEDRILL, 0
; Route 6
	db 18, BUTTERFREE, BEEDRILL, 0
	db 18, VENONAT, SCYTHER, 0
; Unused
	db 18, METAPOD, CATERPIE, VENONAT, 0
; Route 9
	db 23, VENOMOTH, PINSIR, 0
	db 21, BUTTERFREE, BEEDRILL, SCYTHER, 0
; Viridian Forest
	db $FF, 6, CATERPIE, 8, METAPOD, 0
; Victory Road - Talos
	db 53, SCYTHER, KABUTOPS, STARMIE, BLASTOISE, 0

LassData:
; Route 3
	db 10, KRABBY, ODDISH, 0
	db 10, NIDORAN_F, NIDORAN_M, 0
	db 14, JIGGLYPUFF, 0
; Route 4
	db 35, PARASECT, VILEPLUME, 0
; Mt. Moon 1F
	db 11, ODDISH, BELLSPROUT, 0
	db 14, CLEFAIRY, 0
; Route 24
	db 16, PIDGEY, NIDORAN_F, 0
	db 15, JIGGLYPUFF, ODDISH, 0
; Route 25
	db 16, JIGGLYPUFF, 0
	db 16, ODDISH, PIDGEY, ODDISH, 0
; SS Anne 1F Rooms
	db 18, PIDGEY, NIDORINA, 0
; SS Anne 2F Rooms
	db 21, JIGGLYPUFF, 0
; Route 8
	db 26, WEEPINBELL, NIDORINA, 0
	db 27, MEOWTH, LICKITUNG, NIDORINA, 0
	db 25, PIDGEOTTO, RATICATE, MEOWTH, NIDORINO, 0
	db 26, CLEFAIRY, CLEFABLE, 0
; Celadon Gym
	db 28, GLOOM, WEEPINBELL, 0
	db 29, PARASECT, EXEGGUTOR, 0
; Viridian Forest
	db 6, NIDORAN_F, NIDORAN_M, 0

BrockData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Pewter Gym
	db $FF, 12, GEODUDE, 14, ONIX, 0
; 2: Rematch
	db $FF, 63, KABUTOPS, 64, GOLBAT, 64, RHYDON, 65, ONIX, 65, GOLEM, 0

JrTrainerMData:
; Pewter Gym
	db 9, DIGLETT, SANDSHREW, 0
; Route 24/Route 25
	db 15, DIGLETT, PSYDUCK, 0
; Route 24
	db 18, MANKEY, 0
; Unused
	db 20, SQUIRTLE, 0
; Route 6
	db $FF, 17, MANKEY, 20, RATICATE, 0 ; mini-ace Raticate (Forte)
; Unused
	db 18, DIGLETT, DIGLETT, SANDSHREW, 0
	db 21, GROWLITHE, CHARMANDER, 0
; Route 9
	db 21, RATICATE, DIGLETT, BELLSPROUT, SANDSHREW, 0
; Route 12
	db 29, NIDORINA, NIDORINO, 0
; Route 6
	db 16, HORSEA, BELLSPROUT, 0

JrTrainerFData:
; Cerulean Gym
	db 19, SEEL, 0
; Unused
	db 16, ODDISH, BELLSPROUT, 0
; Route 6
	db 16, PIDGEY, SPEAROW, PIDGEY, 0
; Unused
	db 22, BULBASAUR, 0
; Route 9
	db 21, ODDISH, BELLSPROUT, TANGELA, PIDGEOTTO, 0
	db 24, MEOWTH, 0
; Route 10
	db 25, CLEFAIRY, WIGGLYTUFF, 0
	db 26, PIDGEOTTO, FARFETCHD, 0
; Rock Tunnel B1F
	db 23, JIGGLYPUFF, PIDGEOTTO, MEOWTH, 0
	db 24, GLOOM, IVYSAUR, 0
; Celadon Gym
	db 29, BULBASAUR, IVYSAUR, 0
; Route 13
	db 28, POLIWHIRL, CLEFAIRY, WEEPINBELL, POLIWHIRL, MEOWTH, 0
	db 29, POLIWHIRL, SEAKING, 0
	db 28, TANGELA, PERSIAN, 0
	db 29, POLIWHIRL, SEADRA, 0
; Route 20
	db 41, SEAKING, SEAKING, 0
; Rock Tunnel 1F
	db 24, WEEPINBELL, CLEFAIRY, 0
	db 23, MEOWTH, WARTORTLE, FEAROW, 0
	db 23, PIDGEOTTO, RATICATE, NIDORINA, WEEPINBELL, 0
; Route 15
	db 34, PSYDUCK, PERSIAN, GOLDUCK, 0
	db 36, WEEPINBELL, POLIWRATH, 0
	db 38, CLEFABLE, 0
	db 35, TANGELA, PONYTA, SANDSLASH, 0
; Route 20
	db 40, TENTACRUEL, SEADRA, DEWGONG, 0
; Route 6
	db 19, CUBONE, 0

RocketData:
; Mt. Moon B2F  (party order = trainer-index order: 1=ROCKET3, 2=ROCKET1, 3=ROCKET2)
	db 15, CUBONE, 0 ; ROCKET3 — stolen Cubone (Lavender foreshadow)
	db 12, RATTATA, ZUBAT, 0 ; ROCKET1
	db 12, EKANS, ZUBAT, 0 ; ROCKET2
; Unused
	db 16, RATICATE, 0
; Cerulean City
	db 18, MACHOP, DROWZEE, 0
; Route 24
	db 16, KOFFING, VOLTORB, EXEGGCUTE, 0
; Game Corner
	db 23, RATICATE, GOLBAT, 0
; Rocket Hideout B1F
	db 25, DROWZEE, MACHOP, 0
	db 26, EKANS, RATICATE, 0
	db 25, GRIMER, KOFFING, CUBONE, 0
	db 26, DROWZEE, SANDSHREW, RATICATE, 0
	db 25, GRIMER, ARBOK, 0
; Rocket Hideout B2F
	db 24, GOLBAT, KOFFING, GRIMER, RATICATE, 0
; Rocket Hideout B3F
	db 26, EKANS, RATICATE, DROWZEE, 0
	db 27, MACHOKE, ARBOK, 0
; Unused
	db 23, SANDSHREW, EKANS, SANDSLASH, 0
	db 23, EKANS, SANDSHREW, ARBOK, 0
; Rocket Hideout B4F
	db 26, KOFFING, GOLBAT, 0
; Unused
	db 25, ZUBAT, ZUBAT, GOLBAT, 0
	db 26, KOFFING, DROWZEE, 0
	db 23, ZUBAT, RATICATE, RATICATE, ZUBAT, 0
	db 26, DROWZEE, KOFFING, 0
; Silph Co. 2F
	db 39, MAROWAK, GOLBAT, 0
	db 35, GOLBAT, RATICATE, GOLBAT, PINSIR, 0
; Silph Co. 3F
	db 38, RATICATE, HYPNO, MUK, 0
; Silph Co. 4F
	db 39, MACHOKE, HYPNO, 0
	db 38, ARBOK, VILEPLUME, MAROWAK, 0
; Silph Co. 5F
	db 40, TAUROS, 0
	db 41, HYPNO, 0
; Silph Co. 6F
	db 39, MUK, PRIMEAPE, 0
	db 38, GOLBAT, VILEPLUME, RATICATE, 0
; Silph Co. 7F
	db 37, RATICATE, ARBOK, WEEZING, GOLBAT, 0
	db 39, MAROWAK, MAGMAR, 0
	db 39, SANDSLASH, VILEPLUME, 0
; Silph Co. 8F
	db 37, RATICATE, TENTACRUEL, GOLBAT, RATICATE, 0
	db 39, VICTREEBEL, GOLBAT, WEEZING , 0
; Silph Co. 9F
	db 38, HYPNO, MUK, MACHOKE, 0
	db 38, GOLBAT, HYPNO, RHYHORN, 0
; Silph Co. 10F
	db 43, MACHOKE, 0
; Silph Co. 11F
	db 38, RATICATE, MUK, GOLBAT, MAROWAK, ARBOK, 0
; Unused
	db 32, CUBONE, DROWZEE, MAROWAK, 0
; Jessie & James — MOVED to JessieAndJamesData (boss class, parties $01-$04).
; These 4 parties (Rocket party $2a-$2d) are now orphans referenced by no
; script. Kept here so the SUBSEQUENT party indices ($2e-$31, the unused
; tail) don't shift. Safe to remove if those tail entries also go.
	db $FF, 15, EKANS, 16, MEOWTH, 15, KOFFING, 0 ; Mt. Moon B2F (orphan)
	db $FF, 28, KOFFING, 29, MEOWTH, 28, ARBOK, 0 ; Rocket Hideout B4F (orphan)
	db $FF, 33, MEOWTH, 31, ARBOK, 30, LICKITUNG, 31, WEEZING, 0 ; Pokémon Tower 7F (orphan)
	db $FF, 42, WEEZING, 41, LICKITUNG, 42, ARBOK, 44, MEOWTH, 43, VICTREEBEL, 0 ; Silph Co. 11F (orphan)
; Unused
	db 16, KOFFING, 0
	db 27, KOFFING, 0
	db 29, WEEZING, 0
	db 33, WEEZING, 0

JessieAndJamesData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Mt. Moon B2F
	db $FF, 15, EKANS, 15, KOFFING, 16, MEOWTH, 0
; 2: Rocket Hideout (first encounter)
	db $FF, 28, ARBOK, 28, KOFFING, 29, MEOWTH, 0
; 3: Pokemon Tower 7F (second encounter)
	db $FF, 31, LICKITUNG, 32, ARBOK, 32, WEEZING, 33, MEOWTH, 0
; 4: Silph Co. 11F
	db $FF, 41, LICKITUNG, 42, VICTREEBEL, 42, GYARADOS, 43, ARBOK, 43, WEEZING, 44, MEOWTH, 0

SuperNerdData:
; Mt. Moon 1F
	db 11, MAGNEMITE, VOLTORB, 0
; Mt. Moon B2F
	db 12, GRIMER, KABUTO, OMANYTE, 0
; Route 8
	db 26, VOLTORB, KOFFING, VOLTORB, MAGNEMITE, 0
	db 27, GRIMER, PORYGON, GRIMER, 0
	db 28, KOFFING, 0
; Unused
	db 22, KOFFING, MAGNEMITE, KOFFING, 0
	db 20, MAGNEMITE, MAGNEMITE, KOFFING, MAGNEMITE, 0
	db 24, MAGNEMITE, VOLTORB, 0
; Cinnabar Gym (parties 9-12 — FOUR of them; the 12th has no comment of its
; own and hid below RAPIDASH, which is how the 2026-08-17 insertion landed in
; the middle and briefly gave the gym's 4th super nerd a L21 MAGNEMITE)
	db 49, VULPIX, NINETALES, 0
	db 53, PONYTA, CHARMELEON, VULPIX, GROWLITHE, 0
	db 52, RAPIDASH, 0
	db 50, CHARMELEON, FLAREON, 0
; Route 11 — the two ex-ENGINEERs (13, 14); that class slot became KIYO, and
; these two already wore the SUPER_NERD overworld sprite. Same teams.
	db 21, MAGNEMITE, 0
	db 18, MAGNEMITE, MACHOP, MAGNEMITE, 0

HikerData:
; Mt. Moon 1F
	db 10, GEODUDE, GEODUDE, ONIX, 0
; Route 25
	db 16, MACHOP, GEODUDE, 0
	db 15, GEODUDE, ZUBAT, MACHOP, GEODUDE, 0
	db 18, ONIX, 0
; Route 9
	db 24, GEODUDE, ONIX, 0
	db 22, GEODUDE, MACHOP, GEODUDE, 0
; Route 10
	db 25, ZUBAT, ONIX, GOLBAT, 0
	db 27, RHYHORN, TAUROS, 0 ; ride-pokemon duo (Forte)
; Rock Tunnel B1F
	db $FF, 24, GEODUDE, 24, GEODUDE, 26, GRAVELER, 0
	db 26, GRAVELER, 0
; Route 9/Rock Tunnel B1F
	db 23, MACHOP, ONIX, 0
; Rock Tunnel 1F
	db $FF, 24, MACHOP, 26, MACHOKE, 0
	db 24, ONIX, SANDSHREW, ONIX, 0
	db $FF, 24, GEODUDE, 26, GRAVELER, 0
; Victory Road - Sable
	db 52, AERODACTYL, PARASECT, JOLTEON, ARCANINE, 0

MistyData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Cerulean Gym
	db $FF, 19, PSYDUCK, 20, GOLDEEN, 21, STARMIE, 0
; 2: Rematch
	db $FF, 63, BLASTOISE, 64, GYARADOS, 64, OMASTAR, 65, STARMIE, 65, GOLDUCK, 0

SailorData:
; SS Anne Stern
	db 19, MACHOP, KRABBY, 0
	db 18, MACHOP, TENTACOOL, 0
; SS Anne B1F Rooms
	db 21, SHELLDER, 0
	db 18, HORSEA, SHELLDER, TENTACOOL, 0
	db 19, KRABBY, STARYU, 0
	db 18, HORSEA, STARYU, KRABBY, 0
	db 20, MACHOP, 0
; Vermilion Gym
	db 24, MAGNEMITE, 0

GentlemanData:
; SS Anne 1F Rooms
	db 18, GROWLITHE, GROWLITHE, 0
	db 19, NIDORAN_M, NIDORAN_F, 0
; SS Anne 2F Rooms/Vermilion Gym
	db 22, VOLTORB, MAGNEMITE, 0
; Unused
	db 48, PRIMEAPE, 0
; SS Anne 2F Rooms
	db 18, GROWLITHE, PONYTA, 0

FisherData:
; SS Anne 2F Rooms
	db 18, GOLDEEN, TENTACOOL, GOLDEEN, 0
; SS Anne B1F Rooms
	db 18, TENTACOOL, STARYU, SHELLDER, 0
; Route 12
	db 25, GOLDEEN, POLIWAG, GOLDEEN, 0
	db 26, TENTACOOL, GOLDEEN, 0
	db 28, SEAKING, 0
	db 24, POLIWAG, SHELLDER, DRATINI, HORSEA, 0
; Route 21
	db 40, SEAKING, GOLDEEN, SEAKING, SEAKING, 0
	db 41, SHELLDER, CLOYSTER, 0
	db $FF, 30, MAGIKARP, 38, GYARADOS, 38, GYARADOS, 38, GYARADOS, 38, GYARADOS, 40, GYARADOS,  0
	db 40, SEAKING, TENTACRUEL, 0
; Route 12
	db $FF, 27, MAGIKARP, 27, MAGIKARP, 32, GYARADOS,  0

Rival2Data:
; v0.7 Phase B: DEAD DATA — rival parties are now GENERATED from
; data/trainers/rival_pools.asm (see GenerateRivalParty). Kept only as a
; placeholder for the pointer table; remove in the Phase C cleanup.
; SS Anne 2F
	db $FF, 20, RATICATE , 22, WEEPINBELL, 21, SANDSHREW, 24, EEVEE, 0
; Pokémon Tower 2F
	db $FF, 34, FEAROW, 32, SHELLDER, 32, GROWLITHE, 33, KADABRA, 35, JOLTEON, 0
	db $FF, 34, FEAROW, 32, MAGNEMITE, 33, KADABRA, 32, SHELLDER, 35, FLAREON, 0
	db $FF, 34, FEAROW, 32, VULPIX, 33, KADABRA, 32, SCYTHER, 35, VAPOREON, 0
; Silph Co. 7F
	db $FF, 43, PARASECT, 44, GYARADOS, 43, RHYDON, 44, ALAKAZAM, 46, JOLTEON, 0
	db $FF, 43, ELECTABUZZ, 44, CLOYSTER, 43, DODRIO , 44, ALAKAZAM, 46, FLAREON, 0
	db $FF, 43, VICTREEBEL, 44, PORYGON, 43, PRIMEAPE, 44, ALAKAZAM, 46, VAPOREON, 0
; Route 22
	db $FF, 55, JOLTEON, 53, PIDGEOT, 52, EXEGGUTOR , 52, MAROWAK,  54, ARCANINE, 54, ALAKAZAM, 0
	db $FF, 54, FEAROW, 52, MAGNETON, 53, GOLDUCK, 54, ALAKAZAM, 52, MAROWAK, 55, FLAREON, 0
	db $FF, 53, PIDGEOT, 54, MACHAMP, 54, ALAKAZAM, 52, NINETALES, 52, SCYTHER, 55, VAPOREON, 0

LtSurgeData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Vermilion Gym
	db $FF, 31, ELECTRODE, 32, ELECTABUZZ, 33, MAGNETON, 34, RAICHU, 0
; 2: Rematch
	db $FF, 63, POLIWRATH, 64, ELECTRODE, 64, MAGNETON, 65, ELECTABUZZ, 65, RAICHU, 0

KiyoData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Fighting Dojo (Saffron)
	db $FF, 40, HITMONLEE, 40, HITMONCHAN, 40, MACHOKE, 0
; 2: Viridian Gym rematch (post-League)
	db $FF, 63, PRIMEAPE, 63, HITMONLEE, 64, HITMONCHAN, 64, POLIWRATH, 65, MACHAMP, 0

RockerData:
; Vermilion Gym
	db 21, VOLTORB, VOLTORB, VOLTORB, 0
; Route 12
	db 30, VOLTORB, ELECTRODE, 0

PokemaniacData:
; Route 10
	db 43, MAGMAR, JYNX, LAPRAS, 0
	db 27, KANGASKHAN, 0
; Rock Tunnel B1F
	db 23, SLOWPOKE, LICKITUNG, SLOWPOKE, 0
	db 26, CHARMELEON, CUBONE, 0
	db 25, SLOWPOKE, 0
; Victory Road 2F
	db 52, VENUSAUR, LAPRAS, LICKITUNG, 0
; Rock Tunnel 1F
	db 25, CUBONE, SLOWPOKE, 0

GamblerData:
; Route 11
	db 19, POLIWAG, HORSEA, 0
	db 19, BELLSPROUT, ODDISH, 0
	db 19, DROWZEE, ABRA, 0
	db 19, GROWLITHE, VULPIX, 0
; Route 8
	db $FF, 24, POLIWAG, 24, POLIWAG, 27, POLIWHIRL, 0
; Unused
	db 22, ONIX, GEODUDE, GEODUDE, 0
; Route 8
	db 27, GROWLITHE, VULPIX, 0

ChannelerData:
; Unused
	db 22, GASTLY, 0
	db 24, GASTLY, 0
	db 23, GASTLY, GASTLY, 0
	db 24, GASTLY, 0
; Pokémon Tower 3F
	db 26, GASTLY, 0
	db 26, VULPIX, 0
; Unused
	db 26, HAUNTER, 0
; Pokémon Tower 3F
	db 27, GASTLY, 0
; Pokémon Tower 4F
	db 27, GASTLY, VULPIX, 0
	db 28, GASTLY, DROWZEE, 0
; Unused
	db 24, GASTLY, 0
; Pokémon Tower 4F
	db 29, HAUNTER, 0
; Unused
	db 24, GASTLY, 0
; Pokémon Tower 5F
	db 30, HAUNTER, HYPNO, 0
; Unused
	db 24, GASTLY, 0
; Pokémon Tower 5F
	db 30, GASTLY, NINETALES, 0
	db 30, MR_MIME, GASTLY, 0
	db 28, VULPIX, HAUNTER, 0
; Pokémon Tower 6F
	db 32, GASTLY, DROWZEE, HAUNTER, 0
	db 35, HAUNTER, 0
	db 33, HYPNO, HAUNTER, NINETALES, 0
; Saffron Gym
	db 44, HAUNTER, NINETALES, 0
	db 45, HYPNO, 0
	db 43, HYPNO, HAUNTER, KADABRA, 0

BikerData:
; Route 13
	db $FF, 29, SHELLDER, 31, WEEZING, 29, CLOYSTER, 0
; Route 14
	db 30, SANDSLASH, MACHOKE, 0
; Route 15
	db 34, SANDSLASH, KOFFING, SANDSLASH, GRIMER, 0
	db $FF, 34, KOFFING, 34, GRIMER, 36, WEEZING, 0
; Route 16
	db 29, GRIMER, BEEDRILL, 0
	db 31, WEEZING, 0
	db 28, GRIMER, CHARMELEON, RHYHORN, GRIMER, 0
; Route 17
	db 33, WEEZING, KOFFING, WEEZING, 0
	db 35, MUK, 0
	db 33, ELECTRODE, MAGNETON, 0
	db 32, WEEZING, MUK, 0
	db 30, SANDSLASH, KRABBY, KOFFING, KINGLER, 0
; Route 14
	db 31, BEEDRILL, WEEZING, BEEDRILL, 0
	db 32, HITMONCHAN, GRIMER, KOFFING, 0
	db 32, HITMONLEE, MUK, 0

BurglarData:
; Unused
	db 29, GROWLITHE, VULPIX, 0
	db 33, GROWLITHE, 0
	db 28, VULPIX, CHARMANDER, PONYTA, 0
; Cinnabar Gym
	db 48, FLAREON, NINETALES, 0
	db 51, RAPIDASH, 0
	db 54, VULPIX, GROWLITHE, 0
; Mansion 2F
	db 44, PRIMEAPE, MAGMAR, 0
; Mansion 3F
	db 43, NINETALES, 0
; Mansion B1F
	db 44, MACHOKE, RAPIDASH, 0
; Victory Road - Disq
	db 53, FLAREON, TENTACRUEL, NINETALES, DEWGONG, 0

BeautyData:
; Celadon Gym
	db 29, TANGELA, WEEPINBELL, EXEGGCUTE, 0
	db 30, TANGELA, IVYSAUR, 0
	db 32, VICTREEBEL, 0
; Route 13
	db 28, VULPIX, NINETALES, GLOOM, 0
	db 30, CLEFAIRY, PERSIAN, 0
; Route 20
	db 45, SEAKING, 0
	db 40, CLOYSTER, KINGLER, CLOYSTER, 0
	db 41, POLIWHIRL, SEAKING, 0
; Route 15
	db 35, GOLDUCK, WIGGLYTUFF, 0
	db 35, IVYSAUR, TANGELA, 0
; Unused
	db 33, WEEPINBELL, BELLSPROUT, WEEPINBELL, 0
; Route 19
	db 43, GOLDUCK, DEWGONG, SEAKING, 0
	db 46, LAPRAS, 0
	db 43, DRAGONAIR, GYARADOS, SEADRA, 0
; Route 20
	db 43, BLASTOISE, DEWGONG, SLOWBRO, 0
; Victory Road - ReaderDragon
	db 53, RAICHU, HYPNO, PERSIAN, TAUROS, 0

ErikaData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Celadon Gym (4th)
	db $FF, 34, TANGELA, 35, VICTREEBEL, 37, VILEPLUME, 38, VENUSAUR, 0
; 2: Rematch
	db $FF, 63, EXEGGUTOR, 64, TANGELA, 64, VICTREEBEL, 65, VILEPLUME, 65, VENUSAUR, 0

GiovanniData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Rocket Hideout B4F
	db $FF, 33, BEEDRILL, 34, RHYHORN, 34, DUGTRIO, 35, PERSIAN, 0
; 2: Silph Co. 11F
	db $FF, 43, KINGLER, 43, MACHAMP, 44, NIDOQUEEN, 45, NIDOKING, 45, PERSIAN, 0
; 3: Viridian Gym
	db $FF, 53, GOLEM, 53, MACHAMP, 54, RHYDON, 54, CLOYSTER, 55, PERSIAN, 55, NIDOKING, 0

JugglerData:
; Silph Co. 5F
	db 37, KADABRA, MR_MIME, 0
; Victory Road 2F - Obelisk
	db 51, POLIWRATH, RHYDON, FLAREON, JOLTEON, 0
; Fuchsia Gym
	db 35, BEEDRILL, NIDOKING, GOLBAT, HAUNTER, 0
	db 37, TENTACRUEL, MUK, 0
; Victory Road 2F - Alakadoof
	db 53, OMASTAR, ALAKAZAM, RAICHU, MR_MIME, 0
; Unused
	db 33, HYPNO, 0
; Fuchsia Gym
	db 40, HYPNO, 0
	db 36, WEEZING, HYPNO, 0

TamerData:
; Fuchsia Gym
	db 36, SCYTHER, ARBOK, 0
	db 36, ARBOK, NIDOQUEEN, 0
; Viridian Gym
	db 55, RHYDON, 0
	db 53, ARBOK, TAUROS, 0
; Victory Road 2F - Regi
	db 53, TANGELA, SANDSLASH, LICKITUNG, ARBOK, 0
; Unused
	db 42, RHYHORN, PRIMEAPE, ARBOK, TAUROS, 0

KogaData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Fuchsia Gym (5th)
	db $FF, 41, VENOMOTH, 42, WEEZING, 43, MUK, 44, GOLBAT, 45, ARBOK, 0
; 2: Rematch
	db $FF, 63, TENTACRUEL, 64, MUK, 64, WEEZING, 65, GOLBAT, 65, ARBOK, 0

JanineData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Fuchsia Gym (post-Koga)
	db $FF, 39, WEEZING, 39, MUK, 40, GOLBAT, 41, VENOMOTH, 41, BEEDRILL, 0

BirdKeeperData:
; Route 13
	db 32, FEAROW, PIDGEOTTO, 0
	db 28, SPEAROW, DODUO, PIDGEY, SPEAROW, SPEAROW, 0
	db 30, PIDGEOTTO, FEAROW, PIDGEOTTO, FEAROW, 0
; Route 14
	db 33, FARFETCHD, 0
	db 33, DODRIO, FEAROW, 0
; Route 15
	db 35, PIDGEOTTO, FARFETCHD, DODRIO, PIDGEOTTO, 0
	db 36, DODRIO, PIDGEOT, 0
; Route 18
	db 34, PIDGEOTTO, FEAROW, 0
	db 36, DODRIO, 0
	db 32, FARFETCHD, DODUO, FEAROW,  0
; Route 20
	db 41, FEAROW, FEAROW, PIDGEOT, 0
; Unused
	db 39, PIDGEOTTO, PIDGEOTTO, PIDGEY, PIDGEOTTO, 0
	db 42, FARFETCHD, FEAROW, 0
; Route 14
	db 33, PIDGEY, DODUO, PIDGEOTTO, 0
	db 31, FARFETCHD, SPEAROW, PIDGEY, FEAROW, 0
	db 34, FEAROW, PIDGEOTTO,  0
	db 32, PIDGEOTTO, DODUO, FEAROW, 0

SwimmerData:
; Cerulean Gym
	db 16, HORSEA, SHELLDER, 0
; Route 19
	db 43, TENTACRUEL, CLOYSTER, 0
	db 40, SEAKING, SEADRA, STARMIE, 0
	db 42, POLIWRATH, SEADRA, 0
	db 41, SEADRA, TENTACRUEL, GYARADOS, 0
	db 41, SEAKING, SLOWBRO, GOLDUCK, 0
	db 45, SEADRA, 0
	db 40, TENTACRUEL, TENTACRUEL, STARMIE, SEADRA, TENTACRUEL, 0
; Route 20
	db 42, KINGLER, CLOYSTER, 0
	db 45, GYARADOS, 0
	db 42, SEADRA, GYARADOS, SEADRA, 0
; Route 21
	db 43, SEADRA, TENTACRUEL, 0
	db 47, STARMIE, 0
	db 44, TENTACRUEL, BLASTOISE, 0
	db 44, POLIWHIRL, KINGLER, SEADRA, 0

CueBallData:
; Route 16
	db 28, MACHOP, WIGGLYTUFF, MACHOP, 0
	db 29, MANKEY, MACHOP, 0
	db 31, MACHOKE, 0
; Route 17
	db 31, PRIMEAPE, WIGGLYTUFF, 0
	db 32, MACHOKE, CLEFABLE, 0
	db 34, MACHOKE, 0
	db 30, MANKEY, PRIMEAPE, CLEFABLE, MACHOKE,  0
	db 32, PRIMEAPE, MACHOKE, 0
; Route 21
	db 42, CLOYSTER, RHYDON, TENTACRUEL, 0

BlackbeltData:
; Fighting Dojo — Forte's 2026-08-18 redesign: four two-mon schools on a
; 32->38 ladder under KIYO's L40 trio. Party 1 is DEAD data (the master
; fights as KIYO 1 since a6dcf153), kept in place because party ids are
; positional — never renumber.
	db 40, HITMONLEE, HITMONCHAN, 0     ; 1: dead, position-load-bearing
	db 38, GRAVELER, MACHOKE, 0         ; 2: (3,4) the senior — new master post-League
	db 34, POLIWHIRL, PRIMEAPE, 0       ; 3: (3,6)
	db 36, PINSIR, MACHOKE, 0           ; 4: (6,5)
	db 32, MACHOP, MANKEY, 0            ; 5: (6,7) the junior
; Viridian Gym
	db 52, POLIWRATH, GRAVELER, 0
	db 52, MACHAMP, HITMONLEE, 0
	db 52, PRIMEAPE, HITMONCHAN, 0
; Victory Road 2F - Brice
	db 52, POLIWRATH, DODRIO, MACHAMP, PINSIR, 0
; Post-League one-shot dojo rebattles (talk-scripted, scripts/FightingDojo.asm):
; each student's own team, evolved — party N returns as party N+8, on a
; 52->58 ladder under KIYO's Viridian 63-65.
	db 58, FARFETCHD, GOLEM, MACHAMP, 0 ; 10: (3,4) the promoted master
	db 54, POLIWRATH, PRIMEAPE, 0       ; 11: (3,6)
	db 56, PINSIR, MACHAMP, 0           ; 12: (6,5)
	db 52, MACHOKE, PRIMEAPE, 0         ; 13: (6,7)

PsychicData:
; Saffron Gym
	db 42, KADABRA, SLOWBRO, HYPNO, KADABRA, 0
	db 43, MR_MIME, KADABRA, 0
	db 41, VENOMOTH, JYNX, SLOWBRO, 0
	db 45, STARMIE, 0

SabrinaData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Saffron Gym (6th)
	db $FF, 41, KADABRA, 43, HYPNO, 45, VENOMOTH, 47, MR_MIME, 49, ALAKAZAM, 0
; 2: Rematch
	db $FF, 63, HYPNO, 64, MR_MIME, 64, VENOMOTH, 65, ALAKAZAM, 65, GENGAR, 0

ScientistData:
; Unused
	db 34, KOFFING, VOLTORB, 0
; Silph Co. 2F
	db 37, MUK, WEEZING, PORYGON, WEEZING, 0
	db 38, MAGNETON, ELECTRODE, MAGNETON, 0
; Silph Co. 3F/Mansion 1F
	db 39, ELECTRODE, WEEZING, 0
; Silph Co. 4F
	db 41, ELECTABUZZ, 0
; Silph Co. 5F
	db 36, MAGNETON, PORYGON, WEEZING, MAGNEMITE, 0
; Silph Co. 6F
	db 35, VOLTORB, STARYU, ELECTRODE, MAGNETON, STARMIE, 0
; Silph Co. 7F
	db 39, ELECTRODE, MUK, 0
; Silph Co. 8F — prototype PORYGON ace (v0.7: was solo L43 PORYGON)
	db $FF, 40, MAGNETON, 42, ELECTRODE, 45, PORYGON, 0
; Silph Co. 9F
	db 40, MUK, KABUTOPS, 0
; Silph Co. 10F
	db 40, WEEZING, OMASTAR, 0
; Mansion 3F
	db 45, MAGNETON, DITTO, MUK, 0
; Mansion B1F
	db 46, PORYGON, ELECTRODE, 0

BlaineData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Cinnabar Gym
	db $FF, 49, NINETALES, 49, RAPIDASH, 49, ARCANINE, 51, RHYDON, 52, MAGMAR, 0
; 2: Rematch
	db $FF, 63, NINETALES, 64, CHARIZARD, 64, ARCANINE, 65, RHYDON, 65, MAGMAR, 0

CooltrainerMData:
; Viridian Gym
	db 52, NIDOQUEEN, NIDOKING, 0
; Victory Road 3F - Karlos, Tiberius
	db 52, CHARIZARD, MAGNETON, TENTACRUEL, RHYDON, 0
	db 53, NIDOKING, CHARIZARD, VILEPLUME, SLOWBRO, 0
; Unused
	db 45, KINGLER, STARMIE, 0
; Victory Road 1F - Aero
	db 53, ELECTABUZZ, SNORLAX, SLOWBRO, PORYGON, 0
; Unused
	db 44, IVYSAUR, WARTORTLE, CHARMELEON, 0
	db 49, NIDOKING, 0
	db 44, KINGLER, CLOYSTER, 0
; Viridian Gym
	db 53, SANDSLASH, MAROWAK, 0
	db 51, GOLEM, ELECTRODE, VICTREEBEL, 0
; Viridian Forest toll gate (2026-08-30) - party 11, appended
	db 10, SCYTHER, PINSIR, 0

CooltrainerFData:
; Celadon Gym
	db 29, WEEPINBELL, GLOOM, IVYSAUR, 0
; Victory Road 3F -  Soul, Zach
	db 53, DRAGONAIR, GENGAR, TAUROS, NIDOQUEEN, 0
	db $FF, 54, WIGGLYTUFF, 54, CLEFABLE, 54, CHANSEY, 57, EEVEE, 0
; Unused
	db 46, VILEPLUME, BUTTERFREE, 0
; Victory Road 1F - Isona
	db 53, SEADRA, DRAGONAIR, VENUSAUR, HYPNO, 0
; Unused
	db 45, IVYSAUR, VENUSAUR, 0
	db 45, NIDORINA, NIDOQUEEN, 0
	db 43, PERSIAN, NINETALES, RAICHU, 0

LoreleiData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: E4
	db $FF, 56, SLOWBRO, 56, JYNX, 57, DEWGONG, 57, CLOYSTER, 58, LAPRAS, 0
; 2: Rematch
	db $FF, 71, SLOWBRO, 71, JYNX, 72, DEWGONG, 72, CLOYSTER, 73, LAPRAS, 0

BrunoData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: E4
	db $FF, 57, ONIX, 57, NIDOKING, 58, HITMONCHAN, 58, HITMONLEE, 59, MACHAMP, 0
; 2: Rematch
	db $FF, 72, ONIX, 72, NIDOKING, 73, HITMONCHAN, 73, HITMONLEE, 74, MACHAMP, 0

AgathaData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: E4
	db $FF, 58, MAROWAK, 58, PARASECT, 59, GOLBAT, 59, ARBOK, 60, GENGAR, 0
; 2: Rematch
	db $FF, 73, MAROWAK, 73, PARASECT, 74, GOLBAT, 74, ARBOK, 75, GENGAR, 0

LanceData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: E4
	db $FF, 60, CHARIZARD, 60, SEADRA, 61, GYARADOS, 61, AERODACTYL, 62, DRAGONITE, 62, DRAGONITE, 0
; 2: Rematch — Main sets +15 levels
	db $FF, 75, CHARIZARD, 75, SEADRA, 76, GYARADOS, 76, AERODACTYL, 77, DRAGONITE, 77, DRAGONITE, 0

Rival3Data:
; v0.7 Phase B: DEAD DATA — rival parties are now GENERATED from
; data/trainers/rival_pools.asm (see GenerateRivalParty). Kept only as a
; placeholder for the pointer table; remove in the Phase C cleanup. 
; Champion's Room
	db $FF, 63, ALAKAZAM, 60, RHYDON, 61, GYARADOS, 63, ARCANINE, 62, EXEGGUTOR, 65, JOLTEON, 0
	db $FF, 62, MAGNETON, 61, DODRIO, 63, ALAKAZAM, 60, SANDSLASH, 62, CLOYSTER, 65, FLAREON, 0
	db $FF, 60, MACHAMP, 61, PIDGEOT, 62, NINETALES, 62, VICTREEBEL, 63, ALAKAZAM, 65, VAPOREON, 0
; Rematch
	db $FF, 77, ALAKAZAM, 76, MACHAMP, 75, GYARADOS, 74, PIDGEOT, 75, EXEGGUTOR, 77, ARCANINE, 0

ProfOakData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Hall of Fame
	db $FF, 70, DRAGONITE, 70, SNORLAX, 70, TAUROS, 75, CHARIZARD, 75, VENUSAUR, 75, BLASTOISE, 0
; 2: Rematch — Main sets +10 levels
	db $FF, 80, DRAGONITE, 80, SNORLAX, 80, TAUROS, 85, CHARIZARD, 85, VENUSAUR, 85, BLASTOISE, 0

JennyData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Vermilion City
	db $FF, 63, PARASECT, 64, BLASTOISE, 64, PIDGEOT, 65, ARCANINE, 65, GENGAR, 0

JoyData:
; v1.0 rosters — generated from Notes/Boss Movesets.md (source of truth)
; 1: Fuchsia Pokecenter
	db $FF, 53, KANGASKHAN, 54, WIGGLYTUFF, 54, CLEFABLE, 55, CHANSEY, 55, MR_MIME, 0

SmithData:
; Moltres Fight
    db 60, AERODACTYL, GENGAR, TENTACRUEL, ALAKAZAM, TAUROS, STARMIE, 0

CraigData:
; Zapdos Fight
	db 60, JOLTEON, AERODACTYL, EXEGGUTOR, SNORLAX, CLOYSTER, ARCANINE, 0

WeebraData:
; Articuno Fight
	db 60, SNORLAX, GENGAR, CHARIZARD, VAPOREON, ONIX, MACHAMP, 0

ForteData:
; "Forte / DREIGON" superboss — all L80, in Forte's send-out order (Nidoking ace/last).
; Per-mon movesets in special_moves.asm (finalized by Forte in Notes/Boss Movesets.md).
	db 80, BEEDRILL, HITMONLEE, MAGMAR, GOLEM, GYARADOS, NIDOKING, 0

BillData:
; Post-League, in his house on Route 25. Not a trainer and not pretending to be:
; the team is what he has studied rather than what he would pick to win. The
; three eeveelutions are his research, Ditto lost its own shape the way he once
; did, and Porygon - a Pokemon that is software - leads, because he is the man
; who taught the world to keep Pokemon inside a machine.
	db $FF, 70, EEVEE, 70, VAPOREON, 70, JOLTEON, 70, FLAREON, 75, DITTO, 75, PORYGON, 0
