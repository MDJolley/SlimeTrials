extends Button

var selected : bool
const HAT_RES_Y : int = 64

var hat_id : int = 0 :
	get:
		return hat_preview.frame

@onready var hat_preview: Sprite2D = $HatPreview

signal hat_selected

func _ready() -> void:
	hat_preview.vframes = hat_preview.texture.get_height() / HAT_RES_Y

func deselect():
	selected = false
	self_modulate = Color.WHITE

func _on_pressed() -> void:
	selected = true
	hat_selected.emit()
	self_modulate = Color.CADET_BLUE
