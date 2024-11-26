@tool
extends AnimatableBody2D

@onready var polygon: Polygon2D = $Polygon
@onready var outline: Polygon2D = $Outline
@onready var collision_shape: CollisionShape2D = $CollisionShape

@export var color : Color = Color.ALICE_BLUE
@export var outline_color : Color = Color.DEEP_SKY_BLUE
@export var outline_thickness : float = 6

func _ready() -> void:
	bake_shape()

func bake_shape():
	var poly = polygon.polygon
	var ol_poly : Array
	polygon.color = color
	outline.color = outline_color
	for point : Vector2 in poly:
		var x = point.x + outline_thickness if point.x < 0 else point.x - outline_thickness
		var y = point.y + outline_thickness if point.y < 0 else point.y - outline_thickness
		ol_poly.append(Vector2(x,y))
	outline.polygon = ol_poly
	
	collision_shape.set_shape( RectangleShape2D.new() )
	collision_shape.shape.set_size(Vector2( abs(poly[0] - poly[2]) ))
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		bake_shape()
