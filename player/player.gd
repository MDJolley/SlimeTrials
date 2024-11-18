class_name Player
extends CharacterBody2D

@onready var state_machine = $StateMachine
@onready var wall_detector: Node2D = $WallDetector
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const GRAVITY : float = 35

var has_dash : bool
var has_double_jump : bool
var touching_wall : bool = false
var respawn_location : Vector2
var gems : Array

@export var ground_acceleration : float = .4
@export var ground_move_speed : float = 500
@export var ground_friction : float = 0.4
@export var air_acceleration : float = .2
@export var air_move_speed : float = 550
@export var air_friction : float = 0.03
@export var minimum_move_speed : float = 0.01
@export var jump_strength : float = 1000
@export var double_jump_strength : float = 1000
@export var dash_speed : float = 1000
@export var dash_time : float = 0.1
@export var wall_slide_speed : float = 500
@export var wall_jump_strength : float = 1000

func _check_if_valid_wall() -> bool:
	for raycast in wall_detector.get_children():
		if raycast.is_colliding():
			return true
	return false
	
func _ready() -> void:
	state_machine.init(self)

func spawn(loc) -> void:
	position = loc
	animation_player.play("spawn")
	await animation_player.animation_finished
	state_machine.change_state($StateMachine/Idle)
	set_spawn_location(loc)
	velocity = Vector2(0,0)
	GameManager.start_time()
	move_and_slide()

func enable() -> void:
	print("wut")
	await get_tree().create_timer(2)
	visible = true
	set_collision_layer_value(1, true)

func disable() -> void:
	visible = false
	set_collision_layer_value(1, false)

func set_spawn_location(loc) -> void:
	respawn_location = loc

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func die() -> void:
	global_position = respawn_location

func touch_goal(goal : Area2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", goal.position, 1)
	#var final_position : Vector2 = goal.global_position
	#var anim : Animation = animation_player.get_animation("goal_portal")
	#var track_id : int = anim.find_track(^":global_position", Animation.TYPE_VALUE)
	#var key_id_start : int = anim.track_find_key(track_id, 0)
	#var key_id_end : int = anim.track_find_key(track_id, 1)
	#anim.track_set_key_value(track_id, key_id_start, global_position)
	#anim.track_set_key_value(track_id, key_id_end, final_position)
	animation_player.play("goal_portal")
	
	
	state_machine.change_state($StateMachine/GoalSucc)
	await animation_player.animation_finished
	GameManager.load_next_map()
	
