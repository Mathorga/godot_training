extends TextureButton

class_name MemoryTile

@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage

func _enter_tree() -> void:
	pressed.connect(on_pressed)

func _ready() -> void:
	pass

func setup(item: Texture2D, frame: Texture2D) -> void:
	frame_image.texture = frame
	item_image.texture = item

func on_pressed() -> void:
	pass
