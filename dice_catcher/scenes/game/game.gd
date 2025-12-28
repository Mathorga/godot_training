extends Node2D

const DICE: Resource = preload("uid://c6wsbyjga68up")
const GAME_OVER = preload("uid://c0orcx0ncovyq")
const MARGIN: float = 80.0
const STOPPABLE_GROUP_NAME: String = "stoppable"

@onready var dice_spawn_timer: Timer = $DiceSpawnTimer
@onready var score_label: Label = $ScoreLabel
@onready var soundtrack: AudioStreamPlayer = $Soundtrack

var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score_label()
	spawn_dice()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func spawn_dice() -> void:
	var vpr: Rect2 = get_viewport_rect()
	var new_dice: Dice =  DICE.instantiate()
	new_dice.position = Vector2(randf_range(
		vpr.position.x + MARGIN,
		vpr.end.x - MARGIN
	), -MARGIN)
	add_child(new_dice)
	new_dice.game_over.connect(_on_dice_game_over)

func pause_all_dice() -> void:
	dice_spawn_timer.stop()
	var to_stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE_GROUP_NAME)
	for node in to_stop:
		node.set_physics_process(false)

func update_score_label() -> void:
	score_label.text = "%04d" % _score

func _on_dice_game_over() -> void:
	soundtrack.stop()
	soundtrack.stream = GAME_OVER
	soundtrack.play()
	pause_all_dice()

func _on_dice_spawn_timer_timeout() -> void:
	spawn_dice()

func _on_fox_point_scored() -> void:
	_score += 1
	update_score_label()
