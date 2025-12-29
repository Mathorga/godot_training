extends TextureButton

class_name LevelButton

@export var level_number: String = ""

@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	pressed.connect(on_pressed)

	level_label.text = level_number
	var level_score: int = ScoreProvider.get_level_score(level_number)
	if level_score == -1:
		score_label.text = "-"
	else:
		score_label.text = "%d" % level_score

func on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)

func on_mouse_exited() -> void:
	scale = Vector2.ONE

func on_pressed() -> void:
	ScoreProvider.selected_level = level_number
	get_tree().change_scene_to_file("res://scenes/level_base/level_%s.tscn" % level_number)
