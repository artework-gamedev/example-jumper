extends Node2D

# Camera globals
var camera_scene: Resource = preload("res://scenes/game_camera.tscn")
var camera: Camera2D = null

# Platform generation globals
@onready var platform_parent = $PlatformParent
var platform_scene: Resource = preload("res://scenes/Platform.tscn")

func _ready() -> void:
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)
	
	create_platform(Vector2(100, 300))

func _process(_delta: float) -> void:
	# Process debug commands to quit and reset game
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func create_platform(location: Vector2) -> Node2D:
	var platform: Node2D = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform
