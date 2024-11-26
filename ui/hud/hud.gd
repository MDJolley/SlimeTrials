extends Control
class_name Hud

@onready var gem_count : Label = find_child("GemCount")
@onready var timer : Label = find_child("Timer")
@onready var record_notifier : Label = find_child("RecordDisplay")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var deaths_count : Label = find_child("Deaths")

func _ready() -> void:
	PlayerData.connect("player_death", update_deaths)
	update_gems()
	update_deaths()
	pass

func _process(delta: float) -> void:
	update_timer()

func update_deaths():
	deaths_count.text = str(PlayerData.death_count)

func update_gems() -> void:
	var count = PlayerData.gem_collection.size()
	gem_count.set_text(str(count))

func update_timer() -> void:
	var formatted_time = str(GameManager.speedrun_time)
	var decimal_index = formatted_time.find(".")
	formatted_time = formatted_time.left(decimal_index + 3)
	timer.set_text(formatted_time)

func show_speedrun_record(time : float, new : bool) -> void:
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	formatted_time = formatted_time.left(decimal_index + 3)
	if new:
		record_notifier.text = str("NEW RECORD!   ", formatted_time)
	else:
		record_notifier.text = str("Too slow...  Best time: ", formatted_time)
	animation_player.play("new_record")
