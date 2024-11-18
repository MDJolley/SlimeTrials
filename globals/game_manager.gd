extends Node

var player : Player
var active_map_holder : Node2D
var active_map : Map
var hud
var speedrun_times : Dictionary
var map_id

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hud = get_tree().get_first_node_in_group("hud")
	active_map_holder = get_tree().get_first_node_in_group("current_map")
	active_map = active_map_holder.get_child(0)

func collect_gem() -> void:
	hud.collect_gem()

func load_map(map : String) -> void:
	var next_map = load(map)
	var loaded_maps : Array = active_map_holder.get_children()
	if loaded_maps.size() > 0:
		for scene in active_map_holder.get_children():
			scene.queue_free()
	active_map_holder.add_child(next_map.instantiate())
	active_map = active_map_holder.get_child(0)
	await player.spawn(active_map.spawn_location)

func load_next_map() -> void:
	var next_map = active_map.next_map
	load_map(next_map)

func start_time() -> void:
	pass
