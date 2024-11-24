class_name State
extends Node

@export var animation_name : String
@export var state_name : String

var parent : Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func ground_physics(delta: float, player: Player) -> void:
	if parent.inputs_locked:
		return
	var input_direction : float = Input.get_axis("move_left", "move_right")
	if input_direction != 0:
		input_direction *= player.ground_move_speed
		if not Input.is_action_pressed("move_down"):
			player.velocity.x = lerp(player.velocity.x, input_direction, player.ground_acceleration)
		else:
			player.velocity.x = lerp(player.velocity.x, 0.0, player.ground_friction)
	elif input_direction == 0.0:
		if abs(player.velocity.x) > player.minimum_move_speed:
			player.velocity.x = lerp(player.velocity.x, 0.0, player.ground_friction)
		else:
			player.velocity.x = 0

	player.velocity.y = player.GRAVITY

func air_physics(delta: float, player : Player, fast_fall : bool) -> void:
	if parent.inputs_locked:
		return
	var current_gravity = player.GRAVITY
	if Input.is_action_pressed("jump"):
		current_gravity *= .75
	if fast_fall:
		player.velocity.y += current_gravity
	player.velocity.y += current_gravity 
	
	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction != 0:
		input_direction *= player.air_move_speed
	#TODO check for high velocities and slow friction or change direction
		if (0.0 < input_direction && input_direction < player.velocity.x) or (0.0 > input_direction && input_direction > parent.velocity.x):
			parent.velocity.x = lerp(parent.velocity.x, input_direction, parent.air_friction/1000)
		else:
			player.velocity.x = lerp(player.velocity.x, input_direction, player.air_acceleration)
	elif input_direction == 0.0:
		if abs(player.velocity.x) > player.minimum_move_speed:
			player.velocity.x = lerp(player.velocity.x, 0.0, player.air_friction)
		else:
			player.velocity.x = 0
