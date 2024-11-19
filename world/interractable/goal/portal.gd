extends Area2D

var touched : bool = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		pass
	else:
		body.touch_goal(self)
