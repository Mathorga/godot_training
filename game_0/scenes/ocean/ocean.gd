extends Node2D


@onready var plane: Sprite2D = $Plane
#@onready var helicopter: Sprite2D = $Helicopter
#@onready var carrier: Sprite2D = $Carrier

const ROT_SPEED: float = PI
#var _target: Vector2 = Vector2.ZERO

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("set_target"):
		#_target = get_global_mouse_position()
		#plane.look_at(_target)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#plane.global_translate(Vector2(50.0, 30.0) * delta)
	#plane.look_at(carrier.global_position)
	#plane.position = plane.position.move_toward(_target, 350.0 * delta)

	# The X cpmponent of the transform is actually the whole position.
	#plane.position +=  plane.transform.x * 350.0 * delta
	if Input.is_action_pressed("ui_up"):
		plane.move_local_x(350.0 * delta)

	if Input.is_action_pressed("ui_right"):
		plane.rotate(ROT_SPEED * delta)
	elif Input.is_action_pressed("ui_left"):
		plane.rotate(-ROT_SPEED * delta)
