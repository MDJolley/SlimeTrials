extends Node2D

@onready var path: Path2D = $Path
@onready var path_follow : PathFollow2D = $Path/PathFollow
@onready var animation_player: AnimationPlayer = $Path/AnimationPlayer

@export var loop : bool = false
@export var move_speed : float = 256.0

var path_length : float 

func _ready() -> void:
	path_length = path.curve.get_baked_length()
	if not loop:
		animation_player.play("move")
		animation_player.set_speed_scale( move_speed / path_length )

func _process(delta: float) -> void:
	pass
	path_follow.set_progress(path_follow.progress + move_speed)
