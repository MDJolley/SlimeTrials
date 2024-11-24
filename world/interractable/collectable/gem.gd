extends CharacterBody2D
class_name Gem

@export var id : int
@export var follow_position : Vector2 = Vector2(0, -10) 
@export var speed : float = 200

@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var collectable : bool = true
var following_player : Player = null
var collected : bool = false
var starting_position : Vector2

func _ready() -> void:
	starting_position = position
	if PlayerData.check_if_gem_collected(self): 
		collected = true
		_on_already_collected()
	_on_player_died()

func _physics_process(delta: float) -> void:
	if following_player:
		_calculate_velocity()
		move_and_slide()

func _on_already_collected() -> void:
	sprite.set_self_modulate(Color(1, 1, 1, .1))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not collectable:
		return
	if body is not Player:
		pass
	else:
		following_player = body
		body.connect("safe_to_collect", _on_safe_to_connect)
		body.connect("drop_gems", _on_player_died)

func _on_safe_to_connect():
	if collectable == false:
		return
	following_player = null
	animation_player.play("collect")
	animation_player.speed_scale = 1.5
	PlayerData.collect_gem(self)

func _calculate_velocity():
	var target_position = following_player.position + follow_position
	if position.distance_to(target_position) > 10:
		var direction = (target_position - position).normalized()
		velocity = direction * speed
	if position.distance_to(target_position) > 150:
		var direction = (target_position - position).normalized()
		velocity = direction * speed * 1.5

func _on_player_died():
	collectable = false
	_reset()
	await get_tree().create_timer(.1).timeout
	collectable = true

func _reset():
	position = starting_position
	if following_player == null:
		return
	following_player.disconnect("safe_to_collect", _on_safe_to_connect)
	following_player = null
