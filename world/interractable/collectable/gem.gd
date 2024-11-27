extends Follower
class_name Gem

@export var id : int

@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var collected : bool = false
var starting_position : Vector2

func _ready() -> void:
	super._ready()
	if PlayerData.check_if_gem_collected(self): 
		collected = true
		_on_already_collected()

func _on_already_collected() -> void:
	sprite.texture = load("res://assets/sprite_sheets/Gem_Collected.png")
	sprite.self_modulate.a = .75	

func _on_safe_to_collect():
	if collectable == false:
		return
	if following_player:
		_consume()
	following_player = null
	animation_player.play("collect")
	animation_player.speed_scale = 1.5
	PlayerData.collect_gem(self)

func _on_player_grabbed(body: Node2D) -> void:
	super._on_player_grabbed(body)
	if body.is_in_group("player"):
		body.connect("safe_to_collect", _on_safe_to_collect)
