class_name Player
extends CharacterBody2D

@onready var state_machine = $StateMachine
@onready var wall_detector: Node2D = $WallDetector
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurtbox: Area2D = $Hurtbox
@onready var collision_shape: CollisionPolygon2D = $CollisionShape
@onready var safety_check: Timer = $SafetyCheck
@onready var hat: Sprite2D = $Hat
@onready var die_sfx: AudioStreamPlayer2D = $SFX/Die

#const GRAVITY : float = 35
const GRAVITY : float = 30
const RESPAWN_DELAY : float = 1

signal pause_game
signal reset
signal drop_followers
signal touched_goal
signal spawning
signal safe_to_collect
signal level_complete
signal dead
signal movement_interrupted

@export var default_ground_acceleration : float = .4
@export var ground_move_speed : float = 500
@export var default_ground_friction : float = 0.4
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

var cyote : bool = false :
	set(param):
		cyote = param
		await get_tree().create_timer(.1).timeout
		cyote = false
var has_dash : bool :
	get():
		return has_dash
	set(dash):
		if !dash:
			$DashParticles.emitDash()
		has_dash = dash
var has_double_jump : bool
var touching_wall : bool = false
var respawn_location : Vector2
var gems : Array
var inputs_locked : bool = false
var max_fall_speed : float =  600
var can_interract : bool = false
var facing_direction : int = 1
var followers : Array = []
var ice_blocks : int = 0
var on_ice : bool = false :
	set(value):
		if value == true:
			ground_friction = default_ground_friction / 50
			ground_acceleration = default_ground_acceleration / 10
		else:
			ground_friction = default_ground_friction
			ground_acceleration = default_ground_acceleration
var ground_friction : float = default_ground_friction
var ground_acceleration : float = default_ground_acceleration



func edit_ice_blocks(value : int) :
	ice_blocks = ice_blocks + value
	print(ice_blocks, " <- ice blocks")
	on_ice = true if ice_blocks > 0 else false

func _check_if_valid_wall() -> bool:
	for raycast in wall_detector.get_children():
		if raycast.is_colliding():
			return true
	return false

func _ready() -> void:
	hat.frame = PlayerData.hat
	PlayerData.connect("player_hat_changed", func(): hat.frame = PlayerData.hat)
	state_machine.init(self)

func spawn(loc) -> void:
	has_dash = true
	has_double_jump = true
	position = loc
	velocity = Vector2(0,0)
	#await get_tree().create_timer(1).timeout
	show_sprite()
	animation_player.play("spawn")
	state_machine.change_state($StateMachine/Idle)
	enable_collision()
	spawning.emit.call_deferred()
	await animation_player.animation_finished
	can_interract = true
	set_spawn_location(loc)

func enable_collision() -> void:
	set_collision_layer_value(1, true)
	hurtbox.enable_collision()
	collision_shape.disabled = false
	collision_shape.set_deferred("disabled", false)

func disable_collision() -> void:
	set_collision_layer_value(1, false)
	hurtbox.disable_collision()
	collision_shape.disabled = true
	collision_shape.set_deferred("disabled", true)

func set_spawn_location(loc) -> void:
	respawn_location = loc

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game.emit.call_deferred()
	if Input.is_action_just_pressed("restart"):
		if ! state_machine.current_state == $StateMachine/GoalSucc :
			_restart_level()
	if inputs_locked:
		return
	if event.is_action_pressed("move_left"):
		facing_direction = -1
	elif event.is_action_pressed("move_right"):
		facing_direction = 1
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func die() -> void:
	animation_player.play("death_ragdoll")
	die_sfx.play()
	can_interract = false
	PlayerData.player_died()
	drop_followers.emit()
	disable_collision()
	$DeathParticles.emitting = true
	hide_sprite()
	state_machine.change_state($StateMachine/Stop)
	followers = []
	await get_tree().create_timer(RESPAWN_DELAY).timeout
	dead.emit()


	spawn(respawn_location)

func touch_goal(goal : Area2D) -> void:
	can_interract = false
	emit_signal("safe_to_collect")
	emit_signal("touched_goal")
	GameManager.stop_clock()
	disable_collision()
	state_machine.change_state($StateMachine/GoalSucc)
	
	#Speedrun Timer
	
	
	#Animations
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", goal.position, 1)
	animation_player.play("goal_portal")
	await animation_player.animation_finished
	tween.stop()
	position = Vector2(0,0)
	emit_signal("level_complete")
	followers = []

func show_sprite() -> void:
	$Sprite.visible = true

func hide_sprite() -> void:
	$Sprite.visible = false

func _on_safety_check_timeout() -> void:
	emit_signal("safe_to_collect")

func lock_inputs(time : float) -> void:
	inputs_locked = true
	await get_tree().create_timer(time).timeout
	inputs_locked = false

func return_dash() -> void:
	has_dash = true

func play_sound(name : String):
	var sound_player : AudioStreamPlayer2D = find_child(name)
	if sound_player != null:
		sound_player.play()
	

func _restart_level() -> void:
	reset.emit()
	drop_followers.emit()
