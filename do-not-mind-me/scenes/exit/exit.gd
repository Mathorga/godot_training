extends Area2D

func _ready() -> void:
	SignalHub.show_exit_requested.connect(_on_exit_show_requested)
	hide()

func _on_exit_show_requested() -> void:
	show()
	set_deferred("monitoring", true)
