extends State

@export var falling : State
@export var double_jumping : State
@export var dashing : State
@export var wall_jumping : State

var fast_fall : bool = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("dash") && parent.has_dash:
		return dashing
	if event.is_action_pressed("jump") && parent.has_double_jump:
		return double_jumping
	if event.is_action_released("jump"):
		fast_fall = true
	return null

func enter() -> void:
	parent.velocity.y = -parent.jump_strength
	fast_fall = false

func process_physics(delta: float) -> State:
	super.air_physics(delta, parent, fast_fall)
	
	if parent.velocity.y >= 0:
		return falling
	
	print(parent.velocity.y, " <- Jump velocity")
	parent.move_and_slide()
	return null
