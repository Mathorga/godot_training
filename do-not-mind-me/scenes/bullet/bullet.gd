extends Area2D
class_name Bullet

const SPEED: float = 250.0

@onready var on_screen_notifier_2d: VisibleOnScreenNotifier2D = $OnScreenNotifier2D
@onready var laser_sound: AudioStreamPlayer2D = $LaserSound

var _dir: Vector2 = Vector2.ZERO

func _enter_tree() -> void:
	body_entered.connect(_on_body_entered)

func _ready() -> void:
	on_screen_notifier_2d.screen_exited.connect(_on_screen_exited)

	var player: Player = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	print("PLAYER: ", player)
	if player == null: queue_free()

	if player != null: laser_sound.play()

	_dir = global_position.direction_to(player.global_position)
	look_at(player.global_position)
 
func _process(delta: float) -> void:
	global_position += _dir * SPEED * delta

func _on_body_entered(_body: Node2D) -> void:
	print("BULLET_HIT")
	queue_free()

func _on_screen_exited() -> void:
	queue_free()
