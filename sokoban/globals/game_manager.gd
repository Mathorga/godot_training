extends Node

const MAIN_SCENE: PackedScene = preload("uid://dt12mjj45tb81")
const LEVEL_SCENE: PackedScene = preload("uid://3erogswmru6e")

var current_level: int = -1

func load_main_scene() -> void:
	current_level = -1

	get_tree().change_scene_to_packed(MAIN_SCENE)

func load_level_scene(level_number: int) -> void:
	if level_number > 0:
		current_level = level_number

	if current_level > 0:
		get_tree().change_scene_to_packed(LEVEL_SCENE)
