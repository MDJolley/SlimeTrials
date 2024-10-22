extends Node2D

var platform_scene = preload("res://world/falling_platforms/falling_platform_object.tscn")

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func spawn_new_platform(delay : float) -> void:
	await get_tree().create_timer(delay).timeout
	add_child(platform_scene.instantiate())
