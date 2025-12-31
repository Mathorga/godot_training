extends TextureRect

class_name FrontSprite

## Scale sizes.
const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_STD: Vector2 = Vector2.ONE

## Time for scaling animation to complete.
const SCALE_TIME: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_image()
	run_animation()

func set_random_image() -> void:
	texture = ImageManager.get_random_item_image()

func get_random_spin_time() -> float:
	return randf_range(0.5, 1.5)

func get_random_rotation() -> float:
	return randf_range(-360.0 , 360.0)

func run_animation() -> void:
	var tween: Tween = create_tween()
	# tween.set_loops()

	# Scale down.
	tween.tween_property(self, "scale", SCALE_SMALL , SCALE_TIME)
	tween.tween_callback(set_random_image)

	# Then scale back up and rotate.
	tween.tween_property(self, "scale", SCALE_STD , SCALE_TIME)
	tween.tween_property(self, "rotation_degrees", get_random_rotation(), get_random_spin_time())

	# Every tween is garbage-collected after it's been used.
	tween.tween_callback(run_animation)
