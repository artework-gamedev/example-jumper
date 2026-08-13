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
	
	generate_ground_layer_of_platforms()

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

func generate_ground_layer_of_platforms() -> void:
	const platform_width: int = 136 # Hardcoded value, taken from the width of the CollisionShape2D rectangle of the platform
	const platform_height: int = 63 # Hardcoded, taken from the height of the platform sprite
	var viewport_size: Vector2 = get_viewport_rect().size
	# Number of platforms needed to cover the ground
	var num_ground_layer_platforms: float = (viewport_size.x / platform_width) + 1
	# Cover the ground in the platforms
	for i in range(num_ground_layer_platforms):
		create_platform(Vector2(i * platform_width, viewport_size.y - platform_height))
