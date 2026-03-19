extends TextureProgressBar
class_name HealthBar

const COLOR_LOW: Color = Color("#CC0000")
const COLOR_MID: Color = Color("#FF9900")
const COLOR_HIGH: Color = Color("#33CC33")

signal died

@export var level_low: int = 30
@export var level_mid: int = 65
@export var start_health: int = 100
@export var max_health: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	min_value = 0.0
	max_value = max_health
	value = start_health
	set_color()

func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_LOW
		return

	if value < level_mid:
		tint_progress = COLOR_MID
		return

	tint_progress = COLOR_HIGH

func update_value(val: int) -> void:
	value += val

	if value <= 0.0:
		died.emit()

	set_color()
