extends Area2D
class_name Player

const GROUP_NAME: String = "Player"
const HEALTH_BOOST: int = 25
const BULLET_SPEED: float = 250.0
const MOVEMENT_PADDING: Vector2 = Vector2.ONE * 16.0

@export var speed: float = 250.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	var move_vec: Vector2 = Input.get_vector("left", "right", "up", "down")
	_set_animation(move_vec)

	if Input.is_action_just_pressed("shoot"):
		SignalHub.request_create_bullet(global_position, Vector2.UP, BULLET_SPEED, BulletBase.BulletType.player)

	global_position += move_vec * speed * delta
	global_position = global_position.clamp(MOVEMENT_PADDING, get_viewport_rect().end - MOVEMENT_PADDING)

func _set_animation(move_vec: Vector2) -> void:
	if is_zero_approx(move_vec.x):
		animation_player.play("fly")
		return

	animation_player.play("turn")
	sprite_2d.flip_h = move_vec.x > 0

func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area.get_power_up_type():
			PowerUp.PowerUpType.shield:
				shield.enable()
			PowerUp.PowerUpType.health:
				SignalHub.emit_player_health_restored(HEALTH_BOOST)
		return

	if area is Projectile:
		SignalHub.emit_player_hit(area.get_damage())
