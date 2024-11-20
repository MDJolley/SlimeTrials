extends Control

@onready var gem_count : Label = find_child("GemCount")
@onready var timer : Label = find_child("Timer")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	update_timer()

func collect_gem() -> void:
	var count = PlayerData.gem_collection.size()
	gem_count.set_text(str(count))

func update_timer() -> void:
	var formatted_time = str(GameManager.speedrun_time)
	var decimal_index = formatted_time.find(".")
	formatted_time = formatted_time.left(decimal_index + 3)
	timer.set_text(formatted_time)
