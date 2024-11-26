extends Control

signal unpause
signal continue_pressed
signal menu_pressed
signal quit_pressed


var menu_active : bool = false

func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if not menu_active:
		return
	if Input.is_action_just_pressed("pause"):
		menu_active = false
		unpause.emit.call_deferred()

func _on_continue_pressed() -> void:
	unpause.emit.call_deferred()


func _on_menu_pressed() -> void:
	menu_pressed.emit.call_deferred()


func _on_quit_pressed() -> void:
	quit_pressed.emit.call_deferred()
