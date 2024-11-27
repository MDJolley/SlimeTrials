extends State

@export var falling : State
@export var walking : State
@export var hyper : State

@onready var state_machine: Node2D = $".."
@onready var dash_sfx: AudioStreamPlayer2D = $"../../SFX/Dash"


var dashing : bool = false
var dash_vector : Vector2
var is_hyperdashing : bool = false
var interrupted : bool = false
#TODO export superjumping?

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump") && parent._check_if_valid_wall() && !parent.is_on_floor():
		is_hyperdashing = true
		return hyper
	elif event.is_action_pressed("jump") && parent.is_on_floor():
		is_hyperdashing = true
		return hyper
	return null

func enter() -> void:
	dash_sfx.play()
	interrupted = false
	parent.connect("movement_interrupted", func(): interrupted = true)
	is_hyperdashing = false
	dash_vector = Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("move_up", "move_down"))
	if dash_vector == Vector2(0,0):
		#TODO Dash in direction player is facing
		return
	
	dashing = true
	parent.has_dash = false
	await get_tree().create_timer(parent.dash_time).timeout
	if dashing:
		end_dash()

func process_physics(delta: float) -> State:
	
	if !dashing:
		return falling if !parent.is_on_floor() else walking
	parent.velocity = dash_vector.normalized() * parent.dash_speed
	parent.move_and_slide()
	
	
	return null

func end_dash() -> void:
	#TODO stop particle machine
	if not is_hyperdashing and not interrupted:
		parent.velocity = parent.velocity.normalized() * parent.air_move_speed
	dashing = false
	is_hyperdashing = false
	interrupted = false
