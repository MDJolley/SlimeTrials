extends Node

var player : Player :
	get():
		return get_tree().get_first_node_in_group("player")
var active_map_holder : Node2D
var active_map : Map
var hud
var map_id : int :
	get():
		map_id = active_map.map_id
		return map_id
var speedrun_time : float = 0.0:
	get():
		return speedrun_time

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hud = get_tree().get_first_node_in_group("hud")
	active_map_holder = get_tree().get_first_node_in_group("current_map")
	active_map = active_map_holder.get_child(0)

func _process(delta: float) -> void:
	speedrun_time += delta

func start_clock() -> void:
	speedrun_time = 0.0

func stop_clock() -> void:
	var time = speedrun_time
	var level = active_map.map_id
	var new_entry = {map_id: speedrun_time}
	if map_id in PlayerData.speedrun_records:
		var standing_record = PlayerData.speedrun_records.get(map_id)
		PlayerData.speedrun_records[map_id] = time if time < standing_record else standing_record
	else:
		PlayerData.speedrun_records.merge({map_id : speedrun_time})
		prints("New record for level", map_id, "=", time)

func collect_gem() -> void:
	hud.collect_gem()

func load_map(map : String) -> void:
	var next_map = load(map)
	var loaded_maps : Array = active_map_holder.get_children()
	if loaded_maps.size() > 0:
		for scene in active_map_holder.get_children():
			scene.queue_free()
	active_map = next_map.instantiate()
	player.spawn(active_map.spawn_location)
	active_map_holder.add_child(active_map)
	active_map = active_map_holder.get_child(0)
	start_clock()
	#player.spawn(active_map.spawn_location)

func load_next_map() -> void:
	print("Loading next map")
	var next_map = active_map.next_map
	load_map(next_map)

func start_time() -> void:
	pass
