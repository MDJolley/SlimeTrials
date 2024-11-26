extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var sprite: Sprite2D = $Sprite

@export var respawn_time : float = 1.5

var player_touching = false

func _hide() -> void:
	collision_shape.disabled = true
	sprite.visible = false
	await get_tree().create_timer(respawn_time).timeout
	collision_shape.disabled = false
	sprite.visible = true

func _physics_process(delta: float) -> void:
	if player_touching:
		var player = get_overlapping_bodies()[0]
		if player.has_dash:
			return
		else:
			_consume(player)


func _consume(player) -> void:
	_hide()
	player.return_dash()

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	else:
		player_touching = true
	if body.has_dash:
		return

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_touching = false
	
