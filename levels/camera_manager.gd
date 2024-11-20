extends Node

@onready var phantom_camera: PhantomCamera2D = $PhantomCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#phantom_camera.position = GameManager.player.position
	phantom_camera.set_follow_target(GameManager.player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
