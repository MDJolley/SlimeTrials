extends Control
class_name Menu

const GAMEPLAY_PATH : String = "res://game/gameplay.tscn"
const LEVEL_SELECT = preload("res://menus/level_select.tscn")
const HAT_SELECT = preload("res://menus/hat_select.tscn")
const RESET_CONFIRMATION = preload("res://menus/reset_confirmation.tscn")

@onready var hbox: HBoxContainer = $MarginContainer/HBoxContainer
@onready var margin_container: MarginContainer = $MarginContainer

func _ready() -> void:
	pass



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(GAMEPLAY_PATH)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_reset_pressed() -> void:
	margin_container.add_child(RESET_CONFIRMATION.instantiate())


func _on_practice_pressed() -> void:
	if hbox.get_child_count() > 1:
		hbox.get_child(1).queue_free()
	hbox.add_child(LEVEL_SELECT.instantiate())

func _on_wardrobe_pressed() -> void:
	get_tree().change_scene_to_packed(HAT_SELECT)
