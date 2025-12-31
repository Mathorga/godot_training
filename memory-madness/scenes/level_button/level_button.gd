extends TextureButton

class_name LevelButton

@export var level_number: int = 0

@onready var label: Label = $Label

func _enter_tree() -> void:
	pressed.connect(on_pressed)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_label_text()

func set_label_text() -> void:
	var level_settings: LevelSettingResource = LevelDataSelector.get_level_setting(level_number)
	if level_settings == null:
		return

	label.text = "%dx%d" % [
		level_settings.get_cols(),
		level_settings.get_rows()
	]

func on_pressed() -> void:
	print("Pressed level button %d" % level_number)
