extends EnemyBase

class_name FrogEnemy

const JUMP_VELOCITY: Vector2 = Vector2(100.0, -300.0)

@onready var jump_timer: Timer = $JumpTimer

var seen_player: bool = false
var can_jump: bool = false

func _ready() -> void:
	super._ready()

	jump_timer.timeout.connect(on_jump_timer_timeout)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	velocity += gravity * delta

	try_jump()

	move_and_slide()

	if is_on_floor():
		velocity.x = 0.0
		animated_sprite_2d.play("idle")

	face_player()

func try_jump() -> void:
	if not seen_player:
		return

	if not is_on_floor():
		return

	if not can_jump:
		return

	velocity = Vector2(JUMP_VELOCITY.x if animated_sprite_2d.flip_h else -JUMP_VELOCITY.x, JUMP_VELOCITY.y)
	can_jump = false
	start_timer() 
	animated_sprite_2d.play("jump")

func start_timer() -> void:
	jump_timer.start(randi_range(2, 4))

func on_jump_timer_timeout() -> void:
	can_jump = true

func on_screen_entered() -> void:
	if seen_player:
		return

	seen_player = true
	start_timer()
