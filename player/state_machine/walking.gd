extends State

#Transferable States
@export var idle : State
@export var falling : State
@export var jumping : State
@export var dashing : State
#TODO , dash atk

func enter() -> void:
	parent.has_dash = true
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("dash") && parent.has_dash:
		return dashing
	if event.is_action_pressed("jump"): 
		return jumping
	return null

func process_physics(delta: float) -> State:
	if !parent.is_on_floor():
		return falling
	
	super.ground_physics(delta, parent)
	
	parent.move_and_slide()
	
	if parent.is_on_floor() && parent.velocity.x == 0 && not Input.is_anything_pressed():
		return idle
	return null
