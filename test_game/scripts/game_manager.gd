extends Node

@onready var score_label: Label = $ScoreLabel

var score: int = 0

func add_point() -> void:
	score += 1
	score_label.text = "YOU COLLECTED " + str(score) + " COINS"
 
 
