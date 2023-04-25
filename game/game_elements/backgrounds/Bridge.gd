#creates 2 bridge components, moves around 1 of them based on position of
# player relative to the center of the other
extends Node2D

const COMPONENT_WIDTH = 1024

onready var components = [$Component1, $Component2]

onready var player = get_tree().get_nodes_in_group("player")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var px = player.global_position.x
	var stationary_component : bool = 0
	if components[stationary_component].global_position.distance_to(px) < (COMPONENT_WIDTH/2):
		pass
