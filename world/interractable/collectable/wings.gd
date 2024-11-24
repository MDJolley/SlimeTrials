extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var sprite: Sprite2D = $Sprite

@export var respawn_time : float = 1.5


func _hide() -> void:
	collision_shape.disabled = true
	sprite.visible = false
	await get_tree().create_timer(respawn_time).timeout
	collision_shape.disabled = false
	sprite.visible = true

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	_hide()
	body.return_dash()
