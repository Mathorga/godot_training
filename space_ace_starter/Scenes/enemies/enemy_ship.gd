extends EnemyBase
class_name EnemyShip

@export var shoot_at_player: bool = false
@export var aims_at_player: bool = false

@export var bullet_type: BulletBase.BulletType = BulletBase.BulletType.enemy
@export var bullet_speed: float = 120.0
@export var bullet_dir: Vector2 = Vector2.DOWN
@export var bullet_wait_time: float = 3.0
@export var bullet_wait_time_var: float = 0.5
@export var power_up_chance: float = 0.9

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var laser_timer: Timer = $LaserTimer

var _player_ref: Player

func _ready() -> void:
	super()
	laser_timer.timeout.connect(_on_laser_timer_timeout)

	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if _player_ref == null:
		queue_free()

	start_shoot_timer()

func start_shoot_timer() -> void:
	SpaceUtils.set_and_start_timer(laser_timer, bullet_wait_time, bullet_wait_time_var)

func die() -> void:
	super()

	if randf() < power_up_chance:
		SignalHub.request_create_rand_power_up(global_position)

func _on_laser_timer_timeout() -> void:
	if not shoot_at_player: return

	SignalHub.request_create_bullet(
		global_position,
		bullet_dir if not aims_at_player else global_position.direction_to(_player_ref.global_position),
		bullet_speed,
		bullet_type
	)
	start_shoot_timer()
