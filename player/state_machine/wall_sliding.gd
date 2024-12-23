extends State

@export var wall_jumping : State
@export var falling : State
@export var dashing : State
@export var walking : State

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return wall_jumping
	if event.is_action_pressed("dash"):
		return dashing if parent.has_dash else null
	return null

func process_physics(delta: float) -> State:
	if parent.velocity.y < 0:
		return falling
	if parent.is_on_floor():
		parent.has_double_jump = true
		return walking
	if !parent._check_if_valid_wall():
		return falling
	parent.velocity.y = lerp(parent.velocity.y, parent.wall_slide_speed, .5)
	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction != 0:
		input_direction *= parent.air_move_speed
		parent.velocity.x = lerp(parent.velocity.x, input_direction, parent.air_acceleration)
	
	parent.move_and_slide()
	
	return null
