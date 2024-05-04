extends Node2D

const SAW_BLADE = preload("res://entities/saw_blade/saw_blade.tscn")

@onready var arrow_sprite = $ArrowSprite2D
@onready var timer = $Timer

var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))

func _ready():
	Events.balloon_popped.connect(timer.stop)
	timer.timeout.connect(_on_timer_timeout)
	arrow_sprite.rotation = direction.angle()

func _on_timer_timeout():
	var saw_blade = SAW_BLADE.instantiate()
	saw_blade.position = position
	saw_blade.linear_velocity = direction * 50
	get_tree().current_scene.get_node("SawBladeManager").add_child(saw_blade)
	Events.saw_blade_added.emit()
	queue_free()
