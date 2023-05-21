extends Area2D

var level : int = 0
var damage : float = 8.0
var area = 1.0
var attack_cooldown = 1.0 #interval between every time field attacks a mob

#array of enemies in the area
var enemies_in_range = []

onready var sprite = $Sprite

func _ready():
	$CooldownTimer.start(attack_cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	sprite.rotate(0.01)


func level_up():
	level += 1
	match level:
		1:
			$Sprite.visible = true
			damage = 8.0
			attack_cooldown = 0.8
			area = 1.0
		2:
			damage *= 1.1
			area *= 1.1
		3:
			damage *= 1.1
			area *= 1.1
		4:
			damage *= 1.1
			area *= 1.1
		5:
			damage *= 1.1
			area *= 1.05
		6:
			damage *= 2.0
			area *= 1.05
	$AttackArea.scale *= area
	$Sprite.scale *= area


func get_name():
	return "Force Field"

func get_level():
	return level

func get_icon():
	return "res://assets/weaponArt/force_field.png"

func get_desc():
	match (level):
		0:
			return "Damages enemies entering its field";
		1:
			return "Damage +10%, Area +10%"
		2:
			return "Damage +10%, Area +10%"
		3:
			return "Damage +10%, Area +10%"
		4:
			return "Damage +10%, Area +5%"
		5:
			SaveScript.game_data.twoUnlocked = true
			SaveScript.save()
			return "Damage +100%, Area +5%"
			
func _on_Field_body_entered(body):
	if !enemies_in_range.has(body):
		if body.has_method("hit_for"):
			enemies_in_range.append(body)
			if level != 0:
				body.hit_for(damage)


func _on_Field_body_exited(body):
	if enemies_in_range.has(body):
		enemies_in_range.erase(body)


func _on_CooldownTimer_timeout():
	if level != 0:
		for mob in enemies_in_range:
			mob.hit_for(damage)
	$CooldownTimer.start(attack_cooldown)
