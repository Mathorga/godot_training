extends Area2D

func _enter_tree() -> void:
	body_entered.connect(_on_body_entered)

func _ready() -> void:
	SignalHub.show_exit_requested.connect(_on_exit_show_requested)
	hide()

func _on_exit_show_requested() -> void:
	show()
	set_deferred("monitoring", true)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SignalHub.emit_exit_reached()
