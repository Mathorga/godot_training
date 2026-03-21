extends PathFollow2D
class_name EnemyBase

@export var points: int = 10
@export var crash_damage: int = 10

@onready var booms: Node2D = $Booms
@onready var health_bar: HealthBar = $HealthBar
@onready var hit_box: Area2D = $HitBox

var _speed: float = 50.0

func _ready() -> void:
	health_bar.died.connect(die)
	hit_box.area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	progress += _speed * delta

	if progress_ratio > 0.99:
		queue_free()

func make_booms() -> void:
	for boom in booms.get_children():
		SignalHub.request_create_explosion(boom.global_position, Explosion.BOOM)

func die() -> void:
	make_booms()
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is BulletBase:
		health_bar.update_value(-area.get_damage())
