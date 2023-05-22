extends Node

var highscore = 0
enum level {ONE, TWO, THREE}
var selectedLevel = Globals.selectedLevel

var time = 0.0 #in s
var seconds = 0
var minutes = 0
var spawner_level = 1

var mobsKilled = 0
var bossesKilled = 0

var time_till_boss = 300
var game_over = false
var victory = false #achieved by surviving 10 minutes

onready var clock = $Clock/ClockDisplay/TimeDisplay
onready var spawner = $MobSpawner

# Load level based on which is active
func _ready():
	highscore = SaveScript.game_data.highscore
	set_highscore(highscore)
	$Background.set_bg(selectedLevel)
	match (selectedLevel):
		0:
			$Music/Music1.play()
		1:
			$Music/Music2.play()
		2:
			$Music/Music3.play()
	spawner.set_active(true)
	time = 0.0
	seconds = 0
	minutes = 0
	spawner_level = 1
	spawner.set_level(spawner_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		return
	time += delta
	seconds += delta
	if round(seconds) >= 60:
		minutes += 1
		seconds = 0
	clock.text = str(minutes).pad_zeros(2) + ":" + str(round(seconds)).pad_zeros(2)
	if time > highscore:
		highscore = time
		set_highscore(highscore)
	if minutes >= 10 && minutes % 5 == 0:
		spawner.set_level(9)

func mob_killed():
	mobsKilled += 1
	
func boss_defeated():
	bossesKilled += 1
	spawner.boss_defeated()

func end_game():
	game_over = true
	spawner.set_active(false)
	for sound_player in $Music.get_children():
		sound_player.stop()
	#save data
	save_game()
	$GameOverScreenTimer.start(1.0)

func save_game():
	SaveScript.game_data.highscore = highscore
	if bossesKilled > 0:
		SaveScript.game_data.achievement1 = true
	if minutes >= 10:
		SaveScript.game_data.achievement2 = true
	SaveScript.save()

func set_highscore(t):
	$Clock/HBoxContainer/HighScore.text = str(int(t/60)).pad_zeros(2)+":"+str(round(fmod(t,60))).pad_zeros(2)

func _on_Player_gameOver():
	end_game()

func _on_GameOverScreenTimer_timeout():
	$GameOverScreen.make_visible(victory, $Clock/ClockDisplay/TimeDisplay.text)

func _on_SpawnerLevelUpTimer_timeout():
	#level up every 30 seconds
	if spawner_level < 9:
		spawner_level += 1
	spawner.set_level(spawner_level)
	$SpawnerLevelUpTimer.start(45)

func _on_GameOverScreen_quit():
	save_game()
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")


#save the game every minute
func _on_SaveTimer_timeout():
	save_game()
	$SaveTimer.start(60)
