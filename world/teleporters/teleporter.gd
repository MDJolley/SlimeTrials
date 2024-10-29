extends StaticBody2D
class_name Teleporter

@onready var return_point: Marker2D = $ReturnPoint
@onready var receiver: Area2D = $Receiver

@export var sibling : Teleporter

var teleport_possible : bool = false
var player : Player

func _process(delta: float) -> void:
	if !teleport_possible:
		pass
	if player != null:
		if player.state_machine.current_state.state_name == "dashing":
			print("Dashed on me.")
		if Input.is_action_pressed("move_down"):
			print("down")

func _on_receiver_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		teleport_possible = true

func _on_receiver_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player left")
		teleport_possible = false
		player = null
