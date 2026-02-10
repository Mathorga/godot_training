extends NinePatchRect

class_name LevelButton

@onready var level_label: Label = $LevelLabel

@export var level_number: int

func _enter_tree() -> void:
	gui_input.connect(_on_gui_input)

func _ready() -> void:
	level_label.text = "%02d" % level_number

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		GameManager.load_level_scene(level_number)
