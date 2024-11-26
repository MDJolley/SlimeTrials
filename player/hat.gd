extends Sprite2D

const HAT_RES_Y : int = 64

func _ready() -> void:
	self.vframes = self.texture.get_height() / HAT_RES_Y
