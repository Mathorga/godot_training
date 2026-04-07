extends Node

const MAIN_SCENE: PackedScene = preload("uid://0a0lwwpw0a5e")
const LEVEL_SCENE: PackedScene = preload("uid://dtlahjfup0gwl")

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN_SCENE)

func load_level_scene() -> void:
	get_tree().change_scene_to_packed(LEVEL_SCENE)
