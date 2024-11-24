extends Node2D

@export_file("*.tscn") var map_to_load : String

@onready var player: Player = $Player

var loaded_map : Map :
	get:
		return $CurrentMap.get_child(0)

signal map_loaded

func _ready() -> void:
	GameManager.setup_gameplay(self)
	load_map(map_to_load)
	player.connect("level_complete", func(): load_map(loaded_map.next_map))
	player.connect("dead", _reload_map)

func _reload_map() -> void:
	load_map(loaded_map.scene_file_path)

func load_map(map) -> void:
	var next_map = load(map)
	var loaded_maps : Array = $CurrentMap.get_children()
	if loaded_maps.size() > 0:
		for scene in loaded_maps:
			scene.queue_free()
	
	$CurrentMap.add_child(next_map.instantiate())
	loaded_map = $CurrentMap.get_child(0)
	emit_signal("map_loaded")
	player.spawn(loaded_map.spawn_location)
	GameManager.start_clock()
