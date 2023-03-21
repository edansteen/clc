extends Node2D

var level = 1
var projectiles = 1
var damage = 8.0
var rotation_speed = 1.0
var orb_size = 1.0
var radius = 5.0

var angle = 0

var orb = preload("res://attacks/projectiles/OrbProjectile.tscn")

#array with all active orbs
var orbs = [
	orb.instance()
]

onready var point = $OriginPoint.global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lvl(1, 1)
	call_deferred("add_child",orbs[0])
	#place orbs 
	orbs[0].position = point + Vector2(cos(angle), sin(angle)) * radius


func set_lvl(lvl, dmg_multiplier):
	match level:
		1:
			projectiles = 1
			damage = 8.0
			rotation_speed = 1.0
			orb_size = 1.0
			radius = 5.0
	for node in orbs:
		node.set_level(lvl, dmg_multiplier)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	orbs[0].position = point + (orbs[0].position - point).rotated(angle)
