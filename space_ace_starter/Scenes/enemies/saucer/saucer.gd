extends EnemyBase
class_name Saucer

@onready var shoot_timer: Timer = $ShootTimer
@onready var animation_tree: AnimationTree = $AnimationTree

var _is_shooting: bool = false
var _is_dead: bool = false

func _ready() -> void:
	super()
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	animation_tree.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	if !_is_shooting:
		super(delta)
		return

func set_shooting(shooting: bool) -> void:
	_is_shooting = shooting

func fire_missile() -> void:
	SignalHub.request_create_homing_missile(global_position)

func _on_shoot_timer_timeout() -> void:
	set_shooting(true)

func _on_health_bar_died() -> void:
	_is_dead = true
	shoot_timer.stop()
	set_process(false)
	SpaceUtils.toggle_area2d(hit_box, false)
	ScoreManager.increment_score(points)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		die()
