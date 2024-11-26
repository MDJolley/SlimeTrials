extends Area2D

@onready var tile_map: TileMapLayer = $TileMap


func _on_body_entered(body: Node2D) -> void:
	if body.can_interract:
		tile_map.self_modulate.a = .5

func _on_body_exited(body: Node2D) -> void:
	tile_map.self_modulate.a = 1
	
