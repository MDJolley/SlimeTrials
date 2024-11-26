extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape

func _ready() -> void:
	print("Next portal is ready")
	var player : Player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		pass
	else:
		if not body.can_touch_goal:
			return
		body.touch_goal(self)
