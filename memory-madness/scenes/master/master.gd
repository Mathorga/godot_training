extends Control

@onready var music: AudioStreamPlayer = $Music
@onready var main: Control = $Main
@onready var game: Game = $Game

func _enter_tree() -> void:
	SignalHub.level_selected.connect(on_level_selected)
	SignalHub.game_exit_pressed.connect(on_exit_pressed)
	SignalHub.game_over.connect(on_game_over)

func _ready() -> void:
	on_exit_pressed() 

func show_game_screen(s: bool) -> void:
	game.visible = s
	main.visible = not s

func on_level_selected(_level_number: int) -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_IN_GAME)
	show_game_screen(true)

func on_exit_pressed() -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_MAIN_MENU)
	show_game_screen(false)

func on_game_over(_moves_count: int) -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_GAME_OVER)
