extends Area2D

var level = 1
var damage = 8
var area = 1.0
var attack_cooldown = 1.0 #interval between every time field attacks a mob

#array of enemies in the area
var enemies_in_range = []

onready var sprite = $Sprite
onready var attack_area = $AttackArea

func _ready():
	match level:
		1:
			damage = 8
			attack_cooldown = 1.0
			area = 1.0
		2:
			damage *= 2
			area *= 1+(1/3)
		3:
			damage *= 1+(1/3)
			area *= 1.1
		4:
			damage *= 1+(1/3)
			area *= 1.1
		5:
			damage *= 1+(1/3)
			area *= 1.1
		6:
			damage *= 2
			area *= 1.1
	attack_area.scale *= area
	sprite.scale *= area
	$CooldownTimer.start(attack_cooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sprite.rotate(0.01)


func level_up():
	if level > 6:
		level += 1
	

func get_description():
	return "a force field";
	
	
func _on_Field_body_entered(body):
	if !enemies_in_range.has(body):
		if body.has_method("hit_for"):
			enemies_in_range.append(body)
			body.hit_for(damage)


func _on_Field_body_exited(body):
	if enemies_in_range.has(body):
		enemies_in_range.erase(body)


func _on_CooldownTimer_timeout():
	for mob in enemies_in_range:
		mob.hit_for(damage)
	$CooldownTimer.start(attack_cooldown)
