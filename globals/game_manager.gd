extends Node

var player : Player
var active_map : Node2D
var hud

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hud = get_tree().get_first_node_in_group("hud")
	active_map = get_tree().get_first_node_in_group("current_map")
	
func collect_gem() -> void:
	hud.collect_gem()

func load_next_map() -> void:
	player.disable()
	for area : Map in active_map.get_children():
		var next = load(area.next_map)
		area.queue_free()
		active_map.add_child(next.instantiate())
	
	var map = active_map.get_child(0)
	await player.spawn(map.spawn_location)
