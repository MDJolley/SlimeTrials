extends Node2D
class_name Map

@export var map_id : int

@onready var spawn_location : Vector2 = $SpawnLocation.position

@export_file("*.tscn") var next_map : String = "empty"

var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	

func _process(delta: float) -> void:
	pass
