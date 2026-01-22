extends CharacterBody2D

class_name Player

const DAMAGE_SOUND = preload("uid://cb87hnh5qv2q4")
const JUMP_SOUND = preload("uid://c0esc5pejr7pa")

const GRAVITY: Vector2 = Vector2(0.0, 981.0)
const JUMP_SPEED: float = 350.0
const RUN_SPEED: float = 100.0
const MAX_FALL_SPEED: float = 500.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0.0, -130.0)

@export var fall_off_y: float = 1000.0 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hit_box: Area2D = $HitBox
@onready var hurt_timer: Timer = $HurtTimer

var _is_hurt: bool = false
var _invincible: bool = false

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

func _ready() -> void:
	hit_box.area_entered.connect(_on_hitbox_area_entered)
	hurt_timer.timeout.connect(_on_hurt_timer_timeout)

func _unhandled_input(event: InputEvent) -> void:
	# Continuous shooting.
	if event.is_action_pressed("shoot"):
		shooter.shoot(Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT)

func _physics_process(delta: float) -> void:
	# Apply gravity.
	# Here we're using delta because we're not setting the value of velocity directly,
	# rather we're increasing it by some amount that NEEDS to be scaled by delta: it's an acceleration.
	velocity += GRAVITY * delta

	apply_inputs()

	velocity.y = clampf(velocity.y, -JUMP_SPEED, MAX_FALL_SPEED)

	# Only apply movement after velocity has been updated.
	move_and_slide()

	update_debug_label()

	check_fall_off()

func play_sfx(sfx: AudioStream) -> void:
	sound.stop()
	sound.stream = sfx
	sound.play()

func apply_inputs() -> void:
	if _is_hurt:
		return

	# Move.
	velocity.x = Input.get_axis("left", "right") * RUN_SPEED;

	# Jump.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
		play_sfx(JUMP_SOUND)

	flip_sprite()

func flip_sprite() -> void:
	if is_zero_approx(velocity.x):
		return

	sprite_2d.flip_h = velocity.x < 0

func update_debug_label() -> void:
	var debug_string: String = ""
	debug_string += "floor: %s \n" % is_on_floor()
	debug_string += "v: %.1f | %.1f\n" % [velocity.x, velocity.y]
	debug_string += "p: %.1f | %.1f" % [global_position.x, global_position.y]

	debug_label.text = debug_string

func check_fall_off() -> void:
	if global_position.y > fall_off_y:
		queue_free()

func go_invincible() -> void:
	if _invincible:
		return

	_invincible = true

	var tween: Tween = create_tween()
	for i in range(20):
		tween.tween_property(sprite_2d, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.1)
		tween.tween_property(sprite_2d, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.1)
	tween.tween_property(self, "_invincible", false, 0.0)

func _apply_hurt_jump() -> void:
	_is_hurt = true
	play_sfx(DAMAGE_SOUND)
	hurt_timer.start()
	set_deferred("velocity", HURT_JUMP_VELOCITY)

func _apply_hit() -> void:
	if _invincible:
		return

	go_invincible()

	_apply_hurt_jump()

func _on_hitbox_area_entered(_area: Area2D) -> void:
	_apply_hit()

func _on_hurt_timer_timeout() -> void:
	_is_hurt = false
