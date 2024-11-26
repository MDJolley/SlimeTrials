@tool
extends Node

@onready var phantom_camera: PhantomCamera2D = $PhantomCamera
@onready var player = GameManager.player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phantom_camera.global_position = $"../SpawnLocation".global_position
	phantom_camera.set_follow_target(player)
