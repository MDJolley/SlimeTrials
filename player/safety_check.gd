extends Timer

var state : State :
	get:
		return $"../StateMachine".current_state

var active : bool = false

func _process(delta: float) -> void:
	if state == $"../StateMachine/Walking" or state == $"../StateMachine/Idle":
		if active:
			pass
		else:
			active = true
			start()
	else:
		stop()
		active = false
