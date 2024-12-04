extends Control



func _on_cancel_button_down() -> void:
	queue_free()


func _on_reset_button_down() -> void:
	PlayerData.purge_player_data()
	queue_free()
