extends State

@export var idle : State

var suction_point : Vector2

func enter() -> void:
	var port : Node2D = get_tree().get_first_node_in_group("portal")
	if port:
		suction_point = port.global_position
	else:
		pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
