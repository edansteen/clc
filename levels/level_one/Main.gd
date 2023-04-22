extends Node

var time = 0.0 #in s
var seconds = 0
var minutes = 0
var spawner_level = 1
var victory = false

var time_till_boss = 5*60
var game_over = false

onready var clock = $Clock/ClockDisplay/TimeDisplay
onready var spawner = $MobSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner.set_active(true)
	time = 0.0
	seconds = 0
	minutes = 0
	spawner_level = 1
	spawner.set_level(spawner_level)
	$Music.play()
	
	#equip players base attack
	$Player.level_up_weapon(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		return
	seconds += delta
	if seconds >= 60:
		minutes += 1
		seconds = 0
	clock.text = str(minutes).pad_zeros(2) + ":" + str(round(seconds)).pad_zeros(2)

func boss_defeated():
	victory = true
	end_game()

func end_game():
	game_over = true
	spawner.set_active(false)
	$Music.stop()
	$GameOverScreenTimer.start(1.0)

func _on_Player_gameOver():
	end_game()

func _on_GameOverScreenTimer_timeout():
	$GameOverScreen.make_visible(victory)


func _on_SpawnerLevelUpTimer_timeout():
	#level up every 30 seconds
	spawner_level += 1
	spawner.set_level(spawner_level)
	$SpawnerLevelUpTimer.start(45)


func _on_GameTimer_timeout():
	spawner.set_level(8) #spawn the snake boss
