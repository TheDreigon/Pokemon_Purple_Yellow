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
	pic_money EngineerPic,     5000
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
	pic_money PKMNTrainerMPic, 9900
	pic_money PKMNTrainerMPic, 9900
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
	pic_money PKMNTrainerFPic, 9900
	pic_money JaninePic, 	   9900 ; boss-classed leader (post-Koga) — pays 99/lvl like every other boss (was 3500=35/lvl, a Cooltrainer-tier oversight)
	pic_money JoyPic, 	   	   9900
	pic_money JennyPic, 	   9900
	pic_money JessieJamesPic,  6600 ; Jessie & James — 66/lvl (comedic recurring duo, above a regular Rocket; pic in gfx/trainers/jessiejames.pic)
	pic_money PKMNTrainerMPic, 9900 ; Forte (Red avatar — reuses the male-protagonist trainer pic)
	assert_table_length NUM_TRAINERS
