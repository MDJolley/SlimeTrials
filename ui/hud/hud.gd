extends Node2D

@onready var gem_count: Label = $GemContainer/GemCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func collect_gem() -> void:
	var count = PlayerData.gem_collection.size()
	gem_count.set_text(str(count))
	
