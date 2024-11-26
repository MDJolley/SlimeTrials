extends Control
const LEVELS_PATH : String = "res://levels/"

const LEVEL_BUTTON = preload("res://menus/level_button.tscn")
const GAMEPLAY = preload("res://game/gameplay.tscn")



func _ready() -> void:
	var dir = DirAccess.open(LEVELS_PATH)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	var level_index = 1

	while file_name != "":
		var button = LEVEL_BUTTON.instantiate()
		var button_text : Label = button.find_child("Label")
		button_text.text = str("Level ", level_index)
		add_child(button)
		
		button.connect("button_down", func(): _level_selected(file_name))
		
		level_index += 1
		file_name = dir.get_next()
	

func _level_selected(level : String):
	var gameplay_scene = GAMEPLAY.instantiate()
	gameplay_scene.map_to_load = str(LEVELS_PATH, level)
	gameplay_scene.loop = true
	gameplay_scene.repeating_map = str(LEVELS_PATH, level)
	var scene = PackedScene.new()
	scene.pack(gameplay_scene)
	
	get_tree().root.add_child(gameplay_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = gameplay_scene



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
