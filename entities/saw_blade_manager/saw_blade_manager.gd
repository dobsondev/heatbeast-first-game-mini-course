extends Node

const SAW_BLADE_TELEGRAPH = preload("res://entities/saw_blade_telegraph/saw_blade_telegraph.tscn")

@onready var timer = $Timer
@onready var spawn_zone = $SpawnZone

func _ready():
	spawn_zone.hide()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)
	spawn_saw() # Spawn first saw immediately

func _on_timer_timeout():
	spawn_saw()
	
func spawn_saw():
	var saw_blade_telegraph = SAW_BLADE_TELEGRAPH.instantiate()
	var rect = spawn_zone.get_global_rect()
	var saw_x = randf_range(rect.position.x, rect.end.x)
	var saw_y = randf_range(rect.position.y, rect.end.y)
	saw_blade_telegraph.position = Vector2(saw_x, saw_y)
	get_tree().current_scene.get_node("SawBladeManager").add_child(saw_blade_telegraph)
