extends Node2D


@export_file("*.tscn") var pause_menu_path : String
@export_file("*.tscn") var map_to_load : String

const MAIN_MENU_PATH : String = "res://menus/main_menu.tscn"

var pause_menu : Resource
var loop : bool = false
var repeating_map : String

@onready var popup_layer: Control = self.find_child("PopupLayer")
@onready var player : Player = $Player

var loaded_map : Map :
	get:
		return $CurrentMap.get_child(0)

signal map_loaded

func _ready() -> void:
	pause_menu = load(pause_menu_path)
	GameManager.setup_gameplay(self)
	load_map(map_to_load)
	player.connect("level_complete", func(): load_map(loaded_map.next_map))
	player.connect("dead", _reload_map)
	player.connect("reset", _reload_map)
	player.connect("pause_game", _pause_game)

func _reload_map() -> void:
	load_map(loaded_map.scene_file_path)

func load_map(map : String) -> void:	
	if map == "empty" and loop == false:
		PlayerData.save()
		get_tree().change_scene_to_file(MAIN_MENU_PATH)
		return
	var next_map
	if loop:
		next_map = load(repeating_map)
	else:
		next_map = load(map)
	var loaded_maps : Array = $CurrentMap.get_children()
	if loaded_maps.size() > 0:
		for scene in loaded_maps:
			scene.free()
	player.position = Vector2(0,0)
	print("player moved to ", player.position)
	
	$CurrentMap.add_child(next_map.instantiate())
	loaded_map = $CurrentMap.get_child(0)
	emit_signal("map_loaded")
	player.spawn(loaded_map.spawn_location)
	GameManager.start_clock()

func get_current_map() -> Map:
	if $CurrentMap.get_children().size() == 1:
		return $CurrentMap.get_child(0)
	else: 
		return null

func _pause_game():
	get_tree().paused = true
	var pause = pause_menu.instantiate()

	popup_layer.add_child(pause)
	pause.menu_active = true
	pause.connect("unpause", _unpause_game)
	pause.connect("menu_pressed", _menu_pressed)
	pause.connect("quit_pressed", _quit_pressed)

func _unpause_game():
	get_tree().paused = false
	var children = popup_layer.get_children()
	if children.size() > 0:
		for child in children:
			child.queue_free()

func _menu_pressed():
	get_tree().paused = false
	PlayerData.save()
	get_tree().change_scene_to_file(MAIN_MENU_PATH)

func _quit_pressed():
	get_tree().paused = false
	PlayerData.save()
	get_tree().quit()
