extends State

@export var double_jumping : State
@export var walking : State
@export var wall_sliding : State

var fast_fall : bool = false

func process_input(event: InputEvent) -> State:

	if event.is_action_pressed("jump") && parent.has_double_jump:
		return double_jumping
	if event.is_action_released("jump"):
		fast_fall = true
	return null

func enter() -> void:
	parent.velocity.y -= parent.jump_strength


func process_physics(delta: float) -> State:
	if parent._check_if_valid_wall() && parent.velocity.y >= 0:
		return wall_sliding
	if parent.is_on_floor() && parent.velocity.y >= 0:
		return walking
		
	 
	#TODO normal gravity
	parent.velocity.y += parent.GRAVITY
	
	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction != 0:
		input_direction *= parent.air_move_speed
		
		if (0.0 < input_direction && input_direction < parent.velocity.x) or (0.0 > input_direction && input_direction > parent.velocity.x):
			pass
		else:
			parent.velocity.x = lerp(parent.velocity.x, input_direction, parent.air_acceleration/10)
	elif input_direction == 0.0:
		if abs(parent.velocity.x) > parent.minimum_move_speed:
			parent.velocity.x = lerp(parent.velocity.x, 0.0, parent.air_friction/1000)
			pass
		else:
			parent.velocity.x = 0
	
	parent.move_and_slide()
	return null
