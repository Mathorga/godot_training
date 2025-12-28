extends Node

class_name Game

const PIPES: Resource = preload("uid://dms402y81minq")

@onready var pipes_holder: Node = $PipesHolder
@onready var upper_spawn: Marker2D = $UpperSpawn
@onready var lower_spawn: Marker2D = $LowerSpawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_pipes()

func _spawn_pipes() -> void:
	var pipes: Pipes = PIPES.instantiate()
	pipes.position.x = upper_spawn.position.x
	pipes.position.y = randf_range(
		upper_spawn.position.y,
		lower_spawn.position.y
	 )
	pipes_holder.add_child(pipes)

func _on_spawn_timer_timeout() -> void:
	_spawn_pipes()
