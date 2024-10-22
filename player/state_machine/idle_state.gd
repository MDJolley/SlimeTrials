extends State

@export var walking : State
@export var jumping : State
@export var dashing : State
@export var falling : State
#TODO export atk

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		return walking
	if event.is_action_pressed("jump"):
		return jumping
	if event.is_action_pressed("dash") && parent.has_dash:
		return dashing
	return null

func process_physics(delta: float) -> State:
	if !parent.is_on_floor():
		return falling
	parent.velocity.y = parent.GRAVITY
	parent.move_and_slide()
	return null
