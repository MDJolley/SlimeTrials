extends Node

var player : Player :
	get():
		return get_tree().get_first_node_in_group("player")
var hud : Control :
	get:
		return get_tree().get_first_node_in_group("hud")
var speedrun_time : float = 0.0:
	get():
		return speedrun_time
var gameplay_scene : Node2D :
	get: 
		return get_tree().get_first_node_in_group("gameplay")


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	speedrun_time += delta

func setup_gameplay(gameplay_scene : Node2D) -> void:
	gameplay_scene.connect("map_loaded", start_clock)

func start_clock() -> void:
	speedrun_time = 0.0

func stop_clock() -> void:
	var time = speedrun_time
	var level = gameplay_scene.loaded_map.map_id
	if level in PlayerData.speedrun_records:
		var standing_record = PlayerData.speedrun_records.get(level)
		if time < standing_record:
			prints("New record for level", level, "=", time)
			PlayerData.speedrun_records[level] = time
			#Display new record in hud?
		else:
			prints("Too slow!  Standing record =", standing_record)
	else:
		PlayerData.speedrun_records.merge({level : speedrun_time})
		prints("New record for level", level, "=", time)

func collect_gem() -> void:
	hud.collect_gem()
