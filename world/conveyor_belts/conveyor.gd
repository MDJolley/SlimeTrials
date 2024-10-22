extends StaticBody2D

@export var clockwise : bool = true
@export var linear_velocity : float = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("belt")
	if !clockwise:
		sprite.flip_h = true
		constant_linear_velocity.x = -linear_velocity
	else:
		constant_linear_velocity.x = linear_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
