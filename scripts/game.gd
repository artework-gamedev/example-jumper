extends Node2D

# Camera globals
var camera_scene: Resource = preload("res://scenes/game_camera.tscn")
var camera: Camera2D = null


func _ready() -> void:
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)


func _process(_delta: float) -> void:
	# Process debug commands to quit and reset game
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
