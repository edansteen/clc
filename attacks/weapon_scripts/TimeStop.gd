extends Node2D

var level = 0
var cooldown = 30.0
var duration = 5.0

onready var timer = $CooldownTimer
onready var dur_timer = $DurationTimer
onready var filter = $ScreenFilter

func level_up():
	level += 1
	match level:
		1:
			cooldown = 30.0
			duration = 6.0
		2:
			duration = 7.0
		3:
			cooldown -= 5.0
		4:
			duration = 8.5
		5:
			cooldown -= 10
		6:
			duration = 12.0
	$Activation.play()

func get_name():
	return "The World"
	
func get_icon():
	return "res://assets/weaponArt/orb_sprite.png"

func get_level():
	return level

func get_desc():
	match level:
		0:
			return "Freezes all enemies for 5 seconds every 30 seconds"
		1:
			return "Duration increased to 7 seconds"
		2:
			return "Cooldown reduced by 5 seconds"
		3:
			return "Duration increased to 8.5 seconds"
		4:
			return "Cooldown reduced by 10 seconds"
		5:
			return "Duration increased to 12 seconds"



func _on_CooldownTimer_timeout():
	$Activation.play()


func _on_DurationTimer_timeout():
	filter.set_deferred("visible", false)
	for mob in get_tree().get_nodes_in_group("mobs"):
		if mob.has_method("freeze"):
			mob.freeze(false)
	timer.start(cooldown)


func _on_Activation_finished():
	filter.set_deferred("visible", true)
	for mob in get_tree().get_nodes_in_group("mobs"):
		if mob.has_method("freeze"):
			mob.freeze(true)
	dur_timer.start(duration)
