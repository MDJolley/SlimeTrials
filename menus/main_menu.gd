extends Control
class_name Menu

const GAMEPLAY_PATH : String = "res://game/gameplay.tscn"
const LEVEL_SELECT = preload("res://menus/level_select.tscn")

@onready var hbox: HBoxContainer = $MarginContainer/HBoxContainer

func _ready() -> void:
	pass



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(GAMEPLAY_PATH)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_reset_pressed() -> void:
	PlayerData.purge_player_data()


func _on_practice_pressed() -> void:
	if hbox.get_child_count() > 1:
		hbox.get_child(1).queue_free()
	hbox.add_child(LEVEL_SELECT.instantiate())
