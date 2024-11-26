extends GPUParticles2D

@onready var dashParticles = preload("res://player/effects/particles/dashParticles.tres")
@onready var player: Player = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func emitDash():
	process_material = dashParticles
	emitting = true
	await get_tree().create_timer(player.dash_time).timeout
	emitting = false
