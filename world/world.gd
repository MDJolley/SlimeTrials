extends Node2D
class_name Map


@onready var spawn_location : Vector2 = $SpawnLocation.position

@export var map_id : int
@export_file("*.tscn") var next_map : String

var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.position = spawn_location

func _process(delta: float) -> void:
	pass
