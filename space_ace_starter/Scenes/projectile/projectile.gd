extends Area2D

class_name Projectile

@export var damage: int = 10

@onready var on_screen_notifier: VisibleOnScreenNotifier2D = $OnScreenNotifier

func _enter_tree() -> void:
	area_entered.connect(_on_area_entered)

func _ready() -> void:
	on_screen_notifier.screen_exited.connect(_on_screen_exited)

func get_damage() -> int:
	return damage

func blow_up() -> void:
	set_process(false)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	blow_up()

func _on_screen_exited() -> void:
	queue_free()
