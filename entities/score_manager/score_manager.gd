class_name ScoreManager
extends Node

@onready var saw_count_label = $SawCountLabel
@onready var high_score_label = $HighScoreLabel

var saw_count = 0

func _ready():
	Events.saw_blade_added.connect(update_saw_count)
	var highscore = Highscore.load_highscore()
	if highscore:
		high_score_label.text = "Highscore\n" + str(highscore)

func update_saw_count():
	saw_count += 1
	saw_count_label.text = "Blades\n" + str(saw_count)
	
func get_score() -> int:
	return saw_count
