@tool
extends Area2D

@export var facing : Facing = Facing.UP :
	set(value):
		facing = value
		_set_facing()

enum Facing{UP, DOWN, LEFT, RIGHT}
@export var launch_power : float = 1000

var launch_angle : Vector2 :
	get:
		match facing:
			Facing.UP:
				return Vector2(0, -1)
			Facing.DOWN:
				return Vector2(0, 1)
			Facing.LEFT:
				return Vector2(-1, -0.3)
			Facing.RIGHT:
				return Vector2(1, -0.3)
			_:
				return Vector2(0, -1)
var bouncing : bool = false

func _ready() -> void:
	_set_facing()
	set_process(false)

func _set_facing() -> void:
	match facing:
		Facing.UP:
			rotation_degrees = 0
		Facing.DOWN:
			rotation_degrees = 180
		Facing.LEFT:
			rotation_degrees = 270
		Facing.RIGHT:
			rotation_degrees = 90

func _on_body_entered(body: Node2D) -> void:
	if bouncing: 
		return
	else :
		bouncing = true
		$AnimationPlayer.advance(0)
		$AnimationPlayer.play("bounce")
		await $AnimationPlayer.animation_finished
		_reset()

func _launch() -> void:
	if !has_overlapping_bodies():
		return
	var player : Player = get_overlapping_bodies()[0]
	player.find_child("DashParticles").emitDash()
	player.emit_signal("movement_interrupted")
	player.state_machine.change_state_by_name("Falling")
	player.has_dash = true
	player.has_double_jump = true
	player.play_sound("Dash")
	if launch_angle.x == 0:
		player.velocity = launch_angle * launch_power
	else:
		
		player.lock_inputs(.1)
		player.velocity = launch_angle * launch_power
	player.move_and_slide()

func _reset() -> void:
	bouncing = false
