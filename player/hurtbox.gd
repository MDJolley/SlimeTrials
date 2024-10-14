extends Area2D

@onready var player: Player = $".."

func _on_body_entered(body: Node2D) -> void:
	player.die()
