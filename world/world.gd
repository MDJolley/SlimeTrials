extends Node2D
class_name Map


@onready var spawn_location = find_child("SpawnLocation").position

@export_file("*.tscn") var next_map : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
