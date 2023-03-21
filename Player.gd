extends KinematicBody2D

signal gameOver

export var speed = 200.0
export var attack_dmg = 1.0
export var max_hp = 3
export var hp = 3
export var xp_level = 1
export var xp = 0
var xp_to_next_lvl = 10
var xp_increase_multiplier = 1.1 #amount xp needed increases by after level up

var invincible = false
var invincibility_time = 1.0 #in s
var velocity := Vector2()
var game_over := false
var immunity_time := 0.1

#Enemy Related
var enemy_close = [] #Array of all enemies within range
var nearest_enemy

#Attacks
var attacks_array = [
	preload("res://attacks/Field.tscn"), # field
	preload("res://attacks/Orb.tscn"), # orbs
	preload("res://attacks/MagicMissile.tscn"), # magic missile
	preload("res://attacks/LightningRod.tscn") #lightning rod
]

#First weapon player equips
var base_attack = attacks_array[0]

# Nodes
onready var sprite = $AnimatedSprite
onready var attacks = $Attacks
onready var ui = $UI
onready var animation_player = $AnimatedSprite/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 0
	position.y = 0
	hp = max_hp
	game_over = false
	$Camera2D.make_current()
	equip_attack(base_attack)

#Get keyboard input for movement
func get_input():
	velocity = Vector2()
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

#when hit
func hit():
	hp -= 1
	animation_player.play("hurt")
	ui.set_hearts(hp)
	if hp <= 0:
		if !game_over:
			emit_signal("gameOver")
			game_over = true
			sprite.play("hit")
	else: #if hit, make sure player gets brief invincibility
		invincible = true
		$ImmunityTimer.start(immunity_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if game_over:
		sprite.rotate(0.1)
		return
		
	get_input()
	
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0: 
			sprite.flip_h = true
		sprite.play("run")
	else:
		sprite.play("idle")
	
	var collision = move_and_collide(velocity.normalized()*speed*delta)
	#grab items that can be picked up
	if collision:
		if collision.collider.has_method("grab"):
			collision.collider.grab()


func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.RIGHT

#equip the preload of the specified attack
func equip_attack(attack):
	attacks.call_deferred("add_child", attack.instance())

func add_xp(n):
	xp += n
	if xp >= xp_to_next_lvl:
		xp_level += 1
		xp -= xp_to_next_lvl
		xp_to_next_lvl *= xp_increase_multiplier
		ui.add_xp(xp,xp_to_next_lvl,xp_level)

func _on_ImmunityTimer_timeout():
	invincible = false

func _on_EnemyDetectionArea_body_entered(body):
	if !enemy_close.has(body):
		enemy_close.append(body)

func _on_EnemyDetectionArea_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)

#grab items
func _on_GrabRange_area_entered(area):
	if area.has_method("grab_xp"):
		add_xp(area.grab_xp())
		area.queue_free()
		$ItemPickup.play()
	elif area.has_method("grab_heart"):
		if hp < max_hp:
			hp += 1
			ui.set_hearts(hp)
			area.queue_free()
			$ItemPickup.play()
