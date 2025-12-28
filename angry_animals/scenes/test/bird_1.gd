extends RigidBody2D

class_name Bird1
 
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	sleeping_state_changed.connect(_on_sleeping_state_changed)
	timer.timeout.connect(_on_timer_timeout)
	input_event.connect(_on_input_event)

func _process(delta: float) -> void:
	label.text = "FZ:%s CC:%d\nSL:%s" % [freeze, get_contact_count(), sleeping]

func _on_sleeping_state_changed() -> void:
	print("_on_sleeping_state_changed")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == 1:
			position = get_global_mouse_position()

func _on_timer_timeout() -> void:
	freeze = false
