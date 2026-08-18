MACRO pic_money
	dw \1
	bcd3 \2
ENDM

TrainerPicAndMoneyPointers::
	table_width 5, TrainerPicAndMoneyPointers
	; pic pointer, base reward money
	; money received after battle = base money × level of last enemy mon.
	; NOTE: only the top 4 digits of this bcd3 value are read (GetTrainerInformation
	; copies 2 of 3 bytes), so the EFFECTIVE rate is value/100 per level:
	; 1500 here = 15/level, 9900 = 99/level (the cap). Scale edits accordingly.
	pic_money YoungsterPic,    1500
	pic_money BugCatcherPic,   1000
	pic_money LassPic,         1500
	pic_money SailorPic,       3000
	pic_money JrTrainerMPic,   2000
	pic_money JrTrainerFPic,   2000
	pic_money PokemaniacPic,   5000
	pic_money SuperNerdPic,    2500
	pic_money HikerPic,        3500
	pic_money BikerPic,        2000
	pic_money BurglarPic,      9000
	pic_money BlackbeltPic,    9900 ; KIYO — 99/lvl. He is a SEMI-boss in the Saffron
	                                ; dojo and a full BOSS in the Viridian Gym, but prize
	                                ; money is keyed to the CLASS, so one number covers
	                                ; both fights. Forte chose the gym leader's 99 over
	                                ; the flat semi 79 (2026-08-18). Do NOT "fix" this to
	                                ; 7900 to match the other semis.
	                                ; (was ENGINEER; reuses the blackbelt portrait until he gets his own. Class $0C sits below PROF_OAK, so the pic-bank ladder already sends it to "Trainer Pics 1", where BlackbeltPic lives.
	pic_money FisherPic,       3500
	pic_money SwimmerPic,       500
	pic_money CueBallPic,      2500
	pic_money GamblerPic,      7000
	pic_money BeautyPic,       7000
	pic_money PsychicPic,      1000
	pic_money RockerPic,       2500
	pic_money JugglerPic,      3500
	pic_money TamerPic,        4000
	pic_money BirdKeeperPic,   2500
	pic_money BlackbeltPic,    2500
	pic_money Rival1Pic,       3500
	pic_money ProfOakPic,      9900
	pic_money PKMNTrainerMPic, 7900 ; SMITH — semi-boss self-insert, 79/lvl
	pic_money PKMNTrainerMPic, 7900 ; CRAIG — semi-boss self-insert, 79/lvl
	pic_money ScientistPic,    5000
	pic_money GiovanniPic,     9900
	pic_money RocketPic,       3000
	pic_money CooltrainerMPic, 3500
	pic_money CooltrainerFPic, 3500
	pic_money BrunoPic,        9900
	pic_money BrockPic,        9900
	pic_money MistyPic,        9900
	pic_money LtSurgePic,      9900
	pic_money ErikaPic,        9900
	pic_money KogaPic,         9900
	pic_money BlainePic,       9900
	pic_money SabrinaPic,      9900
	pic_money GentlemanPic,    7000
	pic_money Rival2Pic,       6500
	pic_money Rival3Pic,       9900
	pic_money LoreleiPic,      9900
	pic_money ChannelerPic,    3000
	pic_money AgathaPic,       9900
	pic_money LancePic,        9900
	pic_money PKMNTrainerFPic, 7900 ; WEEBRA — semi-boss self-insert, 79/lvl
	pic_money JaninePic, 	   7900 ; JANINE — 79/lvl, the flat semi-boss rate (was 6600; and 3500 before that, a Cooltrainer-tier oversight)
	pic_money JoyPic, 	   	   7900 ; JOY — semi-boss (repeatable), 79/lvl
	pic_money JennyPic, 	   7900 ; JENNY — semi-boss (repeatable), 79/lvl
	pic_money JessieJamesPic,  7900 ; Jessie & James — 79/lvl, the flat semi-boss rate (comedic recurring duo; pic in gfx/trainers/jessiejames.pic)
	pic_money DreigonPic,      9900 ; Forte / DREIGON — his own portrait, grown out of the player's own front pic (gfx/trainers/dreigon.png)
	pic_money BillPic, 	   7900 ; BILL — semi-boss (repeatable), 79/lvl (was 76: the semis are flat now)
	assert_table_length NUM_TRAINERS
