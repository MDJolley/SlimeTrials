extends Area2D
class_name Gem

@export var id : int
@onready var sprite: Sprite2D = $Sprite

var collected : bool = false

func _ready() -> void:
	if PlayerData.check_if_gem_collected(self): 
		collected = true
		_on_already_collected()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		pass
	else:
		PlayerData.collect_gem(self)

func _on_already_collected() -> void:
	sprite.set_self_modulate(Color(1, 1, 1, .1))
