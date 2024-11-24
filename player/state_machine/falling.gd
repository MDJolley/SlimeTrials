extends State

@export var walking : State
@export var double_jumping : State
@export var dashing : State
@export var wall_slide : State
@export var jumping : State

var fast_fall : bool = false
var buffered_jump : bool = false :
	set(param):
		buffered_jump = param
		await  get_tree().create_timer(.1).timeout
		buffered_jump = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("dash") && parent.has_dash:
		return dashing
	if event.is_action_pressed("jump"):
		if parent.cyote:
			return jumping
		if parent.has_double_jump:
			return double_jumping
		else:
			buffer_jump()

	return null

func buffer_jump() -> void:
	buffered_jump = true
	#await get_tree().create_timer(.1).timeout
	#buffered_jump = false

func enter() -> void:
	pass

func process_physics(delta: float) -> State:
	if parent._check_if_valid_wall() && parent.velocity.y >= 0:
		return wall_slide
	if parent.is_on_floor():
		parent.has_double_jump = true
		parent.has_dash = true
		return jumping if buffered_jump else walking 
	
	super.air_physics(delta, parent, fast_fall)
	
	parent.move_and_slide()
	return null
	
	
