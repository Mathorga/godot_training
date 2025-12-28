extends RigidBody2D

class_name Bird

enum BirdState {
	Ready,
	Drag,
	Release
}

const DRAG_LIM_MIN: Vector2 = Vector2(-60.0, 0.0)
const DRAG_LIM_MAX: Vector2 = Vector2(0.0, 60.0)
const IMPULSE_MULT: float = 20.0
const IMPULSE_MAX: float = 1200.0

@onready var label: Label = $Label
@onready var arrow_sprite: Sprite2D = $ArrowSprite
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var state: BirdState = BirdState.Ready
var start_position: Vector2 = Vector2.ZERO
var drag_start_position: Vector2 = Vector2.ZERO
var drag_vector: Vector2 = Vector2.ZERO
var arrow_scale_x: float = 0.0

#region builtin

func _unhandled_input(event: InputEvent) -> void:
	match state:
		BirdState.Drag:
			if event.is_action_released("drag"):
				call_deferred("change_state", BirdState.Release)
		_:
			pass

func _ready() -> void:
	# Connect to events.
	input_event.connect(_on_input_event)
	sleeping_state_changed.connect(_on_sleeping_state_changed)
	body_entered.connect(_on_body_entered)
	visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exited)

	setup()

func _physics_process(_delta: float) -> void:
	update_state()
	update_debug_label()

#endregion

#region misc

func setup() -> void:
	arrow_scale_x = arrow_sprite.scale.x
	arrow_sprite.hide()
	start_position = position

func update_debug_label() -> void:
	var debug_string: String = "ST:%s SL%s FR:%s\n" % [BirdState.keys()[state], sleeping, freeze]
	debug_string += "drag_start_position: %.1f, %.1f\n" % [drag_start_position.x, drag_start_position.y]
	debug_string += "drag_vector: %.1f, %.1f\n" % [drag_vector.x, drag_vector.y]

	label.text = debug_string

func update_state() -> void:
	match state:
		BirdState.Drag:
			handle_dragging()

func change_state(new_state: BirdState) -> void:
	if state == new_state:
		return

	state = new_state

	match state:
		BirdState.Drag:
			start_dragging()
		BirdState.Release:
			start_release()

func update_arrow_scale() -> void:
	var impulse_length: float = compute_impulse().length()
	var weight: float = clamp(impulse_length / IMPULSE_MAX, 0.0, 1.0)
	arrow_sprite.scale.x = lerp(1.0, 2.0, weight) * arrow_scale_x
	arrow_sprite.rotation = (start_position - position).angle()

func compute_impulse() -> Vector2:
	return drag_vector * -IMPULSE_MULT

func start_dragging() -> void:
	arrow_sprite.show()
	drag_start_position = get_global_mouse_position()

func start_release() -> void:
	arrow_sprite.hide()
	launch_sound.play()
	freeze = false
	SignalHub.emit_attempt_made()
	apply_central_impulse(compute_impulse())

func handle_dragging() -> void:
	var drag_delta: Vector2 = get_global_mouse_position() - drag_start_position
	drag_delta = drag_delta.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)
	
	var diff: Vector2 = drag_delta - drag_vector

	if diff.length() > 0.0 and not stretch_sound.playing:
		stretch_sound.play()

	drag_vector = drag_delta

	position = start_position + drag_vector

	update_arrow_scale()

func die() -> void:
	SignalHub.emit_bird_died()
	queue_free()

#endregion

#region signals

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void: 
	if event.is_action_pressed("drag") and state == BirdState.Ready:
		change_state(BirdState.Drag)

func _on_sleeping_state_changed() -> void:
	if sleeping:
		for body in get_colliding_bodies():
			if body is Cup:
				body.vanish()
				break
		call_deferred("die")

func _on_body_entered(body: Node) -> void:
	if body is Cup and not kick_sound.playing:
		kick_sound.play()

func _on_screen_exited() -> void:
	die()

#endregion
