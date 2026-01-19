extends Node2D

class_name Shooter

@export var speed: float = 50.0
@export var shoot_delay: float = 0.5
@export var bullet_key: Constants.ObjectType = Constants.ObjectType.ENEMY_BULLET

@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound

var can_shoot: bool = true

func _ready() -> void:
	shoot_timer.timeout.connect(on_shoot_timer_timeout)

	shoot_timer.wait_time = shoot_delay

func shoot(direction: Vector2) -> void:
	if not can_shoot:
		return

	can_shoot = false
	SignalHub.emit_create_bullet_requested(global_position, direction, speed, bullet_key)
	shoot_timer.start()

func on_shoot_timer_timeout() -> void:
	can_shoot = true
