extends Node

var player : Player :
	get():
		return get_tree().get_first_node_in_group("player")
var hud : Hud :
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
	var level = gameplay_scene.get_current_map().map_id
	if level in PlayerData.speedrun_records:
		var standing_record = PlayerData.speedrun_records.get(level)
		if time < standing_record:
			#prints("New record for level", level, "=", time)
			hud.show_speedrun_record(time, true)
			PlayerData.speedrun_records[level] = time
			PlayerData.save()
			#Display new record in hud?
		else:
			#prints("Too slow!  Standing record =", standing_record)
			hud.show_speedrun_record(standing_record, false)
	else:
		hud.show_speedrun_record(time, true)
		PlayerData.speedrun_records.merge({level : speedrun_time})
		PlayerData.save()
		#prints("New record for level", level, "=", time)

func collect_gem() -> void:
	hud.update_gems()
