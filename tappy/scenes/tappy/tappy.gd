extends CharacterBody2D

class_name Tappy

const JUMP_SPEED: float = 300.0

@export var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var engine_sound: AudioStreamPlayer = $EngineSound

var _jumped: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		_jumped = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if _jumped:
		velocity.y = -JUMP_SPEED
		animation_player.play("thrust")
		_jumped = false

	# Move 100 pixels/s to the right.
	#velocity.x = 100.0
	velocity.y += _gravity * delta
	move_and_slide()

	# Pitch engine sound according to its height in the screen.
	engine_sound.pitch_scale = remap(1 - (position.y / get_viewport_rect().end.y), 0.0, 1.0, 0.5, 1.5)

	if is_on_floor():
		die()

func die() -> void:
	# Broadcast an on_tappy_died signal from the SignalHub.
	SignalBus.emit_on_tappy_died_signal()
	get_tree().paused = true
