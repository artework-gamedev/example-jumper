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
	
	generate_level_platforms()

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

func generate_level_platforms() -> void:
	const platform_width: int = 134 + 2 # Hardcoded value, taken from the width of the CollisionShape2D rectangle of the platform
	const platform_height: int = 63 # Hardcoded, taken from the height of the platform sprite
	var viewport_size: Vector2 = get_viewport_rect().size
	
	# Generating the ground layer
	# Number of platforms needed to cover the ground
	var num_ground_layer_platforms: float = (viewport_size.x / platform_width) + 1
	var ground_layer_y: float = viewport_size.y - platform_height
	# Cover the ground in the platforms
	for i in range(num_ground_layer_platforms):
		create_platform(Vector2(i * platform_width, ground_layer_y))
	
	# Generate the climbing staircase of platforms
	const num_platforms: int = 50 # Number of platforms for this level
	const first_platform_height: int = 300 # First platform is this height above the ground layer
	const distance_between_platforms: int = 200 # Distance between each rung of ladder
	var platform_min_x: int = 0 # Leftmost position of a platform
	var platform_max_x: int = int(viewport_size.x - platform_width) # Rightmost position of a platform
	var next_platform_y = ground_layer_y - first_platform_height
	# Create each rung one at a time
	for i in range(num_platforms):
		var next_platform_x = randi_range(platform_min_x, platform_max_x)
		create_platform(Vector2(next_platform_x, next_platform_y))
		next_platform_y = next_platform_y - distance_between_platforms
