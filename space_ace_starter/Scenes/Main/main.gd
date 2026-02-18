extends Control

class_name Main

@onready var play_button: UIButton = $MC/VB/PlayButton
@onready var quit_button: UIButton = $MC/VB/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_play_button_pressed() -> void:
	GameManager.load_level_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
