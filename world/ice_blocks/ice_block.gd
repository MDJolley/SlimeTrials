extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _player_on(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
	else:
		body.edit_ice_blocks(1)


func _player_off(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
	else:
		body.edit_ice_blocks(-1)
