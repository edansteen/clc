extends Node

export var time = 0.0 #in s
export var time_till_boss = 5*60
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobSpawner.set_active(true)
	time = 0.0
	$Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		return
	time += delta


func get_time():
	return time


func _on_Player_gameOver():
	game_over = true
	$MobSpawner.set_active(false)
	$Music.stop()
	$GameOverScreenTimer.start(1.0)


func _on_GameOverScreenTimer_timeout():
	$GameOverScreen.make_visible()
