extends Node2D

@onready var player: Player = $".."

func _on_body_entered(body: Node2D) -> void:
	player.touching_wall = true


func _on_body_exited(body: Node2D) -> void:
	player.touching_wall = false
