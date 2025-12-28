extends TextureButton

class_name LevelButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)

func on_mouse_exited() -> void:
	scale = Vector2.ONE
