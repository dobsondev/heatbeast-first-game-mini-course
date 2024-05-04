extends Node

@onready var label = $Label
@onready var high_score_label = $HighScoreLabel

var game_over: bool = false

func _ready():
	Events.balloon_popped.connect(trigger_game_over)
	label.hide()
	high_score_label.hide()

func trigger_game_over():
	var highscore = Highscore.load_highscore()
	var current_score = get_tree().current_scene.get_node("ScoreManager").get_score()
	if highscore == null || current_score > highscore:
		Highscore.save_highscore(current_score)
		high_score_label.text = "New Highscore " + str(current_score)
		high_score_label.show()
		
	label.show()
	Engine.time_scale = 0.5
	game_over = true

func _physics_process(_delta):
	if game_over && Input.is_action_just_pressed("ui_accept"):
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
