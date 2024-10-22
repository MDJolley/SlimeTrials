extends Node2D

@onready var path_follow : PathFollow2D = $Path/PathFollow
@onready var platform: CharacterBody2D = $Path/PathFollow/Platform

@export var move_speed : float = 0.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.set_progress(path_follow.progress + move_speed)
	platform.move_and_slide()
