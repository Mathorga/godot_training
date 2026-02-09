extends Control

const LEVEL_BUTTON_SCENE: PackedScene = preload("uid://c4fjbfk0lpe7g")

@onready var levels_grid: GridContainer = $MarginContainer/VBoxContainer/LevelsGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(30):
		var level_button: NinePatchRect = LEVEL_BUTTON_SCENE.instantiate()
		# TODO Set button number.
		levels_grid.add_child(level_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
