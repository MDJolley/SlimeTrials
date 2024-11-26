@tool
extends Control

const HAT_V_RESOLUTION : int = 64
const HAT_BUTTON_PATH = preload("res://menus/hat_button.tscn")
const MAIN_MENU_PATH = "res://menus/main_menu.tscn"

var available_hats_count : int

func _ready() -> void:
	_update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		_update()

func _update(): 
	var hat : Sprite2D = $Hat
	available_hats_count = hat.texture.get_height() / HAT_V_RESOLUTION
	hat.vframes = available_hats_count
	if $MarginContainer/VBoxContainer/GridContainer.get_child_count() < available_hats_count:
		for frame in available_hats_count:
			var hat_button = HAT_BUTTON_PATH.instantiate()
			var preview : Sprite2D= hat_button.find_child("HatPreview")
			preview.frame = frame
			hat_button.connect("hat_selected", func(): _deselect_all(frame))
			$MarginContainer/VBoxContainer/GridContainer.add_child(hat_button)
			
	
func _deselect_all(exception : int):
	for button in $MarginContainer/VBoxContainer/GridContainer.get_children():
		if button.hat_id == exception:
			return
		button.deselect()


func _select_hat_and_leave() -> void:
	var hat_id : int = -1
	for button in $MarginContainer/VBoxContainer/GridContainer.get_children():
		if button.selected:
			hat_id = button.hat_id
	print("Hat_ID = ", hat_id)
	if hat_id != -1:
		PlayerData.set_hat(hat_id)
	_back_to_menu()

func _back_to_menu() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
