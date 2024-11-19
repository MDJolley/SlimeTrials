extends AnimatableBody2D

@export var fall_delay : float = 0.5
@export var fall_lifetime : float = 1
@export var fall_speed : float = 200
@export var respawn_time : float = 2

@onready var sprite: Sprite2D = $Sprite
@onready var activation_area: CollisionShape2D = $TriggerArea/CollisionShape
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	#move_and_slide()
	pass


func _on_trigger_area_body_entered(body: Node2D) -> void:
	activation_area.set_disabled(true)
	await fall()

func fall() -> void:
	sprite.frame += 1
	await get_tree().create_timer(fall_delay).timeout
	sprite.frame += 1
	animation_player.play("fall")
	#velocity.y = fall_speed
	#await get_tree().create_timer(fall_lifetime).timeout
	#queue_respawn()

func queue_respawn() -> void:
	get_parent().spawn_new_platform(respawn_time)
	queue_free()
