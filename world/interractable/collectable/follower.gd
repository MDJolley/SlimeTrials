extends CharacterBody2D
class_name Follower

const FOLOW_DIST : float = 48

var idle_position : Vector2
var collectable : bool = true
var following_player : Player
var speed : float = 300
var follower_index : int
var follow_position : Vector2 = Vector2(0,0)

#TODO
signal consumed

func _ready() -> void:
	idle_position = position
	following_player = null

func _on_player_grabbed(body : Node2D) -> void:
	if !collectable:
		return
	if !body.is_in_group("player"):
		return
	if following_player == null:
		following_player = body
		for follower in following_player.followers:
			follower.connect("consumed", _move_up)

		following_player.followers.append(self)
		follower_index = following_player.followers.size()
		following_player.connect("drop_followers", _drop)
		print(follower_index)

func _move_up():
	print(follower_index)
	follower_index -= 1

func _drop():
	collectable = false
	_reset()
	await get_tree().create_timer(.1).timeout
	collectable = true

func _reset():
	position = idle_position
	if following_player == null:
		return
	else:
		following_player = null

func _physics_process(delta: float) -> void:
	if following_player != null:
		_calculate_velocity()
		move_and_slide()

func _calculate_velocity():
	follow_position.x = FOLOW_DIST * follower_index * -following_player.facing_direction
	follow_position.y = -20
	var target_position : Vector2 = following_player.global_position + follow_position
	if global_position.distance_to(target_position) < 10:
		velocity = Vector2(0,0)
	elif global_position.distance_to(target_position) < 32:
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed * .5
	elif global_position.distance_to(target_position) > 32:
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
	elif global_position.distance_to(target_position) > 150:
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed * 1.5
	
func _consume():
	following_player.followers.remove_at(follower_index - 1)
	consumed.emit()
