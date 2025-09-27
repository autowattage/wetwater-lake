extends CanvasLayer

@onready var watertank_bar: TextureProgressBar = $"status-bars/watertank-bar"
@onready var depth_bar: TextureProgressBar = $"status-bars/depth-bar"
@onready var heidi = get_node("../heidi")

var top_pos_clamp
var bottom_pos_clamp

func _ready() -> void:
	top_pos_clamp = heidi.position.y
	bottom_pos_clamp = 2371-180
	Main.addcoin.connect(update_coins)

func _process(delta: float) -> void:
	depth_bar.value = heidi.position.y/(bottom_pos_clamp-top_pos_clamp)-.2
	if watertank_bar.value <= 0:
		get_tree().reload_current_scene()
	if WaterDetect.inwater:
		watertank_bar.value -= 0.025 * delta
	else:
		watertank_bar.value += 0.025 * delta

func _on_depthbar_value_changed(value: float) -> void:
	depth_bar.get_node("heidi-lv").position.y = -5+depth_bar.value*271

func _on_watertankbar_value_changed(value: float) -> void:
	watertank_bar.get_node("arrow").position.y = 268-watertank_bar.value*271

func update_coins(amnt):
	$"coin-counter/Label".text = str("%03d" % amnt)
