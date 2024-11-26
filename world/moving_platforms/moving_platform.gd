extends Node2D

var path_length : float 

@export var loop : bool = false
@export var move_speed : float = 256.0

@onready var path_follow : PathFollow2D = $Path/PathFollow
@onready var animation_player: AnimationPlayer = $Path/AnimationPlayer
@onready var line: Line2D = $Line
@onready var path: Path2D = $Path

func _ready() -> void:
	line.points = path.curve.get_baked_points()
	path_length = path.curve.get_baked_length()
	if not loop:
		animation_player.play("move")
		animation_player.set_speed_scale( move_speed / path_length )

func _process(delta: float) -> void:
	path_follow.set_progress(path_follow.progress + move_speed)
