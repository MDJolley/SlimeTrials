extends Area2D

@onready var player: Player = $".."
@onready var collision_shape: CollisionPolygon2D = $CollisionShape


func _on_body_entered(body: Node2D) -> void:
	player.die()

func disable_collision() -> void:
	collision_shape.set_deferred("disabled", true)

func enable_collision() -> void:
	collision_shape.set_deferred("disabled", false)
