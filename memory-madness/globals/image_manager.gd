extends Node

const FRAME_IMAGES: Array[Texture2D] = [
	preload("uid://xku535x6lyse"),
	preload("uid://bd41objtmfeaq"),
	preload("uid://gi84o5w5wm0m"),
	preload("uid://c3w7yuxoy4p32")
]

var image_list: Array[Texture2D] = []

func _enter_tree() -> void:
	var ifl_resource: ImageFilesListResource = load("res://resources/image_files_list.tres")
	for file in ifl_resource.file_names:
		image_list.append(load(file))

func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()

func get_random_item_image() -> Texture2D:
	return image_list.pick_random()

func get_image_at(index: int) -> Texture2D:
	return image_list[index]

func shuffle_images() -> void:
	image_list.shuffle()
