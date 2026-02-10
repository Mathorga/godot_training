extends Control

const LEVEL_BUTTON_SCENE: PackedScene = preload("uid://c4fjbfk0lpe7g")

@export var levels_count: int = 30

@onready var levels_grid: GridContainer = $MarginContainer/VBoxContainer/LevelsGrid

func _ready() -> void:
	setup_grid()

func setup_grid() -> void:
	for i in range(levels_count):
		var level_button: LevelButton = LEVEL_BUTTON_SCENE.instantiate()
		level_button.level_number = i + 1
		levels_grid.add_child(level_button)
