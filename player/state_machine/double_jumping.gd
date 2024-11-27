extends State

@export var falling : State
@export var dashing : State

@onready var double_jump_particles: GPUParticles2D = $"../../DoubleJumpParticles"
@onready var jump_sfx: AudioStreamPlayer2D = $"../../SFX/Jump"

var fast_fall : bool = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("dash") && parent.has_dash:
		return dashing
	if event.is_action_released("jump"):
		fast_fall = true
	return null

func enter() -> void:
	jump_sfx.play()
	double_jump_particles.restart()
	double_jump_particles.emitting = true
	fast_fall = false
	parent.has_double_jump = false
	parent.velocity.y = -parent.double_jump_strength

func process_physics(delta: float) -> State:
	super.air_physics(delta, parent, fast_fall)
	
	if parent.velocity.y >= 0:
		return falling
	
	parent.move_and_slide()
	return null
