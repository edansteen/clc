extends CanvasLayer

var tile = preload("res://game_elements/backgrounds/BackgroundComponent.tscn")
var player = get_tree().get_nodes_in_group("player")[0]

var tiles = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(4):
		tiles.append(tile.instance())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
