extends State

@export var walking : State
@export var double_jumping : State
@export var dashing : State
@export var wall_slide : State

var fast_fall :bool = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("dash") && parent.has_dash:
		return dashing
	if event.is_action_pressed("jump") && parent.has_double_jump:
		return double_jumping
	return null

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	if parent._check_if_valid_wall() && parent.velocity.y >= 0:
		return wall_slide
	if parent.is_on_floor():
		parent.has_double_jump = true
		parent.has_dash = true
		return walking
	
	super.air_physics(delta, parent, fast_fall)
	
	parent.move_and_slide()
	return null
	
	
