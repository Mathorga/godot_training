extends Projectile
class_name HomingMissile

const ROT_SPEED: float = 1.2
const MOV_SPEED: float = 100.0
const POINTS: int = 5

var _player_ref: Player

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if _player_ref == null:
		queue_free()

func _process(delta: float) -> void:
	var dir_to_player: Vector2 = global_position.direction_to(_player_ref.global_position)
	var angle_to_player: float = (-transform.y).angle_to(dir_to_player)
	rotate(sign(angle_to_player) * min(abs(angle_to_player), ROT_SPEED * delta))
	position += (-transform.y) * MOV_SPEED * delta

func blow_up() -> void:
	ScoreManager.increment_score(POINTS)
	SignalHub.emit_create_explosion_requested(global_position, Explosion.EXPLODE)
	super()
