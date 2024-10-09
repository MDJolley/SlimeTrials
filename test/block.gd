extends StaticBody2D

@onready var collision_shape = $CollisionShape
@onready var poly = $Polygon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape.polygon = poly.polygon
