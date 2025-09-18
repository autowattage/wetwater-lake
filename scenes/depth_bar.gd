extends TextureProgressBar

@onready var heidi_lv: TextureRect = $"heidi-lv"

func _on_value_changed(value: float) -> void:
	heidi_lv.position.y = value*texture_under.get_height()
