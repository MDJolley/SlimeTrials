extends Control
class_name Menu

@export_file("*.tscn") var gameplay : String = "res://game/gameplay.tscn"

func _ready() -> void:
	pass



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(gameplay)
