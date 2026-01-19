extends EnemyBase

@export var fly_velocity: Vector2 = Vector2(35.0, 15.0)

@onready var player_detector: RayCast2D = $PlayerDetector
@onready var flip_timer: Timer = $FlipTimer
@onready var shooter: Shooter = $Shooter

var fly_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	super._ready()

	flip_timer.timeout.connect(on_flip_timer_timeout)

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)

	velocity = fly_direction

	move_and_slide()

	shoot()

func fly_to_player() -> void:
	face_player()

	fly_direction = Vector2(fly_velocity.x if animated_sprite_2d.flip_h else -fly_velocity.x, fly_velocity.y)

func shoot() -> void:
	if player_detector.is_colliding():
		shooter.shoot(global_position.direction_to(player_ref.global_position))

func on_screen_entered() -> void:
	super.on_screen_entered()
	animated_sprite_2d.play("fly")
	fly_to_player()
	flip_timer.start()

func on_flip_timer_timeout() -> void:
	fly_to_player()
