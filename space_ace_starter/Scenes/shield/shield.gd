extends Area2D
class_name Shield

@export var initial_health: int = 5

@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _health: int = initial_health

func _enter_tree() -> void:
	area_entered.connect(_on_area_entered)

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

	disable()

func disable() -> void:
	timer.stop()
	SpaceUtils.toggle_area2d(self, false)
	hide()

func enable() -> void:
	timer.start()
	SpaceUtils.toggle_area2d(self, true)
	show()
	sound.play()
	_health = initial_health
	animation_player.play("RESET")

func hit() -> void:
	animation_player.play("hit")
	_health -= 1
	if _health <= 0:
		disable()

func _on_area_entered(_area: Area2D) -> void:
	hit()

func _on_timer_timeout() -> void:
	disable()
