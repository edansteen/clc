extends Node2D

var damage = 20.0
var area = 1.0
var projectile_num = 1
var cooldown_time = 4.0 #in s
var level = 1

var rng = RandomNumberGenerator.new()
#find mobs on the screen
var mobs_in_range = []

var lightning = preload("res://attacks/projectiles/Lightning.tscn")

onready var main = get_tree().get_nodes_in_group("main")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	match level:
		1:
			damage = 20.0
			area = 1.0
			projectile_num = 1
	$CooldownTimer.start(cooldown_time)
	


func set_damage(d):
	damage = d


func _on_CooldownTimer_timeout():
	for _i in range(projectile_num):
		var l = lightning.instance()
		l.set_level(level)
		#strike random enemy in range
		l.global_position = mobs_in_range[rng.randi_range(0,mobs_in_range.size()-1)].global_position
		main.call_deferred("add_child", l)
	$CooldownTimer.start(cooldown_time)


func _on_Range_body_entered(body):
	if !mobs_in_range.has(body):
		if body.has_method("hit_for"):
			mobs_in_range.append(body)


func _on_Range_body_exited(body):
	if mobs_in_range.has(body):
		mobs_in_range.erase(body)
