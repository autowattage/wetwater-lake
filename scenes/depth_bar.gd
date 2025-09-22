extends TextureProgressBar

@onready var heidi = get_node("../../../heidi")
var top_clamp
var bottom_clamp
func _ready() -> void:
	top_clamp = heidi.position.y
	bottom_clamp = 1536

	
func _process(_delta: float) -> void:
	value = clamp(heidi.position.y/(bottom_clamp-top_clamp)-.2,0,1)
func _on_value_changed(value: float) -> void:
	$"heidi-lv".position.y = -5+value*271
