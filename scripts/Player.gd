extends KinematicBody2D

signal gameOver

export var speed = 200.0
export var max_hp = 100
export var hp = 100
export var xp_level = 1
export var xp = 0
var xp_to_next_lvl = 30
var xp_increase_multiplier = 1.2 #amount xp needed increases by after level up

var invincible = false
var invincibility_time = 1.0 #in s
var velocity := Vector2()
var game_over := false
var immunity_time := 0.1

var rng = RandomNumberGenerator.new()

#Weapons
var weapons_array = [
	preload("res://attacks/Field.tscn"), # field
	preload("res://attacks/Orb.tscn"), # orbs
	preload("res://attacks/MagicMissile.tscn"), # magic missile
	preload("res://attacks/LaserStrike.tscn"), #laser strike
	preload("res://attacks/ChainLightning.tscn"), #chain lightning
	preload("res://attacks/MagicSword.tscn"), #magic sword
	preload("res://attacks/MagicGun.tscn"), #the magic gun
	#preload("res://attacks/TimeStop.tscn"), #Time stop
	#preload("res://attacks/DVDLogo.tscn"), #DVD Logo
	#preload("res://attacks/BlackHole.tscn") #Black hole
]

#Index of first weapon player equips (based on position in attacks_array)
var base_attack = 0

# Nodes
onready var sprite = $AnimatedSprite
onready var weapons = $Weapons
onready var gui = $GUI
onready var animation_player = $AnimatedSprite/AnimationPlayer
onready var levelup_panel = $GUI/Control/LevelUp
onready var xp_bar = $GUI/Control/ProgressBar
onready var healthbar = $GUI/Control/HealthBar
onready var level_label = $GUI/Control/ProgressBar/LevelLabel
onready var upgrade_options = $GUI/Control/LevelUp/UpgradeOptions


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 0
	position.y = 0
	hp = max_hp
	game_over = false
	$Camera2D.make_current()
	xp_level = 1
	xp_bar.max_value = xp_to_next_lvl
	xp_bar.value = xp
	healthbar.max_value = hp
	healthbar.value = hp
	
	#equip all weapons at level 0 (where they do nothing)
	for i in range(weapons_array.size()):
		weapons_array[i] = weapons_array[i].instance() #transform to instance of itself
		weapons.call_deferred("add_child", weapons_array[i])
		
	#level up the base weapon
	level_up_weapon(base_attack)

#Get keyboard input for movement
func get_input():
	velocity = Vector2()
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


#when hit
func hit(dmg):
	if game_over:
		return
	hp -= dmg
	healthbar.value = hp
	animation_player.play("hurt")
	if hp <= 0:
		emit_signal("gameOver")
		for n in weapons.get_children():
			n.queue_free()
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
	

#level up the specified weapon
func level_up_weapon(weapon_index):
	if weapon_index == -1:
		heal(40)
	elif weapon_index < weapons_array.size():
		weapons_array[weapon_index].level_up()
	else:
		print("Error: invalid index")
	$WeaponEquipped.play()

func add_xp(n):
	xp += n
	if xp >= xp_to_next_lvl: # LEVEL UP
		xp_bar.value = xp_bar.max_value
		level_up_player()
		xp_level += 1
		xp -= xp_to_next_lvl
		xp_to_next_lvl *= xp_increase_multiplier
		xp_bar.value = xp
		xp_bar.max_value = xp_to_next_lvl
	xp_bar.value = xp
	
#heal player for n
func heal(n):
	hp += n
	if hp > max_hp:
		hp = max_hp
	healthbar.value = hp
	
	
func level_up_player():
	get_tree().paused = true
	$GUI/Control/LevelUp/LevelUpSound.play()
	levelup_panel.show()
	level_label.text = "Level %s" % str(xp_level)
	#choose random options
	var selected = []
	for button in upgrade_options.get_children():
		var i = rng.randi_range(0,weapons_array.size()-1)
		if !(i in selected) and weapons_array[i].get_level() < 6:
			selected.append(i)
			button.set_value(i)
			button.set_option(weapons_array[i])
		else:
			button.set_option(null)

func _on_ImmunityTimer_timeout():
	invincible = false

#grab items
func _on_GrabRange_area_entered(area):
	if area.has_method("grab_xp"):
		add_xp(area.grab_xp())
		area.queue_free()
		$ItemPickup.play()


func _on_UpgradeOption_pressed():
	get_tree().paused = false
	levelup_panel.hide()
	level_up_weapon($GUI/Control/LevelUp/UpgradeOptions/UpgradeOption.get_value())


func _on_UpgradeOption2_pressed():
	get_tree().paused = false
	levelup_panel.hide()
	level_up_weapon($GUI/Control/LevelUp/UpgradeOptions/UpgradeOption2.get_value())


func _on_UpgradeOption3_pressed():
	get_tree().paused = false
	levelup_panel.hide()
	level_up_weapon($GUI/Control/LevelUp/UpgradeOptions/UpgradeOption3.get_value())
