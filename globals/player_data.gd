extends Node


var speedrun_records : Dictionary = {}
var death_count : int = 0
var gem_collection : Array
var save_path : String = "user://player_data.save"
var hat : int = 0

signal player_death
signal player_hat_changed

func collect_gem(gem : Gem) -> void:
	if !check_if_gem_collected(gem):
		gem_collection.append(gem.id)
		GameManager.collect_gem()

func _ready() -> void:
	load_player_data()
	pass

func check_if_gem_collected(gem : Gem ) -> bool:
	return true if gem_collection.has(gem.id) else false

func save() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(speedrun_records)
	file.store_var(death_count)
	file.store_var(gem_collection)
	file.store_var(hat)


func load_player_data() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		speedrun_records = file.get_var()
		death_count = file.get_var()
		gem_collection = file.get_var()
		hat = file.get_var()

func purge_player_data() -> void:
	if FileAccess.file_exists(save_path):
		speedrun_records = {}
		gem_collection = []
		death_count = 0
		save()

	else:
		print("No save data located.")
		gem_collection = []
		speedrun_records = {}
		death_count = 0

func player_died():
	death_count += 1
	player_death.emit()

func set_hat(hat_id : int):
	player_hat_changed.emit()
	hat = hat_id
	save()
