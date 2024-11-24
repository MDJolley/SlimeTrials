extends Node2D
class_name Map


@onready var spawn_location : Vector2 = $SpawnLocation.position


@export var map_id : int
@export_file("*.tscn") var next_map : String

var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	

func _process(delta: float) -> void:
	pass
