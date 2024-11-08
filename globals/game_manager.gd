extends Node

var player : Player
var active_map
var hud

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hud = get_tree().get_first_node_in_group("hud")
	
func collect_gem() -> void:
	hud.collect_gem()
