extends Control

class_name Game

@onready var exit_button: TextureButton = $HBoxContainer/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	exit_button.pressed.connect(on_exit_pressed)

func on_exit_pressed() -> void:
	SignalHub.emit_game_exit_pressed()
