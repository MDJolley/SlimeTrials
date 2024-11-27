extends AnimatableBody2D

@onready var key: CharacterBody2D = $Key
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _attempt_to_open(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
	if body == key.following_player:
		_open()

func _open() -> void:
	#animation_player.play("open")
	
	#TODO
	queue_free()
	pass
 
