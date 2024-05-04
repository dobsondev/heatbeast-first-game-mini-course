extends CharacterBody2D

const SPEED = 100

@onready var hurtbox: Area2D = $Hurtbox

func _ready():
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func _physics_process(_delta):
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_vector * SPEED
	move_and_slide()

func _on_hurtbox_body_entered(_body: Node2D):
	Events.balloon_popped.emit()
	queue_free()
