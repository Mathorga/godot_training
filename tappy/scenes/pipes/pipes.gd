extends Node2D

class_name Pipes

@onready var laser: Area2D = $Laser
@onready var score_sound: AudioStreamPlayer = $ScoreSound

# Horizontal speed in pixels/s.
const SPEED: float = 120.0

func _ready() -> void:
	SignalBus.on_tappy_died.connect(_on_tappy_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

func disconnect_laser() -> void:
	if laser.body_exited.is_connected(_on_laser_body_exited):
		laser.body_exited.disconnect(_on_laser_body_exited)

func _on_screen_notifier_screen_exited() -> void:
	queue_free()

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()

func _on_laser_body_exited(body: Node2D) -> void:
	if body is Tappy:
		disconnect_laser()
		SignalBus.emit_on_point_scored_signal()
		score_sound.play()

func _on_tappy_died() -> void:
	disconnect_laser()
